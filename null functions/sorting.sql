USE SalesDB
-- Sort the customers from lowest to highest scores,
-- with NULLs appearing last

-- # in case of sorting, sql treats null as the smallest value
-- so before sorting we have to handle nulls

SELECT
    CustomerID,
    Score,
    -- # 1. lazy way
    COALESCE(Score, 999999) NullHandledScore
FROM Sales.Customers
ORDER BY COALESCE(Score, 999999)