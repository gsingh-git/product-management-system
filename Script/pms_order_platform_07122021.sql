USE [inventory_dev]
GO
/****** Object:  Table [dbo].[Orders]    Script Date: 07-12-2021 11:31:25 AM ******/
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
	[IsActive] [bit] NOT NULL,
	[IsDeleted] [bit] NOT NULL,
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
/****** Object:  Table [dbo].[Platform]    Script Date: 07-12-2021 11:31:25 AM ******/
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
SET IDENTITY_INSERT [dbo].[Platform] ON 

INSERT [dbo].[Platform] ([Id], [Name], [Code]) VALUES (1, N'Amazon', N'AMZ')
INSERT [dbo].[Platform] ([Id], [Name], [Code]) VALUES (2, N'FlipKart', N'FLK')
INSERT [dbo].[Platform] ([Id], [Name], [Code]) VALUES (3, N'Meesho', N'MSH')
INSERT [dbo].[Platform] ([Id], [Name], [Code]) VALUES (4, N'Other', N'OTH')
INSERT [dbo].[Platform] ([Id], [Name], [Code]) VALUES (5, N'Offline', N'OFL')
SET IDENTITY_INSERT [dbo].[Platform] OFF
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Table_1_IsActive1]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Orders] ADD  CONSTRAINT [DF_Table_1_IsDeleted1]  DEFAULT ((0)) FOR [IsDeleted]
GO
