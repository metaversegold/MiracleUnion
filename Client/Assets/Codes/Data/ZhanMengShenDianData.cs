using System.Collections.Generic;
using ProtoBuf;
using System;
namespace Server.Data
{
    [ProtoContract]
    public class UnionPalaceData
    {
        //角色id
        [ProtoMember(1)]
        public int RoleID = 0;
        //守护id
        [ProtoMember(2)]
        public int StatueID = 0;
        //守护等级
        [ProtoMember(3)]
        public int StatueLevel = 0;
        //生命上限
        [ProtoMember(4)]
        public int LifeAdd = 0;
        //攻击
        [ProtoMember(5)]
        public int AttackAdd = 0;
        //防御
        [ProtoMember(6)]
        public int DefenseAdd = 0;
        //伤害加成
        [ProtoMember(7)]
        public int AttackInjureAdd = 0;
        //需要战功
        [ProtoMember(8)]
        public int ZhanGongNeed = 0;
        //暴击类型 0=无，1=暴击，2=完美暴击
        [ProtoMember(9)]
        public int BurstType = 0;
        //操作类型
        [ProtoMember(10)]
        public int ResultType = 0;
        //剩余战功
        [ProtoMember(11)]
        public int ZhanGongLeft = 0;
        //战盟等级
        [ProtoMember(12)]
        public int UnionLevel = 0;
        //守护类型
        [ProtoMember(13)]
        public int StatueType = 0;
    }

    public enum EUnionPalaceState
    {
        EUionMore = -8,     //战盟等级不足，不能提升
        EPalaceMore = -7,   //战盟等级<现在等级
        Efail = -6,         //失败
        ENoUnion = -5,      //没有加入联盟
        EOver = -4,         //全部开启
        EnoZhanGong = -3,   //战功不足
        ENoHave = -2,       //没有加入战盟
        EnoOpen = -1,       //未开放
        Default = 0,        //
        Success = 1,        //成功，未生效 
        Next = 2,           //成功，开启下一个
        End = 3,            //提升达到极限
        PalaceMore = 4,      //战盟等级<现在等级
        UnionNeedUp = 5,    //战盟等级不足，不能提升

    }

}
