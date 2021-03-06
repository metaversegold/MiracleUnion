using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ProtoBuf;
using Tmsk.Contract;

namespace Server.Data
{
    /// <summary>
    /// 玩家动作数据封装类
    /// </summary>
    [ProtoContract]
    public class CS_SprUseGoods : IProtoBuffData
    {
        // 角色id
        [ProtoMember(1)]
        public int RoleId = 0;

        // 物品dbId
        [ProtoMember(2)]
        public int DbId = 0;

        // 物品类型Id
        [ProtoMember(3)]
        public int GoodsId = 0;

        // 使用个数
        [ProtoMember(4)]
        public int UseNum = 0;

        public int fromBytes(byte[] data, int offset, int count)
        {
            int pos = offset;
            int mycount = 0;

            for (; mycount < count; )
            {
                int fieldnumber = -1;
                int wt = -1;
                ProtoUtil.GetTag(data, ref pos, ref fieldnumber, ref wt, ref mycount);

                switch (fieldnumber)
                {
                    case 1: this.RoleId = ProtoUtil.IntMemberFromBytes(data, wt, ref pos, ref mycount); break;
                    case 2: this.DbId = ProtoUtil.IntMemberFromBytes(data, wt, ref pos, ref mycount); break;
                    case 3: this.GoodsId = ProtoUtil.IntMemberFromBytes(data, wt, ref pos, ref mycount); break;
                    case 4: this.UseNum = ProtoUtil.IntMemberFromBytes(data, wt, ref pos, ref mycount); break;
                    default:
                        {
                            throw new ArgumentException("error!!!");
                        }
                }
            }
            return pos;
        }

        public byte[] toBytes()
        {
            int total = 0;
            total += ProtoUtil.GetIntSize(this.RoleId, true, 1);
            total += ProtoUtil.GetIntSize(this.DbId, true, 2);
            total += ProtoUtil.GetIntSize(this.GoodsId, true, 3);
            total += ProtoUtil.GetIntSize(this.UseNum, true, 4);
            
            byte[] data = new byte[total];
            int offset = 0;

            ProtoUtil.IntMemberToBytes(data, 1, ref offset, this.RoleId);
            ProtoUtil.IntMemberToBytes(data, 2, ref offset, this.DbId);
            ProtoUtil.IntMemberToBytes(data, 3, ref offset, this.GoodsId);
            ProtoUtil.IntMemberToBytes(data, 4, ref offset, this.UseNum);

            return data;
        }
    }
}