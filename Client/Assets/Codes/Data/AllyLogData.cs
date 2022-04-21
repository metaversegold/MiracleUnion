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
    /// 战盟外交日志
    /// </summary>
    [ProtoContract]
    public class AllyLogData
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
        /// 自身战盟ID
        /// </summary>
        [ProtoMember(4)]
        public int MyUnionID = 0;

        /// <summary>
        /// 时间
        /// </summary>
        [ProtoMember(5)]
        public DateTime LogTime = DateTime.MinValue;

        /// <summary>
        /// 结盟状态
        /// </summary>
        [ProtoMember(6)]
        public int LogState = 0;
    }
}
