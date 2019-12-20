Use master
go

DROP TABLE IF EXISTS MyRestaurant
go
Create DataBase MyRestaurant
go
USE MyRestaurant
GO

DROP TABLE IF EXISTS DDRestaurantLatin.OrdersItems;
DROP TABLE IF EXISTS DDRestaurantLatin.Items;
DROP TABLE IF EXISTS DDRestaurantLatin.Orders;
DROP TABLE IF EXISTS DDRestaurantLatin.Customers;
DROP TABLE IF EXISTS DDRestaurantLatin.Areas;
DROP TABLE IF EXISTS DDRestaurantLatin.Employees;

DROP SCHEMA IF EXISTS DDRestaurantLatin;
go
CREATE SCHEMA DDRestaurantLatin; 
GO
--CREATE TABLES
CREATE TABLE DDRestaurantLatin.Customers (
    CustomerId INT constraint PKCustomers  PRIMARY KEY IDENTITY (1, 1),
    FirstName VARCHAR (20) NOT NULL,
    LastName VARCHAR (20) NOT NULL,
    PhoneNumber VARCHAR (17) NOT NULL,
    PostCode VARCHAR(6) NOT NULL,
	CustomerAddress VARCHAR (50) NOT NULL,
	AreaId int NOT NULL,
	Email VARCHAR (60),
	Points INT NOT NULL
    );

CREATE TABLE DDRestaurantLatin.Employees(
	EmployeeId INT constraint PKEmployees PRIMARY KEY IDENTITY (1,1),
	FirstName VARCHAR (20) NOT NULL,
	LastName VARCHAR (20) NOT NULL,
	PhoneNumber Varchar (17) NOT NULL,
	Email VARCHAR (60),
	SinNumber VARCHAR (20) NOT NULL,
	EmployeeAddress VARCHAR (50) NOT NULL,
	BirthDate DATE
	);

CREATE TABLE DDRestaurantLatin.Items(
	ItemId INT constraint  PKItems  PRIMARY KEY IDENTITY (1,1),
	ItemName VARCHAR (40) NOT NULL,
	IngredientsSummary VARCHAR(200) NOT NULL,
	Calories INT NOT NULL,
	Price MONEY NOT NULL
	);

CREATE TABLE DDRestaurantLatin.Areas(
	AreaId INT constraint PKAreas PRIMARY KEY IDENTITY(1,1),
	AreaName VARCHAR (20) NOT NULL,
	EmployeeId INT not null
	FOREIGN KEY (EmployeeId) REFERENCES DDRestaurantLatin.Employees(EmployeeId)
	);

CREATE TABLE DDRestaurantLatin.Orders (
OrderId INT constraint PKORDERS  PRIMARY KEY IDENTITY(1,1),
CustomerId INT NOT NULL,
EmployeeId int not null,
OrderDate DateTime not null
FOREIGN KEY (CustomerId) REFERENCES DDRestaurantLatin.Customers(CustomerId),
FOREIGN KEY (EmployeeId) REFERENCES DDRestaurantLatin.Employees(EmployeeId)
);


CREATE TABLE DDRestaurantLatin.OrdersItems (
OrderItemId INT constraint PKOrdersItems PRIMARY KEY IDENTITY(1,1),
Amount INT NOT NULL,
OrderId int not null,
ItemId int not null
FOREIGN KEY (OrderId) REFERENCES DDRestaurantLatin.Orders(OrderId),
FOREIGN KEY (ItemId) REFERENCES DDRestaurantLatin.Items(ItemId)
);

ALTER TABLE DDRestaurantLatin.Customers ALTER COLUMN AreaId int
ALTER TABLE DDRestaurantLatin.Customers
ADD FOREIGN KEY (AreaId) REFERENCES DDRestaurantLatin.Areas(AreaId);



ALTER TABLE DDRestaurantLatin.Orders
add CONSTRAINT ConsOrderDate 
DEFAULT GETDATE() for OrderDate

ALTER TABLE DDRestaurantLatin.Customers
ADD CONSTRAINT CHK_PostCode CHECK (PostCode like '[a-z][0-9][a-z][0-9][a-z][0-9]');
GO  

--PROCEDURES FOR CUSTOMERS
CREATE PROCEDURE DDRestaurantLatin.CustomersInsert @FirstName varchar(20), @LastName varchar(20), 
@PhoneNumber varchar(17), @PostCode varchar(6), @CustomerAddress varchar(50), @AreaId int, @Email varchar(60), @Points int
AS
INSERT INTO DDRestaurantLatin.Customers(FirstName, LastName, PhoneNumber, PostCode, CustomerAddress, AreaId, Email, Points)
VALUES (@FirstName, @LastName, @PhoneNumber, @Postcode, @CustomerAddress, @AreaId, @Email, @Points);
GO

CREATE PROCEDURE DDRestaurantLatin.CustomersUpdate @CustomerId int, @FirstName varchar(20), @LastName varchar(20), 
@PhoneNumber varchar(17), @PostCode varchar(6), @CustomerAddress varchar(50), @AreaId int, @Email varchar(60), @Points int
AS
UPDATE DDRestaurantLatin.Customers
SET FirstName = @FirstName, LastName = @LastName, PhoneNumber = @PhoneNumber, PostCode = @PostCode, CustomerAddress = @CustomerAddress, AreaId = @AreaId, Email = @Email, Points = @Points
WHERE CustomerId = @CustomerId;
GO

CREATE PROCEDURE DDRestaurantLatin.CustomersDelete @CustomerId int 
AS
DELETE FROM DDRestaurantLatin.Customers
WHERE CustomerId = @CustomerId;
GO

--PROCEDURE FOR ITEMS
CREATE PROCEDURE DDRestaurantLatin.ItemsInsert @ItemName varchar(40), @IngredientsSummary varchar(200), 
@Calories int, @Price int
AS

INSERT INTO DDRestaurantLatin.Items(ItemName, IngredientsSummary, Calories, Price)
VALUES (@ItemName, @IngredientsSummary, @Calories, @Price);
GO

CREATE PROCEDURE DDRestaurantLatin.ItemsUpdate @ItemId int, @ItemName varchar(40), @IngredientsSummary varchar(200), 
@Calories int, @Price int
AS

UPDATE DDRestaurantLatin.Items
SET ItemName = @ItemName, IngredientsSummary = @IngredientsSummary, Calories = @Calories, Price = @Price
WHERE ItemId = @ItemId;
GO

CREATE PROCEDURE DDRestaurantLatin.ItemsDelete @ItemId int 
AS
DELETE FROM DDRestaurantLatin.Items
WHERE ItemId = @ItemId;
GO

--PROCEDURE FOR EMPLOYEES
CREATE PROCEDURE DDRestaurantLatin.EmployeesInsert @FirstName varchar(20), @LastName varchar(20), 
@PhoneNumber varchar(17), @Email varchar(60), @SinNumber varchar(20), @EmployeeAddress varchar(50), @BirthDate datetime
AS
INSERT INTO DDRestaurantLatin.Employees(FirstName, LastName, PhoneNumber, Email, SinNumber, EmployeeAddress, BirthDate)
VALUES                                (@FirstName, @LastName, @PhoneNumber, @Email, @SinNumber, @EmployeeAddress, @BirthDate);
GO

CREATE PROCEDURE DDRestaurantLatin.EmployeesUpdate @EmployeeId int, @FirstName varchar(20), @LastName varchar(20), 
@PhoneNumber varchar(17), @Email varchar(60), @SinNumber varchar(20), @EmployeeAddress varchar(50), @BirthDate datetime
AS
UPDATE DDRestaurantLatin.Employees
SET FirstName = @FirstName, LastName = @LastName, PhoneNumber = @PhoneNumber, Email = @Email, SinNumber = @SinNumber, EmployeeAddress = @EmployeeAddress, BirthDate = @BirthDate
WHERE EmployeeId = @EmployeeId;
GO

CREATE PROCEDURE DDRestaurantLatin.EmployeesDelete @EmployeeId int 
AS
DELETE FROM DDRestaurantLatin.Employees
WHERE EmployeeId = @EmployeeId;
GO

CREATE PROCEDURE DDRestaurantLatin.OrdersInsert @CustomerId int, @EmployeeId int, @OrderDate datetime 
AS
INSERT INTO DDRestaurantLatin.Orders(CustomerId, EmployeeId, OrderDate)
VALUES                                (@CustomerId, @EmployeeId, @OrderDate);
GO


--CREATE INDEX
CREATE INDEX ix_Employees_PhoneNumber
ON DDRestaurantLatin.Employees(PhoneNumber)
GO

CREATE INDEX ix_Areas_AreaName
ON DDRestaurantLatin.Areas(AreaName)
GO

CREATE INDEX ix_Customers_PhoneNumber
ON DDRestaurantLatin.Customers(PhoneNumber)
GO

CREATE INDEX ix_Orders_CustomerId
ON DDRestaurantLatin.Orders(CustomerId)
GO

CREATE INDEX ix_Items_ItemName
ON DDRestaurantLatin.Items(ItemName)
GO

CREATE INDEX ix_OrdersItems_OrderId
ON DDRestaurantLatin.OrdersItems(OrderId)
GO

-- Reports
CREATE VIEW Top10SoldProducts  
AS  
Select top 10 i.ItemName, sum(oi.Amount) as amount
from DDRestaurantLatin.Items i
join DDRestaurantLatin.OrdersItems oi
on i.ItemId = oi.ItemId
group by i.ItemName
order by amount desc
GO


CREATE VIEW Top10Customers 
AS  
Select top 5 FirstName, LastName
from DDRestaurantLatin.Customers
order by Points desc
GO

CREATE VIEW Top5Employees  
AS  
Select top 5 FirstName, LastName, count(e.EmployeeId) as Orders
from DDRestaurantLatin.Employees e
join DDRestaurantLatin.Areas a
on e.EmployeeId = a.EmployeeId
group by FirstName, LastName
order by Orders desc
GO

-- FUNCTIONS
CREATE FUNCTION DDRestaurantLatin.Customers_ReturnOrderCount
(
	@PhoneNumber varchar(17),
	@OrderDate date = NULL
)
RETURNS INT
WITH RETURNS NULL ON NULL INPUT, 
	SCHEMABINDING 
AS
	BEGIN
		DECLARE @OutputValue int
		SELECT @OutputValue = Count(*)
		FROM DDRestaurantLatin.Orders o
		JOIN DDRestaurantLatin.Customers c
		ON o.CustomerId = c.CustomerID
		WHERE c.PhoneNumber = @PhoneNumber
			AND (o.OrderDate LIKE @OrderDate OR @OrderDate IS NULL);

		RETURN @OutputValue
			END;
	GO
	

CREATE FUNCTION DDRestaurantLatin.Items_TotalSoldItems
(
	@ItemId int
)
RETURNS INT
WITH RETURNS NULL ON NULL INPUT, 
	SCHEMABINDING 
AS
	BEGIN
		DECLARE @OutputValue int
		SELECT @OutputValue = Sum(Amount)
		FROM DDRestaurantLatin.OrdersItems 
				WHERE ItemId = @ItemId
					RETURN @OutputValue
			END;
	GO

	
