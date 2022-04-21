using System;
using System.Collections.Generic;
using System.Linq;
using ProtoBuf;

namespace Server.Data
{
    /// <summary>
    /// 请求港澳台礼包兑换时，客户端传过的参数数据
    /// </summary>
    [ProtoContract]
    public class GATGiftData
    {
        /// <summary>
        /// 短礼品码
        /// </summary>
        [ProtoMember(1)]
        public String strShortGiftKey;

        /// <summary>
        /// 时间
        /// </summary>
        [ProtoMember(2)]
        public long lTime;

        /// <summary>
        /// 时间、短礼品码格式化成字符串后，与私钥生成的MD5码，以便作简单的验证。
        /// </summary>
        [ProtoMember(3)]
        public String strMD5;
    }

    /// <summary>
    /// 服务器验证后，返回兑换信息
    /// </summary>
    [ProtoContract]
    public class ServerGATGiftResultData
    {
        /// <summary>
        /// 长礼品码
        /// </summary>
        [ProtoMember(1)]
        public String strLongGiftKey;

        /// <summary>
        /// 时间
        /// </summary>
        [ProtoMember(2)]
        public long lTime;

        /// <summary>
        /// 时间、短礼品码格式化成字符串后，与私钥生成的MD5码，以便作简单的验证。
        /// </summary>
        [ProtoMember(3)]
        public String strMD5;
    }
}