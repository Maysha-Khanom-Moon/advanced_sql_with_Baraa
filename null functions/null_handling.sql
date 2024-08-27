USE SalesDB
-- Find the average scores of the customers
SELECT
    CustomerID,
    Score,
    AVG(Score) OVER() AvgScores,
    AVG(COALESCE(Score, 0)) OVER() AvgScores2
FROM Sales.Customers