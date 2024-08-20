USE SalesDB
-- Rank the orders based on their sales from highest to lowest
SELECT
    OrderID,
    ProductID,
    Sales,
    ROW_NUMBER() OVER(ORDER BY Sales DESC) SalesRank_Row
FROM Sales.Orders;

-- same value but distinct row rank