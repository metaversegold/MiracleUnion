using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ProtoBuf;

namespace Server.Data
{
    [ProtoContract]
    public class SpecActInfo
    {
        // 活动ID
        [ProtoMember(1)]
        public int ActID = 0;

        // 剩余购买数量 
        [ProtoMember(2)]
        public int LeftPurNum = 0;

        // 该值代表领取领取状态（-1 未达成、0 未领取、1 已领取）
        [ProtoMember(3)]
        public int State = 0;

        // 显示信息，根据活动类型对应不的信息。
        [ProtoMember(4)]
        public int ShowNum1 = 0;

        // 显示信息，根据活动类型对应不的信息。
        [ProtoMember(5)]
        public int ShowNum2 = 0;
    }

    [ProtoContract]
    public class SpecialActivityData
    {
        // 专属组ID
        [ProtoMember(1)]
        public int GroupID = 0;

        // 专属活动信息
        [ProtoMember(2)]
        public List<SpecActInfo> SpecActInfoList;
    }
}
