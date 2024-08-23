USE SalesDB

-- Find the lowest and highest sales for each product
-- Find the difference in sales between the current and the lowest sales
SELECT 
    OrderID,
    ProductID,
    Sales,
    FIRST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales) LowestSales,
    MIN(Sales) OVER (PARTITION BY ProductID) LowestSales2,
    LAST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales ROWS BETWEEN CURRENT ROW AND UNBOUNDED FOLLOWING) HighestSales,
    FIRST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales DESC) HighestSales2,
    MAX(Sales) OVER (PARTITION BY ProductID) HighestSales3,
    Sales - FIRST_VALUE(Sales) OVER (PARTITION BY ProductID ORDER BY Sales) SalesDifference
FROM Sales.Orders