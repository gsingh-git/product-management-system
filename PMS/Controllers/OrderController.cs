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

        private IEnumerable<Platform> GetProductSpecification()
        {
            //todo: implement caching            
            var platforms = _unitOfWork.Repository<Platform>().GetAll();
            return platforms.ToList();
        }


        [HttpGet]
        public async Task<ActionResult> UpsertOrder(long id = 0)
        {
            ViewBag.PlatformList = GetPlatforms();
            var model = new OrderVM();
            if (id > 0)
            {
                var order = await _unitOfWork.Repository<Order>().GetByIdAsync(id);
                if (order != null)
                    model = order.ToViewModel();

            }
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
            if(order.Id > 0)
                orderToUpdate = await _unitOfWork.Repository<Order>().GetByIdAsync(order.Id);
            
            if (TryUpdateOrderModel(orderToUpdate, order))
            {
                try
                {
                    await _unitOfWork.CommitAsync();

                    return RedirectToAction("Index");
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


        [HttpGet]
        public async Task<List<OrderVM>> GetAllOrders(long productSpecificationId = 0)
        {
            var result = new List<OrderVM>();
            if(productSpecificationId > 0)
            {
                var orders = _unitOfWork.Repository<Order>().FindBy(x => x.ProductSpecificationId == productSpecificationId);
                if (orders.IsAny())
                {
                    foreach (var order in orders)
                    {
                        result.Add(order.ToViewModel());
                    }
                }
                
            }
            return await Task.FromResult(result);
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

                return true;
            }
            catch (Exception e)
            {
                return false;
            }
        }
    }
}
