-- Consulta 1
SELECT IDcomic, Personaje, Numero
FROM Comic
WHERE Personaje = 'Spider-Man'
ORDER BY Numero;

-- Consulta 2
SELECT Empleado.IDempleado, Empleado.Nombre, Empleado.Apellido, SUM(Compra.Total) AS TotalVentas
FROM Compra
JOIN Empleado ON Compra.IDempleado = Empleado.IDempleado
GROUP BY Empleado.IDempleado, Empleado.Nombre, Empleado.Apellido;


-- Consulta 3
SELECT Comic.IDcomic, Comic.Personaje, COUNT(Incluye.IDcomic) AS VecesVendido
FROM Incluye
JOIN Comic ON Incluye.IDcomic = Comic.IDcomic
GROUP BY Comic.IDcomic, Comic.Personaje
ORDER BY VecesVendido DESC;


-- Vista 1
CREATE VIEW TotalComprasPorCliente AS
SELECT Cliente.IDcliente, Cliente.Nombre, Cliente.Apellido, SUM(Compra.Total) AS TotalGastado
FROM Cliente
JOIN Compra ON Cliente.IDcliente = Compra.IDcliente
GROUP BY Cliente.IDcliente, Cliente.Nombre, Cliente.Apellido;

-- Vista 2
CREATE VIEW DetalleCompras AS
SELECT Compra.IDcompra, Compra.Fecha, Comic.Personaje, Comic.Numero
FROM Compra
JOIN Incluye ON Compra.IDcompra = Incluye.IDcompra
JOIN Comic ON Incluye.IDcomic = Comic.IDcomic;

-- Vista 3
CREATE VIEW InventarioPorPersonaje AS
SELECT Personaje, SUM(Cantidad) AS TotalDisponible
FROM Comic
GROUP BY Personaje;