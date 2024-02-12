CREATE DOMAIN Tipos_a AS INT 
CHECK (VALUE BETWEEN 1 AND 2);

CREATE TABLE Administrador
(
  Id_Admin SERIAL PRIMARY KEY, 
  Nombre VARCHAR(255) NOT NULL, 
  Correo VARCHAR(255) NOT NULL UNIQUE,
  Contrasena VARCHAR(255) NOT NULL, 
  Tipo_Admin Tipos_a 
);

-- Tabla que almacena información sobre los torneos organizados.
CREATE DOMAIN Tipos_estatus AS VARCHAR(15)
CHECK(VALUE IN ('En curso', 'Finalizado','Disponible'));


CREATE TABLE Torneo
(
  Id_Torneo SERIAL PRIMARY KEY, 
  ID_admin INT NOT NULL, 
  Nombre VARCHAR(255) NOT NULL UNIQUE, 
  Juego VARCHAR(255) NOT NULL, 
  Reglas VARCHAR(255) NOT NULL, 
  Num_participantes INT NOT NULL,
  Estatus Tipos_estatus, 
  Inicio DATE NOT NULL, 
  Fin DATE NOT NULL,
  FOREIGN KEY (ID_admin) REFERENCES Administrador(Id_Admin)
  ON DELETE SET Null  
  ON UPDATE CASCADE 
);

-- Tabla que almacena información sobre los jugadores registrados en el sistema.
CREATE TABLE Jugador
(
  Nombre VARCHAR(255) NOT NULL, 
  Id_Jugador SERIAL PRIMARY KEY, 
  Correo VARCHAR(255) NOT NULL UNIQUE,
  Contrasena VARCHAR(255) NOT NULL, 
  Nivel INT  DEFAULT 1
  
);

-- Tabla de relación que registra la participación de jugadores en torneos.
CREATE DOMAIN Tipos_resultado AS VARCHAR(10)
CHECK(VALUE IN ('Ganador', 'Perdedor','En curso'));

CREATE TABLE Participar
(   
  Id_Torneo INT NOT NULL, 
  Id_Jugador INT NOT NULL,
  Resultado Tipos_resultado,
  PRIMARY KEY (Id_Torneo, Id_Jugador), 
  FOREIGN KEY (Id_Torneo) REFERENCES Torneo(Id_Torneo)
  ON DELETE CASCADE  
  ON UPDATE CASCADE ,
  FOREIGN KEY (Id_Jugador) REFERENCES Jugador(Id_Jugador)
  ON DELETE CASCADE  
  ON UPDATE CASCADE 
);

-- Tabla que registra las relaciones de amistad entre jugadores.
CREATE TABLE Amistad
(
  Id_Jugador INT NOT NULL,
  Id_amigo INT NOT NULL, 
  FOREIGN KEY (Id_Jugador) REFERENCES Jugador(Id_Jugador)
  ON DELETE CASCADE  
  ON UPDATE CASCADE,  
  FOREIGN KEY (Id_amigo) REFERENCES Jugador(Id_Jugador) 
  ON DELETE CASCADE  
  ON UPDATE CASCADE 
);




ALTER TABLE Torneo ADD CONSTRAINT Num_participantes
CHECK (Num_participantes BETWEEN 10 AND 50);

ALTER TABLE Jugador 
ADD CONSTRAINT Nivel
CHECK (Nivel BETWEEN 1 AND 100);

ALTER TABLE Administrador 
ADD CONSTRAINT Contrasena
CHECK (LENGTH(Contrasena) >= 8);

ALTER TABLE Torneo
ADD CONSTRAINT Fechas_validas
CHECK (Fin > Inicio);

ALTER TABLE Amistad
ADD CONSTRAINT Amigos_unicos
CHECK (Id_Jugador <> Id_amigo);