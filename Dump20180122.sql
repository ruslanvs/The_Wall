-- MySQL dump 10.13  Distrib 5.7.17, for macos10.12 (x86_64)
--
-- Host: localhost    Database: the_wall
-- ------------------------------------------------------
-- Server version	5.7.21

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
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `comment` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  `message_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_comments_users1_idx` (`user_id`),
  KEY `fk_comments_messages1_idx` (`message_id`),
  CONSTRAINT `fk_comments_messages1` FOREIGN KEY (`message_id`) REFERENCES `messages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_comments_users1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,'Perspiciatis quaerat saepe veniam officiis unde, nesciunt commodi accusamus dolorum nihil doloremque numquam sequi consequatur aliquam est eligendi odio architecto eius fugiat exercitationem? Assumenda dicta ex pariatur dolore odit praesentium facere vel?','2018-01-21 17:13:40','2018-01-21 17:13:40',2,2),(2,'Response to Marat','2018-01-21 17:31:54','2018-01-21 17:31:54',2,1),(3,'Response to Arash\r\n','2018-01-21 17:32:55','2018-01-21 17:32:55',2,2),(4,'From Marat to Arash','2018-01-21 18:08:43','2018-01-21 18:08:43',1,2),(5,'Arash commented in response to Marat','2018-01-21 18:09:24','2018-01-21 18:09:24',2,2),(6,'Shut up bitch','2018-01-21 18:46:16','2018-01-21 18:46:16',1,3),(7,'I thought so too','2018-01-21 18:55:06','2018-01-21 18:55:06',3,4),(8,'Assumenda dicta ex pariatur dolore odit praesentium facere vel? Illo veniam, illum maiores dicta doloribus itaque dolorem quos sequi, tenetur minima impedit fugit non animi at tempore velit debitis aliquid autem! Hic quae amet incidunt?','2018-01-21 19:03:52','2018-01-21 19:03:52',3,5),(9,'Beatae sit voluptatum laudantium eligendi dolor quidem!','2018-01-21 19:04:22','2018-01-21 19:04:22',1,5),(10,'Beatae sit voluptatum laudantium eligendi dolor quidem!','2018-01-21 19:05:18','2018-01-21 19:05:18',2,4),(11,'sregdsfg sf sdf df sf fsdg ','2018-01-22 10:56:40','2018-01-22 10:56:40',1,4);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `message` text,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_messages_users_idx` (`user_id`),
  CONSTRAINT `fk_messages_users` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Beatae sit voluptatum laudantium eligendi dolor quidem! Enim provident veniam quibusdam. Excepturi necessitatibus soluta mollitia ipsam ex, porro officiis. Quaerat, provident suscipit consequuntur error libero possimus doloribus tempore, at optio sunt qui itaque assumenda sint cum iusto eaque nesciunt nihil.','2018-01-21 17:12:36','2018-01-21 17:12:36',1),(2,'Placeat consectetur rem veritatis suscipit alias nam maxime nobis commodi maiores dolor ea impedit, saepe voluptatibus totam, aut ipsa ducimus ipsam ratione! Architecto, dolore! Aut soluta, quibusdam temporibus vel harum, laudantium error labore inventore voluptatibus nulla odit. Doloremque.','2018-01-21 17:13:22','2018-01-21 17:13:22',2),(3,'Assumenda dicta ex pariatur dolore odit praesentium facere vel?','2018-01-21 18:30:18','2018-01-21 18:30:18',3),(4,'adf a;kl aadsf ad a adds as','2018-01-21 18:54:35','2018-01-21 18:54:35',1),(5,'Hello everyone! \r\nAssumenda dicta ex pariatur dolore odit praesentium facere vel? Illo veniam, illum maiores dicta doloribus itaque dolorem quos sequi, tenetur minima impedit fugit non animi at tempore velit debitis aliquid autem! Hic quae amet incidunt?','2018-01-21 19:03:29','2018-01-21 19:03:29',4),(6,'Beatae sit voluptatum laudantium eligendi dolor quidem!','2018-01-21 19:05:10','2018-01-21 19:05:10',2);
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Marat','Azen','mazen@test.tt','ed97564c8571c5e550136ec49af8d004','2018-01-21 17:12:18','2018-01-21 17:12:18'),(2,'Arash','Soy','arash.soy@test.tt','91ce0af7b9a6729cffcd6b00d59d5a3d','2018-01-21 17:12:58','2018-01-21 17:12:58'),(3,'Tork','Madden','tmadden@test.tt','00d92a1414b3eb84b2aee85aa2c63c75','2018-01-21 18:29:42','2018-01-21 18:29:42'),(4,'Dig','Dong','dd@test.tt','25090b2dd05b496de48dc020af89d726','2018-01-21 19:00:04','2018-01-21 19:00:04');
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

-- Dump completed on 2018-01-22 10:57:59
