USE SalesDB

SELECT
    CONVERT(INT, '123') AS [String to Int CONVERT],
    CONVERT(Date, '2025-08-20') AS [String to Date CONVERT],
    CONVERT(DATE, CreationTime) AS [Datetime to Date CONVERT],

	CONVERT(varchar, CreationTime, 32) AS [USA Std. Style:32],
	CONVERT(varchar, CreationTime, 34) AS [EURO Std. Style:34]
FROM Sales.Orders;