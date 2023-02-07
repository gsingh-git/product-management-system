using System;
using System.Linq;

namespace PMS.Helper
{
    public static class BarcodeHelper
    {
        public static string GetNewBarcode()
        {
            var obj = Guid.NewGuid();
            var numericPhone = new string(obj.ToString().Where(char.IsDigit).ToArray());
            var num = numericPhone.Substring(0, 11);
            return num;
        }
    }
}