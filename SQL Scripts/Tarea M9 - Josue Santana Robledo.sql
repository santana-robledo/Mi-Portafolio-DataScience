USE AdventureWorks2025;
GO

/* =========================================================
   TAREA M9 – JOSUE SANTANA ROBLEDO CORONA
   ========================================================= */


/*
   EJERCICIO 1
   Obtener nombre y puesto de los empleados */

SELECT
    P.FirstName,
    P.LastName,
    E.JobTitle
FROM HumanResources.Employee AS E
INNER JOIN Person.Person AS P
    ON E.BusinessEntityID = P.BusinessEntityID;
GO


/*
   EJERCICIO 2
   Obtener nombres de todos los clientes, incluyendo aquellos que no tengan registro en Person.Person
   */

SELECT
    P.FirstName,
    P.LastName
FROM Sales.Customer AS C
LEFT JOIN Person.Person AS P
    ON C.PersonID = P.BusinessEntityID;
GO


/* 
   EJERCICIO 3
   Mostrar todas las órdenes y su CustomerID, incluso si no existe un cliente asociado
 */

SELECT
    SOH.SalesOrderID,
    C.CustomerID
FROM Sales.SalesOrderHeader AS SOH
RIGHT JOIN Sales.Customer AS C
    ON SOH.CustomerID = C.CustomerID;
GO


/* 
   EJERCICIO 4
   Mostrar todos los productos y todas las reseñas, incluso cuando no exista coincidencia
 */

SELECT
    P.Name,
    PR.Comments
FROM Production.Product AS P
FULL OUTER JOIN Production.ProductReview AS PR
    ON P.ProductID = PR.ProductID;
GO


/* 
   EJERCICIO 5
   Combinar todos los productos con todas las categorías */

SELECT
    P.Name AS ProductName,
    PC.Name AS CategoryName
FROM Production.Product AS P
CROSS JOIN Production.ProductCategory AS PC;
GO


/*
   EJERCICIO 6
   Combinar nombres de productos y nombres de modelos.
 */

SELECT
    Name
FROM Production.Product

UNION

SELECT
    Name
FROM Production.ProductModel;
GO


/* 
   EJERCICIO 6
   Combinar nombres de productos y nombres de modelos.
 */

SELECT
    Name
FROM Production.Product

UNION ALL

SELECT
    Name
FROM Production.ProductModel;
GO


/* 
   EJERCICIO 7
   Indicar si el puesto contiene la palabra 'Manager'*/

SELECT
    BusinessEntityID,
    COALESCE(JobTitle, 'No Title') AS JobTitle,
    CASE
        WHEN JobTitle LIKE '%Manager%' THEN 'Manager'
        ELSE 'No Manager'
    END AS PositionType
FROM HumanResources.Employee;
GO


/* 
   EJERCICIO 8
   Mostrar 'No Quota' cuando SalesQuota sea NULL
   */

SELECT
    BusinessEntityID,
    SalesQuota,
    ISNULL(CAST(SalesQuota AS VARCHAR(20)), 'No Quota') AS QuotaStatus
FROM Sales.SalesPerson;
GO