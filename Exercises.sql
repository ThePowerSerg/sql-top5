USE Red30Tech
GO

SELECT * FROM ConventionAttendees
SELECT * FROM EmployeeDirectory
SELECT * FROM Inventory
SELECT * FROM OnlineRetailSales 
SELECT * FROM SessionInfo
SELECT * FROM SpeakerInfo

---- Subquery example
SELECT * FROM OnlineRetailSales
WHERE [Order Total] >= (SELECT AVG([Order Total]) FROM OnlineRetailSales)

-- Aggregate Functions
SELECT MIN([Order Total]) FROM OnlineRetailSales
SELECT MAX([Order Total]) FROM OnlineRetailSales
SELECT AVG([Order Total]) FROM OnlineRetailSales
SELECT SUM([Order Total]) FROM OnlineRetailSales
SELECT COUNT([Order Total]) FROM OnlineRetailSales
SELECT VAR([Order Total]) FROM OnlineRetailSales

---- Multi-Row Subquery
SELECT [Speaker Name], [Session Name], [Start Date], [End Date], [Room Name] 
FROM SessionInfo
WHERE [Session Name] IN (SELECT [Session Name] FROM SpeakerInfo WHERE Organization = 'Two Trees Olive Oil')
ORDER BY [Speaker Name]

---- Multi-Row INNER JOIN
SELECT SP.[Name], SE.[Session Name], SE.[Start Date], SE.[End Date], SE.[Room Name] 
FROM SessionInfo SE INNER JOIN SpeakerInfo SP
ON SE.[Session Name] = SP.[Session Name]
WHERE SP.Organization = 'Two Trees Olive Oil'
ORDER BY SP.[Name] 

---- EXISTS operator
SELECT C.[First name], C.[Last name], C.State, C.Email, C.[Phone Number] 
FROM ConventionAttendees C
WHERE EXISTS (
SELECT * FROM OnlineRetailSales O 
WHERE C.State = O.CustState)
ORDER BY C.State, C.[First name]

---- NOT EXISTS operator
SELECT C.[First name], C.[Last name], C.State, C.Email, C.[Phone Number] 
FROM ConventionAttendees C
WHERE NOT EXISTS (
SELECT * FROM OnlineRetailSales O 
WHERE C.State = O.CustState)
ORDER BY C.State, C.[First name]

---- GROUP BY With HAVING Clause
SELECT CustName, ProdName, COUNT(ProdName) AS ProductCount
FROM OnlineRetailSales
GROUP BY CustName, ProdName
HAVING COUNT(ProdName) > 1
ORDER BY CustName


---- CTE
;WITH TotalAverage AS (
	SELECT OrderType, AVG([Order Total]) AS AVGTOTAL
	FROM OnlineRetailSales
	GROUP BY OrderType
	)
SELECT * FROM TotalAverage WHERE AVGTOTAL > 500


-----ROW NUMBER
SELECT OrderNum, OrderDate, CustName, ProdName, Quantity, ROW_NUMBER() OVER (PARTITION BY CustName ORDER BY OrderDate DESC) AS ROW_NUM
FROM OnlineRetailSales

---- This query returns the most recent order for each customer
;WITH MostRecentOrder AS (
	SELECT OrderNum, OrderDate, CustName, ProdName, Quantity, ROW_NUMBER() OVER (PARTITION BY CustName ORDER BY OrderDate DESC) AS ROW_NUM
	FROM OnlineRetailSales)
SELECT * FROM MostRecentOrder WHERE ROW_NUM = 1

;WITH MostRecentOrder AS (
SELECT OrderNum, OrderDate, CustName, ProdName, ROW_NUMBER() OVER (PARTITION BY CustName ORDER BY OrderDate DESC) AS ROW_NUM
FROM OnlineRetailSales)
SELECT * FROM MostRecentOrder WHERE ROW_NUM = 1


----------------------------------------------------------------------------------------------------------------------------------------
DROP TABLE IF EXISTS #tmpMostRecentOrder

SELECT OrderNum, OrderDate, CustName, ProdName, Quantity, ROW_NUMBER() OVER (PARTITION BY CustName ORDER BY OrderDate DESC) AS ROW_NUM
INTO #tmpMostRecentOrder
FROM OnlineRetailSales

SELECT * FROM #tmpMostRecentOrder WHERE ROW_NUM = 1

-----------------------------------------------------------------------------------------------------------------------------------------