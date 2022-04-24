using System;
using Server.Data;

namespace ET
{
    [CmdByteHandler(TCPGameServerCmds.CMD_SPR_BUFFERDATA)]
    public class CMD_SPR_BUFFERDATA_Handler : CmdByteHandler
    {
        protected override async ETTask Run(Session session, byte[] message)
        {
            Log.Debug($"收到消息 CMD_SPR_BUFFERDATA : " + BitConverter.ToString(message));
            BufferData bufferData =  DataHelper.BytesToObject<BufferData>(message, 0, message.Length);
            Log.Debug($"收到消息 bufferData : " + bufferData.BufferID);
        }
    }
}
