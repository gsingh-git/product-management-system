using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using PMS.EntityModel;
using PMS.Helper;
using PMS.Repository;
using PMS.ViewModels;

namespace PMS.Controllers
{
    public class OrderController : Controller
    {
        private readonly IUnitOfWork _unitOfWork;

        public OrderController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        private IEnumerable<Platform> GetPlatforms()
        {
            //todo: implement caching            
            var platforms = _unitOfWork.Repository<Platform>().GetAll();
            return platforms.ToList();
        }

        private List<SelectListBaseVM> GetProductSpecification(long productId)
        {
            //todo: implement caching  
            var result = new List<SelectListBaseVM>();
            var specifications = _unitOfWork.Repository<ProductSpecificationDetail>().FindBy(x => x.ProductId == productId);

            if (specifications.IsAny())
            {

            }
            return result;
        }

        private string GetProductName(long productSpecificationId)
        {
            var specifications = _unitOfWork.Repository<ProductSpecificationDetail>().GetByIdAsync(productSpecificationId).Result;

            if (specifications != null)
            {
                var product = _unitOfWork.Repository<Product>().GetByIdAsync(specifications.ProductId).Result;
                var specfication = _unitOfWork.Repository<ProductSpecifications>().GetByIdAsync(specifications.SpecificationId).Result;

                return $"{product.Name}-{specfication.Name}";
            }
            return string.Empty;
        }


        [HttpGet]
        public async Task<ActionResult> UpsertOrder(long id = 0, long productSpecificationId = 0, long productId = 0)
        {
            ViewBag.PlatformList = GetPlatforms();
            var model = new OrderVM();
            if (id > 0)
            {
                var order = await _unitOfWork.Repository<Order>().GetByIdAsync(id);
                if (order != null)
                    model = order.ToViewModel();
            }
            model.ProductId = productId;
            model.Product = GetProductName(productSpecificationId);
            return PartialView(model);
        }

        [HttpPost]
        public async Task<IActionResult> Upsert(OrderVM order)
        {
            if (order == null)
            {
                return BadRequest(HttpStatusCode.BadRequest);
            }

            var orderToUpdate = new Order();
            if (order.Id > 0)
                orderToUpdate = await _unitOfWork.Repository<Order>().GetByIdAsync(order.Id);

            if (TryUpdateOrderModel(orderToUpdate, order))
            {
                try
                {
                    await _unitOfWork.CommitAsync();

                    return RedirectToAction("Upsert", "Inventory", new { id = order.ProductId });
                }
                catch (DataException /* dex */)
                {
                    //Log the error (uncomment dex variable name and add a line here to write a log.
                    ModelState.AddModelError("",
                        "Unable to save changes. Try again, and if the problem persists, see your system administrator.");
                }
            }

            return View(order);
        }

        private bool UpdateInventoryAsync(int noOfUnitSold, long productSpecificationId)
        {
            try
            {
                var specification = _unitOfWork.Repository<ProductSpecificationDetail>().GetByIdAsync(productSpecificationId).Result;
                if (specification != null)
                {
                    var currentInventory = specification.TotalInstockQuantity;
                    specification.TotalInstockQuantity = currentInventory - noOfUnitSold;
                }

                return true;
            }
            catch (Exception)
            {

                return false;
            }

        }

        [HttpGet]
        public ActionResult GetProductOrder(string id)
        {
            long.TryParse(id, out var productSpecificationId);
            var result = GetAllOrders(productSpecificationId);
            return PartialView("_GetProductOrder", result);
        }

        private List<OrderVM> GetAllOrders(long id = 0)
        {
            var result = new List<OrderVM>();
            if (id > 0)
            {
                var orders = _unitOfWork.Repository<Order>().FindBy(x => x.ProductSpecificationId == id);
                if (orders.IsAny())
                {
                    foreach (var order in orders)
                    {
                        result.Add(order.ToViewModel());
                    }
                }

            }
            return result;
        }

        private bool TryUpdateOrderModel(Order orderToUpdate, OrderVM order)
        {
            try
            {
                orderToUpdate = order.ToEntity(orderToUpdate);
                if (orderToUpdate.Id > 0)
                {
                    orderToUpdate.ModifiedBy = 1;
                    orderToUpdate.ModifiedOn = DateTime.Now;
                }
                else
                {
                    orderToUpdate.CreatedBy = 1;
                    orderToUpdate.CreatedOn = DateTime.Now;
                    orderToUpdate.IsActive = true;
                    orderToUpdate.IsDeleted = false;
                    _unitOfWork.Repository<Order>().Insert(orderToUpdate);
                }

                return UpdateInventoryAsync(order.NoOfUnitSold, order.ProductSpecificationId);
            }
            catch (Exception e)
            {
                return false;
            }
        }
    }
}
