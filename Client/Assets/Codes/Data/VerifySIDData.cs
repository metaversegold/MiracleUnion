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
    public class ClientVerifySIDData
    {
        /// <summary>
        /// 平台SID
        /// </summary>
        [ProtoMember(1)]
        public string strSID = "";

        /// <summary>
        /// 发送消息时的时间戳
        /// </summary>
        [ProtoMember(2)]
        public long lTime;

        /// <summary>
        /// 平台SID、时间戳格式化成字符串后，与私钥生成的MD5码，以便作简单的验证。
        /// </summary>        
        [ProtoMember(3)]
        public string strMD5 = "";
    }

    /// <summary>
    /// 验证SID后，返回平台用户ID
    /// </summary>
    [ProtoContract]
    public class ServerVerifySIDData
    {
        /// <summary>
        /// 平台用户ID
        /// </summary>
        [ProtoMember(1)]
        public string strPlatformUserID = "";

        /// <summary>
        /// 帐户名，跟用户ID相同
        /// </summary>
        [ProtoMember(2)]
        public string strAccountName = "";

        /// <summary>
        /// 返回消息时的时间戳
        /// </summary>
        [ProtoMember(3)]
        public long lTime = 0;

        /// <summary>
        /// 是否成人
        /// </summary>
        [ProtoMember(4)]
        public string strCM = "1";

        /// <summary>
        /// 参数加密
        /// </summary>
        [ProtoMember(5)]
        public string strToken = "";
    }

    /// <summary>
    /// 验证SID后，返回平台用户ID及Token
    /// </summary>
    [ProtoContract]
    public class ServerVerifySIDDataToken
    {
        /// <summary>
        /// 平台用户ID
        /// </summary>
        [ProtoMember(1)]
        public string strPlatformUserID = "";

        /// <summary>
        /// 帐户名，跟用户ID相同
        /// </summary>
        [ProtoMember(2)]
        public string strAccountName = "";

        /// <summary>
        /// 返回消息时的时间戳
        /// </summary>
        [ProtoMember(3)]
        public long lTime = 0;

        /// <summary>
        /// 是否成人
        /// </summary>
        [ProtoMember(4)]
        public string strCM = "1";

        /// <summary>
        /// 参数加密
        /// </summary>
        [ProtoMember(5)]
        public string strToken = "";

        /// <summary>
        /// 参数加密
        /// </summary>
        [ProtoMember(6)]
        public string strPlatformToken = "";
    }

}
