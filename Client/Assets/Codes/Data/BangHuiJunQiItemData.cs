using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ProtoBuf;

namespace Server.Data
{
    /// <summary>
    /// 战盟军旗项数据数据
    /// </summary>
    [ProtoContract]
    public class BangHuiJunQiItemData
    {
        /// <summary>
        /// 帮派的ID
        /// </summary>
        [ProtoMember(1)]
        public int BHID = 0;

        /// <summary>
        /// 战旗名称
        /// </summary>
        [ProtoMember(2)]
        public string QiName = "";

        /// <summary>
        /// 帮成员总的级别
        /// </summary>
        [ProtoMember(3)]
        public int QiLevel = 0;
    }
}
