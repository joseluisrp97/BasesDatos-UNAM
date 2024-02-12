--Consulta1
SELECT IDarticulo, Titulo, Año
FROM Articulo
WHERE Plataforma = 'BlueRay' AND Año >= 2000;

--Consulta2
SELECT e.IDempleado, e.Nombre, COUNT(t.IDticket) as Numero_Tickets
FROM Empleado e
JOIN Ticket t ON e.IDempleado = t.IDempleado
GROUP BY e.IDempleado, e.Nombre
ORDER BY Numero_Tickets DESC;

--Consulta3
SELECT a.Titulo, COUNT(i.IDarticulo) as Numero_Alquileres
FROM Articulo a
JOIN Incluye i ON a.IDarticulo = i.IDarticulo
GROUP BY a.Titulo
ORDER BY Numero_Alquileres DESC
LIMIT 3;

--Vista1
CREATE VIEW IngresosPorCliente AS
SELECT c.IDcliente, c.Nombre, SUM(t.Total) as Total_Ingresos
FROM Cliente c
JOIN Ticket t ON c.IDcliente = t.IDcliente
GROUP BY c.IDcliente, c.Nombre;

--Vista2
CREATE VIEW DetalleAlquileres AS
SELECT a.Titulo, a.Año, c.Nombre as Cliente, t.FechaAlquiler, t.FechaDevolucion
FROM Articulo a
JOIN Incluye i ON a.IDarticulo = i.IDarticulo
JOIN Ticket t ON i.IDticket = t.IDticket
JOIN Cliente c ON t.IDcliente = c.IDcliente;

--Vista3
CREATE VIEW ArticulosPorGeneros AS
SELECT Genero, COUNT(IDarticulo) as Numero_Articulos
FROM Articulo
GROUP BY Genero;