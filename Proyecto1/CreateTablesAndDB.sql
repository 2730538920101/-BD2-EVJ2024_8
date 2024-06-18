CREATE DATABASE IngenieriaBD;

USE IngenieriaBD;
GO
-- Verificar si la tabla Usuarios existe, si no, crearla
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Usuarios')
BEGIN
    CREATE SEQUENCE UsuarioIdSequence
        AS INT
        START WITH 1
        INCREMENT BY 1;

    CREATE TABLE Usuarios (
        IdUsuario INT PRIMARY KEY DEFAULT (NEXT VALUE FOR UsuarioIdSequence),
        FirstName VARCHAR(50) NOT NULL,
        LastName VARCHAR(50) NOT NULL,
        Email VARCHAR(100) UNIQUE NOT NULL,
        DateOfBirth DATE NOT NULL,
        Password VARCHAR(100) NOT NULL,
        Credits INT NOT NULL,
        EmailConfirmed BIT NOT NULL
    );
END
GO

SELECT * FROM dbo.Usuarios;

-- Verificar si la tabla Roles existe, si no, crearla
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Roles')
BEGIN
    CREATE SEQUENCE RolesIdSequence
        AS INT
        START WITH 1
        INCREMENT BY 1;
    CREATE TABLE Roles (
        IdRol INT PRIMARY KEY DEFAULT (NEXT VALUE FOR RolesIdSequence),
        RoleName VARCHAR(50) NOT NULL
    );
END

SELECT * FROM dbo.Roles;

-- Verificar si la tabla UsuarioRole existe, si no, crearla
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'UsuarioRole')
BEGIN
    CREATE SEQUENCE UsuarioRoleIdSequence
        AS INT
        START WITH 1
        INCREMENT BY 1;
    CREATE TABLE UsuarioRole (
        IdUsuarioRole INT PRIMARY KEY DEFAULT (NEXT VALUE FOR UsuarioRoleIdSequence),
        IdUsuario INT FOREIGN KEY REFERENCES Usuarios(IdUsuario),
        IdRol INT FOREIGN KEY REFERENCES Roles(IdRol)
    );
END

SELECT * FROM dbo.UsuarioRole;

-- Verificar si la tabla Course existe, si no, crearla
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Course')
BEGIN
    CREATE SEQUENCE CourseIdSequence
        AS INT
        START WITH 1
        INCREMENT BY 1;
    CREATE TABLE Course (
        CodCourse INT PRIMARY KEY DEFAULT (NEXT VALUE FOR CourseIdSequence),
        Name VARCHAR(100) NOT NULL,
        CreditsRequired INT NOT NULL
    );
END

SELECT * FROM dbo.Course;

-- Verificar si la tabla ProfileStudent existe, si no, crearla
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'ProfileStudent')
BEGIN
    CREATE SEQUENCE ProfileStudentIdSequence
        AS INT
        START WITH 1
        INCREMENT BY 1;
    CREATE TABLE ProfileStudent (
        IdProfileStudent INT PRIMARY KEY DEFAULT (NEXT VALUE FOR ProfileStudentIdSequence),
        IdUsuario INT UNIQUE FOREIGN KEY REFERENCES Usuarios(IdUsuario)
    );
END

SELECT * FROM dbo.ProfileStudent;

-- Verificar si la tabla TutorProfile existe, si no, crearla
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'TutorProfile')
BEGIN
    CREATE SEQUENCE TutorProfileIdSequence
        AS INT
        START WITH 1
        INCREMENT BY 1;
    CREATE TABLE TutorProfile (
        IdTutorProfile INT PRIMARY KEY DEFAULT (NEXT VALUE FOR TutorProfileIdSequence),
        IdUsuario INT UNIQUE FOREIGN KEY REFERENCES Usuarios(IdUsuario)
    );
END
SELECT * FROM dbo.TutorProfile;

-- Verificar si la tabla CourseTutor existe, si no, crearla
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'CourseTutor')
BEGIN
    CREATE SEQUENCE CourseTutorIdSequence
        AS INT
        START WITH 1
        INCREMENT BY 1;
    CREATE TABLE CourseTutor (
        IdCourseTutor INT PRIMARY KEY DEFAULT (NEXT VALUE FOR CourseTutorIdSequence),
        IdTutorProfile INT FOREIGN KEY REFERENCES TutorProfile(IdTutorProfile),
        CodCourse INT FOREIGN KEY REFERENCES Course(CodCourse)
    );
END
SELECT * FROM dbo.CourseTutor;

-- Verificar si la tabla CourseAssignment existe, si no, crearla
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'CourseAssignment')
BEGIN
    CREATE SEQUENCE CourseAssignmentIdSequence
        AS INT
        START WITH 1
        INCREMENT BY 1;
    CREATE TABLE CourseAssignment (
        IdCourseAssignment INT PRIMARY KEY DEFAULT (NEXT VALUE FOR CourseAssignmentIdSequence),
        IdUsuario INT FOREIGN KEY REFERENCES Usuarios(IdUsuario),
        CodCourse INT FOREIGN KEY REFERENCES Course(CodCourse)
    );
END
SELECT * FROM dbo.CourseAssignment;

-- Verificar si la tabla TFA existe, si no, crearla
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'TFA')
BEGIN
    CREATE SEQUENCE TFAIdSequence
        AS INT
        START WITH 1
        INCREMENT BY 1;
    CREATE TABLE TFA (
        IdTFA INT PRIMARY KEY DEFAULT (NEXT VALUE FOR TFAIdSequence),
        IdUsuario INT UNIQUE FOREIGN KEY REFERENCES Usuarios(IdUsuario),
        Enabled BIT NOT NULL
    );
END
SELECT * FROM dbo.TFA;

-- Verificar si la tabla Notification existe, si no, crearla
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Notification')
BEGIN
    CREATE SEQUENCE NotificationIdSequence
        AS INT
        START WITH 1
        INCREMENT BY 1;
    CREATE TABLE Notification (
        IdNotification INT PRIMARY KEY DEFAULT (NEXT VALUE FOR NotificationIdSequence),
        IdUsuario INT FOREIGN KEY REFERENCES Usuarios(IdUsuario),
        Message VARCHAR(MAX) NOT NULL
    );
END
SELECT * FROM dbo.Notification;


-- Verificar si la tabla HistoryLog existe, si no, crearla
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'HistoryLog')
BEGIN
    CREATE TABLE HistoryLog (
        IdHistoryLog INT PRIMARY KEY IDENTITY(1,1),
        description_ VARCHAR(MAX) NOT NULL,
        type_ VARCHAR(MAX) NOT NULL,
        Timestamp_ DATETIME NOT NULL DEFAULT GETDATE()
    ) PRINT 'Tabla HistorialTransaccion creada correctamente.';
END 
SELECT * FROM dbo.HistoryLog;
DROP TABLE IF EXISTS HistoryLog;
