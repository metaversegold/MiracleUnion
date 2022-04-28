﻿using System;
using Server.Data;

namespace ET
{
    [CmdTextHandler(TCPGameServerCmds.CMD_SPR_USERGOLDCHANGE)]
    public class CMD_SPR_USERGOLDCHANGE_Handler : CmdTextHandler
    {
        protected override async ETTask Run(Session session, string[] fields)
        {
            Log.Debug($"收到消息 CMD_SPR_USERGOLDCHANGE : " + fields);
        }
    }
}
