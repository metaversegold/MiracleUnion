using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ProtoBuf;

namespace Server.Data
{
    /// <summary>
    /// 角色属性数据
    /// </summary>
    [ProtoContract]
    public class EquipPropsData
    {
        [ProtoMember(1)]
        public int RoleID = 0;

        [ProtoMember(2)]
        public double Strength = 0;

        [ProtoMember(3)]
        public double Intelligence = 0;

        [ProtoMember(4)]
        public double Dexterity = 0;

        [ProtoMember(5)]
        public double Constitution = 0;

        [ProtoMember(6)]
        public double MinAttack = 0;

        [ProtoMember(7)]
        public double MaxAttack = 0;

        [ProtoMember(8)]
        public double MinDefense = 0;

        [ProtoMember(9)]
        public double MaxDefense = 0;

        [ProtoMember(10)]
        public double MagicSkillIncrease = 0;

        [ProtoMember(11)]
        public double MinMAttack = 0;

        [ProtoMember(12)]
        public double MaxMAttack = 0;

        [ProtoMember(13)]
        public double MinMDefense = 0;

        [ProtoMember(14)]
        public double MaxMDefense = 0;

        [ProtoMember(15)]
        public double PhySkillIncrease = 0;

        [ProtoMember(16)]
        public double MaxHP = 0;

        [ProtoMember(17)]
        public double MaxMP = 0;

        [ProtoMember(18)]
        public double AttackSpeed = 0;

        [ProtoMember(19)]
        public double Hit = 0;

        [ProtoMember(20)]
        public double Dodge = 0;

        [ProtoMember(21)]
        public int TotalPropPoint = 0;

        [ProtoMember(22)]
        public int ChangeLifeCount = 0;

        [ProtoMember(23)]
        public int CombatForce = 0;

        [ProtoMember(24)]
        public int TEMPStrength = 0;

        [ProtoMember(25)]
        public int TEMPIntelligsence = 0;

        [ProtoMember(26)]
        public int TEMPDexterity = 0;

        [ProtoMember(27)]
        public int TEMPConstitution = 0;
    }
}
