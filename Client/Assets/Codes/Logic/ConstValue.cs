namespace ET
{
    public static class ConstValue
    {

        /// <summary>
        /// 代码修订版本号
        /// </summary>
        public static int CodeRevision = 2;
        
        /// <summary>
        /// 程序版本号
        /// </summary>
        public static string MainExeVer = "20151212";

        /// <summary>
        /// 资源版本号
        /// </summary>
        public static string ResSwfVer = "20151212";
        
        public const string LoginAddress = "45.135.118.232:4402";
        public const string GameAddress = "45.135.118.232:10001";

        public static string GetDeviceID()
        {
            return "Test Device ID with unity editor";
        }
    }
}