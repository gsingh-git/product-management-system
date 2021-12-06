using System;
using System.Linq;
using Microsoft.AspNetCore.Mvc;

namespace PMS.Controllers
{
    public class GridController : Controller
    {
        private readonly DatabaseContext _context;

        public GridController(DatabaseContext context)
        {
            _context = context;
        }

        public IActionResult Index()
        {
            return View();
        }


        public IActionResult LoadData()
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
            var products = (from product in _context.Products
                select product);

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
            //Returning Json Data
            var jsonData = new {draw, recordsFiltered = recordsTotal, recordsTotal, data = productEntities};
            return Ok(jsonData);
        }

        [HttpGet]
        public IActionResult Edit(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return RedirectToAction("Index", "Grid");
            }

            return View("");
        }

        [HttpPost]
        public IActionResult Delete(string id)
        {
            if (string.IsNullOrEmpty(id))
            {
                return RedirectToAction("Index", "Grid");
            }

            int result = 0;

            if (result > 0)
            {
                return Json(data: true);
            }

            return Json(data: false);
        }
    }
}