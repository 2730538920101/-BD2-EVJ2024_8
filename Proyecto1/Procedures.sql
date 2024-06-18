------------------------------------------------------------------------------------------------------------------------
--* Procedure PR1 - Registro de Usuarios
USE IngenieriaBD; 
GO

CREATE PROCEDURE PR1
(
    @Firstname VARCHAR(50),
    @Lastname VARCHAR(50),
    @Email VARCHAR(100),
    @DateOfBirth DATE,
    @Password VARCHAR(100),
    @Credits INT
)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Verificar si el email ya está registrado
        IF EXISTS (SELECT 1 FROM Usuarios WHERE Email = @Email)
        BEGIN
            ROLLBACK TRANSACTION;
            RETURN;
        END

        -- Insertar nuevo usuario
        INSERT INTO Usuarios (FirstName, LastName, Email, DateOfBirth, Password, Credits, EmailConfirmed)
        VALUES (@Firstname, @Lastname, @Email, @DateOfBirth, @Password, @Credits, 1);

        -- Obtener el ID del nuevo usuario
        DECLARE @UsuarioId INT;
        SET @UsuarioId = SCOPE_IDENTITY();

        -- Asignar rol de estudiante al nuevo usuario
        INSERT INTO UsuarioRole (IdUsuario, IdRol)
        SELECT @UsuarioId, IdRol FROM Roles WHERE RoleName = 'Student';

        -- Insertar perfil de estudiante
        INSERT INTO ProfileStudent (IdUsuario) VALUES (@UsuarioId);

        -- Insertar notificación de registro
        INSERT INTO Notification (IdUsuario, Message)
        VALUES (@UsuarioId, 'Se ha registrado correctamente en el sistema.');

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
        -- Re-throw the error to the calling environment
        THROW;
    END CATCH
END;
GO


------------------------------------------------------------------------------------------------------------------------
--* Procedure PR2 - Cambio de Roles

USE IngenieriaBD;
GO

CREATE PROCEDURE PR2
(
    @Email VARCHAR(100),
    @CodCourse INT
)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        -- Verificar si el usuario existe y tiene una cuenta activa
        IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE Email = @Email AND EmailConfirmed = 1)
        BEGIN
            ROLLBACK TRANSACTION
            RETURN
        END

        -- Obtener el ID del usuario
        DECLARE @UsuarioId INT
        SELECT @UsuarioId = IdUsuario FROM Usuarios WHERE Email = @Email

        -- Agregar el rol de tutor al usuario
        INSERT INTO UsuarioRole (IdUsuario, IdRol)
        SELECT @UsuarioId, IdRol FROM Roles WHERE RoleName = 'Tutor'

        -- Insertar perfil de tutor
        INSERT INTO TutorProfile (IdUsuario) VALUES (@UsuarioId)

        -- Asignar el curso al tutor
        INSERT INTO CourseTutor (IdTutorProfile, CodCourse)
        SELECT IdTutorProfile, @CodCourse FROM TutorProfile WHERE IdUsuario = @UsuarioId

        -- Insertar notificación de cambio de rol
        INSERT INTO Notification (IdUsuario, Message)
        VALUES (@UsuarioId, 'Se te ha asignado el rol de tutor para el curso ' + (SELECT Name FROM Course WHERE CodCourse = @CodCourse))

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        THROW
    END CATCH
END
GO

------------------------------------------------------------------------------------------------------------------------
--* Procedure PR3 - Asignación de Curso

USE IngenieriaBD;
GO

CREATE PROCEDURE PR3
(
    @Email VARCHAR(100),
    @CodCourse INT
)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        -- Verificar si el usuario existe y tiene una cuenta activa
        IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE Email = @Email AND EmailConfirmed = 1)
        BEGIN
            ROLLBACK TRANSACTION
            RETURN
        END

        -- Obtener el ID del usuario
        DECLARE @UsuarioId INT
        SELECT @UsuarioId = IdUsuario FROM Usuarios WHERE Email = @Email

        -- Verificar si el usuario tiene los créditos suficientes
        DECLARE @CreditsRequired INT
        SELECT @CreditsRequired = CreditsRequired FROM Course WHERE CodCourse = @CodCourse

        DECLARE @CreditsUsuario INT
        SELECT @CreditsUsuario = Credits FROM Usuarios WHERE IdUsuario = @UsuarioId

        IF @CreditsUsuario < @CreditsRequired
        BEGIN
            ROLLBACK TRANSACTION
            RETURN
        END

        -- Asignar el curso al estudiante
        INSERT INTO CourseAssignment (IdUsuario, CodCourse)
        VALUES (@UsuarioId, @CodCourse)

        -- Obtener el ID del tutor del curso
        DECLARE @TutorProfileId INT
        SELECT @TutorProfileId = IdTutorProfile
        FROM CourseTutor
        WHERE CodCourse = @CodCourse

        -- Insertar notificación para el estudiante
        INSERT INTO Notification (IdUsuario, Message)
        VALUES (@UsuarioId, 'Se te ha asignado el curso ' + (SELECT Name FROM Course WHERE CodCourse = @CodCourse))

        -- Insertar notificación para el tutor
        DECLARE @TutorUsuarioId INT
        SELECT @TutorUsuarioId = IdUsuario
        FROM TutorProfile
        WHERE IdTutorProfile = @TutorProfileId

        INSERT INTO Notification (IdUsuario, Message)
        VALUES (@TutorUsuarioId, 'Se te ha asignado un nuevo estudiante al curso ' + (SELECT Name FROM Course WHERE CodCourse = @CodCourse))

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        THROW
    END CATCH
END
GO

------------------------------------------------------------------------------------------------------------------------
--* Procedure PR4 - Creación de roles para estudiantes

USE IngenieriaBD;
GO

CREATE PROCEDURE PR4
(
    @RoleName VARCHAR(50)
)
AS
BEGIN
    INSERT INTO Roles (RoleName)
    VALUES (@RoleName)
END
GO

------------------------------------------------------------------------------------------------------------------------
--* Procedure PR5 - Creación de Cursos

USE IngenieriaBD;
GO

CREATE PROCEDURE PR5
(
    @Name VARCHAR(100),
    @CreditsRequired INT
)
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION

        INSERT INTO Course (Name, CreditsRequired)
        VALUES (@Name, @CreditsRequired)

        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION
        THROW
    END CATCH
END
GO

------------------------------------------------------------------------------------------------------------------------
--* Procedure PR6 - Validación de Datos


USE IngenieriaBD;
GO

CREATE PROCEDURE PR6
AS
BEGIN
    -- Validar campos FirstName y LastName en la tabla Usuarios
    IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CHK_Usuarios_Nombres')
    BEGIN
        ALTER TABLE Usuarios
        ADD CONSTRAINT CHK_Usuarios_Nombres CHECK (FirstName NOT LIKE '%[^a-zA-Z]%' AND LastName NOT LIKE '%[^a-zA-Z]%')
    END

    -- Validar campo Name en la tabla Course
    IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CHK_Course_Name')
    BEGIN
        ALTER TABLE Course
        ADD CONSTRAINT CHK_Course_Name CHECK (Name NOT LIKE '%[^a-zA-Z ]%')
    END

    -- Validar campo CreditsRequired en la tabla Course
    IF NOT EXISTS (SELECT * FROM sys.check_constraints WHERE name = 'CHK_Course_CreditsRequired')
    BEGIN
        ALTER TABLE Course
        ADD CONSTRAINT CHK_Course_CreditsRequired CHECK (CreditsRequired >= 0 AND CreditsRequired <= 10)
    END
END;
GO

