using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ProtoBuf;


namespace Server.Data
{
    /// <summary>
    /// 荧光宝石数据
    /// </summary>
    [ProtoContract]
    public class FluorescentGemData
    {
        /// <summary>
        /// 宝石镶嵌列表
        /// [部位id，[宝石类型,宝石GoodsData]]
        /// </summary>
        [ProtoMember(1)]
        public Dictionary<int, Dictionary<int, GoodsData>> GemInstalList = new Dictionary<int, Dictionary<int, GoodsData>>();
        
        /// <summary>
        /// 宝石仓库列表
        /// 格子索引,宝石GoodsData
        /// </summary>
        [ProtoMember(2)]
        public Dictionary<int, GoodsData> GemStoreList = new Dictionary<int, GoodsData>();
    }

    [ProtoContract]
    public class LevelupDiamondObject
    {
        /// <summary>
        /// 状态值, 成功 0, 其他值
        /// </summary>
        [ProtoMember(1)]
        public int status;

        /// <summary>
        /// 标示升级位置, 0: 背包, 1: 装备栏 
        /// </summary>
        [ProtoMember(2)]
        public int flag;

        /// <summary>
        /// 升级后的新物品
        /// </summary>
        [ProtoMember(3)]
        public GoodsData newGoods;
    }

    /// <summary>
    /// 荧光宝石升级传输结构 [XSea 2015/8/13]
    /// </summary>
    [ProtoContract]
    public class FluorescentGemUpTransferData
    {
        /// <summary>
        /// 角色id
        /// </summary>
        [ProtoMember(1)]
        public int _RoleID;


        /// <summary>
        /// 类型 0=背包中升级，1=装备栏升级
        /// </summary>
        [ProtoMember(2)]
        public int _UpType;

        /// <summary>
        /// 背包中的格子索引
        /// </summary>
        [ProtoMember(3)]
        public int _BagIndex;

        /// <summary>
        /// 装备部位索引
        /// </summary>
        [ProtoMember(4)]
        public int _Position;

        /// <summary>
        /// 宝石类型
        /// </summary>
        [ProtoMember(5)]
        public int _GemType;

        /// <summary>
        /// 要删除宝石的字典 key=背包格子索引，value=要扣的个数
        /// </summary>
        [ProtoMember(6)]
        public Dictionary<int, int> _DecGoodsDict;

        public FluorescentGemUpTransferData(int roleID, int levelupType, int bagIndex, int position, int gemType, Dictionary<int, int> decGoodsDic)
        {
            this._RoleID = roleID;
            this._UpType = levelupType;
            this._BagIndex = bagIndex;
            this._Position = position;
            this._GemType = gemType;
            this._DecGoodsDict = decGoodsDic;
        }
    }

    #region 荧光宝石装备栏变动传输结构
    /// <summary>
    /// 荧光宝石装备栏变动传输结构
    /// </summary>
    [ProtoContract]
    public class FluorescentGemEquipChangesTransferData
    {
        /// <summary>
        /// 部位索引
        /// </summary>
        [ProtoMember(1)]
        public int _Position;

        /// <summary>
        /// 宝石类型
        /// </summary>
        [ProtoMember(2)]
        public int _GemType;

        /// <summary>
        /// 宝石信息
        /// </summary>
        [ProtoMember(3)]
        public GoodsData _GoodsData = null;
    }

    #endregion 荧光宝石装备栏变动传输结构

    #region 荧光宝石挖掘结果传输结构
    /// <summary>
    /// 荧光宝石挖掘结果传输结构
    /// </summary>
    [ProtoContract]
    public class FluorescentGemDigTransferData
    {
        /// <summary>
        /// 结果0：成功，非0=错误代码
        /// </summary>
        [ProtoMember(1)]
        public int _Result;

        /// <summary>
        /// 获取宝石列表
        /// </summary>
        [ProtoMember(2)]
        public List<int> _GemList;
    }

    #endregion 荧光宝石挖掘结果传输结构
}
