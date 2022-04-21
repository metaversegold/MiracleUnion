using System.Collections.Generic;
using ProtoBuf;

namespace Server.Data
{
    //罗兰法阵传送门数据
    [ProtoContract]
    public class FazhenTelegateProtoData
    {
        [ProtoMember(1)]
        public int gateId = 0;  //传送门编号，1~5
        [ProtoMember(2)]
        public int DestMapCode = 0; //传到哪个地图，0为未知
    }
}
