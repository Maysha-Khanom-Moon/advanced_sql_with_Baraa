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