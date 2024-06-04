USE [Car_Management]
GO
/****** Object:  Table [dbo].[CarInfo]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CarInfo](
	[CarId] [int] IDENTITY(1,1) NOT NULL,
	[ManufacturerId] [int] NOT NULL,
	[CarTypeId] [int] NOT NULL,
	[TransmissionTypeId] [int] NOT NULL,
	[Engine] [char](4) NOT NULL,
	[BHP] [int] NOT NULL,
	[Mileage] [int] NOT NULL,
	[Seat] [int] NOT NULL,
	[AirBagDetails] [int] NOT NULL,
	[BootSpace] [int] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CarId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CarTransmissionType]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CarTransmissionType](
	[Id] [int] IDENTITY(301,1) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CarType]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CarType](
	[Id] [int] IDENTITY(201,1) NOT NULL,
	[Type] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Manufacturer]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Manufacturer](
	[Id] [int] IDENTITY(101,1) NOT NULL,
	[Name] [nvarchar](255) NOT NULL,
	[ContactNo] [char](10) NOT NULL,
	[RegisteredOffice] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleTable]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleTable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserTable]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTable](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CarInfo]  WITH CHECK ADD FOREIGN KEY([CarTypeId])
REFERENCES [dbo].[CarType] ([Id])
GO
ALTER TABLE [dbo].[CarInfo]  WITH CHECK ADD FOREIGN KEY([TransmissionTypeId])
REFERENCES [dbo].[CarTransmissionType] ([Id])
GO
ALTER TABLE [dbo].[CarInfo]  WITH CHECK ADD  CONSTRAINT [FK_CarInfo_Manufacturer] FOREIGN KEY([ManufacturerId])
REFERENCES [dbo].[Manufacturer] ([Id])
GO
ALTER TABLE [dbo].[CarInfo] CHECK CONSTRAINT [FK_CarInfo_Manufacturer]
GO
ALTER TABLE [dbo].[UserTable]  WITH CHECK ADD  CONSTRAINT [FK_UserTable_RoleTable] FOREIGN KEY([Id])
REFERENCES [dbo].[RoleTable] ([Id])
GO
ALTER TABLE [dbo].[UserTable] CHECK CONSTRAINT [FK_UserTable_RoleTable]
GO
ALTER TABLE [dbo].[CarInfo]  WITH CHECK ADD CHECK  (([Engine] like '[0-9].[0-9]L'))
GO
/****** Object:  StoredProcedure [dbo].[AddCarTransmissionType]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[AddCarTransmissionType] 
@Type nvarchar(255),
@result int output
AS 
BEGIN
if not Exists(select 1 from CarTransmissionType where type = @type)
begin

INSERT INTO CarTransmissionType( Type) VALUES (@Type)
 end
 
if @@ROWCOUNT > 0
	begin
		Set @result = 1;
	end;
else
	begin
		set @result = 0;
	end
END
GO
/****** Object:  StoredProcedure [dbo].[AddManufacturerType]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[AddManufacturerType] 
@Name NVARCHAR(255),
@ContactNo CHAR(10),
@RegisteredOffice NVARCHAR(255),
@result int output
AS 
BEGIN
if Not Exists(select 1 from Manufacturer where Name = @Name and ContactNo=@ContactNo and RegisteredOffice=@RegisteredOffice)
begin 
     INSERT INTO Manufacturer( Name, ContactNo,RegisteredOffice) VALUES (@Name, @ContactNo, @RegisteredOffice)
end
if @@ROWCOUNT > 0
	begin
		Set @result = 1;
	end;
	return @result;
END
GO
/****** Object:  StoredProcedure [dbo].[AdminDeleteCar]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   procedure [dbo].[AdminDeleteCar](@CarId int ,
@result int output)
as begin
if exists(select 1 from carinfo where CarId = @CarId)
	begin
		delete from carinfo
		where CarId = @CarId;

		set @result = 1;
	end;
else
	begin
		set @result=0;
	end
end
GO
/****** Object:  StoredProcedure [dbo].[AdminListCar]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   Procedure [dbo].[AdminListCar]
AS
BEGIN
	
	SELECT [CarId]
      ,[ManufacturerId]
      ,[CarTypeId]
      ,[TransmissionTypeId]
      ,[ManufacturerName]
      ,[Model]
      ,[Type]
      ,[Engine]
      ,[BHP]
      ,[Transmission]
      ,[Mileage]
      ,[Seat]
      ,[AirBagDetails]
      ,[BootSpace]
      ,[Price]
  FROM [dbo].[CarInfo]





END
GO
/****** Object:  StoredProcedure [dbo].[AdminListCarManufacturer]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create    Procedure [dbo].[AdminListCarManufacturer]
AS
BEGIN	
	SELECT Id,Name,ContactNo,RegisteredOffice
  FROM [dbo].[Manufacturer]
END
GO
/****** Object:  StoredProcedure [dbo].[AdminListCarSearch]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   procedure [dbo].[AdminListCarSearch]
@Model nvarchar(100)
as
begin
select * from CarInfo
where model = @Model;
end
GO
/****** Object:  StoredProcedure [dbo].[AdminListCarTrans]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create    Procedure [dbo].[AdminListCarTrans]
AS
BEGIN	
	SELECT Id,Type
  FROM [dbo].[CarTransmissionType]
END
GO
/****** Object:  StoredProcedure [dbo].[AdminUpdateCar]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE  PROCEDURE [dbo].[AdminUpdateCar](
    @CarId int,
    @ManufacturerId int,
    @CarTypeId int,
    @TransmissiontypeID int,
    @Model nvarchar(100),
    @Engine nvarchar(4),
    @BHP int,
    @Mileage int,
    @Seats int,
    @AirBagDetails int,
    @BootSpace int,
    @Price decimal(18,2),
    @result int output
)
AS 
BEGIN
    -- Declare variables to hold the ManufacturerName, Transmission, and CarType
    DECLARE @ManufacturerName nvarchar(100);
    DECLARE @Transmission nvarchar(100);
    DECLARE @CarType nvarchar(100);

    -- Select the ManufacturerName from the Manufacturer table
    SELECT @ManufacturerName = Name
    FROM Manufacturer
    WHERE Id = @ManufacturerId;

    -- Select the Transmission from the CarTransmissionType table
    SELECT @Transmission = Type
    FROM CarTransmissionType
    WHERE Id = @TransmissiontypeID;

    -- Select the CarType from the CarType table
    SELECT @CarType = Type
    FROM CarType
    WHERE Id = @CarTypeId;

    -- Check if the CarId exists in the Car table
    IF EXISTS (SELECT 1 FROM [dbo].[CarInfo] WHERE CarId = @CarId)
    BEGIN
        -- Update the values in the Car table
        UPDATE CarInfo
        SET ManufacturerId = @ManufacturerId,
            CarTypeId = @CarTypeId,
            TransmissiontypeID = @TransmissiontypeID,
            ManufacturerName = @ManufacturerName,
            Model = @Model,
            Type = @CarType,
            Engine = @Engine,
            BHP = @BHP,
            Transmission = @Transmission,
            Mileage = @Mileage,
            Seat = @Seats,
            [AirBagDetails]= @AirBagDetails,
            BootSpace = @BootSpace,
            Price = @Price
        WHERE CarId = @CarId;

        SET @result = 1;
    END
    ELSE
    BEGIN
        SET @result = 0;
    END
end
GO
/****** Object:  StoredProcedure [dbo].[DeleteCarInfo]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[DeleteCarInfo]

                 @CarId int,
				 @result int output

AS 

BEGIN
		if exists(select 1 from CarInfo where CarId= @CarId)
		begin

      DELETE FROM CarInfo WHERE CarId=@CarId;
	  set @result =1;
	  end
	  else
	  begin
	  set @result= 0;
	  end

END;
GO
/****** Object:  StoredProcedure [dbo].[DeleteCarTransmissionType]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[DeleteCarTransmissionType] (
@Id int,
@result int output)
AS 
	BEGIN
		if exists( select 1 from CarTransmissionType where Id= @Id)
		begin
 
			DELETE FROM CarTransmissionType
			WHERE Id = @Id
 
			set @result=1;
		end
	else
		begin
			set @result=0;
		end
	return @result
	end
GO
/****** Object:  StoredProcedure [dbo].[DeleteManufacturer]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteManufacturer]
@Id int,
@result int output
AS 
BEGIN
if exists( select 1 from Manufacturer where Id= @Id)
begin
	Delete From CarInfo
	where ManufacturerId= @Id;

    DELETE FROM Manufacturer
    WHERE Id = @Id
 
set @result=1;
end
else
begin
set @result=0;
end
end
GO
/****** Object:  StoredProcedure [dbo].[DropDownLISTConstraint]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DropDownLISTConstraint]
AS
	BEGIN
		SELECT Model,[Type],Transmission 
		FROM CarInfo
	END
GO
/****** Object:  StoredProcedure [dbo].[ListCarType]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[ListCarType] 
AS 
BEGIN
     SELECT * FROM CarType
END
GO
/****** Object:  StoredProcedure [dbo].[NewListCar]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   Procedure [dbo].[NewListCar]
AS
BEGIN
	SELECT ManufacturerName,Model,Type,Engine,BHP,Transmission,Mileage,Seat,AirBagDetails,BootSpace,
	Price
	From CarInfo
END
GO
/****** Object:  StoredProcedure [dbo].[p_AddCarType]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   PROCEDURE [dbo].[p_AddCarType] 
@Type nvarchar(50),
@result int output
AS 
BEGIN
if Not Exists(select 1 from CarType where Type = @Type)
begin 
INSERT INTO CarType (Type) VALUES (@Type)
end
if @@ROWCOUNT > 0
	begin
		Set @result = 1;
	end;
	return @result;
END
GO
/****** Object:  StoredProcedure [dbo].[p_allgetCarManufacturer]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   procedure [dbo].[p_allgetCarManufacturer]

as
begin
select * from Manufacturer;
end
GO
/****** Object:  StoredProcedure [dbo].[p_allgetCarTransmissionType]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   procedure [dbo].[p_allgetCarTransmissionType]
as
begin

Select Type,Id from [dbo].[CarTransmissionType];
end
GO
/****** Object:  StoredProcedure [dbo].[p_allgetCarType]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   procedure [dbo].[p_allgetCarType]
as
begin

Select Type,Id from CarType;
end
GO
/****** Object:  StoredProcedure [dbo].[p_checkadmin]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create   procedure [dbo].[p_checkadmin](@userName nvarchar(50),
@password nvarchar(50),
@result int output)
as
begin

	if exists(select 1 from UserTable
	where Username = @userName and Password = @password)
	begin
	set @result = 1;
	end
	else
	begin
		set @result = 0;
	end
end;
GO
/****** Object:  StoredProcedure [dbo].[p_DeleteCarType]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[p_DeleteCarType] 
@Id int,
@result int output
AS 
BEGIN
if exists( select 1 from CarType where Id= @Id)
begin
 
 Delete from  CarInfo
 where CarTypeId = @Id;
    DELETE FROM CarType
    WHERE Id = @Id
 
set @result=1;
end
else
begin
set @result=0;
end
end
GO
/****** Object:  StoredProcedure [dbo].[p_getByIdCarInfo]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create     procedure [dbo].[p_getByIdCarInfo](
@CarId int)
as 
begin
if exists( select 1 from CarInfo where CarId= @CarId)
begin
SELECT * FROM CarInfo WHERE CarId = @CarId
end
end
GO
/****** Object:  StoredProcedure [dbo].[p_getByIdCarType]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[p_getByIdCarType] (
@Id int)
AS 
BEGIN
if exists( select 1 from CarType where Id= @Id)
begin
 
   SELECT * FROM CarType WHERE Id = @Id; 

end
end
GO
/****** Object:  StoredProcedure [dbo].[p_getbyIdManufacturer]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 create     procedure [dbo].[p_getbyIdManufacturer](
@Id int)
as 
begin
if exists( select 1 from Manufacturer where Id= @Id)
begin
SELECT * FROM Manufacturer WHERE Id = @Id
end
end
GO
/****** Object:  StoredProcedure [dbo].[p_getbyIdTrasmissionType]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE   procedure [dbo].[p_getbyIdTrasmissionType](
@Id int)
as 
begin
if exists( select 1 from CarTransmissionType where Id= @Id)
begin
SELECT * FROM CarTransmissionType WHERE Id = @Id
end
end
GO
/****** Object:  StoredProcedure [dbo].[p_UpdateCarType]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[p_UpdateCarType] 
@Id int,
@Type nvarchar(255),
@result int output
AS 
BEGIN
if exists( select 1 from CarType where Id= @Id)
begin
 
    UPDATE CarType
    SET Type=@Type
WHERE Id = @Id
set @result=1;
end
else
begin
set @result=0;
end
end
GO
/****** Object:  StoredProcedure [dbo].[UpdateCarTransmissionType]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateCarTransmissionType] 
@Id int,
@Type nvarchar(255),
@result int output
AS 
BEGIN
if exists( select 1 from CarTransmissionType where Id= @Id)
begin
 
    UPDATE CarTransmissionType
    SET Type=@Type
WHERE Id = @Id
set @result=1;
end
else
begin
set @result=0;
end
end
GO
/****** Object:  StoredProcedure [dbo].[UpdateManufacturer]    Script Date: 6/4/2024 1:05:17 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateManufacturer] 
@Id int,
@Name NVARCHAR(255),
@ContactNo CHAR(10),
@RegisteredOffice NVARCHAR(255),
@result int output
AS 
BEGIN
if exists( select 1 from Manufacturer where Id= @Id)
begin
 
    UPDATE Manufacturer
    SET Name=@Name, ContactNo=@ContactNo, RegisteredOffice=@RegisteredOffice
	WHERE Id = @Id
 
set @result=1;
end
else
begin
set @result=0;
end
end
GO
