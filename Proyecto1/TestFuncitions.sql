SELECT * FROM proyecto1.Usuarios;
SELECT * FROM proyecto1.Course;
SELECT * FROM proyecto1.CourseAssignment;
SELECT * FROM proyecto1.CourseTutor;
SELECT * FROM proyecto1.Notification;
SELECT * FROM proyecto1.ProfileStudent;
SELECT * FROM proyecto1.Roles;
SELECT * FROM proyecto1.TFA;
SELECT * FROM proyecto1.TutorProfile;
SELECT * FROM proyecto1.UsuarioRole;
SELECT * FROM proyecto1.Usuarios;
SELECT * FROM proyecto1.HistoryLog;

--F1: Func_curso_usuarios
--Esta función devuelve la lista de alumnos asignados a un curso concreto.
SELECT * FROM proyecto1.F1(772);


--F2: Func_tutor_curso
--Esta función devuelve la lista de cursos que un tutor está asignado a impartir.

-- En primer lugar, necesitamos obtener el TutorProfile Id de Juan Pérez
DECLARE @TutorProfileId INT;
SELECT @TutorProfileId = Id FROM proyecto1.TutorProfile 
WHERE UserId = (SELECT Id FROM proyecto1.Usuarios WHERE Email = 'juan.perez@example.com');

-- Ahora podemos utilizar este Id en nuestra función
SELECT * FROM proyecto1.F2(@TutorProfileId);

--3. F3: Func_notificacion_usuarios
-- Esta función devuelve la lista de notificaciones enviadas a un usuario concreto.
DECLARE @UserId UNIQUEIDENTIFIER;
SELECT @UserId = Id FROM proyecto1.Usuarios WHERE Email = 'juan.perez@example.com';

SELECT * FROM proyecto1.F3(@UserId);
 
-- F4: Func_logger
-- Esta función devuelve toda la información almacenada en la tabla HistoryLog.
SELECT * FROM proyecto1.F4();


--F5: Func_usuarios
--Esta función devuelve la ficha del alumno con los campos especificados.
DECLARE @UserId UNIQUEIDENTIFIER;
SELECT @UserId = Id FROM proyecto1.Usuarios WHERE Email = 'maria.gonzalez@example.com';

SELECT * FROM proyecto1.F5(@UserId);