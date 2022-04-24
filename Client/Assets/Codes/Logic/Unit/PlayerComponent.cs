using System;
using System.Collections.Generic;

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
        public Dictionary<int, string[]> Roles = new Dictionary<int, string[]>();

        public void InitServerInfo(string[] fields)
        {
            UserID = Convert.ToInt64(fields[0]);
            UserName = fields[1];
            UserToken = fields[2];
            RoleID = -1;
            IsAdult = Convert.ToInt32(fields[3]) == 1;
        }

        public void InitRoleList(string[] fields)
        {
            Roles.Clear();
            string[] roles = fields[1].Split('|');
            for (int i = 0; i < roles.Length; i++)
            {
                string[] info = roles[i].Split('$');
                if (info.Length == 7)
                {
                    int id = Convert.ToInt32(info[0]);
                    Roles[id] = info;
                }
            }
        }
    }
}