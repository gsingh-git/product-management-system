using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Net;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using PMS.EntityModel;
using PMS.Helper;
using PMS.Repository;
using PMS.ViewModels;

namespace PMS.Controllers
{
    public class InventoryController : Controller
    {
        private readonly IUnitOfWork _unitOfWork;
        private readonly IHostingEnvironment _hostingEnvironment;

        public InventoryController(IUnitOfWork unitOfWork, IHostingEnvironment environment)
        {
            _unitOfWork = unitOfWork;
            _hostingEnvironment = environment;
        }

        private IEnumerable<ProductCategory> GetProductCategories()
        {
            //todo: implement caching
            //var productCategories = HttpContext.Cache.Get HttpContext.Cache["regions"] as IEnumerable<ProductCategory>;
            var categories = _unitOfWork.Repository<ProductCategory>().GetAll();
            return categories.ToList();
        }

        private IEnumerable<ProductSpecifications> GetProductSpecifications()
        {
            //todo: implement caching
            //var productCategories = HttpContext.Cache.Get HttpContext.Cache["regions"] as IEnumerable<ProductCategory>;
            var specifications = _unitOfWork.Repository<ProductSpecifications>().GetAll();
            return specifications.ToList();
        }

        public IActionResult Index()
        {
            return View();
        }

        public IActionResult GetAllData()
        {
            var draw = HttpContext.Request.Form["draw"].FirstOrDefault();
            // Skiping number of Rows count
            var start = Request.Form["start"].FirstOrDefault();
            // Paging Length 10,20
            var length = Request.Form["length"].FirstOrDefault();
            // Sort Column Name
            var sortColumn = Request
                .Form["columns[" + Request.Form["order[0][column]"].FirstOrDefault() + "][name]"].FirstOrDefault();
            // Sort Column Direction ( asc ,desc)
            var sortColumnDirection = Request.Form["order[0][dir]"].FirstOrDefault();
            // Search Value from (Search box)
            var searchValue = Request.Form["search[value]"].FirstOrDefault();

            //Paging Size (10,20,50,100)
            int pageSize = length != null ? Convert.ToInt32(length) : 0;
            int skip = start != null ? Convert.ToInt32(start) : 0;
            int recordsTotal = 0;

            // Getting all Product data
            var products = _unitOfWork.Repository<Product>().GetAll().AsQueryable();


            //Sorting
            if (!(string.IsNullOrEmpty(sortColumn) && string.IsNullOrEmpty(sortColumnDirection)))
            {
                //customerData = customerData.OrderBy(sortColumn + " " + sortColumnDirection);
            }

            //Search
            if (!string.IsNullOrEmpty(searchValue))
            {
                products = products.Where(m =>
                    m.Name == searchValue || m.Description.Contains(searchValue) || m.City == searchValue);
            }

            //total number of rows count 
            recordsTotal = products.Count();
            //Paging 
            var productEntities = products.Skip(skip).Take(pageSize).ToArray();
            var productList = new List<ProductVM>();
            if (productEntities.IsAny())
            {
                productEntities.ToList().ForEach(x =>
                {
                    var productvm = x.ToViewModel();
                    if (x.ProductCategoryId.HasValue)
                    {
                        var productCategory =
                            _unitOfWork.Repository<ProductCategory>().GetById(x.ProductCategoryId.Value);
                        productvm.CategoryName = productCategory?.Name;
                    }
                    var productSpecification =
                            _unitOfWork.Repository<ProductSpecificationDetail>().FindBy(y => y.ProductId == x.Id);
                    if (productSpecification.IsAny())
                    {
                        productvm.TotalItems = productSpecification.Count(x => x.IsActive && !x.IsDeleted);
                    }

                    productList.Add(productvm);
                });
            }

            //Returning Json Data
            var jsonData = new { draw, recordsFiltered = recordsTotal, recordsTotal, data = productList };
            return Ok(jsonData);
        }


        public async Task<IActionResult> Upsert(long id = 0)
        {
            ViewBag.ProductCategories = GetProductCategories();
            ViewBag.ProductSpecification = GetProductSpecifications();

            var productVM = new ProductVM();
            if (id > 0)
            {
                var product = await _unitOfWork.Repository<Product>().GetByIdAsync(id);
                productVM = product.ToViewModel();

                //check for product specifications
                var productSpecifications =
                    _unitOfWork.Repository<ProductSpecificationDetail>().FindBy(x => x.ProductId == product.Id);
                // bind it to specification VM 
                if (productSpecifications.IsAny())
                {
                    var productSpecificationList = new List<ProductSpecificationVM>();
                    foreach (var specification in productSpecifications)
                    {
                        productSpecificationList.Add(specification.ToViewModel());
                    }

                    productVM.ProductSpecification = productSpecificationList;
                }
            }

            return View(productVM);
        }

        [HttpPost]
        public async Task<IActionResult> Upsert(ProductVM product)
        {
            if (product == null)
            {
                return BadRequest(HttpStatusCode.BadRequest);
            }

            var productToUpdate = new Product();
            if (product.Id > 0)
                productToUpdate = await _unitOfWork.Repository<Product>().GetByIdAsync(product.Id);

            if (TryUpdateProductModel(productToUpdate, product))
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

            return View(product);
        }

        [HttpGet]
        public ActionResult GetProductSpecification(string id)
        {
            int.TryParse(id, out var productId);
            var model = new ProductSpecificationVM();
            ViewBag.ProductSpecification = GetProductSpecifications();
            ViewBag.ProductCategories = GetProductCategories();

            if (productId > 0)
            {
                var specificationToUpdate = new ProductSpecificationDetail();

                specificationToUpdate.ProductId = productId;
                specificationToUpdate.SpecificationId = 0;
                specificationToUpdate.PricePerPiece = 0;
                specificationToUpdate.CreatedBy = 1;
                specificationToUpdate.CreatedOn = DateTime.Now;
                specificationToUpdate.IsActive = true;
                specificationToUpdate.IsDeleted = false;

                _unitOfWork.Repository<ProductSpecificationDetail>().Insert(specificationToUpdate);
                _unitOfWork.Commit();

                model = specificationToUpdate.ToViewModel();
            }

            return PartialView("_AddProductSpecification", model);
        }

        private bool TryUpdateProductModel(Product productToUpdate, ProductVM product)
        {
            try
            {
                productToUpdate = product.ToEntity(productToUpdate);
                if (productToUpdate.Id > 0)
                {
                    productToUpdate.ModifiedBy = 1;
                    productToUpdate.ModifiedOn = DateTime.Now;
                }
                else
                {
                    productToUpdate.CreatedBy = 1;
                    productToUpdate.CreatedOn = DateTime.Now;
                    productToUpdate.Barcode = BarcodeHelper.GetNewBarcode();
                    productToUpdate.IsActive = true;
                    productToUpdate.IsDeleted = false;
                    _unitOfWork.Repository<Product>().Insert(productToUpdate);
                }

                return TryUpdateProductSpecificationModel(product.ProductSpecification);
            }
            catch (Exception e)
            {
                return false;
            }
        }

        private bool TryUpdateProductSpecificationModel(List<ProductSpecificationVM> productSpecificationVM)
        {
            try
            {
                if (!productSpecificationVM.IsAny()) return true;

                foreach (var specification in productSpecificationVM)
                {
                    var specificationToUpdate = new ProductSpecificationDetail();

                    if (specification.Id > 0)
                        specificationToUpdate = _unitOfWork.Repository<ProductSpecificationDetail>()
                            .GetByIdAsync(specification.Id).Result;

                    specificationToUpdate = specification.ToEntity(specificationToUpdate);
                    if (specification.ProductImage != null)
                    {

                        var uniqueFileName = GetUniqueFileName(specification.ProductImage.FileName);
                        var uploadPath = Path.Combine(_hostingEnvironment.WebRootPath, "uploads");

                        if (!Directory.Exists(uploadPath))
                            Directory.CreateDirectory(uploadPath);

                        var filePath = Path.Combine(uploadPath, uniqueFileName);
                        specification.ProductImage.CopyTo(new FileStream(filePath, FileMode.Create));

                        specificationToUpdate.FileName = uniqueFileName;
                    }

                    if (specificationToUpdate.Id > 0)
                    {
                        specificationToUpdate.ModifiedBy = 1;
                        specificationToUpdate.ModifiedOn = DateTime.Now;
                    }
                    else
                    {
                        specificationToUpdate.CreatedBy = 1;
                        specificationToUpdate.CreatedOn = DateTime.Now;
                        if (specification.TotalInstockQuantity == 0)
                            specificationToUpdate.TotalInstockQuantity = specification.PurchasedQuantity;

                        _unitOfWork.Repository<ProductSpecificationDetail>().Insert(specificationToUpdate);
                    }
                }

                return true;
            }
            catch (Exception e)
            {
                return false;
            }
        }

        [HttpGet]
        public IActionResult Edit(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return RedirectToAction("Index", "Inventory");
            }

            return View("");
        }

        [HttpPost]
        public IActionResult Delete(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return RedirectToAction("Index", "Inventory");
            }

            int result = 0;

            if (result > 0)
            {
                return Json(data: true);
            }

            return Json(data: false);
        }

        private string GetUniqueFileName(string fileName)
        {
            fileName = Path.GetFileName(fileName);
            return Guid.NewGuid().ToString().Substring(0, 8)
                   + Path.GetExtension(fileName);
        }
    }
}