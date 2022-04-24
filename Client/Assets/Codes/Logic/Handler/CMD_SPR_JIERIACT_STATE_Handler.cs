using System;
using Server.Data;

namespace ET
{
    [CmdTextHandler(TCPGameServerCmds.CMD_SPR_JIERIACT_STATE)]
    public class CMD_SPR_JIERIACT_STATE_Handler : CmdTextHandler
    {
        protected override async ETTask Run(Session session, string message)
        {
            Log.Debug($"收到消息 CMD_SPR_JIERIACT_STATE : " + message);
        }
    }
}
