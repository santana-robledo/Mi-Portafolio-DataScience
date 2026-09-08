USE AdventureWorks2025;
GO

/* =========================================================
   TAREA M10 – JOSUE SANTANA ROBLEDO CORONA
   ========================================================= */


/* 
   EJERCICIO 1
   Obtener por cada producto:
   - ProductID
   - Número total de ventas (OrderQty)
   - Valor total de ventas (LineTotal)
   */

SELECT
    ProductID,
    SUM(OrderQty) AS TotalVentas,
    SUM(LineTotal) AS ValorTotalVentas
FROM Sales.SalesOrderDetail
GROUP BY ProductID;
GO


/*
   EJERCICIO 2
   Mostrar productos que han tenido más de 50 unidades vendidas
   */

SELECT
    ProductID,
    SUM(OrderQty) AS TotalVentas
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(OrderQty) > 50;
GO


/* 
   EJERCICIO 3
   Mostrar:
   - SalesOrderID
   - ProductID
   - LineTotal
   - Valor total de ventas de cada SalesOrderID
   */

SELECT
    SalesOrderID,
    ProductID,
    LineTotal,
    SUM(LineTotal) OVER (
        PARTITION BY SalesOrderID
    ) AS TotalVentaPorOrden
FROM Sales.SalesOrderDetail;
GO


/*
   EJERCICIO 4
   Numerar cada línea de pedido dentro de cada SalesOrderID */

SELECT
    SalesOrderID,
    SalesOrderDetailID,
    ProductID,
    LineTotal,
    ROW_NUMBER() OVER (
        PARTITION BY SalesOrderID
        ORDER BY SalesOrderDetailID
    ) AS NumeroLinea
FROM Sales.SalesOrderDetail;
GO


/* 
   EJERCICIO 5
   Asignar un rango a cada producto dentro de cada SalesOrderID basado en LineTotal 
   */

SELECT
    SalesOrderID,
    ProductID,
    LineTotal,
    RANK() OVER (
        PARTITION BY SalesOrderID
        ORDER BY LineTotal DESC
    ) AS Rango
FROM Sales.SalesOrderDetail;
GO


/*
   EJERCICIO 6
   Asignar un rango denso a cada producto dentro de cada SalesOrderID basado en LineTotal
   */

SELECT
    SalesOrderID,
    ProductID,
    LineTotal,
    DENSE_RANK() OVER (
        PARTITION BY SalesOrderID
        ORDER BY LineTotal DESC
    ) AS RangoDenso
FROM Sales.SalesOrderDetail;
GO


/* 
   EJERCICIO 7
   Mostrar productos cuyo valor total de ventas seasuperior a $5000 
   */

SELECT
    ProductID,
    SUM(LineTotal) AS ValorTotalVentas
FROM Sales.SalesOrderDetail
GROUP BY ProductID
HAVING SUM(LineTotal) > 5000
ORDER BY ValorTotalVentas DESC;
GO