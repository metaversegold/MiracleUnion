using System;
using System.Collections.Generic;
using System.Linq;
using ProtoBuf;

namespace Server.Data
{
    /// <summary>
    /// 请求订单信息时，客户端传过的参数数据
    /// </summary>
    [ProtoContract]
    public class ClientGetOrderData
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
        public String strUserID;

        /// <summary>
        /// 要充值的金额
        /// </summary>
        [ProtoMember(3)]
        public String strMoney;

        /// <summary>
        /// 服务器编号
        /// </summary>
        [ProtoMember(4)]
        public int nServerID;

        /// <summary>
        /// 发送消息时的时间戳
        /// </summary>
        [ProtoMember(5)]
        public long lTime;
		//角色名称
		[ProtoMember(6)]
		public string roleName;
		//角色id
		[ProtoMember(7)]
		public int roleId;
        /// <summary>
        /// 平台名、用户ID、服务器ID、时间戳格式化成字符串后，与私钥生成的MD5码，以便作简单的验证。
        /// </summary>
        [ProtoMember(8)]
        public String strMD5;
	}

    /// <summary>
    /// 验证SID后，返回平台用户ID
    /// </summary>
    [ProtoContract]
    public class ServerGetOrderData
    {
        /// <summary>
        /// 交易流水号
        /// </summary>
        [ProtoMember(1)]
        public string strExchangeOrder = "";

        /// <summary>
        /// 透传参数
        /// </summary>
        [ProtoMember(2)]
        public string strExtParam = "";

        /// <summary>
        /// 发送消息时的时间戳
        /// </summary>
        [ProtoMember(3)]
        public long lTime;

        /// <summary>
        /// 交易流水号、发送消息时的时间戳、与私钥生成的MD5码，以便作简单的验证。
        /// </summary>
        [ProtoMember(4)]
        public String strMD5;
    }

	[ProtoContract]
	public class IOSClientGetOrderData
	{
		/// <summary>
		/// 平台名
		/// </summary>
		[ProtoMember(1)]
		public String strPlatform = "";
		
		/// <summary>
		/// 用户ID
		/// </summary>
		[ProtoMember(2)]
		public String strUserID = "";
		
		/// <summary>
		/// 要充值的金额
		/// </summary>
		[ProtoMember(3)]
		public String strMoney = "";
		
		/// <summary>
		/// 服务器编号
		/// </summary>
		[ProtoMember(4)]
		public int nServerID = 1;
		
		/// <summary>
		/// 发送消息时的时间戳
		/// </summary>
		[ProtoMember(5)]
		public long lTime = 0;        
		
		/// <summary>
		/// 平台名、用户ID、要充值的金额、服务器ID、时间戳、区域代码、区域标识、语言代码、货币代码、配页符号格式化成字符串后，与私钥生成的MD5码，以便作简单的验证。
		/// </summary>
		[ProtoMember(6)]
		public String strMD5 = "";

		/// <summary>
		/// 区域代码
		/// </summary>
		[ProtoMember(7)]
		public String NSLocaleCountryCode = "";
		
		/// <summary>
		/// 区域标识
		/// </summary>
		[ProtoMember(8)]
		public String NSLocaleIdentifier = "";
		
		/// <summary>
		/// 语言代码
		/// </summary>
		[ProtoMember(9)]
		public String NSLocaleLanguageCode = "";
		
		/// <summary>
		/// 货币符号
		/// </summary>
		[ProtoMember(10)]
		public String NSLocaleCurrencySymbol = "";
		
		/// <summary>
		/// 货币代码
		/// </summary>
		[ProtoMember(11)]
		public String NSLocaleCurrencyCode = "";
		
		/// <summary>
		/// 配页符号
		/// </summary>
		[ProtoMember(12)]
		public String NSLocaleCollatorIdentifier = "";

		[ProtoMember(13)]
		public String Md5IdxValue = "";
		
		[ProtoMember(14)]
		public String Md5IdyValue = "";
		
		[ProtoMember(15)]
		public String IdxEqual = "";
		
		[ProtoMember(16)]
		public String NotUseAgent = "";

		[ProtoMember(17)]
		public String VersionCode = "";
		//角色名称
		[ProtoMember(18)]
		public string roleName;

		//角色id
		[ProtoMember(19)]
		public int roleId;
		
		//角色id
		[ProtoMember(20)]
		public string iOSVersion;
	}
}
