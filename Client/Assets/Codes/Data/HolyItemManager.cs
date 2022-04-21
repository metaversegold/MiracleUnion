using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ProtoBuf;


namespace Server.Data
{
    //圣物部件类
    [ProtoContract]
    public class HolyItemPartData
    {
        //圣物部件阶级 目前最高有10阶
        [ProtoMember(1)]
        public sbyte m_sSuit = 0;

        //部件碎片
        [ProtoMember(2)]
        public int m_nSlice = 0;
    }

    //圣物数据类
    [ProtoContract]
    public class HolyItemData
    {
        //圣物类型 目前有4个类型 1 == 黄金圣杯 2 == 黄金圣冠 3 == 黄金圣剑 4 == 黄金圣典
        [ProtoMember(1)]
        public sbyte m_sType = 0;

        //圣物部件 目前有6个部件
        [ProtoMember(2)]
        public Dictionary<sbyte, HolyItemPartData> m_PartArray = null;

        //public Dictionary<sbyte, HolyItemPartData> m_PartArray = new Dictionary<sbyte, HolyItemPartData>();
    }
    

}
