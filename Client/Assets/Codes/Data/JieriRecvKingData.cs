using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ProtoBuf;

namespace Server.Data
{
    // 节日收取王活动信息
    [ProtoContract]
    public class JieriRecvKingData
    {
        [ProtoMember(1)]
        public List<JieriRecvKingItemData> RankingList;// 排行榜数据，可能为空

        [ProtoMember(2)]
        public JieriRecvKingItemData MyData;// [保留]个人收取数据，客户端可能会用到
    }

}
