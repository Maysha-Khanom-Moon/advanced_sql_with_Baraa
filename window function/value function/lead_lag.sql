USE SalesDB

-- Analyze the month-over-month(MoM) performance by finding the percentage change
-- in sales between the current and previous month
SELECT 
    *,
    CurrentMonthSales - PreviousMonthSales MoM_Change,
    ROUND(CAST((CurrentMonthSales - PreviousMonthSales) AS FLOAT) / PreviousMonthSales * 100, 1) MoM_Perc
FROM (
    SELECT
        MONTH(OrderDate) OrderMonth,
        SUM(Sales) CurrentMonthSales,
        LAG(SUM(Sales)) OVER (ORDER BY MONTH(OrderDate)) PreviousMonthSales
    FROM Sales.Orders
    GROUP BY
    MONTH(OrderDate)
) t