USE SalesDB

-- # datetrunc
-- how many orders were placed each year?
SELECT
    YEAR(OrderDate) Year,
    COUNT(*) NumOfOrders
FROM Sales.Orders
GROUP BY YEAR(OrderDate);


-- how many orders were placed each month?
SELECT
    -- MONTH(OrderDate) Month,
    DATENAME(month, OrderDate) as OrderDate,
    COUNT(*) NumOfOrders
FROM Sales.Orders
GROUP BY DATENAME(month, OrderDate);