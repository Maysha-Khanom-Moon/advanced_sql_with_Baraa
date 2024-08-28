USE SalesDB
-- Find the sales price for each order by dividing sales by quantity

SELECT
    OrderID,
    Sales,
    Sales / NULLIF(Quantity, 0) AS Price
FROM Sales.Orders