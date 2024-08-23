USE SalesDB

-- Analyze customer loyalty by ranking customers
-- based on the average number of days between orders
SELECT
    CustomerID,
    AVG(DaysUntilNextOrder) AvgDays,
	RANK() OVER (ORDER BY COALESCE(AVG(DaysUntilNextOrder), 999999)) RankAvg
FROM (
    SELECT
        OrderID,
        CustomerID,
        OrderDate CurrentOrder,
        LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate) NextOrder,
        DATEDIFF(day, OrderDate, LEAD(OrderDate) OVER(PARTITION BY CustomerID ORDER BY OrderDate)) DaysUntilNextOrder
    FROM Sales.Orders
) t
GROUP BY 
    CustomerID