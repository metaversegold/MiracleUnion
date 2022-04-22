using System;
using UnityEngine;


namespace ET
{
    
    [CmdTextHandler(TCPGameServerCmds.CMD_LOGIN_ON1)]
    public class CMD_LOGIN_ON1_Handler : CmdTextHandler
    {
        protected override async ETTask Run(Session session, string message)
        {
            var zoneScene = session.DomainScene();
            PlayerComponent player = zoneScene.GetComponent<PlayerComponent>();
            player.InitServerInfo(message);
            
            session?.Dispose();
            
            var sessionGame = zoneScene.GetComponent<NetTcpComponent>().Create(NetworkHelper.ToIPEndPoint(ConstValue.GameAddress));
            {
                string strcmd = StringUtil.substitute("{0}:{1}:{2}:{3}:{4}:{5}:{6}",
                    player.UserID,
                        player.UserName,
                        player.UserToken,
                        -1,//RoleRandToken??
                        (int)TCPCmdProtocolVer.VerSign,
                        player.IsAdult?1:0,
                        "Test Device ID"//QMQJJava.GetDeviceID()
                    );
                string kuafu = StringUtil.substitute(":{0}:{1}:{2}:{3}:{4}:{5}",0, 0, 0, 0, "", 0);//跨服信息
                strcmd += kuafu;
                sessionGame.SendString(TCPGameServerCmds.CMD_LOGIN_ON, strcmd);
            }
        }
    }
    
    [CmdTextHandler(TCPGameServerCmds.CMD_LOGIN_ON)]
    public class CMD_LOGIN_ON_Handler : CmdTextHandler
    {
        protected override async ETTask Run(Session session, string message)
        {
            Log.Debug($"收到消息 : " + message);
            
            await TimerComponent.Instance.WaitAsync(500);
            
            var zoneScene = session.DomainScene();
            zoneScene.RemoveComponent<SessionComponent>();
            zoneScene.AddComponent<SessionComponent>().Session = session;
            
            await Game.EventSystem.PublishAsync(new EventType.LoginFinish() {ZoneScene = zoneScene});
            
            string[] fields = message.Split(':');
            PlayerComponent player = zoneScene.GetComponent<PlayerComponent>();
            player.RoleRandToken = Convert.ToInt32(fields[0]);
            
            session.AddComponent<PingComponent>();
            
            string strcmd = StringUtil.substitute("{0}:{1}", player.UserID, player.GameServerID);
            session.SendString(TCPGameServerCmds.CMD_SECOND_PASSWORD_CHECK_STATE, strcmd);
            session.SendString(TCPGameServerCmds.CMD_ROLE_LIST, strcmd);
            // strcmd = StringUtil.substitute("{0}:{1}:{2}", player.UserID, player.RoleID, "Test Device ID");
            // tcpClient.SendData(TCPOutPacket.MakeTCPOutPacket(tcpClient.OutPacketPool, strcmd, (int)(TCPGameServerCmds.CMD_INIT_GAME)));
        }
    }
    
    [CmdByteHandler(TCPGameServerCmds.CMD_NTF_EACH_ROLE_ALLOW_CHANGE_NAME)]
    public class CMD_NTF_EACH_ROLE_ALLOW_CHANGE_NAME_Handler : CmdByteHandler
    {
        protected override async ETTask Run(Session session, byte[] message)
        {
            Log.Debug($"收到消息 CMD_NTF_EACH_ROLE_ALLOW_CHANGE_NAME : " + BitConverter.ToString(message));
        }
    }
    
    [CmdTextHandler(TCPGameServerCmds.CMD_SECOND_PASSWORD_CHECK_STATE)]
    public class CMD_SECOND_PASSWORD_CHECK_STATE_Handler : CmdTextHandler
    {
        protected override async ETTask Run(Session session, string message)
        {
            Log.Debug($"收到消息 : " + message);
        }
    }
    
    [CmdTextHandler(TCPGameServerCmds.CMD_ROLE_LIST)]
    public class CMD_ROLE_LIST_Handler : CmdTextHandler
    {
        protected override async ETTask Run(Session session, string message)
        {
            var zoneScene = session.DomainScene();
            PlayerComponent player = zoneScene.GetComponent<PlayerComponent>();
            player.InitRoleList(message);
            var fui = zoneScene.GetComponent<FUIComponent>().Get(FUILobby.UIResName);
			fui.GetComponent<FUILobbyComponent>().UpdateRoleList();
        }
    }
    
    public static class LoginHelper
    {
        public static async ETTask Login(Scene zoneScene, string address, string account, string password)
        {
            try
            {
                // 创建一个ETModel层的Session
                R2C_Login r2CLogin;
                Session session = null;
                try
                {
                    session = zoneScene.GetComponent<NetTcpComponent>().Create(NetworkHelper.ToIPEndPoint(address));
                    {
                        string strcmd = StringUtil.substitute("{0}:{1}:{2}", (int)(TCPCmdProtocolVer.VerSign), account, password);
                        PlayerPrefs.SetString("userName",account);
                        PlayerPrefs.SetString("password",password);
                        session.SendString(TCPGameServerCmds.CMD_LOGIN_ON1, strcmd);
                    }
                    // session = zoneScene.GetComponent<NetKcpComponent>().Create(NetworkHelper.ToIPEndPoint(address));
                    // {
                    //     r2CLogin = (R2C_Login) await session.Call(new C2R_Login() { Account = account, Password = password });
                    // }
                }
                finally
                {
                    //session?.Dispose();
                }

                // // 创建一个gate Session,并且保存到SessionComponent中
                // Session gateSession = zoneScene.GetComponent<NetKcpComponent>().Create(NetworkHelper.ToIPEndPoint(r2CLogin.Address));
                // gateSession.AddComponent<PingComponent>();
                // zoneScene.AddComponent<SessionComponent>().Session = gateSession;
				            //
                // G2C_LoginGate g2CLoginGate = (G2C_LoginGate)await gateSession.Call(
                //     new C2G_LoginGate() { Key = r2CLogin.Key, GateId = r2CLogin.GateId});
                //
                // Log.Debug("登陆gate成功!");
                //
                // await Game.EventSystem.PublishAsync(new EventType.LoginFinish() {ZoneScene = zoneScene});
            }
            catch (Exception e)
            {
                Log.Error(e);
            }
        } 
    }
}