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
-- ***************** ASIGNACION DE CURSOS **************** --
-- ******************************************************* --
-- Correcto
-- Curso no tiene tutor asignado
EXEC proyecto1.PR3 @CodCourse = 772, @Email = 'juan.perez@example.com';
-- Correo vacio
EXEC proyecto1.PR3 @CodCourse = 772, @Email = '';
-- Codigo de curso negativo
EXEC proyecto1.PR3 @CodCourse = -772, @Email = 'juan.perez@example.com';
-- Usuario no existe
EXEC proyecto1.PR3 @CodCourse = 772, @Email = 'no.existe@example.com';
-- No tiene creditos suficientes
EXEC proyecto1.PR3 @CodCourse = 283, @Email = 'juan.perez@example.com';
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