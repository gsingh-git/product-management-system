using System;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;

namespace PMS.Helper
{
    public static class ExtensionHelper
    {
        public static string ToLeadZeros(this int strNum, int num, char paddingChar = '0')
        {
            var str = strNum.ToString();
            return str.PadLeft(str.Length + num, paddingChar);
        }

        public static string ToLeadZeros(this string str, int num, char paddingChar = '0')
        {
            return str.PadLeft(str.Length + num, paddingChar);
        }

        public static bool IsAny<T>(this IEnumerable<T> enumerable)
        {
            return enumerable?.Any() == true;
        }

        public static DateTime ToDateTime(this string date, string dateFormat = "MM/dd/yyyy")
        {
            DateTime.TryParseExact(date,
                        dateFormat,
                        CultureInfo.InvariantCulture,
                        DateTimeStyles.None, out DateTime dt);

            return dt;
        }
    }
}