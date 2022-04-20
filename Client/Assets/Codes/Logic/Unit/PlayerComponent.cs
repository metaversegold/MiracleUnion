using System;

namespace ET
{
    public class PlayerComponent: Entity, IAwake
    {
        public long UserID;
        public string UserName;
        public string UserToken;
        public bool IsAdult;

        public void InitServerInfo(string message)
        {
            string[] fields = message.Split(':');
            UserID = Convert.ToInt64(fields[0]);
            UserName = fields[1];
            UserToken = fields[2];
            IsAdult = Convert.ToInt32(fields[3]) == 1;
        }
    }
}