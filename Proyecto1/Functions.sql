----------------------------------------------------------------------------------------------------------------
-- * Func_course_usuarios
-- * Retornará el listado completo de alumnos que están asignados a un determinado curso.
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
CREATE FUNCTION Func_logger()
RETURNS TABLE
AS
RETURN
    SELECT description_, type_, Timestamp_
    FROM HistoryLog;

----------------------------------------------------------------------------------------------------------------
--* Func_usuarios
--* Retornará el expediente de cada alumno, que incluye los siguientes campos: FirstName, LastName, Email, DateOfBirth, Credits, RoleName.
CREATE FUNCTION Func_usuarios(@IdUsuario INT)
RETURNS TABLE
AS
RETURN
    SELECT u.FirstName, u.LastName, u.Email, u.DateOfBirth, u.Credits, r.RoleName
    FROM Usuarios u
    INNER JOIN UsuarioRole ur ON u.IdUsuario = ur.IdUsuario
    INNER JOIN Roles r ON ur.IdRol = r.IdRol
    WHERE u.IdUsuario = @IdUsuario;