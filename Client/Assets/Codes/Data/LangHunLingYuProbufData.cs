using System.Collections.Generic;
using ProtoBuf;
using System;

namespace Server.Data
{
    public enum LangHunLingYuGameStates
    {
        None, //无
        SignUp, //报名时间
        Wait, //等待开始
        Start, //开始
        Awards, //有未领取奖励
        NotJoin, // 未参加本次活动
    }

    /// <summary>
    /// 分数增加
    /// </summary>
    [ProtoContract]
    public class LangHunLingYuSelfScore
    {
        /// <summary>
        /// 分数
        /// </summary>
        [ProtoMember(1)]
        public int AddScore;

        /// <summary>
        /// 区号
        /// </summary>
        [ProtoMember(2)]
        public int ZoneID;

        /// <summary>
        /// 名字
        /// </summary>
        [ProtoMember(3)]
        public string Name = "";

        /// <summary>
        /// 阵营方
        /// </summary>
        [ProtoMember(4)]
        public int Side;

        /// <summary>
        /// 得分的角色ID
        /// </summary>
        [ProtoMember(5)]
        public int RoleId;

        /// <summary>
        /// 如果是连杀得分,这个值表示连杀数,否则为0
        /// </summary>
        [ProtoMember(6)]
        public int ByLianShaNum;

        /// <summary>
        /// 职业
        /// </summary>
        [ProtoMember(7)]
        public int Occupation;

        /// <summary>
        /// 个人的总积分
        /// </summary>
        [ProtoMember(8)]
        public int TotalScore;
    }

    /// <summary>
    /// 战斗结束的结果和奖励
    /// </summary>
    [ProtoContract]
    public class LangHunLingYuAwardsData
    {
        /// <summary>
        /// 战斗结果(0失败,1胜利)
        /// </summary>
        [ProtoMember(1)]
        public int Success;

        /// <summary>
        /// 奖励物品列表
        /// </summary>
        [ProtoMember(2)]
        public List<AwardsItemData> AwardsItemDataList;

    }

    /// <summary>
    /// 狼魂领域活动龙塔内各帮派的人数列表数据
    /// </summary>
    [ProtoContract]
    public class BangHuiRoleCountData
    {
        /// <summary>
        /// 战斗结束的时间
        /// </summary>
        [ProtoMember(1)]
        public int BHID;

        /// <summary>
        /// 人数
        /// </summary>
        [ProtoMember(2)]
        public int RoleCount;
    }

    /// <summary>
    /// 狼魂领域活动各Buff拥有者列表信息
    /// </summary>
    [ProtoContract]
    public class LangHunLingYuQiZhiBuffOwnerData
    {
        /// <summary>
        /// 战斗结束的时间
        /// </summary>
        [ProtoMember(1)]
        public int NPCID;

        /// <summary>
        /// 拥有者帮会ID
        /// </summary>
        [ProtoMember(2)]
        public int OwnerBHID;

        /// <summary>
        /// 拥有者帮会名
        /// </summary>
        [ProtoMember(3)]
        public string OwnerBHName;

        /// <summary>
        /// 占有者帮会的区号
        /// </summary>
        [ProtoMember(4)]
        public int OwnerBHZoneId = 0;

    }
    /// <summary>
    /// 狼魂领域活动占领者数据
    /// </summary>
    [ProtoContract]
    public class LangHunLingYuLongTaOwnerData
    {
        /// <summary>
        /// 王城战盟名称
        /// </summary>
        [ProtoMember(1)]
        public string OwnerBHName = "";

        /// <summary>
        /// 王城战盟ID
        /// </summary>
        [ProtoMember(2)]
        public int OwnerBHid = 0;

        /// <summary>
        /// 占有者帮会的区号
        /// </summary>
        [ProtoMember(3)]
        public int OwnerBHZoneId = 0;

    }

    /// <summary>
    /// 狼魂领域活动结果和奖励信息
    /// </summary>
    [ProtoContract]
    public class LangHunLingYuResultInfo
    {
        /// <summary>
        /// 当前占领者帮会ID
        /// </summary>
        [ProtoMember(1)]
        public int BHID = 0;

        /// <summary>
        /// 当前占领者帮会名称
        /// </summary>
        [ProtoMember(2)]
        public string BHName = "";

        /// <summary>
        /// 奖励经验
        /// </summary>
        [ProtoMember(3)]
        public long ExpAward;

        /// <summary>
        /// 奖励战功
        /// </summary>
        [ProtoMember(4)]
        public int ZhanGongAward;

        /// <summary>
        /// 战盟资金
        /// </summary>
        [ProtoMember(5)]
        public int ZhanMengZiJin;
    }

    /// <summary>
    /// 狼魂领域请求信息
    /// </summary>
    [ProtoContract]
    public class LangHunLingYuRequestInfo
    {
        /// <summary>
        /// 位置
        /// </summary>
        [ProtoMember(1)]
        public int Site = 0;

        /// <summary>
        /// 当前申请的帮会ID
        /// </summary>
        [ProtoMember(2)]
        public int BHID = 0;

        /// <summary>
        /// 出价
        /// </summary>
        [ProtoMember(3)]
        public int BidMoney = 0;

        /// <summary>
        /// 帮会名称
        /// </summary>
        [ProtoMember(4)]
        public string BHName = "";
    }

    [ProtoContract]
    public class LangHunLingYuWorldData
    {
        [ProtoMember(1)]
        public List<LangHunLingYuCityData> CityList;
    }

    [ProtoContract]
    public class LangHunLingYuCityData
    {
        [ProtoMember(1)]
        public int CityId;

        [ProtoMember(2)]
        public int CityLevel;

        [ProtoMember(3)]
        public BangHuiMiniData Owner;

        [ProtoMember(4)]
        public List<BangHuiMiniData> AttackerList;
    }

    [ProtoContract]
    public class LangHunLingYuRoleData
    {
        /// <summary>
        /// 报名状态
        /// </summary>
        [ProtoMember(1)]
        public int SignUpState;

        /// <summary>
        /// 每日奖励领取状态，0表示未领取，非0表示已领取
        /// </summary>
        [ProtoMember(2)]
        public List<int> GetDayAwardsState;

        /// <summary>
        /// 自己相关的（占领或进攻）最多10个城池的列表，列表可为null，数量可能不足10个
        /// </summary>
        [ProtoMember(3)]
        public List<LangHunLingYuCityData> SelfCityList;

        /// <summary>
        /// 4个其他城池的列表
        /// </summary>
        [ProtoMember(4)]
        public List<LangHunLingYuCityData> OtherCityList;

    }

    public class LangHunLingYuBangHuiData
    {
        /// <summary>
        /// 每日奖励领取状态，0表示未领取，非0表示已领取
        /// </summary>
        [ProtoMember(1)]
        public int GetDayAwardsState;

        /// <summary>
        /// 自己相关的（占领或进攻）最多10个城池的列表，列表可为null，数量可能不足10个
        /// </summary>
        [ProtoMember(2)]
        public List<LangHunLingYuCityData> SelfCityList;

        /// <summary>
        /// 4个其他城池的列表
        /// </summary>
        [ProtoMember(3)]
        public List<LangHunLingYuCityData> OtherCityList;
    }
}
