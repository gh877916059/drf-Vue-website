-- MySQL dump 10.13  Distrib 5.7.20, for Win64 (x86_64)
--
-- Host: localhost    Database: APP_Inventor_case_base
-- ------------------------------------------------------
-- Server version	5.7.20-log

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can view group',2,'view_group'),(8,'Can view permission',1,'view_permission'),(9,'Can add content type',3,'add_contenttype'),(10,'Can change content type',3,'change_contenttype'),(11,'Can delete content type',3,'delete_contenttype'),(12,'Can view content type',3,'view_contenttype'),(13,'Can add session',4,'add_session'),(14,'Can change session',4,'change_session'),(15,'Can delete session',4,'delete_session'),(16,'Can view session',4,'view_session'),(17,'Can add 用户',5,'add_userprofile'),(18,'Can change 用户',5,'change_userprofile'),(19,'Can delete 用户',5,'delete_userprofile'),(20,'Can add 短信验证码',6,'add_verifycode'),(21,'Can change 短信验证码',6,'change_verifycode'),(22,'Can delete 短信验证码',6,'delete_verifycode'),(23,'Can view 用户',5,'view_userprofile'),(24,'Can view 短信验证码',6,'view_verifycode'),(25,'Can add 轮播案例',7,'add_banner'),(26,'Can change 轮播案例',7,'change_banner'),(27,'Can delete 轮播案例',7,'delete_banner'),(28,'Can add 案例',8,'add_cases'),(29,'Can change 案例',8,'change_cases'),(30,'Can delete 案例',8,'delete_cases'),(31,'Can add 案例类别',9,'add_casescategory'),(32,'Can change 案例类别',9,'change_casescategory'),(33,'Can delete 案例类别',9,'delete_casescategory'),(34,'Can add 案例图片',10,'add_casesimage'),(35,'Can change 案例图片',10,'change_casesimage'),(36,'Can delete 案例图片',10,'delete_casesimage'),(37,'Can add 热搜词',11,'add_hotsearchwords'),(38,'Can change 热搜词',11,'change_hotsearchwords'),(39,'Can delete 热搜词',11,'delete_hotsearchwords'),(40,'Can add 首页案例类别广告',12,'add_indexad'),(41,'Can change 首页案例类别广告',12,'change_indexad'),(42,'Can delete 首页案例类别广告',12,'delete_indexad'),(43,'Can view 轮播案例',7,'view_banner'),(44,'Can view 案例',8,'view_cases'),(45,'Can view 案例类别',9,'view_casescategory'),(46,'Can view 案例图片',10,'view_casesimage'),(47,'Can view 热搜词',11,'view_hotsearchwords'),(48,'Can view 首页案例类别广告',12,'view_indexad'),(49,'Can add 用户收藏',13,'add_userfav'),(50,'Can change 用户收藏',13,'change_userfav'),(51,'Can delete 用户收藏',13,'delete_userfav'),(52,'Can add 用户留言',14,'add_userleavingmessage'),(53,'Can change 用户留言',14,'change_userleavingmessage'),(54,'Can delete 用户留言',14,'delete_userleavingmessage'),(55,'Can view 用户收藏',13,'view_userfav'),(56,'Can view 用户留言',14,'view_userleavingmessage'),(57,'Can add Bookmark',15,'add_bookmark'),(58,'Can change Bookmark',15,'change_bookmark'),(59,'Can delete Bookmark',15,'delete_bookmark'),(60,'Can add log entry',16,'add_log'),(61,'Can change log entry',16,'change_log'),(62,'Can delete log entry',16,'delete_log'),(63,'Can add User Setting',17,'add_usersettings'),(64,'Can change User Setting',17,'change_usersettings'),(65,'Can delete User Setting',17,'delete_usersettings'),(66,'Can add User Widget',18,'add_userwidget'),(67,'Can change User Widget',18,'change_userwidget'),(68,'Can delete User Widget',18,'delete_userwidget'),(69,'Can view Bookmark',15,'view_bookmark'),(70,'Can view log entry',16,'view_log'),(71,'Can view User Setting',17,'view_usersettings'),(72,'Can view User Widget',18,'view_userwidget'),(73,'Can add Token',19,'add_token'),(74,'Can change Token',19,'change_token'),(75,'Can delete Token',19,'delete_token'),(76,'Can view Token',19,'view_token'),(77,'Can view 短信验证码',6,'view_smsverifycode'),(78,'Can add 短信验证码',6,'add_smsverifycode'),(79,'Can change 短信验证码',6,'change_smsverifycode'),(80,'Can delete 短信验证码',6,'delete_smsverifycode'),(81,'Can add captcha store',20,'add_captchastore'),(82,'Can change captcha store',20,'change_captchastore'),(83,'Can delete captcha store',20,'delete_captchastore'),(84,'Can view captcha store',20,'view_captchastore');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `authtoken_token`
--

DROP TABLE IF EXISTS `authtoken_token`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `authtoken_token` (
  `key` varchar(40) NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_users_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `users_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authtoken_token`
--

LOCK TABLES `authtoken_token` WRITE;
/*!40000 ALTER TABLE `authtoken_token` DISABLE KEYS */;
/*!40000 ALTER TABLE `authtoken_token` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `captcha_captchastore`
--

DROP TABLE IF EXISTS `captcha_captchastore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `captcha_captchastore` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `challenge` varchar(32) NOT NULL,
  `response` varchar(32) NOT NULL,
  `hashkey` varchar(40) NOT NULL,
  `expiration` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `hashkey` (`hashkey`)
) ENGINE=InnoDB AUTO_INCREMENT=321 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `captcha_captchastore`
--

LOCK TABLES `captcha_captchastore` WRITE;
/*!40000 ALTER TABLE `captcha_captchastore` DISABLE KEYS */;
INSERT INTO `captcha_captchastore` VALUES (6,'GZVE','gzve','2714e8b198f2f331129536b095e69d90466d2a9e','2017-11-12 13:48:46.309516'),(7,'PVNV','pvnv','81d5c25ad1014981646b8414bd7116b33d7096c3','2017-11-12 13:49:42.620388'),(8,'HKDP','hkdp','04f5bd4ad717f1f4d4961ee8d5c79afa37652a3c','2017-11-12 13:50:41.631458'),(9,'RLTE','rlte','744fd6f92a128e8dc86b9a42f6c9c86f868c4aaf','2017-11-12 13:51:52.869689'),(10,'OLWP','olwp','692c445e4a9bd0df4c8dbe04c63733dfd6d67201','2017-11-12 13:52:43.548286'),(11,'EAOJ','eaoj','249568a29666a22615c0488b63827f840ac0cf1e','2017-11-12 13:53:28.589565'),(12,'ERBY','erby','ebb37f433e13be6fb5188b89324ea088e28d50d6','2017-11-12 13:53:36.236530'),(13,'EVWY','evwy','8055272f8e09093eab7796efc6b1ef01c77f3d84','2017-11-12 13:53:41.674465'),(14,'OEGA','oega','e013b9097d96e55918d7fdfebb1dd864f201ca25','2017-11-12 13:56:56.438844'),(15,'HAGF','hagf','d3e41e7be3258624c5aaa6609ba6cc574e21d77e','2017-11-12 13:57:02.043713'),(16,'ZLOF','zlof','bdbc1ee4c283197923326a0ff1b24e2768a6db30','2017-11-12 13:57:05.864923'),(17,'TYYT','tyyt','6567cad9c954967fc6b98280930c0f34760cb4e5','2017-11-12 13:57:10.466128'),(18,'AYMO','aymo','b360b2bb05ab5f6c3f702f58cdb284e64db52d1a','2017-11-12 13:59:09.888520'),(19,'WXDM','wxdm','ed20813ea19312c70c3ca28fde8ac448afd16aca','2017-11-12 13:59:35.629636'),(20,'PEKN','pekn','274eed2300716fff5cd49b3477a5b2287ce46d7c','2017-11-12 14:00:21.216088'),(21,'ABML','abml','d4ab41c92b572f6318670c7eb77fbee5847c1bf8','2017-11-12 14:00:35.789580'),(22,'WSDN','wsdn','68569da8471d41c9a456118baafd66e462b67633','2017-11-12 14:02:14.591373'),(23,'JVJK','jvjk','6ee506e3ca7b71b7d2821bd9b36e26ebe0d34bb1','2017-11-12 14:02:18.164647'),(24,'NBNL','nbnl','f480a31986d533b2c293d5f9da55718737c5bdba','2017-11-12 14:03:01.208562'),(25,'YOWO','yowo','4fbaf8eaa932e683290518c356fb9d27768f889a','2017-11-12 14:05:42.534280'),(26,'NZNM','nznm','3f4b2bb5b8d783bfc90cc0ea0c4365021893b075','2017-11-12 14:08:47.115971'),(27,'RMUS','rmus','2e4e7532e51e7e58611c8723f80a91da9b77563f','2017-11-12 14:08:55.170569'),(28,'NMGT','nmgt','8a04a08a6e71188d6bcf068c48684a9f25a86cf8','2017-11-12 14:16:54.146194'),(29,'DQJJ','dqjj','20973ed3f9a0fe7ebd07c08f54cf2045ad79fd0c','2017-11-12 14:24:04.978345'),(30,'XCDQ','xcdq','a0dd4faada2bdcb8cea4d2d4dcbdc835e1859d0f','2017-11-12 14:25:43.328464'),(31,'PHOE','phoe','d1de6b0afaa512eddf0d60a6fb430bcfe94e9b5d','2017-11-12 14:26:06.931241'),(32,'IUMS','iums','4851bc516eb1559c42f3b1bdd02c1ebf8e0f2e38','2017-11-12 14:26:48.996495'),(33,'IRFG','irfg','97a9e3077fc6d4f3bc258f2c6899ecbb3737ded6','2017-11-12 14:27:38.945840'),(34,'LRIC','lric','d0080947119748f3a6b5e5691da5678c4d1250bd','2017-11-12 14:28:24.505163'),(35,'JPJG','jpjg','e012bec89b91b870dd27e8f7bb807724231da74e','2017-11-12 14:28:26.553339'),(36,'ARIZ','ariz','740d29a62e92eae455654454a678ffba14a93d04','2017-11-12 14:32:03.236660'),(37,'NGBE','ngbe','98d9f7e2ead6218493d3848241875d9e63eb0a4d','2017-11-12 14:37:10.210915'),(38,'TRVB','trvb','a3594aa8f41ce39087740d6fd7801ef4c2ac1542','2017-11-12 14:38:05.390287'),(39,'DDYK','ddyk','bd5c88aace99175bfb316dd0377c081a02631e76','2017-11-12 14:38:17.747419'),(40,'FFKT','ffkt','3eba9ba06e106d0ed3778c9cbc74fa75782645e9','2017-11-12 14:48:05.686462'),(41,'MRYV','mryv','50cc4fbd3df979e7105488df461908d83060b26a','2017-11-12 14:50:24.656701'),(42,'NVEL','nvel','361a70f7764b73cdf66040ca6382236370cd2f91','2017-11-12 14:50:24.830255'),(43,'XLOO','xloo','fe31b1a884e10478815cf505144a4520da78fc59','2017-11-12 14:50:24.999300'),(44,'MGJZ','mgjz','6ff4354306aafb494172d64c811a87a0b5de57d7','2017-11-12 14:50:25.461990'),(46,'UDJE','udje','923c0ecc4496bcf92d1606acddcf7536115c582d','2017-11-12 15:05:45.585545'),(47,'HSAL','hsal','a2c7b73f17530e4dd52249e8415e46554aadc59a','2017-11-12 15:12:57.489443'),(48,'HJHA','hjha','159cb9cd93e3d8c4a43b8ebcd1d6d04132aea82c','2017-11-12 15:16:38.499100'),(49,'XDIU','xdiu','28506f96e267dd781a578b5dc98d965fd599058c','2017-11-12 15:16:44.292803'),(50,'MOEZ','moez','f9a92f525abd5516f490d084f4339dcd3f9defb6','2017-11-12 15:18:21.938632'),(51,'DLNL','dlnl','cb14cac57511511a63506ebeaf28bfc71c40732f','2017-11-12 15:32:38.020256'),(52,'UULZ','uulz','f01e78f7f5560c55fc4960f1d014104367b1194d','2017-11-12 15:36:16.716824'),(53,'AOVJ','aovj','0488b28fc04033735d6041953b91aa00de8c58cc','2017-11-12 15:36:41.102821'),(54,'SWQH','swqh','ec952008b7341a2d7a63e3f441d115061d35c639','2017-11-12 15:38:56.768596'),(55,'MZVH','mzvh','4eb7214d20290a8e39e2850a07457d18a7ef5ade','2017-11-12 15:39:08.597611'),(56,'YUXR','yuxr','b809401c7f5857e7f4e6dcb5469a74f8a393c89b','2017-11-12 15:43:12.436691'),(57,'IKOV','ikov','92ea3084d073d19f1e3c6b133864cb8e1a13fa5e','2017-11-12 15:46:57.936183'),(58,'IVZO','ivzo','1d6967439bd3535d2d82675ba176c8900e123ab9','2017-11-12 15:56:01.898685'),(59,'AVAT','avat','0b0a3ac0ce85526117dc3f8efa60a39151ac279a','2017-11-12 15:56:12.327718'),(61,'IJVB','ijvb','fcfb764471f8d852ae3eccf8b77f38530c9b700b','2017-11-12 16:02:31.023748'),(62,'ERUX','erux','0215b045a682261890f2c897ace47551bc31c936','2017-11-12 16:02:49.781441'),(63,'HSGZ','hsgz','6caa4125891ba7a6f3d43b2be66c518b557b91c7','2017-11-12 16:04:15.930195'),(64,'KQLV','kqlv','9c830941d85c5413b8b45fbbab02c751afa1ef52','2017-11-12 16:05:00.898117'),(67,'BRYU','bryu','338f10e1b99d012a017d1c97f34633434a9dcd4e','2017-11-12 16:24:00.605159'),(70,'FDBN','fdbn','214af18ed1df7c3112c49edeba4b8f7a4a50ffd3','2017-11-12 17:58:42.341227'),(71,'XGWY','xgwy','509b1afc26f8b5be4020ca10eb2328870205a234','2017-11-13 12:34:00.077763'),(72,'AJID','ajid','3e27256ea38e43f2fc8cdd07ae682db1abecd390','2017-11-13 12:43:56.951480'),(73,'SMQR','smqr','e9b27716708f187723c67847fb861592f1274052','2017-11-13 12:45:13.629160'),(74,'DHYR','dhyr','29d54a5c22395d523d0196190697d8a9d172f8fe','2017-11-13 13:00:12.110968'),(75,'DTHZ','dthz','2292566fe09f83573f777f67f7fb3083ea6d2419','2017-11-13 13:03:22.471828'),(76,'LFFX','lffx','e630641dfb2b8e52047ffb337cacc1a8e3bda714','2017-11-13 13:19:18.623822'),(77,'HWCR','hwcr','bc82a516ad0065282c5bf26464110f2a46009091','2017-11-13 13:19:24.125031'),(78,'ZJNH','zjnh','1e645010ebb86b9ea822804691a1d9b420facb46','2017-11-13 13:20:05.022314'),(79,'SWQI','swqi','9d45b4404a8ae012dca69ec7770150b99addba7f','2017-11-13 13:20:09.448252'),(80,'JPPE','jppe','c1fb51f68e7eb24456ec21513579ab5c9274efb2','2017-11-13 13:20:36.486494'),(81,'KDWL','kdwl','f310750853437e961a5aac9cfc9e7e901cb6c2d8','2017-11-13 13:30:24.073356'),(82,'YJSE','yjse','7caba43fe71b3c7a6b3c95188345fdbe492ceee1','2017-11-13 13:31:13.231008'),(83,'ETMY','etmy','0713fa0f8f879e7979ed6eb1bb8cd94163da14b2','2017-11-13 13:32:07.551934'),(84,'KABA','kaba','5aefb731ef21ad14515d6c4471558bfc6aadcb15','2017-11-13 13:32:14.128332'),(85,'GSKN','gskn','c7692707e6ff8198303bbb88872d8d7005f35a92','2017-11-13 13:32:58.074856'),(86,'HNYR','hnyr','d5bc7f77becbad3cb5c7d523357c1aafa71c73a5','2017-11-13 13:40:03.806032'),(87,'EUCC','eucc','3b64be7ca984e59741394be4e2efab09aaa76761','2017-11-13 13:41:12.121536'),(88,'JFJG','jfjg','f6230ea105986cc9aacdb6ec8fe105fb333e7401','2017-11-13 13:42:09.937364'),(89,'BLOO','bloo','d11fd7d7246690d1c3794274464b229806631aec','2017-11-13 13:42:34.223624'),(91,'JGKI','jgki','dcf7b59310c68d1da61abacc99e58743ae67cd1f','2017-11-13 13:48:15.575456'),(92,'GXRD','gxrd','588aefbf3e505c035ce85848ddd45f1cc0c34493','2017-11-13 13:50:13.392000'),(93,'GFYI','gfyi','5b921f72d90e8cc4b35564e969e94efb0151fb21','2017-11-13 13:54:08.506827'),(94,'FJXU','fjxu','a99a017259dd847827fe033112adaf1fc73f124c','2017-11-13 13:54:18.770216'),(104,'TJFN','tjfn','cd254a4e3b6b084df6292d852e76ee8781879eb1','2017-11-13 14:34:40.085823'),(106,'OINH','oinh','51ca9baf358d2bbf920b1bdebfbddc17c43bf7e2','2017-11-13 14:36:29.157639'),(107,'KWMP','kwmp','40b429a3e9e57d770bc04bfbb4aeae5b3e7137d2','2017-11-13 14:37:29.592458'),(110,'BOJI','boji','3a2cb4b71121d957c46c26fd6850e358358882c9','2017-11-13 14:39:36.424747'),(111,'XVLN','xvln','f3a112385cd69c0f15abbc2f60fac28ac85774ff','2017-11-13 14:41:15.485473'),(112,'YXYA','yxya','48b96cb36bab272881b7c1d0c7aab9d64b1cf7ad','2017-11-13 14:41:21.710352'),(113,'XOTI','xoti','444e774f7dc061192e811180fc7bef8564bc0ea4','2017-11-13 14:41:27.217133'),(115,'AQGJ','aqgj','2990a7cb1b530eb37d363a5cca4a246fff2d3f3a','2017-11-13 14:42:37.597535'),(117,'RWSJ','rwsj','f0464e63748039fa272e6be74324c2e67abdb297','2017-11-13 14:43:38.835516'),(119,'ZWXK','zwxk','8cf52077964a046b6ea4f224ba3e66c63e05e305','2017-11-13 14:46:45.595695'),(120,'IVAE','ivae','84ea457906a6704572c8dd37443c3d7be60c9c2a','2017-11-13 20:40:10.362199'),(121,'MJTS','mjts','a8835342ffe5b5dd9dc249de257a69d6b1ccb3b2','2017-11-13 20:42:51.183172'),(122,'NPDE','npde','9e1ff0306e4570b95ca097134655cf0ed0c366e4','2017-11-13 20:43:12.204339'),(123,'MWFW','mwfw','48af637b8b7208482b14d55c50571428170b5388','2017-11-13 21:17:31.170784'),(124,'SSWB','sswb','a386993751e54f46df00c32eb01f0e849058e692','2017-11-13 21:25:59.917636'),(125,'EMYY','emyy','e41002cec759b0e1c7ebbb3ebd0cc0ef32a3b4f4','2017-11-13 21:26:34.744804'),(126,'WSSK','wssk','1e1bb7138a29985ec6f752c01e460f6cc8cefb32','2017-11-13 21:27:13.483794'),(128,'LBNU','lbnu','b7eb164a22bcc2635a72ebdba38cb764f401cd21','2017-11-13 21:27:51.655207'),(130,'PFUM','pfum','9bda5cf1cec66c95671ac8f56b24274ecccc37a9','2017-11-13 21:46:38.008979'),(131,'LGSS','lgss','adeebe0eb1784663391b4ae99d0a03701e2ae239','2017-11-13 21:46:51.188904'),(132,'LEWS','lews','bf5691da5f365ba7ca55f853211990a69dd89fc3','2017-11-13 21:51:20.786905'),(133,'MZXD','mzxd','47d4cd5cde9142ef5f841a7716e8bacdb5fec4d0','2017-11-13 21:51:26.905729'),(134,'AGTN','agtn','638312aab40891f8f6b876dc452e25300e04bded','2017-11-13 21:51:32.432806'),(135,'LWOR','lwor','dd5b9873f8aa7dadb445aa0b4988024ee3b8e320','2017-11-13 21:51:38.042060'),(136,'JSMY','jsmy','7f231593b7e784da12ff15a2febd6b08232e2be3','2017-11-14 12:46:54.870108'),(137,'BMOE','bmoe','91cdd3f675b082b9cefc0ed278e78e01d492c649','2017-11-14 12:51:28.374021'),(138,'OTWF','otwf','360d504526b82ef7eefb2525012511048625c8a3','2017-11-16 20:17:13.132344'),(140,'LVUZ','lvuz','68548de25d76d3b2ca089f7f09771226fa6d8aec','2017-11-16 20:22:14.092156'),(142,'ZKCZ','zkcz','35263f3bd2d730034529a209dcfb809a08777c4e','2017-11-16 20:30:38.055641'),(143,'KURO','kuro','2d6481bca03541c31ffe0b2de40ee0d9067e2fd8','2017-11-16 20:32:07.575508'),(144,'LSTO','lsto','3c3b027f555b3be4aaa4b51bc064ba3f4e61cd69','2017-11-16 20:33:37.685223'),(145,'SVLM','svlm','717a2ea9a7c2be1204cd29f3a60de02c68f065ec','2017-11-16 21:20:12.112563'),(146,'SCKK','sckk','6a6ab7d3393e2c1a428ece27125133a4698e761f','2017-11-16 21:21:21.444715'),(147,'GNBS','gnbs','ac0f8618b632705581f09e8f72298834322db06a','2017-11-16 21:22:54.888131'),(148,'BQNO','bqno','03c31ae6ff807e928f46499db6d8c212a60dbbd3','2017-11-16 21:24:55.914442'),(149,'GZZC','gzzc','974510c06e20cbb7405589bf6e65faa39ae8dc22','2017-11-16 21:25:55.945237'),(150,'YGQQ','ygqq','79cb75b48b9f754915f30d490ae12f0dfcc18d11','2017-11-16 21:26:45.097112'),(151,'LIIN','liin','f5fa239979332668983118106dadf328492c40b1','2017-11-16 21:30:24.470998'),(152,'DEVS','devs','ec13b56f1a0324e3d1e349150b12cd030d7638b3','2017-11-16 21:31:25.829516'),(153,'HSIQ','hsiq','6695ca9d2cf6903ef403eb02f7ec1540effb621f','2017-11-16 21:44:59.117189'),(154,'UQMR','uqmr','06445740159991eb989be5112bb81708118ae09d','2017-11-16 21:45:06.379455'),(155,'PPAJ','ppaj','0219c42c8e01a2be54374b8b690144a1224f84e9','2017-11-16 21:45:29.164930'),(156,'VXUP','vxup','d35c531d9ce708ea8bc2503ac91b42860ef9ec0b','2017-11-16 21:47:42.584197'),(157,'UCWW','ucww','c391f4b4bc87f8d2cd922e5653467d5ff0e95b74','2017-11-16 21:47:57.692505'),(158,'UBER','uber','61a958de6e7b3aafe74ac74617d6a72125f4b243','2017-11-16 21:49:52.251042'),(159,'ISVM','isvm','70c15d8f1ef505d217a4d193948f6793a8c0ea20','2017-11-16 21:50:08.320234'),(160,'FHXY','fhxy','a46d10aec3bbc10cb368f581e8557906aefa7891','2017-11-16 21:51:13.880263'),(161,'OHTN','ohtn','20c255c0a1dc4d7a0417a5f0a1f7d3df03e8afdd','2017-11-16 21:51:29.211070'),(162,'FALE','fale','01142f54d58b20e2ae5e91cdd033c9db24ef7b3e','2017-11-16 21:57:34.065357'),(163,'OYQF','oyqf','79b955ea26b99bb20a25dd13f15a78d57aabc257','2017-11-16 21:57:57.978430'),(164,'KIBU','kibu','bbe6243483305c8e66987de626447bd8cc40ef82','2017-11-16 21:58:13.882385'),(166,'MKIA','mkia','174c9d17c36f4018a902add21187a0c57453e1e3','2017-11-16 22:00:26.142085'),(168,'EQLR','eqlr','df8427802818db6b266b2f6673823eaffe3b2b59','2017-11-16 22:03:17.228966'),(171,'WAHQ','wahq','d538573d3f549c64822cb0eaaa6b5f655c3443f1','2017-11-16 22:07:52.620648'),(172,'DLLD','dlld','844ffb024b70b92f4bdb78d1135b61afad24b9ea','2017-11-16 22:13:54.929116'),(173,'LGMF','lgmf','143d46192aef0f30aeedf4b9eeced77f9d3521f7','2017-11-16 22:14:08.755519'),(174,'GCSI','gcsi','64cbbd1bd48dc0c126a6d6ad43f41c2821f4586b','2017-11-16 22:16:14.056086'),(175,'INSZ','insz','e226c03b0aedd45eeacc0b7cb0383631ac7d6d13','2017-11-16 22:21:36.322462'),(176,'UOTU','uotu','66562b8468054b3d584f8e74c18c97b4d36fa873','2017-11-16 22:22:25.215874'),(177,'HYWX','hywx','e74982550bcbc896538f96d078cea4941b60614f','2017-11-16 22:24:45.804494'),(178,'MHJZ','mhjz','590e83b6219cbe61d850eb172fb5b2ad6878eec7','2017-11-16 22:26:41.844600'),(179,'QBJF','qbjf','a39d02a61b7a380fec3758216b725d90d5dcac67','2017-11-16 22:27:01.923570'),(180,'ZOPC','zopc','fec17c8ef71a36ead500cfb641aa7025aeb4f0de','2017-11-16 22:28:46.735132'),(181,'XXDX','xxdx','a7701cd2087b3d85493043cfc2aaf6e242c2b73c','2017-11-16 22:30:23.166004'),(182,'UBFQ','ubfq','febd413fc3988bd80bc45768c2c61b1042ab7e30','2017-11-16 22:30:30.635676'),(183,'MSGT','msgt','6dd920b42610a7fccd661889a5f55b0860591656','2017-11-16 22:46:54.779116'),(184,'SMRT','smrt','eb70cf3a50bc0a7f55c7e122ded850f298a13649','2017-11-16 22:48:29.555080'),(185,'OBBX','obbx','3c834d5f93e1488d2ef74b9c6b6c637027b05178','2017-11-16 22:50:46.503276'),(186,'OFDH','ofdh','251b647fd0a0420b7198ab0672da304dd6504792','2017-11-16 22:51:49.963023'),(187,'LNAO','lnao','ac4a36f0392d34100c75a8e64a66ab529db9d18c','2017-11-16 22:55:09.320641'),(188,'MNDT','mndt','26f845e92f823de2b719bfaef6f73fc04d488530','2017-11-16 22:56:15.765132'),(189,'QFKU','qfku','33567e1fb8c7a8933be9a0e0b56579023671cfff','2017-11-16 22:57:38.595181'),(190,'FPEC','fpec','9cfd55bad93d1eaea42a65d63ee5086735563a4c','2017-11-16 22:58:54.936812'),(191,'SKIG','skig','1a1183492d23b5f56e98c4544b70506c90821a53','2017-11-16 23:01:05.003011'),(192,'DSPK','dspk','84a94c0fec88b7fde96d77df8185bdeba8005a91','2017-11-16 23:04:24.237029'),(193,'DHVC','dhvc','db62ae9f62009965f39aaa2f1acf844911c8105b','2017-11-16 23:08:01.672035'),(194,'HPWL','hpwl','810bb82a11f51bf8d454acbcbcf7b525d1fb2ad2','2017-11-16 23:10:35.973249'),(195,'WIXB','wixb','dcc4427d97fc4bf723da025b6f6f678403362e91','2017-11-16 23:11:34.189544'),(196,'YUVC','yuvc','45a964a3c05ec1549ed6ab8e7d35772dc601ce8f','2017-11-16 23:12:08.887741'),(197,'WBVR','wbvr','2a27ac05b76d3dfb9e7deefe3ef26771562b2e02','2017-11-16 23:13:23.529786'),(198,'JZIO','jzio','2600a2aea55e96eca7b035c2dacc371084381b5d','2017-11-16 23:16:10.005334'),(199,'JVBQ','jvbq','df7293803e8db780bf0af9e5e1f5e745eb927040','2017-11-16 23:18:43.878649'),(200,'KJJO','kjjo','34a9c79ba8056fe810693c07aa5e7f33da770401','2017-11-16 23:20:16.549342'),(201,'KMXP','kmxp','fcab3859552a81fe8509035b8634bf771aad5d09','2017-11-16 23:20:34.424751'),(202,'ATGS','atgs','76b9036cca7eb8ed768d4e7d014c0021e7dbb826','2017-11-16 23:21:41.401094'),(204,'CMDP','cmdp','93738055cdbdb96b263ad52d920a3d16234dea07','2017-11-16 23:45:45.782301'),(208,'UASP','uasp','ad04e36f6fbcdc550b7593784aa562e5e3364356','2017-11-17 00:07:00.443462'),(209,'PLML','plml','3d0979ad89fa61148484c9df7d14030509028a77','2017-11-23 13:48:32.925515'),(210,'EYFK','eyfk','0167ef82cb2f8631e0acf6303c2ba95853276778','2017-11-24 18:21:44.292287'),(211,'IIPV','iipv','a8f85bf11289e3a6c61d41e92812bebb8a87aebe','2017-11-24 18:22:09.825113'),(212,'RBZM','rbzm','fa77fb21063be4e8f4256f3d37ff5c76c308532a','2017-11-24 18:22:32.998927'),(213,'VDRW','vdrw','1959653271c882e715150f888272d82950ea674d','2017-11-24 19:04:23.307490'),(214,'XOWB','xowb','29d1d95f174d23b809741a0605cd7d9016639d22','2017-11-27 20:03:11.908508'),(215,'VCSR','vcsr','b8a36942deecd7f374bdadd5df80f4eaad419121','2017-11-27 20:03:43.950252'),(216,'ANGO','ango','a735bfc01d0c833725d41975103f9d95fff579cd','2017-12-03 13:10:12.429121'),(217,'RNQU','rnqu','02ac82b82562336a7c4769b4510cf5f33816c1f7','2017-12-03 13:13:06.461035'),(218,'YYRX','yyrx','67963ec98d74ab87cc45f6b5c7c87907d9807405','2017-12-03 13:14:26.160611'),(219,'FYLQ','fylq','febf876c4ad430eae1e4413c9364f855cb03f53b','2017-12-03 13:17:51.475662'),(220,'KJXP','kjxp','d84a8dd2cc335759f5c622b10cf1c8acff022155','2017-12-03 13:33:08.869102'),(221,'VFQO','vfqo','60a9b3543b8bf81925b066512484b156a432ec47','2017-12-03 13:34:10.036504'),(222,'UBUK','ubuk','ddf4b92b59b2d15e798ba43f06b1856a144bcc89','2017-12-03 13:43:35.154376'),(223,'DSHJ','dshj','c47313594f68441489c18d1345d00a7e87a87a6b','2017-12-03 13:44:27.130049'),(224,'YMEM','ymem','d7b93496da6b2070a41e3bf92023d09ab71db985','2017-12-03 13:45:22.123892'),(225,'WNGP','wngp','14b47fa0b6a42b40acbf34c4b18298e04529754d','2017-12-03 13:46:51.664204'),(226,'IAND','iand','0f086d5761bb27a8a903b11880c8c61494e64d2d','2017-12-03 13:47:00.704882'),(227,'GBXJ','gbxj','bcf5c5b788458b8951c7d0b440636177b5b340ae','2017-12-03 14:03:13.832760'),(228,'VWCQ','vwcq','adfaa0b631ff4bef5cae5eb302a3ff03f839a214','2017-12-03 14:04:13.793474'),(229,'TEVL','tevl','134344d0edb9a342465ea79075b1f955b898bbd0','2017-12-03 14:07:40.476321'),(230,'JUVY','juvy','9b800ea5dfdc7415e4724951ea108bd8830214e6','2017-12-03 14:08:08.973811'),(231,'LLPC','llpc','db241f08aae1c99b9e9a5ec5a84044b3913bfbf4','2017-12-03 14:08:45.616640'),(232,'QXEP','qxep','9e7abd0dcc0acc758f27166f13fa25b259610954','2017-12-03 14:09:23.100556'),(233,'XDUL','xdul','63a1b1efbbac9aea83ec9c2c9a8468f252fba4dd','2017-12-03 14:09:45.184307'),(234,'NVDK','nvdk','bec5794456bdb99c44e7366dd161ed3d669f8c00','2017-12-03 14:09:51.498827'),(235,'OOVE','oove','204e8bb18954b02f807b8fc482b58c1b6cdd5d1c','2017-12-03 14:10:33.550547'),(236,'VEXY','vexy','40162740d40cced4733d02fb6eee1c2cb709716b','2017-12-03 14:16:18.866221'),(237,'PKOE','pkoe','3dacadb771a471be3debf8d24eed46370b0b98b0','2017-12-03 14:16:38.231336'),(238,'GLFL','glfl','9def05b84d857ac07ccf86717735975e8ac46fe0','2017-12-03 14:20:17.429977'),(239,'SPGJ','spgj','81779a880ab3dea67581f936175e55bcff25b2c6','2017-12-03 14:21:14.968905'),(240,'EVJC','evjc','b824f905f57572c3cbc1d56286dcb6e339c49a6b','2017-12-03 14:22:41.133476'),(241,'SAOH','saoh','44f0838434daa1022f72538980812be3486ece0d','2017-12-03 14:24:26.431961'),(242,'UDGB','udgb','468a552ab75db46c8c5d49d4dda1fd444863605a','2017-12-03 14:27:31.071483'),(243,'ZXHG','zxhg','694f80c174e10c2b061bf6017d381727e299a5c3','2017-12-03 14:27:59.939971'),(244,'GGRI','ggri','8d737e8b47e7e80e65bd2dc5963150f38ede0466','2017-12-03 14:30:14.094387'),(245,'KMWZ','kmwz','18594435521145db98d86e680ccfa5a7eed8d583','2017-12-03 14:30:35.843169'),(246,'ZGKW','zgkw','c7ccce2ac8c2927caa62652345622d9d317c90c3','2017-12-03 14:31:12.342248'),(247,'FXWR','fxwr','03dd0f436b26566736bbebba3c49d8652f9716dd','2017-12-03 14:32:05.587782'),(248,'JSIA','jsia','3793533f61f8e89b60278d2b07f99294afb8c229','2017-12-03 14:33:42.320210'),(249,'EMLQ','emlq','b6c8b7e4ede33a2c1e079678c2834683d5a23414','2017-12-03 14:35:44.174398'),(250,'WJUO','wjuo','c4e1f46ea3bfea9a87d544e90aacc0e303e40ba9','2017-12-03 14:35:48.169489'),(251,'QXVB','qxvb','30033b3c905aaf7a18a6283940ba4bf3c70a9a38','2017-12-03 14:36:21.716417'),(252,'IPMY','ipmy','c96b965ef8f2468785ff2ad80443fab63fb55521','2017-12-03 14:36:55.840608'),(253,'CEHN','cehn','12ed551adaa15481b00ac39f16c9d28615aea421','2017-12-03 14:39:13.626795'),(254,'FVVD','fvvd','32ba6130bd45df96cca441c8405987f831082330','2017-12-03 14:39:40.534561'),(255,'OSDA','osda','5e20192d7182b656a882d31d49dfc4b3e24e004e','2017-12-03 14:45:14.271711'),(256,'GROB','grob','d2d777b7cae68c99f97edd9495e384596cea5c6a','2017-12-03 14:46:41.289072'),(257,'BZQL','bzql','37b1a1dd48222541b62d38e4c065b73b8a478cbc','2017-12-03 14:48:27.238918'),(258,'XRXP','xrxp','a31d8080dcbe4eac0419d0761715c8a91328f6a1','2017-12-03 14:51:59.916610'),(259,'AGXF','agxf','7aad58e6f20659fcc8e01ddc2fed6aa27c5bf2c6','2017-12-03 14:53:21.094123'),(260,'YQBS','yqbs','bcebee4454c09fff04565006fda46cfcbaff9c0a','2017-12-03 14:54:44.729815'),(261,'AECC','aecc','30f5eff2276ced4d003d6083aa993db602bcee7c','2017-12-03 15:02:58.539784'),(262,'LKES','lkes','bed57a29b9c3d1be5dbb492b4955b45f0dacdab1','2017-12-03 15:03:48.586092'),(263,'ULLF','ullf','103ea977d63e7e3fd1410ef5fe5d350246d165c8','2017-12-03 15:05:59.364172'),(264,'MWLL','mwll','a03545aa1f982f8c789ec3cae16c31ba0c67fa4c','2017-12-03 15:06:31.259295'),(265,'SYPA','sypa','47681c9d5382ed66f9158f4a78e828bdcc13a091','2017-12-03 15:06:51.851142'),(266,'WFQG','wfqg','b6b0f536bb29132e3356a69c4951f7af095b5b80','2017-12-03 15:07:34.571122'),(267,'UUXW','uuxw','eb84897c59f04b99d7d9f4c73d866fea126409e9','2017-12-03 15:07:58.849219'),(268,'QUKE','quke','14f07d385c02fd138bf9ad76b12c87f2703d3f52','2017-12-03 15:10:50.027121'),(269,'DMCK','dmck','79863a2ed69043f29014037be24e25160b2d2989','2017-12-03 15:11:40.263014'),(270,'WRHI','wrhi','e12062cbb01d1981b7fff01551b0fec7fb3a1b21','2017-12-03 15:12:05.141598'),(271,'NPCM','npcm','f7dea86593616e8a8dadfbd458797850a2303b06','2017-12-03 15:14:44.221687'),(272,'KRJC','krjc','eac4f427151106a172470c93275f86c2e5acabdf','2017-12-03 15:21:01.251900'),(273,'XJHL','xjhl','363cfbae9dccef2b16e1b0c0237a9eefb2e058a0','2017-12-03 15:22:09.386586'),(274,'YQQZ','yqqz','a869c6546151ed36ee4c1d7fff502dde8c2eb222','2017-12-03 15:24:53.804731'),(275,'WGUN','wgun','1953c03d8f91e64b46e95eef8c5f8bc0bba7b2dd','2017-12-03 15:27:54.878687'),(276,'RAUO','rauo','b0fc5217322395f4843608cf41453108e3c60503','2017-12-03 15:29:23.773384'),(277,'GYRI','gyri','7a225c26bc29886f0e06cf6d28112ca959cabe55','2017-12-03 15:31:43.535462'),(278,'FVBU','fvbu','bf732ff1eeb25302d661a81646ccc97cfd998535','2017-12-03 15:33:16.484522'),(279,'DVUW','dvuw','67b0d785821dadd0cb9023f52a1235f99e8d746b','2017-12-03 15:42:53.123334'),(280,'ZQMR','zqmr','7d4a3dfe238198d858d0f3a848cced5ed06dfcbb','2017-12-03 15:43:57.408408'),(281,'WAEL','wael','75c20aa052a93a0865d260b16c812c50d487f1b6','2017-12-03 15:44:30.773627'),(282,'KYHD','kyhd','9afb189aaab12b002b86788a802cf5483390534e','2017-12-03 15:45:38.763133'),(283,'TBOH','tboh','4b504e19a971bc8ec2c9355d7ed0a08c8ce55fc4','2017-12-03 15:51:58.305218'),(284,'VTJM','vtjm','20a3e5ab0d0a034bbf6504c75c11b0ce70766fae','2017-12-03 15:53:24.600680'),(285,'ZNLI','znli','b97882ce2360a17e1a77b05e8f3fcbcfcc6917c4','2017-12-03 15:53:44.553274'),(286,'YDVA','ydva','42a091c4d08b048223082b051c0ded324d4252b3','2017-12-03 15:53:58.353329'),(287,'UKWC','ukwc','23a7c1cbb22c4225f6c115fe7c77d5d9f3541b34','2017-12-03 15:54:04.571460'),(288,'UIQV','uiqv','daadbb4d337459284c62e93bb8bf9efbcb801104','2017-12-03 15:55:59.097218'),(289,'IKZL','ikzl','c995db40824067a71ee225814f5ebdf7cf79b9a7','2017-12-03 15:57:15.649054'),(290,'ACBX','acbx','9039303e4505f728b74bdbb59a44a9be7276c851','2017-12-03 15:57:24.394740'),(291,'NSHT','nsht','6d3e531ddc5efcdfd8b1d892c2cdb42d71dffc65','2017-12-03 16:02:56.672212'),(292,'UXVX','uxvx','d2755e42a080b7921f90e287933676d5dc50ed23','2017-12-03 16:04:45.783364'),(293,'LKYR','lkyr','2fba4ac266a8152422845b95d59b56d49f7db2f1','2017-12-03 16:05:29.554706'),(294,'EPLL','epll','252ae2aaa28427358d5080fea3855dbbbbd166bc','2017-12-03 16:36:21.264786'),(295,'WHWB','whwb','014c3edfa49a3863b0fd0ef7a54bf025ed8c4586','2017-12-03 16:38:54.990048'),(296,'DKPR','dkpr','863f6178a2db432817bf65a18a64c12285e3bafe','2017-12-03 16:39:17.125468'),(297,'ZECO','zeco','aed4dbf1012b468c548e66aeb76b92566b74e856','2017-12-03 16:44:25.519655'),(298,'ZFKI','zfki','d40d61afac6d84afc44dc4c9cbea30af417b6434','2017-12-03 16:44:49.768152'),(299,'BYZE','byze','502853fe7d513d4ab7d48a6b818dc51c364f10bc','2017-12-03 16:44:57.497424'),(300,'XXVG','xxvg','8f0a095d7e2440947e2c4eeee76f676096602256','2017-12-03 16:46:25.588214'),(301,'PJMF','pjmf','ed87d88f3f472ebf433008fb7064d42bfb855974','2017-12-03 16:47:14.039973'),(302,'RMBT','rmbt','ec01d97e7c4626e7156a90355115971ad4a62792','2017-12-03 16:47:44.794764'),(303,'XOMP','xomp','7c09c85171750081a4131633b461799acea3a07b','2017-12-03 16:48:12.056453'),(304,'IVJY','ivjy','3f868538b65bcf02d0db8a8799cbe3b7b49104f4','2017-12-03 16:48:56.175016'),(305,'BOBW','bobw','8d536652f4c3d6feaed4a76e4aeb859ada01f937','2017-12-03 16:52:01.906657'),(306,'ONCA','onca','3e39d0e3d902ee697a8fd52fa605b4b522f2438a','2017-12-03 16:54:16.161952'),(307,'XAMM','xamm','20e8486d00e78b06dc2fa32c50e323335b08a47a','2017-12-03 16:55:41.327876'),(308,'KFUF','kfuf','87b66e2b51b4071bcc4d0384bde2b1afc06e1ef5','2017-12-03 16:56:51.256027'),(309,'EFOG','efog','57115d9e8cc61d1de9e1153fe2f5d4c2844f365d','2017-12-03 16:57:40.081402'),(310,'JKXM','jkxm','e2dd74b756e259193c31d9d5a0bdefcd5906253d','2017-12-03 16:57:55.143729'),(311,'ABEW','abew','c1ac6c370e1b30971d22039edf083c05126467e6','2017-12-03 16:58:42.355748'),(312,'VJNR','vjnr','a98a985e2247f695fffc8ce69f2c42f3a9b29cf8','2017-12-03 17:02:30.548030'),(313,'LEIY','leiy','d0a2d9dade54aeee557e19a438aa0e19035fc1ab','2017-12-03 17:07:54.005463'),(314,'XSWY','xswy','0c689ac8f888f719f2a9fbf1642449d0c8ae5514','2017-12-03 17:09:03.914105'),(315,'HAGZ','hagz','b620d7746ae4c7a60d64d89ea99241dcb414dfa7','2017-12-03 17:09:24.461001'),(316,'CPXH','cpxh','712afdfea43f11fa73ba6a861f01c3a3a92c9f7f','2017-12-03 17:10:50.514500'),(317,'DZLG','dzlg','00595f36fb2e872b045e3fe5d4adba872d2a229e','2017-12-03 17:11:47.587965'),(318,'WZBX','wzbx','c83fcc348beff79f49074bf51fe1884d965b49ae','2017-12-03 19:12:48.148950'),(319,'ZPLB','zplb','81fc6e55d88c6163e9bc9f1e9fa7f15bd1e53dfa','2017-12-04 13:32:44.253753'),(320,'RWEA','rwea','8a53e03d38f3326d88d0df9f2d14bc65983652a0','2017-12-04 13:33:13.515339');
/*!40000 ALTER TABLE `captcha_captchastore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cases_banner`
--

DROP TABLE IF EXISTS `cases_banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cases_banner` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(100) NOT NULL,
  `index` int(11) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  `hyperlink` varchar(200) NOT NULL,
  `title` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cases_banner`
--

LOCK TABLES `cases_banner` WRITE;
/*!40000 ALTER TABLE `cases_banner` DISABLE KEYS */;
INSERT INTO `cases_banner` VALUES (2,'banner/2_iAozXwO.jpg',0,'2017-11-24 00:09:00.000000','https://yuedu.baidu.com/ebook/8098c953f61fb7360a4c6500','你想了解App Inventor2哪一方面？'),(3,'banner/ai2.jpg',1,'2017-11-24 00:10:00.000000','https://yuedu.baidu.com/ebook/8098c953f61fb7360a4c6500','深度解密2015年App Inventor应用开发全国中学生挑战赛-高中组特等奖作品'),(4,'banner/gg.jpg',2,'2017-11-24 00:11:00.000000','https://item.taobao.com/item.htm?spm=a230r.1.14.1.3GGqen&id=534197587790&ns=1&abbucket=19#detail','用App Inventor设计开发移动教育软件');
/*!40000 ALTER TABLE `cases_banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cases_cases`
--

DROP TABLE IF EXISTS `cases_cases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cases_cases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `click_num` int(11) NOT NULL,
  `fav_num` int(11) NOT NULL,
  `cases_brief` longtext NOT NULL,
  `cases_desc` longtext NOT NULL,
  `cases_front_image` varchar(200) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  `category_id` int(11) NOT NULL,
  `reply_num` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cases_cases_category_id_c58c97f7_fk_cases_casescategory_id` (`category_id`),
  CONSTRAINT `cases_cases_category_id_c58c97f7_fk_cases_casescategory_id` FOREIGN KEY (`category_id`) REFERENCES `cases_casescategory` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cases_cases`
--

LOCK TABLES `cases_cases` WRITE;
/*!40000 ALTER TABLE `cases_cases` DISABLE KEYS */;
INSERT INTO `cases_cases` VALUES (12,'App Inventor中秋节贺卡应用介绍',67,0,'App Inventor中秋节贺卡应用介绍','<h1 style=\"text-align: center;\"><strong>App Inventor</strong><strong>中秋节贺卡应用介绍</strong></h1>\n<h2><strong>一、应用描述</strong></h2>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip0-2017-11-23-13-47-36.png\">本应用是一个中秋节贺卡应用，可发送祝福，还有一些趣味拓展功能。下面就让我们从最基础的步骤为您讲解，让您也可以亲身体验，做出一个实用的贺卡应用！</p>\n<h2><strong>二、功能及界面介绍</strong></h2>\n<p>本应用在给予用户节日祝福的同时，与之进行恰当的互动和拓展功能，各屏幕及控件使用情况列举如下：</p>\n<ol>\n<li>引入界面Scrolls 屏幕（画布 图像精灵 计时器）</li>\n<li>菜单及设置界面menu屏幕（界面布局 标签 复选框 按钮 对话框 音频播放器）</li>\n<li>节日相关介绍界面history屏幕（界面布局 按钮 图片 标签）</li>\n<li>猜谜界面question屏幕（界面布局 标签 按钮 图片 对话框）</li>\n<li>传递祝福界面passhappiness屏幕（界面布局 文本输入框 联系人选择框 标签 按钮 短信收发器 对话框）</li>\n</ol>\n<h3><strong>本应用主要功能：</strong></h3>\n<ol>\n<li>建立一系列组件，设置其属性并设计逻辑，实现贺卡整体功能；</li>\n<li>利用计时器及不同图片精灵的z坐标属性控制直观表现时间的动态变化；</li>\n<li>利用社交应用组件实现祝福的传递；</li>\n<li>利用复选框实现应用设置。</li>\n</ol>\n<p>设计过程中使用的素材用户可以通过“上传文件”按钮自行设置，本应用的素材可从附带的aia文件中获取。接下来就让我们带着你，一起来做做看吧！</p>\n<ol>\n<li><strong>首先，登录MIT App Inventor网站，新建一个项目（在整体应用设计过程中，建议用户使用有意义的命名，便于规划，例如本应用的menu屏幕）。用户的编辑界面如下：组件设计页包含组件面板，工作面板，组件列表及属性；逻辑设计页面则是具体的代码设计界面。</strong></li>\n</ol>\n<p>&nbsp;<img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip1-2017-11-23-13-47-47.png\"></p>\n<p>&nbsp;</p>\n<ol start=\"2\">\n<li><strong>首屏是一个小动画，借助月亮描绘主人公随时间推移的生活轨迹，计时器控制界面间的切换。需要用到的组件可以直接从组件面板拖拽至工作面板进行添加。首先考虑四张背景图从11-8.14，此处关键是由于背景始终处于其他元素下方，且日期较大的背景将会覆盖前一个背景，所以需设置图片精灵的z坐标属性，z坐标越大的，在更上层。</strong></li>\n</ol>\n<p><strong><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip2-2017-11-23-13-48-07.png\"></strong></p>\n<p>下面 以此屏幕为例，介绍一下其内各组件的布置情况，后续不再一一列举。</p>\n<table width=\"567\">\n<tbody>\n<tr>\n<td width=\"85\">\n<p><strong>组件类型 </strong></p>\n</td>\n<td width=\"85\">\n<p><strong>组件分组 </strong></p>\n</td>\n<td width=\"189\">\n<p><strong>命名方式 </strong></p>\n</td>\n<td width=\"208\">\n<p><strong>组件功能 </strong></p>\n</td>\n</tr>\n<tr>\n<td width=\"85\">\n<p><strong>画布 </strong></p>\n</td>\n<td width=\"85\">\n<p>绘图动画</p>\n</td>\n<td width=\"189\">\n<p>画布显示动画</p>\n</td>\n<td width=\"208\">\n<p>放置需要展示的图片精灵</p>\n</td>\n</tr>\n<tr>\n<td width=\"85\">\n<p><strong>图片精灵 </strong></p>\n</td>\n<td width=\"85\">\n<p>绘图动画</p>\n</td>\n<td width=\"189\">\n<p>图片精灵月亮背景1-5、图片精灵生活场景1-5、图片精灵日历</p>\n</td>\n<td width=\"208\">\n<p>放置不同图片作为动画的分解部分</p>\n</td>\n</tr>\n<tr>\n<td width=\"85\">\n<p><strong>计时器 </strong></p>\n</td>\n<td width=\"85\">\n<p>传感器</p>\n</td>\n<td width=\"189\">\n<p>计时器控制动画</p>\n</td>\n<td width=\"208\">\n<p>控制图片精灵的显隐实现其动态切换</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p>如下表是对各组件属性的设置情况，用户的高宽设定可根据实际使用的素材进行调整：</p>\n<table>\n<tbody>\n<tr>\n<td width=\"141\">\n<p><strong>组件 </strong></p>\n</td>\n<td width=\"412\">\n<p><strong>属性设置 </strong></p>\n</td>\n</tr>\n<tr>\n<td width=\"141\">\n<p><strong>画布显示动画 </strong></p>\n</td>\n<td width=\"412\">\n<p>高度、宽度均设为充满</p>\n</td>\n</tr>\n<tr>\n<td width=\"141\">\n<p><strong>图片精灵月亮背景1-5 </strong></p>\n</td>\n<td width=\"412\">\n<p>添加图片，高度设为570像素，宽度设为320像素，z坐标设为1,3,5,7,9</p>\n</td>\n</tr>\n<tr>\n<td width=\"141\">\n<p><strong>图片精灵生活场景1-5 </strong></p>\n</td>\n<td width=\"412\">\n<p>添加图片，高度设为200像素，宽度设为自动， x坐标设为30，y坐标设为200，z坐标设为2,4,6,8</p>\n</td>\n</tr>\n<tr>\n<td width=\"141\">\n<p><strong>图片精灵日历 </strong></p>\n</td>\n<td width=\"412\">\n<p>添加图片，高度设为570像素，宽度设为320像素，z坐标设为10</p>\n</td>\n</tr>\n<tr>\n<td width=\"141\">\n<p><strong>计时器控制动画 </strong></p>\n</td>\n<td width=\"412\">\n<p>设“一直计时”、“启用计时”属性为真，计时间隔设为500毫秒</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p><br> 而关于各组件的具体的响应事件，我们将会在逻辑设计里进行设置，从而实现模拟的小动画效果：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip3-2017-11-23-13-48-52.png\"></p>\n<p>说明： 【1】+【4】内置快-&gt;控制；【2】内置快-&gt;数学；【3】内置快-&gt;逻辑。</p>\n<p>注意：在使用计时器时，我们往往需要设置一个变量，其数值为计时器启用计时后经历的计时间隔数，通过对变量的控制实现对计时器的控制。并且，在使用计时器的时候，需要注意，为避免出现不必要的错误，在切换屏幕之前，需要先停止计时器，即在打开新屏幕之前把计时器“启用计时”属性设置为“false”。</p>\n<p>&nbsp;</p>\n<ol start=\"3\">\n<li><strong>第二个界面是菜单界面</strong></li>\n</ol>\n<p><strong><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip4-2017-11-23-13-49-16.png\"></strong></p>\n<p>&nbsp; &nbsp; 本屏幕巧妙使用了界面布局，三种不同布局组件可按需摆放甚至嵌套放置。我们利用布局组件设置空白间隔以排版、放置竖直菜单和可以弹出的设置框。竖直的菜单设置了新的素材，用平台自带的原型按钮同理。通过对按钮的逻辑设计可实现屏幕间跳转或打开设置框（初始显示状态为假）。音频播放器用于播放 <br> 背景音乐，用户可以允许其后台播放，也可以在切换屏幕前停止播放器。具体代码如下：</p>\n<p>&nbsp;<img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip5-2017-11-23-13-49-27.png\"></p>\n<ol start=\"4\">\n<li><strong>接下来是history屏幕，实现菜单中“追溯”的功能。</strong></li>\n</ol>\n<p>这一屏幕中新添加了图片组件，用于添加一个小装饰图片，和标签组件，用于展示具体的历史相关文本内容，最初按钮文本被设置为空，不同按钮被点击后，可设置标签文本属性设置显示不同内容。</p>\n<p>&nbsp;</p>\n<ol start=\"5\">\n<li><strong> question</strong><strong>屏幕实现了猜谜功能，利用表格布局结合空白水平布局可以将四个答案选项工整排布。</strong></li>\n</ol>\n<p><strong><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip6-2017-11-23-13-49-46.png\"></strong></p>\n<p>我们设置两个变量，分别对应当前题目序号以及当前已答对的题目数目，判断它们的数值可以做出相应的响应，以第一个问题为例，具体代码如下：</p>\n<p>&nbsp;<img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip7-2017-11-23-13-51-02.png\"></p>\n<ol start=\"6\">\n<li><strong>最后一个是passhappiness屏幕，用于为亲友发送祝福。</strong></li>\n</ol>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip8-2017-11-23-13-51-12.png\"></p>\n<p><br> 在这里我们添加了两个社交应用分组里的特殊空间——短信收发器和联系人选择框以实现短信通讯功能。而文本输入框的设置给用户提供了两种选择，直接输入号码，或通过联系人选择框调用手机自带通讯录内联系人号码。对话框用于保证收件人号码及短信内容均不为空。</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip9-2017-11-23-13-51-24.png\"></p>\n<p>具体实现的代码如下：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip10-2017-11-23-13-51-34.png\"></p>\n<p>这样，通过使用带有社交应用功能的控件，用户既可以收到来自应用本身的祝福，也可以借助本应用为平台，向亲友发送祝福。赠人玫瑰，手有余香，你是不是已经蠢蠢欲动了呢？在学习完本教程后，快实际尝试一下，做一个属于你的节日贺卡应用，并分享给大家吧！</p>\n<p><strong>三、应用情景展示</strong></p>\n<p><strong><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip11-2017-11-23-13-51-54.png\">&nbsp;&nbsp;<img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip12-2017-11-23-13-51-58.png\">&nbsp;&nbsp;<img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip13-2017-11-23-13-52-05.png\"></strong></p>\n<p>&nbsp;</p>\n<p><strong><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip14-2017-11-23-13-52-11.png\">&nbsp;&nbsp;<img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip15-2017-11-23-13-52-15.png\">&nbsp;&nbsp;<img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip16-2017-11-23-13-52-20.png\"></strong></p>\n<p>&nbsp;</p>\n<p><strong><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip17-2017-11-23-13-52-27.png\">&nbsp;&nbsp;<img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip18-2017-11-23-13-53-44.png\"></strong></p>','http://127.0.0.1:8000/media/case_cover_picture/admin4/封面图-2017-11-26-18-01-19.jpg','2017-11-23 14:23:26.575485',13,0),(13,'App Inventor元宵节贺卡应用介绍',6,0,'App Inventor元宵节贺卡应用介绍','<h1>App Inventor元宵节贺卡应用介绍</h1>\n<h2>一、应用描述</h2>\n<p>在温暖团圆的元宵节，我们结合多种中国风的元素及多样形式，为你带来乐趣和祝福。</p>\n<h2>二、功能及界面介绍&amp;应用情景展示</h2>\n<p>本贺卡应用各屏幕及所包含的控件的使用情况如下：</p>\n<ol>\n<li>引入界面Screen1屏幕（计时器）</li>\n<li>菜单界面menu屏幕（界面布局 按钮 画布 图像精灵 计时器）</li>\n<li>节日历史介绍界面history屏幕（界面布局 标签 按钮 文本语音转换器）</li>\n<li>猜灯谜界面riddle屏幕（界面布局 标签 文本输入框）</li>\n<li>花灯展示界面lantern屏幕（按钮）</li>\n<li>分享界面happyshare屏幕（界面布局 标签 图像 按钮 信息分享器 计时器）</li>\n</ol>\n<p>本应用主要功能：</p>\n<ol>\n<li>建立一系列组件，设置其属性并设计逻辑，实现贺卡整体功能；</li>\n<li>利用计时器及不同图片精灵的显示状态属性控制实现gif的效果；</li>\n<li>利用社交应用组件实现祝福的传递；</li>\n</ol>\n<p>设计过程中使用的素材用户可以通过“上传文件”按钮自行设置，本应用的素材可从附带的aia文件中获取。下面详细介绍本应用的制作过程：</p>\n<h4><br>1. 登录MIT App Inventor网站，新建一个项目，在屏幕1内设置屏幕Screen1的背景图片属性添加图片素材。本屏幕是通过计时器计时实现到下一屏幕menu的自动跳转，没各屏幕的开屏及关屏动画可个性化设置（提醒：切换屏幕前需要关闭计时器）。</h4>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip0-2017-11-27-15-19-16.png\"></p>\n<h4><br>2. Menu屏幕提供了本应用的功能菜单，用界面布局合理摆放菜单的五个按钮，用计时器控制图像精灵显示状态实现gif效果，整个界面简洁大方又不失活力。</h4>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip1-2017-11-27-15-19-42.png\"></p>\n<p><br> 在实现gif效果的部分，本应用巧妙地利用了名为“否定”的逻辑模块直接对图像精灵显示状态进行改变，简化了代码，如下代码对比分析：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip2-2017-11-27-15-19-56.png\"></p>\n<p><br> 说明： 【1】内置块-&gt;数学；【2】内置块-&gt;逻辑；【3】内置块-&gt;控制。</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip3-2017-11-27-15-20-05.png\"></p>\n<h4><br>3. 菜单第一项指向history屏幕，这一屏幕内利用标签显示关于元宵节的节日历史。我们选用了多媒体组件里的文本语音转换器在屏幕初始化时引导读出“元宵节的历史”，这是对这一组件的简单应用，通过对文本语音转换器的巧妙设计，可以实现应用和用户间的生动交流互动。</h4>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip4-2017-11-27-15-20-26.png\"></p>\n<p><br> 相关代码如下：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip5-2017-11-27-15-20-34.png\"></p>\n<p>说明： 【1】内置快-&gt;过程。</p>\n<h4><br>4. 菜单第二项指向riddle屏幕，这是一个猜谜界面。分别用十个标签显示谜面，和十个文本输入框供用户输入谜底。比较特别的是奖励语的设置，奖励语的内容通过一个变量控制，而变量通过对用户答案的正确性的判断决定。以用户答对三道题获取奖励语“三阳开泰”为例，效果如下图：</h4>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip6-2017-11-27-15-21-04.png\"></p>\n<p><br> 在设计代码时，为防止已答对题目对变量值得影响，在每次用户点击查看奖励按钮后，需要先对变量的值进行重设。具体代码如下：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip7-2017-11-27-15-21-16.png\"></p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip8-2017-11-27-15-21-22.png\"></p>\n<p>注意：在今后使用文本输入框的时候，为避免用户意外输入多余的空格造成不必要的错误，需要在对文本输入框进行设置前对其内文本进行“删除空格”的操作。</p>\n<h4><br>5. 看花灯功能对应lantern屏幕，这一屏幕设置较简单，是花灯背景图和“返回菜单”按钮的组合。</h4>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip9-2017-11-27-15-21-48.png\"></p>\n<h4><br>6. 最后一项功能送祝福由happyshare屏幕实现，这一屏幕中，我们使用了社交应用组件分组里的信息分享器控件，用于调用所在手机平台内可以调用的实现信息传递和分享的其他应用。这里以发送短信为例，过程如下：</h4>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip10-2017-11-27-15-22-24.png\">&nbsp; &nbsp;<img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip11-2017-11-27-15-22-29.png\">&nbsp; &nbsp;<img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip12-2017-11-27-15-22-35.png\"></p>\n<p><br> 界面的组件设计情况如下：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip13-2017-11-27-15-22-43.png\"></p>\n<p><br> 在退出应用被点击时，应用在退出程序之前有一个小小的设置，利用了图片和计时器，效果如下：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip14-2017-11-27-15-22-53.png\"></p>\n<p>以此屏幕为例，下面介绍一下各组件的布置情况：</p>\n<table width=\"558\">\n<tbody>\n<tr>\n<td width=\"85\">\n<p><strong>组件类型 </strong></p>\n</td>\n<td width=\"76\">\n<p><strong>组件分组 </strong></p>\n</td>\n<td width=\"208\">\n<p><strong>命名方式 </strong></p>\n</td>\n<td width=\"189\">\n<p><strong>组件功能 </strong></p>\n</td>\n</tr>\n<tr>\n<td width=\"85\">\n<p><strong>水平布局</strong></p>\n</td>\n<td width=\"76\">\n<p>界面布局</p>\n</td>\n<td width=\"208\">\n<p>水平局部退出语、水平布局退出图像</p>\n</td>\n<td width=\"189\">\n<p>放置需要展示的图片精灵</p>\n</td>\n</tr>\n<tr>\n<td width=\"85\">\n<p><strong>标签 </strong></p>\n</td>\n<td width=\"76\">\n<p>用户界面</p>\n</td>\n<td width=\"208\">\n<p>标签+标签文本内容</p>\n</td>\n<td width=\"189\">\n<p>显示提示语和祝福语</p>\n</td>\n</tr>\n<tr>\n<td width=\"85\">\n<p><strong>图像 </strong></p>\n</td>\n<td width=\"76\">\n<p>用户界面</p>\n</td>\n<td width=\"208\">\n<p>图像可爱妹纸</p>\n</td>\n<td width=\"189\">\n<p>显示退出前的图像</p>\n</td>\n</tr>\n<tr>\n<td width=\"85\">\n<p><strong>按钮 </strong></p>\n</td>\n<td width=\"76\">\n<p>用户界面</p>\n</td>\n<td width=\"208\">\n<p>按钮+分享喜悦/返回菜单/退出应用</p>\n</td>\n<td width=\"189\">\n<p>实现菜单功能</p>\n</td>\n</tr>\n<tr>\n<td width=\"85\">\n<p><strong>信息分享器 </strong></p>\n</td>\n<td width=\"76\">\n<p>社交应用</p>\n</td>\n<td width=\"208\">\n<p>信息分享器分享祝福</p>\n</td>\n<td width=\"189\">\n<p>在手机不同应用间实现分享，显示能处理相关信息的应用列表并允许用户自选一项来实现分享过程</p>\n</td>\n</tr>\n<tr>\n<td width=\"85\">\n<p><strong>计时器 </strong></p>\n</td>\n<td width=\"76\">\n<p>传感器</p>\n</td>\n<td width=\"208\">\n<p>计时器控制动画</p>\n</td>\n<td width=\"189\">\n<p>控制退出前图像的显示时间</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p>如下表是对各组件属性的设置情况，用户的高宽设定可根据实际使用的素材进行调整：</p>\n<table>\n<tbody>\n<tr>\n<td width=\"132\">\n<p><strong>组件 </strong></p>\n</td>\n<td width=\"397\">\n<p><strong>属性</strong><strong>设</strong><strong>置 </strong></p>\n</td>\n</tr>\n<tr>\n<td width=\"132\">\n<p><strong>水平布局两个 </strong></p>\n</td>\n<td width=\"397\">\n<p>宽度均设为充满，水平布局退出语高度设为250像素</p>\n</td>\n</tr>\n<tr>\n<td width=\"132\">\n<p><strong>标签三个 </strong></p>\n</td>\n<td width=\"397\">\n<p>无特殊设置，可自由控制字号</p>\n</td>\n</tr>\n<tr>\n<td width=\"132\">\n<p><strong>图像 </strong></p>\n</td>\n<td width=\"397\">\n<p>添加素材作为图片属性，高度宽度均设为自动</p>\n</td>\n</tr>\n<tr>\n<td width=\"132\">\n<p><strong>按钮三个 </strong></p>\n</td>\n<td width=\"397\">\n<p>按钮分享喜悦及按钮返回菜单宽度设为100像素，其他设置为默认状态</p>\n</td>\n</tr>\n<tr>\n<td width=\"132\">\n<p><strong>信息分享器分享祝福 </strong></p>\n</td>\n<td width=\"397\">\n<p>无特殊设置</p>\n</td>\n</tr>\n<tr>\n<td width=\"132\">\n<p><strong>计时器控制动画 </strong></p>\n</td>\n<td width=\"397\">\n<p>设“一直计时”属性为真，计时间隔为默认的1000毫秒</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p><br> &nbsp;逻辑设计展示：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</p>\n<p>&nbsp;<img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip15-2017-11-27-15-23-09.png\"></p>','http://127.0.0.1:8000/media/case_cover_picture/admin4/封面图-2017-11-27-15-09-37.jpg','2017-11-27 15:09:54.873821',13,0),(22,'App Inventor生日贺卡应用介绍',2,0,'App Inventor生日贺卡应用介绍','<h1>App Inventor生日贺卡应用介绍</h1>\n<h2>一、应用描述</h2>\n<p>生日意味着时光流逝，阅历沉淀，我们在欢庆中成长着，一点一点地看着自己的改变。</p>\n<h2>二、功能及界面介绍</h2>\n<p>本贺卡应用各屏幕及所包含的控件的使用情况如下：</p>\n<ol>\n<li>登入界面Screen1屏幕（界面布局 文本输入框 按钮 对话框）</li>\n<li>开场贺卡card屏幕（界面布局 画布 图像精灵 标签 按钮 音频播放器）</li>\n<li>应用菜单menu屏幕（画布 图像精灵）</li>\n<li>求祝福界面wish屏幕（画布 图像精灵 按钮）</li>\n<li>购物界面shopping屏幕（画布图像精灵 activity启动器）</li>\n<li>同生缘界面destiny屏幕（界面布局 按钮 图像 标签）</li>\n<li>个人秀编辑界面edit屏幕（界面布局 标签 按钮 文本输入框 照相机 对话框）</li>\n<li>个人秀展示界面show屏幕（界面布局 按钮 标签 图像）</li>\n</ol>\n<p>本应用主要功能：</p>\n<ol>\n<li>建立一系列组件，通过设置控件属性及逻辑设计，实现贺卡整体功能；</li>\n<li>利用画布和图像精灵的组合提升英语界面的美观度，还能播放音乐让用户身临其境；</li>\n<li>利用activity启动器打开网页页面；</li>\n<li>列表木块进行逻辑设计存储多个变量；</li>\n<li>调用手机照相机进行拍照。</li>\n</ol>\n<p>设计过程中使用的素材用户可以通过“上传文件”按钮自行设置，本应用的素材可从附带的aia文件中获取。下面详细介绍本应用的制作过程：</p>\n<h4><br>1. 登录MIT App Inventor网站，新建一个项目，在屏幕1内设置屏幕Screen1的背景图片属性添加背景图素材，利用界面布局布置好文本输入框及按钮位置。</h4>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip0-2017-11-27-16-26-37.png\"></p>\n<p><br> 作为一个登入界面，本屏幕内有供用户输入用户名（Mike）的文本输入框。需要注意的是，这里从文本输入框获取的文本作为一个变量“name”被传递到了下一屏幕内使用。相关代码如下：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip1-2017-11-27-16-26-52.png\"></p>\n<p>说明： 【1】内置块-&gt;变量；【2】内置块-&gt;逻辑；【3】内置块-&gt;过程；【4】内置块。</p>\n<h4><br>2. card屏幕提供了一个开场的祝福贺卡，从Screen1获取的变量姓名在这里被应用，和祝福语组合构成界面。</h4>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip2-2017-11-27-16-27-20.png\"><br> 背景音乐可通过按钮控制播放/暂停，代码如下：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip3-2017-11-27-16-27-27.png\"></p>\n<p>说明： 【1】内置块-&gt;文本；【2】内置块-&gt;过程；【3】内置块-&gt;控制。</p>\n<h4>3. Menu屏幕是菜单界面，这一界面相比于其他界面元素多样，更加美观，关键是要利用好画布和图像精灵的布局设计，同时，素材选取在色调及风格上的统一性也很重要。</h4>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip4-2017-11-27-16-27-51.png\"></p>\n<p>本界面内代码布置较为简洁，只是利用图像精灵作为菜单按钮控制屏幕跳转。</p>\n<h4><br>4. 菜单第一项指向wish屏幕，这是一个送祝福界面，显示积极的祝福语：</h4>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip5-2017-11-27-16-28-32.png\"></p>\n<h4><br>5. 菜单第一项指向shopping屏幕。</h4>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip6-2017-11-27-16-29-03.png\"></p>\n<p><br> 这一屏幕内的特殊组件是activity启动器，是属于通信连接分组的组件。通过activity的相关功能，调用手机浏览器打开相应网页页面。</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip7-2017-11-27-16-29-14.png\"></p>\n<p>说明： 【1】内置块-&gt;过程。</p>\n<p><br> 点击“蛋糕”按钮后，效果如下：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip8-2017-11-27-16-29-26.png\"></p>\n<h4><br>6. 下一功能同生缘为destiny屏幕，显示与用户生日相同的明星图片及简介。</h4>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip9-2017-11-27-16-29-46.png\"></p>\n<p>最后一项功能个人秀功能由两个屏幕edit和show共同实现：</p>\n<h4><br>7. Edit屏幕：用户可以输入一段关于自己对自己未来期待的文字。</h4>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip10-2017-11-27-16-30-08.png\"></p>\n<p>开始输入后，“完成”按钮自动显示：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip11-2017-11-27-16-30-17.png\"></p>\n<p>用户输入结束后点击“完成”，屏幕下方小菜单自动显示：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip12-2017-11-27-16-30-24.png\"></p>\n<p>点击“拍照”，照相机控件将调用手机相机功能进行拍照并获取图像，点击“生成个人秀”跳转至show屏幕，获取的图像同样被作为一个变量传递到show界面。</p>\n<p>下面以此屏幕为例，介绍一下各组件的布置情况。</p>\n<table width=\"558\">\n<tbody>\n<tr>\n<td width=\"85\">\n<p><strong>组件类型 </strong></p>\n</td>\n<td width=\"76\">\n<p><strong>组件分组 </strong></p>\n</td>\n<td width=\"208\">\n<p><strong>命名方式 </strong></p>\n</td>\n<td width=\"189\">\n<p><strong>组件功能 </strong></p>\n</td>\n</tr>\n<tr>\n<td width=\"85\">\n<p><strong>水平布局</strong></p>\n</td>\n<td width=\"76\">\n<p>界面布局</p>\n</td>\n<td width=\"208\">\n<p>水平布局x空白/功能</p>\n</td>\n<td width=\"189\">\n<p>设置界面空白，规划布局</p>\n</td>\n</tr>\n<tr>\n<td width=\"85\">\n<p><strong>标签 </strong></p>\n</td>\n<td width=\"76\">\n<p>用户界面</p>\n</td>\n<td width=\"208\">\n<p>标签+标签文本内容</p>\n</td>\n<td width=\"189\">\n<p>显示提示语和祝福语</p>\n</td>\n</tr>\n<tr>\n<td width=\"85\">\n<p><strong>文本输入框 </strong></p>\n</td>\n<td width=\"76\">\n<p>用户界面</p>\n</td>\n<td width=\"208\">\n<p>文本输入框期待内容</p>\n</td>\n<td width=\"189\">\n<p>供用户输入文本并保存到变量中</p>\n</td>\n</tr>\n<tr>\n<td width=\"85\">\n<p><strong>按钮 </strong></p>\n</td>\n<td width=\"76\">\n<p>用户界面</p>\n</td>\n<td width=\"208\">\n<p>按钮完成、按钮拍照……</p>\n</td>\n<td width=\"189\">\n<p>实现菜单功能</p>\n</td>\n</tr>\n<tr>\n<td width=\"85\">\n<p><strong>照相机 </strong></p>\n</td>\n<td width=\"76\">\n<p>多媒体</p>\n</td>\n<td width=\"208\">\n<p>照相机拍照</p>\n</td>\n<td width=\"189\">\n<p>调用手机相机功能进行拍照</p>\n</td>\n</tr>\n<tr>\n<td width=\"85\">\n<p><strong>对话框 </strong></p>\n</td>\n<td width=\"76\">\n<p>用户界面</p>\n</td>\n<td width=\"208\">\n<p>对话框弹出提示</p>\n</td>\n<td width=\"189\">\n<p>针对用户操作弹出相应提示框</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p>如下表是对各组件属性的设置情况，用户的高宽设定可根据实际使用的素材进行调整：</p>\n<p>&nbsp;</p>\n<table>\n<tbody>\n<tr>\n<td width=\"132\">\n<p><strong>组件 </strong></p>\n</td>\n<td width=\"397\">\n<p><strong>属性</strong><strong>设</strong><strong>置 </strong></p>\n</td>\n</tr>\n<tr>\n<td width=\"132\">\n<p><strong>水平布局若干 </strong></p>\n</td>\n<td width=\"397\">\n<p>按照布局要求自主设置</p>\n</td>\n</tr>\n<tr>\n<td width=\"132\">\n<p><strong>标签 </strong></p>\n</td>\n<td width=\"397\">\n<p>无特殊设置，可自由控制字号</p>\n</td>\n</tr>\n<tr>\n<td width=\"132\">\n<p><strong>文本输入框 </strong></p>\n</td>\n<td width=\"397\">\n<p>高度设为200像素，宽度设为400像素，设置“显示状态”为真</p>\n</td>\n</tr>\n<tr>\n<td width=\"132\">\n<p><strong>按钮若干 </strong></p>\n</td>\n<td width=\"397\">\n<p>高度设为40像素，宽度设为自动</p>\n</td>\n</tr>\n<tr>\n<td width=\"132\">\n<p><strong>照相机 </strong></p>\n</td>\n<td width=\"397\">\n<p>无特殊设置</p>\n</td>\n</tr>\n<tr>\n<td width=\"132\">\n<p><strong>对话框 </strong></p>\n</td>\n<td width=\"397\">\n<p>无特殊设置（可调整其显示时长）</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p><br> &nbsp;具体代码展示：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip13-2017-11-27-16-30-49.png\"></p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip14-2017-11-27-16-30-55.png\"></p>\n<p>说明： 【1】+【4】内置块-&gt;变量；【2】内置块-&gt;逻辑；【3】+【5】内置块-&gt;过程；【6】内置块-&gt;列表。</p>\n<h4><br>8. Show屏幕：屏幕分为左右两部分，左侧用于显示用户之前输入的期待文字，右侧用于显示传递到本屏幕的已拍得的照片，从而生成个人秀。</h4>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip15-2017-11-27-16-31-20.png\"></p>\n<p><br> 个人秀从编辑到生成的过程让用户实际参与其中，增强了互动性。 在这部分的代码中，我们使用了列表的功能模块，将文字内容和图像同时存储在一个列表的列表项里。代码如下：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip16-2017-11-27-16-31-33.png\">&nbsp;&nbsp;<img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip17-2017-11-27-16-31-37.png\"></p>\n<p>说明： 设置文本及图片代码块——内置块-&gt;列表。</p>\n<p>&nbsp;</p>','http://127.0.0.1:8000/media/case_cover_picture/admin4/封面图-2017-11-27-16-31-57.jpg','2017-11-27 16:32:04.694045',13,0),(24,'App Inventor春节贺卡应用介绍',1,0,'App Inventor春节贺卡应用介绍','<h1 style=\"text-align: center;\">App Inventor春节贺卡应用介绍</h1>\n<h2>一、应用描述</h2>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip0-2017-11-27-17-12-11.png\">本应用是一个春节贺卡应用，可以它向亲友恭贺新春，还有一些趣味拓展功能。下面就让我们从最基础的步骤为您讲解，让您也可以亲身体验，做出一个实用的贺卡应用！</p>\n<h2>二、功能及界面介绍</h2>\n<p>本应用在给予用户节日祝福的同时，与之进行恰当的互动和拓展功能，各屏幕及控件使用情况列举如下：</p>\n<ol>\n<li>开场界面Screen1 屏幕（计时器）</li>\n<li>菜单界面menu屏幕（界面布局 按钮）</li>\n<li>填对联界面scrolls屏幕（界面布局 标签 文本输入框 按钮 对话框）</li>\n<li>贺岁片界面movie屏幕（界面布局 标签 按钮）</li>\n<li>流行语界面fashion屏幕（按钮）</li>\n<li>年夜饭界面meal屏幕（界面布局 按钮 画布 图像精灵 照相机 信息分享器）</li>\n</ol>\n<p>本应用主要功能：</p>\n<ol>\n<li>建立一系列组件，设置其属性并设计逻辑，实现贺卡整体功能；</li>\n<li>通过对联猜字实现应用和用户之间的交互；</li>\n<li>信息分享器实现祝福信息的传递。</li>\n</ol>\n<p>设计过程中使用的素材用户可以通过“上传文件”按钮自行设置，本应用的素材可从附带的aia文件中获取。接下来就让我们带着你，一起来做做看吧！</p>\n<h4><br>1. 首先，登录MIT App Inventor网站，新建一个项目（在整体应用设计过程中，建议用户使用有意义的命名，便于规划，例如本应用的menu屏幕）。设置首屏背景图片，用计时器控制切换到下一屏幕。 （小提示：在设计应用首屏时，如果界面操作权在用户手上，需要设置屏幕被回压即手机返回键被点击时应用退出，这样的界面较为友好）</h4>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip1-2017-11-27-17-13-08.png\"></p>\n<h2><br>2. 菜单屏幕menu含四个功能按钮连接不同屏幕和一个退出按钮，四个不同的功能屏幕均设置了返回菜单的按钮，便于操作。</h2>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip2-2017-11-27-17-13-32.png\"></p>\n<h4><br>3. Scrolls屏幕对应第一项菜单功能，设置了应用和用户的简单互动，界面显示一副不完整的对联，用户可以向文本输入框输入答案，答案正确则收获祝福语。</h4>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip3-2017-11-27-17-13-52.png\"></p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip4-2017-11-27-17-14-00.png\"></p>\n<p><br> 代码如下：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip5-2017-11-27-17-14-11.png\"></p>\n<p>这里注意图片中红框内，包图案里填充了东西，这是逻辑设计面板里的一个特殊功能，可以在一次登录期间暂时存放一些想要参考的代码块，值得注意的是，这些代码块是可以跨越不同项目供用户进行参考的，这对于用户用app inventor开发是一种良好的体验，大大的提高了开发效率。使用效果如下：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip6-2017-11-27-17-14-20.png\"></p>\n<h4><br>4. Movie屏幕会把近期的电影新片信息展示给用户（利用Web浏览框会有更好的展示效果，我们会在其他案例中实现这个组件），fashion界面则是总结过去一年（2015年）的十大流行语：</h4>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip7-2017-11-27-17-14-46.png\"></p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip8-2017-11-27-17-14-53.png\"></p>\n<h4><br>5. 最后一项功能对应meal屏幕，用户被建议对年夜饭进行拍照，并且借助信息分享器组件发送给好友。</h4>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip9-2017-11-27-17-15-12.png\">&nbsp;&nbsp;<img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip10-2017-11-27-17-15-18.png\">&nbsp;&nbsp;<img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip11-2017-11-27-17-15-30.png\"></p>\n<p><br> 代码展示：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip12-2017-11-27-17-15-52.png\"></p>','http://127.0.0.1:8000/media/case_cover_picture/admin4/封面图-2017-11-27-17-11-32.jpg','2017-11-27 17:16:10.275904',13,0),(33,'App Inventor日常签应用介绍',1,0,'App Inventor日常签应用介绍','<h1 style=\"text-align: center;\">App Inventor日常签应用介绍</h1>\n<h2>一、应用描述</h2>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip0-2017-11-27-19-26-55.png\" />本应用是一个关于心情的抽签应用，就像它的名字一样，日常生活中，当你失落时，来抽取一签，看看你能得到什么惊喜吧！</p>\n<h2>二、功能及界面介绍</h2>\n<p>本应用各屏幕及控件使用情况列举如下：</p>\n<ol>\n<li>抽取界面Screen1屏幕（界面布局 标签 滑动条 按钮 加速度传感器）</li>\n<li>结果及分享界面sign屏幕（界面布局 画布 图像 按钮 信息分享器）</li>\n</ol>\n<p>本应用主要功能：</p>\n<ol>\n<li>建立一系列组件，设置其属性并设计逻辑，实现日常签的随机抽取功能；</li>\n<li>借助滑动条和加速度传感器控件，提供给用户两种抽签方式；</li>\n<li>利用画布抓取素材并保存于手机，用于文件及信息分享。</li>\n</ol>\n<p>设计过程中使用的素材用户可以通过&ldquo;上传文件&rdquo;按钮自行设置，本应用的素材可从附带的aia文件中获取。接下来就让我们带着你，一起来做做看吧！</p>\n<h4><br />1. 首先，登录MIT App Inventor网站，新建一个项目及两个屏幕。第一个屏幕Screen1用于引入应用及实现抽取过程。</h4>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip1-2017-11-27-19-27-45.png\" />&nbsp;&nbsp;<img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip2-2017-11-27-19-27-53.png\" /></p>\n<p><br /> 实现效果：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip3-2017-11-27-19-28-05.png\" /></p>\n<p>这里的设计中我们使用了两个较为特殊的控件&mdash;&mdash;滑动条和加速度传感器。滑动条由一个进度条和一个可拖动的滑块组成。可以左右拖动滑块来设定滑块位置，拖动滑块将触发&ldquo;位置变化&rdquo;事件，并记录滑块位置。滑块位置可以动态更新其他控件的某些属性或是一些变量的取值。加速度传感器是一个非可视组件，可以用于侦测晃动，并测出加速度三个维度分量的近似值。 如下为代码块的设计：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip4-2017-11-27-19-28-22.png\" /></p>\n<p><br /> 在这里我们为滑动条设定了最大最小值及初始位置，而在实际的逻辑设计中，为了取整，我们利用了&ldquo;四舍五入&rdquo;模块；同时用加速度传感器检测用户的&ldquo;摇动&rdquo;行为，并且利用了随机数生成的功能。</p>\n<p>本屏幕内的组件布置情况：</p>\n<table width=\"567\">\n<tbody>\n<tr>\n<td width=\"104\">\n<p><strong>组件类型 </strong></p>\n</td>\n<td width=\"85\">\n<p><strong>组件分组 </strong></p>\n</td>\n<td width=\"151\">\n<p><strong>命名方式 </strong></p>\n</td>\n<td width=\"227\">\n<p><strong>组件功能 </strong></p>\n</td>\n</tr>\n<tr>\n<td width=\"104\">\n<p><strong>水平/垂直布局 </strong></p>\n</td>\n<td width=\"85\">\n<p>界面布局</p>\n</td>\n<td width=\"151\">\n<p>类型+功能</p>\n</td>\n<td width=\"227\">\n<p>控制组件排版</p>\n</td>\n</tr>\n<tr>\n<td width=\"104\">\n<p><strong>标签 </strong></p>\n</td>\n<td width=\"85\">\n<p>用户界面</p>\n</td>\n<td width=\"151\">\n<p>标签1&mdash;5</p>\n</td>\n<td width=\"227\">\n<p>编辑文字，作为解说语</p>\n</td>\n</tr>\n<tr>\n<td width=\"104\">\n<p><strong>滑动条 </strong></p>\n</td>\n<td width=\"85\">\n<p>用户界面</p>\n</td>\n<td width=\"151\">\n<p>滑动条抽取</p>\n</td>\n<td width=\"227\">\n<p>控制图片精灵的显隐实现其动态切换</p>\n</td>\n</tr>\n<tr>\n<td width=\"104\">\n<p><strong>按钮 </strong></p>\n</td>\n<td width=\"85\">\n<p>用户界面</p>\n</td>\n<td width=\"151\">\n<p>按钮抽取</p>\n</td>\n<td width=\"227\">\n<p>点击切换界面</p>\n</td>\n</tr>\n<tr>\n<td width=\"104\">\n<p><strong>加速度传感器 </strong></p>\n</td>\n<td width=\"85\">\n<p>传感器</p>\n</td>\n<td width=\"151\">\n<p>加速度传感器摇一摇</p>\n</td>\n<td width=\"227\">\n<p>感应用户晃动手机行为并作出响应</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p>如下表是对各组件属性的设置情况，用户的高宽设定可根据实际使用的素材进行调整：</p>\n<table>\n<tbody>\n<tr>\n<td width=\"141\">\n<p><strong>组件 </strong></p>\n</td>\n<td width=\"412\">\n<p><strong>属性</strong><strong>设</strong><strong>置 </strong></p>\n</td>\n</tr>\n<tr>\n<td width=\"141\">\n<p><strong>水平布局xxx</strong></p>\n</td>\n<td width=\"412\">\n<p>高度设为350像素，宽度设为充满</p>\n</td>\n</tr>\n<tr>\n<td width=\"141\">\n<p><strong>垂直布局文字及输入框 </strong></p>\n</td>\n<td width=\"412\">\n<p>高度设为自动，宽度设为充满，水平对齐设为居中</p>\n</td>\n</tr>\n<tr>\n<td width=\"141\">\n<p><strong>标签1</strong><strong>&mdash;</strong><strong>5 </strong></p>\n</td>\n<td width=\"412\">\n<p>标签1&mdash;4字号设为18，标签5字号设为14，编辑好文本内容</p>\n</td>\n</tr>\n<tr>\n<td width=\"141\">\n<p><strong>滑动条抽取 </strong></p>\n</td>\n<td width=\"412\">\n<p>宽度设为充满，最大值设为9，最小值设为1并且为初始值</p>\n</td>\n</tr>\n<tr>\n<td width=\"141\">\n<p><strong>按钮抽取 </strong></p>\n</td>\n<td width=\"412\">\n<p>字号设为18</p>\n</td>\n</tr>\n<tr>\n<td width=\"141\">\n<p><strong>加速度传感器摇一摇 </strong></p>\n</td>\n<td width=\"412\">\n<p>默认设置即可，如需要可更改最小间隔及敏感度属性</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p>&nbsp;</p>\n<h2>2. sign屏幕用于显示抽签结果及进一步的分享功能。用户可以查看抽签结果，并且通过手机相关应用实现签图及文字的分享。界面效果如下：</h2>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip5-2017-11-27-19-29-41.png\" /></p>\n<p><br /> 由于签图本身是应用的素材文件，而非手机内存储的图像，不可直接用于发送。我们用画布解决了这个问题。画布有保存背景图片的功能，具体过程如下：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip6-2017-11-27-19-29-50.png\" /></p>\n<p><br /> 这样，点击&ldquo;展示&amp;分享&rdquo;按钮后，用户就可以把签图和应用自带的文字作为内容分享给好友，如下为示例：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip7-2017-11-27-19-30-02.png\" />&nbsp;&nbsp;<img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip8-2017-11-27-19-30-08.png\" /></p>\n<p>本屏幕内的组件布置情况：</p>\n<table width=\"567\">\n<tbody>\n<tr>\n<td width=\"104\">\n<p><strong>组件类型 </strong></p>\n</td>\n<td width=\"85\">\n<p><strong>组件分组 </strong></p>\n</td>\n<td width=\"151\">\n<p><strong>命名方式 </strong></p>\n</td>\n<td width=\"227\">\n<p><strong>组件功能 </strong></p>\n</td>\n</tr>\n<tr>\n<td width=\"104\">\n<p><strong>水平布局xxx </strong></p>\n</td>\n<td width=\"85\">\n<p>界面布局</p>\n</td>\n<td width=\"151\">\n<p>类型+功能</p>\n</td>\n<td width=\"227\">\n<p>控制组件排版，放置组件</p>\n</td>\n</tr>\n<tr>\n<td width=\"104\">\n<p><strong>画布 </strong></p>\n</td>\n<td width=\"85\">\n<p>绘图动画</p>\n</td>\n<td width=\"151\">\n<p>画布</p>\n</td>\n<td width=\"227\">\n<p>存储结果图片，作为文件发送</p>\n</td>\n</tr>\n<tr>\n<td width=\"104\">\n<p><strong>按钮 </strong></p>\n</td>\n<td width=\"85\">\n<p>用户界面</p>\n</td>\n<td width=\"151\">\n<p>按钮+展示分享/退出应用</p>\n</td>\n<td width=\"227\">\n<p>实现菜单功能</p>\n</td>\n</tr>\n<tr>\n<td width=\"104\">\n<p><strong>信息分享器 </strong></p>\n</td>\n<td width=\"85\">\n<p>社交应用</p>\n</td>\n<td width=\"151\">\n<p>加速度传感器摇一摇</p>\n</td>\n<td width=\"227\">\n<p>调用手机可用于分享文件及信息的应用</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p>&nbsp;</p>\n<p>如下表是对各组件属性的设置情况，用户的高宽设定可根据实际使用的素材进行调整：</p>\n<table>\n<tbody>\n<tr>\n<td width=\"141\">\n<p><strong>组件 </strong></p>\n</td>\n<td width=\"412\">\n<p><strong>属性</strong><strong>设</strong><strong>置 </strong></p>\n</td>\n</tr>\n<tr>\n<td width=\"141\">\n<p><strong>水平布局三个</strong></p>\n</td>\n<td width=\"412\">\n<p>高宽可按照用户喜好设置</p>\n</td>\n</tr>\n<tr>\n<td width=\"141\">\n<p><strong>画布 </strong></p>\n</td>\n<td width=\"412\">\n<p>背景颜色设为透明，高度设为260像素，宽度设为200像素</p>\n</td>\n</tr>\n<tr>\n<td width=\"141\">\n<p><strong>按钮两个 </strong></p>\n</td>\n<td width=\"412\">\n<p>默认设置即可</p>\n</td>\n</tr>\n<tr>\n<td width=\"141\">\n<p><strong>信息分享器分享签 </strong></p>\n</td>\n<td width=\"412\">\n<p>无组件属性，由逻辑设计控制</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p>&nbsp;</p>','http://127.0.0.1:8000/media/case_cover_picture/admin4/封面图-2017-11-27-19-30-23.jpg','2017-11-27 19:30:37.528359',13,0),(34,'App Inventor微笑应用介绍',0,0,'App Inventor微笑应用介绍','<h1 style=\"text-align: center;\">App Inventor微笑应用介绍</h1>\n<h2>一、应用描述</h2>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip0-2017-11-27-20-41-15.png\" />本应用是一个疏解心情的&ldquo;微笑&rdquo;应用，通过故事和小游戏，为用户解忧，给予鼓舞，让用户开心的微笑。下面就让我们从最基础的步骤为您讲解，如何做出一个这样的应用。</p>\n<h2>二、功能及界面介绍</h2>\n<p>本应用在给予用户快乐的同时，与之进行恰当的互动和拓展功能，各屏幕及控件使用情况列举如下：</p>\n<ol>\n<li>引入界面Screen1 屏幕（界面布局 标签 画布 按钮 计时器）</li>\n<li>故事界面storyshow屏幕（界面布局 标签 画布 图像精灵 按钮 计时器）</li>\n<li>游戏及拍照界面smile屏幕（界面布局 按钮 画布 球形精灵 标签 图像选择框 照相机）</li>\n<li>笑容展示界面smileshow屏幕（画布 图像精灵 界面布局 按钮 音效）</li>\n</ol>\n<p>本应用主要功能：</p>\n<ol>\n<li>建立一系列组件，设置其属性并设计逻辑，实现贺卡整体功能；</li>\n<li>灵活使用了较多的计时器，实现了多样功能；</li>\n<li>借助画布自身过程实现了画线；</li>\n<li>利用球形精灵完成了小游戏的设置。</li>\n</ol>\n<p>设计过程中使用的素材用户可以通过&ldquo;上传文件&rdquo;按钮自行设置，本应用的素材可从附带的aia文件中获取。接下来就让我们带着你，一起来做做看吧！</p>\n<h4>1. 首先，登录MIT App Inventor网站，新建一个项目（在整体应用设计过程中，建议用户使用有意义的命名，便于规划，例如本应用的menu屏幕）。</h4>\n<h4><br />2. 第一个屏幕Screen1是引入界面，包含引用语和切换按钮，通过界面布局控件设置界面排版，用标签显示文字。需要注意的是，本应用中，为增强美观，我们为按钮的图像属性进行了设置。</h4>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip1-2017-11-27-20-42-11.png\" /></p>\n<p><br /> 此外，我们要引入画布的新功能&mdash;&mdash;画点、画线和画圆的功能。我们设置一个空画布，通过非可视组件计时器控制其自动画线和画点，而画笔的颜色和画的位置均由随机数生成，具体代码如下：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip2-2017-11-27-20-42-19.png\" /><br /> 当然，画布的线宽等属性也可以在组件属性框内设置。随着时间推移，界面内彩色的点和线越来越多，界面的初始效果及运行一段时间后的效果如下：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip3-2017-11-27-20-42-30.png\" />&nbsp;&nbsp;<img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip4-2017-11-27-20-42-34.png\" /></p>\n<p>画布在App Inventor中是一个功能较强大的绘图组件，加入适当的创意，就可以获得生动的效果。图像精灵合理显示，展示了类似于幻灯片播放的效果。 实现如下：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip5-2017-11-27-20-42-40.png\" /><br /> 小提示：在进行逻辑设计时对冗长重复代码块进行折叠操作可使界面简洁有条理，更加直观，便于掌控。</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip6-2017-11-27-20-42-48.png\" /></p>\n<h4><br />3. 点击&ldquo;不放弃&rdquo;进入smile屏幕，这一界面功能较多，有小游戏的特殊设置。 初始界面如下：</h4>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip7-2017-11-27-20-43-08.png\" /></p>\n<p>本屏幕内的图像选择框组件可以让用户从手机内部相册里选择图片。</p>\n<p>如果用户直接点击&ldquo;微笑&rdquo;或&ldquo;从相册内寻找笑脸&rdquo;按钮，在用户完成拍照或完成照片选取后，会直接跳转至下一屏幕smileshow并且传递图像作为下一屏幕初始值。</p>\n<p><br /> 但是如果用户点击下方第一个按钮，游戏界面和游戏规则将会弹出，游戏界面在画布里设置，包含一个正在运动的球形精灵，这是一个十分灵活的组件，可以与外界进行交互。界面效果如下：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip8-2017-11-27-20-43-17.png\" /><br /> 小球以一定速度运动，与边界碰撞后被反弹，用户成功点击小球三次后，游戏界面被隐藏（重新点击按钮可重复进行游戏），弹出如下界面：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip9-2017-11-27-20-43-23.png\" /><br /> 具体实现的代码如下：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip10-2017-11-27-20-43-30.png\" /></p>\n<p>下面以此屏幕为例，介绍一下其内各组件的布置情况。</p>\n<table width=\"567\">\n<tbody>\n<tr>\n<td width=\"104\">\n<p><strong>组件类型 </strong></p>\n</td>\n<td width=\"85\">\n<p><strong>组件分组 </strong></p>\n</td>\n<td width=\"170\">\n<p><strong>命名方式 </strong></p>\n</td>\n<td width=\"208\">\n<p><strong>组件功能 </strong></p>\n</td>\n</tr>\n<tr>\n<td width=\"104\">\n<p><strong>水平/垂直布局 </strong></p>\n</td>\n<td width=\"85\">\n<p>界面布局</p>\n</td>\n<td width=\"170\">\n<p>类型+功能</p>\n</td>\n<td width=\"208\">\n<p>设置布局，放置控件 &nbsp;</p>\n</td>\n</tr>\n<tr>\n<td width=\"104\">\n<p><strong>按钮 </strong></p>\n</td>\n<td width=\"85\">\n<p>用户界面</p>\n</td>\n<td width=\"170\">\n<p>按钮微笑，按钮讲笑话</p>\n</td>\n<td width=\"208\">\n<p>菜单功能</p>\n</td>\n</tr>\n<tr>\n<td width=\"104\">\n<p><strong>画布 </strong></p>\n</td>\n<td width=\"85\">\n<p>绘图动画</p>\n</td>\n<td width=\"170\">\n<p>画布设置游戏</p>\n</td>\n<td width=\"208\">\n<p>小游戏界面，用于放置球形精灵</p>\n</td>\n</tr>\n<tr>\n<td width=\"104\">\n<p><strong>球形精灵 </strong></p>\n</td>\n<td width=\"85\">\n<p>绘图动画</p>\n</td>\n<td width=\"170\">\n<p>球形精灵设置游戏</p>\n</td>\n<td width=\"208\">\n<p>作为小游戏主题与外界进行交互</p>\n</td>\n</tr>\n<tr>\n<td width=\"104\">\n<p><strong>标签 </strong></p>\n</td>\n<td width=\"85\">\n<p>用户界面</p>\n</td>\n<td width=\"170\">\n<p>标签+功能</p>\n</td>\n<td width=\"208\">\n<p>显示文字</p>\n</td>\n</tr>\n<tr>\n<td width=\"104\">\n<p><strong>图像选择框 </strong></p>\n</td>\n<td width=\"85\">\n<p>多媒体</p>\n</td>\n<td width=\"170\">\n<p>图像选择框从相册选取</p>\n</td>\n<td width=\"208\">\n<p>从手机相册内选取图片</p>\n</td>\n</tr>\n<tr>\n<td width=\"104\">\n<p><strong>照相机</strong></p>\n</td>\n<td width=\"85\">\n<p>多媒体</p>\n</td>\n<td width=\"170\">\n<p>照相机微笑拍照</p>\n</td>\n<td width=\"208\">\n<p>调用手机相机进行拍照</p>\n</td>\n</tr>\n</tbody>\n</table>\n<p>如下表是对各组件属性的设置情况，用户的实际设定可根据喜好和实际需求进行调整：</p>\n<table>\n<tbody>\n<tr>\n<td width=\"151\">\n<p><strong>组件 </strong></p>\n</td>\n<td width=\"402\">\n<p><strong>属性</strong><strong>设</strong><strong>置 </strong></p>\n</td>\n</tr>\n<tr>\n<td width=\"151\">\n<p><strong>水平/垂直布局若干 </strong></p>\n</td>\n<td width=\"402\">\n<p>高度、宽度均按用户喜好进行设置，实现排版</p>\n</td>\n</tr>\n<tr>\n<td width=\"151\">\n<p><strong>按钮两个 </strong></p>\n</td>\n<td width=\"402\">\n<p>添加图片，高宽自定</p>\n</td>\n</tr>\n<tr>\n<td width=\"151\">\n<p><strong>画布设置游戏 </strong></p>\n</td>\n<td width=\"402\">\n<p>高度设为170像素，宽度为充满</p>\n</td>\n</tr>\n<tr>\n<td width=\"151\">\n<p><strong>球形精灵设置游戏 </strong></p>\n</td>\n<td width=\"402\">\n<p>半径设为5像素，速度设为每秒移动15像素，方向设为右偏上45度，x\\y坐标设为155和90，约为画布中心位置，画笔颜色选择青色 &nbsp;</p>\n</td>\n</tr>\n<tr>\n<td width=\"151\">\n<p><strong>标签两个 </strong></p>\n</td>\n<td width=\"402\">\n<p>默认设置，适当调整字号</p>\n</td>\n</tr>\n<tr>\n<td width=\"151\">\n<p><strong>图像选择框从相册选取 </strong></p>\n</td>\n<td width=\"402\">\n<p>高度设为36像素，宽度设为240像素</p>\n</td>\n</tr>\n<tr>\n<td width=\"151\">\n<p><strong>照相机微笑拍照 </strong></p>\n</td>\n<td width=\"402\">\n<p>默认设置</p>\n</td>\n</tr>\n</tbody>\n</table>\n<h4><br />5. 最后一个屏幕smileshow，在默认模板后方设置z坐标更小的照片进行显示，用音效播放短音乐。效果如下：</h4>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip11-2017-11-27-20-43-57.png\" /><br /> 代码参考：</p>\n<p><img src=\"http://127.0.0.1:8000/media/rich_text_picture/admin4/mceclip12-2017-11-27-20-44-03.png\" /></p>\n<p>这样，一个微笑应用就完成了，是不是很有效？分享给你的朋友，分享更多的笑容吧。</p>','http://127.0.0.1:8000/media/case_cover_picture/admin4/封面图-2017-11-27-20-40-25.jpg','2017-11-27 20:44:37.808347',13,0);
/*!40000 ALTER TABLE `cases_cases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cases_casescategory`
--

DROP TABLE IF EXISTS `cases_casescategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cases_casescategory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `code` varchar(30) NOT NULL,
  `desc` longtext NOT NULL,
  `category_type` int(11) NOT NULL,
  `is_tab` tinyint(1) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  `parent_category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cases_casescategory_parent_category_id_59913834_fk_cases_cas` (`parent_category_id`),
  CONSTRAINT `cases_casescategory_parent_category_id_59913834_fk_cases_cas` FOREIGN KEY (`parent_category_id`) REFERENCES `cases_casescategory` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cases_casescategory`
--

LOCK TABLES `cases_casescategory` WRITE;
/*!40000 ALTER TABLE `cases_casescategory` DISABLE KEYS */;
INSERT INTO `cases_casescategory` VALUES (1,'教育','jiao_yu','',1,0,'2017-10-25 23:34:18.365400',NULL),(2,'语文','yu_wen','',2,0,'2017-10-25 23:34:18.519407',1),(3,'数学','shu_xue','',2,0,'2017-10-25 23:34:18.561400',1),(4,'英语','ying_yu','',2,0,'2017-10-25 23:34:18.696394',1),(5,'物理','wu_li','',2,0,'2017-10-25 23:34:18.767393',1),(6,'化学','hua_xue','',2,0,'2017-10-25 23:34:18.818432',1),(7,'生物','sheng_wu','',2,0,'2017-10-25 23:34:18.859501',1),(8,'历史','li_shi','',2,0,'2017-10-25 23:34:18.907428',1),(9,'政治','zheng_zhi','',2,0,'2017-10-25 23:34:18.948398',1),(10,'地理','di_li','',2,0,'2017-10-25 23:34:18.995488',1),(11,'计算机','ji_suan_ji','',2,0,'2017-10-25 23:34:19.036508',1),(12,'生活','sheng_huo','',1,0,'2017-10-25 23:34:19.084511',NULL),(13,'节日祝福','jie_ri_zhu_fu','',2,0,'2017-10-25 23:34:19.125532',12),(14,'浏览器','liu_lan_qi','',2,0,'2017-10-25 23:34:19.173517',12),(15,'动态壁纸','dong_tai_bi_zhi','',2,0,'2017-10-25 23:34:19.213519',12),(16,'天气','tian_qi','',2,0,'2017-10-25 23:34:19.261531',12),(17,'播放器','bo_fang_qi','',2,0,'2017-10-25 23:34:19.324609',12),(18,'通话通讯','tong_hua_tong_xun','',2,0,'2017-10-25 23:34:19.372527',12),(19,'社交网络','she_jiao_wang_luo','',2,0,'2017-10-25 23:34:19.413532',12),(20,'主题插件','zhu_ti_cha_jian','',2,0,'2017-10-25 23:34:19.527539',12),(21,'拍摄美化','pai_she_mei_hua','',2,0,'2017-10-25 23:34:19.859554',12),(22,'新闻资讯','xin_wen_zi_xun','',2,0,'2017-10-25 23:34:19.978562',12),(23,'图书阅读','tu_shu_yue_du','',2,0,'2017-10-25 23:34:20.069567',12),(24,'办公','ban_gong','',2,0,'2017-10-25 23:34:20.133574',12),(25,'网购支付','wang_gou_zhi_fu','',2,0,'2017-10-25 23:34:20.202575',12),(26,'金融理财','jin_rong_li_cai','',2,0,'2017-10-25 23:34:20.244606',12),(27,'游戏','you_xi','',1,0,'2017-10-25 23:34:20.287649',NULL),(28,'手机网游','shou_ji_wang_you','',2,0,'2017-10-25 23:34:20.335583',27),(29,'益智游戏','yi_zhi_you_xi','',2,0,'2017-10-25 23:34:20.376613',27),(30,'射击游戏','she_ji_you_xi','',2,0,'2017-10-25 23:34:20.423588',27),(31,'策略游戏','ce_lue_you_xi','',2,0,'2017-10-25 23:34:20.501613',27),(32,'动作冒险','dong_zuo_mao_xian','',2,0,'2017-10-25 23:34:20.646609',27),(33,'赛车竞速','sai_che_jing_su','',2,0,'2017-10-25 23:34:20.711602',27),(34,'模拟经营','mo_ni_jing_ying','',2,0,'2017-10-25 23:34:20.800637',27),(35,'角色扮演','jue_se_ban_yan','',2,0,'2017-10-25 23:34:20.866707',27),(36,'体育运动','ti_yu_yun_dong','',2,0,'2017-10-25 23:34:20.921647',27),(37,'棋牌桌游','qi_pai_zhuo_you','',2,0,'2017-10-25 23:34:20.963651',27),(38,'虚拟养成','xu_ni_yang_cheng','',2,0,'2017-10-25 23:34:21.010649',27),(39,'音乐游戏','yin_yue_you_xi','',2,0,'2017-10-25 23:34:21.052275',27),(40,'对战格斗','dui_zhan_ge_dou','',2,0,'2017-10-25 23:34:21.099150',27),(41,'辅助工具','fu_zhu_gong_ju','',2,0,'2017-10-25 23:34:21.141446',27);
/*!40000 ALTER TABLE `cases_casescategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cases_casesimage`
--

DROP TABLE IF EXISTS `cases_casesimage`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cases_casesimage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `image` varchar(100) DEFAULT NULL,
  `add_time` datetime(6) NOT NULL,
  `cases_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `cases_casesimage_cases_id_9af892bc_fk_cases_cases_id` (`cases_id`),
  CONSTRAINT `cases_casesimage_cases_id_9af892bc_fk_cases_cases_id` FOREIGN KEY (`cases_id`) REFERENCES `cases_cases` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cases_casesimage`
--

LOCK TABLES `cases_casesimage` WRITE;
/*!40000 ALTER TABLE `cases_casesimage` DISABLE KEYS */;
/*!40000 ALTER TABLE `cases_casesimage` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cases_hotsearchwords`
--

DROP TABLE IF EXISTS `cases_hotsearchwords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cases_hotsearchwords` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `keywords` varchar(20) NOT NULL,
  `index` int(11) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cases_hotsearchwords`
--

LOCK TABLES `cases_hotsearchwords` WRITE;
/*!40000 ALTER TABLE `cases_hotsearchwords` DISABLE KEYS */;
/*!40000 ALTER TABLE `cases_hotsearchwords` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (2,'auth','group'),(1,'auth','permission'),(19,'authtoken','token'),(20,'captcha','captchastore'),(7,'cases','banner'),(8,'cases','cases'),(9,'cases','casescategory'),(10,'cases','casesimage'),(11,'cases','hotsearchwords'),(12,'cases','indexad'),(3,'contenttypes','contenttype'),(4,'sessions','session'),(6,'users','smsverifycode'),(5,'users','userprofile'),(13,'user_operation','userfav'),(14,'user_operation','userleavingmessage'),(15,'xadmin','bookmark'),(16,'xadmin','log'),(17,'xadmin','usersettings'),(18,'xadmin','userwidget');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2017-10-25 23:30:09.016742'),(2,'contenttypes','0002_remove_content_type_name','2017-10-25 23:30:10.662508'),(3,'auth','0001_initial','2017-10-25 23:30:17.448822'),(4,'auth','0002_alter_permission_name_max_length','2017-10-25 23:30:18.497320'),(5,'auth','0003_alter_user_email_max_length','2017-10-25 23:30:18.549401'),(6,'auth','0004_alter_user_username_opts','2017-10-25 23:30:18.606490'),(7,'auth','0005_alter_user_last_login_null','2017-10-25 23:30:18.660500'),(8,'auth','0006_require_contenttypes_0002','2017-10-25 23:30:18.707662'),(9,'auth','0007_alter_validators_add_error_messages','2017-10-25 23:30:18.760663'),(10,'auth','0008_alter_user_username_max_length','2017-10-25 23:30:18.818753'),(11,'users','0001_initial','2017-10-25 23:30:28.088715'),(12,'authtoken','0001_initial','2017-10-25 23:30:30.067800'),(13,'authtoken','0002_auto_20160226_1747','2017-10-25 23:30:31.784248'),(14,'cases','0001_initial','2017-10-25 23:30:50.502660'),(15,'sessions','0001_initial','2017-10-25 23:30:51.536687'),(16,'user_operation','0001_initial','2017-10-25 23:30:52.523249'),(17,'user_operation','0002_auto_20171021_2051','2017-10-25 23:31:00.178070'),(18,'xadmin','0001_initial','2017-10-25 23:31:13.332702'),(19,'users','0002_auto_20171105_1822','2017-11-05 18:22:52.555090'),(20,'captcha','0001_initial','2017-11-12 11:10:20.332706'),(21,'cases','0002_auto_20171114_1739','2017-11-14 17:40:15.960270'),(22,'user_operation','0003_auto_20171114_1739','2017-11-14 17:40:17.612533'),(23,'cases','0003_auto_20171124_0005','2017-11-24 00:05:39.452009'),(24,'cases','0004_cases_reply_num','2017-11-24 18:20:02.480445');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('4gnaz2cy9qgb2n70lhvk8a5rg1ormxnx','OTRiMWRlNzQyMjYxN2I4MDgxYTY5NWU3YzU4ZDMwNmEwYjA0Y2MwZDp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoidXNlcnMudmlld3MuQ3VzdG9tQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImQyNjcwZTgyODRmNzE0ODc3ZWU1NjY0NGZjMGZlMTgwMWE2NGE4NDMiLCJMSVNUX1FVRVJZIjpbWyJjYXNlcyIsImNhc2VzIl0sIiJdfQ==','2017-12-06 12:08:03.270157'),('biyyajra0mb1h4a740fuo0e5lbmfax9r','NjY5NTJmNGRiMjllMDZjMzZiNWNjN2RhZmU4ODUwN2UzZTUzOTU2ODp7InBpY3R1cmVfY29kZSI6ImNZa1EifQ==','2017-11-26 00:03:05.627455'),('lh03sz5k7f3f93buzhtfu9ehwkr1r5bd','ZGFkZTQ1MWNkNzgyZDkzODQyY2ViYWI3Nzg3M2Q3OGVlNzRmNzJlNTp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoidXNlcnMudmlld3MuQ3VzdG9tQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImQyNjcwZTgyODRmNzE0ODc3ZWU1NjY0NGZjMGZlMTgwMWE2NGE4NDMiLCJMSVNUX1FVRVJZIjpbWyJjYXNlcyIsImJhbm5lciJdLCIiXX0=','2017-12-08 00:12:44.592700'),('rrjiigorai55pqycg7x8l8it5vjga5jj','OTRiMWRlNzQyMjYxN2I4MDgxYTY5NWU3YzU4ZDMwNmEwYjA0Y2MwZDp7Il9hdXRoX3VzZXJfaWQiOiI0IiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoidXNlcnMudmlld3MuQ3VzdG9tQmFja2VuZCIsIl9hdXRoX3VzZXJfaGFzaCI6ImQyNjcwZTgyODRmNzE0ODc3ZWU1NjY0NGZjMGZlMTgwMWE2NGE4NDMiLCJMSVNUX1FVRVJZIjpbWyJjYXNlcyIsImNhc2VzIl0sIiJdfQ==','2017-11-28 17:50:02.641571');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_operation_userfav`
--

DROP TABLE IF EXISTS `user_operation_userfav`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_operation_userfav` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `add_time` datetime(6) NOT NULL,
  `goods_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_operation_userfav_user_id_goods_id_2dbadda7_uniq` (`user_id`,`goods_id`),
  KEY `user_operation_userfav_goods_id_57fc554f_fk_cases_cases_id` (`goods_id`),
  CONSTRAINT `user_operation_userfav_goods_id_57fc554f_fk_cases_cases_id` FOREIGN KEY (`goods_id`) REFERENCES `cases_cases` (`id`),
  CONSTRAINT `user_operation_userfav_user_id_4e4de070_fk_users_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `users_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_operation_userfav`
--

LOCK TABLES `user_operation_userfav` WRITE;
/*!40000 ALTER TABLE `user_operation_userfav` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_operation_userfav` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_smsverifycode`
--

DROP TABLE IF EXISTS `users_smsverifycode`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_smsverifycode` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `code` varchar(10) NOT NULL,
  `mobile` varchar(11) NOT NULL,
  `add_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_smsverifycode`
--

LOCK TABLES `users_smsverifycode` WRITE;
/*!40000 ALTER TABLE `users_smsverifycode` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_smsverifycode` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_userprofile`
--

DROP TABLE IF EXISTS `users_userprofile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_userprofile` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `name` varchar(30) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `gender` varchar(6) NOT NULL,
  `mobile` varchar(11) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_userprofile`
--

LOCK TABLES `users_userprofile` WRITE;
/*!40000 ALTER TABLE `users_userprofile` DISABLE KEYS */;
INSERT INTO `users_userprofile` VALUES (1,'pbkdf2_sha256$36000$Muf7mwCADlPm$Ig8zikCvVJWpVtxUtxR2NoMjKNIVLC0BBYxq7OAVRMI=',NULL,1,'admin1','','',1,1,'2017-11-12 12:53:43.782807',NULL,NULL,'female',NULL,NULL),(2,'pbkdf2_sha256$36000$GXjlQwqaBeVx$Q/4E7D58o+cvT4pjf9nIN2/wGqbT7qXMGdcUUSyoVLo=',NULL,1,'admin2','','',1,1,'2017-11-12 14:49:55.686171',NULL,NULL,'female','18826075157',NULL),(3,'pbkdf2_sha256$36000$IgLKFircksvd$DXmGUjIH5sNbXI0VYYkBetAvxk/6L7mybpZv0VXEiB4=',NULL,1,'admin3','','',1,1,'2017-11-12 15:54:29.082657',NULL,NULL,'female','18826075157',NULL),(4,'pbkdf2_sha256$36000$p1EZZ7Wr63uC$qLO7lerTxrvhl5/Mx7KNDabavGbi2JKQNYFkTIfURcI=','2017-11-23 23:50:33.694422',1,'admin4','','',1,1,'2017-11-12 16:20:32.189836',NULL,NULL,'female','18826075157',NULL),(5,'pbkdf2_sha256$36000$ue2R18amMDkY$RWKOdIpS+omY5F0DGNkK0m67XFlIzeV852Bq0tmc/L4=',NULL,1,'admin5','','',1,1,'2017-11-13 13:43:07.065287',NULL,NULL,'female','18826075157',NULL),(6,'pbkdf2_sha256$36000$msQz2hLtVg1I$a75XOT/Amg1/6P19kWf+c9Zqm3F9GCXse/rWpEU4KGo=',NULL,1,'admin6','','',1,1,'2017-11-13 14:00:13.542330',NULL,NULL,'female','1882607515',NULL),(7,'pbkdf2_sha256$36000$5zRcWy9y3KNp$Gy8o3X7/MdTkF7qQ57qDPcpQC4zBTZzQwXNRjovGblw=',NULL,1,'admin10','','',1,1,'2017-11-13 21:38:53.676614',NULL,NULL,'female','18826075157',NULL),(8,'pbkdf2_sha256$36000$Gp6Ug3v5oFmz$oX8Yd/JwvQjZVc48ZK4ARco4r3iJ6M9vFuVimdSS7Pk=',NULL,0,'admin11','','',0,1,'2017-11-16 20:15:34.817996',NULL,NULL,'female','18826075157',NULL),(9,'pbkdf2_sha256$36000$8Ok9VVagg1qG$gGM8J20D39BFs4HphmPkgArcz2zzzEZUsVkStwTO/vI=',NULL,0,'18826075157','','',0,1,'2017-11-16 20:17:36.058623',NULL,NULL,'female','18826075157',NULL),(10,'pbkdf2_sha256$36000$erJxOmbwzSqA$ZiKV4momsOT9PldiW2LI+EN9kBza5gKCL5sC0HyAWMQ=',NULL,0,'admin99','','',0,1,'2017-11-16 22:02:08.622873',NULL,NULL,'female','18826075157',NULL),(11,'pbkdf2_sha256$36000$Vqb4s0V1CqYE$e0CDE42q1HYDmlzJu7H+Cu/qhNNWrqttNd5B5X4A8nc=',NULL,0,'admin456','','',0,1,'2017-11-16 23:44:32.205224',NULL,NULL,'female','',NULL),(12,'pbkdf2_sha256$36000$K6H0SYiDKHqJ$VUB88+SpHn9EJVBkLlhDBdamovKkwfvFhmycARp6nQ4=',NULL,0,'admin444','','',0,1,'2017-11-16 23:46:51.933034',NULL,NULL,'female','',NULL);
/*!40000 ALTER TABLE `users_userprofile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_userprofile_groups`
--

DROP TABLE IF EXISTS `users_userprofile_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_userprofile_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userprofile_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_userprofile_groups_userprofile_id_group_id_823cf2fc_uniq` (`userprofile_id`,`group_id`),
  KEY `users_userprofile_groups_group_id_3de53dbf_fk_auth_group_id` (`group_id`),
  CONSTRAINT `users_userprofile_gr_userprofile_id_a4496a80_fk_users_use` FOREIGN KEY (`userprofile_id`) REFERENCES `users_userprofile` (`id`),
  CONSTRAINT `users_userprofile_groups_group_id_3de53dbf_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_userprofile_groups`
--

LOCK TABLES `users_userprofile_groups` WRITE;
/*!40000 ALTER TABLE `users_userprofile_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_userprofile_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_userprofile_user_permissions`
--

DROP TABLE IF EXISTS `users_userprofile_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_userprofile_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userprofile_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_userprofile_user_p_userprofile_id_permissio_d0215190_uniq` (`userprofile_id`,`permission_id`),
  KEY `users_userprofile_us_permission_id_393136b6_fk_auth_perm` (`permission_id`),
  CONSTRAINT `users_userprofile_us_permission_id_393136b6_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `users_userprofile_us_userprofile_id_34544737_fk_users_use` FOREIGN KEY (`userprofile_id`) REFERENCES `users_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_userprofile_user_permissions`
--

LOCK TABLES `users_userprofile_user_permissions` WRITE;
/*!40000 ALTER TABLE `users_userprofile_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_userprofile_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_bookmark`
--

DROP TABLE IF EXISTS `xadmin_bookmark`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xadmin_bookmark` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `url_name` varchar(64) NOT NULL,
  `query` varchar(1000) NOT NULL,
  `is_share` tinyint(1) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `xadmin_bookmark_content_type_id_60941679_fk_django_co` (`content_type_id`),
  KEY `xadmin_bookmark_user_id_42d307fc_fk_users_userprofile_id` (`user_id`),
  CONSTRAINT `xadmin_bookmark_content_type_id_60941679_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `xadmin_bookmark_user_id_42d307fc_fk_users_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `users_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_bookmark`
--

LOCK TABLES `xadmin_bookmark` WRITE;
/*!40000 ALTER TABLE `xadmin_bookmark` DISABLE KEYS */;
/*!40000 ALTER TABLE `xadmin_bookmark` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_log`
--

DROP TABLE IF EXISTS `xadmin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xadmin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `ip_addr` char(39) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` varchar(32) NOT NULL,
  `message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `xadmin_log_content_type_id_2a6cb852_fk_django_content_type_id` (`content_type_id`),
  KEY `xadmin_log_user_id_bb16a176_fk_users_userprofile_id` (`user_id`),
  CONSTRAINT `xadmin_log_content_type_id_2a6cb852_fk_django_content_type_id` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `xadmin_log_user_id_bb16a176_fk_users_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `users_userprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_log`
--

LOCK TABLES `xadmin_log` WRITE;
/*!40000 ALTER TABLE `xadmin_log` DISABLE KEYS */;
INSERT INTO `xadmin_log` VALUES (1,'2017-11-24 00:10:22.653320','127.0.0.1','2','你想了解App Inventor2哪一方面？','create','已添加',7,4),(2,'2017-11-24 00:11:47.859976','127.0.0.1','3','深度解密2015年App Inventor应用开发全国中学生挑战赛-高中组特等奖作品','create','已添加',7,4),(3,'2017-11-24 00:12:44.063625','127.0.0.1','4','用App Inventor设计开发移动教育软件','create','已添加',7,4);
/*!40000 ALTER TABLE `xadmin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_usersettings`
--

DROP TABLE IF EXISTS `xadmin_usersettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xadmin_usersettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(256) NOT NULL,
  `value` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `xadmin_usersettings_user_id_edeabe4a_fk_users_userprofile_id` (`user_id`),
  CONSTRAINT `xadmin_usersettings_user_id_edeabe4a_fk_users_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `users_userprofile` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_usersettings`
--

LOCK TABLES `xadmin_usersettings` WRITE;
/*!40000 ALTER TABLE `xadmin_usersettings` DISABLE KEYS */;
INSERT INTO `xadmin_usersettings` VALUES (1,'dashboard:home:pos','',4);
/*!40000 ALTER TABLE `xadmin_usersettings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `xadmin_userwidget`
--

DROP TABLE IF EXISTS `xadmin_userwidget`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `xadmin_userwidget` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_id` varchar(256) NOT NULL,
  `widget_type` varchar(50) NOT NULL,
  `value` longtext NOT NULL,
  `user_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `xadmin_userwidget_user_id_c159233a_fk_users_userprofile_id` (`user_id`),
  CONSTRAINT `xadmin_userwidget_user_id_c159233a_fk_users_userprofile_id` FOREIGN KEY (`user_id`) REFERENCES `users_userprofile` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `xadmin_userwidget`
--

LOCK TABLES `xadmin_userwidget` WRITE;
/*!40000 ALTER TABLE `xadmin_userwidget` DISABLE KEYS */;
/*!40000 ALTER TABLE `xadmin_userwidget` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-05 19:36:28
