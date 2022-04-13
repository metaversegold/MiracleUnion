
using UnityEngine;
using UnityEngine.UI;

namespace ET
{
	[ObjectSystem]
	public class FUILobbyComponentAwakeSystem : AwakeSystem<FUILobbyComponent>
	{
		public override void Awake(FUILobbyComponent self)
		{
			self.Awake();
		}
	}
	public class FUILobbyComponent : Entity, IAwake
	{
		private FUILobby fuiLobby;
		
		public void Awake()
		{
			fuiLobby = GetParent<FUILobby>();
			fuiLobby.enterButton.self.onClick.Set(OnClickEnterMap);
		}

		public override void Dispose()
		{
			if (IsDisposed)
			{
				return;
			}

			base.Dispose();

			fuiLobby.enterButton.self.onClick.Clear();
		}

		public void OnClickEnterMap()
		{
			EnterMapHelper.EnterMapAsync(this.ZoneScene()).Coroutine();
			this.ZoneScene().GetComponent<FUIComponent>().Remove(FUILobby.UIResName);
		}

		public static FUI Create(Scene scene)
		{
			var fui = FUILobby.CreateInstance(scene);

			//默认将会以Id为Name，也可以自定义Name，方便查询和管理
			fui.Name = FUILobby.UIResName;
			fui.MakeFullScreen();
			fui.AddComponent<FUILobbyComponent>();

			scene.GetComponent<FUIComponent>().Add(fui, true);

			return fui;
		}
	}
}
