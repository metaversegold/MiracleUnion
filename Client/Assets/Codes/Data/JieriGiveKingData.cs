using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ProtoBuf;

namespace Server.Data
{
    // 节日赠送王活动信息
    [ProtoContract]
    public class JieriGiveKingData
    {
        [ProtoMember(1)]
        public List<JieriGiveKingItemData> RankingList;// 排行榜数据，可能为空
    
        [ProtoMember(2)]
        public JieriGiveKingItemData MyData;// [保留]个人赠送数据，客户端可能会用到

    }

}
