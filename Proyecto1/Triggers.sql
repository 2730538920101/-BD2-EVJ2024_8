------------------------------------------------------------------------------------------------------------------------
--* Trigger para la tabla Usuarios
USE IngenieriaBD;
GO

CREATE TRIGGER Trigger1_Usuarios
ON proyecto1.Usuarios AFTER INSERT, UPDATE, DELETE
AS
BEGIN

    -- Se declaran las variables
    DECLARE @Operacion VARCHAR(20);
    DECLARE @Descripcion VARCHAR(100);
    DECLARE @NombreTabla VARCHAR(128);

    -- Asigna el nombre de la tabla
    SET @NombreTabla = 'Usuarios';

    -- Determinando el tipo de operacion
    IF EXISTS (SELECT * FROM INSERTED)
        SET @Operacion = 'INSERT';
    ELSE IF EXISTS (SELECT * FROM DELETED)
        SET @Operacion = 'DELETE';
    ELSE
        SET @Operacion = 'UPDATE';

    -- Insertando en la tabla HistoryLog
    SET @Descripcion = 'Operacion ' + @Operacion + ' en la tabla ' + @NombreTabla + ' Exitosa';
    INSERT INTO proyecto1.HistoryLog([Date], Description) VALUES (GETDATE(), @Descripcion);
END;
GO
------------------------------------------------------------------------------------------------------------------------
--* Trigger para la tabla Roles
USE IngenieriaBD;
GO

CREATE TRIGGER Trigger1_Roles
ON proyecto1.Roles AFTER INSERT, UPDATE, DELETE
AS
BEGIN

    -- Se declaran las variables
    DECLARE @Operacion VARCHAR(20);
    DECLARE @Descripcion VARCHAR(100);
    DECLARE @NombreTabla VARCHAR(128);

    -- Asigna el nombre de la tabla
    SET @NombreTabla = 'Roles';

    -- Determinando el tipo de operacion
    IF EXISTS (SELECT * FROM INSERTED)
        SET @Operacion = 'INSERT';
    ELSE IF EXISTS (SELECT * FROM DELETED)
        SET @Operacion = 'DELETE';
    ELSE
        SET @Operacion = 'UPDATE';

    -- Insertando en la tabla HistoryLog
    SET @Descripcion = 'Operacion ' + @Operacion + ' en la tabla ' + @NombreTabla + ' Exitosa';
    INSERT INTO proyecto1.HistoryLog([Date], Description) VALUES (GETDATE(), @Descripcion);
END;
GO
------------------------------------------------------------------------------------------------------------------------
--* Trigger para la tabla UsuarioRole
USE IngenieriaBD;
GO

CREATE TRIGGER Trigger1_UsuarioRole
ON proyecto1.UsuarioRole AFTER INSERT, UPDATE, DELETE
AS
BEGIN

    -- Se declaran las variables
    DECLARE @Operacion VARCHAR(20);
    DECLARE @Descripcion VARCHAR(100);
    DECLARE @NombreTabla VARCHAR(128);

    -- Asigna el nombre de la tabla
    SET @NombreTabla = 'UsuarioRole';

    -- Determinando el tipo de operacion
    IF EXISTS (SELECT * FROM INSERTED)
        SET @Operacion = 'INSERT';
    ELSE IF EXISTS (SELECT * FROM DELETED)
        SET @Operacion = 'DELETE';
    ELSE
        SET @Operacion = 'UPDATE';

    -- Insertando en la tabla HistoryLog
    SET @Descripcion = 'Operacion ' + @Operacion + ' en la tabla ' + @NombreTabla + ' Exitosa';
    INSERT INTO proyecto1.HistoryLog([Date], Description) VALUES (GETDATE(), @Descripcion);
END;
GO
------------------------------------------------------------------------------------------------------------------------
--* Trigger para la tabla Course
USE IngenieriaBD;
GO

CREATE TRIGGER Trigger1_Course
ON proyecto1.Course AFTER INSERT, UPDATE, DELETE
AS
BEGIN

    -- Se declaran las variables
    DECLARE @Operacion VARCHAR(20);
    DECLARE @Descripcion VARCHAR(100);
    DECLARE @NombreTabla VARCHAR(128);

    -- Asigna el nombre de la tabla
    SET @NombreTabla = 'Course';

    -- Determinando el tipo de operacion
    IF EXISTS (SELECT * FROM INSERTED)
        SET @Operacion = 'INSERT';
    ELSE IF EXISTS (SELECT * FROM DELETED)
        SET @Operacion = 'DELETE';
    ELSE
        SET @Operacion = 'UPDATE';

    -- Insertando en la tabla HistoryLog
    SET @Descripcion = 'Operacion ' + @Operacion + ' en la tabla ' + @NombreTabla + ' Exitosa';
    INSERT INTO proyecto1.HistoryLog([Date], Description) VALUES (GETDATE(), @Descripcion);
END;
GO
------------------------------------------------------------------------------------------------------------------------
--* Trigger para la tabla ProfileStudent
USE IngenieriaBD;
GO

CREATE TRIGGER Trigger1_ProfileStudent
ON proyecto1.ProfileStudent AFTER INSERT, UPDATE, DELETE
AS
BEGIN

    -- Se declaran las variables
    DECLARE @Operacion VARCHAR(20);
    DECLARE @Descripcion VARCHAR(100);
    DECLARE @NombreTabla VARCHAR(128);

    -- Asigna el nombre de la tabla
    SET @NombreTabla = 'ProfileStudent';

    -- Determinando el tipo de operacion
    IF EXISTS (SELECT * FROM INSERTED)
        SET @Operacion = 'INSERT';
    ELSE IF EXISTS (SELECT * FROM DELETED)
        SET @Operacion = 'DELETE';
    ELSE
        SET @Operacion = 'UPDATE';

    -- Insertando en la tabla HistoryLog
    SET @Descripcion = 'Operacion ' + @Operacion + ' en la tabla ' + @NombreTabla + ' Exitosa';
    INSERT INTO proyecto1.HistoryLog([Date], Description) VALUES (GETDATE(), @Descripcion);
END;
GO
------------------------------------------------------------------------------------------------------------------------
--* Trigger para la tabla TutorProfile
USE IngenieriaBD;
GO

CREATE TRIGGER Trigger1_TutorProfile
ON proyecto1.TutorProfile AFTER INSERT, UPDATE, DELETE
AS
BEGIN

    -- Se declaran las variables
    DECLARE @Operacion VARCHAR(20);
    DECLARE @Descripcion VARCHAR(100);
    DECLARE @NombreTabla VARCHAR(128);

    -- Asigna el nombre de la tabla
    SET @NombreTabla = 'TutorProfile';

    -- Determinando el tipo de operacion
    IF EXISTS (SELECT * FROM INSERTED)
        SET @Operacion = 'INSERT';
    ELSE IF EXISTS (SELECT * FROM DELETED)
        SET @Operacion = 'DELETE';
    ELSE
        SET @Operacion = 'UPDATE';

    -- Insertando en la tabla HistoryLog
    SET @Descripcion = 'Operacion ' + @Operacion + ' en la tabla ' + @NombreTabla + ' Exitosa';
    INSERT INTO proyecto1.HistoryLog([Date], Description) VALUES (GETDATE(), @Descripcion);
END;
GO
------------------------------------------------------------------------------------------------------------------------
--* Trigger para la tabla CourseTutor
USE IngenieriaBD;
GO

CREATE TRIGGER Trigger1_CourseTutor
ON proyecto1.CourseTutor AFTER INSERT, UPDATE, DELETE
AS
BEGIN

    -- Se declaran las variables
    DECLARE @Operacion VARCHAR(20);
    DECLARE @Descripcion VARCHAR(100);
    DECLARE @NombreTabla VARCHAR(128);

    -- Asigna el nombre de la tabla
    SET @NombreTabla = 'CourseTutor';

    -- Determinando el tipo de operacion
    IF EXISTS (SELECT * FROM INSERTED)
        SET @Operacion = 'INSERT';
    ELSE IF EXISTS (SELECT * FROM DELETED)
        SET @Operacion = 'DELETE';
    ELSE
        SET @Operacion = 'UPDATE';

    -- Insertando en la tabla HistoryLog
    SET @Descripcion = 'Operacion ' + @Operacion + ' en la tabla ' + @NombreTabla + ' Exitosa';
    INSERT INTO proyecto1.HistoryLog([Date], Description) VALUES (GETDATE(), @Descripcion);
END;
GO
------------------------------------------------------------------------------------------------------------------------
--* Trigger para la tabla CourseAssignment
USE IngenieriaBD;
GO

CREATE TRIGGER Trigger1_CourseAssignment
ON proyecto1.CourseAssignment AFTER INSERT, UPDATE, DELETE
AS
BEGIN

    -- Se declaran las variables
    DECLARE @Operacion VARCHAR(20);
    DECLARE @Descripcion VARCHAR(100);
    DECLARE @NombreTabla VARCHAR(128);

    -- Asigna el nombre de la tabla
    SET @NombreTabla = 'CourseAssignment';

    -- Determinando el tipo de operacion
    IF EXISTS (SELECT * FROM INSERTED)
        SET @Operacion = 'INSERT';
    ELSE IF EXISTS (SELECT * FROM DELETED)
        SET @Operacion = 'DELETE';
    ELSE
        SET @Operacion = 'UPDATE';

    -- Insertando en la tabla HistoryLog
    SET @Descripcion = 'Operacion ' + @Operacion + ' en la tabla ' + @NombreTabla + ' Exitosa';
    INSERT INTO proyecto1.HistoryLog([Date], Description) VALUES (GETDATE(), @Descripcion);
END;
GO
------------------------------------------------------------------------------------------------------------------------
--* Trigger para la tabla TFA
USE IngenieriaBD;
GO

CREATE TRIGGER Trigger1_TFA
ON proyecto1.TFA AFTER INSERT, UPDATE, DELETE
AS
BEGIN

    -- Se declaran las variables
    DECLARE @Operacion VARCHAR(20);
    DECLARE @Descripcion VARCHAR(100);
    DECLARE @NombreTabla VARCHAR(128);

    -- Asigna el nombre de la tabla
    SET @NombreTabla = 'TFA';

    -- Determinando el tipo de operacion
    IF EXISTS (SELECT * FROM INSERTED)
        SET @Operacion = 'INSERT';
    ELSE IF EXISTS (SELECT * FROM DELETED)
        SET @Operacion = 'DELETE';
    ELSE
        SET @Operacion = 'UPDATE';

    -- Insertando en la tabla HistoryLog
    SET @Descripcion = 'Operacion ' + @Operacion + ' en la tabla ' + @NombreTabla + ' Exitosa';
    INSERT INTO proyecto1.HistoryLog([Date], Description) VALUES (GETDATE(), @Descripcion);
END;
GO
------------------------------------------------------------------------------------------------------------------------
--* Trigger para la tabla Notification
USE IngenieriaBD;
GO

CREATE TRIGGER Trigger1_Notification
ON proyecto1.Notification AFTER INSERT, UPDATE, DELETE
AS
BEGIN

    -- Se declaran las variables
    DECLARE @Operacion VARCHAR(20);
    DECLARE @Descripcion VARCHAR(100);
    DECLARE @NombreTabla VARCHAR(128);

    -- Asigna el nombre de la tabla
    SET @NombreTabla = 'Notification';

    -- Determinando el tipo de operacion
    IF EXISTS (SELECT * FROM INSERTED)
        SET @Operacion = 'INSERT';
    ELSE IF EXISTS (SELECT * FROM DELETED)
        SET @Operacion = 'DELETE';
    ELSE
        SET @Operacion = 'UPDATE';

    -- Insertando en la tabla HistoryLog
    SET @Descripcion = 'Operacion ' + @Operacion + ' en la tabla ' + @NombreTabla + ' Exitosa';
    INSERT INTO proyecto1.HistoryLog([Date], Description) VALUES (GETDATE(), @Descripcion);
END;
GO