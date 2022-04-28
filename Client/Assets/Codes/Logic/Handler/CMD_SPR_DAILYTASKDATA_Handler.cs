using System;
using Server.Data;

namespace ET
{
    [CmdByteHandler(TCPGameServerCmds.CMD_SPR_DAILYTASKDATA)]
    public class CMD_SPR_DAILYTASKDATA_Handler : CmdByteHandler
    {
        protected override async ETTask Run(Session session, byte[] message)
        {
            Log.Debug($"收到消息 CMD_SPR_DAILYTASKDATA : " + BitConverter.ToString(message));
        }
    }
}
