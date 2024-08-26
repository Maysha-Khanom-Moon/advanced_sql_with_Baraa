USE SalesDB
-- Retrive employee details with gender displayed as full text
SELECT
    EmployeeID,
    FirstName,
    LastName,
    Gender,
    CASE
        WHEN Gender = 'F' THEN 'Female'
        WHEN Gender = 'M' THEN 'Male'
        ELSE 'Not Avaiable'
    END GenderFullText
FROM Sales.Employees;


-- Retrive customers details with abbreviated country code
-- step 1
SELECT DISTINCT Country
FROM Sales.Customers;

-- step 2
-- full format
SELECT
    CustomerID,
    FirstName,
    LastName,
    Country,
    CASE
        WHEN Country = 'Germany' THEN 'DE'
        WHEN Country = 'USA' THEN 'US'
        ELSE 'n/a'
    END CountryAbbr
FROM Sales.Customers

-- quick form
SELECT
    CustomerID,
    FirstName,
    LastName,
    Country,
    CASE Country
        WHEN 'Germany' THEN 'DE'
        WHEN 'USA' THEN 'US'
        ELSE 'n/a'
    END CountryAbbr
FROM Sales.Customers