using System;
using Server.Data;

namespace ET
{
    [CmdTextHandler(TCPGameServerCmds.CMD_UPDATEALLTHINGINDEXS)]
    public class CMD_UPDATEALLTHINGINDEXS_Handler : CmdTextHandler
    {
        protected override async ETTask Run(Session session, string[] fields)
        {
            Log.Debug($"收到消息 CMD_UPDATEALLTHINGINDEXS : " + fields);
        }
    }
}
