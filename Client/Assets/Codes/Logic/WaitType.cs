using Server.Data;

namespace ET
{
    namespace WaitType
    {
        public struct Wait_UnitStop: IWaitType
        {
            public int Error
            {
                get;
                set;
            }
        }
        
        public struct Wait_CreateMyUnit: IWaitType
        {
            public int Error
            {
                get;
                set;
            }
        }
        
        public struct Wait_CreatePlayerRoleUnit: IWaitType
        {
            public int Error
            {
                get;
                set;
            }

            public RoleData Data;
        }
        
        public struct Wait_SceneChangeFinish: IWaitType
        {
            public int Error
            {
                get;
                set;
            }
        }
    }
}