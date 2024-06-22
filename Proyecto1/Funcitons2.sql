USE IngenieriaBD;
GO

-- Asegúrate de que no haya ninguna otra instrucción antes del CREATE FUNCTION
CREATE FUNCTION proyecto1.F1 (@CodCourse INT)
RETURNS TABLE
AS
RETURN
(
    SELECT u.Firstname, u.Lastname, u.Email
    FROM proyecto1.Usuarios u
    INNER JOIN proyecto1.CourseAssignment ca ON u.Id = ca.StudentId
    WHERE ca.CourseCodCourse = @CodCourse
)
GO
------------------------------------------------------------------------------------------------------------


USE IngenieriaBD;
GO

CREATE FUNCTION proyecto1.F2 (@TutorProfileId INT)
RETURNS TABLE
AS
RETURN
(
    SELECT c.CodCourse, c.Name
    FROM proyecto1.Course c
    INNER JOIN proyecto1.CourseTutor ct ON c.CodCourse = ct.CourseCodCourse
    INNER JOIN proyecto1.TutorProfile tp ON ct.TutorId = tp.UserId
    WHERE tp.Id = @TutorProfileId
)
GO

------------------------------------------------------------------------------------------------------------
USE IngenieriaBD;
GO

CREATE FUNCTION proyecto1.F3 (@UserId UNIQUEIDENTIFIER)
RETURNS TABLE
AS
RETURN
(
    SELECT Message, Date
    FROM proyecto1.Notification
    WHERE UserId = @UserId
)
GO

------------------------------------------------------------------------------------------------------------
USE IngenieriaBD;
GO

CREATE FUNCTION proyecto1.F4 ()
RETURNS TABLE
AS
RETURN
(
    SELECT *
    FROM proyecto1.HistoryLog
)
GO


------------------------------------------------------------------------------------------------------------
USE IngenieriaBD;
GO

CREATE FUNCTION proyecto1.F5 (@UserId UNIQUEIDENTIFIER)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        u.Firstname,
        u.Lastname,
        u.Email,
        u.DateOfBirth,
        ps.Credits,
        r.RoleName
    FROM proyecto1.Usuarios u
    LEFT JOIN proyecto1.ProfileStudent ps ON u.Id = ps.UserId
    LEFT JOIN proyecto1.UsuarioRole ur ON u.Id = ur.UserId
    LEFT JOIN proyecto1.Roles r ON ur.RoleId = r.Id
    WHERE u.Id = @UserId
)
GO

------------------------------------------------------------------------------------------------------------

------------------------------------------------------------------------------------------------------------