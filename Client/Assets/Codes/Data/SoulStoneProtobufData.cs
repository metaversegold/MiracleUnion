using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ProtoBuf;

namespace Server.Data
{
    /// <summary>
    /// "魂石获取"额外功能
    /// </summary>
    [ProtoContract]
    public class SoulStoneExtFuncItem
    {
        // 功能类型
        [ProtoMember(1)]
        public int FuncType;

        // 消耗类型
        [ProtoMember(2)]
        public int CostType;
    }

    /// <summary>
    /// "魂石获取" 随机信息查询
    /// </summary>
    [ProtoContract]
    public class SoulStoneQueryGetData
    {
        [ProtoMember(1)]
        public int CurrRandId;

        [ProtoMember(2)]
        public List<SoulStoneExtFuncItem> ExtFuncList;
    }

    /// <summary>
    /// 魂石数据
    /// </summary>
    [ProtoContract]
    public class SoulStoneData
    {
        // 魂石背包栏
        [ProtoMember(1)]
        public List<GoodsData> StonesInBag;

        // 魂石装备栏
        [ProtoMember(2)]
        public List<GoodsData> StonesInUsing;
    }

    /// <summary>
    /// 获取魂石
    /// </summary>
    [ProtoContract]
    public class SoulStoneGetData
    {
        [ProtoMember(1)]
        public int Error;

        // 客户端请求进行的次数
        [ProtoMember(2)]
        public int RequestTimes;

        // 实际进行的次数
        [ProtoMember(3)]
        public int RealDoTimes;

        // 最终的随机组ID
        [ProtoMember(4)]
        public int NewRandId;

        [ProtoMember(5)]
        public List<int> Stones;

        // 额外获得物品
        [ProtoMember(6)]
        public List<int> ExtGoods;
    }

    /// <summary>
    /// 魂石错误码
    /// </summary>
    public enum ESoulStoneErrorCode
    {
        Success = 0, //成功，其余全失败
        UnknownFailed, // 未知错误
        VisitParamsError, // 客户端访问参数错误
        SelectExtFuncNotOpen, // 选择的额外功能未开启
        ConfigError, // 配置文件错误
        LangHunFenMoNotEnough, // 狼魂粉末不足
        ExtCostNotEnough, // 额外消耗不足
        BagNoSpace, // 背包不足
        LevelIsFull, // 等级已满
        CanNotEquip, // 不可装备
        DbFailed, // 数据库错误
        NotOpen, // 功能未开启
    }

    //聚魂额外功能类型
    public enum ESoulStoneExtFuncType
    {
        NULL = 0,
        AddedGoods = 1, // 获得额外道具
        ReduceLangHunFenMo = 2, //减少狼魂粉末消耗
        UpSuccessRate = 3, //提高成功几率
        HoldTypeIfFail = 4, //聚魂失败锁定跳转
    }

    //聚魂额外功能消耗类型
    public enum ESoulStoneExtCostType
    {
        NULL = 0,
        MoJing = 1,
        XingHun = 2,
        ChengJiu = 3,
        ShengWang = 4,
        ZuanShi = 5,
    }
}
