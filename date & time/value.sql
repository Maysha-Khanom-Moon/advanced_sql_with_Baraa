USE SalesDB

SELECT 
	OrderID,
	CreationTime,
	'2025-08-20' HardCoded,
	GETDATE() Today
FROM Sales.Orders