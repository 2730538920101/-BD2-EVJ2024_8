-- ******************************************************* --
-- **************** CREACION DE USUARIOS ***************** --
-- ******************************************************* --
-- Correcto
EXEC proyecto1.PR1
    @Firstname = 'Juan',
    @Lastname = 'Perez',
    @Email = 'juan.perez@example.com',
    @DateOfBirth = '1990-01-15',
    @Password = 'password123',
    @Credits = 20;
EXEC proyecto1.PR1
    @Firstname = 'Maria',
    @Lastname = 'Gonzalez',
    @Email = 'maria.gonzalez@example.com',
    @DateOfBirth = '1990-01-15',
    @Password = 'password123',
    @Credits = 20;
-- Nombre vacio
EXEC proyecto1.PR1
    @Firstname = '',
    @Lastname = 'Perez',
    @Email = 'juan.perez@example.com',
    @DateOfBirth = '1990-01-15',
    @Password = 'password123',
    @Credits = 20;
-- Apellido vacio
EXEC proyecto1.PR1
    @Firstname = 'Juan',
    @Lastname = '',
    @Email = 'juan.perez@example.com',
    @DateOfBirth = '1990-01-15',
    @Password = 'password123',
    @Credits = 20;
-- Correo vacio
EXEC proyecto1.PR1
    @Firstname = 'Juan',
    @Lastname = 'Perez',
    @Email = '',
    @DateOfBirth = '1990-01-15',
    @Password = 'password123',
    @Credits = 20;
-- Fecha de nacimiento vacia
EXEC proyecto1.PR1
    @Firstname = 'Juan',
    @Lastname = 'Perez',
    @Email = 'juan.perez@example.com',
    @DateOfBirth = NULL,
    @Password = 'password123',
    @Credits = 20;
-- Contraseña vacia
EXEC proyecto1.PR1
    @Firstname = 'Juan',
    @Lastname = 'Perez',
    @Email = 'juan.perez@example.com',
    @DateOfBirth = '1990-01-15',
    @Password = '',
    @Credits = 20;
-- Creditos negativos
EXEC proyecto1.PR1
    @Firstname = 'Juan',
    @Lastname = 'Perez',
    @Email = 'juan.perez@example.com',
    @DateOfBirth = '1990-01-15',
    @Password = 'password123',
    @Credits = -20;
-- Correo duplicado
EXEC proyecto1.PR1
    @Firstname = 'Juan',
    @Lastname = 'Perez',
    @Email = 'juan.perez@example.com',
    @DateOfBirth = '1990-01-15',
    @Password = 'password123',
    @Credits = 20;
-- Nombre incorrecto
EXEC proyecto1.PR1
    @Firstname = 'Ju@an',
    @Lastname = 'Perez',
    @Email = 'juan.perez@example.com',
    @DateOfBirth = '1990-01-15',
    @Password = 'password123',
    @Credits = 20;
-- Apellido incorrecto
EXEC proyecto1.PR1
    @Firstname = 'Juan',
    @Lastname = 'Per@ez',
    @Email = 'juan.perez@example.com',
    @DateOfBirth = '1990-01-15',
    @Password = 'password123',
    @Credits = 20;
-- ******************************************************* --
-- ******************** CAMBIO DE ROL ******************** --
-- ******************************************************* --
-- Correcto
EXEC proyecto1.PR2 @Email = 'juan.perez@example.com', @CodCourse = 772;
-- Correo vacio
EXEC proyecto1.PR2 @Email = '', @CodCourse = 772;
-- Codigo de curso negativo
EXEC proyecto1.PR2 @Email = 'juan.perez@example.com', @CodCourse = -772;
-- El curso no existe
EXEC proyecto1.PR2 @Email = 'juan.perez@example.com', @CodCourse = 999;
-- Usuario no existe
EXEC proyecto1.PR2 @Email = 'no.existe@example.com', @CodCourse = 772;
-- ******************************************************* --
-- ***************** ASIGNACION DE CURSOS **************** --
-- ******************************************************* --
-- Correcto
EXEC proyecto1.PR3 @CodCourse = 772, @Email = 'maria.gonzalez@example.com';
-- Curso no tiene tutor asignado
EXEC proyecto1.PR3 @CodCourse = 970, @Email = 'maria.gonzalez@example.com';
-- Correo vacio
EXEC proyecto1.PR3 @CodCourse = 970, @Email = '';
-- Codigo de curso negativo
EXEC proyecto1.PR3 @CodCourse = -970, @Email = 'maria.gonzalez@example.com';
-- Usuario no existe
EXEC proyecto1.PR3 @CodCourse = 970, @Email = 'no.existe@example.com';
-- No tiene creditos suficientes
EXEC proyecto1.PR3 @CodCourse = 283, @Email = 'maria.gonzalez@example.com';
-- ******************************************************* --
-- ****************** CREACION DE ROLES ****************** --
-- ******************************************************* --
-- Correcto
EXEC proyecto1.PR4 @RoleName = 'Guest';
-- Nombre de rol incorrecto
EXEC proyecto1.PR4 @RoleName = '';
-- ******************************************************* --
-- ***************** CREACION DE CURSOS ****************** --
-- ******************************************************* --
-- Correcto
EXEC proyecto1.PR5 @CodCourse = 100, @Name = 'Sistemas Operativos 2', @CreditsRequired = 40;
-- Duplicacion de codigo de curso
EXEC proyecto1.PR5 @CodCourse = 100, @Name = 'Sistemas Operativos 2', @CreditsRequired = 40;
-- Nombre de curso incorrecto
EXEC proyecto1.PR5 @CodCourse = 101, @Name = 'Sistemas @ Operativos 2', @CreditsRequired = 40;
-- Creditos requeridos negativos
EXEC proyecto1.PR5 @CodCourse = 101, @Name = 'Sistemas Operativos 2', @CreditsRequired = -40;