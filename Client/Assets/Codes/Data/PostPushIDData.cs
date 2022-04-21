using System;
using System.Collections.Generic;
using System.Linq;
using ProtoBuf;

namespace Server.Data
{
    /// <summary>
    /// 上传推送数据时，客户端传过来的参数数据
    /// </summary>
    [ProtoContract]
    public class ClientPostPushIDData
    {
        /// <summary>
        /// 推送ID
        /// </summary>
        [ProtoMember(1)]
        public string strPushID;

        /// <summary>
        /// 发送消息时的时间戳
        /// </summary>
        [ProtoMember(2)]
        public long lTime;

        /// <summary>
        /// 目标个数格式化成字符串后，与私钥生成的MD5码，以便作简单的验证。
        /// </summary>        
        [ProtoMember(3)]
        public string strMD5 = "";
    }

    /// <summary>
    /// 上传推送数据时，服务器返回给客户端的数据
    /// </summary>
    [ProtoContract]
    public class ServerPostPushIDData
    {
        /// <summary>
        /// 推送ID
        /// </summary>
        [ProtoMember(1)]
        public long iPushIDChatOrder = 0;
    }
}
