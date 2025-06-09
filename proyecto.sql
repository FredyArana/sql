CREATE DATABASE bd_nuevax;
USE bd_nuevax;

CREATE TABLE documentos (
  doc_id INT PRIMARY KEY AUTO_INCREMENT,
  titulo VARCHAR(255) NOT NULL,
  ubicacion VARCHAR(255) NOT NULL,
  eliminado_en TIMESTAMP DEFAULT NULL
);

CREATE TABLE permisos (
  permiso_id INT PRIMARY KEY AUTO_INCREMENT,
  nombre_permiso VARCHAR(255) NOT NULL,
  descripcion_permiso VARCHAR(255) NOT NULL,
  estado TINYINT(1) NOT NULL,
  eliminado_en TIMESTAMP DEFAULT NULL
);

CREATE TABLE usuarios_app (
  usuario_id INT PRIMARY KEY AUTO_INCREMENT,
  email VARCHAR(255) UNIQUE NOT NULL,
  email_personal VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  permiso_id INT NOT NULL,
  activo TINYINT(1) NOT NULL DEFAULT 1,
  conectado TINYINT(1) NOT NULL,
  ultima_visita TIMESTAMP NULL,
  foto_id INT NULL,
  fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  clave_visible VARCHAR(255) NULL,
  eliminado_en TIMESTAMP DEFAULT NULL,
  FOREIGN KEY (permiso_id) REFERENCES permisos(permiso_id),
  FOREIGN KEY (foto_id) REFERENCES documentos(doc_id)
);

CREATE TABLE planes_servicio (
  plan_id INT PRIMARY KEY AUTO_INCREMENT,
  nombre_plan VARCHAR(255),
  descripcion_beneficios TEXT,
  costo_moneda DOUBLE NOT NULL,
  usuarios_permitidos INT NULL,
  eliminado_en TIMESTAMP DEFAULT NULL
);

CREATE TABLE organizaciones (
  organizacion_id INT PRIMARY KEY AUTO_INCREMENT,
  usuario_id INT NOT NULL,
  plan_id INT NOT NULL,
  nombre_org VARCHAR(255) NOT NULL,
  descripcion_org VARCHAR(255) NULL,
  numero_ruc VARCHAR(255) NOT NULL,
  telefono_org VARCHAR(255) NOT NULL,
  eliminado_en TIMESTAMP DEFAULT NULL,
  FOREIGN KEY (usuario_id) REFERENCES usuarios_app(usuario_id),
  FOREIGN KEY (plan_id) REFERENCES planes_servicio(plan_id)
);

CREATE TABLE empleados (
  empleado_id INT PRIMARY KEY AUTO_INCREMENT,
  usuario_id INT NOT NULL,
  organizacion_id INT NOT NULL,
  nombre_empleado VARCHAR(255) NOT NULL,
  apellido_paterno VARCHAR(255) NOT NULL,
  apellido_materno VARCHAR(255) NOT NULL,
  documento_identidad VARCHAR(8) NULL,
  fecha_nac TIMESTAMP NULL,
  telefono_empleado VARCHAR(255) NULL,
  eliminado_en TIMESTAMP DEFAULT NULL,
  FOREIGN KEY (usuario_id) REFERENCES usuarios_app(usuario_id),
  FOREIGN KEY (organizacion_id) REFERENCES organizaciones(organizacion_id)
);

CREATE TABLE departamentos (
  departamento_id INT PRIMARY KEY AUTO_INCREMENT,
  organizacion_id INT NOT NULL,
  nombre_depto VARCHAR(255) NOT NULL,
  descripcion_depto VARCHAR(255) NULL,
  codigo_depto VARCHAR(255) NOT NULL,
  color_depto VARCHAR(255) NULL,
  activo TINYINT(1) NOT NULL,
  fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  eliminado_en TIMESTAMP DEFAULT NULL,
  FOREIGN KEY (organizacion_id) REFERENCES organizaciones(organizacion_id)
);

CREATE TABLE equipos_trabajo (
  equipo_id INT PRIMARY KEY AUTO_INCREMENT,
  lider_id INT NOT NULL,
  departamento_id INT NOT NULL,
  nombre_equipo VARCHAR(255) NOT NULL,
  descripcion_equipo VARCHAR(255) NULL,
  fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  eliminado_en TIMESTAMP DEFAULT NULL,
  FOREIGN KEY (lider_id) REFERENCES empleados(empleado_id),
  FOREIGN KEY (departamento_id) REFERENCES departamentos(departamento_id)
);

CREATE TABLE miembros_equipo_trabajo (
  miembro_id INT PRIMARY KEY AUTO_INCREMENT,
  equipo_id INT NOT NULL,
  empleado_id INT NOT NULL,
  fecha_union TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  activo TINYINT(1) NOT NULL,
  eliminado_en TIMESTAMP DEFAULT NULL,
  FOREIGN KEY (equipo_id) REFERENCES equipos_trabajo(equipo_id),
  FOREIGN KEY (empleado_id) REFERENCES empleados(empleado_id)
);

CREATE TABLE estados_tarea (
  estado_id INT PRIMARY KEY AUTO_INCREMENT,
  nombre_estado VARCHAR(255) NOT NULL,
  descripcion_estado VARCHAR(255) NULL,
  eliminado_en TIMESTAMP DEFAULT NULL
);

CREATE TABLE objetivos (
  objetivo_id INT PRIMARY KEY AUTO_INCREMENT,
  equipo_id INT NOT NULL,
  estado_id INT NOT NULL,
  nombre_objetivo VARCHAR(255) NOT NULL,
  descripcion_objetivo VARCHAR(255) NULL,
  fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  fecha_limite TIMESTAMP NULL,
  eliminado_en TIMESTAMP DEFAULT NULL,
  FOREIGN KEY (equipo_id) REFERENCES equipos_trabajo(equipo_id),
  FOREIGN KEY (estado_id) REFERENCES estados_tarea(estado_id)
);

CREATE TABLE tareas (
  tarea_id INT PRIMARY KEY AUTO_INCREMENT,
  objetivo_id INT NOT NULL,
  estado_id INT NOT NULL,
  nombre_tarea VARCHAR(255) NOT NULL,
  descripcion_tarea VARCHAR(255) NULL,
  fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
  fecha_entrega TIMESTAMP NULL,
  eliminado_en TIMESTAMP DEFAULT NULL,
  FOREIGN KEY (objetivo_id) REFERENCES objetivos(objetivo_id),
  FOREIGN KEY (estado_id) REFERENCES estados_tarea(estado_id)
);

CREATE TABLE tipos_modalidad (
  modalidad_id INT PRIMARY KEY AUTO_INCREMENT,
  nombre_modalidad VARCHAR(255) NOT NULL,
  descripcion_modalidad VARCHAR(255) NULL,
  eliminado_en TIMESTAMP DEFAULT NULL
);

CREATE TABLE reuniones_programadas (
  reunion_id INT PRIMARY KEY AUTO_INCREMENT,
  equipo_id INT NOT NULL,
  fecha_reunion DATE NOT NULL,
  hora_reunion TIME NULL,
  duracion_minutos INT NOT NULL,
  descripcion_reunion VARCHAR(255) NULL,
  asunto_reunion VARCHAR(255) NOT NULL,
  modalidad_id INT NOT NULL,
  sala_reunion VARCHAR(255) NULL,
  estado_reunion VARCHAR(255) NOT NULL DEFAULT 'PROGRAMADA',
  observacion_reunion VARCHAR(255) NULL,
  eliminado_en TIMESTAMP DEFAULT NULL,
  FOREIGN KEY (equipo_id) REFERENCES equipos_trabajo(equipo_id),
  FOREIGN KEY (modalidad_id) REFERENCES tipos_modalidad(modalidad_id)
);

CREATE TABLE coordinadores_departamento (
  coord_id INT PRIMARY KEY AUTO_INCREMENT,
  departamento_id INT NOT NULL,
  empleado_id INT NOT NULL,
  fecha_inicio TIMESTAMP NOT NULL,
  fecha_fin TIMESTAMP NULL,
  eliminado_en TIMESTAMP DEFAULT NULL,
  FOREIGN KEY (departamento_id) REFERENCES departamentos(departamento_id),
  FOREIGN KEY (empleado_id) REFERENCES empleados(empleado_id)
);

CREATE TABLE invitaciones_equipo (
  invitacion_id INT PRIMARY KEY AUTO_INCREMENT,
  equipo_id INT NOT NULL,
  empleado_id INT NOT NULL,
  fecha_invitacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  fecha_expiracion TIMESTAMP NULL,
  fecha_respuesta TIMESTAMP NULL,
  estado_invitacion VARCHAR(255) NOT NULL DEFAULT 'PENDIENTE',
  eliminado_en TIMESTAMP DEFAULT NULL,
  FOREIGN KEY (equipo_id) REFERENCES equipos_trabajo(equipo_id),
  FOREIGN KEY (empleado_id) REFERENCES empleados(empleado_id)
);

CREATE TABLE mensajes_equipo (
  mensaje_id INT PRIMARY KEY AUTO_INCREMENT,
  remitente_id INT NOT NULL,
  destinatario_id INT NOT NULL,
  contenido_mensaje TEXT NOT NULL,
  fecha_mensaje DATE NOT NULL,
  hora_mensaje TIME NOT NULL,
  leido TINYINT(1) NOT NULL,
  documento_id INT NULL,
  eliminado_en TIMESTAMP DEFAULT NULL,
  FOREIGN KEY (remitente_id) REFERENCES empleados(empleado_id),
  FOREIGN KEY (destinatario_id) REFERENCES empleados(empleado_id),
  FOREIGN KEY (documento_id) REFERENCES documentos(doc_id)
);
