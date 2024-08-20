USE SalesDB
-- Find the average sales across all orders
-- and find the average sales for each product
-- additionally provide details such order ID, order date
SELECT
    OrderID,
    ProductID,
    OrderDate,
    Sales,
    AVG(Sales) OVER(PARTITION BY ProductID) AvgSalesByProducts,
    AVG(Sales) OVER() AvgSales
FROM Sales.Orders;


-- Find the average scores of customers
-- additionally provide details such CustomerID and LastName
SELECT 
    CustomerID,
    LastName,
    Score,
    COALESCE(Score, 0) CustomerScore,
    AVG(Score) OVER() AvgScore,
	AVG(COALESCE(Score, 0)) OVER() AvgScoreConsiderNull
FROM Sales.Customers;


-- Find all orders where sales are higher than the average sales across all orders
SELECT *
FROM(
    SELECT
        OrderID,
        ProductID,
        Sales,
        AVG(Sales) OVER() AvgSales,
    FROM Sales.Orders
) t WHERE Sales > AvgSales
