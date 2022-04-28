using System;
using Server.Data;

namespace ET
{
    [CmdByteHandler(TCPGameServerCmds.CMD_SPR_FUBENDATA)]
    public class CMD_SPR_FUBENDATA_Handler : CmdByteHandler
    {
        protected override async ETTask Run(Session session, byte[] message)
        {
            Log.Debug($"收到消息 CMD_SPR_FUBENDATA : " + BitConverter.ToString(message));
        }
    }
}
