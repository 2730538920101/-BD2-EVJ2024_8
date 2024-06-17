CREATE DATABASE IngenieriaBD;

-- Verificar si la tabla Usuarios existe, si no, crearla
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Usuarios')
BEGIN
    CREATE TABLE Usuarios (
        IdUsuario INT PRIMARY KEY IDENTITY(1,1),
        FirstName VARCHAR(50) NOT NULL,
        LastName VARCHAR(50) NOT NULL,
        Email VARCHAR(100) UNIQUE NOT NULL,
        DateOfBirth DATE NOT NULL,
        Password VARCHAR(100) NOT NULL,
        Credits INT NOT NULL,
        EmailConfirmed BIT NOT NULL
    );
END

SELECT * FROM dbo.Usuarios;

-- Verificar si la tabla Roles existe, si no, crearla
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Roles')
BEGIN
    CREATE TABLE Roles (
        IdRol INT PRIMARY KEY IDENTITY(1,1),
        RoleName VARCHAR(50) NOT NULL
    );
END

SELECT * FROM dbo.Roles;

-- Verificar si la tabla UsuarioRole existe, si no, crearla
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'UsuarioRole')
BEGIN
    CREATE TABLE UsuarioRole (
        IdUsuarioRole INT PRIMARY KEY IDENTITY(1,1),
        IdUsuario INT FOREIGN KEY REFERENCES Usuarios(IdUsuario),
        IdRol INT FOREIGN KEY REFERENCES Roles(IdRol)
    );
END

SELECT * FROM dbo.UsuarioRole;

-- Verificar si la tabla Course existe, si no, crearla
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Course')
BEGIN
    CREATE TABLE Course (
        CodCourse INT PRIMARY KEY IDENTITY(1,1),
        Name VARCHAR(100) NOT NULL,
        CreditsRequired INT NOT NULL
    );
END

SELECT * FROM dbo.Course;

-- Verificar si la tabla ProfileStudent existe, si no, crearla
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'ProfileStudent')
BEGIN
    CREATE TABLE ProfileStudent (
        IdProfileStudent INT PRIMARY KEY IDENTITY(1,1),
        IdUsuario INT UNIQUE FOREIGN KEY REFERENCES Usuarios(IdUsuario)
    );
END

SELECT * FROM dbo.ProfileStudent;

-- Verificar si la tabla TutorProfile existe, si no, crearla
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'TutorProfile')
BEGIN
    CREATE TABLE TutorProfile (
        IdTutorProfile INT PRIMARY KEY IDENTITY(1,1),
        IdUsuario INT UNIQUE FOREIGN KEY REFERENCES Usuarios(IdUsuario)
    );
END
SELECT * FROM dbo.TutorProfile;

-- Verificar si la tabla CourseTutor existe, si no, crearla
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'CourseTutor')
BEGIN
    CREATE TABLE CourseTutor (
        IdCourseTutor INT PRIMARY KEY IDENTITY(1,1),
        IdTutorProfile INT FOREIGN KEY REFERENCES TutorProfile(IdTutorProfile),
        CodCourse INT FOREIGN KEY REFERENCES Course(CodCourse)
    );
END
SELECT * FROM dbo.CourseTutor;

-- Verificar si la tabla CourseAssignment existe, si no, crearla
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'CourseAssignment')
BEGIN
    CREATE TABLE CourseAssignment (
        IdCourseAssignment INT PRIMARY KEY IDENTITY(1,1),
        IdUsuario INT FOREIGN KEY REFERENCES Usuarios(IdUsuario),
        CodCourse INT FOREIGN KEY REFERENCES Course(CodCourse)
    );
END
SELECT * FROM dbo.CourseAssignment;

-- Verificar si la tabla TFA existe, si no, crearla
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'TFA')
BEGIN
    CREATE TABLE TFA (
        IdTFA INT PRIMARY KEY IDENTITY(1,1),
        IdUsuario INT UNIQUE FOREIGN KEY REFERENCES Usuarios(IdUsuario),
        Enabled BIT NOT NULL
    );
END
SELECT * FROM dbo.TFA;

-- Verificar si la tabla Notification existe, si no, crearla
IF NOT EXISTS (SELECT * FROM sys.tables WHERE name = 'Notification')
BEGIN
    CREATE TABLE Notification (
        IdNotification INT PRIMARY KEY IDENTITY(1,1),
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
        Action VARCHAR(10) NOT NULL,
        TableName VARCHAR(50) NOT NULL,
        OldValues VARCHAR(MAX),
        NewValues VARCHAR(MAX),
        Timestamp DATETIME NOT NULL DEFAULT GETDATE()
    );
END
SELECT * FROM dbo.HistoryLog;