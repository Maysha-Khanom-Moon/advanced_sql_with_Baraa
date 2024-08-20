USE SalesDB
-- Find the total sales for each product
SELECT 
	ProductID,
    SUM(Sales) as TotalSalesByProduct
FROM Sales.Orders 
GROUP BY ProductID;


-- Find the total sales across all orders and 
-- the total sales for each product
-- additionally, provide details such as order ID and order date
SELECT 
    OrderID,
	ProductID,
    OrderDate,
    SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesByProduct,
    SUM(Sales) OVER() TotalSales
FROM Sales.Orders;


-- Find the percentage contribution of each product's sales to the total sales
SELECT
    OrderID,
    ProductID,
    Sales,
    SUM(Sales) OVER() TotalSales,
    ROUND (CAST (Sales AS FLOAT) / SUM(Sales) OVER() * 100, 2) ParcentageOfTotal
FROM Sales.Orders