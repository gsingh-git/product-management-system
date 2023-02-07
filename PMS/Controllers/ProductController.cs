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
    public class ProductController : Controller
    {
        private readonly IUnitOfWork _unitOfWork;

        public ProductController(IUnitOfWork unitOfWork)
        {
            _unitOfWork = unitOfWork;
        }

        [HttpGet]
        public async Task<ActionResult> Upsert(long id = 0, long productSpecificationId = 0, long productId = 0)
        {
            var model = new ProductPurchaseHistoryVM();
            if (id > 0)
            {
                var purchaseHistory = await _unitOfWork.Repository<ProductPurchaseHistory>().GetByIdAsync(id);
                if (purchaseHistory != null)
                    model = purchaseHistory.ToViewModel();
            }
            model.ProductSpecificationId = productSpecificationId;
            model.ProductId = productId;
            return PartialView(model);
        }

        [HttpPost]
        public async Task<IActionResult> Upsert(ProductPurchaseHistoryVM purchaseHistory)
        {
            if (purchaseHistory == null)
            {
                return BadRequest(HttpStatusCode.BadRequest);
            }

            var purchaseToUpdate = new ProductPurchaseHistory();
            if (purchaseHistory.Id > 0)
                purchaseToUpdate = await _unitOfWork.Repository<ProductPurchaseHistory>().GetByIdAsync(purchaseHistory.Id);

            if (TryUpdatePurchaseHistoryModel(purchaseToUpdate, purchaseHistory))
            {
                try
                {
                    await _unitOfWork.CommitAsync();

                    return RedirectToAction("Upsert", "Inventory", new { id = purchaseHistory.ProductId });
                }
                catch (DataException /* dex */)
                {
                    //Log the error (uncomment dex variable name and add a line here to write a log.
                    ModelState.AddModelError("",
                        "Unable to save changes. Try again, and if the problem persists, see your system administrator.");
                }
            }

            return View(purchaseHistory);
        }

        private bool TryUpdatePurchaseHistoryModel(ProductPurchaseHistory purchaseHistoryToUpdate, ProductPurchaseHistoryVM purchaseHistory)
        {
            try
            {
                purchaseHistoryToUpdate = purchaseHistory.ToEntity(purchaseHistoryToUpdate);
                if (purchaseHistoryToUpdate.Id > 0)
                {
                    purchaseHistoryToUpdate.ModifiedBy = 1;
                    purchaseHistoryToUpdate.ModifiedOn = DateTime.Now;
                }
                else
                {
                    purchaseHistoryToUpdate.CreatedBy = 1;
                    purchaseHistoryToUpdate.CreatedOn = DateTime.Now;
                    purchaseHistoryToUpdate.IsActive = true;
                    purchaseHistoryToUpdate.IsDeleted = false;
                    _unitOfWork.Repository<ProductPurchaseHistory>().Insert(purchaseHistoryToUpdate);
                }

                return UpdatePurchaseQuantityAsync(purchaseHistory.PurchaseQuantity, purchaseHistory.ProductSpecificationId);
            }
            catch (Exception e)
            {
                return false;
            }
        }
        private bool UpdatePurchaseQuantityAsync(int purchasedQuantity, long productSpecificationId)
        {
            try
            {
                var specification = _unitOfWork.Repository<ProductSpecificationDetail>().GetByIdAsync(productSpecificationId).Result;
                if (specification != null)
                {
                    var currentQuantity = specification.PurchasedQuantity;
                    var totalnstock = specification.TotalInstockQuantity;
                    specification.PurchasedQuantity = currentQuantity + purchasedQuantity;
                    specification.TotalInstockQuantity = totalnstock + purchasedQuantity;
                }

                return true;
            }
            catch (Exception)
            {

                return false;
            }

        }

    }
}
