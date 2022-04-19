using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Net;
using System.Text;
using UnityEngine;

namespace ET
{
    [ObjectSystem]
    public class NetTcpComponentAwakeSystem: AwakeSystem<NetTcpComponent, int>
    {
        public override void Awake(NetTcpComponent self, int sessionStreamDispatcherType)
        {
            self.Awake(sessionStreamDispatcherType);
        }
    }

    [ObjectSystem]
    public class NetTcpComponentAwake1System: AwakeSystem<NetTcpComponent, IPEndPoint, int>
    {
        public override void Awake(NetTcpComponent self, IPEndPoint address, int sessionStreamDispatcherType)
        {
            self.Awake(address, sessionStreamDispatcherType);
        }
    }
    
    public class NetTcpComponent : Entity, IAwake<int>, IAwake<IPEndPoint, int>, IDestroy
    {
        public AService Service;
        
        public int SessionStreamDispatcherType { get; set; }

        public void Awake(int sessionStreamDispatcherType)
        {
            SessionStreamDispatcherType = sessionStreamDispatcherType;
            
            Service = new TService(NetThreadComponent.Instance.ThreadSynchronizationContext, ServiceType.CMD);
            Service.ErrorCallback += (channelId, error) => OnError(channelId, error);
            Service.ReadCallback += (channelId, Memory) => OnRead(channelId, Memory);

            NetThreadComponent.Instance.Add(Service);
        }

        public void Awake(IPEndPoint address, int sessionStreamDispatcherType)
        {
            SessionStreamDispatcherType = sessionStreamDispatcherType;
            
            Service = new TService(NetThreadComponent.Instance.ThreadSynchronizationContext, address, ServiceType.CMD);
            Service.ErrorCallback += (channelId, error) => OnError(channelId, error);
            Service.ReadCallback += (channelId, Memory) => OnRead(channelId, Memory);
            Service.AcceptCallback += (channelId, IPAddress) => OnAccept(channelId, IPAddress);

            NetThreadComponent.Instance.Add(Service);
        }
        

        public override void Dispose()
        {
            if (IsDisposed)
            {
                return;
            }

            base.Dispose();
            
            NetThreadComponent.Instance.Remove(Service);
            Service.Destroy();
        }
        
        public void OnRead(long channelId, MemoryStream memoryStream)
        {
            Session session = GetChild<Session>(channelId);
            if (session == null)
            {
                return;
            }

            session.LastRecvTime = TimeHelper.ClientNow();
            //SessionStreamDispatcher.Instance.Dispatch(SessionStreamDispatcherType, session, memoryStream);
            
            int offsetLen = 2;
            byte[] data = memoryStream.GetBuffer();
            byte[] data2 = new byte[data.Length];
            byte[] data3 = new byte[data.Length-offsetLen];
            DataHelper.CopyBytes(data2, 0, data, 0, data.Length);
            int _PacketDataSize = data.Length;
            //再读取2个字节的指令
            ushort _PacketCmdID = BitConverter.ToUInt16(data2, 0);

            if (data.Length > offsetLen)
            {
                DataHelper.CopyBytes(data3, 0, data2, offsetLen, data.Length - offsetLen);
            }

            string strData = new UTF8Encoding().GetString(data3, 0, (int) data3.Length);
            Log.Debug($"xx服务端 内容 cmd {((TCPGameServerCmds)_PacketCmdID).ToString()} ({_PacketDataSize}):{strData}");
            Log.Debug("xx服务端 bytes:" + BitConverter.ToString(memoryStream.GetBuffer()));
        }

        public void OnError(long channelId, int error)
        {
            Session session = GetChild<Session>(channelId);
            if (session == null)
            {
                return;
            }

            session.Error = error;
            session.Dispose();
        }

        // 这个channelId是由CreateAcceptChannelId生成的
        public void OnAccept(long channelId, IPEndPoint ipEndPoint)
        {
            Session session = AddChildWithId<Session, AService>(channelId, Service);
            session.RemoteAddress = ipEndPoint;

            // 挂上这个组件，5秒就会删除session，所以客户端验证完成要删除这个组件。该组件的作用就是防止外挂一直连接不发消息也不进行权限验证
            session.AddComponent<SessionAcceptTimeoutComponent>();
            // 客户端连接，2秒检查一次recv消息，10秒没有消息则断开
            session.AddComponent<SessionIdleCheckerComponent, int>(NetThreadComponent.checkInteral);
        }

        public Session Get(long id)
        {
            Session session = GetChild<Session>(id);
            return session;
        }

        public Session Create(IPEndPoint realIPEndPoint)
        {
            long channelId = RandomHelper.RandInt64();
            Session session = AddChildWithId<Session, AService>(channelId, Service);
            session.RemoteAddress = realIPEndPoint;
            session.AddComponent<SessionIdleCheckerComponent, int>(NetThreadComponent.checkInteral);
            
            Service.GetOrCreate(session.Id, realIPEndPoint);

            return session;
        }
    }
}
