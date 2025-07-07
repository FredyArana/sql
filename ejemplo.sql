-- Crear la base de datos
CREATE DATABASE recupera;

-- Tabla padre
CREATE TABLE Origen (
  OrigenID STRING(36) NOT NULL,
  Procedencia STRING(50),
  Actividad STRING(50) -- Estudia o Trabaja
) PRIMARY KEY (OrigenID);

-- Tabla hija
CREATE TABLE Persona (
  OrigenID STRING(36) NOT NULL,
  PersonaID STRING(36) NOT NULL,
  Nombre STRING(50),
  Edad INT64,
  FechaNacimiento DATE,
  EdadDoble INT64 AS (Edad * 2) STORED
) PRIMARY KEY (OrigenID, PersonaID),
  INTERLEAVE IN PARENT Origen ON DELETE CASCADE;

-- Tabla multivalorada
CREATE TABLE Intereses (
  OrigenID STRING(36) NOT NULL,
  PersonaID STRING(36) NOT NULL,
  Interes STRING(50) NOT NULL
) PRIMARY KEY (OrigenID, PersonaID, Interes),
  INTERLEAVE IN PARENT Persona ON DELETE CASCADE;

-- Insertar en Origen
INSERT INTO Origen (OrigenID, Procedencia, Actividad) VALUES
('O1', 'Lima', 'Estudia'),
('O2', 'Cusco', 'Trabaja'),
('O3', 'Arequipa', 'Estudia'),
('O4', 'Piura', 'Trabaja'),
('O5', 'Tacna', 'Estudia');

-- Insertar en Persona
INSERT INTO Persona (OrigenID, PersonaID, Nombre, Edad, FechaNacimiento) VALUES
('O1', 'P1', 'Ana López', 20, '2005-03-15'),
('O2', 'P2', 'Luis Gómez', 25, '2000-08-10'),
('O3', 'P3', 'María Torres', 30, '1995-06-01'),
('O4', 'P4', 'Pedro Ramírez', 22, '2003-01-20'),
('O5', 'P5', 'Sofía Díaz', 27, '1998-11-25');

-- Intereses (multivalorado)
INSERT INTO Intereses (OrigenID, PersonaID, Interes) VALUES
('O1', 'P1', 'Música'),
('O1', 'P1', 'Lectura'),
('O2', 'P2', 'Fútbol'),
('O3', 'P3', 'Arte'),
('O3', 'P3', 'Viajes'),
('O4', 'P4', 'Cine'),
('O4', 'P4', 'Tecnología'),
('O5', 'P5', 'Idiomas'),
('O5', 'P5', 'Baile');
