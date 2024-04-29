----- Define the CTE expression name and column list.
WITH Sales_CTE (SalesPersonID, SalesOrderID, SalesYear)
AS
-- Define the CTE query.
(
    SELECT SalesPersonID, SalesOrderID, YEAR(OrderDate) AS SalesYear
    FROM Sales.SalesOrderHeader
    WHERE SalesPersonID IS NOT NULL
)
-- Define the outer query referencing the CTE name.
SELECT SalesPersonID, COUNT(SalesOrderID) AS TotalSales, SalesYear
FROM Sales_CTE
GROUP BY SalesYear, SalesPersonID
ORDER BY SalesPersonID, SalesYear;


-- define CTE:
WITH Cost_by_Month AS
(SELECT campaign_id AS campaign,
       TO_CHAR(created_date, 'YYYY-MM') AS month,
       SUM(cost) AS monthly_cost
FROM marketing
WHERE created_date BETWEEN NOW() - INTERVAL '3 MONTH' AND NOW()
GROUP BY 1, 2
ORDER BY 1, 2)

-- use CTE in subsequent query:
SELECT campaign, avg(monthly_cost) as "Avg Monthly Cost"
FROM Cost_by_Month
GROUP BY campaign
ORDER BY campaign