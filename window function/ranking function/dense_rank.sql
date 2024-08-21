USE SalesDB
-- Rank the orders based on their sales from highest to lowest
SELECT
    OrderID,
    ProductID,
    Sales,
    ROW_NUMBER() OVER(ORDER BY Sales DESC) SalesRank_Row,
    RANK() OVER(ORDER BY Sales DESC) SalesRank_Rank,
    DENSE_RANK() OVER(ORDER BY Sales DESC) SalesRank_Dense
FROM Sales.Orders;

-- dense_rank()
-- same value have same row rank
-- but don't skip the rank