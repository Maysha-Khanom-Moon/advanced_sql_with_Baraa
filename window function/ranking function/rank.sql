USE SalesDB
-- Rank the orders based on their sales from highest to lowest
SELECT
    OrderID,
    ProductID,
    Sales,
    ROW_NUMBER() OVER(ORDER BY Sales DESC) SalesRank_Row,
    RANK() OVER(ORDER BY Sales DESC) SalesRank_Rank
FROM Sales.Orders;

-- same value have same row rank
-- then skip the rank