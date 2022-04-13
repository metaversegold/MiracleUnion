

namespace ET
{
	public class AppStartInitFinish_CreateLoginUI: AEvent<EventType.AppStartInitFinish>
	{
		protected override async ETTask Run(EventType.AppStartInitFinish args)
		{
			await args.ZoneScene.GetComponent<FUIPackageComponent>().AddPackageAsync(FUIPackage.Login);
			FUILoginComponent.Create(args.ZoneScene);
		}
	}
}
