using System;
using System.Collections;
using System.Collections.Generic;
using Server.Data;

using ProtoBuf;


namespace HSGameEngine.GameFramework.Logic
{
//CMD_SPR_COPY_WOLF_SCORE_INFO = 1025,//狼魂要塞——得分信息
//方式：服务器=》客户端
//参数：CopyWolfScoreData

//CMD_SPR_COPY_WOLF_AWARD      = 1026,//狼魂要塞——领奖信息
//方式：服务器=》客户端
//参数：CopyWolfAwardsData

    /// <summary>
    /// 成绩信息
    /// </summary>
    [ProtoContract]
    public class CopyWolfScoreData
    {
        /// <summary>
        /// 波次
        /// </summary>
        [ProtoMember(1)]
        public int Wave = 0;

        /// <summary>
        ///  结束时间
        /// </summary>
        [ProtoMember(2)]
        public long EndTime = 0;

        /// <summary>
        /// 要塞生命
        /// </summary>
        [ProtoMember(3)]
        public int FortLifeNow = 0;

        /// <summary>
        /// 要塞生命（最大）
        /// </summary>
        [ProtoMember(4)]
        public int FortLifeMax = 0;

        /// <summary>
        /// 积分（角色id，分数）
        /// </summary>
        [ProtoMember(5)]
        public Dictionary<int , int> RoleMonsterScore = new Dictionary<int , int>();

        /// <summary>
        /// 剩余怪物数量
        /// </summary>
        [ProtoMember(6)]
        public int MonsterCount = 0;
    }

    /// <summary>
    /// 领奖信息
    /// </summary>
    [ProtoContract]
    public class CopyWolfAwardsData
    {
        /// <summary>
        /// 经验
        /// </summary>
        [ProtoMember(1)]
        public long Exp;

        /// <summary>
        /// 金钱
        /// </summary>
        [ProtoMember(2)]
        public int Money;

        /// <summary>
        /// 狼魂粉末
        /// </summary>
        [ProtoMember(3)]
        public int WolfMoney;

        /// <summary>
        /// 波数
        /// </summary>
        [ProtoMember(4)]
        public int Wave;

        /// <summary>
        /// 积分（角色id，分数）
        /// </summary>
        [ProtoMember(5)]
        public int RoleScore = 0;
    }
}