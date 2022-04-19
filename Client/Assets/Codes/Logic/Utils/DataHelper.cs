using System;
using System.Collections.Generic;
using System.Text;

namespace ET
{

    /// <summary>
    /// 数据操作辅助
    /// </summary>
    public static class DataHelper
    {
        // SortBytes的key
        private static bool bSortKeyInit = false;

        private static object mutex = new object();
        
        // SortBytes的key
        public static byte SortKey = 0;

        // SortBytes的key64
        public static ulong SortKey64 = 0;

        /// <summary>
        /// 压缩的大小
        /// </summary>
        public static int MinZipBytesSize = 1024000;

        /// <summary>
        /// 当前工作路径
        /// </summary>
        public static string CurrentDirectory;

        /// <summary>
        /// 字节数据拷贝
        /// </summary>
        /// <param name="copyTo">目标字节数组</param>
        /// <param name="offsetTo">目标字节数组的拷贝偏移量</param>
        /// <param name="copyFrom">源字节数组</param>
        /// <param name="offsetFrom">源字节数组的拷贝偏移量</param>
        /// <param name="count">拷贝的字节个数</param>
        public static void CopyBytes(byte[] copyTo, int offsetTo, byte[] copyFrom, int offsetFrom, int count)
        {
            /*for (int i = 0; i < count; i++)
            {
                copyTo[offsetTo + i] = copyFrom[offsetFrom + i];
            }*/
            Array.Copy(copyFrom, offsetFrom, copyTo, offsetTo, count);
        }

        /// <summary>
        /// 字节数据排序
        /// </summary>
        /// <param name="copyTo"></param>
        /// <param name="offsetTo"></param>
        /// <param name="count"></param>
        public static void SortBytes(byte[] bytesData, int offsetTo, int count)
        {
            if (!bSortKeyInit)
            {
                lock (mutex)
                {
                    if (!bSortKeyInit)
                    {
                        byte[] keyBytes = BitConverter.GetBytes((int)1695843216);
                        for (int i = 0; i < keyBytes.Length; i++)
                        {
                            SortKey += keyBytes[i];
                        }
                        bSortKeyInit = true;
                    }
                }
            }

            for (int x = offsetTo; x < (offsetTo + count); x++)
            {
                bytesData[x] ^= SortKey;
            }
        }

        /// <summary>
        /// 比较两个字节数组是否相同
        /// </summary>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <returns></returns>
        public static bool CompBytes(byte[] left, byte[] right)
        {
            if (left.Length != right.Length)
            {
                return false;
            }

            bool ret = true;
            for (int i = 0; i < left.Length; i++)
            {
                if (left[i] != right[i])
                {
                    ret = false;
                    break;
                }
            }

            return ret;
        }

        /// <summary>
        /// 比较两个字节数组是否相同
        /// </summary>
        /// <param name="left"></param>
        /// <param name="right"></param>
        /// <returns></returns>
        public static bool CompBytes(byte[] left, byte[] right, int count)
        {
            if (left.Length < count || right.Length < count)
            {
                return false;
            }

            bool ret = true;
            for (int i = 0; i < count; i++)
            {
                if (left[i] != right[i])
                {
                    ret = false;
                    break;
                }
            }

            return ret;
        }

        /// <summary>
        /// 产生并填充随机数
        /// </summary>
        /// <param name="buffer"></param>
        /// <param name="offset"></param>
        /// <param name="count"></param>
        public static void RandBytes(byte[] buffer, int offset, int count)
        {
            long tick = TimeHelper.ClientNow() * 10000;
            Random rnd = new Random((int)(tick & 0xffffffffL) | (int)(tick >> 32));
            for (int i = 0; i < count; i++)
            {
                buffer[offset + i] = (byte)rnd.Next(0, 0xFF);
            }
        }

        /// <summary>
        /// 将字节流转换为Hex编码的字符串(无分隔符号)
        /// </summary>
        /// <param name="b"></param>
        /// <returns></returns>
        public static string Bytes2HexString(byte[] b)
        {
            int ch = 0;
            string ret = "";
            for (int i = 0; i < b.Length; i++)
            {
                ch = (b[i] & 0xFF);
                ret += ch.ToString("X2").ToUpper();
            }

            return ret;
        }

        /// <summary>
        /// 将Hex编码的字符串转换为字节流(无分隔符号)
        /// </summary>
        /// <param name="s"></param>
        /// <returns></returns>
        public static byte[] HexString2Bytes(string s)
        {
            if (s.Length % 2 != 0) //非法的字符串
            {
                return null;
            }

            int b = 0;
            string hexstr = "";
            byte[] bytesData = new byte[s.Length / 2];
            for (int i = 0; i < s.Length / 2; i++)
            {
                hexstr = s.Substring(i * 2, 2);
                b = Int32.Parse(hexstr, System.Globalization.NumberStyles.HexNumber) & 0xFF;
                bytesData[i] = (byte)b;
            }

            return bytesData;
        }

        /// <summary>
        /// 判断如果不是 "*", 则转为指定的值, 否则默认值
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static Int32 ConvertToInt32(string str, Int32 defVal)
        {
            try
            {
                if ("*" != str)
                {
                    return Convert.ToInt32(str);
                }

                return defVal;
            }
            catch (Exception)
            {
            }

            return defVal;
        }

        /// <summary>
        /// 判断如果不是 "*", 则转为指定的值, 否则默认值
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static string ConvertToStr(string str, string defVal)
        {
            if ("*" != str)
            {
                return str;
            }

            return defVal;
        }

        /// <summary>
        /// 将日期时间字符串转为整数表示
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static long ConvertToTicks(string str, long defVal)
        {
            if ("*" == str)
            {
                return defVal;
            }

            str = str.Replace('$', ':');

            try
            {
                DateTime dt;
                if (!DateTime.TryParse(str, out dt))
                {
                    return 0L;
                }

                return dt.Ticks / 10000;
            }
            catch (Exception)
            {
            }

            return 0L;
        }

        /// <summary>
        /// 将日期时间字符串转为整数表示
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static long ConvertToTicks(string str)
        {
            try
            {
                DateTime dt;
            if (!DateTime.TryParse(str, out dt))
            {
                return 0L;
            }

            return dt.Ticks / 10000;
            }
            catch (Exception)
            {
            }

            return 0L;
        }

        /// <summary>
        /// Unix秒的起始计算毫秒时间(相对系统时间)
        /// </summary>
        private static long UnixStartTicks = DataHelper.ConvertToTicks("1970-01-01 08:00");

        /// <summary>
        /// 将Unix秒表示的时间转换为系统毫秒表示的时间
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static long UnixSecondsToTicks(int secs)
        {
            return UnixStartTicks + ((long)secs * 1000);
        }

        /// <summary>
        /// 将Unix秒表示的时间转换为系统毫秒表示的时间
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static long UnixSecondsToTicks(string secs)
        {
            int intSecs = Convert.ToInt32(secs);
            return UnixSecondsToTicks(intSecs);
        }

        /// <summary>
        /// 获取Unix秒表示的当前时间
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static int UnixSecondsNow()
        {
            long ticks = TimeHelper.ClientNowSeconds();
            return SysTicksToUnixSeconds(ticks);
        }

        /// <summary>
        /// 将系统毫秒表示的时间转换为Unix秒表示的时间
        /// </summary>
        /// <param name="str"></param>
        /// <returns></returns>
        public static int SysTicksToUnixSeconds(long ticks)
        {
            long secs = (ticks - UnixStartTicks) / 1000;
            return (int)secs;
        }

        /// <summary>
        /// UTF8 汉字字节流转成 Unicode 汉字字节流
        /// </summary>
        /// <param name="input"></param>
        /// <see cref="http://hi.baidu.com/hyqsoft/blog/item/263795a164d1728346106464.html"/>
        public static byte[] Utf8_2_Unicode(byte[] input)
        {
            var ret = new List<byte>();
            for (var i = 0; i < input.Length; i++)
            {
                if (input[i] >= 240) // 11110xxx
                {
                    //i += 3;
                    //throw new Exception("四字节的 UTF- 8 字符不能转换成两字节的 Unicode 字符！");
                    return null;
                }
                //else if (input[i] >= 224)
                if (input[i] >= 224) // 1110xxxx
                {
                    ret.Add((byte)((input[i + 2] & 63) | ((input[i + 1] & 3) << 6)));
                    ret.Add((byte)((input[i] << 4) | ((input[i + 1] & 60) >> 2)));
                    i += 2;
                }
                else if (input[i] >= 192) // 110xxxxx
                {
                    ret.Add((byte)((input[i + 1] & 63) | ((input[i] & 3) << 6)));
                    ret.Add((byte)((input[i] & 28) >> 2));
                    i += 1;
                }
                else
                {
                    ret.Add(input[i]);
                    ret.Add(0);
                }
            }
            return ret.ToArray();
        }

        public static string EncodeBase64(string str)
        {
            if (string.IsNullOrEmpty(str))
            {
                str = "null";
            }

            byte[] bytes = Encoding.UTF8.GetBytes(str);
            return Convert.ToBase64String(bytes);
        }

        public static string DecodeBase64(string base64Str)
        {
            try
            {
                if (!string.IsNullOrEmpty(base64Str))
                {
                    byte[] bytes = Convert.FromBase64String(base64Str);
                    return Encoding.UTF8.GetString(bytes);
                }
            }
            catch
            {
            }

            return null;
        }

        private static DateTime StartDate = new DateTime(2011, 11, 11);

        /// <summary>
        /// 返回服务器时间相对于"2011-11-11"经过了多少天
        /// 可以避免使用DayOfYear产生的跨年问题
        /// </summary>
        /// <returns></returns>
        public static double GetOffsetSecond(DateTime date)
        {
            return (date - StartDate).TotalSeconds;
        }

        /// <summary>
        /// 返回服务器时间相对于"2011-11-11"经过了多少天
        /// 可以避免使用DayOfYear产生的跨年问题
        /// </summary>
        /// <returns></returns>
        public static int GetOffsetDay(DateTime now)
        {
            return (int)(now - StartDate).TotalDays;
        }

        /// <summary>
        /// 当前时间相对于"2011-11-11"经过了多少天
        /// </summary>
        /// <returns></returns>
        public static int GetOffsetDayNow()
        {
            return GetOffsetDay(TimeHelper.DateTimeNow());
        }

        /// <summary>
        /// 使用服务器时间相对于"2011-11-11"经过了多少天 来返回具体的日期
        /// 可以避免使用DayOfYear产生的跨年问题
        /// </summary>
        /// <returns></returns>
        public static DateTime GetRealDate(int day)
        {
            return StartDate.AddDays(day);
        }
    }
}
