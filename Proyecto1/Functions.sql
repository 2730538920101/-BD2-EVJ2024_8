----------------------------------------------------------------------------------------------------------------
-- * Func_course_usuarios
-- * Retornará el listado completo de alumnos que están asignados a un determinado curso.

/*
Descripción: Esta función devuelve una tabla con la información de los alumnos asignados a un curso específico.

Parámetros:
    @CodCourse INT - El código del curso del que se quiere obtener la lista de alumnos.

Retorna:
    Una tabla con las columnas FirstName, LastName y Email de los alumnos asignados al curso.

Uso:
    SELECT * FROM Func_course_usuarios(1234)  -- Donde 1234 es el código del curso
*/
CREATE FUNCTION Func_course_usuarios(@CodCourse INT)
RETURNS TABLE
AS
RETURN
    SELECT u.FirstName, u.LastName, u.Email
    FROM Usuarios u
    INNER JOIN CourseAssignment ca ON u.IdUsuario = ca.IdUsuario
    WHERE ca.CodCourse = @CodCourse;

----------------------------------------------------------------------------------------------------------------
-- * Func_tutor_course
-- * Retornará la lista de cursos a los cuales los tutores estén designados para dar clase.

/*
Descripción: Esta función devuelve una tabla con los nombres de los cursos asignados a un tutor específico.

Parámetros:
    @IdTutorProfile INT - El ID del perfil del tutor del que se quiere obtener la lista de cursos.

Retorna:
    Una tabla con la columna Name que contiene los nombres de los cursos asignados al tutor.

Uso:
    SELECT * FROM Func_tutor_course(5678)  -- Donde 5678 es el ID del perfil del tutor
*/
CREATE FUNCTION Func_tutor_course(@IdTutorProfile INT)
RETURNS TABLE
AS
RETURN
    SELECT c.Name
    FROM Course c
    INNER JOIN CourseTutor ct ON c.CodCourse = ct.CodCourse
    WHERE ct.IdTutorProfile = @IdTutorProfile;

----------------------------------------------------------------------------------------------------------------
--* Func_notification_usuarios
--* Retornará la lista de notificaciones que hayan sido enviadas a un usuario.

/*
Descripción: Esta función devuelve una tabla con los mensajes de las notificaciones enviadas a un usuario específico.

Parámetros:
    @IdUsuario INT - El ID del usuario del que se quiere obtener las notificaciones.

Retorna:
    Una tabla con la columna Message que contiene los mensajes de las notificaciones enviadas al usuario.

Uso:
    SELECT * FROM Func_notification_usuarios(9012)  -- Donde 9012 es el ID del usuario
*/
CREATE FUNCTION Func_notification_usuarios(@IdUsuario INT)
RETURNS TABLE
AS
RETURN
    SELECT Message
    FROM Notification
    WHERE IdUsuario = @IdUsuario;

----------------------------------------------------------------------------------------------------------------
--* Func_logger
--* Retornará la información almacenada en la tabla HistoryLog.

/*
Descripción: Esta función devuelve toda la información almacenada en la tabla HistoryLog.

Parámetros:
    Ninguno

Retorna:
    Una tabla con las columnas description_, type_ y Timestamp_ de la tabla HistoryLog.

Uso:
    SELECT * FROM Func_logger()
*/
CREATE FUNCTION Func_logger()
RETURNS TABLE
AS
RETURN
    SELECT description_, type_, Timestamp_
    FROM HistoryLog;

----------------------------------------------------------------------------------------------------------------
--* Func_usuarios
--* Retornará el expediente de cada alumno, que incluye los siguientes campos: FirstName, LastName, Email, DateOfBirth, Credits, RoleName.

/*
Descripción: Esta función devuelve el expediente completo de un alumno específico.

Parámetros:
    @IdUsuario INT - El ID del usuario del que se quiere obtener el expediente.

Retorna:
    Una tabla con las columnas FirstName, LastName, Email, DateOfBirth, Credits y RoleName del alumno.

Uso:
    SELECT * FROM Func_usuarios(3456)  -- Donde 3456 es el ID del usuario
*/
CREATE FUNCTION Func_usuarios(@IdUsuario INT)
RETURNS TABLE
AS
RETURN
    SELECT u.FirstName, u.LastName, u.Email, u.DateOfBirth, u.Credits, r.RoleName
    FROM Usuarios u
    INNER JOIN UsuarioRole ur ON u.IdUsuario = ur.IdUsuario
    INNER JOIN Roles r ON ur.IdRol = r.IdRol
    WHERE u.IdUsuario = @IdUsuario;