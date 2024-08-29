WITH Orders AS (
    SELECT 1 ID, 'A' Category UNION
    SELECT 2, NULL UNION
    SELECT 3, '' UNION
    SELECT 4, '  '
)

SELECT *,
	DATALENGTH (Category) CategoryLen
FROM Orders

/*
# empty string and blank space are looking similar
-- but length is different
*/