USE SalesDB;

SELECT 
OrderID,
OrderDate,
OrderStatus,
Sales,
-- SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY 
-- OrderDate ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING)
-- SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY 
-- OrderDate ROWS BETWEEN 2 PRECEDING AND CURRENT ROW)
SUM(Sales) OVER(PARTITION BY OrderStatus ORDER BY 
OrderDate ROWS 2 PRECEDING) TotalSales
FROM Sales.Orders;


-- Find the total sales for each order status 
-- only for 2 products 101, 102
SELECT
    OrderID,
    OrderDate,
    OrderStatus,
	ProductID,
    Sales,
    SUM(Sales) OVER(PARTITION BY OrderStatus) TotalSales
FROM Sales.Orders
WHERE ProductID IN(101, 102);


-- rank customers based on their total sales
-- as we don't have to show details so we can choose group by
-- but for group by their is no rank function so we will use window and group by together
-- steps:
--     1. build the query using group by
--     2. then add the window function
SELECT
    CustomerID,
    SUM(Sales) TotalSales,
	RANK() OVER(ORDER BY SUM(Sales))
FROM Sales.Orders
GROUP BY CustomerID