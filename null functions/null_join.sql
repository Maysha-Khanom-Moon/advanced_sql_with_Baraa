USE SalesDB
-- join customers and employees table
SELECT
    CustomerID,
-- using unique identifier is must, if common columns occur in both table
-- it's usually better to join on unique identifiers
-- we see a clear map about selected columns
	a.FirstName,
	a.LastName,
	Country,
	Gender,
	BirthDate,
	Score,
	Salary
FROM Sales.Customers AS a
JOIN Sales.Employees AS b
ON 
    a.FirstName = b.FirstName 
    AND
    ISNULL(a.LastName, '') = ISNULL(b.LastName, '')