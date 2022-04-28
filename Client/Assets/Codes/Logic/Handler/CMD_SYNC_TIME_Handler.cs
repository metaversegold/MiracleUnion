using System;
using Server.Data;

namespace ET
{
    [CmdTextHandler(TCPGameServerCmds.CMD_SYNC_TIME)]
    public class CMD_SYNC_TIME_Handler : CmdTextHandler
    {
        protected override async ETTask Run(Session session, string[] fields)
        {
            Log.Debug($"收到消息 CMD_SYNC_TIME : " + fields);
            
            var zoneScene = session.DomainScene();
            PlayerComponent player = zoneScene.GetComponent<PlayerComponent>();
            await SceneChangeHelper.SceneChangeTo(zoneScene, player.NetDataRoleData);
            
            player.StartPlayGame();
        }
    }
}
