namespace PMS.EntityModel
{
    public class ProductSpecificationDetail : BaseEntity
    {
        public long ProductId { get; set; }
        public int SpecificationId { get; set; }
        public int ProductCategoryId { get; set; }
        public int PurchasedQuantity { get; set; }
        public int TotalInstockQuantity { get; set; }
        public decimal? PricePerPiece { get; set; }
        public decimal? SellingPricePerPiece { get; set; }
        public string Other { get; set; }
        public string FileName { get; set; }
    }
}