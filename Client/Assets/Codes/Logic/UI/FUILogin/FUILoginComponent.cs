using UnityEngine;

namespace ET
{
	[ObjectSystem]
	public class FUILoginComponentAwakeSystem : AwakeSystem<FUILoginComponent>
	{
		public override void Awake(FUILoginComponent self)
		{
			self.Awake();
		}
	}
	
	public class FUILoginComponent: Entity, IAwake
	{
		private FUILogin fuiLogin;
		
		public void Awake()
		{
			fuiLogin = GetParent<FUILogin>();
			fuiLogin.loginButton.self.onClick.Set(OnClickLogin);
		}

		public override void Dispose()
		{
			if (IsDisposed)
			{
				return;
			}

			base.Dispose();

			fuiLogin.loginButton.self.onClick.Clear();
		}

		public void OnClickLogin()
		{
			LoginHelper.Login(
				this.DomainScene(),
				ConstValue.LoginAddress, 
				fuiLogin.accountInput.text, 
				fuiLogin.passwordInput.text).Coroutine();
		}

		public static FUI Create(Scene scene)
		{
			var fui = FUILogin.CreateInstance(scene);

			//默认将会以Id为Name，也可以自定义Name，方便查询和管理
			fui.Name = FUILogin.UIResName;
			fui.MakeFullScreen();
			fui.AddComponent<FUILoginComponent>();

			scene.GetComponent<FUIComponent>().Add(fui, true);

			return fui;
		}
	}
}
