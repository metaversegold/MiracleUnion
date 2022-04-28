using System;
using Server.Data;

namespace ET
{
    [CmdByteHandler(TCPGameServerCmds.CMD_SPR_HOLYITEM_DATA)]
    public class CMD_SPR_HOLYITEM_DATA_Handler : CmdByteHandler
    {
        protected override async ETTask Run(Session session, byte[] message)
        {
            Log.Debug($"收到消息 CMD_SPR_HOLYITEM_DATA : " + BitConverter.ToString(message));
        }
    }
}
