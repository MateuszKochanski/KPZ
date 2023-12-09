CREATE DATABASE  IF NOT EXISTS `hol9000db` /*!40100 DEFAULT CHARACTER SET utf8mb3 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `hol9000db`;
-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: hol9000db
-- ------------------------------------------------------
-- Server version	8.2.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Konsultacja`
--

DROP TABLE IF EXISTS `Konsultacja`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Konsultacja` (
  `Pracownik_idPracownik` int NOT NULL,
  `Pomieszczenia_idPomieszczenia` int NOT NULL,
  `dzienTygodnia` int NOT NULL,
  `godzinaRozpoczecia` timestamp NOT NULL,
  `godzinaZakonczenia` timestamp NOT NULL,
  KEY `fk_Konsultacja_Pracownik1_idx` (`Pracownik_idPracownik`),
  KEY `fk_Konsultacja_Pomieszczenia1_idx` (`Pomieszczenia_idPomieszczenia`),
  CONSTRAINT `pomieszczenie` FOREIGN KEY (`Pomieszczenia_idPomieszczenia`) REFERENCES `Pomieszczenia` (`idPomieszczenia`),
  CONSTRAINT `pracownik` FOREIGN KEY (`Pracownik_idPracownik`) REFERENCES `Pracownik` (`idPracownik`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Konsultacja`
--

LOCK TABLES `Konsultacja` WRITE;
/*!40000 ALTER TABLE `Konsultacja` DISABLE KEYS */;
INSERT INTO `Konsultacja` VALUES (1,1,1,'2001-01-01 14:15:00','2001-01-01 16:00:00'),(2,0,0,'2001-01-01 14:15:00','2001-01-01 16:00:00');
/*!40000 ALTER TABLE `Konsultacja` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pomieszczenia`
--

DROP TABLE IF EXISTS `Pomieszczenia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pomieszczenia` (
  `idPomieszczenia` int NOT NULL,
  `numerPomieszczenia` varchar(45) NOT NULL,
  `pietro` int NOT NULL,
  `pojemnosc` int NOT NULL,
  PRIMARY KEY (`idPomieszczenia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pomieszczenia`
--

LOCK TABLES `Pomieszczenia` WRITE;
/*!40000 ALTER TABLE `Pomieszczenia` DISABLE KEYS */;
INSERT INTO `Pomieszczenia` VALUES (0,'224',2,2),(1,'314',3,1),(2,'306',3,20),(3,'11',0,150),(4,'124',1,50);
/*!40000 ALTER TABLE `Pomieszczenia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pracownik`
--

DROP TABLE IF EXISTS `Pracownik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pracownik` (
  `idPracownik` int NOT NULL,
  `Imie` varchar(45) NOT NULL,
  `Nazwisko` varchar(45) NOT NULL,
  `AccessCardID` int NOT NULL,
  PRIMARY KEY (`idPracownik`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pracownik`
--

LOCK TABLES `Pracownik` WRITE;
/*!40000 ALTER TABLE `Pracownik` DISABLE KEYS */;
INSERT INTO `Pracownik` VALUES (0,'Krzysztof','Majewski',12332),(1,'Piotr','Połać',24412),(2,'Robert','Janowski',52441);
/*!40000 ALTER TABLE `Pracownik` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pracownik_has_Zajęcia`
--

DROP TABLE IF EXISTS `Pracownik_has_Zajęcia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pracownik_has_Zajęcia` (
  `Pracownik_idPracownik` int NOT NULL,
  `Zajęcia_idZajęcia` int NOT NULL,
  KEY `fk_Pracownik_has_Zajęcia_Zajęcia1_idx` (`Zajęcia_idZajęcia`),
  KEY `fk_Pracownik_has_Zajęcia_Pracownik1_idx` (`Pracownik_idPracownik`),
  CONSTRAINT `fk_Pracownik_has_Zajęcia_Pracownik1` FOREIGN KEY (`Pracownik_idPracownik`) REFERENCES `Pracownik` (`idPracownik`),
  CONSTRAINT `fk_Pracownik_has_Zajęcia_Zajęcia1` FOREIGN KEY (`Zajęcia_idZajęcia`) REFERENCES `Zajęcia` (`idZajęcia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pracownik_has_Zajęcia`
--

LOCK TABLES `Pracownik_has_Zajęcia` WRITE;
/*!40000 ALTER TABLE `Pracownik_has_Zajęcia` DISABLE KEYS */;
INSERT INTO `Pracownik_has_Zajęcia` VALUES (0,0),(0,4),(0,5),(1,2),(1,3),(2,1),(2,6),(2,7);
/*!40000 ALTER TABLE `Pracownik_has_Zajęcia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pracownik_ma_dostep_do_Pomieszczenia`
--

DROP TABLE IF EXISTS `Pracownik_ma_dostep_do_Pomieszczenia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pracownik_ma_dostep_do_Pomieszczenia` (
  `Pracownik_idPracownik` int NOT NULL,
  `Pomieszczenia_idPomieszczenia` int NOT NULL,
  KEY `fk_Pracownik_has_Pomieszczenia_Pomieszczenia1_idx` (`Pomieszczenia_idPomieszczenia`),
  KEY `fk_Pracownik_has_Pomieszczenia_Pracownik1_idx` (`Pracownik_idPracownik`),
  CONSTRAINT `fk_Pracownik_has_Pomieszczenia_Pomieszczenia1` FOREIGN KEY (`Pomieszczenia_idPomieszczenia`) REFERENCES `Pomieszczenia` (`idPomieszczenia`),
  CONSTRAINT `fk_Pracownik_has_Pomieszczenia_Pracownik1` FOREIGN KEY (`Pracownik_idPracownik`) REFERENCES `Pracownik` (`idPracownik`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pracownik_ma_dostep_do_Pomieszczenia`
--

LOCK TABLES `Pracownik_ma_dostep_do_Pomieszczenia` WRITE;
/*!40000 ALTER TABLE `Pracownik_ma_dostep_do_Pomieszczenia` DISABLE KEYS */;
INSERT INTO `Pracownik_ma_dostep_do_Pomieszczenia` VALUES (0,1),(0,2),(0,3),(0,4),(1,1),(1,2),(1,3),(1,4),(2,0),(2,2),(2,3),(2,4);
/*!40000 ALTER TABLE `Pracownik_ma_dostep_do_Pomieszczenia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Pracownik_odwiedzil_Pomieszczenia`
--

DROP TABLE IF EXISTS `Pracownik_odwiedzil_Pomieszczenia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Pracownik_odwiedzil_Pomieszczenia` (
  `Pracownik_idPracownik` int NOT NULL,
  `Pomieszczenia_idPomieszczenia` int NOT NULL,
  `kiedyUzylTuKarty` timestamp NOT NULL COMMENT 'format danych czasowych wszedzie do rozkminienia\\n',
  KEY `fk_Pracownik_has_Pomieszczenia_Pomieszczenia2_idx` (`Pomieszczenia_idPomieszczenia`),
  KEY `fk_Pracownik_has_Pomieszczenia_Pracownik2_idx` (`Pracownik_idPracownik`),
  CONSTRAINT `fk_Pracownik_has_Pomieszczenia_Pomieszczenia2` FOREIGN KEY (`Pomieszczenia_idPomieszczenia`) REFERENCES `Pomieszczenia` (`idPomieszczenia`),
  CONSTRAINT `fk_Pracownik_has_Pomieszczenia_Pracownik2` FOREIGN KEY (`Pracownik_idPracownik`) REFERENCES `Pracownik` (`idPracownik`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Pracownik_odwiedzil_Pomieszczenia`
--

LOCK TABLES `Pracownik_odwiedzil_Pomieszczenia` WRITE;
/*!40000 ALTER TABLE `Pracownik_odwiedzil_Pomieszczenia` DISABLE KEYS */;
INSERT INTO `Pracownik_odwiedzil_Pomieszczenia` VALUES (0,1,'2023-12-05 14:02:00'),(0,2,'2023-12-05 10:12:00'),(0,3,'2023-12-04 12:01:00'),(0,4,'2023-12-04 10:12:00'),(1,2,'2023-12-09 02:09:05'),(1,3,'2023-12-04 14:14:00'),(2,0,'2023-12-04 14:12:00'),(2,4,'2023-12-04 12:17:00'),(1,2,'2023-12-09 02:09:04'),(1,2,'2023-12-09 02:09:04'),(1,2,'2023-12-09 02:09:04'),(1,2,'2023-12-09 02:09:04'),(1,2,'2023-12-09 02:09:04');
/*!40000 ALTER TABLE `Pracownik_odwiedzil_Pomieszczenia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Student`
--

DROP TABLE IF EXISTS `Student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Student` (
  `idStudent` int NOT NULL,
  `nrIndeksu` int NOT NULL,
  `kodKreskowyLegitymacji` int NOT NULL,
  `Imie` varchar(45) NOT NULL,
  `Nazwisko` varchar(45) NOT NULL,
  PRIMARY KEY (`idStudent`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Student`
--

LOCK TABLES `Student` WRITE;
/*!40000 ALTER TABLE `Student` DISABLE KEYS */;
INSERT INTO `Student` VALUES (0,300000,10246541,'Karol','Zdun'),(1,300001,12432541,'Piotr','Nowak'),(2,300002,10265224,'Karol','Kopyra'),(3,300003,12346541,'Mariola','Gołębiewska'),(4,300004,10244623,'Marcin','Olszewski'),(5,300005,12345541,'Alicja','Mironczuk');
/*!40000 ALTER TABLE `Student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Student_has_Zajęcia`
--

DROP TABLE IF EXISTS `Student_has_Zajęcia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Student_has_Zajęcia` (
  `Student_idStudent` int NOT NULL,
  `Zajęcia_idZajęcia` int NOT NULL,
  KEY `fk_Student_has_Zajęcia_Zajęcia1_idx` (`Zajęcia_idZajęcia`),
  KEY `fk_Student_has_Zajęcia_Student1_idx` (`Student_idStudent`),
  CONSTRAINT `fk_Student_has_Zajęcia_Student1` FOREIGN KEY (`Student_idStudent`) REFERENCES `Student` (`idStudent`),
  CONSTRAINT `fk_Student_has_Zajęcia_Zajęcia1` FOREIGN KEY (`Zajęcia_idZajęcia`) REFERENCES `Zajęcia` (`idZajęcia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Student_has_Zajęcia`
--

LOCK TABLES `Student_has_Zajęcia` WRITE;
/*!40000 ALTER TABLE `Student_has_Zajęcia` DISABLE KEYS */;
INSERT INTO `Student_has_Zajęcia` VALUES (0,0),(0,1),(0,2),(0,5),(1,0),(1,1),(1,2),(1,5),(2,0),(2,1),(2,2),(2,5),(3,3),(3,4),(3,6),(3,7),(4,3),(4,4),(4,6),(4,7),(5,3),(5,4),(5,6),(5,7);
/*!40000 ALTER TABLE `Student_has_Zajęcia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Zajęcia`
--

DROP TABLE IF EXISTS `Zajęcia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Zajęcia` (
  `idZajęcia` int NOT NULL,
  `NazwaPrzedmiotu` varchar(45) NOT NULL,
  `TypZajec` varchar(45) NOT NULL COMMENT 'wykład/lab/proj\\n',
  `dzienTygodnia` int NOT NULL,
  `godzinaRozpoczecia` timestamp NOT NULL,
  `godzinaZakonczenia` timestamp NOT NULL,
  `Pomieszczenia_idPomieszczenia` int NOT NULL,
  PRIMARY KEY (`idZajęcia`),
  KEY `fk_Zajęcia_Pomieszczenia1_idx` (`Pomieszczenia_idPomieszczenia`),
  CONSTRAINT `fk_Zajęcia_Pomieszczenia1` FOREIGN KEY (`Pomieszczenia_idPomieszczenia`) REFERENCES `Pomieszczenia` (`idPomieszczenia`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Zajęcia`
--

LOCK TABLES `Zajęcia` WRITE;
/*!40000 ALTER TABLE `Zajęcia` DISABLE KEYS */;
INSERT INTO `Zajęcia` VALUES (0,'KPD','ćwiczenia',0,'2001-01-01 10:15:00','2001-01-01 12:00:00',4),(1,'OPP','wykład',0,'2001-01-01 12:15:00','2001-01-01 14:00:00',4),(2,'DWK','wykład',0,'2001-01-01 14:15:00','2001-01-01 16:00:00',3),(3,'KKP','wykład',0,'2001-01-01 10:15:00','2001-01-01 12:00:00',3),(4,'PA','laboratoria',0,'2001-01-01 12:15:00','2001-01-01 14:00:00',3),(5,'KZU','laboratoria',1,'2001-01-01 10:15:00','2001-01-01 14:00:00',2),(6,'TPU','ćwiczenia',1,'2001-01-01 10:15:00','2001-01-01 12:00:00',4),(7,'KWD','wykład',1,'2001-01-01 12:15:00','2001-01-01 14:00:00',4);
/*!40000 ALTER TABLE `Zajęcia` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-09 22:41:01
