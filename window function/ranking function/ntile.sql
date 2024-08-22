USE SalesDB

SELECT 
    OrderID,
    Sales,
    NTILE(1) OVER(ORDER BY Sales DESC) OneBucket,
    NTILE(2) OVER(ORDER BY Sales DESC) TwoBucket,
    NTILE(3) OVER(ORDER BY Sales DESC) ThreeBucket,
	NTILE(4) OVER(ORDER BY Sales DESC) FourBucket,
    NTILE(5) OVER(ORDER BY Sales DESC) FiveBucket,
	NTILE(6) OVER(ORDER BY Sales DESC) SixBucket
FROM Sales.Orders


-- # data segmentation
-- Segment all orders into 3 categories: high, medium and low sales
SELECT *,
CASE WHEN Buckets = 1 THEN 'High'
	 WHEN Buckets = 2 THEN 'Medium'
     WHEN Buckets = 3 THEN 'Low'
END SalesSegmentations
FROM (
    SELECT
        OrderID,
        Sales,
        NTILE(3) OVER(ORDER BY Sales DESC) Buckets
    FROM Sales.Orders
) t


-- # equalizing load processing
-- In order to export the data, divide the orders into 2 groups
SELECT
    NTILE(2) OVER(ORDER BY OrderID) Buckets,
    *
FROM Sales.Orders