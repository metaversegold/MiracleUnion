using System;
using System.Collections.Generic;
using System.Linq;
using ProtoBuf;

namespace Server.Data
{
    [ProtoContract]
    public class ClientAppealData
    {       
        /// <summary>
        /// 用户ID
        /// </summary>
        [ProtoMember(1)]
        public String strUserID;      

        /// <summary>
        /// 发送消息时的时间戳
        /// </summary>
        [ProtoMember(2)]
        public long lTime;

        /// <summary>
        /// 用户ID、时间戳格式化成字符串后，与私钥生成的MD5码，以便作简单的验证。
        /// </summary>
        [ProtoMember(3)]
        public String strMD5;
    }

    /// <summary>
    /// 验证SID后，返回平台用户ID
    /// </summary>
    [ProtoContract]
    public class ServerAppealData
    {
        /// <summary>
        /// 验证状态(0表示申诉处理成功)
        /// </summary>
        [ProtoMember(1)]
        public string strState = "";

        /// <summary>
        /// 发送消息时的时间戳
        /// </summary>
        [ProtoMember(2)]
        public long lTime;

		/// <summary>
		/// 原因
		/// </summary>
		[ProtoMember(3)]
		public string strResult = "";

		/// <summary>
		/// 验证状态、时间戳格式化成字符串后，与私钥生成的MD5码，以便作简单的验证。
        /// </summary>
        [ProtoMember(4)]
        public String strMD5;
    }
}
