using System.Collections.Generic;
using ProtoBuf;

namespace Server.Data
{
    /// <summary>
    /// 万魔塔扫荡数据
    /// </summary>
    [ProtoContract]
    public class LayerSweepData 
    {
        /// <summary>
        /// 层编号
        /// </summary>
        [ProtoMember(1)]
        public int nLayerOrder = 0;

        /// <summary>
        /// 经验
        /// </summary>
        [ProtoMember(2)]
        public int nExp = 0;

        /// <summary>
        /// 金币
        /// </summary>
        [ProtoMember(3)]
        public int nMoney = 0;

        /// <summary>
        /// 星魂
        /// </summary>
        [ProtoMember(4)]
        public int nXinHun = 0;

        /// <summary>
        /// 奖励
        /// </summary>
        [ProtoMember(5)]
        public List<GoodsData> GoodsList = null;

    }
}
