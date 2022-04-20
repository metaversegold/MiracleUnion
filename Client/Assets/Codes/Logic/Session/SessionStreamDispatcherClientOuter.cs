using System;
using System.IO;
using System.Text;

namespace ET
{
    [SessionStreamDispatcher(SessionStreamDispatcherType.SessionStreamDispatcherClientOuter)]
    public class SessionStreamDispatcherClientOuter: ISessionStreamDispatcher
    {
        public void Dispatch(Session session, MemoryStream memoryStream)
        {
            ushort opcode = BitConverter.ToUInt16(memoryStream.GetBuffer(), Packet.KcpOpcodeIndex);
            Type type = OpcodeTypeComponent.Instance.GetType(opcode);
            object message = MessageSerializeHelper.DeserializeFrom(opcode, type, memoryStream);
            
            if (message is IResponse response)
            {
                session.OnRead(opcode, response);
                return;
            }

            OpcodeHelper.LogMsg(session.DomainZone(), opcode, message);
            // 普通消息或者是Rpc请求消息
            MessageDispatcherComponent.Instance.Handle(session, opcode, message);
        }
    }
    
    [SessionStreamDispatcher(SessionStreamDispatcherType.SessionStreamDispatcherClientOuterCmd)]
    public class SessionStreamDispatcherClientOuterCmd: ISessionStreamDispatcher
    {
        public void Dispatch(Session session, MemoryStream memoryStream)
        {
            byte[] messageBytes = memoryStream.GetBuffer();
            ushort _PacketCmdID = BitConverter.ToUInt16(messageBytes, 0);
            
            // 普通消息或者是Rpc请求消息
            MessageDispatcherComponent.Instance.CmdHandle(session, _PacketCmdID, messageBytes);
        }
    }
}