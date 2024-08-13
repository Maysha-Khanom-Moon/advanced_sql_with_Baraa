USE SalesDB

-- Find the total Sales Across all orders
-- SELECT SUM(Sales) FROM Sales.Orders;


-- Find the total sales for each product
-- SELECT ProductID, SUM(Sales)
-- FROM Sales.Orders
-- GROUP BY ProductID;


-- Find the total sales for each product, 
-- additionally provide details such order id & order date
-- SELECT 
-- 	OrderID,
-- 	OrderDate,
-- 	ProductID,
-- 	SUM(Sales) TotalSales
-- FROM Sales.Orders
-- group by rule: all columns in select must be included in group by
-- GROUP BY 
--     OrderID,
--     OrderDate,
--     ProductID
-- group by breaks the requirement for each product sales, it works for each order id. so data is not aggregated.

SELECT
	OrderID,
	OrderDate,
    ProductID,
    SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesByProduct
FROM Sales.Orders