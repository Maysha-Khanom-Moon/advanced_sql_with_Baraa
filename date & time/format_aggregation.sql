USE SalesDB

-- # data aggregation
SELECT 
    FORMAT(OrderDate, 'MMM yy') OrderDate,
    COUNT(*)
FROM Sales.Orders
GROUP BY FORMAT(OrderDate, 'MMM yy')