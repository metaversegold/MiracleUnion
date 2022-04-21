using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ProtoBuf;

namespace Server.Data
{
    /// <summary>
    /// 节日活动相关xml数据，推送到客户端  (专享活动通用 2016年3月7日@myw新加)
    /// </summary>
    [ProtoContract]
    public class JieriXmlData
    {
        /// <summary>
        /// 登录周ID
        /// </summary>
        [ProtoMember(1)]
        public List<string> XmlList = null;

        /// <summary>
        ///当前服务器配置版本号，客户端检测收到的版本号与本地的是否一致
        /// </summary>
        [ProtoMember(2)]
        public int Version;

    }
}
