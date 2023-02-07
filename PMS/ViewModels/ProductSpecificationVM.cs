using Microsoft.AspNetCore.Http;

namespace PMS.ViewModels
{
    public class ProductSpecificationVM
    {
        public long ProductId { get; set; }
        public int SpecificationId { get; set; }
        public int ProductCategoryId { get; set; }
        public int PurchasedQuantity { get; set; }
        public int TotalInstockQuantity { get; set; }
        public decimal? PricePerPiece { get; set; }
        public decimal? SellingPricePerPiece { get; set; }
        public string Other { get; set; }
        public long Id { get; set; }
        public bool IsDeleted { get; set; }
        public bool IsActive { get; set; }
        public string FileName { get; set; }
        public IFormFile ProductImage { set; get; }
    }
}