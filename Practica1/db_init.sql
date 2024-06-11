CREATE DATABASE PRACTICA1;

USE PRACTICA1;

-- Creación de la tabla PACIENTE
CREATE TABLE PACIENTE(
    idPaciente INT PRIMARY KEY,  -- Añadido AUTO_INCREMENT
    edad INT,
    genero VARCHAR(20)
);

-- Creación de la tabla HABITACION
CREATE TABLE HABITACION(
    idHabitacion INT PRIMARY KEY,  -- Añadido AUTO_INCREMENT
    habitacion VARCHAR(50)
);

-- Creación de la tabla LOG_HABITACION
CREATE TABLE LOG_HABITACION(
    id_log_habitacion INT AUTO_INCREMENT PRIMARY KEY,
    idHabitacion INT,  -- Definido solo el campo
    timestampx VARCHAR(100),  -- Cambiado a VARCHAR(100)
    statusx VARCHAR(45),
    FOREIGN KEY (idHabitacion) REFERENCES HABITACION(idHabitacion)  -- Definición de la clave externa
);

-- Creación de la tabla LOG_ACTIVIDAD
CREATE TABLE LOG_ACTIVIDAD(
    id_log_actividad INT AUTO_INCREMENT PRIMARY KEY,
    timestampx VARCHAR(100),  -- Cambiado a VARCHAR(100)
    actividad VARCHAR(500),
    idPaciente INT,
    idHabitacion INT,
    FOREIGN KEY (idPaciente) REFERENCES PACIENTE(idPaciente),  -- Definición de la clave externa
    FOREIGN KEY (idHabitacion) REFERENCES HABITACION(idHabitacion)  -- Definición de la clave externa
);
