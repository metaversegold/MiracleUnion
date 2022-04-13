

namespace ET
{
	public class LoginFinish_RemoveLoginUI: AEvent<EventType.LoginFinish>
	{
		protected override async ETTask Run(EventType.LoginFinish args)
		{
			args.ZoneScene.GetComponent<FUIComponent>().Remove(FUILogin.UIResName);
		}
	}
}
