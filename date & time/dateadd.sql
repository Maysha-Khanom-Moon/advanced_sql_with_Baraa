USE SalesDB

SELECT
    OrderID,
    OrderDate,
    DATEADD(year, 2, OrderDate) AS TwoYearsLater,
    DATEADD(month, 3, OrderDate) AS ThreeMonthsLater,
    DATEADD(day, -10, OrderDate) AS TenDaysBefore
FROM Sales.Orders