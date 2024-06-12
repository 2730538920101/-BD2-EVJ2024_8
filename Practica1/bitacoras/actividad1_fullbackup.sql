-- MySQL dump 10.13  Distrib 8.0.32, for Linux (x86_64)
--
-- Host: localhost    Database: PRACTICA1
-- ------------------------------------------------------
-- Server version	8.0.32

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `HABITACION`
--

DROP TABLE IF EXISTS `HABITACION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `HABITACION` (
  `idHabitacion` int NOT NULL,
  `habitacion` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`idHabitacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `HABITACION`
--

LOCK TABLES `HABITACION` WRITE;
/*!40000 ALTER TABLE `HABITACION` DISABLE KEYS */;
INSERT INTO `HABITACION` VALUES (1,'Sala de examenes 1\r'),(2,'Sala de examenes 2\r'),(3,'Sala de examenes 3\r'),(4,'Sala de examenes 4\r'),(5,'Sala de imagenes 1\r'),(6,'Sala de procedimientos 1\r'),(7,'Sala de procedimientos 2\r'),(8,'Sala de procedimientos 3\r'),(9,'Sala de procedimientos 4\r'),(10,'Recepcion\r'),(11,'Laboratorio\r'),(12,'Estación de revisión 1\r'),(13,'Estación de revisión 2\r'),(14,'Estación de revisión 3\r'),(15,'Estación de revisión 4\r');
/*!40000 ALTER TABLE `HABITACION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LOG_ACTIVIDAD`
--

DROP TABLE IF EXISTS `LOG_ACTIVIDAD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LOG_ACTIVIDAD` (
  `idLogActividad` int NOT NULL AUTO_INCREMENT,
  `timestampx` timestamp NULL DEFAULT NULL,
  `actividad` varchar(500) DEFAULT NULL,
  `idPaciente` int DEFAULT NULL,
  `idHabitacion` int DEFAULT NULL,
  PRIMARY KEY (`idLogActividad`),
  KEY `idPaciente` (`idPaciente`),
  KEY `idHabitacion` (`idHabitacion`),
  CONSTRAINT `LOG_ACTIVIDAD_ibfk_1` FOREIGN KEY (`idPaciente`) REFERENCES `PACIENTE` (`idPaciente`),
  CONSTRAINT `LOG_ACTIVIDAD_ibfk_2` FOREIGN KEY (`idHabitacion`) REFERENCES `HABITACION` (`idHabitacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LOG_ACTIVIDAD`
--

LOCK TABLES `LOG_ACTIVIDAD` WRITE;
/*!40000 ALTER TABLE `LOG_ACTIVIDAD` DISABLE KEYS */;
/*!40000 ALTER TABLE `LOG_ACTIVIDAD` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LOG_HABITACION`
--

DROP TABLE IF EXISTS `LOG_HABITACION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `LOG_HABITACION` (
  `idLogHabitacion` int NOT NULL AUTO_INCREMENT,
  `idHabitacion` int DEFAULT NULL,
  `timestampx` timestamp NULL DEFAULT NULL,
  `statusx` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idLogHabitacion`),
  KEY `idHabitacion` (`idHabitacion`),
  CONSTRAINT `LOG_HABITACION_ibfk_1` FOREIGN KEY (`idHabitacion`) REFERENCES `HABITACION` (`idHabitacion`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LOG_HABITACION`
--

LOCK TABLES `LOG_HABITACION` WRITE;
/*!40000 ALTER TABLE `LOG_HABITACION` DISABLE KEYS */;
/*!40000 ALTER TABLE `LOG_HABITACION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PACIENTE`
--

DROP TABLE IF EXISTS `PACIENTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `PACIENTE` (
  `idPaciente` int NOT NULL,
  `edad` int DEFAULT NULL,
  `genero` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`idPaciente`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PACIENTE`
--

LOCK TABLES `PACIENTE` WRITE;
/*!40000 ALTER TABLE `PACIENTE` DISABLE KEYS */;
/*!40000 ALTER TABLE `PACIENTE` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-12  4:13:36
