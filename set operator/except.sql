USE SalesDB

-- Find the customers who are not employees at the same time
SELECT 
    FirstName,
    LastName
FROM Sales.Customers
EXCEPT
SELECT
    FirstName,
    LastName
FROM Sales.Employees;

-- # here order of queries mattered

-- Find the employees who are not customers at the same time
SELECT
    FirstName,
    LastName
FROM Sales.Employees
EXCEPT
SELECT 
    FirstName,
    LastName
FROM Sales.Customers;