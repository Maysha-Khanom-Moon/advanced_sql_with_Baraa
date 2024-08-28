USE SalesDB
-- Sort the customers from lowest to highest scores,
-- with NULLs appearing last

-- # in case of sorting, sql treats null as the smallest value
-- so before sorting we have to handle nulls

SELECT
    CustomerID,
    Score,
    -- # 1. lazy way
--    COALESCE(Score, 999999) NullHandledScore,

    -- # 2. boolean flag
    CASE WHEN Score IS NULL THEN 1 ELSE 0 END Flag
FROM Sales.Customers
-- 1.
-- ORDER BY COALESCE(Score, 999999)

-- 2.
ORDER BY CASE WHEN Score IS NULL THEN 1 ELSE 0 END, Score
-- first sort the data following Flag then sort again based on Score
