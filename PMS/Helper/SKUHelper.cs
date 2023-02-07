using PMS.ViewModels;

namespace PMS.Helper
{
    public static class SKUHelper
    {
        public static string GenerateProductSKU(ProductVM product, string categoryCode, string color)
        {
            //WK0R8210M9599Y
            //WK-women Kurti, 0R - color red, 8210 - base price 210(left padding by 8)
            //M - size Medium, 9599 - selling price 599(left padding by 9),Y- is double price product

            return $"{categoryCode}{color.ToLeadZeros(2)}";
        }
    }
}