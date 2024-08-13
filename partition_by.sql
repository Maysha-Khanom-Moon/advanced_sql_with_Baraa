-- Find the total sales across all orders
-- additionally provide details such order id & order date
SELECT 
    OrderID,
    OrderDate,
    SUM(Sales) OVER() TotalSales
FROM Sales.Orders


-- Find the total sales for each product,
-- additionally provide details such order id & order date
SELECT
	ProductID,
    OrderID,
    OrderDate,
    SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesByProduct
FROM Sales.Orders


-- Find the total sales across all orders
-- Find tht total sales for each product
-- additionally provide details such order id, order date
SELECT
    ProductID,
    OrderID,
    OrderDate,
	Sales,
    SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesByProduct,
    SUM(Sales) OVER() TotalSales
FROM Sales.Orders


-- Find the total sales for each combination of product and order status
SELECT
    ProductID,
    OrderID,
    OrderDate,
	Sales,
    OrderStatus,
    SUM(Sales) OVER(PARTITION BY ProductID) TotalSalesByProduct,
    SUM(Sales) OVER() TotalSales,
    SUM(Sales) Over(PARTITION BY ProductID, OrderStatus) SalesByProductAndStatus
FROM Sales.Orders