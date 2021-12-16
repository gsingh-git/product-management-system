using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PMS.ViewModels
{
    public class OrderVM
    {
        public long Id { get; set; }
        public long ProductSpecificationId { get; set; }
        public long ProductId { get; set; }
        public string Product { get; set; }
        public string OrderId { get; set; }
        public int PlatformId { get; set; }
        public int NoOfUnitSold { get; set; }
        public string Other { get; set; }
    }
}
