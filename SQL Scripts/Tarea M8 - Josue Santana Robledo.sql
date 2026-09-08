CREATE TABLE dbo.Ventas
(
    NumeroOrden INT PRIMARY KEY,
    FechaOrden DATETIME2,
    FechaEntrega DATE,
    EstatusOrden VARCHAR(20),
    NombreCliente VARCHAR(100),
    DomicilioEntrega VARCHAR(200),
    CompraOnline CHAR(1),
    MetodoPago VARCHAR(30),
    Subtotal DECIMAL(10,2),
    Observaciones VARCHAR(500)
);
GO

SELECT *
FROM dbo.Ventas;

INSERT INTO dbo.Ventas
(
    NumeroOrden,
    FechaOrden,
    FechaEntrega,
    EstatusOrden,
    NombreCliente,
    DomicilioEntrega,
    CompraOnline,
    MetodoPago,
    Subtotal,
    Observaciones
)
VALUES
(
    12345,
    '2022-08-05 18:58:46.867',
    '2022-08-15',
    'Pendiente',
    'Juan Perez',
    'Avenida Siempre Viva 742 Springfield',
    'S',
    'Tarjeta de Credito',
    20565.62,
    'El cliente indica que solo puede recibir el envio entre semana.'
),
(
    12346,
    '2022-08-06 10:25:15.500',
    '2022-08-16',
    'En Proceso',
    'Maria Lopez',
    'Calle Reforma 120 Guadalajara',
    'S',
    'Tarjeta de Debito',
    8750.00,
    'Solicita confirmar el horario de entrega.'
),
(
    12347,
    '2022-08-07 14:10:30.250',
    '2022-08-17',
    'Completada',
    'Carlos Ramirez',
    'Avenida Vallarta 450 Zapopan',
    'N',
    'Efectivo',
    12500.75,
    'Entrega directamente en el domicilio indicado.'
),
(
    12348,
    '2022-08-08 09:45:12.100',
    '2022-08-18',
    'Cancelada',
    'Ana Torres',
    'Calle Juarez 89 Tlaquepaque',
    'S',
    'Tarjeta de Credito',
    4599.99,
    'El cliente solicito cancelar la orden.'
),
(
    12349,
    '2022-08-09 16:35:55.900',
    '2022-08-19',
    'Pendiente',
    'Luis Hernandez',
    'Calle Independencia 300 Tonala',
    'N',
    'Efectivo',
    3200.50,
    'Llamar al cliente antes de realizar la entrega.'
);
GO

EXEC sp_rename 'dbo.Ventas', 'Ordenes';
GO

SELECT *
FROM dbo.Ordenes;

ALTER TABLE dbo.Ordenes
ADD FechaEnvio DATE;
GO

SELECT *
FROM dbo.Ordenes;

ALTER TABLE dbo.Ordenes
ADD FechaEnvio DATE DEFAULT CAST(GETDATE() AS DATE);
GO