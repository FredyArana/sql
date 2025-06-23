-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS examen;
USE examen;

-- Crear la tabla provincia
CREATE TABLE provincia (
  id INT PRIMARY KEY,
  codigo VARCHAR(10),
  nombre VARCHAR(100),
  direccion VARCHAR(150)
);

-- Insertar datos en la tabla provincia
INSERT INTO provincia (id, codigo, nombre, direccion)
VALUES
  (1, '0123', 'Santa', 'Av. Perú 123'),
  (2, '0456', 'Samanco', 'Calle Bolívar 456'),
  (3, '012', 'Moro', 'Jr. Lima 789');

-- Crear la tabla datos
CREATE TABLE datos (
  id INT PRIMARY KEY,
  dni VARCHAR(15),
  nombre VARCHAR(50),
  ap_paterno VARCHAR(50),
  ap_materno VARCHAR(50),
  fecnac DATE,
  provincia_id INT,
  direccion VARCHAR(100),
  FOREIGN KEY (provincia_id) REFERENCES provincia(id)
);

-- Insertar datos en la tabla datos
INSERT INTO datos (id, dni, nombre, ap_paterno, ap_materno, fecnac, provincia_id, direccion)
VALUES
  (1, '71093594', 'fredy', 'arana', 'manrique', '2002-05-02', 1, 'La libertad 352'),
  (2, '123456', 'gerardo', 'aguilar', 'cacio', '2012-09-07', 2, 'Av garatea'),
  (3, '71093594', 'frank', 'romero', 'castillo', '2015-03-08', 3, 'Av argentina');
