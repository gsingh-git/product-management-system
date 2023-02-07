using System.Collections.Generic;

namespace PMS.ViewModels
{
    public class ProductVM
    {
        public long Id { get; set; }
        public string Name { get; set; }
        public string Description { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }
        public string SKU { get; set; }
        public string Barcode { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public decimal GstAmount { get; set; }
        public decimal TransportationAmount { get; set; }
        public bool IsGstOrder { get; set; }
        public int ProductCategoryId { get; set; }
        public string CategoryName { get; set; }
        public int TotalItems { get; set; }

        public decimal TotalAmount => Price + GstAmount + TransportationAmount + OtherAmount;

        public List<ProductSpecificationVM> ProductSpecification { get; set; }
        public decimal SellingPrice { get; set; }
        public decimal OtherAmount { get; set; }
    }
}