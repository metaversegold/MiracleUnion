using System;
using Server.Data;

namespace ET
{
    [CmdByteHandler(TCPGameServerCmds.CMD_SPR_MARRY_PARTY_JOIN_LIST)]
    public class CMD_SPR_MARRY_PARTY_JOIN_LIST_Handler : CmdByteHandler
    {
        protected override async ETTask Run(Session session, byte[] message)
        {
            Log.Debug($"收到消息 CMD_SPR_MARRY_PARTY_JOIN_LIST : " + BitConverter.ToString(message));
        }
    }
}
