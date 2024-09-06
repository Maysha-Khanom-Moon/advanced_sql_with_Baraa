/* Find the products that have a price 
        higher than the average price of all products */

-- we need subquery because window function only can use in SELECT or ORDER BY clauses
USE SalesDB
-- main query
SELECT 
	* 
FROM (
	-- subquery
	SELECT
		ProductID,
		Price,
		AVG(Price) OVER() AvgPrice
	FROM Sales.Products
) t
WHERE price > AvgPrice;


-- Rank customers based on their total amount of sales
SELECT
    *
FROM (
	SELECT
		CustomerID,
		SUM(Sales) TotalSales
	FROM Sales.Orders
    GROUP BY CustomerID
) t