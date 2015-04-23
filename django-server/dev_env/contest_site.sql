-- MySQL dump 10.13  Distrib 5.6.10, for osx10.7 (x86_64)
--
-- Host: localhost    Database: contest_site
-- ------------------------------------------------------
-- Server version	5.6.10

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `compiler_data`
--

DROP TABLE IF EXISTS `compiler_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `compiler_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `is_compiled` tinyint(1) NOT NULL,
  `compile_command` text NOT NULL,
  `run_command` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `compiler_data`
--

LOCK TABLES `compiler_data` WRITE;
/*!40000 ALTER TABLE `compiler_data` DISABLE KEYS */;
INSERT INTO `compiler_data` VALUES (1,'Perl',0,'','perl {FILENAME}');
/*!40000 ALTER TABLE `compiler_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contest_run_data`
--

DROP TABLE IF EXISTS `contest_run_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contest_run_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `problem_id` int(11) NOT NULL,
  `successful` tinyint(1) NOT NULL,
  `submit_time` datetime NOT NULL,
  `output` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contest_run_data`
--

LOCK TABLES `contest_run_data` WRITE;
/*!40000 ALTER TABLE `contest_run_data` DISABLE KEYS */;
INSERT INTO `contest_run_data` VALUES (17,2,2,1,'2013-05-09 23:53:02','Hello, World!\n'),(18,2,2,0,'2013-05-09 23:53:20','Hello, World!\nhdfsafda');
/*!40000 ALTER TABLE `contest_run_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `problem_data`
--

DROP TABLE IF EXISTS `problem_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `problem_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` text NOT NULL,
  `score` int(11) NOT NULL,
  `input_type` enum('stdin','file','none') NOT NULL,
  `output_type` enum('stdout','file','none') NOT NULL,
  `input_sample` text NOT NULL,
  `input_private` text NOT NULL,
  `output_sample` text NOT NULL,
  `output_private` text NOT NULL,
  `description` text NOT NULL,
  `input_description` text NOT NULL,
  `output_description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `problem_data`
--

LOCK TABLES `problem_data` WRITE;
/*!40000 ALTER TABLE `problem_data` DISABLE KEYS */;
INSERT INTO `problem_data` VALUES (1,'Simple Math',3,'file','stdout','+ 2 1\r\n* 5 6\r\n/ 50 2','* 10 60\r\n/ 50 5\r\n200 * -1','3\r\n30\r\n25','600\r\n10\r\n-200','Add up all the numbers. Get crackin\' yo!','Each line contains an operator followed by two numbers, separated by spaces. perform the prefix operation.','The operation on each line.'),(2,'Hello World',10,'none','stdout','','','Hello, World!\r\n','Hello, World!\r\n','You are asleep. You awake. Greet the world!','No input','print \"Hello, World!\"');
/*!40000 ALTER TABLE `problem_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_compiler_data`
--

DROP TABLE IF EXISTS `user_compiler_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_compiler_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL,
  `compiler_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_compiler_data`
--

LOCK TABLES `user_compiler_data` WRITE;
/*!40000 ALTER TABLE `user_compiler_data` DISABLE KEYS */;
INSERT INTO `user_compiler_data` VALUES (1,2,1);
/*!40000 ALTER TABLE `user_compiler_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` tinytext NOT NULL,
  `name` text NOT NULL,
  `password` text NOT NULL,
  `guid` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'leanrobot','','leanrobot',0),(2,'team1','The TableDroppers','team1',2),(3,'judge1','','judge1',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-05-12 15:07:15
