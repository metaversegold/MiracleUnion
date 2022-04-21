using System;
using System.Collections.Generic;
using System.Linq;
using ProtoBuf;

namespace Server.Data
{
    /// <summary>
    /// 请求语音服务器地址时，客户端传过的参数数据
    /// </summary>
    [ProtoContract]
    public class ClientAudioURLData
    {
        /// <summary>
        /// 平台名
        /// </summary>
        [ProtoMember(1)]
        public string strPlatform = "";

        /// <summary>
        /// 服务器编号
        /// </summary>        
        [ProtoMember(2)]
        public int iServerID = 1;

        /// <summary>
        /// 发送消息时的时间戳
        /// </summary>
        [ProtoMember(3)]
        public long lTime;

        /// <summary>
        /// 平台名、服务器ID格式化成字符串后，与私钥生成的MD5码，以便作简单的验证
        /// </summary>        
        [ProtoMember(4)]
        public string strMD5 = "";
    }

    /// <summary>
    /// 请求语音服务器地址时 服务器返回给客户端的数据
    /// </summary>
    [ProtoContract]
    public class ServerAudioURLData
    {
        /// <summary>
        /// 平台名
        /// </summary>
        [ProtoMember(1)]
        public string strAudioURL = "";
    }
}
