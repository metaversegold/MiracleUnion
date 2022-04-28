using System;
using Server.Data;

namespace ET
{
    [CmdByteHandler(TCPGameServerCmds.CMD_INIT_GAME)]
    public class CMD_INIT_GAME_Handler : CmdByteHandler
    {
        protected override async ETTask Run(Session session, byte[] message)
        {
            var zoneScene = session.DomainScene();
            Log.Debug($"收到消息 CMD_INIT_GAME : " + BitConverter.ToString(message));
            RoleData roleData =  DataHelper.BytesToObject<RoleData>(message, 0, message.Length);
            Log.Debug($"收到消息 RoleData : " + roleData.RoleName);
            PlayerComponent player = zoneScene.GetComponent<PlayerComponent>();
            player.NetDataRoleData = roleData;
            
            //CMD_SPR_GETATTRIB2 EquipPropsData
            //CMD_SPR_BUFFERDATA BufferData
            //CMD_SPR_REFRESH_ICON_STATE ActivityIconStateData 刷新图标状态信息
            
            //CMD_SPR_VIPLEVELUP roleid:VIP经验
            //CMD_SPR_JIERIACT_STATE 活动ICON控制
            //CMD_SPR_DAILYACTIVEDATA 获取每日活跃信息
            //CMD_UPDATEALLTHINGINDEXS
            
            //todo CMD_SYNC_TIME
            string strcmd = StringUtil.substitute("{0}:{1}", zoneScene.GetComponent<PlayerComponent>().RoleID, TimeHelper.ClientNow());
            zoneScene.GetComponent<SessionComponent>().Session.SendString(TCPGameServerCmds.CMD_SYNC_TIME, strcmd);
            
            //session.DomainScene().GetComponent<ObjectWait>().Notify(new WaitType.Wait_CreatePlayerRoleUnit() {Data = roleData});
            
            await ETTask.CompletedTask;
        }
    }
}
