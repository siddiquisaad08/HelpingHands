-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: seva_x
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `delivery_details`
--

DROP TABLE IF EXISTS `delivery_details`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `delivery_details` (
  `delivery_id` int NOT NULL AUTO_INCREMENT,
  `item_id` int NOT NULL,
  `donor_id` int NOT NULL,
  `needy_id` int NOT NULL,
  `delivery_address` text NOT NULL,
  `delivery_status` tinyint(1) DEFAULT '0',
  `delivery_code` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`delivery_id`),
  KEY `delivery_item_FK_idx` (`item_id`),
  KEY `delivery_donor_idx` (`donor_id`,`needy_id`),
  KEY `delivery_needy_FK_idx` (`needy_id`),
  CONSTRAINT `delivery_donor_FK` FOREIGN KEY (`donor_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `delivery_item_FK` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `delivery_needy_FK` FOREIGN KEY (`needy_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `delivery_details`
--

LOCK TABLES `delivery_details` WRITE;
/*!40000 ALTER TABLE `delivery_details` DISABLE KEYS */;
INSERT INTO `delivery_details` VALUES (8,3,14,20,'Mumbai, India',1,997550,'2023-05-08 06:41:05','2023-05-08 06:43:41'),(9,2,14,21,'Mumbai, India',0,887234,'2023-05-08 06:44:41','2023-05-08 06:44:41');
/*!40000 ALTER TABLE `delivery_details` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item` (
  `item_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `description` varchar(500) NOT NULL,
  `pictureSrc` varchar(500) NOT NULL,
  `isActive` tinyint(1) NOT NULL,
  `creationTimestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` int NOT NULL,
  PRIMARY KEY (`item_id`),
  UNIQUE KEY `item_id_UNIQUE` (`item_id`),
  KEY `item_users_FK_idx` (`user_id`),
  CONSTRAINT `item_users_FK` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (2,'Clothes and Shoes for 18-30yr old','Nunc rhoncus metus sed neque vehicula convallis. Praesent non dui augue. Nullam pellentesque mi turpis, quis vulputate eros tristique sed. Donec commodo, nisi ac pellentesque blandit, quam libero auctor felis, quis cursus velit turpis ut est. Vestibulum a tellus pellentesque, scelerisque justo eu, mollis felis. Fusce purus dui, sagittis quis ipsum eget, interdum aliquam justo. Nam rutrum felis at urna sollicitudin tincidunt.','uploads/items/91416840-80dc-425f-b108-c7aff37fd67e-laundry-tips-before-you-donate-clothes-4046404-01-ca8bf91d0b9f418689cec82662381c09.jpg',1,'2023-02-16 16:34:35',14),(3,'12th std NCERT textbooks','Nunc rhoncus metus sed neque vehicula convallis. Praesent non dui augue. Nullam pellentesque mi turpis, quis vulputate eros tristique sed. Donec commodo, nisi ac pellentesque blandit, quam libero auctor felis, quis cursus velit turpis ut est. Vestibulum a tellus pellentesque, scelerisque justo eu, mollis felis. Fusce purus dui, sagittis quis ipsum eget, interdum aliquam justo. Nam rutrum felis at urna sollicitudin tincidunt.','uploads/items/c10e64a7-cf60-44e3-ac95-e64298566a84-IMG_20230121_180822_250x250@2x.webp',1,'2023-02-16 17:02:11',14),(4,'Clothes for women','Cras tincidunt, sapien vitae bibendum consectetur, orci enim cursus risus, ut viverra velit risus fermentum sem. In lobortis sapien libero, non semper lectus eleifend a. Aenean sed neque a mi bibendum rhoncus. Vestibulum sed leo non lacus molestie iaculis sit amet vel massa. Ut at augue dolor. Sed facilisis luctus risus, id aliquam nibh tristique ac. Cras vitae elementum urna. Donec libero est, finibus nec lacus in, convallis congue dui. Integer vel libero lectus. Maecenas aliquam eros arcu, non','uploads/items/9fc1f279-9528-45cd-a33a-7875124a3b11-istockphoto-653003428-612x612.jpg',1,'2023-02-16 17:02:34',14),(5,'20kg Rice','orem ipsum dolor sit amet, consectetur adipiscing elit. Aenean vel tellus dignissim, efficitur leo tristique, malesuada lorem. Cras dictum ipsum interdum, posuere lacus vel, sodales risus. Suspendisse a sapien eros. Maecenas venenatis ornare massa, et euismod augue ultricies et. Aenean bibendum, metus vitae posuere volutpat, eros turpis vehicula urna, a molestie mauris nisi at sem. Suspendisse posuere, eros in ornare mollis, libero sapien porttitor sapien, id dapibus tellus orci at lacus. Nunc c','uploads/items/ddbad5fc-d911-4800-916f-4f169a3f9000-1649441664-9019-rice-splco.jpg',1,'2023-02-16 17:03:02',14);
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_requests`
--

DROP TABLE IF EXISTS `item_requests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_requests` (
  `id` int NOT NULL AUTO_INCREMENT,
  `item_id` int NOT NULL,
  `user_id` int NOT NULL,
  `request_status` tinyint(1) DEFAULT '0',
  `request_timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `request_update_timestamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `request_message` text,
  PRIMARY KEY (`id`),
  KEY `itemRequests_item_FK_idx` (`item_id`),
  KEY `itemRequests_user_FK_idx` (`user_id`),
  CONSTRAINT `itemRequests_item_FK` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `itemRequests_user_FK` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=232 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_requests`
--

LOCK TABLES `item_requests` WRITE;
/*!40000 ALTER TABLE `item_requests` DISABLE KEYS */;
INSERT INTO `item_requests` VALUES (229,3,20,1,'2023-05-08 06:37:36','2023-05-08 06:41:05','i need this to study for y NEET exam'),(230,2,21,1,'2023-05-08 06:42:41','2023-05-08 06:44:41','I need this for my wedding'),(231,5,20,0,'2023-05-08 06:44:18','2023-05-08 06:44:18','I need this for my dinner');
/*!40000 ALTER TABLE `item_requests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `needy`
--

DROP TABLE IF EXISTS `needy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `needy` (
  `needy_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `isHeadOfFamily` tinyint(1) NOT NULL,
  `sourceOfIncome` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `noOfFamilyMembers` int NOT NULL,
  `yearlyIncome` int NOT NULL,
  `rationCardSrc` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL,
  `rationCardType` varchar(20) COLLATE utf8mb4_bin NOT NULL,
  `aadharCardSrc` varchar(250) COLLATE utf8mb4_bin DEFAULT NULL,
  `isVerified` tinyint(1) NOT NULL DEFAULT '0',
  `totalEarningMembersInFamily` int NOT NULL,
  `noteForAdmin` text COLLATE utf8mb4_bin,
  PRIMARY KEY (`needy_id`),
  KEY `needy_user_FK_idx` (`user_id`),
  CONSTRAINT `needy_user_FK` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `needy`
--

LOCK TABLES `needy` WRITE;
/*!40000 ALTER TABLE `needy` DISABLE KEYS */;
INSERT INTO `needy` VALUES (8,20,1,'Working at hospital',5,120000,'uploads/rationCards/4c2cdb74-cdd9-4ba4-ad64-7e7c9854f490-1rationCard.jpg','saffron','uploads/aadharCards/32f82db2-1abb-48ce-85b0-ca267766b290-1aadharCard.webp',1,1,'I want to get help by receiving the donations as my salary is not enough for fulfilling my requirements and it would be of great help if i can receive the donations.\r\nThanks.'),(9,21,1,'Playing football',3,250000,'uploads/rationCards/e17a40dc-0dc0-41ed-947a-6aae2cdbb892-1rationCard.jpg','','uploads/aadharCards/346b75b5-d49b-4774-81d0-48ade8e22815-1aadharCard.jpg',1,1,'i want to receive donations');
/*!40000 ALTER TABLE `needy` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `refresh_token`
--

DROP TABLE IF EXISTS `refresh_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `refresh_token` (
  `token_id` int NOT NULL AUTO_INCREMENT,
  `refresh_token` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`token_id`)
) ENGINE=InnoDB AUTO_INCREMENT=251 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `refresh_token`
--

LOCK TABLES `refresh_token` WRITE;
/*!40000 ALTER TABLE `refresh_token` DISABLE KEYS */;
INSERT INTO `refresh_token` VALUES (193,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTW9oYW1lZCBBcmliIiwiZW1haWwiOiJhcmliQGdtYWlsLmNvbSIsInJvbGVfaWQiOjMsImlhdCI6MTY3ODEzMTA4OCwiZXhwIjoxNjc4MTMxMjA4fQ.ZFBm0DTJXwYyV5h8d--uAanJwrWb5jBFm6DSpk3UN_k'),(194,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoia2FyaW0gYmVuemVtYSIsImVtYWlsIjoia2FyaW1AZ21haWwuY29tIiwicm9sZV9pZCI6MSwiaWF0IjoxNjc4MTMxMTE4LCJleHAiOjE2NzgxMzEyMzh9.hrF5ZyaUY2utPBi4ZSV0aYKkbbeUng6w6dyDbVp0fvo'),(195,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWFkbmkgQW5zYXJpIiwiZW1haWwiOiJtYWRuaUBnbWFpbC5jb20iLCJyb2xlX2lkIjoyLCJpYXQiOjE2NzgxMzIzMTEsImV4cCI6MTY3ODEzMjQzMX0.rabbNgZh1EIjhg1999lnK2OoJU-zWUNfiiNuXjFDveY'),(196,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWF6aGFyIEFuc2FyaSIsImVtYWlsIjoibWF6aGFyQGdtYWlsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY3ODEzNDQ5NSwiZXhwIjoxNjc4MTM0NjE1fQ.DV_mf9JdDk3r4jdQzqpZjPEagVWLzL9_OL1GLr03kwg'),(197,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWFkbmkgQW5zYXJpIiwiZW1haWwiOiJtYWRuaUBnbWFpbC5jb20iLCJyb2xlX2lkIjoyLCJpYXQiOjE2NzgxMzQ4NzMsImV4cCI6MTY3ODEzNDk5M30.uVd3zuEp0D-xtevmwrbrjPuRjpg7hg6QUzgdaMXxO9M'),(198,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWF6aGFyIEFuc2FyaSIsImVtYWlsIjoibWF6aGFyQGdtYWlsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY3ODEzNTY4MiwiZXhwIjoxNjc4MTM1ODAyfQ.j4uk0Nc-MbEWNecE0GeFXA1Ngwib1zykCR8qS-yVuZQ'),(199,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoia2FyaW0gYmVuemVtYSIsImVtYWlsIjoia2FyaW1AZ21haWwuY29tIiwicm9sZV9pZCI6MSwiaWF0IjoxNjc4MjAxNTMxLCJleHAiOjE2NzgyMDE2NTF9.TBHR1sW6WKLIMeJ-MOHgQE-SGGX4GrZ4nEZRSAjWSTw'),(200,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWFkbmkgQW5zYXJpIiwiZW1haWwiOiJtYWRuaUBnbWFpbC5jb20iLCJyb2xlX2lkIjoyLCJpYXQiOjE2NzgyMDE2NTUsImV4cCI6MTY3ODIwMTc3NX0.7LiLxT--tdupJKCwvAwusZjl0THdSouYUdtrfbKLuOg'),(201,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWF6aGFyIEFuc2FyaSIsImVtYWlsIjoibWF6aGFyQGdtYWlsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY3ODg5OTkzOCwiZXhwIjoxNjc4OTAwMDU4fQ.fpODxCLnIR9jnwMtoPt57Lz12jhoKXhvR1us-h2YLfU'),(202,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWFkbmkgQW5zYXJpIiwiZW1haWwiOiJtYWRuaUBnbWFpbC5jb20iLCJyb2xlX2lkIjoyLCJpYXQiOjE2Nzg5MDAwNTgsImV4cCI6MTY3ODkwMDE3OH0.0R3sHcagYEgxCfh6VrszCQ3M1K4hkC5HZBqNIhd5Z_0'),(203,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoia2FyaW0gYmVuemVtYSIsImVtYWlsIjoia2FyaW1AZ21haWwuY29tIiwicm9sZV9pZCI6MSwiaWF0IjoxNjc5MTUzNTk5LCJleHAiOjE2NzkxNTM3MTl9.EVaHiSD6DHq_WvO9mNbsH8uzE-ILokT6snb8sFbXFzU'),(204,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWFkbmkgQW5zYXJpIiwiZW1haWwiOiJtYWRuaUBnbWFpbC5jb20iLCJyb2xlX2lkIjoyLCJpYXQiOjE2NzkxNTM2NTQsImV4cCI6MTY3OTE1Mzc3NH0.upY22Ot5IyUd_joJhWsq4odNF5eMcvIbMBV-BR_3dms'),(205,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWF6aGFyIEFuc2FyaSIsImVtYWlsIjoibWF6aGFyQGdtYWlsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY4MDM2MTMwMCwiZXhwIjoxNjgwMzYxNDIwfQ.Mp4EmQZax9ScmhN_g5PRpfTMQyHuHzMafYmASW2FYlk'),(206,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWFkbmkgQW5zYXJpIiwiZW1haWwiOiJtYWRuaUBnbWFpbC5jb20iLCJyb2xlX2lkIjoyLCJpYXQiOjE2ODAzNjE0NjcsImV4cCI6MTY4MDM2MTU4N30.bt6DDEUrPZ5bhcyWKusvmpXU5j5BbfZEkAADhuOXQiY'),(207,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWF6aGFyIEFuc2FyaSIsImVtYWlsIjoibWF6aGFyQGdtYWlsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY4MDM2MTQ3OSwiZXhwIjoxNjgwMzYxNTk5fQ.kPuFlWWerIQ-sexqrF-0pZi3xzw5xRuwPTYMMx_NPkk'),(208,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoia2FyaW0gYmVuemVtYSIsImVtYWlsIjoia2FyaW1AZ21haWwuY29tIiwicm9sZV9pZCI6MSwiaWF0IjoxNjgwMzYxNDk2LCJleHAiOjE2ODAzNjE2MTZ9.cnHvOEUSRcYx8ktMoO4P57VAECtuAKghnHqczFTeonM'),(209,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWF6aGFyIEFuc2FyaSIsImVtYWlsIjoibWF6aGFyQGdtYWlsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY4MDUzMzAyOCwiZXhwIjoxNjgwNTMzMTQ4fQ.2WZm44ves2RTpWvOpGZnh33HBYgmY0n6Wi2-8vI6ljM'),(210,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWFkbmkgQW5zYXJpIiwiZW1haWwiOiJtYWRuaUBnbWFpbC5jb20iLCJyb2xlX2lkIjoyLCJpYXQiOjE2ODA1MzMwODIsImV4cCI6MTY4MDUzMzIwMn0.o7gaKDfIxHistIOyChNMivKksmCLS6Lc_kCGVo9_EMU'),(211,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTW9oYW1lZCBBcmliIiwiZW1haWwiOiJhcmliQGdtYWlsLmNvbSIsInJvbGVfaWQiOjMsImlhdCI6MTY4MDUzNDgxMSwiZXhwIjoxNjgwNTM0OTMxfQ.sFTqIUn-gJlehF_2nsCF1rvZL6smOm4zkFyWIp5-IOY'),(212,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiSm9obiBBbG1hIiwiZW1haWwiOiJqb2huQGdtYWlsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY4MDUzNTA2NiwiZXhwIjoxNjgwNTM1MTg2fQ.7PEN4PB_ZwEOJ7AZTSNJbpib7Ku1o_1H2tjkM4EyQ9A'),(213,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTW9oYW1lZCBBcmliIiwiZW1haWwiOiJhcmliQGdtYWlsLmNvbSIsInJvbGVfaWQiOjMsImlhdCI6MTY4MDUzNTA4OSwiZXhwIjoxNjgwNTM1MjA5fQ.VnJwi-nuoBWx9evrJs8CLcOfifQqrOoRUL8lCbRhwWk'),(214,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiSm9obiBBbG1hIiwiZW1haWwiOiJqb2huQGdtYWlsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY4MDUzNTExMSwiZXhwIjoxNjgwNTM1MjMxfQ.0rpOccmn-wYPwFUuMw_qUOjp_F50_FFXmYc5_DomGqo'),(215,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWF6aGFyIEFuc2FyaSIsImVtYWlsIjoibWF6aGFyQGdtYWlsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY4MDc5MjQ5NiwiZXhwIjoxNjgwNzkyNjE2fQ.WEq68raxs9Wv6W8QCOY63NRrFsii0jCMTH5cjtPTaak'),(216,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTW9oYW1lZCBBcmliIiwiZW1haWwiOiJhcmliQGdtYWlsLmNvbSIsInJvbGVfaWQiOjMsImlhdCI6MTY4MDc5MjUwOCwiZXhwIjoxNjgwNzkyNjI4fQ.Ji2wZ1F0yvnMf-pVB3eKvjBDKqkU97Wmptb9xocyq1c'),(217,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWFkbmkgQW5zYXJpIiwiZW1haWwiOiJtYWRuaUBnbWFpbC5jb20iLCJyb2xlX2lkIjoyLCJpYXQiOjE2ODA3OTI1NTcsImV4cCI6MTY4MDc5MjY3N30.gh6XjXoxDVTr6cjNtuGRo_v9KmPj0e2qMfz0XIGxDB8'),(218,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWF6aGFyIEFuc2FyaSIsImVtYWlsIjoibWF6aGFyQGdtYWlsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY4MDc5ODg5NywiZXhwIjoxNjgwNzk5MDE3fQ.RpAUlONP5IH-RThdUF-mxZ0cQZWj4e4j3NILDtq69d8'),(219,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWF6aGFyIEFuc2FyaSIsImVtYWlsIjoibWF6aGFyQGdtYWlsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY4MDg3MTczMSwiZXhwIjoxNjgwODcxODUxfQ.1GRJoXQpqLnDWU1kRwpnhJYN-dtVj_FiYA-a0e3uE8I'),(220,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWFkbmkgQW5zYXJpIiwiZW1haWwiOiJtYWRuaUBnbWFpbC5jb20iLCJyb2xlX2lkIjoyLCJpYXQiOjE2ODA4NzE3NTMsImV4cCI6MTY4MDg3MTg3M30.e9jazVGIoQiPNtbrzF59egL_FimF33U5rjgQHonjOZY'),(221,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWF6aGFyIEFuc2FyaSIsImVtYWlsIjoibWF6aGFyQGdtYWlsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY4MDg3ODEwMCwiZXhwIjoxNjgwODc4MjIwfQ.unE4i126ZlfxP2py9Dz6QAwbBgX_CY6YSRTcagF_c9k'),(222,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWFkbmkgQW5zYXJpIiwiZW1haWwiOiJtYWRuaUBnbWFpbC5jb20iLCJyb2xlX2lkIjoyLCJpYXQiOjE2ODA4NzgxMTMsImV4cCI6MTY4MDg3ODIzM30.4s_yoexc0XL419NYU-l_Ty3HmOnNMd25bCGy4L3w47U'),(223,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWFkbmkgQW5zYXJpIiwiZW1haWwiOiJtYWRuaUBnbWFpbC5jb20iLCJyb2xlX2lkIjoyLCJpYXQiOjE2ODA4ODI4NjUsImV4cCI6MTY4MDg4Mjk4NX0.9ZmwSnV39L_jBGisZtRkhKzxW-MIjYfm9zwcpo8noEc'),(224,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWF6aGFyIEFuc2FyaSIsImVtYWlsIjoibWF6aGFyQGdtYWlsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY4MDk2NzU0MCwiZXhwIjoxNjgwOTY3NjYwfQ.DJ2IWVMQ3kaM9byXqyOM4RRlS9JXC_yiLIEw4JvO-ig'),(225,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWFkbmkgQW5zYXJpIiwiZW1haWwiOiJtYWRuaUBnbWFpbC5jb20iLCJyb2xlX2lkIjoyLCJpYXQiOjE2ODA5Njc1NjUsImV4cCI6MTY4MDk2NzY4NX0.pqIOIaI6oM9J82Y4wYC5wYbXcA5yJvz-LazoEnk0WYU'),(226,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWFkbmkgQW5zYXJpIiwiZW1haWwiOiJtYWRuaUBnbWFpbC5jb20iLCJyb2xlX2lkIjoyLCJpYXQiOjE2ODEwMzA1NjgsImV4cCI6MTY4MTAzMDY4OH0.KqtXglNJRjyGHAW09bJCVg0dtUs5_-Sx9WCxWObfZLs'),(227,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWF6aGFyIEFuc2FyaSIsImVtYWlsIjoibWF6aGFyQGdtYWlsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY4MTMxODU2NSwiZXhwIjoxNjgxMzE4Njg1fQ.d-y3XEaLENPGlnJBtQQmG9sAb9Ew8eFCAPbRyCbXGKY'),(228,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTW9oYW1lZCBBcmliIiwiZW1haWwiOiJhcmliQGdtYWlsLmNvbSIsInJvbGVfaWQiOjMsImlhdCI6MTY4MTMxODU4MSwiZXhwIjoxNjgxMzE4NzAxfQ.JVSuaf2IxMT0ccjZed7__Cph-GcVJNPf4m39fXgxndg'),(229,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWF6aGFyIEFuc2FyaSIsImVtYWlsIjoibWF6aGFyQGdtYWlsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY4MTMyMDc4NywiZXhwIjoxNjgxMzIwOTA3fQ.25hWncXetkgkUTgjg_MLsaOUk31HfUTivVUs9Qw4MnE'),(230,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTW9oYW1lZCBBcmliIiwiZW1haWwiOiJhcmliQGdtYWlsLmNvbSIsInJvbGVfaWQiOjMsImlhdCI6MTY4MTMyMDc5NywiZXhwIjoxNjgxMzIwOTE3fQ.ETgbjYYvUs2mp8KUhfabZzbKifE6AunuIQpnQVVBGig'),(231,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWFkbmkgQW5zYXJpIiwiZW1haWwiOiJtYWRuaUBnbWFpbC5jb20iLCJyb2xlX2lkIjoyLCJpYXQiOjE2ODEzMjE1NjYsImV4cCI6MTY4MTMyMTY4Nn0.d0xcsxJB9dYRdujhBJr1ZxLkZVERgSWFPc5-ThY4atw'),(232,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWFkbmkgQW5zYXJpIiwiZW1haWwiOiJtYWRuaUBnbWFpbC5jb20iLCJyb2xlX2lkIjoyLCJpYXQiOjE2ODE0ODkxNTIsImV4cCI6MTY4MTQ4OTI3Mn0.3glABsKg0kf8L-aSZ74V_RUjXzkLeF-V2ESFp6tMGTk'),(233,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTW9oYW1lZCBBcmliIiwiZW1haWwiOiJhcmliQGdtYWlsLmNvbSIsInJvbGVfaWQiOjMsImlhdCI6MTY4MTQ4OTE3OCwiZXhwIjoxNjgxNDg5Mjk4fQ.Ge30-xeJcUHfDaZaAz0AjLDIsH6Y0WBQJ9KVca9FsKk'),(234,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWF6aGFyIEFuc2FyaSIsImVtYWlsIjoibWF6aGFyQGdtYWlsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY4MTQ4OTIxMSwiZXhwIjoxNjgxNDg5MzMxfQ.uWoiSrQuBtkKBnSP7VNdOlgSHvrBAi8Fl4NFARaHCzM'),(235,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiS2FyaW0gQmVuemVtYSIsImVtYWlsIjoia2FyaW1AZ21haWwuY29tIiwicm9sZV9pZCI6MSwiaWF0IjoxNjgxNDg5ODQxLCJleHAiOjE2ODE0ODk5NjF9.8jNQmNVdiX9spUiPzkYZmFzCIwRBcoWZa_RxfghsUrU'),(236,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWFkbmkgQW5zYXJpIiwiZW1haWwiOiJtYWRuaUBnbWFpbC5jb20iLCJyb2xlX2lkIjoyLCJpYXQiOjE2ODM0NjgzMTIsImV4cCI6MTY4MzQ2ODQzMn0.rMM1IkUuDl5HdLLXVyjTddivoWAvS0sUL647dIJG71A'),(237,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWF6aGFyIEFuc2FyaSIsImVtYWlsIjoibWF6aGFyQGdtYWlsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY4MzQ2ODQ2MiwiZXhwIjoxNjgzNDY4NTgyfQ.FTV4O98iFUFczqMG7YhLRzT3sj4LddqRuvvk6fEZwHA'),(238,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiS2FyaW0gQmVuemVtYSIsImVtYWlsIjoia2FyaW1AZ21haWwuY29tIiwicm9sZV9pZCI6MSwiaWF0IjoxNjgzNDY4NDc4LCJleHAiOjE2ODM0Njg1OTh9.eeimGm_B5EnclV4ftnVwrQGLqrU1FgaBq5eI1uwitcU'),(239,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWF6aGFyIEFuc2FyaSIsImVtYWlsIjoibWF6aGFyQGdtYWlsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY4MzQ2OTc2NSwiZXhwIjoxNjgzNDY5ODg1fQ.MsQutijqDXbl8IoTdugSRaoOMEd7PrzVH6K42hTGMCU'),(240,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWF6aGFyIEFuc2FyaSIsImVtYWlsIjoibWF6aGFyQGdtYWlsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY4MzQ3MDUxOSwiZXhwIjoxNjgzNDcwNjM5fQ.PMFTH1a2NWIAQcylPfOdL-HwDybt0vAN4JQcaAO9nN4'),(241,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWF6aGFyIEFuc2FyaSIsImVtYWlsIjoibWF6aGFyQGdtYWlsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY4MzQ3MDYyNSwiZXhwIjoxNjgzNDcwNzQ1fQ.WZ6Zyhc-4BEfVKlG70pA3W1_5GMm6td9dL1TViRxoEQ'),(242,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiS2FyaW0gQmVuemVtYSIsImVtYWlsIjoia2FyaW1AZ21haWwuY29tIiwicm9sZV9pZCI6MSwiaWF0IjoxNjgzNDcxMDQyLCJleHAiOjE2ODM0NzExNjJ9.UrAvVlDrT9Bm9j5v30FMfRjI7drXWBhvxT4dQEuouVQ'),(243,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWFkbmkgQW5zYXJpIiwiZW1haWwiOiJtYWRuaUBnbWFpbC5jb20iLCJyb2xlX2lkIjoyLCJpYXQiOjE2ODM0ODM3MDgsImV4cCI6MTY4MzQ4MzgyOH0.2Km5B07gV6k4_bDb9NAn3RBSHIewopGSCknoQYABvFo'),(244,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWFkbmkgQW5zYXJpIiwiZW1haWwiOiJtYWRuaUBnbWFpbC5jb20iLCJyb2xlX2lkIjoyLCJpYXQiOjE2ODM0ODQxNTcsImV4cCI6MTY4MzQ4NDI3N30.56qqiWh5RUDz6s7ntPon-HvzmmnDT0UAapyBP0goEKA'),(245,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWFkbmkgQW5zYXJpIiwiZW1haWwiOiJtYWRuaUBnbWFpbC5jb20iLCJyb2xlX2lkIjoyLCJpYXQiOjE2ODM1MjY0MzksImV4cCI6MTY4MzUyNjU1OX0.2MgcoloFFNhfE6ZTIdIm4hAooeCL8q_9jwkMxUvgMPw'),(246,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWF6aGFyIEFuc2FyaSIsImVtYWlsIjoibWF6aGFyQGdtYWlsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY4MzUyNjgyNSwiZXhwIjoxNjgzNTI2OTQ1fQ.lC_t0Xgm43oNlyCML3uk6OkG8qKEfA1fyQ0nEm9w5UA'),(247,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiS2FyaW0gQmVuemVtYSIsImVtYWlsIjoia2FyaW1AZ21haWwuY29tIiwicm9sZV9pZCI6MSwiaWF0IjoxNjgzNTI3NTUzLCJleHAiOjE2ODM1Mjc2NzN9.VEVujY4CnoTQbMbW9AaPZxKcEt_cgKCGTsUjtQruO_g'),(248,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWF6aGFyIEFuc2FyaSIsImVtYWlsIjoibWF6aGFyQGdtYWlsLmNvbSIsInJvbGVfaWQiOjEsImlhdCI6MTY4MzUyNzgzNCwiZXhwIjoxNjgzNTI3OTU0fQ.e0xNYAqgLAhq5lA6obyZsYw1Xx6xcofrERTAGIpAIsM'),(249,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiTWFkbmkgQW5zYXJpIiwiZW1haWwiOiJtYWRuaUBnbWFpbC5jb20iLCJyb2xlX2lkIjoyLCJpYXQiOjE2ODM1Mjc4ODIsImV4cCI6MTY4MzUyODAwMn0.wzcB7vZlPWyeQJGPKicO2UB2H7y0wJpx3lSejPru2uU'),(250,'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lIjoiS2FyaW0gQmVuemVtYSIsImVtYWlsIjoia2FyaW1AZ21haWwuY29tIiwicm9sZV9pZCI6MSwiaWF0IjoxNjgzNTI4MTQ5LCJleHAiOjE2ODM1MjgyNjl9.f-4VE-T9x56GM-s0f39krK90MZeUJV6q_2ajhIP6BUs');
/*!40000 ALTER TABLE `refresh_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `role_id` int NOT NULL AUTO_INCREMENT,
  `role` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'needy'),(2,'donor'),(3,'admin');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saved`
--

DROP TABLE IF EXISTS `saved`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `saved` (
  `saved_id` int NOT NULL AUTO_INCREMENT,
  `item_id` int NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`saved_id`),
  KEY `saved_item_FK_idx` (`item_id`),
  KEY `saved_user_FK_idx` (`user_id`),
  CONSTRAINT `saved_item_FK` FOREIGN KEY (`item_id`) REFERENCES `item` (`item_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `saved_user_FK` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saved`
--

LOCK TABLES `saved` WRITE;
/*!40000 ALTER TABLE `saved` DISABLE KEYS */;
/*!40000 ALTER TABLE `saved` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `email` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `phone` varchar(13) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `address` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `role_id` int NOT NULL,
  `isActive` tinyint(1) NOT NULL,
  `registrationTimeStamp` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `profilePictureSrc` varchar(500) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  KEY `user_role_FK_idx` (`role_id`),
  CONSTRAINT `user_role_FK` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Mohamed Arib','$2b$10$WsgEtt026XhCH9EwkEZ66eZI0gBbddZgSuZjDI44ugImMU7Y0CV/a','arib@gmail.com','8451066399','Byculla, Mumbai - 400008',3,1,'2023-02-06 11:37:14','uploads/profilePictures/1bf756d2-2029-46d3-8dce-8f0fdb9e1b78-wersm-twitter-expands-testing-of-nft-profile-pictures-feature.jpg'),(2,'Shazli Ansari','$2b$10$f3c0Nnr3HQrizE6NjizIy.A6ufRAEvkZsu/z7hKTvQespRN8ynPTS','shazli@gmail.com','9967203221','Tokyo, Japan - 990912',2,0,'2023-02-04 11:37:14',NULL),(11,'Pablo Gavi','$2b$10$0gV0NR2zor1Flb9q9nPVc.8o3uzOxZuxEEtpUAxTUOXY.KuvNrTge','gavi@gmail.com','8745899965','Barcelona, Spain',2,1,'2023-01-13 11:38:57','uploads/profilePictures/2e260904-baf6-41e4-b420-1b52486ba024-gavi_o7y5l187qk2u1tlfdca7oguoa.jpg'),(14,'Madni Ansari','$2b$10$iekV5/ejVa6w6YnLzcw1qOxzTBSEuoHRzYnZXOdiBaX7UjbjBOq.S','madni@gmail.com','8784569885','Mumbai, India',2,1,'2023-02-07 14:22:22','uploads/profilePictures/74dedbb8-b462-4178-a05b-6c0edc0c9f38-FjU2lkcWYAgNG6d.jpg'),(20,'Mazhar Ansari','$2b$10$Z9gM7HWa6TeiBHemVKtZ8.QChlzC01ZDR1qdhVVvpOVxjbrIV5nG.','mazhar@gmail.com','7845796584','Noorani chawl, Byculla , Mumbai - 400008',1,1,'2023-04-12 17:32:57',NULL),(21,'Karim Benzema','$2b$10$xy3yEx/83wN63kkVt1rjwe4sEAwqr1gUTEUmD60C5TOp0DddoKBUi','karim@gmail.com','4456589745','Lyon, France',1,1,'2023-04-12 17:42:47',NULL);
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

-- Dump completed on 2023-05-08 12:49:24
