CREATE DATABASE PRACTICA1;

USE PRACTICA1;

-- Creación de la tabla PACIENTE
CREATE TABLE PACIENTE(
    idPaciente INT PRIMARY KEY,
    edad INT,
    genero VARCHAR(20)
);

-- Creación de la tabla HABITACION
CREATE TABLE HABITACION(
    idHabitacion INT PRIMARY KEY,
    habitacion VARCHAR(50)
);

-- Creación de la tabla LOG_HABITACION
CREATE TABLE LOG_HABITACION(
    idLogHabitacion INT AUTO_INCREMENT PRIMARY KEY,
    idHabitacion INT,
    timestampx TIMESTAMP,
    statusx VARCHAR(45),
    FOREIGN KEY (idHabitacion) REFERENCES HABITACION(idHabitacion)
);

-- Creación de la tabla LOG_ACTIVIDAD
CREATE TABLE LOG_ACTIVIDAD(
    idLogActividad INT AUTO_INCREMENT PRIMARY KEY,
    timestampx TIMESTAMP,
    actividad VARCHAR(500),
    idPaciente INT,
    idHabitacion INT,
    FOREIGN KEY (idPaciente) REFERENCES PACIENTE(idPaciente),
    FOREIGN KEY (idHabitacion) REFERENCES HABITACION(idHabitacion)
);
