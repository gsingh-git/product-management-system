USE [master]
GO
/****** Object:  Database [inventory_dev]    Script Date: 20/08/2021 20:10:10 ******/
CREATE DATABASE [inventory_dev]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'inventory_dev', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\inventory_dev.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'inventory_dev_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER\MSSQL\DATA\inventory_dev_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
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
EXEC sys.sp_db_vardecimal_storage_format N'inventory_dev', N'ON'
GO
USE [inventory_dev]
GO
/****** Object:  Table [dbo].[ProductCategory]    Script Date: 20/08/2021 20:10:10 ******/
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
/****** Object:  Table [dbo].[Products]    Script Date: 20/08/2021 20:10:11 ******/
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
/****** Object:  Table [dbo].[ProductSpecificationDetail]    Script Date: 20/08/2021 20:10:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductSpecificationDetail](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[ProductId] [bigint] NOT NULL,
	[SpecificationId] [int] NULL,
	[Quantity] [int] NULL,
	[PricePerPiece] [decimal](18, 0) NULL,
	[SellingPricePerPiece] [decimal](18, 0) NULL,
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
/****** Object:  Table [dbo].[ProductSpecifications]    Script Date: 20/08/2021 20:10:11 ******/
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
/****** Object:  Table [dbo].[Users]    Script Date: 20/08/2021 20:10:11 ******/
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
SET IDENTITY_INSERT [dbo].[ProductCategory] ON 
GO
INSERT [dbo].[ProductCategory] ([Id], [Name], [Code]) VALUES (1, N'Other', N'OT')
GO
INSERT [dbo].[ProductCategory] ([Id], [Name], [Code]) VALUES (2, N'Packing Material', N'PM')
GO
INSERT [dbo].[ProductCategory] ([Id], [Name], [Code]) VALUES (3, N'Women Suit', N'WS')
GO
INSERT [dbo].[ProductCategory] ([Id], [Name], [Code]) VALUES (4, N'Women Dress', N'WD')
GO
INSERT [dbo].[ProductCategory] ([Id], [Name], [Code]) VALUES (5, N'Women Top', N'WT')
GO
INSERT [dbo].[ProductCategory] ([Id], [Name], [Code]) VALUES (6, N'Women Kurti', N'WK')
GO
INSERT [dbo].[ProductCategory] ([Id], [Name], [Code]) VALUES (7, N'Men Shirt', N'MS')
GO
INSERT [dbo].[ProductCategory] ([Id], [Name], [Code]) VALUES (8, N'Men TShirt', N'MT')
GO
SET IDENTITY_INSERT [dbo].[ProductCategory] OFF
GO
SET IDENTITY_INSERT [dbo].[ProductSpecifications] ON 
GO
INSERT [dbo].[ProductSpecifications] ([Id], [Name], [Code]) VALUES (1, N'Other', N'OT')
GO
INSERT [dbo].[ProductSpecifications] ([Id], [Name], [Code]) VALUES (2, N'Size-Small', N'SS')
GO
INSERT [dbo].[ProductSpecifications] ([Id], [Name], [Code]) VALUES (3, N'Size-Medium', N'SM')
GO
INSERT [dbo].[ProductSpecifications] ([Id], [Name], [Code]) VALUES (4, N'Size-Large', N'SL')
GO
INSERT [dbo].[ProductSpecifications] ([Id], [Name], [Code]) VALUES (5, N'Size-XL', N'SXL')
GO
INSERT [dbo].[ProductSpecifications] ([Id], [Name], [Code]) VALUES (6, N'Size-XXL', N'S2XL')
GO
INSERT [dbo].[ProductSpecifications] ([Id], [Name], [Code]) VALUES (7, N'Size-XXXL', N'S3XL')
GO
SET IDENTITY_INSERT [dbo].[ProductSpecifications] OFF
GO
SET IDENTITY_INSERT [dbo].[Users] ON 
GO
INSERT [dbo].[Users] ([Id], [Name], [Mobile], [Email], [Password], [IsActive], [IsDeleted], [CreatedOn], [CreatedBy], [ModifiedOn], [ModifiedBy]) VALUES (1, N'Gagandeep Singh', N'9650402710', N'eng.gagandeepsingh@gmail.com', N'gagan123', 1, 0, GETDATE(), 1, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Users] OFF
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
