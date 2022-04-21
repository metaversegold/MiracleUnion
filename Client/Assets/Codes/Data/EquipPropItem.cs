using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;


namespace Assets.Plugins.Scripts.Server.Data
{
    /// <summary>
    /// 扩展属性索引值
    /// </summary>
    public enum ExtPropIndexes
    {
        Strong = 0,       // 耐久
        AttackSpeed = 1,       // 攻击速度
        MoveSpeed = 2,       // 移动速度
        MinDefense = 3,       // 最小物防	
        MaxDefense = 4,       // 最大物防	
        MinMDefense = 5,       // 最小魔防	
        MaxMDefense = 6,       // 最大魔防	
        MinAttack = 7,       // 最小物攻	
        MaxAttack = 8,       // 最大物攻	
        MinMAttack = 9,       // 最小魔攻	
        MaxMAttack = 10,      // 最大魔攻
        IncreasePhyAttack = 11,         // 物理攻击提升(百分比)	
        IncreaseMagAttack = 12,         // 魔法攻击提升(百分比)	
        MaxLifeV = 13,      // 生命上限	
        MaxLifePercent = 14,      // 生命上限加成比例(百分比)	
        MaxMagicV = 15,      // 魔法上限
        MaxMagicPercent = 16,      // 魔法上限加成比例(百分比)
        Lucky = 17,      // 幸运
        HitV = 18,      // 准确	
        Dodge = 19,      // 闪避
        LifeRecoverPercent = 20,      // 生命恢复(百分比)
        MagicRecoverPercent = 21,      // 魔法恢复(百分比)
        LifeRecover = 22,      // 单位时间恢复的生命恢复(固定值)
        MagicRecover = 23,      // 单位时间恢复的魔法恢复(固定值)
        SubAttackInjurePercent = 24,     // 伤害吸收魔法/物理(百分比)
        SubAttackInjure = 25,      // 伤害吸收魔法/物理(固定值)
        AddAttackInjurePercent = 26,     // 伤害加成魔法/物理(百分比)
        AddAttackInjure = 27,      // 伤害加成魔法/物理(固定值)
        IgnoreDefensePercent = 28,      // 无视攻击对象的物理/魔法防御(概率)
        DamageThornPercent = 29,      // 伤害反弹(百分比)
        DamageThorn = 30,      // 伤害反弹(固定值)
        PhySkillIncreasePercent = 31,    // 物理技能增幅(百分比)
        PhySkillIncrease = 32,      // 物理技能增幅(固定值)    
        MagicSkillIncreasePercent = 33,  // 魔法技能增幅(百分比)
        MagicSkillIncrease = 34,      // 魔法技能增幅(固定值)
        FatalAttack = 35,      // 卓越一击
        DoubleAttack = 36,      // 双倍一击
        DecreaseInjurePercent = 37,     // 伤害减少百分比(物理、魔法)
        DecreaseInjureValue = 38,      // 伤害减少数值(物理、魔法)
        CounteractInjurePercent = 39,   // 伤害抵挡百分比(物理、魔法)
        CounteractInjureValue = 40,     // 伤害抵挡数值(物理、魔法)
        IgnoreDefenseRate = 41,     // 无视防御的比例
        IncreasePhyDefense = 42,        // 物理防御提升(百分比)	
        IncreaseMagDefense = 43,        // 魔法防御提升(百分比)	
        LifeSteal = 44,                 // 击中恢复,角色每次成功击中1名敌人时，恢复指定数量的生命值,角色多段攻击时，每段均会触发击中恢复

        AddAttack = 45,                 // 增加物理攻击最小值、物理攻击最大值,增加魔法攻击最小值、魔法攻击最大值
        AddDefense = 46,                // 增加物理防御最小值、物理防御最大值,增加魔法防御最小值、魔法防御最大值

        StateDingShen,                 // 定身状态加成 ChenXiaojun
        StateMoveSpeed,                 // 速度改变状态 ChenXiaojun
        StateJiTui,                     // 击退状态 ChenXiaojun
        StateHunMi,                     // 昏迷状态 ChenXiaojun

        DeLucky,                        // 抵抗幸运一击
        DeFatalAttack,                  // 抵抗卓越一击
        DeDoubleAttack,                 // 抵抗双倍一击

        HitPercent = 54,       // 增加命中百分比 [XSea 2015/5/12]
        DodgePercent = 55,       // 增加闪避百分比 [XSea 2015/5/12]

        SavagePercent = 61,       //野蛮一击
        ColdPercent = 62,       //冷血一击
        RuthlessPercent = 63,       //无情一击

        DeSavagePercent = 64,       //抵抗野蛮一击
        DeColdPercent = 65,       //抵抗冷血一击
        DeRuthlessPercent = 66,       //抵抗无情一击

        LifeStealPercent = 67,       //击中恢复百分比
        Potion = 68,       //药水效果

        Max,
        Max_Configed = 47,              // 在物品表的属性中配置的数量最大值
    }
    public  class EquipPropItem
    {
        public EquipPropItem()
        {
            ResetProps();
        }

        /// <summary>
        /// 5个基础属性值
        /// </summary>
        private double[] _BaseProps = new double[5];

        /// <summary>
        /// 5个基础属性值
        /// </summary>
        public double[] BaseProps
        {
            get { return _BaseProps; }
        }

        /// <summary>
        /// 43个扩展属性值
        /// </summary>
        private double[] _ExtProps = new double[(int)ExtPropIndexes.Max];

        /// <summary>
        /// 43个扩展属性值
        /// </summary>
        public double[] ExtProps
        {
            get { return _ExtProps; }
        }

        /// <summary>
        /// 清空属性值
        /// </summary>
        public void ResetProps()
        {
            for (int i = 0; i < 5; i++)
            {
                _BaseProps[i] = 0;
            }

            for (int i = 0; i < (int)ExtPropIndexes.Max; i++)
            {
                _ExtProps[i] = 0;
            }
        }
    }
}
