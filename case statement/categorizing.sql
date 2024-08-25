USE SalesDB
/* Create report showing total sales for each of the following categories:
    High (sales over 50), Medium (sales 21-50), and low (sales 20 or less)
    Sort the categories form highest sales to lowest
*/
SELECT
	Category,
	SUM(Sales) as TotalSales
FROM(
	SELECT
		OrderID,
		Sales,
		CASE
			WHEN Sales > 50 THEN 'High'
			WHEN Sales > 20 THEN 'Medium'
			ELSE 'Low'
		END Category
	FROM Sales.Orders
) t
GROUP BY Category
Order BY TotalSales DESC