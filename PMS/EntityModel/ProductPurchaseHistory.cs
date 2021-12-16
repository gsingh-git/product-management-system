using System;

namespace PMS.EntityModel
{
    public class ProductPurchaseHistory : BaseEntity
    {        
        public long ProductSpecificationId { get; set; }        
        public int PurchasedQuantity { get; set; }
        public decimal? PricePerUnit { get; set; }
        public string Other { get; set; }
        public DateTime PurchasedDate { get; set; }
    }
}