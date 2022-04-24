using System;
using Server.Data;

namespace ET
{
    [CmdByteHandler(TCPGameServerCmds.CMD_SPR_GETATTRIB2)]
    public class CMD_SPR_GETATTRIB2_Handler : CmdByteHandler
    {
        protected override async ETTask Run(Session session, byte[] message)
        {
            Log.Debug($"收到消息 CMD_SPR_GETATTRIB2 : " + BitConverter.ToString(message));
            EquipPropsData equipPropsData =  DataHelper.BytesToObject<EquipPropsData>(message, 0, message.Length);
            Log.Debug($"收到消息 equipPropsData : " + equipPropsData.MaxHP);
        }
    }
}
