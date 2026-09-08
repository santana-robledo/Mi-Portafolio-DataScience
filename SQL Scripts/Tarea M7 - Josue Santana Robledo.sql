-- ==========================================
-- Tarea M7 - Josue Santana Robledo
-- ==========================================

SELECT count (*) as "Cantidad empleados"
FROM HumanResources.Employee
WHERE JobTitle = 'Tool Designer'

SELECT *
FROM HumanResources.Employee
WHERE JobTitle LIKE  '%Designer'

SELECT *
FROM HumanResources.Employee
WHERE HireDate BETWEEN  '2010-01-01' AND '2010-12-31'

SELECT *
FROM HumanResources.Employee
WHERE NationalIDNumber IN ('295847284','245797967')

SELECT *
FROM HumanResources.Employee
WHERE OrganizationLevel IS NOT NULL
ORDER BY JobTitle ASC, HireDate DESC;