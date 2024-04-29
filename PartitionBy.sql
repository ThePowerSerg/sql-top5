USE Red30Tech
GO

SELECT * FROM ConventionAttendees
SELECT * FROM EmployeeDirectory
SELECT * FROM Inventory
SELECT * FROM OnlineRetailSales 
SELECT * FROM SessionInfo
SELECT * FROM SpeakerInfo

SELECT State, COUNT(City) OVER (PARTITION BY State)
FROM ConventionAttendees

SELECT State, COUNT(DISTINCT [CITY]) 
FROM ConventionAttendees
GROUP BY State
ORDER BY State

SELECT DISTINCT(CITY) FROM ConventionAttendees WHERE STATE = 'ALABAMA'
SELECT DISTINCT(CITY) FROM ConventionAttendees WHERE STATE = 'ALASKA'


SELECT ProdName, ProdNumber, COUNT(ProdName) OVER (PARTITION BY ProdNumber) ProductNameByNumber
FROM Inventory