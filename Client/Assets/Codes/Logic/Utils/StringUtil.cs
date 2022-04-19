using System;

namespace ET
{
    public static class StringUtil
    {
        public static bool IsNullOrEmpty(string str) => string.IsNullOrEmpty(str);

        public static string substitute(string format, params object[] args)
        {
            try
            {
                return string.Format(format, args);
            }
            catch (Exception ex)
            {
                Log.Warning(ex.ToString());
                return format;
            }
        }
    }
}
