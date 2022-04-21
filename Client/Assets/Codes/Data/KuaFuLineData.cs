using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ProtoBuf;

namespace Tmsk.Contract
{
    /// <summary>
    /// 线路数据
    /// </summary>
    [ProtoContract]
    public class KuaFuLineData
    {
        /// <summary>
        /// 线路ID
        /// </summary>
        [ProtoMember(1)]
        public int LineID = 0;

        /// <summary>
        /// 服务器状态
        /// </summary>
        [ProtoMember(2)]
        public int State = 0;

        /// <summary>
        /// 在线人数
        /// </summary>
        [ProtoMember(3)]
        public int OnlineCount = 0;
        
        /// <summary>
        /// 最大在线人数
        /// </summary>
        [ProtoMember(4)]
        public int MaxOnlineCount = 0;

        /// <summary>
        /// 服务器编号
        /// </summary>
        [ProtoMember(5)]
        public int ServerId;

        /// <summary>
        /// 地图编号
        /// </summary>
        [ProtoMember(6)]
        public int MapCode;
    }
}
