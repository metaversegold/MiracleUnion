using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;

namespace ET
{
    [ObjectSystem]
    public class SessionAwakeSystem: AwakeSystem<Session, AService>
    {
        public override void Awake(Session self, AService aService)
        {
            self.Awake(aService);
        }
    }

    public sealed class Session: Entity, IAwake<AService>
    {

        /// <summary>
        /// 保存接收到的数据包
        /// </summary>
        private byte[] PacketBytes = null;

        /// <summary>
        /// 接收到的数据包的命令ID
        /// </summary>
        private ushort _PacketCmdID = 0;

        /// <summary>
        /// 数据包的命令ID属性
        /// </summary>
        public ushort PacketCmdID
        {
            get { return _PacketCmdID; }
            set { _PacketCmdID = value; }
        }

        /// <summary>
        /// 发送的数据包的命令数据长度
        /// </summary>
        private Int32 _PacketDataSize = 0;
        
        private readonly struct RpcInfo
        {
            public readonly IRequest Request;
            public readonly ETTask<IResponse> Tcs;

            public RpcInfo(IRequest request)
            {
                this.Request = request;
                this.Tcs = ETTask<IResponse>.Create(true);
            }
        }

        public AService AService;
        
        private static int RpcId
        {
            get;
            set;
        }

        private readonly Dictionary<int, RpcInfo> requestCallbacks = new Dictionary<int, RpcInfo>();
        
        public long LastRecvTime
        {
            get;
            set;
        }

        public long LastSendTime
        {
            get;
            set;
        }

        public int Error
        {
            get;
            set;
        }

        public void Awake(AService aService)
        {
            this.AService = aService;
            long timeNow = TimeHelper.ClientNow();
            this.LastRecvTime = timeNow;
            this.LastSendTime = timeNow;

            this.requestCallbacks.Clear();
            
            //Log.Info($"session create: zone: {this.DomainZone()} id: {this.Id} {timeNow} ");
        }

        public override void Dispose()
        {
            if (this.IsDisposed)
            {
                return;
            }

            int zone = this.DomainZone();
            long id = this.Id;

            base.Dispose();

            this.AService.RemoveChannel(this.Id);
            
            foreach (RpcInfo responseCallback in this.requestCallbacks.Values.ToArray())
            {
                responseCallback.Tcs.SetException(new RpcException(this.Error, $"session dispose: {id} {this.RemoteAddress}"));
            }

            //Log.Info($"session dispose: {this.RemoteAddress} zone: {zone} id: {id} ErrorCode: {this.Error}, please see ErrorCode.cs! {TimeHelper.ClientNow()}");

            this.requestCallbacks.Clear();
        }

        public IPEndPoint RemoteAddress
        {
            get;
            set;
        }

        public void OnRead(ushort opcode, IResponse response)
        {
            OpcodeHelper.LogMsg(this.DomainZone(), opcode, response);
            
            if (!this.requestCallbacks.TryGetValue(response.RpcId, out var action))
            {
                return;
            }

            this.requestCallbacks.Remove(response.RpcId);
            if (ErrorCore.IsRpcNeedThrowException(response.Error))
            {
                action.Tcs.SetException(new Exception($"Rpc error, request: {action.Request} response: {response}"));
                return;
            }
            action.Tcs.SetResult(response);
        }
        
        public async ETTask<IResponse> Call(IRequest request, ETCancellationToken cancellationToken)
        {
            int rpcId = ++RpcId;
            RpcInfo rpcInfo = new RpcInfo(request);
            this.requestCallbacks[rpcId] = rpcInfo;
            request.RpcId = rpcId;

            this.Send(request);
            
            void CancelAction()
            {
                if (!this.requestCallbacks.TryGetValue(rpcId, out RpcInfo action))
                {
                    return;
                }

                this.requestCallbacks.Remove(rpcId);
                Type responseType = OpcodeTypeComponent.Instance.GetResponseType(action.Request.GetType());
                IResponse response = (IResponse) Activator.CreateInstance(responseType);
                response.Error = ErrorCore.ERR_Cancel;
                action.Tcs.SetResult(response);
            }

            IResponse ret;
            try
            {
                cancellationToken?.Add(CancelAction);
                ret = await rpcInfo.Tcs;
            }
            finally
            {
                cancellationToken?.Remove(CancelAction);
            }
            return ret;
        }

        public async ETTask<IResponse> Call(IRequest request)
        {
            int rpcId = ++RpcId;
            RpcInfo rpcInfo = new RpcInfo(request);
            this.requestCallbacks[rpcId] = rpcInfo;
            request.RpcId = rpcId;
            this.Send(request);
            return await rpcInfo.Tcs;
        }

        public void Reply(IResponse message)
        {
            this.Send(0, message);
        }

        public void Send(IMessage message)
        {
            this.Send(0, message);
        }
        
        public void Send(long actorId, IMessage message)
        {
            (ushort opcode, MemoryStream stream) = MessageSerializeHelper.MessageToStream(message);
            OpcodeHelper.LogMsg(this.DomainZone(), opcode, message);
            this.Send(actorId, stream);
        }
        
        public void Send(long actorId, MemoryStream memoryStream)
        {
            this.LastSendTime = TimeHelper.ClientNow();
            this.AService.SendStream(this.Id, actorId, memoryStream);
        }

        public void SendString(TCPGameServerCmds cmd, string strcmd)
        {
            _PacketCmdID = (ushort) cmd;
            var bytesCmd = new UTF8Encoding().GetBytes(strcmd);
            FinalWriteData(bytesCmd, 0, bytesCmd.Length);
            DataHelper.SortBytes(PacketBytes, 0, PacketBytes.Length);
            using (MemoryStream stream = new MemoryStream(PacketBytes.Length))
            {
                stream.Write(PacketBytes, 0, PacketBytes.Length);
                Log.Debug("xx客户端 内容(" + _PacketDataSize + "):" + strcmd);
                Log.Debug("xx客户端 bytes:" + BitConverter.ToString(PacketBytes));
                this.Send(0, stream);
            }
        }
        
        public bool FinalWriteData(byte[] buffer, int offset, int count)
        {
          if (PacketBytes != null || 11 + count >= 131072)
            return false;
          PacketBytes = new byte[count + 4 + 2 + 1 + 4];
          
          DataHelper.CopyBytes(PacketBytes, 11, buffer, offset, count);
          
          _PacketDataSize = count;
          Final();
          return true;
        }

        private void Final()
        {
          int num1 = _PacketDataSize + 2 + 1 + 4;
          
          DataHelper.CopyBytes(PacketBytes, 0, BitConverter.GetBytes(num1), 0, 4);
          ushort PacketCmdID = _PacketCmdID;
          
          DataHelper.CopyBytes(PacketBytes, 4, BitConverter.GetBytes(PacketCmdID), 0, 2);
          
          int off = 11;
          DateTime now = DateTime.Now;
          int clientCheckTicks = (int) ((now.Ticks - TimeHelper.Before1970Ticks) / 10000000L);
          byte[] bytes = BitConverter.GetBytes(clientCheckTicks);
          CRC32 crc32 = new CRC32();
          crc32.update(bytes);
          crc32.update(PacketBytes, off, _PacketDataSize);
          
          uint cc = crc32.getValue() % byte.MaxValue;
          uint cc2 = (uint)(_PacketCmdID % byte.MaxValue);
          int cc3 =  (int)(cc ^ cc2);
          DataHelper.CopyBytes(PacketBytes, 6, BitConverter.GetBytes((short) cc3), 0, 1);
          DataHelper.CopyBytes(PacketBytes, 7, bytes, 0, 4);

        }
    }
}