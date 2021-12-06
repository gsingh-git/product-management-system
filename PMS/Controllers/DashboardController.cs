using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using PMS.EntityModel;
using PMS.Helper;
using PMS.Repository;
using PMS.ViewModels;

namespace PMS.Controllers
{
    public class DashboardController : Controller
    {
        private readonly IUnitOfWork _unitOfWork;

        public DashboardController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        public async Task<IActionResult> Index()
        {
            var dashboardModel = new DashboardVM();

            var productSpecifications = await
                _unitOfWork.Repository<ProductSpecificationDetail>().FindAllAsync(x => x.IsActive);

            if (productSpecifications.IsAny())
            {
                dashboardModel = new DashboardVM
                {
                    TotalPurchasedInventoryCount = productSpecifications.Sum(x => x.PurchasedQuantity),
                    TotalInventoryCount =
                        productSpecifications.Where(x => !x.IsDeleted).Sum(x => x.TotalInstockQuantity),
                    DiscontinuedProductCount = productSpecifications.Where(x => x.IsActive).Count(x => x.IsDeleted),
                    OutOfStockCount = productSpecifications.Count(x => !x.IsDeleted && x.TotalInstockQuantity < 5),
                    UniqueProductCount = productSpecifications.Count(x => !x.IsDeleted)
                };
            }

            return View(dashboardModel);
        }
    }
}