
--EJERCICIO 10 CONSULTA 1
SELECT Administrador.Nombre , Torneo.*
FROM Torneo   
    JOIN Administrador ON Torneo.ID_admin = Administrador.Id_Admin
WHERE Administrador.Nombre = 'Jordain Bellon';
    
--EJERCICIO 10 CONSULTA 2

SELECT Jugador.Nombre AS Jugador,Torneo.Nombre AS Torneo, Participar.Resultado AS Resultado
FROM Participar
    JOIN Torneo ON Participar.Id_Torneo = Torneo.Id_Torneo 
    JOIN Jugador ON Participar.Id_Jugador = Jugador.Id_Jugador
WHERE Jugador.Nombre = 'Gayle Cadogan';

--EJERCICIO 10 CONSULTA 3

SELECT  Amigo.Nombre AS Nombre_Amigo
FROM Amistad
	JOIN Jugador ON Amistad.Id_Jugador = Jugador.Id_Jugador 
    JOIN Jugador Amigo ON Amistad.Id_amigo = Amigo.Id_Jugador 
WHERE Jugador.Nombre = 'Winfred Dukesbury'


--EJERCICIO 11 VISTA 1

CREATE VIEW Vista_Participantes_Torneo AS
SELECT 
    Torneo.Nombre AS Nombre_Torneo,
    Jugador.Nombre AS Nombre_Jugador,
    Participar.Resultado,
    Jugador.Correo AS Correo_Jugador,
    Jugador.Nivel
FROM Participar
JOIN Torneo ON Participar.Id_Torneo = Torneo.Id_Torneo
JOIN Jugador ON Participar.Id_Jugador = Jugador.Id_Jugador
ORDER BY Torneo.Nombre, Jugador.Nombre;

--EJEMPLO VISTA 1

SELECT * FROM Vista_Participantes_Torneo
WHERE Nombre_Torneo = 'Home Run';

--EJERCICIO 11 VISTA 2

CREATE VIEW Vista_Ganadores AS
SELECT 
    Jugador.Id_Jugador,
    Jugador.Nombre AS Nombre_Jugador,
    COUNT(Participar.Id_Torneo) AS Cantidad_Torneos_Ganados
FROM Participar
JOIN Jugador ON Participar.Id_Jugador = Jugador.Id_Jugador
WHERE Participar.Resultado = 'Ganador'
GROUP BY Jugador.Id_Jugador, Jugador.Nombre
ORDER BY Cantidad_Torneos_Ganados DESC;

--EJEMPLO VISTA 2

SELECT * FROM Vista_Ganadores
WHERE Cantidad_Torneos_Ganados > 3;

--EJERCICIO 11 VISTA 3

CREATE VIEW Vista_Cantidad_Amigos AS
SELECT 
    Jugador.Id_Jugador,
    Jugador.Nombre AS Nombre_Jugador,
    COUNT(Amistad.Id_amigo) AS Cantidad_Amigos
FROM Jugador
LEFT JOIN Amistad ON Jugador.Id_Jugador = Amistad.Id_Jugador
GROUP BY Jugador.Id_Jugador, Jugador.Nombre
ORDER BY Cantidad_Amigos DESC;

--EJEMPLO VISTA 3

SELECT COUNT(*) AS Cantidad_Relaciones_Amistad
FROM Vista_Cantidad_Amigos;
