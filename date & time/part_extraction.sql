USE SalesDB

SELECT
    OrderID,
    CreationTime,
    DATEPART(year, CreationTime) Year_dp,
    DATEPART(month, CreationTime) Month_dp,
    DATEPART(day, CreationTime) Day_dp,
    DATEPART(hour, CreationTime) Hour_dp,
    DATEPART(quarter, CreationTime) Quarter_dp,
    DATEPART(week, CreationTime) Weekday_dp,
    YEAR(CreationTime) AS Year,
    MONTH(CreationTime) AS Month,
    DAY(CreationTime) AS Day
FROM Sales.Orders