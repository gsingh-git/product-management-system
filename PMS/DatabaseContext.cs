using Microsoft.EntityFrameworkCore;
using PMS.EntityModel;

namespace PMS
{
    public class DatabaseContext : DbContext
    {
        public DatabaseContext(DbContextOptions<DatabaseContext> options) : base(options)
        {
        }

        public DbSet<Product> Products { get; set; }
        public DbSet<ProductCategory> ProductCategory { get; set; }
        public DbSet<ProductSpecificationDetail> ProductSpecificationDetail { get; set; }
        public DbSet<ProductSpecifications> ProductSpecifications { get; set; }
        public DbSet<Order> Orders { get; set; }
        public DbSet<Platform> Platforms { get; set; }
    }
}