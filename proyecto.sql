CREATE DATABASE acadevent_2026;
USE acadevent_2026;

-- Tabla de usuarios del sistema
CREATE TABLE usuario (
  id_usuario INT PRIMARY KEY AUTO_INCREMENT,
  nombre VARCHAR(100) NOT NULL,
  apellido VARCHAR(100) NOT NULL,
  correo_electronico VARCHAR(150) UNIQUE NOT NULL,
  contrasena VARCHAR(255) NOT NULL,
  tipo_usuario ENUM('ESTUDIANTE', 'DOCENTE', 'ADMIN') NOT NULL,
  estado_activo BOOLEAN DEFAULT TRUE,
  fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Tabla de eventos académicos
CREATE TABLE evento (
  id_evento INT PRIMARY KEY AUTO_INCREMENT,
  titulo VARCHAR(200) NOT NULL,
  descripcion TEXT,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  modalidad ENUM('PRESENCIAL', 'VIRTUAL', 'HIBRIDO') NOT NULL,
  ubicacion VARCHAR(255),
  id_creador INT NOT NULL,
  fecha_eliminacion TIMESTAMP DEFAULT NULL,
  FOREIGN KEY (id_creador) REFERENCES usuario(id_usuario)
);

-- Tabla de inscripciones y roles en eventos
CREATE TABLE participacion_evento (
  id_participacion INT PRIMARY KEY AUTO_INCREMENT,
  id_evento INT NOT NULL,
  id_usuario INT NOT NULL,
  rol ENUM('ASISTENTE', 'PONENTE', 'ORGANIZADOR') NOT NULL,
  certificado BOOLEAN DEFAULT FALSE,
  FOREIGN KEY (id_evento) REFERENCES evento(id_evento),
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);

-- Tabla de archivos asociados a los eventos
CREATE TABLE archivo_evento (
  id_archivo INT PRIMARY KEY AUTO_INCREMENT,
  id_evento INT NOT NULL,
  titulo VARCHAR(200),
  tipo ENUM('PDF', 'PRESENTACION', 'VIDEO'),
  url VARCHAR(255),
  id_uploader INT NOT NULL,
  fecha_subida DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_evento) REFERENCES evento(id_evento),
  FOREIGN KEY (id_uploader) REFERENCES usuario(id_usuario)
);

-- Tabla de evaluaciones de los eventos
CREATE TABLE evaluacion_evento (
  id_evaluacion INT PRIMARY KEY AUTO_INCREMENT,
  id_evento INT NOT NULL,
  id_usuario INT NOT NULL,
  calificacion TINYINT NOT NULL CHECK (calificacion BETWEEN 1 AND 5),
  comentario TEXT,
  fecha_evaluacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (id_evento) REFERENCES evento(id_evento),
  FOREIGN KEY (id_usuario) REFERENCES usuario(id_usuario)
);
