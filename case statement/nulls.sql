USE SalesDB

-- Find the average scores of customers and treat nulls as 0 and additional provide details such CustomerID and LastName
SELECT
    CustomerID,
    LastName,
    Score,
    CASE
        WHEN Score IS NULL THEN 0
        ELSE Score
    END ScoreClean,
    AVG(Score) OVER() AvgCustomer,
    AVG(
        CASE
            WHEN Score IS NULL THEN 0
            ELSE Score
        END) OVER() AvgCustomerClean
FROM Sales.Customers