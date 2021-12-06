using System.Collections.Generic;
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
    }
}