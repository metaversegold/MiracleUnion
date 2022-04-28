
using System.Linq;
using FairyGUI;
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
		private GList _roleList;
		private int selectedID;
		
		public void Awake()
		{
			fuiLobby = GetParent<FUILobby>();
			fuiLobby.enterButton.self.onClick.Set(OnClickEnterMap);
			
			_roleList = fuiLobby.RoleList;
			_roleList.itemRenderer = RoleListRenderer;
			_roleList.onClickItem.Set(RoleListClick);

			selectedID = 0;
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
			if (selectedID > 0)
			{
				var zoneScene = this.ZoneScene();
				
				string strcmd = StringUtil.substitute("{0}:{1}:{2}", zoneScene.GetComponent<PlayerComponent>().UserID, selectedID, ConstValue.GetDeviceID());
				zoneScene.GetComponent<SessionComponent>().Session.SendString(TCPGameServerCmds.CMD_INIT_GAME, strcmd);
				
				zoneScene.GetComponent<FUIComponent>().Remove(FUILobby.UIResName);
			}
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

		public void UpdateRoleList()
		{
			var zoneScene = this.ZoneScene();
			PlayerComponent player = zoneScene.GetComponent<PlayerComponent>();
			_roleList.numItems = player.Roles.Count;
			if (player.Roles.Count > 0)
			{
				selectedID = player.Roles.Keys.ToList()[0];
			}
			else
			{
				selectedID = 0;
			}
		}


		private void RoleListClick(EventContext context)
		{
			var textItem= context.data as GComponent;
			int ID = (int) textItem.data;
			Log.Debug($"RoleListClick {ID}");
			selectedID = ID;
		}
		
		private void RoleListRenderer(int index, GObject item)
		{
			var zoneScene = this.ZoneScene();
			PlayerComponent player = zoneScene.GetComponent<PlayerComponent>();
			var indexs = player.Roles.Keys.ToList();
			if (player.Roles.ContainsKey(indexs[index]))
			{
				var roleInfo = player.Roles[indexs[index]];
				var cell = item.asCom;
				cell.data = indexs[index];
				cell.GetChild("CharName").asTextField.text = roleInfo[3];
			}
		}

	}
}
