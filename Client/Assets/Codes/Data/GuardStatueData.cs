using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ProtoBuf;

namespace Server.Data
{
    /// <summary>
    /// 守护之灵数据
    /// </summary>
     [ProtoContract]
    public class GuardSoulData
    {
        /// <summary>
        /// TuJianShouHuType.xml 中的Type, 表示该守护之灵对应的图鉴Type
        /// </summary>
        [ProtoMember(1, IsRequired = true)]
        public int type = 0;

        /// <summary>
        /// 装备的栏位, -1表示该守护之灵未装备, >=0 表示装备的栏位id
        /// </summary>
        [ProtoMember(2, IsRequired = true)]
        public int equipSlot = -1;

        public string ToString()
        {
            return ("type, " + type + ", " + "equipSlot, " + equipSlot); 
        }
    }

     /// <summary>
     /// 守护雕像数据
     /// </summary>
     [ProtoContract]
    public class GuardStatueData
    {
        /// <summary>
        /// 等级
        /// </summary>
        [ProtoMember(1, IsRequired = true)]
        public int level = 0;

        /// <summary>
        /// 品阶
        /// </summary>
        [ProtoMember(2, IsRequired = true)]
        public int grade = 0;

        /// <summary>
        /// 拥有的守护点
        /// </summary>
        [ProtoMember(3, IsRequired = true)]
        public int hasGuardPoint = 0;

        /// <summary>
        /// 已激动的所有守护之灵
        /// </summary>
        [ProtoMember(4, IsRequired = true)]
        public List<GuardSoulData> soulGuardList = new List<GuardSoulData>();

        public string ToString() 
        {
            return ("level, " + level + ", " + "grade, " + grade + ", " +
                    "hasGuardPoint, " + hasGuardPoint + ", " + "activetedSouls, " + SoulGuardListToString()
                );
        }

        private string SoulGuardListToString()
        {
            string listStr = "";

            for (int i = 0; i < soulGuardList.Count; i++)
            {
                GuardSoulData soulGuard = soulGuardList[i];

                if(null != soulGuard)
                {
                    listStr += soulGuard.ToString();
                }
            }

            return listStr;
        }

    }
}