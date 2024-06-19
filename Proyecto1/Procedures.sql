------------------------------------------------------------------------------------------------------------------------
--* Procedure PR2 - Cambio de Roles
USE IngenieriaBD;
GO
CREATE PROCEDURE proyecto1.PR2
    @Email VARCHAR(100),
    @CodCourse INT
AS
BEGIN

    DECLARE @Description NVARCHAR(MAX);

    BEGIN TRANSACTION

    BEGIN TRY

        -- Verificar si el usuario existe y tiene una cuenta activa
        IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE Email = @Email AND EmailConfirmed = 1)
        BEGIN
            -- CUALQUIER PROCESO ANTERIOR SE DESHACE
            ROLLBACK TRANSACTION
            -- MARCAR ERROR
            SET @Description = 'Cambio de Rol Fallido: El usuario no existe o no tiene una cuenta activa';
            INSERT INTO proyecto1.HistoryLog ([Date], Description)
            VALUES (GETDATE(), @Description);
            SELECT @Description AS 'Error';
            RETURN;
        END

        -- Obtener el ID del usuario
        DECLARE @UsuarioId INT
        SELECT @UsuarioId = UserId FROM Usuarios WHERE Email = @Email

        -- Agregar el rol de tutor al usuario
        INSERT INTO UsuarioRole (UserId, IdRol)
        SELECT @UsuarioId, IdRol FROM Roles WHERE RoleName = 'Tutor'

        -- Insertar perfil de tutor
        INSERT INTO TutorProfile (UserId) VALUES (@UsuarioId)

        -- Asignar el curso al tutor
        INSERT INTO CourseTutor (IdTutorProfile, CodCourse)
        SELECT IdTutorProfile, @CodCourse FROM TutorProfile WHERE UserId = @UsuarioId

        -- Insertar notificación de cambio de rol
        INSERT INTO Notification (UserId, Message)
        VALUES (@UsuarioId, 'Se te ha asignado el rol de tutor para el curso ' + (SELECT Name FROM Course WHERE CodCourse = @CodCourse))

        -- Mensaje de éxito
        SET @Description = 'Cambio de Rol Exitoso';
        INSERT INTO proyecto1.HistoryLog ([Date], Description)
        VALUES (GETDATE(), @Description);
        SELECT @Description AS Mensaje;

        -- Confirmar transaccion
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        -- CUALQUIER PROCESO ANTERIOR SE DESHACE
        ROLLBACK TRANSACTION;
        -- MARCAR ERROR
        SET @Description = 'Cambio de Roles Fallido: ' + ERROR_MESSAGE();
        INSERT INTO proyecto1.HistoryLog ([Date], Description)
        VALUES (GETDATE(), @Description);
        SELECT @Description AS 'Error';
    END CATCH
END
GO
------------------------------------------------------------------------------------------------------------------------
--* Procedure PR3 - Asignación de Curso
CREATE PROCEDURE proyecto1.PR3
    @Email VARCHAR(100),
    @CodCourse INT
AS
BEGIN

    DECLARE @Description NVARCHAR(MAX);

    -- Iniciar transaccion
    BEGIN TRANSACTION

    BEGIN TRY

        -- Verificar si el usuario existe y tiene una cuenta activa
        IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE Email = @Email AND EmailConfirmed = 1)
        BEGIN
            -- CUALQUIER PROCESO ANTERIOR SE DESHACE
            ROLLBACK TRANSACTION
            -- MARCAR ERROR
            SET @Description = 'Asignacion de Curso Fallida: El usuario no existe o no tiene una cuenta activa';
            INSERT INTO proyecto1.HistoryLog ([Date], Description)
            VALUES (GETDATE(), @Description);
            SELECT @Description AS 'Error';
            RETURN;
        END

        -- Obtener el ID del usuario
        DECLARE @UsuarioId INT
        SELECT @UsuarioId = UserId FROM Usuarios WHERE Email = @Email

        -- Verificar si el usuario tiene los créditos suficientes
        DECLARE @CreditsRequired INT
        SELECT @CreditsRequired = CreditsRequired FROM Course WHERE CodCourse = @CodCourse

        DECLARE @CreditsUsuario INT
        SELECT @CreditsUsuario = Credits FROM Usuarios WHERE UserId = @UsuarioId

        IF @CreditsUsuario < @CreditsRequired
        BEGIN
            -- CUALQUIER PROCESO ANTERIOR SE DESHACE
            ROLLBACK TRANSACTION
            -- MARCAR ERROR
            SET @Description = 'Asignacion de Curso Fallida: No contiene los creditos suficientes para la asignacion del curso';
            INSERT INTO proyecto1.HistoryLog ([Date], Description)
            VALUES (GETDATE(), @Description);
            SELECT @Description AS 'Error';
            RETURN;
        END

        -- Asignar el curso al estudiante
        INSERT INTO CourseAssignment (UserId, CodCourse)
        VALUES (@UsuarioId, @CodCourse)

        -- Obtener el ID del tutor del curso
        DECLARE @TutorProfileId INT
        SELECT @TutorProfileId = IdTutorProfile FROM CourseTutor WHERE CodCourse = @CodCourse

        -- Obtener el ID de usuario del tutor del curso
        DECLARE @TutorUsuarioId INT
        SELECT @TutorUsuarioId = UserId FROM TutorProfile WHERE IdTutorProfile = @TutorProfileId

        -- Insertar notificación para el tutor
        INSERT INTO Notification (UserId, Message)
        VALUES (@TutorUsuarioId, 'Se te ha asignado un nuevo estudiante al curso ' + (SELECT Name FROM Course WHERE CodCourse = @CodCourse))

        -- Insertar notificación para el estudiante
        INSERT INTO Notification (UserId, Message)
        VALUES (@UsuarioId, 'Se te ha asignado el curso ' + (SELECT Name FROM Course WHERE CodCourse = @CodCourse))

        -- Mensaje de éxito
        SET @Description = 'Asignacion de Curso Exitosa';
        INSERT INTO proyecto1.HistoryLog ([Date], Description)
        VALUES (GETDATE(), @Description);
        SELECT @Description AS Mensaje;

        -- Confirmar transaccion
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        -- CUALQUIER PROCESO ANTERIOR SE DESHACE
        ROLLBACK TRANSACTION;
        -- MARCAR ERROR
        SET @Description = 'Asignacion de Curso Fallida: ' + ERROR_MESSAGE();
        INSERT INTO proyecto1.HistoryLog ([Date], Description)
        VALUES (GETDATE(), @Description);
        SELECT @Description AS 'Error';
    END CATCH
END
GO
------------------------------------------------------------------------------------------------------------------------
--* Procedure PR4 - Creación de roles para estudiantes
CREATE PROCEDURE proyecto1.PR4
    @RoleName NVARCHAR(MAX)
AS
BEGIN
    DECLARE @Description NVARCHAR(MAX);

    -- Insercion del rol
    INSERT INTO Roles (RoleName)
    VALUES (@RoleName)

    -- Mensaje de éxito
    SET @Description = 'Insercion de Rol Exitosa';
    INSERT INTO proyecto1.HistoryLog ([Date], Description)
    VALUES (GETDATE(), @Description);
    SELECT @Description AS Mensaje;
END
GO
------------------------------------------------------------------------------------------------------------------------
--* Procedure PR6 - Validación de Datos
CREATE PROCEDURE proyecto1.PR6
    @EntityName NVARCHAR(50),
    @FirstName NVARCHAR(MAX) = NULL,
    @LastName NVARCHAR(MAX) = NULL,
    @Name NVARCHAR(MAX) = NULL,
    @CreditsRequired INT = NULL,
    @IsValid BIT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
	-- Validaciones de Usuario
    IF @EntityName = 'Usuarios'
    BEGIN
        IF ISNULL(@FirstName, '') NOT LIKE '%[^a-zA-Z ]%' AND ISNULL(@LastName, '') NOT LIKE '%[^a-zA-Z ]%'
            SET @IsValid = 1;
        ELSE
            SET @IsValid = 0;
    END
    -- Validacion de Curso
    ELSE IF @EntityName = 'Course'
    BEGIN
        IF ISNULL(@Name, '') NOT LIKE '%[^a-zA-Z 0-9]%' AND ISNUMERIC(@CreditsRequired) = 1
            SET @IsValid = 1;
        ELSE
            SET @IsValid = 0;
    END
    ELSE
    BEGIN
        -- No valida
        SET @IsValid = 0;
    END;
END;
GO
------------------------------------------------------------------------------------------------------------------------
--* Procedure PR5 - Creación de Cursos
CREATE PROCEDURE proyecto1.PR5
    @CodCourse INT,
    @Name NVARCHAR(MAX),
    @CreditsRequired INT
AS
BEGIN
    DECLARE @Description NVARCHAR(MAX);
    DECLARE @IsValid BIT;

    -- Iniciar transacción
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Validación usando PR6
        EXEC proyecto1.PR6 'Course', NULL, NULL, @Name, @CreditsRequired, @IsValid OUTPUT;

        IF @IsValid = 0
        BEGIN
            -- CUALQUIER PROCESO ANTERIOR SE DESHACE
            ROLLBACK TRANSACTION;
            -- MARCAR ERROR
            SET @Description = 'Insercion de Curso Fallida: Nombre o Creditos Incorrectos';
            INSERT INTO proyecto1.HistoryLog ([Date], Description)
            VALUES (GETDATE(), @Description);
            SELECT @Description AS 'Error';
            RETURN;
        END

        -- Validación de créditos negativos
        IF @CreditsRequired < 0
        BEGIN
            -- CUALQUIER PROCESO ANTERIOR SE DESHACE
            ROLLBACK TRANSACTION;
            -- MARCAR ERROR
            SET @Description = 'Insercion de Curso Fallida: Creditos no pueden ser negativos';
            INSERT INTO proyecto1.HistoryLog ([Date], Description)
            VALUES (GETDATE(), @Description);
            SELECT @Description AS 'Error';
            RETURN;
        END

        -- Validación de código de curso negativo
        IF @CodCourse < 0
        BEGIN
            -- CUALQUIER PROCESO ANTERIOR SE DESHACE
            ROLLBACK TRANSACTION;
            -- MARCAR ERROR
            SET @Description = 'Insercion de Curso Fallida: Codigo de Curso no puede ser negativo';
            INSERT INTO proyecto1.HistoryLog ([Date], Description)
            VALUES (GETDATE(), @Description);
            SELECT @Description AS 'Error';
            RETURN;
        END

        -- Inserción del curso
        INSERT INTO proyecto1.Course(CodCourse, Name, CreditsRequired)
        VALUES (@CodCourse, @Name, @CreditsRequired);

        -- Mensaje de éxito
        SET @Description = 'Insercion de Curso Exitosa';
        INSERT INTO proyecto1.HistoryLog ([Date], Description)
        VALUES (GETDATE(), @Description);
        SELECT @Description AS Mensaje;

        -- Confirmar transacción
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- CUALQUIER PROCESO ANTERIOR SE DESHACE
        ROLLBACK TRANSACTION;
        -- MARCAR ERROR
        SET @Description = 'Insercion de Curso Fallida: ' + ERROR_MESSAGE();
        INSERT INTO proyecto1.HistoryLog ([Date], Description)
        VALUES (GETDATE(), @Description);
        SELECT @Description AS 'Error';
    END CATCH;
END;
GO
------------------------------------------------------------------------------------------------------------------------
--* Procedure PR1 - Registro de Usuarios
CREATE PROCEDURE proyecto1.PR1
    @Firstname VARCHAR(max),
    @Lastname VARCHAR(max), 
    @Email VARCHAR(max), 
    @DateOfBirth datetime2(7), 
    @Password VARCHAR(max), 
    @Credits INT
AS
BEGIN
    DECLARE @UserId uniqueidentifier;
    DECLARE @RolId uniqueidentifier;
    DECLARE @ErrorMessage NVARCHAR(MAX);
    DECLARE @ErrorSeverity INT; 

    -- Validaciones de cada campo
    -- Firtsname vacio 
    IF (@Firstname IS NULL OR @Firstname = '')
    BEGIN 
        SET @ErrorMessage = 'Registro de Usuario Fallido: El nombre no puede ir vacio';
        SET @ErrorSeverity = 16;        
        RAISERROR(@ErrorMessage, @ErrorSeverity, 1);
        INSERT INTO proyecto1.HistoryLog ([Date], Description)
        VALUES (GETDATE(), @ErrorMessage);        
        RETURN;
    END

    -- Lastname vacio
    IF (@Lastname IS NULL OR @Lastname = '')
    BEGIN 
        SET @ErrorMessage = 'Registro de Usuario Fallido: El apellido no puede ir vacio';
        SET @ErrorSeverity = 16;
        RAISERROR(@ErrorMessage, @ErrorSeverity, 1);
        RETURN;
    END

    -- correo vacio
    IF (@Email IS NULL OR @Email = '')
    BEGIN 
        SET @ErrorMessage = 'Registro de Usuario Fallido: El campo correo no puede ir vacio';
        SET @ErrorSeverity = 16;
        RAISERROR(@ErrorMessage, @ErrorSeverity, 1);
        RETURN;
    END

    -- fecha vacia 
    IF (@DateOfBirth IS NULL)
    BEGIN
        SET @ErrorMessage = 'Registro de Usuario Fallido: La fecha de nacimiento no puede ir vacia';
        SET @ErrorSeverity = 16;
        RAISERROR(@ErrorMessage, @ErrorSeverity, 1);
        RETURN;
    END

    -- contaseoa vacia 
    IF (@Password IS NULL OR @Password = '')
    BEGIN
        SET @ErrorMessage = 'Registro de Usuario Fallido: El password no puede estar vacio';
        SET @ErrorSeverity = 16;
        RAISERROR(@ErrorMessage, @ErrorSeverity, 1);
        RETURN;
    END

    -- creditos con valor negativo 
    IF (@Credits < 0)
    BEGIN
        SET @ErrorMessage = 'Registro de Usuario Fallido: No puede ingresar una cantidad de creditos negativa';
        SET @ErrorSeverity = 16;
        RAISERROR(@ErrorMessage, @ErrorSeverity, 1);
        RETURN;
    END

    BEGIN TRY
    	-- Inicio de transaccion
        BEGIN TRANSACTION;
       
    	-- Validacion de datos utilizando el procedimiento PR6
        DECLARE @IsValid BIT;
        EXEC proyecto1.PR6 'Usuarios', @Firstname, @Lastname, NULL, NULL, @IsValid OUTPUT;
        IF(@IsValid = 0)
        BEGIN
            SET @ErrorMessage = 'Registro de Usuario Fallido: Algunos campos son incorrectos, solo deben contener letras';
            SET @ErrorSeverity = 16;
            RAISERROR(@ErrorMessage,@ErrorSeverity,1);
            RETURN;
        END     

        -- Validar si el que el email no esto asociado con ninguna otra cuenta dentro del sistema
        IF EXISTS (SELECT * FROM proyecto1.Usuarios WHERE Email = @Email)
        BEGIN
            SET @ErrorMessage = 'Registro de Usuario Fallido: Ya hay un usuario asociado con el correo indicado';
            SET @ErrorSeverity = 16;
            RAISERROR(@ErrorMessage, @ErrorSeverity, 1);
            RETURN;
        END

        -- Creacion de rol estudiante
        SET @RolId = (SELECT Id FROM proyecto1.Roles WHERE RoleName = 'Student');
        IF @RolId IS NULL
        BEGIN
            SET @ErrorMessage = 'Registro de Usuario Fallido: El rol del estudiante no existe';
            SET @ErrorSeverity = 16;
            RAISERROR(@ErrorMessage, @ErrorSeverity, 1);
            RETURN;
        END
        
        -- Insert tabla Usuarios
        SET @UserId = NEWID();
        INSERT INTO proyecto1.Usuarios(Id, Firstname, Lastname, Email, DateOfBirth, Password, LastChanges, EmailConfirmed)
        VALUES (@UserId, @Firstname, @Lastname, @Email, @DateOfBirth, @Password, GETDATE(), 1);

        -- Insert tabla UsuarioRole
        INSERT INTO proyecto1.UsuarioRole (RoleId, UserId, IsLatestVersion)
        VALUES (@RolId, @UserId, 1);

        -- Insert tabla ProfileStudent
        INSERT INTO proyecto1.ProfileStudent (UserId, Credits)
        VALUES (@UserId, @Credits);

        -- Insert tabla TFA
        INSERT INTO proyecto1.TFA (UserId, Status, LastUpdate)
        VALUES (@UserId, 1, GETDATE());

        -- Insert tabla Notification
        INSERT INTO proyecto1.Notification (UserId, Message, Date)
        VALUES (@UserId, 'Se ha registrado satisfactoriamente', GETDATE());
		PRINT 'El estudiante ha sido registrado satisfactoriamente';

        -- Mensaje de éxito
        SET @ErrorMessage = 'Registro de Usuario Exitoso';
        INSERT INTO proyecto1.HistoryLog ([Date], Description)
        VALUES (GETDATE(), @ErrorMessage);
        SELECT @ErrorMessage AS Mensaje;

        -- Confirmar transacción
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- CUALQUIER PROCESO ANTERIOR SE DESHACE
        ROLLBACK TRANSACTION;
        -- MARCAR ERROR
        SET @ErrorMessage = 'Registro de Usuario Fallido: ' + ERROR_MESSAGE();
        INSERT INTO proyecto1.HistoryLog ([Date], Description)
        VALUES (GETDATE(), @ErrorMessage);
        SELECT @ErrorMessage AS 'Error';
        RAISERROR (@ErrorMessage, 16, 1);
    END CATCH;
END;
