using System.Collections.Generic;
using ProtoBuf;
using System;

namespace Server.Data
{
     /// <summary>
    /// 基金数据
    /// </summary>
    [ProtoContract]
    public class FundData
    {     
        [ProtoMember(1, IsRequired = true)]
        public bool IsOpen = false;

        /// <summary>
        /// 操作状态，0默认，1成功，<1操作失败
        /// </summary>
        [ProtoMember(2, IsRequired = true)]
        public int State = 0;

        /// <summary>
        /// 操作基金类型
        /// </summary>
        [ProtoMember(3, IsRequired = true)]
        public int FundType = 0;

        /// <summary>
        /// 基金类型，基金数据
        /// </summary>
        [ProtoMember(4, IsRequired = true)]
        public Dictionary<int, FundItem> FundDic = new Dictionary<int, FundItem>();
    }

    /// <summary>
    /// 基金项
    /// </summary>
    [ProtoContract]
    public class FundItem
    {
        /// <summary>   
        /// 基金类型
        /// </summary>
        [ProtoMember(1, IsRequired = true)]
        public int FundType = 0;

        /// <summary>
        /// 购买状态
        /// </summary>
        [ProtoMember(2, IsRequired = true)]
        public int BuyType = 0;

        /// <summary>
        /// 购买日期
        /// </summary>
        [ProtoMember(3, IsRequired = true)]
        public DateTime BuyTime = DateTime.MinValue;

        /// <summary>
        /// 基金id
        /// </summary>
        [ProtoMember(4, IsRequired = true)]
        public int FundID = 0;

        /// <summary>
        /// 奖励id
        /// </summary>
        [ProtoMember(5, IsRequired = true)]
        public int AwardID = 0;

        /// <summary>
        /// 奖励领取状态
        /// </summary>
        [ProtoMember(6, IsRequired = true)]
        public int AwardType = 0;

        /// <summary>
        /// 基金数据1
        /// </summary>
        [ProtoMember(7, IsRequired = true)]
        public int Value1 = 0;

        /// <summary>
        /// 基金数据2
        /// </summary>
        [ProtoMember(8, IsRequired = true)]
        public int Value2 = 0;
    }


}

