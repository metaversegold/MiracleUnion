using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ProtoBuf;

namespace Server.Data
{
    /// <summary>
    /// 结婚数据
    /// </summary>
    [ProtoContract]
    public class MarriageData_EX
    {
        /// <summary>
        /// 结婚数据
        /// </summary>
        [ProtoMember(1)]
        public MarriageData myMarriageData = null;

        /// <summary>
        /// 玩家名称
        /// </summary>
        [ProtoMember(2)]
        public string roleName;

        /// <summary>
        /// 角色职业
        /// </summary>
        [ProtoMember(3)]
        public int occupationId = 0;
    }
}
