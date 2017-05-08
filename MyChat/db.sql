/*
SQLyog Ultimate v11.33 (64 bit)
MySQL - 5.1.49-community : Database - mychat
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`mychat` /*!40100 DEFAULT CHARACTER SET utf8 */;


USE `mychat`;

/*Table structure for table `chatmessage` */

DROP TABLE IF EXISTS `chatmessage`;

CREATE TABLE `chatmessage` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(20) DEFAULT NULL COMMENT '用户名',
  `avatar` varchar(100) DEFAULT NULL COMMENT '头像',
  `timestamp` varchar(50) DEFAULT NULL COMMENT '时间戳,用此时间获取标准时间',
  `content` varchar(255) DEFAULT NULL COMMENT '消息内容',
  `unreadpoint` int(11) DEFAULT NULL COMMENT '是否未读,用于离线消息,0已读,1未读',
  `type` int(11) DEFAULT NULL COMMENT '消息类型,1.用户消息  2.群组消息',
  `toid` int(255) DEFAULT NULL COMMENT '对方/接受消息的id',
  `from` int(255) DEFAULT NULL COMMENT '我的id',
  `unreadnumbers` varchar(200) DEFAULT NULL COMMENT '针对群组,此消息的未读人员',
  PRIMARY KEY (`id`),
  KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=337 DEFAULT CHARSET=utf8;

/*Data for the table `chatmessage` */

insert  into `chatmessage`(`id`,`username`,`avatar`,`timestamp`,`content`,`unreadpoint`,`type`,`toid`,`from`,`unreadnumbers`) values (1,'huage','/mychat/imgs/3.jpg','1493862976031','hello',0,1,2,1,'0'),(9,'huage','/mychat/imgs/3.jpg','1493862976031','groupmsg',0,2,1,1,'0'),(13,'陆离','/mychat/imgs/1.jpg','1493878332706','hi,I love you~',0,1,1,2,'0'),(14,'陆离','/mychat/imgs/1.jpg','1493878383658','love you always',0,1,1,2,'0'),(15,'huage','/mychat/imgs/3.jpg','1493880550367','111',0,1,2,1,NULL),(16,'huage','/mychat/imgs/3.jpg','1493880578543','222',0,1,2,1,NULL),(17,'huage','/mychat/imgs/3.jpg','1493881716009','1111',0,2,1,1,''),(18,'huage','/mychat/imgs/3.jpg','1493881752524','日了狗',0,2,1,1,''),(19,'huage','/mychat/imgs/3.jpg','1493886749256','img[/mychat/upload/tomcat.jpg]',0,1,2,1,NULL),(22,'huage','/mychat/imgs/3.jpg','1493945940053','I love you to~',0,1,2,1,NULL),(23,'陆离','/mychat/imgs/1.jpg','1493946170698','hello',0,1,1,2,NULL),(24,'陆离','/mychat/imgs/1.jpg','1493946178189','hi',0,1,1,2,NULL),(25,'陆离','/mychat/imgs/1.jpg','1493946237185','Let to me ??',0,1,1,2,NULL),(26,'huage','/mychat/imgs/3.jpg','1493946839300','Let to me???are you ok?',0,1,2,1,NULL),(27,'huage','/mychat/imgs/3.jpg','1493946843758','???',0,1,2,1,NULL),(28,'陆离','/mychat/imgs/1.jpg','1493946871573','face[疑问] ',0,1,1,2,NULL),(29,'陆离','/mychat/imgs/1.jpg','1493946878168','face[兔子] ',0,1,1,2,NULL),(30,'huage','/mychat/imgs/3.jpg','1493946902744','img[/mychat/upload/tomcat.jpg]',0,1,2,1,NULL),(31,'陆离','/mychat/imgs/1.jpg','1493946911931','img[/mychat/upload/tomcat.jpg]',0,1,1,2,NULL),(32,'陆离','/mychat/imgs/1.jpg','1493946963256','img[/mychat/upload/1467944460699_2354.png]',0,1,1,2,NULL),(33,'huage','/mychat/imgs/3.jpg','1493946989386','吃了没',0,2,1,1,''),(34,'陆离','/mychat/imgs/1.jpg','1493947001468','jiangyuan大傻逼',0,1,3,2,NULL),(38,'huage','/mychat/imgs/3.jpg','1493947098908','test111',0,2,1,1,''),(39,'huage','/mychat/imgs/3.jpg','1493947100297','test222',0,2,1,1,''),(40,'陆离','/mychat/imgs/1.jpg','1493947107039','test333',0,2,1,2,''),(41,'陆离','/mychat/imgs/1.jpg','1493947109952','test444',0,2,1,2,''),(42,'陆离','/mychat/imgs/1.jpg','1493947140350','33',0,2,1,2,''),(43,'陆离','/mychat/imgs/1.jpg','1493947913448','hi',0,2,1,2,''),(44,'陆离','/mychat/imgs/1.jpg','1493951218319','img[/upload/tomcat.jpg]',0,1,1,2,NULL),(45,'陆离','/mychat/imgs/1.jpg','1493954712338','hi',0,1,1,2,NULL),(46,'huage','/mychat/imgs/3.jpg','1493954719691','hi too',0,1,2,1,NULL),(47,'陆离','/mychat/imgs/1.jpg','1493954792796','img[/upload/true love code.jpg]',0,1,1,2,NULL),(48,'陆离','/mychat/imgs/1.jpg','1493954810824','img[/upload/tomcat.jpg]',0,1,1,2,NULL),(49,'陆离','/mychat/imgs/1.jpg','1493954817760','img[/upload/true love luli.jpg]',0,1,1,2,NULL),(50,'陆离','/mychat/imgs/1.jpg','1493954829843','img[/upload/true love code.jpg]',0,1,1,2,NULL),(51,'陆离','/mychat/imgs/1.jpg','1493954832859','img[/upload/1467944460699_2354.png]',0,1,1,2,NULL),(52,'陆离','/mychat/imgs/1.jpg','1493954866082','img[/upload/true love luli.jpg]',0,1,1,2,NULL),(53,'陆离','/mychat/imgs/1.jpg','1493954874288','img[/upload/1467944460699_2354.png]',0,1,1,2,NULL),(54,'陆离','/mychat/imgs/1.jpg','1493954974070','img[/upload/tomcat.jpg]',0,1,1,2,NULL),(55,'陆离','/mychat/imgs/1.jpg','1493955024013','img[/upload/tomcat.jpg]',0,1,1,2,NULL),(56,'陆离','/mychat/imgs/1.jpg','1493955027677','img[/upload/1467944460699_2354.png]',0,1,1,2,NULL),(57,'陆离','/mychat/imgs/1.jpg','1493955036695','img[/upload/1467944460699_2354.png]',0,1,1,2,NULL),(58,'陆离','/mychat/imgs/1.jpg','1493955039863','img[/upload/tomcat.jpg]',0,1,1,2,NULL),(59,'陆离','/mychat/imgs/1.jpg','1493955045692','img[/upload/true love luli.jpg]',0,1,1,2,NULL),(60,'陆离','/mychat/imgs/1.jpg','1493955062961','img[/upload/true love code.jpg]',0,1,1,2,NULL),(61,'陆离','/mychat/imgs/1.jpg','1493955099480','img[/upload/111.jpg]',0,1,1,2,NULL),(62,'陆离','/mychat/imgs/1.jpg','1493955114201','img[/upload/1 1.jpg]',0,1,1,2,NULL),(63,'陆离','/mychat/imgs/1.jpg','1493955120671','img[/upload/1.jpg]',0,1,1,2,NULL),(64,'huage','/mychat/imgs/3.jpg','1493955630674','img[/upload/1 2.jpg]',0,1,2,1,NULL),(65,'huage','/mychat/imgs/3.jpg','1493955679993','img[/upload/1.jpg]',0,1,2,1,NULL),(66,'陆离','/mychat/imgs/1.jpg','1493955943261','face[哼] ',0,1,1,2,NULL),(67,'陆离','/mychat/imgs/1.jpg','1493955946006','img[/upload/f4.png]',0,1,1,2,NULL),(68,'陆离','/mychat/imgs/1.jpg','1493955983782','大家好,我是陆离',0,2,1,2,''),(69,'陆离','/mychat/imgs/1.jpg','1493955989824','我爱huage',0,2,1,2,''),(70,'陆离','/mychat/imgs/1.jpg','1493955993313','超级爱',0,2,1,2,''),(71,'陆离','/mychat/imgs/1.jpg','1493956145249','姜源小儿',0,2,1,2,''),(72,'陆离','/mychat/imgs/1.jpg','1493956150329','哈哈哈',0,2,1,2,''),(73,'陆离','/mychat/imgs/1.jpg','1493956153185','我是你妈妈',0,2,1,2,''),(74,'陆离','/mychat/imgs/1.jpg','1493956154890','啊哈哈',0,2,1,2,''),(75,'姜源','/mychat/imgs/4.jpg','1493956440347','...',0,2,1,3,''),(76,'姜源','/mychat/imgs/4.jpg','1493956474763','咳咳',0,2,1,3,''),(77,'姜源','/mychat/imgs/4.jpg','1493956479387','我是谁都能服的么',0,2,1,3,''),(78,'姜源','/mychat/imgs/4.jpg','1493956485155','我能忍么?',0,2,1,3,''),(79,'姜源','/mychat/imgs/4.jpg','1493956492074','咳咳,好吧你是我妈...',0,2,1,3,''),(80,'huage','/mychat/imgs/3.jpg','1493956545488','儿子,我来了~face[哈哈] ',0,2,1,1,''),(81,'姜源','/mychat/imgs/4.jpg','1493956639725','爸,你好',0,2,1,3,''),(82,'陆离','/mychat/imgs/1.jpg','1493963565882','face[熊猫] ',0,1,1,2,NULL),(83,'huage','/mychat/imgs/3.jpg','1493963570758','[熊猫]',0,1,2,1,NULL),(84,'huage','/mychat/imgs/3.jpg','1493963579533','img[/upload/1.jpg]',0,1,2,1,NULL),(85,'陆离','/mychat/imgs/1.jpg','1493963586060','face[鼓掌] ',0,1,1,2,NULL),(86,'陆离','/mychat/imgs/1.jpg','1493963591435','你下线了吧',0,1,1,2,NULL),(87,'陆离','/mychat/imgs/1.jpg','1493963594089','得瑟啊',0,1,1,2,NULL),(88,'陆离','/mychat/imgs/1.jpg','1493963598193','啊哈哈',0,1,1,2,NULL),(89,'huage','/mychat/imgs/3.jpg','1493963622534','222',0,2,3,1,''),(90,'huage','/mychat/imgs/3.jpg','1493963640461','what',0,2,3,1,''),(91,'huage','/mychat/imgs/3.jpg','1493963645690','收到请回复',0,2,3,1,''),(92,'huage','/mychat/imgs/3.jpg','1493963649169','有急事',0,2,3,1,''),(93,'huage','/mychat/imgs/3.jpg','1493963659749','收到请回复,有急事',0,1,3,1,NULL),(94,'huage','/mychat/imgs/3.jpg','1493963661916','喂喂喂',0,1,3,1,NULL),(95,'姜源','/mychat/imgs/4.jpg','1493963711474','face[哼] ',0,1,1,3,NULL),(96,'姜源','/mychat/imgs/4.jpg','1493963717351','干嘛啊,泡妞的人家',0,1,1,3,NULL),(97,'姜源','/mychat/imgs/4.jpg','1493963720295','你抄到人家啦',0,1,1,3,NULL),(98,'姜源','/mychat/imgs/4.jpg','1493963722380','讨厌啊',0,1,1,3,NULL),(99,'陆离','/mychat/imgs/1.jpg','1493963728041','嘿',0,1,1,2,NULL),(100,'陆离','/mychat/imgs/1.jpg','1493963729801','在哪呢',0,1,1,2,NULL),(101,'陆离','/mychat/imgs/1.jpg','1493963732089','来找我吧',0,1,1,2,NULL),(102,'陆离','/mychat/imgs/1.jpg','1493963733786','我家里没人',0,1,1,2,NULL),(103,'陆离','/mychat/imgs/1.jpg','1493963738457','face[抱抱] ',0,1,1,2,NULL),(104,'陆离','/mychat/imgs/1.jpg','1493963773039','来嗨',0,2,1,2,''),(105,'陆离','/mychat/imgs/1.jpg','1493963780305','嗨',0,2,1,2,''),(107,'陆离','/mychat/imgs/1.jpg','1493963791234','2',0,2,1,2,''),(108,'陆离','/mychat/imgs/1.jpg','1493963808557','face[兔子] ',0,2,1,2,''),(109,'姜源','/mychat/imgs/4.jpg','1493963819564','这个可以有',0,2,1,3,''),(110,'姜源','/mychat/imgs/4.jpg','1493963821995','测试下数据',0,2,1,3,''),(111,'姜源','/mychat/imgs/4.jpg','1493963829449','多的话显示的怎么样',0,2,1,3,''),(112,'姜源','/mychat/imgs/4.jpg','1493963833612','我猜肯定没问题啦',0,2,1,3,''),(113,'姜源','/mychat/imgs/4.jpg','1493963835030','啊哈哈哈哈',0,2,1,3,''),(114,'陆离','/mychat/imgs/1.jpg','1493963841202','多线程有木有',0,2,1,2,''),(115,'陆离','/mychat/imgs/1.jpg','1493963848802','哈哈哈',0,2,1,2,''),(116,'陆离','/mychat/imgs/1.jpg','1493963851057','你说呢',0,2,1,2,''),(117,'姜源','/mychat/imgs/4.jpg','1493963862652','嗯.可以很强势啊',0,2,1,3,''),(118,'姜源','/mychat/imgs/4.jpg','1493963870963','这个聊天的要走向世界',0,2,1,3,''),(119,'姜源','/mychat/imgs/4.jpg','1493963874740','发扬中华精神',0,2,1,3,''),(120,'陆离','/mychat/imgs/1.jpg','1493963881403','英雄所见略同也',0,2,1,2,''),(121,'陆离','/mychat/imgs/1.jpg','1493963888748','好,我脑公来了哦',0,2,1,2,''),(122,'huage','/mychat/imgs/3.jpg','1493963924703','哈哈,我来了哦',0,2,1,1,''),(123,'huage','/mychat/imgs/3.jpg','1493963954083','face[抱抱] ',0,1,2,1,NULL),(124,'姜源','/mychat/imgs/4.jpg','1493963995196','img[/upload/tomcat.jpg]',0,2,1,3,''),(126,'huage','/mychat/imgs/3.jpg','1493965280713','2',0,1,2,1,NULL),(127,'陆离','/mychat/imgs/1.jpg','1493965289546','33',0,1,1,2,NULL),(128,'陆离','/mychat/imgs/1.jpg','1493965290425','444',0,1,1,2,NULL),(129,'陆离','/mychat/imgs/1.jpg','1493965291161','555',0,1,1,2,NULL),(130,'陆离','/mychat/imgs/1.jpg','1493965291857','666',0,1,1,2,NULL),(131,'陆离','/mychat/imgs/1.jpg','1493965310897','222',0,2,1,2,''),(133,'huage','/mychat/imgs/3.jpg','1493968261783','11',0,1,2,1,NULL),(155,'huage','/mychat/imgs/3.jpg','1493968275084','2',0,2,1,1,''),(156,'huage','/mychat/imgs/3.jpg','1493968275271','2',0,2,1,1,''),(157,'huage','/mychat/imgs/3.jpg','1493968275428','2',0,2,1,1,''),(158,'huage','/mychat/imgs/3.jpg','1493968275611','2',0,2,1,1,''),(159,'huage','/mychat/imgs/3.jpg','1493968275905','2',0,2,1,1,''),(160,'huage','/mychat/imgs/3.jpg','1493968276059','2',0,2,1,1,''),(161,'huage','/mychat/imgs/3.jpg','1493968276235','2',0,2,1,1,''),(162,'huage','/mychat/imgs/3.jpg','1493968276394','2',0,2,1,1,''),(163,'huage','/mychat/imgs/3.jpg','1493968276556','2',0,2,1,1,''),(164,'huage','/mychat/imgs/3.jpg','1493968276717','2',0,2,1,1,''),(165,'huage','/mychat/imgs/3.jpg','1493968276883','2',0,2,1,1,''),(166,'huage','/mychat/imgs/3.jpg','1493968277019','2',0,2,1,1,''),(167,'huage','/mychat/imgs/3.jpg','1493968277185','2',0,2,1,1,''),(168,'huage','/mychat/imgs/3.jpg','1493968277367','2',0,2,1,1,''),(169,'huage','/mychat/imgs/3.jpg','1493968277694','2',0,2,1,1,''),(170,'huage','/mychat/imgs/3.jpg','1493968277869','2',0,2,1,1,''),(171,'huage','/mychat/imgs/3.jpg','1493968278038','2',0,2,1,1,''),(172,'huage','/mychat/imgs/3.jpg','1493968278210','2',0,2,1,1,''),(173,'huage','/mychat/imgs/3.jpg','1493968278400','22',0,2,1,1,''),(174,'huage','/mychat/imgs/3.jpg','1493968278731','2',0,2,1,1,''),(175,'huage','/mychat/imgs/3.jpg','1493968278883','2',0,2,1,1,''),(176,'huage','/mychat/imgs/3.jpg','1493968279050','2',0,2,1,1,''),(177,'huage','/mychat/imgs/3.jpg','1493968279263','2',0,2,1,1,''),(178,'huage','/mychat/imgs/3.jpg','1493968279340','2',0,2,1,1,''),(179,'huage','/mychat/imgs/3.jpg','1493968280237','2',0,2,1,1,''),(184,'huage','/mychat/imgs/3.jpg','1493970664818','I love you~\nI love you~',0,1,2,1,NULL),(188,'huage','/mychat/imgs/3.jpg','1493970667492','I love you~\nI love you~',0,1,2,1,NULL),(193,'huage','/mychat/imgs/3.jpg','1493970670037','I love you~\nI love you~\nI love you~',0,1,2,1,NULL),(195,'huage','/mychat/imgs/3.jpg','1493970671708','I love you~\nI love you~',0,1,2,1,NULL),(202,'陆离','/mychat/imgs/1.jpg','1493970731894','I love you to ~',0,1,1,2,NULL),(203,'huage','/mychat/imgs/3.jpg','1493972960662','1',0,1,2,1,NULL),(204,'huage','/mychat/imgs/3.jpg','1493972960901','1',0,1,2,1,NULL),(205,'huage','/mychat/imgs/3.jpg','1493972961098','1',0,1,2,1,NULL),(206,'huage','/mychat/imgs/3.jpg','1493972961258','1',0,1,2,1,NULL),(207,'huage','/mychat/imgs/3.jpg','1493972961394','1',0,1,2,1,NULL),(208,'huage','/mychat/imgs/3.jpg','1493972961581','1',0,1,2,1,NULL),(209,'huage','/mychat/imgs/3.jpg','1493972961717','1',0,1,2,1,NULL),(210,'huage','/mychat/imgs/3.jpg','1493972962040','1',0,1,2,1,NULL),(211,'huage','/mychat/imgs/3.jpg','1493972962203','1',0,1,2,1,NULL),(212,'huage','/mychat/imgs/3.jpg','1493972962408','1',0,1,2,1,NULL),(213,'huage','/mychat/imgs/3.jpg','1493972962620','1',0,1,2,1,NULL),(214,'huage','/mychat/imgs/3.jpg','1493972962827','1',0,1,2,1,NULL),(215,'huage','/mychat/imgs/3.jpg','1493972963035','1',0,1,2,1,NULL),(216,'huage','/mychat/imgs/3.jpg','1493972963231','1',0,1,2,1,NULL),(217,'huage','/mychat/imgs/3.jpg','1493972963435','1',0,1,2,1,NULL),(218,'huage','/mychat/imgs/3.jpg','1493972963638','11',0,1,2,1,NULL),(219,'huage','/mychat/imgs/3.jpg','1493972964037','11',0,1,2,1,NULL),(220,'huage','/mychat/imgs/3.jpg','1493972964227','1',0,1,2,1,NULL),(221,'huage','/mychat/imgs/3.jpg','1493972964428','1',0,1,2,1,NULL),(222,'huage','/mychat/imgs/3.jpg','1493972964611','1',0,1,2,1,NULL),(223,'huage','/mychat/imgs/3.jpg','1493972964793','1',0,1,2,1,NULL),(224,'huage','/mychat/imgs/3.jpg','1493972964973','1',0,1,2,1,NULL),(225,'huage','/mychat/imgs/3.jpg','1493972965308','1',0,1,2,1,NULL),(226,'huage','/mychat/imgs/3.jpg','1493972965515','11',0,1,2,1,NULL),(227,'huage','/mychat/imgs/3.jpg','1493972965883','1',0,1,2,1,NULL),(228,'huage','/mychat/imgs/3.jpg','1493972966450','1',0,1,2,1,NULL),(229,'huage','/mychat/imgs/3.jpg','1493973126660','3',0,1,2,1,NULL),(230,'huage','/mychat/imgs/3.jpg','1493973126955','3',0,1,2,1,NULL),(231,'huage','/mychat/imgs/3.jpg','1493973127278','3',0,1,2,1,NULL),(232,'huage','/mychat/imgs/3.jpg','1493973127578','3',0,1,2,1,NULL),(233,'huage','/mychat/imgs/3.jpg','1493973127891','3',0,1,2,1,NULL),(234,'huage','/mychat/imgs/3.jpg','1493973128186','3',0,1,2,1,NULL),(235,'huage','/mychat/imgs/3.jpg','1493973128474','3',0,1,2,1,NULL),(236,'huage','/mychat/imgs/3.jpg','1493973128739','3',0,1,2,1,NULL),(237,'huage','/mychat/imgs/3.jpg','1493973129061','3',0,1,2,1,NULL),(238,'huage','/mychat/imgs/3.jpg','1493973129339','3',0,1,2,1,NULL),(239,'huage','/mychat/imgs/3.jpg','1493973129643','3',0,1,2,1,NULL),(240,'huage','/mychat/imgs/3.jpg','1493973129922','3',0,1,2,1,NULL),(241,'huage','/mychat/imgs/3.jpg','1493973130206','3',0,1,2,1,NULL),(242,'huage','/mychat/imgs/3.jpg','1493973130475','3',0,1,2,1,NULL),(243,'huage','/mychat/imgs/3.jpg','1493973130805','33',0,1,2,1,NULL),(244,'huage','/mychat/imgs/3.jpg','1493973131179','3',0,1,2,1,NULL),(245,'huage','/mychat/imgs/3.jpg','1493973131487','3',0,1,2,1,NULL),(246,'huage','/mychat/imgs/3.jpg','1493973131764','3',0,1,2,1,NULL),(247,'huage','/mychat/imgs/3.jpg','1493973132045','3',0,1,2,1,NULL),(248,'huage','/mychat/imgs/3.jpg','1493973132385','3',0,1,2,1,NULL),(249,'huage','/mychat/imgs/3.jpg','1493973132793','3',0,1,2,1,NULL),(250,'huage','/mychat/imgs/3.jpg','1493973133083','3',0,1,2,1,NULL),(251,'huage','/mychat/imgs/3.jpg','1493973133392','3',0,1,2,1,NULL),(252,'huage','/mychat/imgs/3.jpg','1493973133898','3',0,1,2,1,NULL),(253,'huage','/mychat/imgs/3.jpg','1493973656164','2',0,1,2,1,NULL),(254,'huage','/mychat/imgs/3.jpg','1493973656379','2',0,1,2,1,NULL),(255,'huage','/mychat/imgs/3.jpg','1493973656584','22',0,1,2,1,NULL),(256,'huage','/mychat/imgs/3.jpg','1493973656750','2',0,1,2,1,NULL),(257,'huage','/mychat/imgs/3.jpg','1493973657060','2',0,1,2,1,NULL),(258,'huage','/mychat/imgs/3.jpg','1493973657219','2',0,1,2,1,NULL),(259,'huage','/mychat/imgs/3.jpg','1493973657395','2',0,1,2,1,NULL),(260,'huage','/mychat/imgs/3.jpg','1493973657595','2',0,1,2,1,NULL),(261,'huage','/mychat/imgs/3.jpg','1493973657787','2',0,1,2,1,NULL),(262,'huage','/mychat/imgs/3.jpg','1493973657992','2',0,1,2,1,NULL),(263,'huage','/mychat/imgs/3.jpg','1493973658171','2',0,1,2,1,NULL),(264,'huage','/mychat/imgs/3.jpg','1493973658371','2',0,1,2,1,NULL),(265,'huage','/mychat/imgs/3.jpg','1493973658555','2',0,1,2,1,NULL),(266,'huage','/mychat/imgs/3.jpg','1493973658723','2',0,1,2,1,NULL),(267,'huage','/mychat/imgs/3.jpg','1493973658924','2',0,1,2,1,NULL),(268,'huage','/mychat/imgs/3.jpg','1493973659108','2',0,1,2,1,NULL),(269,'huage','/mychat/imgs/3.jpg','1493973659315','22',0,1,2,1,NULL),(270,'huage','/mychat/imgs/3.jpg','1493973659485','2',0,1,2,1,NULL),(271,'huage','/mychat/imgs/3.jpg','1493973659676','2',0,1,2,1,NULL),(272,'huage','/mychat/imgs/3.jpg','1493973659867','2',0,1,2,1,NULL),(273,'huage','/mychat/imgs/3.jpg','1493973660038','2',0,1,2,1,NULL),(274,'huage','/mychat/imgs/3.jpg','1493973660202','2',0,1,2,1,NULL),(275,'huage','/mychat/imgs/3.jpg','1493973661147','22',0,1,2,1,NULL),(276,'huage','/mychat/imgs/3.jpg','1493973831850','2',0,1,2,1,NULL),(277,'陆离','/mychat/imgs/1.jpg','1493973837714','22',0,1,1,2,NULL),(278,'陆离','/mychat/imgs/1.jpg','1493973967071','222',0,1,1,2,NULL),(279,'陆离','/mychat/imgs/1.jpg','1494033658574','hi',0,1,1,2,NULL),(280,'陆离','/mychat/imgs/1.jpg','1494033823130','521',0,1,1,2,NULL),(281,'陆离','/mychat/imgs/1.jpg','1494033823710','1',0,1,1,2,NULL),(282,'陆离','/mychat/imgs/1.jpg','1494033824236','2',0,1,1,2,NULL),(283,'陆离','/mychat/imgs/1.jpg','1494033824635','3',0,1,1,2,NULL),(284,'陆离','/mychat/imgs/1.jpg','1494033825233','4',0,1,1,2,NULL),(285,'陆离','/mychat/imgs/1.jpg','1494033825714','5',0,1,1,2,NULL),(286,'陆离','/mychat/imgs/1.jpg','1494033826285','6',0,1,1,2,NULL),(287,'陆离','/mychat/imgs/1.jpg','1494033827009','7',0,1,1,2,NULL),(288,'陆离','/mychat/imgs/1.jpg','1494033827497','8',0,1,1,2,NULL),(289,'陆离','/mychat/imgs/1.jpg','1494033827986','9',0,1,1,2,NULL),(290,'陆离','/mychat/imgs/1.jpg','1494033828833','10',0,1,1,2,NULL),(291,'陆离','/mychat/imgs/1.jpg','1494033829496','11',0,1,1,2,NULL),(292,'陆离','/mychat/imgs/1.jpg','1494033830177','12',0,1,1,2,NULL),(293,'陆离','/mychat/imgs/1.jpg','1494033830929','13',0,1,1,2,NULL),(294,'陆离','/mychat/imgs/1.jpg','1494033831817','14',0,1,1,2,NULL),(295,'陆离','/mychat/imgs/1.jpg','1494033832682','15',0,1,1,2,NULL),(296,'huage','/mychat/imgs/3.jpg','1494033834887','16',0,1,2,1,NULL),(297,'huage','/mychat/imgs/3.jpg','1494033836198','17',0,1,2,1,NULL),(298,'huage','/mychat/imgs/3.jpg','1494033837062','18',0,1,2,1,NULL),(299,'huage','/mychat/imgs/3.jpg','1494033837928','19',0,1,2,1,NULL),(300,'huage','/mychat/imgs/3.jpg','1494033838678','20',0,1,2,1,NULL),(301,'huage','/mychat/imgs/3.jpg','1494035673201','嘿',0,1,2,1,NULL),(302,'陆离','/mychat/imgs/1.jpg','1494035682761','吃饭没啊',0,1,1,2,NULL),(303,'huage','/mychat/imgs/3.jpg','1494035690725','嗯.我吃了',0,1,2,1,NULL),(304,'huage','/mychat/imgs/3.jpg','1494035699166','我在上班你在干嘛',0,1,2,1,NULL),(305,'陆离','/mychat/imgs/1.jpg','1494035706240','我现在在看手机啊',0,1,1,2,NULL),(306,'陆离','/mychat/imgs/1.jpg','1494035710832','你好好工作啊',0,1,1,2,NULL),(307,'huage','/mychat/imgs/3.jpg','1494035718821','嗯.今天风大记得多穿点哦',0,1,2,1,NULL),(308,'陆离','/mychat/imgs/1.jpg','1494035721680','知道了',0,1,1,2,NULL),(309,'huage','/mychat/imgs/3.jpg','1494035732465','其实我就想测试数据而已',0,1,2,1,NULL),(310,'陆离','/mychat/imgs/1.jpg','1494035737271','哦face[悲伤] ',0,1,1,2,NULL),(311,'huage','/mychat/imgs/3.jpg','1494035744957','萌萌别哭啊',0,1,2,1,NULL),(312,'陆离','/mychat/imgs/1.jpg','1494035750416','face[抱抱] 不哭哦',0,1,1,2,NULL),(313,'huage','/mychat/imgs/3.jpg','1494035756325','嗯乖哦',0,1,2,1,NULL),(314,'陆离','/mychat/imgs/1.jpg','1494035765671','嗯啊face[亲亲] ',0,1,1,2,NULL),(315,'huage','/mychat/imgs/3.jpg','1494035981918','儿子啊,起床没诶',0,1,3,1,NULL),(316,'huage','/mychat/imgs/3.jpg','1494036100119','face[哼] ',0,1,3,1,NULL),(317,'陆离','/mychat/imgs/1.jpg','1494036117831','儿子,起床没',0,1,3,2,NULL),(318,'huage','/mychat/imgs/3.jpg','1494036173220','儿子啊,你妹收到我消息啊',0,1,3,1,NULL),(319,'陆离','/mychat/imgs/1.jpg','1494036181401','起床没儿子',0,1,3,2,NULL),(320,'姜源','/mychat/imgs/4.jpg','1494036217400','爸,我起床了...',0,1,1,3,NULL),(321,'姜源','/mychat/imgs/4.jpg','1494036232423','妈我也起床了哦',0,1,2,3,NULL),(322,'陆离','/mychat/imgs/1.jpg','1494036240160','儿子乖啊',0,1,3,2,NULL),(323,'陆离','/mychat/imgs/1.jpg','1494036251516','img[/upload/f4.png]',0,1,3,2,NULL),(324,'huage','/mychat/imgs/3.jpg','1494036267879','233',0,1,3,1,NULL),(325,'huage','/mychat/imgs/3.jpg','1494036282158','img[/upload/1.jpg]',0,1,2,1,NULL),(326,'陆离','/mychat/imgs/1.jpg','1494036288469','img[/upload/bck2.jpeg]',0,1,1,2,NULL),(327,'2','/mychat/imgs/user.png','1494040972683','留个言~',0,1,1,9,NULL),(328,'2','/mychat/imgs/user.png','1494041002089','22',0,1,1,9,NULL),(329,'2','/mychat/imgs/user.png','1494041009169','留个言',0,1,1,9,NULL),(330,'陆离','/mychat/imgs/1.jpg','1494041331960','face[怒] ',0,1,1,2,NULL),(331,'huage','/mychat/imgs/3.jpg','1494041347943','face[挖鼻] ',0,1,2,1,NULL),(332,'陆离','/mychat/imgs/1.jpg','1494048237918','hello',0,1,1,2,NULL),(333,'huage','/mychat/imgs/3.jpg','1494048245767','hello 毛?',0,1,2,1,NULL),(334,'huage','/mychat/imgs/3.jpg','1494048250272','毛个毛?',0,1,2,1,NULL),(335,'陆离','/mychat/imgs/1.jpg','1494048252699','face[怒] ',0,1,1,2,NULL),(336,'huage','/mychat/imgs/3.jpg','1494048255587','face[晕] ',0,1,2,1,NULL);

/*Table structure for table `flock` */

DROP TABLE IF EXISTS `flock`;

CREATE TABLE `flock` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupname` varchar(30) DEFAULT NULL COMMENT '群名称',
  `avatar` varchar(100) DEFAULT NULL COMMENT '头像',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

/*Data for the table `flock` */

insert  into `flock`(`id`,`groupname`,`avatar`) values (1,'激情的java','/mychat/imgs/java.jpg'),(2,'老铁一家人','/mychat/imgs/laotie.jpg'),(3,'实现你的梦想','/mychat/imgs/dream.jpg');

/*Table structure for table `flockrefuser` */

DROP TABLE IF EXISTS `flockrefuser`;

CREATE TABLE `flockrefuser` (
  `uid` int(11) DEFAULT NULL COMMENT '用户id',
  `fid` int(11) DEFAULT NULL COMMENT '分组id'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `flockrefuser` */

insert  into `flockrefuser`(`uid`,`fid`) values (1,1),(2,1),(3,1),(6,2),(7,2),(8,2);

/*Table structure for table `friends` */

DROP TABLE IF EXISTS `friends`;

CREATE TABLE `friends` (
  `me` int(11) DEFAULT NULL,
  `friend` int(11) DEFAULT NULL,
  `groupid` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `friends` */

insert  into `friends`(`me`,`friend`,`groupid`) values (1,3,2),(2,1,1),(2,1,3),(3,1,4),(2,1,0),(2,7,0),(2,7,0),(2,7,0),(7,2,5),(2,7,3),(1,2,1),(2,1,1),(1,7,2),(7,1,6),(1,9,2),(9,1,9),(9,7,9),(7,9,5),(8,2,7),(2,8,3),(3,2,4),(2,3,3);

/*Table structure for table `group` */

DROP TABLE IF EXISTS `group`;

CREATE TABLE `group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `groupname` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

/*Data for the table `group` */

insert  into `group`(`id`,`user_id`,`groupname`) values (1,1,'家人'),(2,1,'朋友'),(3,2,'家人'),(4,3,'朋友'),(5,7,'家人'),(6,7,'朋友'),(7,8,'家人'),(8,8,'朋友'),(9,9,'家人'),(10,9,'朋友');

/*Table structure for table `message` */

DROP TABLE IF EXISTS `message`;

CREATE TABLE `message` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '消息id',
  `content` varchar(255) DEFAULT NULL COMMENT '内容',
  `uid` int(11) DEFAULT NULL COMMENT '发送给谁啊',
  `from` int(11) DEFAULT NULL COMMENT '谁发的',
  `from_group` int(11) DEFAULT NULL COMMENT '分组ID',
  `type` int(11) DEFAULT NULL COMMENT '1.请求加好友.  2.已拒绝  3.已同意',
  `remark` varchar(200) DEFAULT NULL COMMENT '附带留言',
  `href` varchar(100) DEFAULT NULL COMMENT '未知意义',
  `read` int(11) DEFAULT NULL COMMENT '是否已读 1.已读. 0.未读',
  `time` datetime DEFAULT NULL COMMENT '时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;

/*Data for the table `message` */

insert  into `message`(`id`,`content`,`uid`,`from`,`from_group`,`type`,`remark`,`href`,`read`,`time`) values (1,'申请添加你为好友',1,2,1,2,'我答应嫁给你','',1,'2019-05-21 05:21:00'),(2,'申请添加你为好友',1,2,1,3,'我们结婚吧','',1,'2019-05-21 06:21:00'),(3,'申请添加你为好友',1,2,1,2,'我爱你一辈子','',1,'2019-05-21 05:22:00'),(4,'申请添加你为好友',7,1,2,3,NULL,NULL,1,'2017-04-26 12:00:35'),(5,'申请添加你为好友',8,2,3,3,NULL,NULL,1,'2017-04-26 13:28:42'),(6,'申请添加你为好友',7,2,3,2,NULL,NULL,1,'2017-04-26 13:29:16'),(7,'申请添加你为好友',7,2,3,2,NULL,NULL,1,'2017-04-26 13:44:25'),(8,'申请添加你为好友',7,2,3,3,NULL,NULL,1,'2017-04-26 13:46:34'),(9,'申请添加你为好友',1,7,6,3,NULL,NULL,1,'2017-04-26 15:03:39'),(10,'申请添加你为好友',1,9,9,3,NULL,NULL,1,'2017-04-26 16:29:56'),(11,'申请添加你为好友',9,7,5,3,NULL,NULL,1,'2017-04-26 16:47:19'),(12,'申请添加你为好友',3,2,3,3,NULL,NULL,1,'2017-05-05 13:53:53');

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL,
  `pwd` varchar(20) DEFAULT NULL,
  `sign` varchar(200) DEFAULT NULL COMMENT '签名',
  `avatar` varchar(200) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`id`,`username`,`pwd`,`sign`,`avatar`,`status`) values (1,'huage','123','志在天涯，梦在亲人；心随宁静，随遇而安。','/mychat/imgs/3.jpg','hide'),(2,'陆离','123','this is luli~','/mychat/imgs/1.jpg','hide'),(3,'姜源','123','姜源二货!','/mychat/imgs/4.jpg','hide'),(5,'gongchen','123123','this is shabi','/mychat/imgs/4.jpg','hide'),(6,'huage','123123','this is fake','/mychat/imgs/4.jpg','hide'),(7,'321','321','hahaha','/mychat/imgs/user.png','hide'),(8,'123','123','It\'s test!','/mychat/imgs/user.png','hide'),(9,'2','2','qqqqq','/mychat/imgs/user.png','hide');

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
