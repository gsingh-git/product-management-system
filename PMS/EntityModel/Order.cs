using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace PMS.EntityModel
{
    public class Order : BaseEntity
    {
        public long ProductSpecificationId { get; set; }
        public string OrderId { get; set; }
        public int PlatformId { get; set; }
        public int NoOfUnitSold { get; set; }
        public string Other { get; set; }
    }
}
