using System;

namespace ET
{
    public class PlayerComponent: Entity, IAwake
    {
        public long UserID;
        public string UserName;
        public string UserToken;
        public bool IsAdult;
        public int GameServerID;
        public int RoleID;
        public int RoleRandToken;

        public void InitServerInfo(string message)
        {
            string[] fields = message.Split(':');
            UserID = Convert.ToInt64(fields[0]);
            UserName = fields[1];
            UserToken = fields[2];
            RoleID = -1;
            IsAdult = Convert.ToInt32(fields[3]) == 1;
        }
    }
}