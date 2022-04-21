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
    public class ClientGetAudioChatData
    {
        /// <summary>
        /// 语音信息编号
        /// </summary>
        [ProtoMember(1)]
        public long iAudioChatOrder = 0;

        /// <summary>
        /// 发送消息时的时间戳
        /// </summary>
        [ProtoMember(2)]
        public long lTime;

        /// <summary>
        /// 语音信息编号格式化成字符串后，与私钥生成的MD5码，以便作简单的验证。
        /// </summary>        
        [ProtoMember(3)]
        public string strMD5 = "";
    }

    /// <summary>
    /// 请求语音信息时 服务器返回给客户端的数据
    /// </summary>
    [ProtoContract]
    public class ServerGetAudioChatData
    {
        /// <summary>
        /// 语音信息
        /// </summary>
        [ProtoMember(1)]
        public byte[] arrAudioChat = null;
    }
}
