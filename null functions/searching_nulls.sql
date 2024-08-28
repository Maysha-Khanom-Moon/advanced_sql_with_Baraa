USE SalesDB

-- Indentify the customers who have no score
SELECT
    *
FROM Sales.Customers
WHERE Score IS NULL;


-- List all cutomers who have scores
SELECT *
FROM Sales.Customers
WHERE Score IS NOT NULL