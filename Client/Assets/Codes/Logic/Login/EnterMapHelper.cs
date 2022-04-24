using System;


namespace ET
{
    public static class EnterMapHelper
    {
        public static async ETTask EnterMapAsync(Scene zoneScene)
        {
            try
            {
                // G2C_EnterMap g2CEnterMap = await zoneScene.GetComponent<SessionComponent>().Session.Call(new C2G_EnterMap()) as G2C_EnterMap;
                // zoneScene.GetComponent<PlayerComponent>().UserID = g2CEnterMap.MyId;
                string strcmd = StringUtil.substitute("{0}:{1}:{2}", zoneScene.GetComponent<PlayerComponent>().UserID, zoneScene.GetComponent<PlayerComponent>().RoleID,ConstValue.GetDeviceID());
                zoneScene.GetComponent<SessionComponent>().Session.SendString(TCPGameServerCmds.CMD_INIT_GAME, strcmd);
                
                // 等待场景切换完成
                await zoneScene.GetComponent<ObjectWait>().Wait<WaitType.Wait_SceneChangeFinish>();
                
                Game.EventSystem.Publish(new EventType.EnterMapFinish() {ZoneScene = zoneScene});
            }
            catch (Exception e)
            {
                Log.Error(e);
            }	
        }
    }
}