using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ProtoBuf;
using Tmsk.Contract;

namespace Server.Data
{
    /// <summary>
    /// 精灵移动数据封装类
    /// </summary>
    [ProtoContract]
    public class SpriteMoveData : IProtoBuffData
    {
        [ProtoMember(1)]
        public int roleID = 0;

        [ProtoMember(2)]
        public int mapCode = 0;

        [ProtoMember(3)]
        public int action = 0;

        [ProtoMember(4)]
        public int toX = 0;

        [ProtoMember(5)]
        public int toY = 0;

        [ProtoMember(6)]
        public int extAction = 0;

        [ProtoMember(7)]
        public int fromX = 0;

        [ProtoMember(8)]
        public int fromY = 0;

        [ProtoMember(9)]
        public long startMoveTicks = 0;

        [ProtoMember(10)]
        public string pathString = "";

        public SpriteMoveData() { }

        public SpriteMoveData(int roleID, int mapCode, int action, int toX, int toY, int extAction, int fromX, int fromY, long startMoveTicks, string pathString)
        {
            this.roleID = roleID;
            this.mapCode = mapCode;
            this.action = action;
            this.toX = toX;
            this.toY = toY;
            this.extAction = extAction;
            this.fromX = fromX;
            this.fromY = fromY;
            this.startMoveTicks = startMoveTicks;
            this.pathString = pathString;
        }

//         public static SpriteMoveData getInstance(int roleID, int mapCode, int action, int toX, int toY, int extAction, int fromX, int fromY, long startMoveTicks, string pathString)
//         {
//             instance.roleID = roleID;
//             instance.mapCode = mapCode;
//             instance.action = action;
//             instance.toX = toX;
//             instance.toY = toY;
//             instance.extAction = extAction;
//             instance.fromX = fromX;
//             instance.fromY = fromY;
//             instance.startMoveTicks = startMoveTicks;
//             instance.pathString = pathString;
//             return instance;
//         }

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
                    case 1: this.roleID = ProtoUtil.IntMemberFromBytes(data, wt, ref pos, ref mycount); break;
                    case 2: this.mapCode = ProtoUtil.IntMemberFromBytes(data, wt, ref pos, ref mycount); break;
                    case 3: this.action = ProtoUtil.IntMemberFromBytes(data, wt, ref pos, ref mycount); break;
                    case 4: this.toX = ProtoUtil.IntMemberFromBytes(data, wt, ref pos, ref mycount); break;
                    case 5: this.toY = ProtoUtil.IntMemberFromBytes(data, wt, ref pos, ref mycount); break;
                    case 6: this.extAction = ProtoUtil.IntMemberFromBytes(data, wt, ref pos, ref mycount); break;
                    case 7: this.fromX = ProtoUtil.IntMemberFromBytes(data, wt, ref pos, ref mycount); break;
                    case 8: this.fromY = ProtoUtil.IntMemberFromBytes(data, wt, ref pos, ref mycount); break;
                    case 9: this.startMoveTicks = ProtoUtil.LongMemberFromBytes(data, wt, ref pos, ref mycount); break;
                    case 10: this.pathString = ProtoUtil.StringMemberFromBytes(data, wt, ref pos, ref mycount); break;
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
            total += ProtoUtil.GetIntSize(roleID, true, 1);
            total += ProtoUtil.GetIntSize(mapCode, true, 2);
            total += ProtoUtil.GetIntSize(action, true, 3);
            total += ProtoUtil.GetIntSize(toX, true, 4);
            total += ProtoUtil.GetIntSize(toY, true, 5);
            total += ProtoUtil.GetIntSize(extAction, true, 6);
            total += ProtoUtil.GetIntSize(fromX, true, 7);
            total += ProtoUtil.GetIntSize(fromY, true, 8);
            total += ProtoUtil.GetLongSize(startMoveTicks, true, 9);
            total += ProtoUtil.GetStringSize(pathString, true, 10);
            byte[] data = new byte[total];
            int offset = 0;

            ProtoUtil.IntMemberToBytes(data, 1, ref offset, roleID);
            ProtoUtil.IntMemberToBytes(data, 2, ref offset, mapCode);
            ProtoUtil.IntMemberToBytes(data, 3, ref offset, action);
            ProtoUtil.IntMemberToBytes(data, 4, ref offset, toX);
            ProtoUtil.IntMemberToBytes(data, 5, ref offset, toY);
            ProtoUtil.IntMemberToBytes(data, 6, ref offset, extAction);
            ProtoUtil.IntMemberToBytes(data, 7, ref offset, fromX);
            ProtoUtil.IntMemberToBytes(data, 8, ref offset, fromY);
            ProtoUtil.LongMemberToBytes(data, 9, ref offset, startMoveTicks);
            ProtoUtil.StringMemberToBytes(data, 10, ref offset, pathString);

            return data;
        }
    }
}
