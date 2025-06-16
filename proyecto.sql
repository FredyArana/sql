CREATE DATABASE bd_acadevent2025;
USE bd_acadevent2025;

-- Usuarios del sistema (profesores, estudiantes, admins)
CREATE TABLE usuarios (
  usuario_id INT PRIMARY KEY AUTO_INCREMENT,
  nombres VARCHAR(100) NOT NULL,
  apellidos VARCHAR(100) NOT NULL,
  email VARCHAR(150) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  rol ENUM('ESTUDIANTE', 'DOCENTE', 'ADMIN') NOT NULL,
  activo BOOLEAN DEFAULT TRUE,
  fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Eventos académicos
CREATE TABLE eventos (
  evento_id INT PRIMARY KEY AUTO_INCREMENT,
  titulo_evento VARCHAR(200) NOT NULL,
  descripcion TEXT,
  fecha_inicio DATE NOT NULL,
  fecha_fin DATE NOT NULL,
  modalidad ENUM('PRESENCIAL', 'VIRTUAL', 'HÍBRIDO') NOT NULL,
  lugar VARCHAR(255),
  creado_por INT NOT NULL,
  eliminado_en TIMESTAMP DEFAULT NULL,
  FOREIGN KEY (creado_por) REFERENCES usuarios(usuario_id)
);

-- Participación de usuarios en eventos
CREATE TABLE participantes_evento (
  participante_id INT PRIMARY KEY AUTO_INCREMENT,
  evento_id INT NOT NULL,
  usuario_id INT NOT NULL,
  rol_participacion ENUM('ASISTENTE', 'PONENTE', 'ORGANIZADOR') NOT NULL,
  certificado_emitido BOOLEAN DEFAULT FALSE,
  FOREIGN KEY (evento_id) REFERENCES eventos(evento_id),
  FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id)
);

-- Documentos del evento
CREATE TABLE documentos_evento (
  documento_id INT PRIMARY KEY AUTO_INCREMENT,
  evento_id INT NOT NULL,
  titulo_doc VARCHAR(200),
  tipo_doc ENUM('PDF', 'PRESENTACIÓN', 'VIDEO'),
  url_archivo VARCHAR(255),
  subido_por INT NOT NULL,
  fecha_subida DATETIME DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (evento_id) REFERENCES eventos(evento_id),
  FOREIGN KEY (subido_por) REFERENCES usuarios(usuario_id)
);

-- Evaluaciones de eventos
CREATE TABLE evaluaciones (
  evaluacion_id INT PRIMARY KEY AUTO_INCREMENT,
  evento_id INT NOT NULL,
  usuario_id INT NOT NULL,
  puntuacion TINYINT NOT NULL CHECK (puntuacion BETWEEN 1 AND 5),
  comentarios TEXT,
  fecha_evaluacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (evento_id) REFERENCES eventos(evento_id),
  FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id)
);
