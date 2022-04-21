using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ProtoBuf;

namespace Server.Data
{
    /// <summary>
    /// 摆摊日志项
    /// </summary>
    [ProtoContract]
	public class BaiTanLogItemData
	{
        /// <summary>
        /// 摊主的角色ID
        /// </summary>
        [ProtoMember(1)]
        public int rid = 0;

        /// <summary>
        /// 购买者的角色ID
        /// </summary>
        [ProtoMember(2)]
        public int OtherRoleID = 0;

        /// <summary>
        /// 购买者的角色名称
        /// </summary>
        [ProtoMember(3)]
        public string OtherRName = "";

        /// <summary>
        /// 物品ID
        /// </summary>
        [ProtoMember(4)]
        public int GoodsID = 0;

        /// <summary>
        /// 物品数量
        /// </summary>
        [ProtoMember(5)]
        public int GoodsNum = 0;

        /// <summary>
        /// 物品强化级别
        /// </summary>
        [ProtoMember(6)]
        public int ForgeLevel = 0;

        /// <summary>
        /// 物品钻石价格
        /// </summary>
        [ProtoMember(7)]
        public int TotalPrice = 0;

        /// <summary>
        /// 剩余钻石
        /// </summary>
        [ProtoMember(8)]
        public int LeftYuanBao = 0;

        /// <summary>
        /// 事件时间
        /// </summary>
        [ProtoMember(9)]
        public string BuyTime = "";

        /// <summary>
        /// 物品非绑定金币价格
        /// </summary>
        [ProtoMember(10)]
        public int YinLiang = 0;

        /// <summary>
        /// 剩余金币
        /// </summary>
        [ProtoMember(11)]
        public int LeftYinLiang = 0;
        /// <summary>
        /// 交易税
        /// </summary>
        [ProtoMember(12)]
        public int Tax = 0;

        /// <summary>
        /// 卓越属性
        /// </summary>
        [ProtoMember(13)]
        public int Excellenceinfo = 0;
    }
}
