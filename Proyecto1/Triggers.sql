USE IngenieriaBD;
GO
--* Trigger para la tabla Usuarios
CREATE TRIGGER Trigger1_Usuarios
ON Usuarios AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
    BEGIN
        --* Se realizó una operación de actualización
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (UPDATE) EN LA TABLA Usuarios', 'UPDATE')
    END
    ELSE IF EXISTS (SELECT * FROM INSERTED)
    BEGIN
        --* Se realizó una operación de inserción
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (INSERT) EN LA TABLA Usuarios', 'INSERT')
    END
    ELSE IF EXISTS (SELECT * FROM DELETED)
    BEGIN
        --* Se realizó una operación de eliminación
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (DELETE) EN LA TABLA Usuarios', 'DELETE')
    END
END;
GO
------------------------------------------------------------------------------------------------------------------------
--* Trigger para la tabla Roles
USE IngenieriaBD;
GO

CREATE TRIGGER Trigger1_Roles
ON Roles AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
    BEGIN
        --* Se realizó una operación de actualización
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (UPDATE) EN LA TABLA Roles', 'UPDATE')
    END
    ELSE IF EXISTS (SELECT * FROM INSERTED)
    BEGIN
        --* Se realizó una operación de inserción
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (INSERT) EN LA TABLA Roles', 'INSERT')
    END
    ELSE IF EXISTS (SELECT * FROM DELETED)
    BEGIN
        --* Se realizó una operación de eliminación
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (DELETE) EN LA TABLA Roles', 'DELETE')
    END
END;
GO
------------------------------------------------------------------------------------------------------------------------
--* Trigger para la tabla UsuarioRole
USE IngenieriaBD;
GO

CREATE TRIGGER Trigger1_UsuarioRole
ON UsuarioRole AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
    BEGIN
        --* Se realizó una operación de actualización
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (UPDATE) EN LA TABLA UsuarioRole', 'UPDATE')
    END
    ELSE IF EXISTS (SELECT * FROM INSERTED)
    BEGIN
        --* Se realizó una operación de inserción
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (INSERT) EN LA TABLA UsuarioRole', 'INSERT')
    END
    ELSE IF EXISTS (SELECT * FROM DELETED)
    BEGIN
        --* Se realizó una operación de eliminación
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (DELETE) EN LA TABLA UsuarioRole', 'DELETE')
    END
END;
GO
------------------------------------------------------------------------------------------------------------------------

--* Trigger para la tabla Course
USE IngenieriaBD;
GO

CREATE TRIGGER Trigger1_Course
ON Course AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
    BEGIN
        --* Se realizó una operación de actualización
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (UPDATE) EN LA TABLA Course', 'UPDATE')
    END
    ELSE IF EXISTS (SELECT * FROM INSERTED)
    BEGIN
        --* Se realizó una operación de inserción
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (INSERT) EN LA TABLA Course', 'INSERT')
    END
    ELSE IF EXISTS (SELECT * FROM DELETED)
    BEGIN
        --* Se realizó una operación de eliminación
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (DELETE) EN LA TABLA Course', 'DELETE')
    END
END;
GO

------------------------------------------------------------------------------------------------------------------------
--* Trigger para la tabla ProfileStudent
USE IngenieriaBD;
GO

CREATE TRIGGER Trigger1_ProfileStudent
ON ProfileStudent AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
    BEGIN
        --* Se realizó una operación de actualización
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (UPDATE) EN LA TABLA ProfileStudent', 'UPDATE')
    END
    ELSE IF EXISTS (SELECT * FROM INSERTED)
    BEGIN
        --* Se realizó una operación de inserción
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (INSERT) EN LA TABLA ProfileStudent', 'INSERT')
    END
    ELSE IF EXISTS (SELECT * FROM DELETED)
    BEGIN
        --* Se realizó una operación de eliminación
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (DELETE) EN LA TABLA ProfileStudent', 'DELETE')
    END
END;
GO

------------------------------------------------------------------------------------------------------------------------
--* Trigger para la tabla TutorProfile
USE IngenieriaBD;
GO

CREATE TRIGGER Trigger1_TutorProfile
ON TutorProfile AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
    BEGIN
        --* Se realizó una operación de actualización
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (UPDATE) EN LA TABLA TutorProfile', 'UPDATE')
    END
    ELSE IF EXISTS (SELECT * FROM INSERTED)
    BEGIN
        --* Se realizó una operación de inserción
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (INSERT) EN LA TABLA TutorProfile', 'INSERT')
    END
    ELSE IF EXISTS (SELECT * FROM DELETED)
    BEGIN
        --* Se realizó una operación de eliminación
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (DELETE) EN LA TABLA TutorProfile', 'DELETE')
    END
END;
GO

------------------------------------------------------------------------------------------------------------------------
--* Trigger para la tabla CourseTutor
USE IngenieriaBD;
GO

CREATE TRIGGER Trigger1_CourseTutor
ON CourseTutor AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
    BEGIN
        --* Se realizó una operación de actualización
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (UPDATE) EN LA TABLA CourseTutor', 'UPDATE')
    END
    ELSE IF EXISTS (SELECT * FROM INSERTED)
    BEGIN
        --* Se realizó una operación de inserción
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (INSERT) EN LA TABLA CourseTutor', 'INSERT')
    END
    ELSE IF EXISTS (SELECT * FROM DELETED)
    BEGIN
        --* Se realizó una operación de eliminación
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (DELETE) EN LA TABLA CourseTutor', 'DELETE')
    END
END;
GO

------------------------------------------------------------------------------------------------------------------------
--* Trigger para la tabla CourseAssignment
USE IngenieriaBD;
GO

CREATE TRIGGER Trigger1_CourseAssignment
ON CourseAssignment AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
    BEGIN
        --* Se realizó una operación de actualización
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (UPDATE) EN LA TABLA CourseAssignment', 'UPDATE')
    END
    ELSE IF EXISTS (SELECT * FROM INSERTED)
    BEGIN
        --* Se realizó una operación de inserción
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (INSERT) EN LA TABLA CourseAssignment', 'INSERT')
    END
    ELSE IF EXISTS (SELECT * FROM DELETED)
    BEGIN
        --* Se realizó una operación de eliminación
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (DELETE) EN LA TABLA CourseAssignment', 'DELETE')
    END
END;
GO

------------------------------------------------------------------------------------------------------------------------
--* Trigger para la tabla TFA
USE IngenieriaBD;
GO

CREATE TRIGGER Trigger1_TFA
ON TFA AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
    BEGIN
        --* Se realizó una operación de actualización
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (UPDATE) EN LA TABLA TFA', 'UPDATE')
    END
    ELSE IF EXISTS (SELECT * FROM INSERTED)
    BEGIN
        --* Se realizó una operación de inserción
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (INSERT) EN LA TABLA TFA', 'INSERT')
    END
    ELSE IF EXISTS (SELECT * FROM DELETED)
    BEGIN
        --* Se realizó una operación de eliminación
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (DELETE) EN LA TABLA TFA', 'DELETE')
    END
END;
GO


------------------------------------------------------------------------------------------------------------------------
--* Trigger para la tabla Notification
USE IngenieriaBD;
GO

CREATE TRIGGER Trigger1_Notification
ON Notification AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    IF EXISTS (SELECT * FROM INSERTED) AND EXISTS (SELECT * FROM DELETED)
    BEGIN
        --* Se realizó una operación de actualización
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (UPDATE) EN LA TABLA Notification', 'UPDATE')
    END
    ELSE IF EXISTS (SELECT * FROM INSERTED)
    BEGIN
        --* Se realizó una operación de inserción
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (INSERT) EN LA TABLA Notification', 'INSERT')
    END
    ELSE IF EXISTS (SELECT * FROM DELETED)
    BEGIN
        --* Se realizó una operación de eliminación
        INSERT INTO HistoryLog(description_, type_) VALUES('SE REALIZO UNA ACCION (DELETE) EN LA TABLA Notification', 'DELETE')
    END
END;
GO