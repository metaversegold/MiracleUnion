using System;
using Server.Data;

namespace ET
{
    
    
    [CmdByteHandler(TCPGameServerCmds.CMD_SPR_CLIENTHEART)]
    public class CMD_SPR_CLIENTHEART_Handler : CmdByteHandler
    {
        protected override async ETTask Run(Session session, byte[] message)
        {
            Log.Debug($"收到消息 CMD_SPR_CLIENTHEART : " + BitConverter.ToString(message));
        }
    }
    
    [ObjectSystem]
    public class PingComponentAwakeSystem: AwakeSystem<PingComponent>
    {
        public override void Awake(PingComponent self)
        {
            self.PingAsync().Coroutine();
        }
    }

    [ObjectSystem]
    public class PingComponentDestroySystem: DestroySystem<PingComponent>
    {
        public override void Destroy(PingComponent self)
        {
        }
    }
    
    public class PingComponent: Entity, IAwake, IDestroy
    {
        private void Ping()
        {
            Session session = GetParent<Session>();
            PlayerComponent player = this.DomainScene().GetComponent<PlayerComponent>();

            SCClientHeart ClientHeart = new SCClientHeart();
            ClientHeart.RoleID = player.RoleID;
            ClientHeart.RandToken = player.RoleRandToken;
            ClientHeart.Ticks = (int)TimeHelper.ClientNow();
            ClientHeart.ReportCliRealTick = DateTime.Now.Ticks; // 不要随意修改该值
            byte[] bData = ClientHeart.toBytes();

            session.SendBytes(TCPGameServerCmds.CMD_SPR_CLIENTHEART, bData);
        }

        public async ETTask PingAsync()
        {
            try
            {
                Ping();
                for (int i = 0; ; i++)
                {
                    await TimerComponent.Instance.WaitAsync(10000);
                    Ping();
                }
            }
            catch (Exception e)
            {
                Log.Error(e);
            }
        }
    }
}