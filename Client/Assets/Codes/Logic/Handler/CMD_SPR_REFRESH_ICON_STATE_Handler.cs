using System;
using Server.Data;

namespace ET
{
    [CmdByteHandler(TCPGameServerCmds.CMD_SPR_REFRESH_ICON_STATE)]
    public class CMD_SPR_REFRESH_ICON_STATE_Handler : CmdByteHandler
    {
        protected override async ETTask Run(Session session, byte[] message)
        {
            Log.Debug($"收到消息 CMD_SPR_REFRESH_ICON_STATE : " + BitConverter.ToString(message));
            ActivityIconStateData activityIconStateData =  DataHelper.BytesToObject<ActivityIconStateData>(message, 0, message.Length);
            Log.Debug($"收到消息 ActivityIconStateData : " + activityIconStateData.arrIconState);
        }
    }
}
