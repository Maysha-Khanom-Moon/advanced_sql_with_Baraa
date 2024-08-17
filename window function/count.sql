-- Find the total number of orders
USE SalesDB
SELECT 
    COUNT(*) TotalOrders
FROM Sales.Orders;


-- Find the total number of orders
-- additionally provide details such order ID, order date
SELECT 
    OrderID,
    OrderDate,
    COUNT(1) OVER() TotalOrders
FROM Sales.Orders;


-- Find the total orders for each customers
SELECT 
    OrderID,
    OrderDate,
	CustomerID,
    COUNT(1) OVER() TotalOrders,
	COUNT(*) OVER(PARTITION BY CustomerID) OrdersByCustomers
FROM Sales.Orders;


-- Find the total number of customers,
-- additionally provide all customer's details
SELECT
    *,
    COUNT(1) OVER() TotalCustomers
FROM Sales.Customers;


-- Find the total number of scores and countries for the customers
SELECT
    *,
    COUNT(1) OVER() TotalCustomers,
    COUNT(Score) OVER() TotalScores,
    COUNT(Country) OVER() TotalCountries
FROM Sales.Customers;


-- Check whether the table 'OrdersArchive' contain any duplicate rows
-- 1. find out the primary key then
SELECT
    OrderID,
    COUNT(*) OVER(PARTITION BY OrderID) CheckPK
FROM Sales.OrdersArchive;

-- if we get any CheckPK value more than 1 then those have duplicates