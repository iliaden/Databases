-- MySQL dump 10.13  Distrib 5.1.58, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: recipe
-- ------------------------------------------------------
-- Server version	5.1.58-1ubuntu1

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
  `rid` int(10) unsigned DEFAULT NULL,
  `mid` int(10) unsigned DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `body` text,
  PRIMARY KEY (`id`),
  KEY `rec_id` (`rid`),
  KEY `mem_id` (`mid`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`rid`) REFERENCES `recipes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comments_ibfk_2` FOREIGN KEY (`mid`) REFERENCES `members` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=136 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `conversions`
--

DROP TABLE IF EXISTS `conversions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `conversions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `imperial` int(11) NOT NULL,
  `metric` int(11) NOT NULL,
  `imp_to_met` float unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `imperial` (`imperial`,`metric`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ingredients`
--

DROP TABLE IF EXISTS `ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ingredients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `instructions`
--

DROP TABLE IF EXISTS `instructions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `instructions` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rid` int(10) unsigned NOT NULL DEFAULT '0',
  `value` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rid` (`rid`),
  KEY `recipe_id` (`rid`),
  CONSTRAINT `instructions_ibfk_1` FOREIGN KEY (`rid`) REFERENCES `recipes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `member_favorites`
--

DROP TABLE IF EXISTS `member_favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `member_favorites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mid` int(10) unsigned NOT NULL,
  `fid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mid` (`mid`,`fid`),
  KEY `member_id` (`mid`),
  KEY `friend_id` (`fid`),
  CONSTRAINT `member_favorites_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `members` (`id`) ON DELETE CASCADE,
  CONSTRAINT `member_favorites_ibfk_2` FOREIGN KEY (`fid`) REFERENCES `members` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `members`
--

DROP TABLE IF EXISTS `members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `members` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(50) NOT NULL,
  `username` varchar(20) NOT NULL,
  `password` char(32) NOT NULL,
  `dateJoined` datetime DEFAULT NULL,
  `type` enum('normal','moderator') NOT NULL,
  `showEmail` enum('yes','no') DEFAULT NULL,
  `defaultPage` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `picture_ratings`
--

DROP TABLE IF EXISTS `picture_ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `picture_ratings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mid` int(10) unsigned NOT NULL,
  `pid` int(10) unsigned NOT NULL,
  `dateVoted` datetime NOT NULL,
  `rating` tinyint(2) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rating_id` (`mid`,`pid`),
  KEY `member_id` (`mid`),
  KEY `pic_id` (`pid`),
  CONSTRAINT `picture_ratings_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `members` (`id`) ON DELETE CASCADE,
  CONSTRAINT `picture_ratings_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `pictures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pictures`
--

DROP TABLE IF EXISTS `pictures`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `pictures` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rid` int(10) unsigned DEFAULT NULL,
  `mid` int(10) unsigned DEFAULT NULL,
  `imgdata` longblob,
  `dateAdded` datetime DEFAULT NULL,
  `type` enum('image/jpeg','image/bmp','image/gif') DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `recipe_id` (`rid`),
  KEY `member_id` (`mid`),
  KEY `mid` (`mid`),
  CONSTRAINT `pictures_ibfk_1` FOREIGN KEY (`rid`) REFERENCES `recipes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pictures_ibfk_2` FOREIGN KEY (`mid`) REFERENCES `members` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ratings` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mid` int(10) unsigned NOT NULL,
  `rid` int(10) unsigned NOT NULL,
  `dateVoted` datetime NOT NULL,
  `rating` tinyint(2) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mid` (`mid`,`rid`),
  KEY `member_id` (`mid`),
  KEY `rid` (`rid`),
  CONSTRAINT `ratings_ibfk_3` FOREIGN KEY (`mid`) REFERENCES `members` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ratings_ibfk_4` FOREIGN KEY (`rid`) REFERENCES `recipes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=784 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipe_favorites`
--

DROP TABLE IF EXISTS `recipe_favorites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipe_favorites` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `mid` int(10) unsigned NOT NULL,
  `rid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mid` (`mid`,`rid`),
  KEY `member_id` (`mid`),
  KEY `recipe_id` (`rid`),
  CONSTRAINT `recipe_favorites_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `members` (`id`) ON DELETE CASCADE,
  CONSTRAINT `recipe_favorites_ibfk_2` FOREIGN KEY (`rid`) REFERENCES `recipes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipes`
--

DROP TABLE IF EXISTS `recipes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipes` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `author` int(10) unsigned NOT NULL,
  `servings` tinyint(4) DEFAULT NULL,
  `category` enum('appetizer','meat','vegetarian','dessert','drinks') DEFAULT NULL,
  `dateAdded` datetime NOT NULL,
  `prepTime` float(4,2) NOT NULL,
  `cookTime` float(4,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  KEY `author_id` (`author`),
  CONSTRAINT `recipes_ibfk_1` FOREIGN KEY (`author`) REFERENCES `members` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=111 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipes_ingredients`
--

DROP TABLE IF EXISTS `recipes_ingredients`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipes_ingredients` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `iid` int(10) unsigned NOT NULL,
  `rid` int(10) unsigned NOT NULL,
  `quantity` float NOT NULL,
  `unit` enum('none','g','ml','tsp','tbsp','cup') DEFAULT NULL,
  `modifier` varchar(50) NOT NULL,
  `unit_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `iid` (`iid`),
  KEY `rid` (`rid`),
  KEY `unit_id` (`unit_id`),
  CONSTRAINT `recipes_ingredients_ibfk_1` FOREIGN KEY (`iid`) REFERENCES `ingredients` (`id`),
  CONSTRAINT `recipes_ingredients_ibfk_2` FOREIGN KEY (`rid`) REFERENCES `recipes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `recipes_ingredients_ibfk_3` FOREIGN KEY (`unit_id`) REFERENCES `units` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recipes_subcategories`
--

DROP TABLE IF EXISTS `recipes_subcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recipes_subcategories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `rid` int(10) unsigned NOT NULL,
  `sid` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=98 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `subcategories`
--

DROP TABLE IF EXISTS `subcategories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `subcategories` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `category` enum('appetizer','meat','vegetarian','dessert','drinks') DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `units`
--

DROP TABLE IF EXISTS `units`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `units` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) DEFAULT NULL,
  `abbreviation` varchar(5) DEFAULT NULL,
  `unitType` enum('imperial','metric','universal') NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `abbreviation` (`abbreviation`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2012-01-29 18:42:16
