USE SalesDB

-- show creation time using the following format:
-- Day Wed Jan Q1 2025 12:34:56 PM
SELECT
    OrderID,
    CreationTime,
    'Day ' + 
    FORMAT(CreationTime, 'ddd MMM ') +
    'Q' + DATENAME(quarter, CreationTime) +
    FORMAT(CreationTime, ' yyyy HH:mm:ss')
    AS CustomeFormat
FROM Sales.Orders