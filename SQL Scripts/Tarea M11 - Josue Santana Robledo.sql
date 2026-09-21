USE AdventureWorks2022;
GO

/* ============================================================
   TAREA M11 – Josue Santana Robledo Corona
   ============================================================ */


/*
   EJERCICIO 1
 */

SELECT
    ProductID,
    Name
FROM Production.Product
WHERE ProductID IN (
    SELECT ProductID
    FROM Sales.SalesOrderDetail
)
ORDER BY Name ASC;
GO


/* 
   EJERCICIO 2
*/

SELECT
    e.BusinessEntityID,
    p.FirstName + ' ' + p.LastName AS [Nombre del Empleado],
    d.Name AS [Nombre del Departamento]
FROM HumanResources.Employee AS e
INNER JOIN Person.Person AS p
    ON e.BusinessEntityID = p.BusinessEntityID
INNER JOIN HumanResources.EmployeeDepartmentHistory AS edh
    ON e.BusinessEntityID = edh.BusinessEntityID
INNER JOIN HumanResources.Department AS d
    ON edh.DepartmentID = d.DepartmentID
WHERE edh.EndDate IS NULL;
GO


/*
   EJERCICIO 3
   */

WITH EmpleadosActuales AS
(
    SELECT
        e.BusinessEntityID,
        p.FirstName + ' ' + p.LastName AS [Nombre del Empleado],
        edh.DepartmentID
    FROM HumanResources.Employee AS e
    INNER JOIN Person.Person AS p
        ON e.BusinessEntityID = p.BusinessEntityID
    INNER JOIN HumanResources.EmployeeDepartmentHistory AS edh
        ON e.BusinessEntityID = edh.BusinessEntityID
    WHERE edh.EndDate IS NULL
)
SELECT
    ea.BusinessEntityID,
    ea.[Nombre del Empleado],
    d.Name AS [Nombre del Departamento]
FROM EmpleadosActuales AS ea
INNER JOIN HumanResources.Department AS d
    ON ea.DepartmentID = d.DepartmentID;
GO


/* 
   EJERCICIO 4
*/

CREATE TABLE #ProductosOrdenados
(
    ProductID INT,
    Name NVARCHAR(50)
);
GO

INSERT INTO #ProductosOrdenados (ProductID, Name)
SELECT
    ProductID,
    Name
FROM Production.Product
WHERE ProductID IN (
    SELECT ProductID
    FROM Sales.SalesOrderDetail
);
GO

SELECT *
FROM #ProductosOrdenados;
GO

CREATE TABLE ##ProductosOrdenadosGlobal
(
    ProductID INT,
    Name NVARCHAR(50)
);
GO

INSERT INTO ##ProductosOrdenadosGlobal (ProductID, Name)
SELECT
    ProductID,
    Name
FROM Production.Product
WHERE ProductID IN (
    SELECT ProductID
    FROM Sales.SalesOrderDetail
);
GO

SELECT *
FROM ##ProductosOrdenadosGlobal;
GO


/* 
   EJERCICIO 5
   */

SELECT
    SalesOrderNumber,
    PurchaseOrderNumber
FROM Sales.SalesOrderHeader
WHERE YEAR(OrderDate) = 2011;
GO


/* 
EJERCICIO 6
*/

SELECT
    SUBSTRING(SalesOrderNumber, 3, LEN(SalesOrderNumber))
        AS NewSalesOrderNumber,

    SUBSTRING(PurchaseOrderNumber, 3, LEN(PurchaseOrderNumber))
        AS NewPurchaseOrderNumber
FROM Sales.SalesOrderHeader;
GO