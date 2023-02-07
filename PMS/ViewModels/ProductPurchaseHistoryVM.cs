using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PMS.ViewModels
{
    public class ProductPurchaseHistoryVM
    {
        public long ProductSpecificationId { get; set; }
        public int PurchaseQuantity { get; set; }
        public string PurchaseDate { get; set; }
        public string Other { get; set; }
        public long Id { get; set; }
        public long ProductId { get; set; }
        public decimal PricePerUnit { get; set; }
    }
}
