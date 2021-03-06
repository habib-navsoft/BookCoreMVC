USE [BookShop_DB]
GO
/****** Object:  Table [dbo].[Author]    Script Date: 4/12/2021 3:10:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Author](
	[aID] [int] IDENTITY(1,1) NOT NULL,
	[firstName] [nvarchar](100) NOT NULL,
	[lastName] [nvarchar](100) NULL,
 CONSTRAINT [PK_Author] PRIMARY KEY CLUSTERED 
(
	[aID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Books]    Script Date: 4/12/2021 3:10:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Books](
	[bID] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](255) NOT NULL,
	[isbnNo] [nvarchar](50) NOT NULL,
	[published] [datetime] NULL,
	[cID] [int] NOT NULL,
 CONSTRAINT [PK_Books] PRIMARY KEY CLUSTERED 
(
	[bID] ASC,
	[isbnNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Books_Details]    Script Date: 4/12/2021 3:10:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Books_Details](
	[bID] [int] NOT NULL,
	[aID] [int] NOT NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Category]    Script Date: 4/12/2021 3:10:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[cID] [int] IDENTITY(1,1) NOT NULL,
	[title] [nvarchar](150) NOT NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[cID] ASC,
	[title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Author] ON 

GO
INSERT [dbo].[Author] ([aID], [firstName], [lastName]) VALUES (1, N'Wasim', N'Akram')
GO
INSERT [dbo].[Author] ([aID], [firstName], [lastName]) VALUES (2, N'Golam', N'Habib')
GO
INSERT [dbo].[Author] ([aID], [firstName], [lastName]) VALUES (3, N'John', N'Karry')
GO
SET IDENTITY_INSERT [dbo].[Author] OFF
GO
SET IDENTITY_INSERT [dbo].[Books] ON 

GO
INSERT [dbo].[Books] ([bID], [title], [isbnNo], [published], [cID]) VALUES (1, N'Java', N'J1234', CAST(N'2021-11-04 00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[Books] ([bID], [title], [isbnNo], [published], [cID]) VALUES (2, N'JQuery', N'JQ323', CAST(N'2021-11-04 00:00:00.000' AS DateTime), 2)
GO
INSERT [dbo].[Books] ([bID], [title], [isbnNo], [published], [cID]) VALUES (3, N'DotNet CORE', N'DNC001', CAST(N'2021-11-04 00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[Books] ([bID], [title], [isbnNo], [published], [cID]) VALUES (4, N'C#', N'C9898', CAST(N'2021-04-11 14:43:15.427' AS DateTime), 2)
GO
SET IDENTITY_INSERT [dbo].[Books] OFF
GO
INSERT [dbo].[Books_Details] ([bID], [aID]) VALUES (1, 1)
GO
INSERT [dbo].[Books_Details] ([bID], [aID]) VALUES (2, 2)
GO
INSERT [dbo].[Books_Details] ([bID], [aID]) VALUES (1, 2)
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

GO
INSERT [dbo].[Category] ([cID], [title]) VALUES (1, N'Fiction')
GO
INSERT [dbo].[Category] ([cID], [title]) VALUES (2, N'Science')
GO
INSERT [dbo].[Category] ([cID], [title]) VALUES (3, N'Life')
GO
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [UQ__Books__AA06B8B0CC83F6F6]    Script Date: 4/12/2021 3:10:17 PM ******/
ALTER TABLE [dbo].[Books] ADD  CONSTRAINT [UQ__Books__AA06B8B0CC83F6F6] UNIQUE NONCLUSTERED 
(
	[isbnNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[sp_BookSearch]    Script Date: 4/12/2021 3:10:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[sp_BookSearch]-- null,null,' Hawking',null
(
@title nvarchar(150) =null,
@isbnNo nvarchar(100) =null,
@author nvarchar(200) =null,
@category nvarchar(300) =null
)
AS
BEGIN


select b.bid,b.title,b.isbnNo,b.published,c.title,
(a.firstName + ' ' + a.lastName)as authorName
from books b
left join category c on c.cID =b.cID
left join books_details d on d.bID =b.bID
left join author a on a.aID =d.aID
where
b.title = isnull(@title,b.title)
and b.isbnNo =isnull(@isbnNo,b.isbnNo)
and (a.firstName + ' ' + a.lastName) like isnull('%' + @author +'%',(a.firstName + ' ' + a.lastName))
and c.title = isnull(@category,c.title)
order by b.title

END

GO
/****** Object:  StoredProcedure [dbo].[sp_GetCategory]    Script Date: 4/12/2021 3:10:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetCategory] 
 @title nvarchar(150) = null
AS
BEGIN
   SET NOCOUNT ON;
   SELECT * FROM Category where title =isNull(@title, title)
END

GO
/****** Object:  StoredProcedure [dbo].[sp_InsertUpdateDelete_Bookes]    Script Date: 4/12/2021 3:10:18 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create PROCEDURE [dbo].[sp_InsertUpdateDelete_Bookes]     
          
(         
 @bID int=0,  
 @title nvarchar(510)=null,
 @isbnNo nvarchar(100)=null,
 @published datetime=null,
 @cID int=0,
 @aID int=0,       
 @ActionFlg varchar(1),    
 @PKValue int=0 output          
)          
AS          
          
BEGIN         
    
if(@ActionFlg ='S')    
 BEGIN
 
  INSERT INTO books(title,isbnNo,published,cID) 
  values(@title,@isbnNo,@published,@cID)          
  Set @PKValue=(SELECT SCOPE_IDENTITY());       
  if(@PKValue <>0)
	begin
	INSERT INTO books_details(bID,aID) 
	values(@PKValue,@aID)          
	end
 END    
else if(@ActionFlg ='U')    
 BEGIN
 
  UPDATE books SET title=@title,isbnNo=@isbnNo,published=@published,cID=@cID
  where bID =@bID  
  Set @PKValue=@bID;     

  UPDATE books_details SET bID=@bID,aID=@aID
  where bID =@bID;  

 END    
else if(@ActionFlg ='D')    
 BEGIN 
 
  DELETE from books where bID =@bID   
  Set @PKValue=@bID

  DELETE from books_details where bID =@bID   

 END    
          
RETURN @PKValue     

End
