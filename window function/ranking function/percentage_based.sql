USE SalesDB
-- Find the products that fall within the highest 40% of the prices
-- # cume_dist()
SELECT * ,
CONCAT(DistRank * 100, '%') DistRankPerc
FROM(
	SELECT
		Product,
		Price,
		CUME_DIST() OVER (ORDER BY Price DESC) DistRank
	FROM Sales.Products
) t 
WHERE DistRank <= 0.4


-- # percent_rank()
SELECT * ,
CONCAT(DistRank * 100, '%') DistRankPerc
FROM(
	SELECT
		Product,
		Price,
		PERCENT_RANK() OVER (ORDER BY Price DESC) DistRank
	FROM Sales.Products
) t 
WHERE DistRank <= 0.4