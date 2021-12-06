using PMS.EntityModel;
using PMS.ViewModels;

namespace PMS.Helper
{
    public static class PMSMapper
    {
        public static Product ToEntity(this ProductVM viewModel, Product entityModel)
        {
            entityModel ??= new Product();

            entityModel.Id = viewModel.Id;
            entityModel.Address = viewModel.Address;
            entityModel.Barcode = viewModel.Barcode;
            entityModel.Price = viewModel.Price;
            entityModel.City = viewModel.City;
            entityModel.Description = viewModel.Description;
            entityModel.Quantity = viewModel.Quantity;
            entityModel.State = viewModel.State;
            entityModel.Name = viewModel.Name;
            entityModel.SKU = viewModel.SKU;
            entityModel.ProductCategoryId = viewModel.ProductCategoryId;
            entityModel.IsGstOrder = viewModel.IsGstOrder;
            entityModel.GstAmount = viewModel.GstAmount;
            entityModel.TransportationAmount = viewModel.TransportationAmount;
            entityModel.SellingPrice = viewModel.SellingPrice;
            entityModel.OtherAmount = viewModel.OtherAmount;
            return entityModel;
        }

        public static ProductVM ToViewModel(this Product entityModel)
        {
            if (entityModel == null) return new ProductVM();

            return new ProductVM
            {
                Id = entityModel.Id,
                Address = entityModel.Address,
                Barcode = entityModel.Barcode,
                Price = entityModel.Price,
                City = entityModel.City,
                Description = entityModel.Description,
                Quantity = entityModel.Quantity,
                State = entityModel.State,
                Name = entityModel.Name,
                SKU = entityModel.SKU,
                ProductCategoryId = entityModel.ProductCategoryId ?? 0,
                GstAmount = entityModel.GstAmount ?? 0,
                IsGstOrder = entityModel.IsGstOrder,
                TransportationAmount = entityModel.TransportationAmount ?? 0,
                SellingPrice = entityModel.SellingPrice ?? 0,
                OtherAmount = entityModel.OtherAmount ?? 0
            };
        }

        public static ProductSpecificationDetail ToEntity(this ProductSpecificationVM viewModel,
            ProductSpecificationDetail entityModel)
        {
            entityModel ??= new ProductSpecificationDetail();

            entityModel.Id = viewModel.Id;
            entityModel.PurchasedQuantity = viewModel.PurchasedQuantity;
            entityModel.TotalInstockQuantity = viewModel.TotalInstockQuantity;
            entityModel.PricePerPiece = viewModel.PricePerPiece;
            entityModel.Other = viewModel.Other;
            entityModel.SellingPricePerPiece = viewModel.SellingPricePerPiece;
            entityModel.ProductId = viewModel.ProductId;
            entityModel.SpecificationId = viewModel.SpecificationId;
            entityModel.ProductCategoryId = viewModel.ProductCategoryId;
            entityModel.IsDeleted = viewModel.IsDeleted;
            entityModel.IsActive = viewModel.IsActive;
            entityModel.FileName = viewModel.FileName;

            return entityModel;
        }

        public static ProductSpecificationVM ToViewModel(this ProductSpecificationDetail entityModel)
        {
            if (entityModel == null) return new ProductSpecificationVM();

            return new ProductSpecificationVM
            {
                Id = entityModel.Id,
                PricePerPiece = entityModel.PricePerPiece,
                ProductId = entityModel.ProductId,
                PurchasedQuantity = entityModel.PurchasedQuantity,
                TotalInstockQuantity = entityModel.TotalInstockQuantity,
                Other = entityModel.Other,
                SellingPricePerPiece = entityModel.SellingPricePerPiece,
                SpecificationId = entityModel.SpecificationId,
                ProductCategoryId = entityModel.ProductCategoryId,
                IsDeleted = entityModel.IsDeleted,
                IsActive = entityModel.IsActive,
                FileName = entityModel.FileName
            };
        }
    }
}