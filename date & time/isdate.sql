USE SalesDB

SELECT 
    ISDATE('123') DateCheck1,
    ISDATE('2025-08-20') DateCheck2,

-- sql server format: yyyy-MM-dd
-- so for (dd-MM-yyyy): isdate return 0
    ISDATE('20-08-2025') DateCheck3,

-- sql thought: 2025-01-01
-- 4 digit string
	ISDATE('2025') DateCheck4,

-- but month or days can't understand
	ISDATE('08') DateCheck4,

-- without year, sql doesn't work
    ISDATE('20-08') DateCheck5,

-- sql allows: only year | standard format
    ISDATE('2025-08') DateCheck6;



-------
SELECT
    OrderDate,
    -- CAST(OrderDate AS DATE) OrderDate,
    ISDATE(OrderDate) DateType,
    CASE
        WHEN ISDATE(OrderDate) = 1 THEN CAST(OrderDate AS DATE)
		ELSE '9999-01-01'
    END NewOrderDate

FROM (
    SELECT '2025-08-20' AS OrderDate UNION
    SELECT '2025-08-21' UNION
    SELECT '2025-08-23' UNION
    SELECT '2025-08'
) t
-- WHERE ISDATE(OrderDate) = 0