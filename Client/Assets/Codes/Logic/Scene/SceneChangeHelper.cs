using Server.Data;
using UnityEngine;

namespace ET
{
    public static class SceneChangeHelper
    {
        // 场景切换协程
        public static async ETTask SceneChangeTo(Scene zoneScene, RoleData roleData)
        {
            zoneScene.RemoveComponent<AIComponent>();
            
            CurrentScenesComponent currentScenesComponent = zoneScene.GetComponent<CurrentScenesComponent>();
            currentScenesComponent.Scene?.Dispose(); // 删除之前的CurrentScene，创建新的
            Scene currentScene = SceneFactory.CreateCurrentScene(IdGenerater.Instance.GenerateInstanceId(), zoneScene.Zone, "yongzhedalu", currentScenesComponent);
            UnitComponent unitComponent = currentScene.AddComponent<UnitComponent>();
         
            // 可以订阅这个事件中创建Loading界面
            Game.EventSystem.Publish(new EventType.SceneChangeStart() {ZoneScene = zoneScene});
            
            // 等待CreateMyUnit的消息
            await zoneScene.GetComponent<ObjectWait>().Wait<WaitType.Wait_CreateMyUnit>();
            Unit unit = UnitFactory.Create(currentScene, roleData);
            unitComponent.Add(unit);
            
            zoneScene.RemoveComponent<AIComponent>();
            
            Game.EventSystem.Publish(new EventType.SceneChangeFinish() {ZoneScene = zoneScene, CurrentScene = currentScene});

            // 通知等待场景切换的协程
            zoneScene.GetComponent<ObjectWait>().Notify(new WaitType.Wait_SceneChangeFinish());
        }
    }
}