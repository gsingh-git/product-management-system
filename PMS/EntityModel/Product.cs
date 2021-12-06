namespace PMS.EntityModel
{
    public class Product : BaseEntity
    {
        public string Name { get; set; }
        public string Description { get; set; }
        public int Quantity { get; set; }
        public decimal Price { get; set; }
        public string SKU { get; set; }
        public string Barcode { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public int? ProductCategoryId { get; set; }
        public decimal? SellingPrice { get; set; }
        public decimal? GstAmount { get; set; }
        public decimal? TransportationAmount { get; set; }
        public bool IsGstOrder { get; set; }
        public decimal? OtherAmount { get; set; }
    }
}