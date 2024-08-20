USE SalesDB
-- Find the highest & lowest sales of all orders
-- Findt the highest & lowest sales for each product
-- Additionally provide details such order ID, order date
SELECT
    OrderID,
    OrderDate,
    ProductID,
    MAX(Sales) OVER(PARTITION BY ProductID) HighestSalesByProduct,
    MIN(Sales) OVER(PARTITION BY ProductID) LowestSalesByProduct,
    MAX(Sales) OVER() HighestSales,
    MIN(Sales) OVER() LowestSales
FROM Sales.Orders;


-- Show the employees who have the highest salaries
SELECT * 
FROM (
    SELECT *,
    MAX(Salary) OVER() HighestSalary
    FROM Sales.Employees
) t WHERE Salary = HighestSalary;


-- Calculate the deviation of each sale from both 
-- the minimum and maximum sales amounts
SELECT
    OrderID,
    OrderDate,
    ProductID,
    MIN(Sales) OVER() LowestSales,
    MAX(Sales) OVER() HighestSales,
    Sales - MIN(Sales) OVER() DeviationFromMin,
    MAX(Sales) OVER() - Sales DeviationFromMax
FROM Sales.Orders;