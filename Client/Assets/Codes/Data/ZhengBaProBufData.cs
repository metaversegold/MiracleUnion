using System.Collections.Generic;
using ProtoBuf;
using System;

namespace Server.Data
{
    /// 众神争霸---主界面信息
    /// </summary>
    [ProtoContract]
    public class ZhengBaMainInfoData
    {
        /// <summary>
        /// 考虑到服务器维护导致活动推移的情况，
        /// 此字段表示实际进行到活动的第几天
        /// </summary>
        [ProtoMember(1)]
        public int RealActDay;

        /// <summary>
        /// 16强列表
        /// </summary>
        [ProtoMember(2)]
        public List<TianTiPaiHangRoleData> Top16List;

        /// <summary>
        /// 当前获得赞最多 [1--16]才有效
        /// </summary>
        [ProtoMember(3)]
        public int MaxSupportGroup;

        /// <summary>
        /// 当前获得贬最多 [1--16]才有效
        /// </summary>
        [ProtoMember(4)]
        public int MaxOpposeGroup;

        /// <summary>
        /// 可以领取的奖励Id [1--8有效]
        /// 参考MatchAward.xml的Id字段
        /// </summary>
        [ProtoMember(5)]
        public int CanGetAwardId;

        /// <summary>
        /// 当前是第几天的战斗结果
        /// </summary>
        [ProtoMember(6)]
        public int RankResultOfDay;

    }

    /// <summary>
    /// 众神争霸---pk日志
    /// 根据策划案文档，只记录有参赛方胜利或者晋级的pk日志
    /// </summary>
    [ProtoContract]
    public class ZhengBaPkLogData
    {
        /// <summary>
        /// 第几天活动的战斗日志，用于可以短根据Match.xml显示战斗名字
        /// Day="1" Name="100进64"
        /// Day="2" Name="64进32"
        /// ...
        /// </summary>
        [ProtoMember(1)]
        public int Day;
        [ProtoMember(2)]
        public int RoleID1;
        [ProtoMember(3)]
        public int ZoneID1;
        [ProtoMember(4)]
        public string RoleName1;
        [ProtoMember(5)]
        public int RoleID2;
        [ProtoMember(6)]
        public int ZoneID2;
        [ProtoMember(7)]
        public string RoleName2;

        /// <summary>
        /// 参考EZhengBaPKResult
        /// EZhengBaPKResult.Win ===> RoleID1 胜利
        /// EZhengBaPKResult.Fail ===> RoleID2 胜利
        /// EZhengBaPKResult.Invalid ===> pk异常，服务器专用
        /// </summary>
        [ProtoMember(8)]
        public int PkResult;
        /// <summary>
        /// 只有PkResult == Win，该字段才有效，表示胜方是否晋级
        /// </summary>
        [ProtoMember(9)]
        public bool UpGrade;

        // 以下字段为服务器需要
        [ProtoMember(10)]
        public int Month;
        [ProtoMember(11)]
        public bool IsMirror1;
        [ProtoMember(12)]
        public bool IsMirror2;
        [ProtoMember(13)]
        public DateTime StartTime;
        [ProtoMember(14)]
        public DateTime EndTime;

    }

    public enum EZhengBaPKResult
    {
        invalid = 0,   //异常
        Win = 1,    // 胜利
        Fail = 2,    //失败
    }
    /// <summary>
    /// 众神争霸---支持日志
    /// 赞、贬、押注，只用于前16强选手
    /// </summary>
    [ProtoContract]
    public class ZhengBaSupportLog
    {
        /// <summary>
        /// 操作者角色ID
        /// </summary>
        [ProtoMember(1)]
        public int FromRoleID;

        /// <summary>
        /// 操作者Zone
        /// </summary>
        [ProtoMember(2)]
        public int FromZoneID;

        /// <summary>
        /// 操作者角色名
        /// </summary>
        [ProtoMember(3)]
        public string FromRoleName;

        /// <summary>
        /// 操作类型，赞、贬、押注，参考EZhengBaSupport
        /// </summary>
        [ProtoMember(4)]
        public int SupportType;

        /// <summary>
        /// 操作的目标group组合
        /// </summary>
        [ProtoMember(5)]
        public int ToUnionGroup;

        /// <summary>
        /// 操作的目标group
        /// </summary>
        [ProtoMember(6)]
        public int ToGroup;

        /// <summary>
        /// 操作时间
        /// </summary>
        [ProtoMember(7)]
        public DateTime Time;
    }

    /// <summary>
    /// 众神争霸---16强赞、贬、押注统计数据
    /// </summary>
    [ProtoContract]
    public class ZhengBaSupportAnalysisData
    {
        /// <summary>
        /// group组合, 由该group组合可以唯一标识两个16强玩家
        /// </summary>
        [ProtoMember(1)]
        public int UnionGroup;
      
        /// <summary>
        /// group，可以标识出一个特定的16强玩家
        /// </summary>
        [ProtoMember(2)]
        public int Group;

        /// <summary>
        /// 总计赞数数
        /// </summary>
        [ProtoMember(3)]
        public int TotalSupport;

        /// <summary>
        /// 总计贬数
        /// </summary>
        [ProtoMember(4)]
        public int TotalOppose;

        /// <summary>
        /// 总计押注数
        /// </summary>
        [ProtoMember(5)]
        public int TotalYaZhu;
    }

    /// <summary>
    /// 众神争霸---16强pk组数据
    /// </summary>
    [ProtoContract]
    public class ZhengBaUnionGroupData
    {
        /// <summary>
        /// group组， 由该group组合可以唯一标识两个16强玩家
        /// </summary>
        [ProtoMember(1)]
        public int UnionGroup;

        /// <summary>
        /// pk组内玩家的赞、贬、押注统计数据
        /// </summary>
        [ProtoMember(2)]
        public List<ZhengBaSupportAnalysisData> SupportDatas;

        /// <summary>
        /// pk组的支持日志
        /// </summary>
        [ProtoMember(3)]
        public List<ZhengBaSupportLog> SupportLogs;

        /// <summary>
        /// pk组内我的赞、贬、押注信息
        /// </summary>
        [ProtoMember(4)]
        public List<ZhengBaSupportFlagData> SupportFlags;

        /// <summary>
        /// 押注胜利能获得的争霸点
        /// </summary>
        [ProtoMember(5)]
        public int WinZhengBaPoint;

    }

    /// <summary>
    /// 众神争霸---我的赞、贬、押注标记
    /// </summary>
    [ProtoContract]
    public class ZhengBaSupportFlagData
    {
        /// <summary>
        /// group组， 由该group组合可以唯一标识两个16强玩家
        /// </summary>
        [ProtoMember(1)]
        public int UnionGroup;

        /// <summary>
        /// group，可以标识出一个特定的16强玩家
        /// </summary>
        [ProtoMember(2)]
        public int Group;

        /// <summary>
        /// 是否已赞
        /// </summary>
        [ProtoMember(3)]
        public bool IsOppose;

        /// <summary>
        /// 是否已贬
        /// </summary>
        [ProtoMember(4)]
        public bool IsSupport;

        /// <summary>
        /// 是否已押注
        /// </summary>
        [ProtoMember(5)]
        public bool IsYaZhu;
    }

    /// <summary>
    /// 众神争霸 --- 通知客户端pk结果
    /// </summary>
    [ProtoContract]
    public class ZhengBaNtfPkResultData
    {
        [ProtoMember(1)]
        public int RoleID;
        /// <summary>
        /// [1---16]表示有效，如果有效，客户端出现假的“随机编号”的按钮
        /// </summary>
        [ProtoMember(2)]
        public int RandGroup;
        /// <summary>
        /// 仍然还需要胜利几场才能晋级
        /// </summary>
        [ProtoMember(3)]
        public int StillNeedWin;
        /// <summary>
        /// 剩余还有几个晋级名额
        /// </summary>
        [ProtoMember(4)]
        public int LeftUpGradeNum;
        /// <summary>
        /// 是否胜利
        /// </summary>
        [ProtoMember(5)]
        public bool IsWin;
        /// <summary>
        /// 是否晋级
        /// </summary>
        [ProtoMember(6)]
        public bool IsUpGrade;
        /// <summary>
        /// 如果晋级，那么新的EZhengBaGrade
        /// </summary>
        [ProtoMember(7)]
        public int NewGrade;
    }

    /// <summary>
    /// 争霸倒计时状态
    /// </summary>
    [ProtoContract]
    [Serializable]
    public class ZhengBaMiniStateData
    {
        /// <summary>
        /// 如果该值 > 0, 表示距离活动开始剩余秒数
        /// </summary>
        [ProtoMember(1)]
        public long PkStartWaitSec;
        /// <summary>
        /// 如果该值 > 0, 表示距离下轮开始剩余秒数
        /// </summary>
        [ProtoMember(2)]
        public long NextLoopWaitSec;
        /// <summary>
        /// 如果该值 > 0, 表示距离本轮结束剩余秒数
        /// </summary>
        [ProtoMember(3)]
        public long LoopEndWaitSec;

        /// <summary>
        /// 争霸赛是否开启
        /// </summary>
        [ProtoMember(4, IsRequired = true)]
        public bool IsZhengBaOpened;

        /// <summary>
        /// 本月是否举行
        /// </summary>
        [ProtoMember(5, IsRequired = true)]
        public bool IsThisMonthInActivity;

    }

}
