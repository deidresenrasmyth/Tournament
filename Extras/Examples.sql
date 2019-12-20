--DBCC CHECKIDENT ('[DDRestaurantLatin].[Customers]', RESEED, 0);
--GO


EXEC DDRestaurantLatin.CustomersInsert 'Juan', 'Chavez', '647-263-9568','M5L3U5', '569 Pape Avenue', 5, 'helloworld@email.com', 50
SELECT * FROM DDRestaurantLatin.Customers
GO

EXEC DDRestaurantLatin.ItemsInsert 'Pie', 'Chicken', 586, 23.00
SELECT * FROM DDRestaurantLatin.Items
GO

EXEC DDRestaurantLatin.ItemsUpdate 1001, 'Pie', 'Vegetables', 422, 20.50
SELECT * FROM DDRestaurantLatin.Items
GO

EXEC DDRestaurantLatin.ItemsDelete 1001
GO

EXEC DDRestaurantLatin.EmployeesInsert 'Bill', 'Gates', '647-263-9568','bill_gates@hotmail.com', '123456789', '569 Pape Avenue', '1985/07/01'
SELECT * FROM DDRestaurantLatin.Employees
GO

EXEC DDRestaurantLatin.EmployeesUpdate 1001,'Bill', 'Gates', '647-263-9568','bill_gates@hotmail.com', '123456789', '569 Pape Avenue', '1986/07/01'
SELECT * FROM DDRestaurantLatin.Employees
GO

EXEC DDRestaurantLatin.EmployeesDelete 1001
GO

EXEC DDRestaurantLatin.CustomersDelete 1004
GO

EXEC DDRestaurantLatin.OrdersInsert 8, 14, '2018/07/01'
GO

CREATE PROCEDURE DDRestaurantLatin.OrdersInsert @CustomerId int, @EmployeeId int, @OrderDate datetime 


Select * from DDRestaurantLatin.Areas;
Select * from DDRestaurantLatin.Customers;
Select * from DDRestaurantLatin.Employees; 
Select * from DDRestaurantLatin.Items;
Select * from DDRestaurantLatin.Orders;
Select * from DDRestaurantLatin.OrdersItems;

SELECT DDRestaurantLatin.Customers_ReturnOrderCount('891-723-1364', '2019-12-08');
GO

SELECT DDRestaurantLatin.Customers_ReturnOrderCount(20)
GO