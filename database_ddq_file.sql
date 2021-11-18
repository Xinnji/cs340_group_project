-- MySQL dump 10.16  Distrib 10.1.37-MariaDB, for Linux (x86_64)
--
-- Host: localhost    Database: bsg
-- ------------------------------------------------------
-- Server version	10.1.37-MariaDB

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
-- Table structure for table `bsg_cert`
--

DROP TABLE IF EXISTS `People`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `People` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `age` int(11) NOT NULL,
  `favMovie` int(11),
  `favShow` int(11),
  `favBook` int(11),
  `favGame` int(11),
  PRIMARY KEY (`id`),
  CONSTRAINT `People_ibfk_1` FOREIGN KEY (`favMovie`) REFERENCES `Movies` (`id`),
  CONSTRAINT `People_ibfk_2` FOREIGN KEY (`favShow`) REFERENCES `Shows` (`id`),
  CONSTRAINT `People_ibfk_3` FOREIGN KEY (`favBook`) REFERENCES `Books` (`id`),
  CONSTRAINT `People_ibfk_4` FOREIGN KEY (`favGame`) REFERENCES `VideoGames` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table 'People'
--

LOCK TABLES 'People' WRITE;
/*!40000 ALTER TABLE `bsg_cert` DISABLE KEYS */;
INSERT INTO People (name, age, favMovie, favShow, favBook, favGame) VALUES ('Nicholas Broce',22,1,1,1,1);
INSERT INTO People (name, age, favMovie, favShow, favBook, favGame) VALUES ('Jason Scott-Hakanson',21,2,2,2,2);
/*!40000 ALTER TABLE `bsg_cert` ENABLE KEYS */;
UNLOCK TABLES;
--
-- Table structure for table 'Movies'
--

DROP TABLE IF EXISTS `Movies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Movies` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` text NOT NULL,
  `genre` text NOT NULL,
  `director` varchar(45) NOT NULL,
  `runTimeMins` int(11) NOT NULL,
  `metacritic` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table 'Movies'
--

LOCK TABLES 'Movies' WRITE;
/*!40000 ALTER TABLE `bsg_cert_people` DISABLE KEYS */;
INSERT INTO Movies (title, genre, director, runTimeMins, metacritic) VALUES ('Knives Out','Mystery','Rian Johnson',130,82);
INSERT INTO Movies (title, genre, director, runTimeMins, metacritic) VALUES ('Dune(2021)','Science Fiction','Denis Villeneuve',156,74);
/*!40000 ALTER TABLE `bsg_cert_people` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table 'Shows'
--

DROP TABLE IF EXISTS `Shows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Shows` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `genre` text NOT NULL,
  `network` varchar(45) NOT NULL,
  `episodes` int(11) NOT NULL,
  `seasons` int(11) NOT NULL,
  `metacritic` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table 'Shows'
--

LOCK TABLES 'Shows' WRITE;
INSERT INTO Shows (title, genre, network, episodes, seasons, metacritic) VALUES ('Star Wars: The Clone Wars', 'Animation, Action & Adventure, Fantasy, Science Fiction, Kids','Cartoon Network',133, 7, 66);
INSERT INTO Shows (title, genre, network, episodes, seasons, metacritic) VALUES ('Warehouse 13','Comedy, Drama, Action & Adventure, Fantasy, Science Fiction','SyFy',64,10, 65);
/*!40000 ALTER TABLE `bsg_cert_people` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table 'Books'
--

DROP TABLE IF EXISTS `Books`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Books` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `genre` varchar(45) NOT NULL,
  `author` varchar(45) NOT NULL,
  `pages` int(11) NOT NULL,
  `metacritic` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table 'Books'
--

LOCK TABLES 'Books' WRITE;
/*!40000 ALTER TABLE `bsg_cert_people` DISABLE KEYS */;
INSERT INTO Books (title, genre, author, pages, metacritic) VALUES ('Harry Potter and the Half-Blood Prince','Fantasy','J.K.Rowling',4607,591);
INSERT INTO Books (title, genre, author, pages, metacritic) VALUES ('The Name of the Wind','Heroic Fantasy','Patrick Rothfuss',662, 90);
/*!40000 ALTER TABLE `bsg_cert_people` ENABLE KEYS */;
UNLOCK TABLES;
--
-- Table structure for table 'VideoGames'
--

DROP TABLE IF EXISTS `VideoGames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VideoGames` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(45) NOT NULL,
  `genre` varchar(45) NOT NULL,
  `studio` varchar(45) NOT NULL,
  `playTimeHrs` int(11) NOT NULL,
  `metacritic` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table 'VideoGames'
--

LOCK TABLES 'VideoGames' WRITE;
/*!40000 ALTER TABLE `bsg_cert_people` DISABLE KEYS */;
INSERT INTO VideoGames (title, genre, studio, playTimeHrs, metacritic) VALUES ('Bioshock Infinte','Action, Shooter, First-Person, Sci-Fi','Irrational Games',11,94);
INSERT INTO VideoGames (title, genre, studio, playTimeHrs, metacritic) VALUES ('Dishonored','Action Adventure, Stealth, First-Person','Arkane Studios',12, 91);
/*!40000 ALTER TABLE `bsg_cert_people` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table 'readBooks'
--

DROP TABLE IF EXISTS `readBooks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `readBooks` (
  `books_id` int(11) NOT NULL,
  `people_id` int(11) NOT NULL,
  PRIMARY KEY (`books_id`,`people_id`),
  CONSTRAINT `readBooks_ibfk_1` FOREIGN KEY (`books_id`) REFERENCES `Books` (`id`),
  CONSTRAINT `readBooks_ibfk_2` FOREIGN KEY (`people_id`) REFERENCES `People` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bsg_people`
--

LOCK TABLES `readBooks` WRITE;
/*!40000 ALTER TABLE `bsg_people` DISABLE KEYS */;
INSERT INTO `readBooks` (`books_id`, `people_id`) VALUES ('1', '1');
INSERT INTO `readBooks` (`books_id`, `people_id`) VALUES ('1', '2');
INSERT INTO `readBooks` (`books_id`, `people_id`) VALUES ('2', '2');
/*!40000 ALTER TABLE `bsg_people` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table 'readBooks'
--

DROP TABLE IF EXISTS `playedGames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `playedGames` (
  `video_games_id` int(11) NOT NULL,
  `people_id` int(11) NOT NULL,
  PRIMARY KEY (`video_games_id`,`people_id`),
  CONSTRAINT `playedGames_ibfk_1` FOREIGN KEY (`video_games_id`) REFERENCES `VideoGames` (`id`),
  CONSTRAINT `playedGames_ibfk_2` FOREIGN KEY (`people_id`) REFERENCES `People` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table 'playedGames'
--

LOCK TABLES `playedGames` WRITE;
/*!40000 ALTER TABLE `bsg_people` DISABLE KEYS */;
INSERT INTO `playedGames` (`video_games_id`, `people_id`) VALUES ('1', '1');
INSERT INTO `playedGames` (`video_games_id`, `people_id`) VALUES ('1', '2');
INSERT INTO `playedGames` (`video_games_id`, `people_id`) VALUES ('2', '1');
INSERT INTO `playedGames` (`video_games_id`, `people_id`) VALUES ('2', '2');
/*!40000 ALTER TABLE `bsg_people` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table 'seenMovies'
--

DROP TABLE IF EXISTS `seenMovies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seenMovies` (
  `movies_id` int(11) NOT NULL,
  `people_id` int(11) NOT NULL,
  PRIMARY KEY (`movies_id`,`people_id`),
  CONSTRAINT `seenMovies_ibfk_1` FOREIGN KEY (`movies_id`) REFERENCES `Movies` (`id`),
  CONSTRAINT `seenMovies_ibfk_2` FOREIGN KEY (`people_id`) REFERENCES `People` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table 'seenMovies'
--

LOCK TABLES `seenMovies` WRITE;
/*!40000 ALTER TABLE `bsg_people` DISABLE KEYS */;
INSERT INTO `seenMovies` (`movies_id`, `people_id`) VALUES ('1', '1');
INSERT INTO `seenMovies` (`movies_id`, `people_id`) VALUES ('1', '2');
INSERT INTO `seenMovies` (`movies_id`, `people_id`) VALUES ('2', '1');
INSERT INTO `seenMovies` (`movies_id`, `people_id`) VALUES ('2', '2');
/*!40000 ALTER TABLE `bsg_people` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table 'seenShows'
--
DROP TABLE IF EXISTS `seenShows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `seenShows` (
  `shows_id` int(11) NOT NULL,
  `people_id` int(11) NOT NULL,
  PRIMARY KEY (`shows_id`,`people_id`),
  CONSTRAINT `seenShows_ibfk_1` FOREIGN KEY (`shows_id`) REFERENCES `Shows` (`id`),
  CONSTRAINT `seenShows_ibfk_2` FOREIGN KEY (`people_id`) REFERENCES `People` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table 'seenShows'
--

LOCK TABLES `seenShows` WRITE;
/*!40000 ALTER TABLE `bsg_people` DISABLE KEYS */;
INSERT INTO `seenShows` (`shows_id`, `people_id`) VALUES ('1', '1');
INSERT INTO `seenShows` (`shows_id`, `people_id`) VALUES ('2', '2');
/*!40000 ALTER TABLE `bsg_people` ENABLE KEYS */;
UNLOCK TABLES;


/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-02-03  0:38:33
