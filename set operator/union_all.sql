 USE SalesDB

-- Combine the data from employees and customers into one table
SELECT 
    FirstName,
    LastName
FROM Sales.Customers;
SELECT
    FirstName,
    LastName
FROM Sales. Employees