using System.Collections.Generic;
using System.Linq;
using Microsoft.AspNetCore.Mvc;
using PMS.EntityModel;

namespace PMS.Controllers
{
    public class BaseController : Controller
    {
        //protected DatabaseContext _context => (DatabaseContext)HttpContext.RequestServices.GetService(typeof(DatabaseContext));

        private protected readonly DatabaseContext _context;

        public BaseController(DatabaseContext context)
        {
            _context = context;
        }

        private protected IEnumerable<ProductCategory> GetProductCategories()
        {
            //todo: implement caching
            //var productCategories = HttpContext.Cache.Get HttpContext.Cache["regions"] as IEnumerable<ProductCategory>;
            return _context.ProductCategory.Select(x => x).ToList();
        }
    }
}