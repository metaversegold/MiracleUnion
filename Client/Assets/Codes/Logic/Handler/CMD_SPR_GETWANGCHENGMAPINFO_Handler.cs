using System;
using Server.Data;

namespace ET
{
    [CmdByteHandler(TCPGameServerCmds.CMD_SPR_GETWANGCHENGMAPINFO)]
    public class CMD_SPR_GETWANGCHENGMAPINFO_Handler : CmdByteHandler
    {
        protected override async ETTask Run(Session session, byte[] message)
        {
            Log.Debug($"收到消息 CMD_SPR_GETWANGCHENGMAPINFO : " + BitConverter.ToString(message));
        }
    }
}
