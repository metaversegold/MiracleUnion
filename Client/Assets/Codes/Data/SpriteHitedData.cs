using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using ProtoBuf;

namespace Server.Data
{
    /// <summary>
    /// 精灵受击
    /// </summary>
    [ProtoContract]
    public class SpriteHitedData
    {
        [ProtoMember(1)]
        public int roleId;

        [ProtoMember(2)]
        public int enemy;

        [ProtoMember(3)]
        public int enemyX;

        [ProtoMember(4)]
        public int enemyY;

        [ProtoMember(5)]
        public int magicCode;
    }
}
