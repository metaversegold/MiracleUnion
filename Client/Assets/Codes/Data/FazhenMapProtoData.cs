using System.Collections.Generic;
using ProtoBuf;

namespace Server.Data
{
    //罗兰法阵地图数据
    [ProtoContract]
    public class FazhenMapProtoData
    {
        [ProtoMember(1)]
        public int SrcMapCode = 0;                                     //传送门所在地图编号
        [ProtoMember(2)]
        public List<FazhenTelegateProtoData> listTelegate = null;       //传送门数据
    }
}
