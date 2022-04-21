using System;
using System.Collections.Generic;
using System.Linq;
using ProtoBuf;

namespace Server.Data
{
    /// <summary>
    /// 请求语音信息时，客户端传过的参数数据
    /// </summary>
    [ProtoContract]
    public class ClientGetQQOrderData
    {
        /// <summary>
        /// 平台名
        /// </summary>
        [ProtoMember(1)]
        public String strPlatform;

        /// <summary>
        /// 用户ID
        /// </summary>
        [ProtoMember(2)]
        public String strOpenid;

        /// <summary>
        /// 从手Q登录态中获取的access_token 的值
        /// </summary>
        [ProtoMember(3)]
        public String strOpenkey;

        /// <summary>
        /// 从手Q登录态中获取的pay_token的值
        /// </summary>
        [ProtoMember(4)]
        public String strPayToken;

        /// <summary>
        /// 购买的物品数量*定价
        /// </summary>
        [ProtoMember(5)]
        public String strPayitem;

        /// <summary>
        /// 物品描述信息
        /// </summary>
        [ProtoMember(6)]
        public String strGoodsMeta;

        /// <summary>
        /// 物品图标地址
        /// </summary>
        [ProtoMember(7)]
        public String strGoodsURL;

        /// <summary>
        /// 平台来源
        /// </summary>
        [ProtoMember(8)]
        public String strPF;

        /// <summary>
        /// 平台来源Key
        /// </summary>
        [ProtoMember(9)]
        public String strPFKey;      

        /// <summary>
        /// 道具总价格
        /// </summary>
        [ProtoMember(10)]
        public String strMoney;

        /// <summary>
        /// 服务器编号
        /// </summary>
        [ProtoMember(11)]
        public int nServerID;

        /// <summary>
        /// 发送消息时的时间戳
        /// </summary>
        [ProtoMember(12)]
        public long lTime;

        /// <summary>
        /// 平台名、用户ID、服务器ID、时间戳格式化成字符串后，与私钥生成的MD5码，以便作简单的验证。
        /// </summary>
        [ProtoMember(13)]
        public String strMD5;
    }

    /// <summary>
    /// 验证SID后，返回平台用户ID
    /// </summary>
    [ProtoContract]
    public class ServerGetQQOrderData
    {
        /// <summary>
        /// 交易流水号
        /// </summary>
        [ProtoMember(1)]
        public string strExchangeOrder = "";

        /// <summary>
        /// URL参数
        /// </summary>
        [ProtoMember(2)]
        public string strURLParam = "";

        /// <summary>
        /// token参数
        /// </summary>
        [ProtoMember(3)]
        public string strToken = "";

        /// <summary>
        /// 发送消息时的时间戳
        /// </summary>
        [ProtoMember(4)]
        public long lTime;

        /// <summary>
        /// 交易流水号、发送消息时的时间戳、与私钥生成的MD5码，以便作简单的验证。
        /// </summary>
        [ProtoMember(5)]
        public String strMD5;
    }
}
