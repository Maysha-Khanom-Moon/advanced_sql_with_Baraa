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
FROM Sales.Orders