-- Rank each order based on their sales from highest to lowest,
-- additionally provide details such order id & order date
SELECT
    OrderID,
    OrderDate,
    Sales,
    RANK() OVER(ORDER BY Sales DESC) RankSales
FROM Sales.Orders