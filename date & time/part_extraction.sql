USE SalesDB

SELECT
    OrderID,
    CreationTime,

-- year, month, day
    YEAR(CreationTime) AS Year,
    MONTH(CreationTime) AS Month,
    DAY(CreationTime) AS Day,

-- datepart --> integer
    DATEPART(year, CreationTime) Year_dp,
    DATEPART(month, CreationTime) Month_dp,
    DATEPART(day, CreationTime) Day_dp,
    DATEPART(hour, CreationTime) Hour_dp,
    DATEPART(quarter, CreationTime) Quarter_dp,
    DATEPART(week, CreationTime) Weekday_dp,

-- datename --> string
    DATENAME(month, CreationTime) Month_dn,
    DATENAME(weekday, CreationTime) Weekday_dn,
    DATENAME(day, CreationTime) Day_dn
FROM Sales.Orders