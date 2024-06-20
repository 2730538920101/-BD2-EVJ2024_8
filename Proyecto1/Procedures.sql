USE IngenieriaBD;
GO
------------------------------------------------------------------------------------------------------------------------
--* Procedure PR2 - Cambio de Roles

/*
Descripción: Este procedimiento permite cambiar el rol de un usuario a tutor y asignarle un curso.

Parámetros:
    @Email VARCHAR(100) - El correo electrónico del usuario.
    @CodCourse INT - El código del curso que se asignará al tutor.

Funcionamiento:
1. Verifica que el correo y el código de curso sean válidos.
2. Comprueba que el usuario exista y tenga una cuenta activa.
3. Agrega el rol de tutor al usuario.
4. Crea un perfil de tutor para el usuario.
5. Asigna el curso especificado al tutor.
6. Envía una notificación al usuario sobre su nuevo rol.

Manejo de errores:
- Si ocurre algún error, la transacción se revierte y se registra en el HistoryLog.
*/
CREATE PROCEDURE proyecto1.PR2
    @Email VARCHAR(100),
    @CodCourse INT
AS
BEGIN

    DECLARE @Description NVARCHAR(MAX);

    BEGIN TRY

        -- Iniciar transaccion
        BEGIN TRANSACTION

        -- Correo vacio
        IF (@Email IS NULL OR @Email = '')
        BEGIN
            SET @Description = 'El campo correo no puede ir vacio';
            RAISERROR(@Description, 16, 1);
            RETURN;
        END

        -- Codigo de curso negativo
        IF @CodCourse < 0
        BEGIN
            -- MARCAR ERROR
            SET @Description = 'El campo codigo de curso no puede ser negativo';
            RAISERROR(@Description, 16, 1);
            RETURN;
        END

        -- Verificacion de existencia de curso
        IF NOT EXISTS (SELECT 1 FROM Course WHERE CodCourse = @CodCourse)
        BEGIN
            -- MARCAR ERROR
            SET @Description = 'El curso no existe';
            RAISERROR(@Description, 16, 1);
            RETURN;
        END

        -- Verificar si el usuario existe y tiene una cuenta activa
        IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE Email = @Email AND EmailConfirmed = 1)
        BEGIN
            -- MARCAR ERROR
            SET @Description = 'El usuario no existe o no tiene una cuenta activa';
            RAISERROR(@Description, 16, 1);
            RETURN;
        END

        -- Obtener el ID del usuario
        DECLARE @UsuarioId UNIQUEIDENTIFIER
        SELECT @UsuarioId = Id FROM Usuarios WHERE Email = @Email

        -- Agregar el rol de tutor al usuario
        INSERT INTO UsuarioRole (UserId, RoleId, IsLatestVersion)
        SELECT @UsuarioId, Id, 1 FROM Roles WHERE RoleName = 'Tutor'

        -- Insertar perfil de tutor
        INSERT INTO TutorProfile (UserId, TutorCode) VALUES (@UsuarioId, @UsuarioId)

        -- Asignar el curso al tutor
        INSERT INTO CourseTutor (TutorId, CourseCodCourse) VALUES (@UsuarioId, @CodCourse);

        -- Insertar notificacion de cambio de rol
        INSERT INTO Notification (UserId, Message, [Date])
        VALUES (@UsuarioId, 'Se te ha asignado el rol de tutor para el curso ' + (SELECT Name FROM Course WHERE CodCourse = @CodCourse), GETDATE())

        -- Mensaje de exito
        SET @Description = 'Cambio de Rol Exitoso';
        INSERT INTO proyecto1.HistoryLog ([Date], Description) VALUES (GETDATE(), @Description);
        PRINT @Description;

        -- Confirmar transaccion
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        -- CUALQUIER PROCESO ANTERIOR SE DESHACE
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
        -- MARCAR ERROR
        SET @Description = 'Cambio de Role Fallido: ' + ERROR_MESSAGE();
        INSERT INTO proyecto1.HistoryLog ([Date], Description) VALUES (GETDATE(), @Description);
        RAISERROR(@Description, 16, 1);
    END CATCH
END
GO
------------------------------------------------------------------------------------------------------------------------
--* Procedure PR3 - Asignacion de Curso

/*
Descripción: Este procedimiento asigna un curso a un estudiante.

Parámetros:
    @Email VARCHAR(100) - El correo electrónico del estudiante.
    @CodCourse INT - El código del curso que se asignará al estudiante.

Funcionamiento:
1. Verifica que el correo y el código de curso sean válidos.
2. Comprueba que el usuario exista y tenga una cuenta activa.
3. Verifica que el estudiante tenga suficientes créditos para el curso.
4. Asigna el curso al estudiante.
5. Envía notificaciones al tutor y al estudiante sobre la asignación.

Manejo de errores:
- Si ocurre algún error, la transacción se revierte y se registra en el HistoryLog.
*/
CREATE PROCEDURE proyecto1.PR3
    @Email VARCHAR(100),
    @CodCourse INT
AS
BEGIN

    DECLARE @Description NVARCHAR(MAX);

    BEGIN TRY

        -- Iniciar transaccion
        BEGIN TRANSACTION

        -- Correo vacio
        IF (@Email IS NULL OR @Email = '')
        BEGIN
            SET @Description = 'El campo correo no puede ir vacio';
            RAISERROR(@Description, 16, 1);
            RETURN;
        END

        -- Codigo de curso negativo
        IF @CodCourse < 0
        BEGIN
            -- MARCAR ERROR
            SET @Description = 'El campo codigo de curso no puede ser negativo';
            RAISERROR(@Description, 16, 1);
            RETURN;
        END

        -- Verificar si el usuario existe y tiene una cuenta activa
        IF NOT EXISTS (SELECT 1 FROM Usuarios WHERE Email = @Email AND EmailConfirmed = 1)
        BEGIN
            -- MARCAR ERROR
            SET @Description = 'El usuario no existe o no tiene una cuenta activa';
            RAISERROR(@Description, 16, 1);
            RETURN;
        END

        -- Obtener el ID del usuario
        DECLARE @UsuarioId UNIQUEIDENTIFIER
        SELECT @UsuarioId = Id FROM Usuarios WHERE Email = @Email;

        -- Verificar si el usuario tiene los creditos suficientes
        DECLARE @CreditsRequired INT
        SELECT @CreditsRequired = CreditsRequired FROM Course WHERE CodCourse = @CodCourse;
        DECLARE @CreditsUsuario INT
        SELECT @CreditsUsuario = Credits FROM ProfileStudent WHERE UserId = @UsuarioId;

        IF @CreditsUsuario < @CreditsRequired
        BEGIN
            -- MARCAR ERROR
            SET @Description = 'No contiene los creditos suficientes para la asignacion del curso';
            RAISERROR(@Description, 16, 1);
            RETURN;
        END

        -- Obtener el ID de usuario del tutor del curso
        DECLARE @TutorUsuarioId UNIQUEIDENTIFIER;
        SELECT @TutorUsuarioId = TutorId FROM CourseTutor WHERE CourseCodCourse = @CodCourse;

        -- Si el curso no tiene tutor asignado se retorna error
        IF @TutorUsuarioId IS NULL
        BEGIN
            -- MARCAR ERROR
            SET @Description = 'El curso no tiene tutor asignado';
            RAISERROR(@Description, 16, 1);
            RETURN;
        END

        -- Asignar el curso al estudiante
        INSERT INTO CourseAssignment (StudentId, CourseCodCourse) VALUES (@UsuarioId, @CodCourse);

        -- Insertar notificacion para el tutor
        INSERT INTO Notification (UserId, Message, [Date])
        VALUES (@TutorUsuarioId, 'Se te ha asignado un nuevo estudiante al curso ' + (SELECT Name FROM Course WHERE CodCourse = @CodCourse), GETDATE());

        -- Insertar notificacion para el estudiante
        INSERT INTO Notification (UserId, Message, [Date])
        VALUES (@UsuarioId, 'Se te ha asignado el curso ' + (SELECT Name FROM Course WHERE CodCourse = @CodCourse), GETDATE());

        -- Mensaje de exito
        SET @Description = 'Asignacion de Curso Exitosa';
        INSERT INTO proyecto1.HistoryLog ([Date], Description) VALUES (GETDATE(), @Description);
        PRINT @Description;

        -- Confirmar transaccion
        COMMIT TRANSACTION
    END TRY
    BEGIN CATCH
        -- CUALQUIER PROCESO ANTERIOR SE DESHACE
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
        -- MARCAR ERROR
        SET @Description = 'Asignacion de Curso Fallida: ' + ERROR_MESSAGE();
        INSERT INTO proyecto1.HistoryLog ([Date], Description) VALUES (GETDATE(), @Description);
        RAISERROR(@Description, 16, 1);
    END CATCH
END
GO
------------------------------------------------------------------------------------------------------------------------
--* Procedure PR4 - Creacion de roles para estudiantes

/*
Descripción: Este procedimiento crea un nuevo rol en el sistema.

Parámetros:
    @RoleName NVARCHAR(MAX) - El nombre del nuevo rol.

Funcionamiento:
1. Verifica que el nombre del rol no esté vacío y solo contenga letras.
2. Inserta el nuevo rol en la tabla Roles.

Manejo de errores:
- Si ocurre algún error, la transacción se revierte y se registra en el HistoryLog.
*/
CREATE PROCEDURE proyecto1.PR4
    @RoleName NVARCHAR(MAX)
AS
BEGIN
    DECLARE @Description NVARCHAR(MAX);

    BEGIN TRY

        -- Iniciar transaccion
        BEGIN TRANSACTION;

        -- Nombre vacio
        IF (@RoleName IS NULL OR @RoleName = '')
        BEGIN
            -- MARCAR ERROR
            SET @Description = 'El nombre del rol no puede ir vacio';
            RAISERROR(@Description, 16, 1);
            RETURN;
        END

        -- Validacion de nombre de rol
        IF ISNULL(@RoleName, '') LIKE '%[^a-zA-Z ]%'
        BEGIN
            -- MARCAR ERROR
            SET @Description = 'El nombre del rol solo acepta letras';
            RAISERROR(@Description, 16, 1);
            RETURN;
        END

        -- Insercion del rol
        INSERT INTO Roles (Id, RoleName) VALUES (NEWID(), @RoleName);

        -- Mensaje de exito
        SET @Description = 'Insercion de Rol Exitosa';
        INSERT INTO proyecto1.HistoryLog ([Date], Description) VALUES (GETDATE(), @Description);
        PRINT @Description;

        -- Confirmar transaccion
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
       -- CUALQUIER PROCESO ANTERIOR SE DESHACE
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
        -- MARCAR ERROR
        SET @Description = 'Creacion de Roles Fallido: ' + ERROR_MESSAGE();
        INSERT INTO proyecto1.HistoryLog ([Date], Description) VALUES (GETDATE(), @Description);
        RAISERROR(@Description, 16, 1);
    END CATCH;
END
GO
------------------------------------------------------------------------------------------------------------------------
--* Procedure PR6 - Validacion de Datos

/*
Descripción: Este procedimiento valida los datos de entrada para las entidades Usuarios y Course.

Parámetros:
    @EntityName NVARCHAR(50) - El nombre de la entidad a validar ('Usuarios' o 'Course').
    @FirstName NVARCHAR(MAX) - El nombre del usuario (solo para 'Usuarios').
    @LastName NVARCHAR(MAX) - El apellido del usuario (solo para 'Usuarios').
    @Name NVARCHAR(MAX) - El nombre del curso (solo para 'Course').
    @CreditsRequired INT - Los créditos requeridos para el curso (solo para 'Course').
    @IsValid BIT OUTPUT - Variable de salida que indica si los datos son válidos (1) o no (0).

Funcionamiento:
1. Dependiendo de la entidad, valida los campos correspondientes.
2. Para 'Usuarios', verifica que FirstName y LastName solo contengan letras.
3. Para 'Course', verifica que Name solo contenga letras y números, y que CreditsRequired sea numérico.

Uso:
Este procedimiento es utilizado internamente por otros procedimientos para validar datos.
*/
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
--* Procedure PR5 - Creacion de Cursos

/*
Descripción: Este procedimiento crea un nuevo curso en el sistema.

Parámetros:
    @CodCourse INT - El código del nuevo curso.
    @Name NVARCHAR(MAX) - El nombre del nuevo curso.
    @CreditsRequired INT - Los créditos requeridos para el curso.

Funcionamiento:
1. Valida los datos del curso utilizando el procedimiento PR6.
2. Verifica que los créditos y el código del curso no sean negativos.
3. Inserta el nuevo curso en la tabla Course.

Manejo de errores:
- Si ocurre algún error, la transacción se revierte y se registra en el HistoryLog.
*/
CREATE PROCEDURE proyecto1.PR5
    @CodCourse INT,
    @Name NVARCHAR(MAX),
    @CreditsRequired INT
AS
BEGIN
    DECLARE @Description NVARCHAR(MAX);
    DECLARE @IsValid BIT;

    BEGIN TRY

        -- Iniciar transaccion
        BEGIN TRANSACTION;

        -- Validacion del curso usando PR6
        EXEC proyecto1.PR6 'Course', NULL, NULL, @Name, @CreditsRequired, @IsValid OUTPUT;

        IF @IsValid = 0
        BEGIN
            -- MARCAR ERROR
            SET @Description = 'Nombre o Creditos Incorrectos';
            RAISERROR(@Description, 16, 1);
            RETURN;
        END

        -- Validacion de creditos negativos
        IF @CreditsRequired < 0
        BEGIN
            -- MARCAR ERROR
            SET @Description = 'Creditos no pueden ser negativos';
            RAISERROR(@Description, 16, 1);
            RETURN;
        END

        -- Validacion de codigo de curso negativo
        IF @CodCourse < 0
        BEGIN
            -- MARCAR ERROR
            SET @Description = 'Codigo de Curso no puede ser negativo';
            RAISERROR(@Description, 16, 1);
            RETURN;
        END

        -- Insercion del curso
        INSERT INTO proyecto1.Course(CodCourse, Name, CreditsRequired)
        VALUES (@CodCourse, @Name, @CreditsRequired);

        -- Mensaje de exito
        SET @Description = 'Insercion de Curso Exitosa';
        INSERT INTO proyecto1.HistoryLog ([Date], Description) VALUES (GETDATE(), @Description);
        PRINT @Description;

        -- Confirmar transaccion
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- CUALQUIER PROCESO ANTERIOR SE DESHACE
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
        -- MARCAR ERROR
        SET @Description = 'Insercion de Curso Fallida: ' + ERROR_MESSAGE();
        INSERT INTO proyecto1.HistoryLog ([Date], Description) VALUES (GETDATE(), @Description);
        RAISERROR(@Description, 16, 1);
    END CATCH;
END;
GO
------------------------------------------------------------------------------------------------------------------------
--* Procedure PR1 - Registro de Usuarios

/*
Descripción: Este procedimiento registra un nuevo usuario en el sistema.

Parámetros:
    @Firstname VARCHAR(max) - El nombre del usuario.
    @Lastname VARCHAR(max) - El apellido del usuario.
    @Email VARCHAR(max) - El correo electrónico del usuario.
    @DateOfBirth datetime2(7) - La fecha de nacimiento del usuario.
    @Password VARCHAR(max) - La contraseña del usuario.
    @Credits INT - Los créditos iniciales del usuario.

Funcionamiento:
1. Valida todos los campos de entrada.
2. Verifica que el correo no esté ya asociado a otra cuenta.
3. Crea un nuevo usuario con el rol de estudiante.
4. Crea un perfil de estudiante para el usuario.
5. Configura la autenticación de dos factores (TFA) para el usuario.
6. Envía una notificación al usuario sobre su registro exitoso.

Manejo de errores:
- Si ocurre algún error, la transacción se revierte y se registra en el HistoryLog.
*/
CREATE PROCEDURE proyecto1.PR1
    @Firstname VARCHAR(max),
    @Lastname VARCHAR(max),
    @Email VARCHAR(max),
    @DateOfBirth datetime2(7),
    @Password VARCHAR(max),
    @Credits INT
AS
BEGIN

    DECLARE @Description NVARCHAR(MAX);
    DECLARE @UserId UNIQUEIDENTIFIER;
    DECLARE @RolId UNIQUEIDENTIFIER;

    BEGIN TRY

    	-- Inicio de transaccion
        BEGIN TRANSACTION;

        -- Validaciones de cada campo
        -- Firtsname vacio
        IF (@Firstname IS NULL OR @Firstname = '')
        BEGIN
            SET @Description = 'El nombre no puede ir vacio';
            RAISERROR(@Description, 16, 1);
            RETURN;
        END

        -- Lastname vacio
        IF (@Lastname IS NULL OR @Lastname = '')
        BEGIN
            SET @Description = 'El apellido no puede ir vacio';
            RAISERROR(@Description, 16, 1);
            RETURN;
        END

        -- correo vacio
        IF (@Email IS NULL OR @Email = '')
        BEGIN
            SET @Description = 'El campo correo no puede ir vacio';
            RAISERROR(@Description, 16, 1);
            RETURN;
        END

        -- fecha vacia
        IF (@DateOfBirth IS NULL)
        BEGIN
            SET @Description = 'La fecha de nacimiento no puede ir vacia';
            RAISERROR(@Description, 16, 1);
            RETURN;
        END

        -- contaseoa vacia
        IF (@Password IS NULL OR @Password = '')
        BEGIN
            SET @Description = 'El password no puede estar vacio';
            RAISERROR(@Description, 16, 1);
            RETURN;
        END

        -- creditos con valor negativo
        IF (@Credits < 0)
        BEGIN
            SET @Description = 'No puede ingresar una cantidad de creditos negativa';
            RAISERROR(@Description, 16, 1);
            RETURN;
        END

    	-- Validacion de datos del usuario utilizando el procedimiento PR6
        DECLARE @IsValid BIT;
        EXEC proyecto1.PR6 'Usuarios', @Firstname, @Lastname, NULL, NULL, @IsValid OUTPUT;
        IF(@IsValid = 0)
        BEGIN
            SET @Description = 'Algunos campos son incorrectos, solo deben contener letras';
            RAISERROR(@Description, 16, 1);
            RETURN;
        END

        -- Validar si el que el email no esto asociado con ninguna otra cuenta dentro del sistema
        IF EXISTS (SELECT * FROM proyecto1.Usuarios WHERE Email = @Email)
        BEGIN
            SET @Description = 'Ya hay un usuario asociado con el correo indicado';
            RAISERROR(@Description, 16, 1);
            RETURN;
        END

        -- Creacion de rol estudiante
        SET @RolId = (SELECT Id FROM proyecto1.Roles WHERE RoleName = 'Student');
        IF @RolId IS NULL
        BEGIN
            SET @Description = 'El rol del estudiante no existe';
            RAISERROR(@Description, 16, 1);
        RETURN;
        END

        -- Insert tabla Usuarios
        SET @UserId = NEWID();
        INSERT INTO proyecto1.Usuarios(Id, Firstname, Lastname, Email, DateOfBirth, Password, LastChanges, EmailConfirmed)
        VALUES (@UserId, @Firstname, @Lastname, @Email, @DateOfBirth, @Password, GETDATE(), 1);

        -- Insert tabla UsuarioRole
        INSERT INTO proyecto1.UsuarioRole (RoleId, UserId, IsLatestVersion) VALUES (@RolId, @UserId, 1);

        -- Insert tabla ProfileStudent
        INSERT INTO proyecto1.ProfileStudent (UserId, Credits) VALUES (@UserId, @Credits);

        -- Insert tabla TFA
        INSERT INTO proyecto1.TFA (UserId, Status, LastUpdate) VALUES (@UserId, 1, GETDATE());

        -- Insert tabla Notification
        INSERT INTO proyecto1.Notification (UserId, Message, Date) VALUES (@UserId, 'Se ha registrado satisfactoriamente el usuario', GETDATE());

        -- Mensaje de exito
        SET @Description = 'Registro de Usuario Correcto';
        INSERT INTO proyecto1.HistoryLog ([Date], Description) VALUES (GETDATE(), @Description);
        PRINT @Description;

        -- Confirmar transaccion
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- CUALQUIER PROCESO ANTERIOR SE DESHACE
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
        END
        -- MARCAR ERROR
        SET @Description = 'Registro de Usuario Fallido: ' + ERROR_MESSAGE();
        INSERT INTO proyecto1.HistoryLog ([Date], Description) VALUES (GETDATE(), @Description);
        RAISERROR(@Description, 16, 1);
    END CATCH;
END;
