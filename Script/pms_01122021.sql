USE [inventory_dev]
GO
ALTER TABLE [dbo].[Users] DROP CONSTRAINT [DF_Users_IsDeleted]
GO
ALTER TABLE [dbo].[Users] DROP CONSTRAINT [DF_Users_IsActive]
GO
ALTER TABLE [dbo].[ProductSpecificationDetail] DROP CONSTRAINT [DF_ProductSpecificationRelationship_IsDeleted]
GO
ALTER TABLE [dbo].[ProductSpecificationDetail] DROP CONSTRAINT [DF_ProductSpecificationRelationship_IsActive]
GO
ALTER TABLE [dbo].[Products] DROP CONSTRAINT [DF_Products_IsDeleted]
GO
ALTER TABLE [dbo].[Products] DROP CONSTRAINT [DF_Products_IsActive]
GO
ALTER TABLE [dbo].[Products] DROP CONSTRAINT [DF_Products_IsGstOrder]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 01/12/2021 21:36:23 ******/
DROP TABLE [dbo].[Users]
GO
/****** Object:  Table [dbo].[ProductSpecifications]    Script Date: 01/12/2021 21:36:23 ******/
DROP TABLE [dbo].[ProductSpecifications]
GO
/****** Object:  Table [dbo].[ProductSpecificationDetail]    Script Date: 01/12/2021 21:36:23 ******/
DROP TABLE [dbo].[ProductSpecificationDetail]
GO
/****** Object:  Table [dbo].[Products]    Script Date: 01/12/2021 21:36:23 ******/
DROP TABLE [dbo].[Products]
GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 01/12/2021 21:36:23 ******/
DROP TABLE [dbo].[ProductCategory]
GO
USE [master]
GO
/****** Object:  Database [inventory_dev]    Script Date: 01/12/2021 21:36:23 ******/
DROP DATABASE [inventory_dev]
GO
/****** Object:  Database [inventory_dev]    Script Date: 01/12/2021 21:36:23 ******/
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
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 01/12/2021 21:36:24 ******/
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
/****** Object:  Table [dbo].[Products]    Script Date: 01/12/2021 21:36:24 ******/
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
	[IsGstOrder] [bit] NOT NULL,
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
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
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
/****** Object:  Table [dbo].[ProductSpecificationDetail]    Script Date: 01/12/2021 21:36:24 ******/
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
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
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
/****** Object:  Table [dbo].[ProductSpecifications]    Script Date: 01/12/2021 21:36:24 ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 01/12/2021 21:36:24 ******/
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
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_IsGstOrder]  DEFAULT ((0)) FOR [IsGstOrder]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Products] ADD  CONSTRAINT [DF_Products_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[ProductSpecificationDetail] ADD  CONSTRAINT [DF_ProductSpecificationRelationship_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[ProductSpecificationDetail] ADD  CONSTRAINT [DF_ProductSpecificationRelationship_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [DF_Users_IsDeleted]  DEFAULT ((0)) FOR [IsDeleted]
GO
USE [master]
GO
ALTER DATABASE [inventory_dev] SET  READ_WRITE 
GO

--SET IDENTITY_INSERT [dbo].[ProductCategory] ON 

--GO
--INSERT [dbo].[ProductCategory] ([Id], [Name], [Code]) VALUES (1, N'Other', N'OT')
--GO
--INSERT [dbo].[ProductCategory] ([Id], [Name], [Code]) VALUES (2, N'Packing Material', N'PM')
--GO
--INSERT [dbo].[ProductCategory] ([Id], [Name], [Code]) VALUES (3, N'Women Suit', N'WS')
--GO
--INSERT [dbo].[ProductCategory] ([Id], [Name], [Code]) VALUES (4, N'Women Dress', N'WD')
--GO
--INSERT [dbo].[ProductCategory] ([Id], [Name], [Code]) VALUES (5, N'Women Top', N'WT')
--GO
--INSERT [dbo].[ProductCategory] ([Id], [Name], [Code]) VALUES (6, N'Women Kurti', N'WK')
--GO
--INSERT [dbo].[ProductCategory] ([Id], [Name], [Code]) VALUES (7, N'Women Bra', N'WB')
--GO
--INSERT [dbo].[ProductCategory] ([Id], [Name], [Code]) VALUES (8, N'Men Shirt', N'MS')
--GO
--INSERT [dbo].[ProductCategory] ([Id], [Name], [Code]) VALUES (9, N'Men TShirt', N'MT')
--GO
--SET IDENTITY_INSERT [dbo].[ProductCategory] OFF
--GO
--SET IDENTITY_INSERT [dbo].[ProductSpecifications] ON 

--GO
--INSERT [dbo].[ProductSpecifications] ([Id], [Name], [Code]) VALUES (1, N'Other', N'OT')
--GO
--INSERT [dbo].[ProductSpecifications] ([Id], [Name], [Code]) VALUES (2, N'Size-Small', N'SS')
--GO
--INSERT [dbo].[ProductSpecifications] ([Id], [Name], [Code]) VALUES (3, N'Size-Medium', N'SM')
--GO
--INSERT [dbo].[ProductSpecifications] ([Id], [Name], [Code]) VALUES (4, N'Size-Large', N'SL')
--GO
--INSERT [dbo].[ProductSpecifications] ([Id], [Name], [Code]) VALUES (5, N'Size-XL', N'SXL')
--GO
--INSERT [dbo].[ProductSpecifications] ([Id], [Name], [Code]) VALUES (6, N'Size-XXL', N'S2XL')
--GO
--INSERT [dbo].[ProductSpecifications] ([Id], [Name], [Code]) VALUES (7, N'Size-XXXL', N'S3XL')
--GO
--INSERT [dbo].[ProductSpecifications] ([Id], [Name], [Code]) VALUES (8, N'26', N'26')
--GO
--INSERT [dbo].[ProductSpecifications] ([Id], [Name], [Code]) VALUES (9, N'28', N'28')
--GO
--INSERT [dbo].[ProductSpecifications] ([Id], [Name], [Code]) VALUES (10, N'30', N'30')
--GO
--INSERT [dbo].[ProductSpecifications] ([Id], [Name], [Code]) VALUES (11, N'32', N'32')
--GO
--INSERT [dbo].[ProductSpecifications] ([Id], [Name], [Code]) VALUES (12, N'34', N'34')
--GO
--INSERT [dbo].[ProductSpecifications] ([Id], [Name], [Code]) VALUES (13, N'36', N'36')
--GO
--INSERT [dbo].[ProductSpecifications] ([Id], [Name], [Code]) VALUES (14, N'38', N'38')
--GO
--INSERT [dbo].[ProductSpecifications] ([Id], [Name], [Code]) VALUES (15, N'40', N'40')
--GO
--INSERT [dbo].[ProductSpecifications] ([Id], [Name], [Code]) VALUES (16, N'42', N'42')
--GO
--INSERT [dbo].[ProductSpecifications] ([Id], [Name], [Code]) VALUES (17, N'44', N'44')
--GO
--INSERT [dbo].[ProductSpecifications] ([Id], [Name], [Code]) VALUES (18, N'46', N'46')
--GO
--SET IDENTITY_INSERT [dbo].[ProductSpecifications] OFF
--GO

