USE [master]
GO
/****** Object:  Database [inventory_dev]    Script Date: 16-12-2021 03:49:21 PM ******/
CREATE DATABASE [inventory_dev]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'inventory_dev', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\inventory_dev.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'inventory_dev_log', FILENAME = N'C:\Program Files (x86)\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\inventory_dev_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [inventory_dev] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [inventory_dev].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [inventory_dev] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [inventory_dev] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [inventory_dev] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [inventory_dev] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [inventory_dev] SET ARITHABORT OFF 
GO
ALTER DATABASE [inventory_dev] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [inventory_dev] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [inventory_dev] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [inventory_dev] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [inventory_dev] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [inventory_dev] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [inventory_dev] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [inventory_dev] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [inventory_dev] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [inventory_dev] SET  DISABLE_BROKER 
GO
ALTER DATABASE [inventory_dev] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [inventory_dev] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [inventory_dev] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [inventory_dev] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [inventory_dev] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [inventory_dev] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [inventory_dev] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [inventory_dev] SET RECOVERY FULL 
GO
ALTER DATABASE [inventory_dev] SET  MULTI_USER 
GO
ALTER DATABASE [inventory_dev] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [inventory_dev] SET DB_CHAINING OFF 
GO
ALTER DATABASE [inventory_dev] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [inventory_dev] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [inventory_dev] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'inventory_dev', N'ON'
GO
USE [inventory_dev]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 16-12-2021 03:49:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Orders](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ProductSpecificationId] [bigint] NOT NULL,
	[OrderId] [nvarchar](50) NULL,
	[PlatformId] [int] NOT NULL,
	[NoOfUnitSold] [int] NOT NULL,
	[Other] [nvarchar](500) NULL,
	[IsActive] [bit] NOT NULL CONSTRAINT [DF_Table_1_IsActive1]  DEFAULT ((1)),
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Table_1_IsDeleted1]  DEFAULT ((0)),
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [bigint] NULL,
 CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Platform]    Script Date: 16-12-2021 03:49:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Platform](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Code] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Platform] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 16-12-2021 03:49:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductCategory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Code] [nvarchar](10) NULL,
 CONSTRAINT [PK_ProductCategory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductPurchaseHistory]    Script Date: 16-12-2021 03:49:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductPurchaseHistory](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ProductSpecificationId] [bigint] NOT NULL,
	[Name] [nvarchar](200) NULL,
	[PurchasedQuantity] [int] NOT NULL,
	[PricePerUnit] [decimal](18, 0) NULL,
	[PurchasedDate] [datetime] NOT NULL,
	[Other] [nvarchar](500) NULL,
	[IsActive] [bit] NOT NULL CONSTRAINT [DF_ProductPurchaseHistory_IsActive]  DEFAULT ((1)),
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_ProductPurchaseHistory_IsDeleted]  DEFAULT ((0)),
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [bigint] NULL,
 CONSTRAINT [PK_ProductPurchaseHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Products]    Script Date: 16-12-2021 03:49:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[Description] [nvarchar](1000) NULL,
	[Quantity] [int] NOT NULL,
	[Price] [decimal](18, 0) NOT NULL,
	[IsGstOrder] [bit] NOT NULL CONSTRAINT [DF_Products_IsGstOrder]  DEFAULT ((0)),
	[GstAmount] [decimal](18, 0) NULL,
	[TransportationAmount] [decimal](18, 0) NULL,
	[OtherAmount] [decimal](18, 0) NULL,
	[SellingPrice] [decimal](18, 0) NULL,
	[SKU] [nvarchar](50) NULL,
	[Barcode] [nvarchar](50) NULL,
	[Address] [nvarchar](1000) NULL,
	[City] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
	[ProductCategoryId] [int] NULL,
	[IsActive] [bit] NOT NULL CONSTRAINT [DF_Products_IsActive]  DEFAULT ((1)),
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_Products_IsDeleted]  DEFAULT ((0)),
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [bigint] NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductSpecificationDetail]    Script Date: 16-12-2021 03:49:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSpecificationDetail](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ProductId] [bigint] NOT NULL,
	[ProductCategoryId] [int] NULL,
	[SpecificationId] [int] NULL,
	[PurchasedQuantity] [int] NULL,
	[TotalInstockQuantity] [int] NULL,
	[PricePerPiece] [decimal](18, 0) NULL,
	[SellingPricePerPiece] [decimal](18, 0) NULL,
	[FileName] [nvarchar](200) NULL,
	[Other] [nvarchar](200) NULL,
	[IsActive] [bit] NOT NULL CONSTRAINT [DF_ProductSpecificationRelationship_IsActive]  DEFAULT ((1)),
	[IsDeleted] [bit] NOT NULL CONSTRAINT [DF_ProductSpecificationRelationship_IsDeleted]  DEFAULT ((0)),
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [bigint] NULL,
 CONSTRAINT [PK_ProductSpecificationRelationship] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ProductSpecifications]    Script Date: 16-12-2021 03:49:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSpecifications](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[Code] [nvarchar](10) NULL,
 CONSTRAINT [PK_ProductSpecifications] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Users]    Script Date: 16-12-2021 03:49:21 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](200) NULL,
	[Mobile] [nvarchar](50) NULL,
	[Email] [nvarchar](200) NULL,
	[Password] [nvarchar](200) NULL,
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
	[CreatedOn] [datetime] NOT NULL,
	[CreatedBy] [bigint] NOT NULL,
	[ModifiedOn] [datetime] NULL,
	[ModifiedBy] [bigint] NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
USE [master]
GO
ALTER DATABASE [inventory_dev] SET  READ_WRITE 
GO
