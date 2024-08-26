USE SalesDB
-- Count how many times each customer has made an order with sales greater than 30

-- step 1
-- create flag with binary values(0, 1) to mark rows that meet certain criteria

-- step 2
-- summarize the binary flag
SELECT
    CustomerID,
    SUM(
		CASE
			WHEN Sales > 30 THEN 1
			ELSE 0
		END
	) TotalOrderHighSales,
	COUNT(*) TotalOrders
FROM Sales.Orders
GROUP BY CustomerID