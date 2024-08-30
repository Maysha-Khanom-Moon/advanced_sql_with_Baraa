USE SalesDB

-- year, month, day
SELECT
    OrderID,
    CreationTime,
    YEAR(CreationTime) AS Year,
    MONTH(CreationTime) AS Month,
    DAY(CreationTime) AS Day
FROM Sales.Orders;


-- datepart --> integer
SELECT
    OrderID,
    CreationTime,
    DATEPART(year, CreationTime) Year_dp,
    DATEPART(month, CreationTime) Month_dp,
    DATEPART(day, CreationTime) Day_dp,
    DATEPART(hour, CreationTime) Hour_dp,
    DATEPART(quarter, CreationTime) Quarter_dp,
    DATEPART(week, CreationTime) Weekday_dp
FROM Sales.Orders;


-- datename --> string
SELECT
    OrderID,
    CreationTime,
    DATENAME(month, CreationTime) Month_dn,
    DATENAME(weekday, CreationTime) Weekday_dn,
    DATENAME(day, CreationTime) Day_dn
FROM Sales.Orders;


-- datetrunc --> level of details
SELECT
    OrderID,
    CreationTime,
    DATETRUNC(year, CreationTime) Year_dt,
    DATETRUNC(month, CreationTime) Month_dt,
    DATETRUNC(day, CreationTime) Day_dt,
    DATETRUNC(hour, CreationTime) Hour_dt,
    DATETRUNC(minute, CreationTime) Minute_dt
FROM Sales.Orders