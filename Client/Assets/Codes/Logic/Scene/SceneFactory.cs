namespace ET
{
    public static class SceneFactory
    {
        public static Scene CreateZoneScene(int zone, string name, Entity parent)
        {
            //Log.Debug($"CreateZoneScene zone {zone}");
            
            Scene zoneScene = EntitySceneFactory.CreateScene(Game.IdGenerater.GenerateInstanceId(), zone, SceneType.Zone, name, parent);
            zoneScene.AddComponent<ZoneSceneFlagComponent>();
            zoneScene.AddComponent<NetTcpComponent, int>(SessionStreamDispatcherType.SessionStreamDispatcherClientOuter);
			zoneScene.AddComponent<CurrentScenesComponent>();
            zoneScene.AddComponent<ObjectWait>();
            zoneScene.AddComponent<PlayerComponent>();
            
            Game.EventSystem.Publish(new EventType.AfterCreateZoneScene() {ZoneScene = zoneScene});
            return zoneScene;
        }
        
        public static Scene CreateCurrentScene(long id, int zone, string name, CurrentScenesComponent currentScenesComponent)
        {
            //Log.Debug($"CreateCurrentScene id {id}, zone {zone}");
            
            Scene currentScene = EntitySceneFactory.CreateScene(id, IdGenerater.Instance.GenerateInstanceId(), zone, SceneType.Current, name, currentScenesComponent);
            currentScenesComponent.Scene = currentScene;
            
            Game.EventSystem.Publish(new EventType.AfterCreateCurrentScene() {CurrentScene = currentScene});
            return currentScene;
        }
        
        
    }
}