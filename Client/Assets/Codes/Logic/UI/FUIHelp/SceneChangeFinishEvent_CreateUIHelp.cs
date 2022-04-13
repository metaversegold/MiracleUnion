namespace ET
{
    public class SceneChangeFinishEvent_CreateUIHelp : AEvent<EventType.SceneChangeFinish>
    {
        protected override async ETTask Run(EventType.SceneChangeFinish args)
        {
            await args.ZoneScene.GetComponent<FUIPackageComponent>().AddPackageAsync(FUIPackage.Common);
        }
    }
}
