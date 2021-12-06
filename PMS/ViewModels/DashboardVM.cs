namespace PMS.ViewModels
{
    public class DashboardVM
    {
        public int TotalInventoryCount { get; set; }
        public int TotalPurchasedInventoryCount { get; set; }

        public int OutOfStockCount { get; set; }
        public int DiscontinuedProductCount { get; set; }
        public int UniqueProductCount { get; set; }
    }
}