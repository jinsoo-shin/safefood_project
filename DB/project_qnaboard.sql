-- MySQL dump 10.13  Distrib 8.0.15, for Win64 (x86_64)
--
-- Host: localhost    Database: project
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `qnaboard`
--

DROP TABLE IF EXISTS `qnaboard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `qnaboard` (
  `num` int(5) NOT NULL DEFAULT '1',
  `title` varchar(1000) DEFAULT NULL,
  `writer` varchar(100) DEFAULT NULL,
  `count` int(5) DEFAULT '0',
  `postdate` datetime DEFAULT CURRENT_TIMESTAMP,
  `password` varchar(100) DEFAULT '0000',
  `content` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `qnaboard`
--

LOCK TABLES `qnaboard` WRITE;
/*!40000 ALTER TABLE `qnaboard` DISABLE KEYS */;
INSERT INTO `qnaboard` VALUES (1,'공지사항','운영자',7,'2019-05-08 14:42:47','0000',NULL),(7,'안녕하세요','싸피',3,'2019-05-08 14:43:16','0000',NULL),(8,'안녕하세요','싸이',3,'2019-05-08 00:00:00','0000',NULL),(9,'안녕하세요','싸이',3,'2019-05-08 00:00:00','0000',NULL),(11,'안녕하세요22','드롭박스',78,'2019-05-08 14:43:37','0000',NULL),(12,'안녕하세요22','드롭박스',75,'2019-05-08 14:43:45','0000',NULL),(15,'월급인상건에대해...','박구곤',22,'2019-05-08 14:44:35','0000','ㅇㅇㅇㅇㅇㅇㅇ'),(17,'월급인상건에대해...','사장',38,'2019-05-08 14:44:50','0000','안녕ㅇ'),(18,'집가고싶어요','누굴까',4,'2019-05-15 17:04:51','1234','ㅁㅁㅁㅁㅁㅁ'),(19,'rrrrttttdddd','test',3,'2019-05-15 17:12:34','1234','dddd'),(22,'16 test','test',4,'2019-05-16 09:55:42','1234','dddd'),(23,'테스트','test',4,'2019-05-16 15:29:28','1234','11');
/*!40000 ALTER TABLE `qnaboard` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-16 16:26:43
