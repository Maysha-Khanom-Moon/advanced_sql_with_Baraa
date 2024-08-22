USE SalesDB

-- Analyze the month-over-month(MoM) performance by finding the percentage change in sales between the current and previous month
SELECT
    OrderID,
    OrderDate,
    Sales,
FROM Sales.Orders