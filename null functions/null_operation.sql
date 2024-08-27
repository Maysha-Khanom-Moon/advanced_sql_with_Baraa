USE SalesDB
/*
Display the full name of customers in a single field
by merging their first and last names,
and add 10 bonus points to each customer's score
*/
SELECT
    CustomerID,
    FirstName,
    LastName,
    FirstName + ' ' + LastName AS FullName,
	-- Mary full name is NULL. although she has the firstname

	COALESCE(LastName, '') LastName2,
    FirstName + COALESCE(LastName, '') AS FullName2,
    Score,
	Score + 10 AS ScoreWithBonus,
	COALESCE(Score, 0) + 10 AS ScoreWithBonus2
FROM Sales.Customers