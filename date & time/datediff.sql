USE SalesDB

-- calculate the age of employees
SELECT
    EmployeeID,
    BirthDate,
    DATEDIFF(year, BirthDate, GETDATE()) Age
FROM Sales.Employees;


-- find the average shipping duration in days for each month
SELECT
	OrderID,
	OrderDate,
	ShipDate,
    DATENAME(month, OrderDate) MonthName,
	DATEDIFF(day, OrderDate, ShipDate) Day2Ship,
	AVG(DATEDIFF(day, OrderDate, ShipDate)) OVER(PARTITION BY MONTH(OrderDate)) AvgShip
FROM Sales.Orders;


-- find the number of days between each order and previous order
SELECT
    OrderID,
    OrderDate CurrentOrderDate,
    LAG(OrderDate) OVER(ORDER BY OrderDate) PreviousOrderDate,
    DATEDIFF(day, LAG(OrderDate) OVER(ORDER BY OrderDate), OrderDate) NumOfDays
FROM Sales.Orders