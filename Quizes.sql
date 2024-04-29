USE Red30Tech
GO

SELECT ProdCategory, ProdNumber, ProdName, [In Stock] 
FROM Inventory 
WHERE [In Stock] < (SELECT AVG([In Stock]) FROM Inventory)