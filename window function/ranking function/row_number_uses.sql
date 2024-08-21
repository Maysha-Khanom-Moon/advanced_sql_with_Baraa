USE SalesDB

-- top-n analysis
-- Find the top highest sales for each product
SELECT *
FROM (
    SELECT 
        OrderID,
        ProductID,
        Sales,
        ROW_NUMBER() OVER(PARTITION BY ProductID ORDER BY Sales DESC) RankByProduct
    FROM Sales.Orders
) t WHERE RankByProduct = 1;


-- bottom-n analysis
-- Find the lowest 2 customers based on their total sales
SELECT * 
FROM (
    SELECT
        CustomerID,
        SUM(Sales) TotalSales,
        ROW_NUMBER() OVER(ORDER BY SUM(Sales)) RankCustomers
    FROM Sales.Orders
    GROUP BY CustomerID
) t WHERE RankCustomers <= 2;

-- why we are using group by with window function:
-- 1. nesting window function does not allowed
-- group by function also does not allowed nesting directly
-- but we can use group by and window function together
-- columns used in GROUP BY and WINDOW function must be the same
