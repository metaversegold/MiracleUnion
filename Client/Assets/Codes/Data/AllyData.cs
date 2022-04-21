using System;
using System.Net;
using System.Collections.Generic;
using ProtoBuf;
using System.Runtime.Serialization.Formatters.Binary;
using System.Runtime.Serialization;
using System.IO;

namespace Server.Data
{
    /// <summary>
    /// 我的盟友和盟友请求数据
    /// </summary>
    [ProtoContract]
    public class AllyData
    {
        /// <summary>
        /// 战盟ID
        /// </summary>
        [ProtoMember(1)]
        public int UnionID = 0;

        /// <summary>
        /// 战盟所在服务器ID
        /// </summary>
        [ProtoMember(2)]
        public int UnionZoneID = 0;

        /// <summary>
        /// 战盟名字
        /// </summary>
        [ProtoMember(3)]
        public string UnionName = "";

        /// <summary>
        /// 战盟等级
        /// </summary>
        [ProtoMember(4)]
        public int UnionLevel = 0;

        /// <summary>
        /// 战盟成员数量
        /// </summary>
        [ProtoMember(5)]
        public int UnionNum = 0;

        /// <summary>
        /// 战盟首领ID
        /// </summary>
        [ProtoMember(6)]
        public int LeaderID = 0;

        /// <summary>
        /// 首领所在服务器ID
        /// </summary>
        [ProtoMember(7)]
        public int LeaderZoneID = 0;

        /// <summary>
        /// 战盟首领名字
        /// </summary>
        [ProtoMember(8)]
        public string LeaderName = "";

        /// <summary>
        /// 时间
        /// </summary>
        [ProtoMember(9)]
        public DateTime LogTime = DateTime.MinValue;

        /// <summary>
        /// 结盟状态
        /// </summary>
        [ProtoMember(10)]
        public int LogState = 0;
    }
}
