using System;
using System.Collections.Generic;
using System.Linq;
using ProtoBuf;

namespace Server.Data
{
    /// <summary>
    /// 上传语音数据时，客户端传过来的参数数据
    /// </summary>
    [ProtoContract]
    public class ClientPostAudioChatData
    {
        /// <summary>
        /// 0为不确定个数，加此参数的目的是便于及时在服务器上删除无用的语音信息
        /// </summary>        
        [ProtoMember(1)]
        public int iTargetNum = 1;

        /// <summary>
        /// 语音信息
        /// </summary>
        [ProtoMember(2)]
        public byte[] arrAudioChat = null;

        /// <summary>
        /// 发送消息时的时间戳
        /// </summary>
        [ProtoMember(3)]
        public long lTime;

        /// <summary>
        /// 目标个数格式化成字符串后，与私钥生成的MD5码，以便作简单的验证。
        /// </summary>        
        [ProtoMember(4)]
        public string strMD5 = "";
    }

    /// <summary>
    /// 上传语音数据时，服务器返回给客户端的数据
    /// </summary>
    [ProtoContract]
    public class ServerPostAudioChatData
    {
        /// <summary>
        /// 平台名
        /// </summary>
        [ProtoMember(1)]
        public long iAudioChatOrder = 0;
    }
}
