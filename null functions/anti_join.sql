USE SalesDB

-- list all details for customers who have not placed any orders
SELECT
    c.*,
    o.OrderID
FROM Sales.Customers c
LEFT JOIN Sales.Orders o 
ON c.CustomerID = o.CustomerID
WHERE o.CustomerID IS NULL;