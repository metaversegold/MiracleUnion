using System;
using Server.Data;

namespace ET
{
    [CmdTextHandler(TCPGameServerCmds.CMD_PLAY_GAME)]
    public class CMD_PLAY_GAME_Handler : CmdTextHandler
    {
        protected override async ETTask Run(Session session, string[] fields)
        {
            Log.Debug($"收到消息 CMD_PLAY_GAME : " + fields);
            
            //CMD_SPR_CHENGJIUDATA      ChengJiuData    查询成就数据
            //CMD_SPR_DAILYTASKDATA     List<DailyTaskData> 
            //CMD_SPR_MARRY_PARTY_JOIN_LIST     Dictionary<int,int>     个人参与婚宴次数列表
            //CMD_SPR_NPCSTATELIST      List<NPCTaskState>
            //CMD_SPR_GETWANGCHENGMAPINFO      WangChengMapInfoData
            //CMD_SPR_MARRY_UPDATE      MarriageData        婚姻状态更新
            //CMD_SPR_MARRY_SPOUSE_DATA     MarriageData_EX     结婚对象婚姻状态更新
            //CMD_SPR_HOLYITEM_DATA     Dictionary<sbyte, HolyItemData>     玩家登陆时返回整个圣物字典 一共4个圣物和所有部件信息
            //CMD_SPR_FUBENDATA         FuBenData
            //CMD_SPR_UPDATE_ROLEDATA       SpriteLifeChangeData
            //CMD_SPR_NEWNPC        NPCRole
            
            //CMD_SPR_USERGOLDCHANGE    角色绑定钻石变化
            //CMD_SPR_ROLEPARAMSCHANGE
            //CMD_SPR_NOTIFYSHENGXIAOGUESSSTAT      生肖运程竞猜状态   
            
        }
    }
}
