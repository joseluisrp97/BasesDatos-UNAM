CREATE TABLE Cliente
(
  Nombre VARCHAR(255) NOT NULL,
  Direccion VARCHAR(255) NOT NULL,
  IDcliente SERIAL PRIMARY KEY
);

CREATE TABLE Empleado
(
  IDempleado SERIAL PRIMARY KEY,
  Nombre VARCHAR(100) NOT NULL,
  Turno VARCHAR(100) NOT NULL
);

CREATE TABLE Articulo
(
  IDarticulo SERIAL PRIMARY KEY,
  Titulo VARCHAR(100) NOT NULL,
  Genero VARCHAR(100) NOT NULL,
  Director VARCHAR(100) NOT NULL,
  Año INT NOT NULL, 
  Plataforma VARCHAR(100) NOT NULL
);

CREATE TABLE Ticket
(
  IDticket SERIAL PRIMARY KEY,
  FechaAlquiler DATE NOT NULL,
  FechaDevolucion DATE,
  Total FLOAT NOT NULL, 
  IDcliente INT,
  IDempleado INT,
  FOREIGN KEY (IDcliente) REFERENCES Cliente(IDcliente) ON DELETE SET NULL,
  FOREIGN KEY (IDempleado) REFERENCES Empleado(IDempleado) ON DELETE SET NULL ON UPDATE CASCADE
);

CREATE TABLE Incluye
(
  IDticket INT NOT NULL,
  IDarticulo INT NOT NULL,
  FOREIGN KEY (IDticket) REFERENCES Ticket(IDticket) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (IDarticulo) REFERENCES Articulo(IDarticulo) ON DELETE CASCADE ON UPDATE CASCADE,
  PRIMARY KEY (IDticket, IDarticulo)
);

-- Check
ALTER TABLE Ticket
ADD CONSTRAINT check_total_nonnegative
CHECK (Total >= 0);

ALTER TABLE Articulo
ADD CONSTRAINT check_year_valid
CHECK (Año > 1800);

ALTER TABLE Empleado
ADD CONSTRAINT check_turno_valid
CHECK (Turno IN ('Mañana', 'Tarde', 'Noche'));

-- Crear dominios
CREATE DOMAIN total_as_money AS NUMERIC
CHECK (VALUE >= 0 AND VALUE <= 1000);

CREATE DOMAIN year_as_movie_year AS INT
CHECK (VALUE > 1895);

CREATE DOMAIN shift_as_work_shift AS VARCHAR
CHECK (VALUE IN ('Mañana', 'Tarde', 'Noche'));

-- Modificación de las columnas de las tablas para usar los nuevos dominios
ALTER TABLE Comic
ALTER COLUMN Precio TYPE precio_comic USING Precio::precio_comic;

ALTER TABLE Comic
ALTER COLUMN Año TYPE año_comic USING Año::año_comic;

ALTER TABLE Cliente
ALTER COLUMN Telefono TYPE telefono_standard USING Telefono::telefono_standard;

ALTER TABLE Empleado
ALTER COLUMN Telefono TYPE telefono_standard USING Telefono::telefono_standard;


-- Restricción Tuplas para la tabla Ticket
ALTER TABLE Ticket
ADD CONSTRAINT check_fechas_validas
CHECK (FechaDevolucion IS NULL OR FechaDevolucion >= FechaAlquiler);

-- Restricción Tuplas para la tabla Articulo
ALTER TABLE Articulo
ADD CONSTRAINT check_antiguo_valido
CHECK (NOT (Genero = 'Antiguo' AND Año >= 1950));