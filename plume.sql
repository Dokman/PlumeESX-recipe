
/*!40101 SET NAMES utf8mb4 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`esx` /*!40100 DEFAULT CHARACTER SET latin1 */;

/*Table structure for table `addon_account` */

DROP TABLE IF EXISTS `addon_account`;

CREATE TABLE `addon_account` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `addon_account` */

insert  into `addon_account`(`name`,`label`,`shared`) values 
('bank_savings','Ahorro bancario',0),
('caution','caution',0),
('property_black_money','Argent Sale Propriété',0),
('society_ambulance','EMS',1),
('society_banker','Bank',1),
('society_cardealer','Cardealer',1),
('society_mechanic','Mechanic',1),
('society_police','Police',1),
('society_realestateagent','Agent immobilier',1),
('society_taxi','Taxi',1);

/*Table structure for table `addon_account_data` */

DROP TABLE IF EXISTS `addon_account_data`;

CREATE TABLE `addon_account_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account_name` varchar(100) DEFAULT NULL,
  `money` int(11) NOT NULL,
  `owner` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_addon_account_data_account_name_owner` (`account_name`,`owner`),
  KEY `index_addon_account_data_account_name` (`account_name`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

/*Data for the table `addon_account_data` */

insert  into `addon_account_data`(`id`,`account_name`,`money`,`owner`) values 
(1,'society_cardealer',0,NULL),
(2,'society_police',0,NULL),
(3,'society_ambulance',0,NULL),
(4,'society_mechanic',0,NULL),
(5,'society_taxi',0,NULL),
(6,'caution',0,'dd5a2e91e9aa1b6c4fc1f66e44f949954c733450'),
(7,'caution',0,'char1:5e396ab5a00ebd7885ae4df5771b1e79535be6f6'),
(8,'property_black_money',0,'char1:5e396ab5a00ebd7885ae4df5771b1e79535be6f6');

/*Table structure for table `addon_inventory` */

DROP TABLE IF EXISTS `addon_inventory`;

CREATE TABLE `addon_inventory` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `addon_inventory` */

insert  into `addon_inventory`(`name`,`label`,`shared`) values 
('property','Propriété',0),
('society_ambulance','EMS',1),
('society_cardealer','Cardealer',1),
('society_mechanic','Mechanic',1),
('society_police','Police',1),
('society_taxi','Taxi',1);

/*Table structure for table `addon_inventory_items` */

DROP TABLE IF EXISTS `addon_inventory_items`;

CREATE TABLE `addon_inventory_items` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `inventory_name` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `count` int(11) NOT NULL,
  `owner` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `index_addon_inventory_items_inventory_name_name` (`inventory_name`,`name`),
  KEY `index_addon_inventory_items_inventory_name_name_owner` (`inventory_name`,`name`,`owner`),
  KEY `index_addon_inventory_inventory_name` (`inventory_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `addon_inventory_items` */

/*Table structure for table `billing` */

DROP TABLE IF EXISTS `billing`;

CREATE TABLE `billing` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) DEFAULT NULL,
  `sender` varchar(40) NOT NULL,
  `target_type` varchar(50) NOT NULL,
  `target` varchar(40) NOT NULL,
  `label` varchar(255) NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `billing` */

/*Table structure for table `body_status` */

DROP TABLE IF EXISTS `body_status`;

CREATE TABLE `body_status` (
  `status` longtext,
  `identifier` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `body_status` */

/*Table structure for table `cardealer_vehicles` */

DROP TABLE IF EXISTS `cardealer_vehicles`;

CREATE TABLE `cardealer_vehicles` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `cardealer_vehicles` */

/*Table structure for table `datastore` */

DROP TABLE IF EXISTS `datastore`;

CREATE TABLE `datastore` (
  `name` varchar(60) NOT NULL,
  `label` varchar(100) NOT NULL,
  `shared` int(11) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `datastore` */

insert  into `datastore`(`name`,`label`,`shared`) values 
('property','Propriété',0),
('society_ambulance','EMS',1),
('society_mechanic','Mechanic',1),
('society_police','Police',1),
('society_taxi','Taxi',1);

/*Table structure for table `datastore_data` */

DROP TABLE IF EXISTS `datastore_data`;

CREATE TABLE `datastore_data` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(60) NOT NULL,
  `owner` varchar(60) DEFAULT NULL,
  `data` longtext,
  PRIMARY KEY (`id`),
  UNIQUE KEY `index_datastore_data_name_owner` (`name`,`owner`),
  KEY `index_datastore_data_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

/*Data for the table `datastore_data` */

insert  into `datastore_data`(`id`,`name`,`owner`,`data`) values 
(1,'society_police',NULL,'{}'),
(2,'society_ambulance',NULL,'{}'),
(3,'society_mechanic',NULL,'{}'),
(4,'society_taxi',NULL,'{}'),
(5,'property','char1:5e396ab5a00ebd7885ae4df5771b1e79535be6f6','{}');

/*Table structure for table `fine_types` */

DROP TABLE IF EXISTS `fine_types`;

CREATE TABLE `fine_types` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` int(11) DEFAULT NULL,
  `category` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=53 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `fine_types` */

insert  into `fine_types`(`id`,`label`,`amount`,`category`) values 
(1,'Misuse of a horn',30,0),
(2,'Illegally Crossing a continuous Line',40,0),
(3,'Driving on the wrong side of the road',250,0),
(4,'Illegal U-Turn',250,0),
(5,'Illegally Driving Off-road',170,0),
(6,'Refusing a Lawful Command',30,0),
(7,'Illegally Stopping a Vehicle',150,0),
(8,'Illegal Parking',70,0),
(9,'Failing to Yield to the right',70,0),
(10,'Failure to comply with Vehicle Information',90,0),
(11,'Failing to stop at a Stop Sign ',105,0),
(12,'Failing to stop at a Red Light',130,0),
(13,'Illegal Passing',100,0),
(14,'Driving an illegal Vehicle',100,0),
(15,'Driving without a License',1500,0),
(16,'Hit and Run',800,0),
(17,'Exceeding Speeds Over < 5 mph',90,0),
(18,'Exceeding Speeds Over 5-15 mph',120,0),
(19,'Exceeding Speeds Over 15-30 mph',180,0),
(20,'Exceeding Speeds Over > 30 mph',300,0),
(21,'Impeding traffic flow',110,1),
(22,'Public Intoxication',90,1),
(23,'Disorderly conduct',90,1),
(24,'Obstruction of Justice',130,1),
(25,'Insults towards Civilans',75,1),
(26,'Disrespecting of an LEO',110,1),
(27,'Verbal Threat towards a Civilan',90,1),
(28,'Verbal Threat towards an LEO',150,1),
(29,'Providing False Information',250,1),
(30,'Attempt of Corruption',1500,1),
(31,'Brandishing a weapon in city Limits',120,2),
(32,'Brandishing a Lethal Weapon in city Limits',300,2),
(33,'No Firearms License',600,2),
(34,'Possession of an Illegal Weapon',700,2),
(35,'Possession of Burglary Tools',300,2),
(36,'Grand Theft Auto',1800,2),
(37,'Intent to Sell/Distrube of an illegal Substance',1500,2),
(38,'Frabrication of an Illegal Substance',1500,2),
(39,'Possession of an Illegal Substance ',650,2),
(40,'Kidnapping of a Civilan',1500,2),
(41,'Kidnapping of an LEO',2000,2),
(42,'Robbery',650,2),
(43,'Armed Robbery of a Store',650,2),
(44,'Armed Robbery of a Bank',1500,2),
(45,'Assault on a Civilian',2000,3),
(46,'Assault of an LEO',2500,3),
(47,'Attempt of Murder of a Civilian',3000,3),
(48,'Attempt of Murder of an LEO',5000,3),
(49,'Murder of a Civilian',10000,3),
(50,'Murder of an LEO',30000,3),
(51,'Involuntary manslaughter',1800,3),
(52,'Fraud',2000,2);

/*Table structure for table `items` */

DROP TABLE IF EXISTS `items`;

CREATE TABLE `items` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `weight` int(11) NOT NULL DEFAULT '1',
  `rare` tinyint(4) NOT NULL DEFAULT '0',
  `can_remove` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `items` */

insert  into `items`(`name`,`label`,`weight`,`rare`,`can_remove`) values 
('alive_chicken','Living chicken',1,0,1),
('bandage','Bandage',2,0,1),
('blowpipe','Blowtorch',2,0,1),
('bread','Bread',1,0,1),
('cannabis','Cannabis',3,0,1),
('carokit','Body Kit',3,0,1),
('carotool','Tools',2,0,1),
('clothe','Cloth',1,0,1),
('copper','Copper',1,0,1),
('cutted_wood','Cut wood',1,0,1),
('diamond','Diamond',1,0,1),
('essence','Gas',1,0,1),
('fabric','Fabric',1,0,1),
('fish','Fish',1,0,1),
('fixkit','Repair Kit',3,0,1),
('fixtool','Repair Tools',2,0,1),
('gazbottle','Gas Bottle',2,0,1),
('gold','Gold',1,0,1),
('iron','Iron',1,0,1),
('marijuana','Marijuana',2,0,1),
('medikit','Medikit',2,0,1),
('packaged_chicken','Chicken fillet',1,0,1),
('packaged_plank','Packaged wood',1,0,1),
('petrol','Oil',1,0,1),
('petrol_raffin','Processed oil',1,0,1),
('phone','Phone',1,0,1),
('slaughtered_chicken','Slaughtered chicken',1,0,1),
('stone','Stone',1,0,1),
('washed_stone','Washed stone',1,0,1),
('water','Water',1,0,1),
('wood','Wood',1,0,1),
('wool','Wool',1,0,1);

/*Table structure for table `job_grades` */

DROP TABLE IF EXISTS `job_grades`;

CREATE TABLE `job_grades` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `job_name` varchar(50) DEFAULT NULL,
  `grade` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `label` varchar(50) NOT NULL,
  `salary` int(11) NOT NULL,
  `skin_male` longtext NOT NULL,
  `skin_female` longtext NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=50 DEFAULT CHARSET=latin1;

/*Data for the table `job_grades` */

insert  into `job_grades`(`id`,`job_name`,`grade`,`name`,`label`,`salary`,`skin_male`,`skin_female`) values 
(1,'unemployed',0,'unemployed','Unemployed',200,'{}','{}'),
(2,'police',0,'recruit','Recrue',20,'{}','{}'),
(3,'police',1,'officer','Officier',40,'{}','{}'),
(4,'police',2,'sergeant','Sergent',60,'{}','{}'),
(5,'police',3,'lieutenant','Lieutenant',85,'{}','{}'),
(6,'police',4,'boss','Commandant',100,'{}','{}'),
(11,'cardealer',0,'recruit','Recruit',10,'{}','{}'),
(12,'cardealer',1,'novice','Novice',25,'{}','{}'),
(13,'cardealer',2,'experienced','Experienced',40,'{}','{}'),
(14,'cardealer',3,'boss','Boss',0,'{}','{}'),
(15,'lumberjack',0,'employee','Employee',0,'{}','{}'),
(16,'fisherman',0,'employee','Employee',0,'{}','{}'),
(17,'fueler',0,'employee','Employee',0,'{}','{}'),
(18,'reporter',0,'employee','Employee',0,'{}','{}'),
(19,'tailor',0,'employee','Employee',0,'{\"mask_1\":0,\"arms\":1,\"glasses_1\":0,\"hair_color_2\":4,\"makeup_1\":0,\"face\":19,\"glasses\":0,\"mask_2\":0,\"makeup_3\":0,\"skin\":29,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":0,\"torso_1\":24,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":0,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":0,\"eyebrows_3\":0,\"pants_2\":0,\"beard_4\":0,\"torso_2\":0,\"beard_2\":6,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":36,\"tshirt_2\":0,\"beard_3\":0,\"hair_1\":2,\"hair_color_1\":0,\"pants_1\":48,\"helmet_1\":-1,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":5,\"shoes\":10,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}','{\"mask_1\":0,\"arms\":5,\"glasses_1\":5,\"hair_color_2\":4,\"makeup_1\":0,\"face\":19,\"glasses\":0,\"mask_2\":0,\"makeup_3\":0,\"skin\":29,\"helmet_2\":0,\"lipstick_4\":0,\"sex\":1,\"torso_1\":52,\"makeup_2\":0,\"bags_2\":0,\"chain_2\":0,\"ears_1\":-1,\"bags_1\":0,\"bproof_1\":0,\"shoes_2\":1,\"lipstick_2\":0,\"chain_1\":0,\"tshirt_1\":23,\"eyebrows_3\":0,\"pants_2\":0,\"beard_4\":0,\"torso_2\":0,\"beard_2\":6,\"ears_2\":0,\"hair_2\":0,\"shoes_1\":42,\"tshirt_2\":4,\"beard_3\":0,\"hair_1\":2,\"hair_color_1\":0,\"pants_1\":36,\"helmet_1\":-1,\"bproof_2\":0,\"eyebrows_4\":0,\"eyebrows_2\":0,\"decals_1\":0,\"age_2\":0,\"beard_1\":5,\"shoes\":10,\"lipstick_1\":0,\"eyebrows_1\":0,\"glasses_2\":0,\"makeup_4\":0,\"decals_2\":0,\"lipstick_3\":0,\"age_1\":0}'),
(20,'miner',0,'employee','Employee',0,'{\"tshirt_2\":1,\"ears_1\":8,\"glasses_1\":15,\"torso_2\":0,\"ears_2\":2,\"glasses_2\":3,\"shoes_2\":1,\"pants_1\":75,\"shoes_1\":51,\"bags_1\":0,\"helmet_2\":0,\"pants_2\":7,\"torso_1\":71,\"tshirt_1\":59,\"arms\":2,\"bags_2\":0,\"helmet_1\":0}','{}'),
(21,'slaughterer',0,'employee','Employee',0,'{\"age_1\":0,\"glasses_2\":0,\"beard_1\":5,\"decals_2\":0,\"beard_4\":0,\"shoes_2\":0,\"tshirt_2\":0,\"lipstick_2\":0,\"hair_2\":0,\"arms\":67,\"pants_1\":36,\"skin\":29,\"eyebrows_2\":0,\"shoes\":10,\"helmet_1\":-1,\"lipstick_1\":0,\"helmet_2\":0,\"hair_color_1\":0,\"glasses\":0,\"makeup_4\":0,\"makeup_1\":0,\"hair_1\":2,\"bproof_1\":0,\"bags_1\":0,\"mask_1\":0,\"lipstick_3\":0,\"chain_1\":0,\"eyebrows_4\":0,\"sex\":0,\"torso_1\":56,\"beard_2\":6,\"shoes_1\":12,\"decals_1\":0,\"face\":19,\"lipstick_4\":0,\"tshirt_1\":15,\"mask_2\":0,\"age_2\":0,\"eyebrows_3\":0,\"chain_2\":0,\"glasses_1\":0,\"ears_1\":-1,\"bags_2\":0,\"ears_2\":0,\"torso_2\":0,\"bproof_2\":0,\"makeup_2\":0,\"eyebrows_1\":0,\"makeup_3\":0,\"pants_2\":0,\"beard_3\":0,\"hair_color_2\":4}','{\"age_1\":0,\"glasses_2\":0,\"beard_1\":5,\"decals_2\":0,\"beard_4\":0,\"shoes_2\":0,\"tshirt_2\":0,\"lipstick_2\":0,\"hair_2\":0,\"arms\":72,\"pants_1\":45,\"skin\":29,\"eyebrows_2\":0,\"shoes\":10,\"helmet_1\":-1,\"lipstick_1\":0,\"helmet_2\":0,\"hair_color_1\":0,\"glasses\":0,\"makeup_4\":0,\"makeup_1\":0,\"hair_1\":2,\"bproof_1\":0,\"bags_1\":0,\"mask_1\":0,\"lipstick_3\":0,\"chain_1\":0,\"eyebrows_4\":0,\"sex\":1,\"torso_1\":49,\"beard_2\":6,\"shoes_1\":24,\"decals_1\":0,\"face\":19,\"lipstick_4\":0,\"tshirt_1\":9,\"mask_2\":0,\"age_2\":0,\"eyebrows_3\":0,\"chain_2\":0,\"glasses_1\":5,\"ears_1\":-1,\"bags_2\":0,\"ears_2\":0,\"torso_2\":0,\"bproof_2\":0,\"makeup_2\":0,\"eyebrows_1\":0,\"makeup_3\":0,\"pants_2\":0,\"beard_3\":0,\"hair_color_2\":4}'),
(22,'ambulance',0,'ambulance','Jr. EMT',20,'{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":8,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}','{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
(23,'ambulance',1,'doctor','EMT',40,'{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":8,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}','{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
(24,'ambulance',2,'chief_doctor','Sr. EMT',60,'{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":8,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}','{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
(25,'ambulance',3,'boss','EMT Supervisor',80,'{\"tshirt_2\":0,\"hair_color_1\":5,\"glasses_2\":3,\"shoes\":9,\"torso_2\":3,\"hair_color_2\":0,\"pants_1\":24,\"glasses_1\":4,\"hair_1\":2,\"sex\":0,\"decals_2\":0,\"tshirt_1\":15,\"helmet_1\":8,\"helmet_2\":0,\"arms\":92,\"face\":19,\"decals_1\":60,\"torso_1\":13,\"hair_2\":0,\"skin\":34,\"pants_2\":5}','{\"tshirt_2\":3,\"decals_2\":0,\"glasses\":0,\"hair_1\":2,\"torso_1\":73,\"shoes\":1,\"hair_color_2\":0,\"glasses_1\":19,\"skin\":13,\"face\":6,\"pants_2\":5,\"tshirt_1\":75,\"pants_1\":37,\"helmet_1\":57,\"torso_2\":0,\"arms\":14,\"sex\":1,\"glasses_2\":0,\"decals_1\":0,\"hair_2\":0,\"helmet_2\":0,\"hair_color_1\":0}'),
(26,'mechanic',0,'recrue','Recruit',12,'{}','{}'),
(27,'mechanic',1,'novice','Novice',24,'{}','{}'),
(28,'mechanic',2,'experimente','Experienced',36,'{}','{}'),
(29,'mechanic',3,'chief','Leader',48,'{}','{}'),
(30,'mechanic',4,'boss','Boss',0,'{}','{}'),
(31,'taxi',0,'recrue','Recruit',12,'{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":32,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":31,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":0,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":27,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}','{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(32,'taxi',1,'novice','Cabby',24,'{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":32,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":31,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":0,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":27,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}','{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(33,'taxi',2,'experimente','Experienced',36,'{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":26,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":57,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":4,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":11,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":0,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}','{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(34,'taxi',3,'uber','Uber Cabby',48,'{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":26,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":57,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":4,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":11,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":0,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}','{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(35,'taxi',4,'boss','Lead Cabby',0,'{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":29,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":31,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":4,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":1,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":0,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":0,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":0,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":4,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":10,\"pants_1\":24}','{\"hair_2\":0,\"hair_color_2\":0,\"torso_1\":57,\"bags_1\":0,\"helmet_2\":0,\"chain_2\":0,\"eyebrows_3\":0,\"makeup_3\":0,\"makeup_2\":0,\"tshirt_1\":38,\"makeup_1\":0,\"bags_2\":0,\"makeup_4\":0,\"eyebrows_4\":0,\"chain_1\":0,\"lipstick_4\":0,\"bproof_2\":0,\"hair_color_1\":0,\"decals_2\":0,\"pants_2\":1,\"age_2\":0,\"glasses_2\":0,\"ears_2\":0,\"arms\":21,\"lipstick_1\":0,\"ears_1\":-1,\"mask_2\":0,\"sex\":1,\"lipstick_3\":0,\"helmet_1\":-1,\"shoes_2\":0,\"beard_2\":0,\"beard_1\":0,\"lipstick_2\":0,\"beard_4\":0,\"glasses_1\":5,\"bproof_1\":0,\"mask_1\":0,\"decals_1\":1,\"hair_1\":0,\"eyebrows_2\":0,\"beard_3\":0,\"age_1\":0,\"tshirt_2\":0,\"skin\":0,\"torso_2\":0,\"eyebrows_1\":0,\"face\":0,\"shoes_1\":49,\"pants_1\":11}'),
(36,'banker',0,'advisor','Asesores',10,'{}','{}'),
(37,'banker',1,'banker','Banquero',20,'{}','{}'),
(38,'banker',2,'business_banker','Banquero de negocios',30,'{}','{}'),
(39,'banker',3,'trader','Comerciante',40,'{}','{}'),
(40,'banker',4,'boss','Banquero principal',0,'{}','{}'),
(46,'realestateagent',0,'location','Location',10,'{}','{}'),
(47,'realestateagent',1,'vendeur','Vendeur',25,'{}','{}'),
(48,'realestateagent',2,'gestion','Gestion',40,'{}','{}'),
(49,'realestateagent',3,'boss','Patron',0,'{}','{}');

/*Table structure for table `jobs` */

DROP TABLE IF EXISTS `jobs`;

CREATE TABLE `jobs` (
  `name` varchar(50) NOT NULL,
  `label` varchar(50) DEFAULT NULL,
  `whitelisted` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `jobs` */

insert  into `jobs`(`name`,`label`,`whitelisted`) values 
('ambulance','EMS',0),
('banker','Banquero',0),
('cardealer','Cardealer',0),
('fisherman','Fisherman',0),
('fueler','Fueler',0),
('lumberjack','Lumberjack',0),
('mechanic','Mechanic',0),
('miner','Miner',0),
('police','LSPD',0),
('realestateagent','Agent immobilier',0),
('reporter','Reporter',0),
('slaughterer','Butcher',0),
('tailor','Tailor',0),
('taxi','Taxi',0),
('unemployed','Unemployed',0);

/*Table structure for table `licenses` */

DROP TABLE IF EXISTS `licenses`;

CREATE TABLE `licenses` (
  `type` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `licenses` */

insert  into `licenses`(`type`,`label`) values 
('dmv','Driving Permit'),
('drive','Drivers License'),
('drive_bike','Motorcycle License'),
('drive_truck','Commercial Drivers License'),
('weed_processing','Weed Processing License');

/*Table structure for table `mdt_reports` */

DROP TABLE IF EXISTS `mdt_reports`;

CREATE TABLE `mdt_reports` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `char_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `incident` longtext,
  `charges` longtext,
  `author` varchar(255) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `date` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mdt_reports` */

/*Table structure for table `mdt_warrants` */

DROP TABLE IF EXISTS `mdt_warrants`;

CREATE TABLE `mdt_warrants` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `char_id` int(11) DEFAULT NULL,
  `report_id` int(11) DEFAULT NULL,
  `report_title` varchar(255) DEFAULT NULL,
  `charges` longtext,
  `date` varchar(255) DEFAULT NULL,
  `expire` varchar(255) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `mdt_warrants` */

/*Table structure for table `owned_properties` */

DROP TABLE IF EXISTS `owned_properties`;

CREATE TABLE `owned_properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double NOT NULL,
  `rented` int(11) NOT NULL,
  `owner` varchar(60) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `owned_properties` */

/*Table structure for table `owned_vehicles` */

DROP TABLE IF EXISTS `owned_vehicles`;

CREATE TABLE `owned_vehicles` (
  `owner` varchar(60) DEFAULT NULL,
  `plate` varchar(12) NOT NULL,
  `vehicle` longtext,
  `type` varchar(20) NOT NULL DEFAULT 'car',
  `job` varchar(20) DEFAULT NULL,
  `stored` tinyint(4) NOT NULL DEFAULT '0',
  `garage_id` varchar(32) NOT NULL DEFAULT 'A',
  `impound` int(1) NOT NULL DEFAULT '0',
  `park_coord` longtext,
  `isparked` int(1) DEFAULT '0',
  PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `owned_vehicles` */

/*Table structure for table `parking_meter` */

DROP TABLE IF EXISTS `parking_meter`;

CREATE TABLE `parking_meter` (
  `identifier` varchar(64) DEFAULT '',
  `plate` varchar(32) DEFAULT '',
  `vehicle` longtext,
  `coord` longtext,
  `park_coord` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `parking_meter` */

/*Table structure for table `phone_app_chat` */

DROP TABLE IF EXISTS `phone_app_chat`;

CREATE TABLE `phone_app_chat` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel` varchar(20) NOT NULL,
  `message` varchar(255) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

/*Data for the table `phone_app_chat` */

/*Table structure for table `phone_calls` */

DROP TABLE IF EXISTS `phone_calls`;

CREATE TABLE `phone_calls` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `owner` varchar(10) NOT NULL COMMENT 'Num tel proprio',
  `num` varchar(10) NOT NULL COMMENT 'Num reférence du contact',
  `incoming` int(11) NOT NULL COMMENT 'Défini si on est à l''origine de l''appels',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `accepts` int(11) NOT NULL COMMENT 'Appels accepter ou pas',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=123 DEFAULT CHARSET=utf8;

/*Data for the table `phone_calls` */

insert  into `phone_calls`(`id`,`owner`,`num`,`incoming`,`time`,`accepts`) values 
(122,'958-2806','458',1,'2021-08-14 22:40:57',0);

/*Table structure for table `phone_messages` */

DROP TABLE IF EXISTS `phone_messages`;

CREATE TABLE `phone_messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `transmitter` varchar(10) NOT NULL,
  `receiver` varchar(10) NOT NULL,
  `message` varchar(255) NOT NULL DEFAULT '0',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `isRead` int(11) NOT NULL DEFAULT '0',
  `owner` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=107 DEFAULT CHARSET=utf8;

/*Data for the table `phone_messages` */

/*Table structure for table `phone_users_contacts` */

DROP TABLE IF EXISTS `phone_users_contacts`;

CREATE TABLE `phone_users_contacts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) CHARACTER SET utf8mb4 DEFAULT NULL,
  `number` varchar(10) CHARACTER SET utf8mb4 DEFAULT NULL,
  `display` varchar(64) CHARACTER SET utf8mb4 NOT NULL DEFAULT '-1',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `phone_users_contacts` */

/*Table structure for table `private_garage` */

DROP TABLE IF EXISTS `private_garage`;

CREATE TABLE `private_garage` (
  `identifier` varchar(64) DEFAULT '',
  `vehicles` longtext,
  `garage` varchar(64) DEFAULT NULL,
  `inventory` longtext
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `private_garage` */

/*Table structure for table `properties` */

DROP TABLE IF EXISTS `properties`;

CREATE TABLE `properties` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `label` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `entering` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `exit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `inside` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `outside` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ipls` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT '[]',
  `gateway` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_single` int(11) DEFAULT NULL,
  `is_room` int(11) DEFAULT NULL,
  `is_gateway` int(11) DEFAULT NULL,
  `room_menu` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `properties` */

insert  into `properties`(`id`,`name`,`label`,`entering`,`exit`,`inside`,`outside`,`ipls`,`gateway`,`is_single`,`is_room`,`is_gateway`,`room_menu`,`price`) values 
(1,'WhispymoundDrive','2677 Whispymound Drive','{\"y\":564.89,\"z\":182.959,\"x\":119.384}','{\"x\":117.347,\"y\":559.506,\"z\":183.304}','{\"y\":557.032,\"z\":183.301,\"x\":118.037}','{\"y\":567.798,\"z\":182.131,\"x\":119.249}','[]',NULL,1,1,0,'{\"x\":118.748,\"y\":566.573,\"z\":175.697}',1500000),
(2,'NorthConkerAvenue2045','2045 North Conker Avenue','{\"x\":372.796,\"y\":428.327,\"z\":144.685}','{\"x\":373.548,\"y\":422.982,\"z\":144.907}','{\"y\":420.075,\"z\":145.904,\"x\":372.161}','{\"x\":372.454,\"y\":432.886,\"z\":143.443}','[]',NULL,1,1,0,'{\"x\":377.349,\"y\":429.422,\"z\":137.3}',1500000),
(3,'RichardMajesticApt2','Richard Majestic, Apt 2','{\"y\":-379.165,\"z\":37.961,\"x\":-936.363}','{\"y\":-365.476,\"z\":113.274,\"x\":-913.097}','{\"y\":-367.637,\"z\":113.274,\"x\":-918.022}','{\"y\":-382.023,\"z\":37.961,\"x\":-943.626}','[]',NULL,1,1,0,'{\"x\":-927.554,\"y\":-377.744,\"z\":112.674}',1700000),
(4,'NorthConkerAvenue2044','2044 North Conker Avenue','{\"y\":440.8,\"z\":146.702,\"x\":346.964}','{\"y\":437.456,\"z\":148.394,\"x\":341.683}','{\"y\":435.626,\"z\":148.394,\"x\":339.595}','{\"x\":350.535,\"y\":443.329,\"z\":145.764}','[]',NULL,1,1,0,'{\"x\":337.726,\"y\":436.985,\"z\":140.77}',1500000),
(5,'WildOatsDrive','3655 Wild Oats Drive','{\"y\":502.696,\"z\":136.421,\"x\":-176.003}','{\"y\":497.817,\"z\":136.653,\"x\":-174.349}','{\"y\":495.069,\"z\":136.666,\"x\":-173.331}','{\"y\":506.412,\"z\":135.0664,\"x\":-177.927}','[]',NULL,1,1,0,'{\"x\":-174.725,\"y\":493.095,\"z\":129.043}',1500000),
(6,'HillcrestAvenue2862','2862 Hillcrest Avenue','{\"y\":596.58,\"z\":142.641,\"x\":-686.554}','{\"y\":591.988,\"z\":144.392,\"x\":-681.728}','{\"y\":590.608,\"z\":144.392,\"x\":-680.124}','{\"y\":599.019,\"z\":142.059,\"x\":-689.492}','[]',NULL,1,1,0,'{\"x\":-680.46,\"y\":588.6,\"z\":136.769}',1500000),
(7,'LowEndApartment','Appartement de base','{\"y\":-1078.735,\"z\":28.4031,\"x\":292.528}','{\"y\":-1007.152,\"z\":-102.002,\"x\":265.845}','{\"y\":-1002.802,\"z\":-100.008,\"x\":265.307}','{\"y\":-1078.669,\"z\":28.401,\"x\":296.738}','[]',NULL,1,1,0,'{\"x\":265.916,\"y\":-999.38,\"z\":-100.008}',562500),
(8,'MadWayneThunder','2113 Mad Wayne Thunder','{\"y\":454.955,\"z\":96.462,\"x\":-1294.433}','{\"x\":-1289.917,\"y\":449.541,\"z\":96.902}','{\"y\":446.322,\"z\":96.899,\"x\":-1289.642}','{\"y\":455.453,\"z\":96.517,\"x\":-1298.851}','[]',NULL,1,1,0,'{\"x\":-1287.306,\"y\":455.901,\"z\":89.294}',1500000),
(9,'HillcrestAvenue2874','2874 Hillcrest Avenue','{\"x\":-853.346,\"y\":696.678,\"z\":147.782}','{\"y\":690.875,\"z\":151.86,\"x\":-859.961}','{\"y\":688.361,\"z\":151.857,\"x\":-859.395}','{\"y\":701.628,\"z\":147.773,\"x\":-855.007}','[]',NULL,1,1,0,'{\"x\":-858.543,\"y\":697.514,\"z\":144.253}',1500000),
(10,'HillcrestAvenue2868','2868 Hillcrest Avenue','{\"y\":620.494,\"z\":141.588,\"x\":-752.82}','{\"y\":618.62,\"z\":143.153,\"x\":-759.317}','{\"y\":617.629,\"z\":143.153,\"x\":-760.789}','{\"y\":621.281,\"z\":141.254,\"x\":-750.919}','[]',NULL,1,1,0,'{\"x\":-762.504,\"y\":618.992,\"z\":135.53}',1500000),
(11,'TinselTowersApt12','Tinsel Towers, Apt 42','{\"y\":37.025,\"z\":42.58,\"x\":-618.299}','{\"y\":58.898,\"z\":97.2,\"x\":-603.301}','{\"y\":58.941,\"z\":97.2,\"x\":-608.741}','{\"y\":30.603,\"z\":42.524,\"x\":-620.017}','[]',NULL,1,1,0,'{\"x\":-622.173,\"y\":54.585,\"z\":96.599}',1700000),
(12,'MiltonDrive','Milton Drive','{\"x\":-775.17,\"y\":312.01,\"z\":84.658}',NULL,NULL,'{\"x\":-775.346,\"y\":306.776,\"z\":84.7}','[]',NULL,0,0,1,NULL,0),
(13,'Modern1Apartment','Appartement Moderne 1',NULL,'{\"x\":-784.194,\"y\":323.636,\"z\":210.997}','{\"x\":-779.751,\"y\":323.385,\"z\":210.997}',NULL,'[\"apa_v_mp_h_01_a\"]','MiltonDrive',0,1,0,'{\"x\":-766.661,\"y\":327.672,\"z\":210.396}',1300000),
(14,'Modern2Apartment','Appartement Moderne 2',NULL,'{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}','{\"x\":-781.808,\"y\":315.866,\"z\":186.913}',NULL,'[\"apa_v_mp_h_01_c\"]','MiltonDrive',0,1,0,'{\"x\":-795.735,\"y\":326.757,\"z\":186.313}',1300000),
(15,'Modern3Apartment','Appartement Moderne 3',NULL,'{\"x\":-774.012,\"y\":342.042,\"z\":195.686}','{\"x\":-779.057,\"y\":342.063,\"z\":195.686}',NULL,'[\"apa_v_mp_h_01_b\"]','MiltonDrive',0,1,0,'{\"x\":-765.386,\"y\":330.782,\"z\":195.08}',1300000),
(16,'Mody1Apartment','Appartement Mode 1',NULL,'{\"x\":-784.194,\"y\":323.636,\"z\":210.997}','{\"x\":-779.751,\"y\":323.385,\"z\":210.997}',NULL,'[\"apa_v_mp_h_02_a\"]','MiltonDrive',0,1,0,'{\"x\":-766.615,\"y\":327.878,\"z\":210.396}',1300000),
(17,'Mody2Apartment','Appartement Mode 2',NULL,'{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}','{\"x\":-781.808,\"y\":315.866,\"z\":186.913}',NULL,'[\"apa_v_mp_h_02_c\"]','MiltonDrive',0,1,0,'{\"x\":-795.297,\"y\":327.092,\"z\":186.313}',1300000),
(18,'Mody3Apartment','Appartement Mode 3',NULL,'{\"x\":-774.012,\"y\":342.042,\"z\":195.686}','{\"x\":-779.057,\"y\":342.063,\"z\":195.686}',NULL,'[\"apa_v_mp_h_02_b\"]','MiltonDrive',0,1,0,'{\"x\":-765.303,\"y\":330.932,\"z\":195.085}',1300000),
(19,'Vibrant1Apartment','Appartement Vibrant 1',NULL,'{\"x\":-784.194,\"y\":323.636,\"z\":210.997}','{\"x\":-779.751,\"y\":323.385,\"z\":210.997}',NULL,'[\"apa_v_mp_h_03_a\"]','MiltonDrive',0,1,0,'{\"x\":-765.885,\"y\":327.641,\"z\":210.396}',1300000),
(20,'Vibrant2Apartment','Appartement Vibrant 2',NULL,'{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}','{\"x\":-781.808,\"y\":315.866,\"z\":186.913}',NULL,'[\"apa_v_mp_h_03_c\"]','MiltonDrive',0,1,0,'{\"x\":-795.607,\"y\":327.344,\"z\":186.313}',1300000),
(21,'Vibrant3Apartment','Appartement Vibrant 3',NULL,'{\"x\":-774.012,\"y\":342.042,\"z\":195.686}','{\"x\":-779.057,\"y\":342.063,\"z\":195.686}',NULL,'[\"apa_v_mp_h_03_b\"]','MiltonDrive',0,1,0,'{\"x\":-765.525,\"y\":330.851,\"z\":195.085}',1300000),
(22,'Sharp1Apartment','Appartement Persan 1',NULL,'{\"x\":-784.194,\"y\":323.636,\"z\":210.997}','{\"x\":-779.751,\"y\":323.385,\"z\":210.997}',NULL,'[\"apa_v_mp_h_04_a\"]','MiltonDrive',0,1,0,'{\"x\":-766.527,\"y\":327.89,\"z\":210.396}',1300000),
(23,'Sharp2Apartment','Appartement Persan 2',NULL,'{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}','{\"x\":-781.808,\"y\":315.866,\"z\":186.913}',NULL,'[\"apa_v_mp_h_04_c\"]','MiltonDrive',0,1,0,'{\"x\":-795.642,\"y\":326.497,\"z\":186.313}',1300000),
(24,'Sharp3Apartment','Appartement Persan 3',NULL,'{\"x\":-774.012,\"y\":342.042,\"z\":195.686}','{\"x\":-779.057,\"y\":342.063,\"z\":195.686}',NULL,'[\"apa_v_mp_h_04_b\"]','MiltonDrive',0,1,0,'{\"x\":-765.503,\"y\":331.318,\"z\":195.085}',1300000),
(25,'Monochrome1Apartment','Appartement Monochrome 1',NULL,'{\"x\":-784.194,\"y\":323.636,\"z\":210.997}','{\"x\":-779.751,\"y\":323.385,\"z\":210.997}',NULL,'[\"apa_v_mp_h_05_a\"]','MiltonDrive',0,1,0,'{\"x\":-766.289,\"y\":328.086,\"z\":210.396}',1300000),
(26,'Monochrome2Apartment','Appartement Monochrome 2',NULL,'{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}','{\"x\":-781.808,\"y\":315.866,\"z\":186.913}',NULL,'[\"apa_v_mp_h_05_c\"]','MiltonDrive',0,1,0,'{\"x\":-795.692,\"y\":326.762,\"z\":186.313}',1300000),
(27,'Monochrome3Apartment','Appartement Monochrome 3',NULL,'{\"x\":-774.012,\"y\":342.042,\"z\":195.686}','{\"x\":-779.057,\"y\":342.063,\"z\":195.686}',NULL,'[\"apa_v_mp_h_05_b\"]','MiltonDrive',0,1,0,'{\"x\":-765.094,\"y\":330.976,\"z\":195.085}',1300000),
(28,'Seductive1Apartment','Appartement Séduisant 1',NULL,'{\"x\":-784.194,\"y\":323.636,\"z\":210.997}','{\"x\":-779.751,\"y\":323.385,\"z\":210.997}',NULL,'[\"apa_v_mp_h_06_a\"]','MiltonDrive',0,1,0,'{\"x\":-766.263,\"y\":328.104,\"z\":210.396}',1300000),
(29,'Seductive2Apartment','Appartement Séduisant 2',NULL,'{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}','{\"x\":-781.808,\"y\":315.866,\"z\":186.913}',NULL,'[\"apa_v_mp_h_06_c\"]','MiltonDrive',0,1,0,'{\"x\":-795.655,\"y\":326.611,\"z\":186.313}',1300000),
(30,'Seductive3Apartment','Appartement Séduisant 3',NULL,'{\"x\":-774.012,\"y\":342.042,\"z\":195.686}','{\"x\":-779.057,\"y\":342.063,\"z\":195.686}',NULL,'[\"apa_v_mp_h_06_b\"]','MiltonDrive',0,1,0,'{\"x\":-765.3,\"y\":331.414,\"z\":195.085}',1300000),
(31,'Regal1Apartment','Appartement Régal 1',NULL,'{\"x\":-784.194,\"y\":323.636,\"z\":210.997}','{\"x\":-779.751,\"y\":323.385,\"z\":210.997}',NULL,'[\"apa_v_mp_h_07_a\"]','MiltonDrive',0,1,0,'{\"x\":-765.956,\"y\":328.257,\"z\":210.396}',1300000),
(32,'Regal2Apartment','Appartement Régal 2',NULL,'{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}','{\"x\":-781.808,\"y\":315.866,\"z\":186.913}',NULL,'[\"apa_v_mp_h_07_c\"]','MiltonDrive',0,1,0,'{\"x\":-795.545,\"y\":326.659,\"z\":186.313}',1300000),
(33,'Regal3Apartment','Appartement Régal 3',NULL,'{\"x\":-774.012,\"y\":342.042,\"z\":195.686}','{\"x\":-779.057,\"y\":342.063,\"z\":195.686}',NULL,'[\"apa_v_mp_h_07_b\"]','MiltonDrive',0,1,0,'{\"x\":-765.087,\"y\":331.429,\"z\":195.123}',1300000),
(34,'Aqua1Apartment','Appartement Aqua 1',NULL,'{\"x\":-784.194,\"y\":323.636,\"z\":210.997}','{\"x\":-779.751,\"y\":323.385,\"z\":210.997}',NULL,'[\"apa_v_mp_h_08_a\"]','MiltonDrive',0,1,0,'{\"x\":-766.187,\"y\":328.47,\"z\":210.396}',1300000),
(35,'Aqua2Apartment','Appartement Aqua 2',NULL,'{\"x\":-786.8663,\"y\":315.764,\"z\":186.913}','{\"x\":-781.808,\"y\":315.866,\"z\":186.913}',NULL,'[\"apa_v_mp_h_08_c\"]','MiltonDrive',0,1,0,'{\"x\":-795.658,\"y\":326.563,\"z\":186.313}',1300000),
(36,'Aqua3Apartment','Appartement Aqua 3',NULL,'{\"x\":-774.012,\"y\":342.042,\"z\":195.686}','{\"x\":-779.057,\"y\":342.063,\"z\":195.686}',NULL,'[\"apa_v_mp_h_08_b\"]','MiltonDrive',0,1,0,'{\"x\":-765.287,\"y\":331.084,\"z\":195.086}',1300000),
(37,'IntegrityWay','4 Integrity Way','{\"x\":-47.804,\"y\":-585.867,\"z\":36.956}',NULL,NULL,'{\"x\":-54.178,\"y\":-583.762,\"z\":35.798}','[]',NULL,0,0,1,NULL,0),
(38,'IntegrityWay28','4 Integrity Way - Apt 28',NULL,'{\"x\":-31.409,\"y\":-594.927,\"z\":79.03}','{\"x\":-26.098,\"y\":-596.909,\"z\":79.03}',NULL,'[]','IntegrityWay',0,1,0,'{\"x\":-11.923,\"y\":-597.083,\"z\":78.43}',1700000),
(39,'IntegrityWay30','4 Integrity Way - Apt 30',NULL,'{\"x\":-17.702,\"y\":-588.524,\"z\":89.114}','{\"x\":-16.21,\"y\":-582.569,\"z\":89.114}',NULL,'[]','IntegrityWay',0,1,0,'{\"x\":-26.327,\"y\":-588.384,\"z\":89.123}',1700000),
(40,'DellPerroHeights','Dell Perro Heights','{\"x\":-1447.06,\"y\":-538.28,\"z\":33.74}',NULL,NULL,'{\"x\":-1440.022,\"y\":-548.696,\"z\":33.74}','[]',NULL,0,0,1,NULL,0),
(41,'DellPerroHeightst4','Dell Perro Heights - Apt 28',NULL,'{\"x\":-1452.125,\"y\":-540.591,\"z\":73.044}','{\"x\":-1455.435,\"y\":-535.79,\"z\":73.044}',NULL,'[]','DellPerroHeights',0,1,0,'{\"x\":-1467.058,\"y\":-527.571,\"z\":72.443}',1700000),
(42,'DellPerroHeightst7','Dell Perro Heights - Apt 30',NULL,'{\"x\":-1451.562,\"y\":-523.535,\"z\":55.928}','{\"x\":-1456.02,\"y\":-519.209,\"z\":55.929}',NULL,'[]','DellPerroHeights',0,1,0,'{\"x\":-1457.026,\"y\":-530.219,\"z\":55.937}',1700000),
(43,'MazeBankBuilding','Maze Bank Building','{\"x\":-79.18,\"y\":-795.92,\"z\":43.35}',NULL,NULL,'{\"x\":-72.50,\"y\":-786.92,\"z\":43.40}','[]',NULL,0,0,1,NULL,0),
(44,'OldSpiceWarm','Old Spice Warm',NULL,'{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}','{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}',NULL,'[\"ex_dt1_11_office_01a\"]','MazeBankBuilding',0,1,0,'{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}',5000000),
(45,'OldSpiceClassical','Old Spice Classical',NULL,'{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}','{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}',NULL,'[\"ex_dt1_11_office_01b\"]','MazeBankBuilding',0,1,0,'{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}',5000000),
(46,'OldSpiceVintage','Old Spice Vintage',NULL,'{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}','{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}',NULL,'[\"ex_dt1_11_office_01c\"]','MazeBankBuilding',0,1,0,'{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}',5000000),
(47,'ExecutiveRich','Executive Rich',NULL,'{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}','{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}',NULL,'[\"ex_dt1_11_office_02b\"]','MazeBankBuilding',0,1,0,'{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}',5000000),
(48,'ExecutiveCool','Executive Cool',NULL,'{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}','{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}',NULL,'[\"ex_dt1_11_office_02c\"]','MazeBankBuilding',0,1,0,'{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}',5000000),
(49,'ExecutiveContrast','Executive Contrast',NULL,'{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}','{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}',NULL,'[\"ex_dt1_11_office_02a\"]','MazeBankBuilding',0,1,0,'{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}',5000000),
(50,'PowerBrokerIce','Power Broker Ice',NULL,'{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}','{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}',NULL,'[\"ex_dt1_11_office_03a\"]','MazeBankBuilding',0,1,0,'{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}',5000000),
(51,'PowerBrokerConservative','Power Broker Conservative',NULL,'{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}','{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}',NULL,'[\"ex_dt1_11_office_03b\"]','MazeBankBuilding',0,1,0,'{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}',5000000),
(52,'PowerBrokerPolished','Power Broker Polished',NULL,'{\"x\":-75.69,\"y\":-827.08,\"z\":242.43}','{\"x\":-75.51,\"y\":-823.90,\"z\":242.43}',NULL,'[\"ex_dt1_11_office_03c\"]','MazeBankBuilding',0,1,0,'{\"x\":-71.81,\"y\":-814.34,\"z\":242.39}',5000000),
(53,'LomBank','Lom Bank','{\"x\":-1581.36,\"y\":-558.23,\"z\":34.07}',NULL,NULL,'{\"x\":-1583.60,\"y\":-555.12,\"z\":34.07}','[]',NULL,0,0,1,NULL,0),
(54,'LBOldSpiceWarm','LB Old Spice Warm',NULL,'{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}','{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}',NULL,'[\"ex_sm_13_office_01a\"]','LomBank',0,1,0,'{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}',3500000),
(55,'LBOldSpiceClassical','LB Old Spice Classical',NULL,'{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}','{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}',NULL,'[\"ex_sm_13_office_01b\"]','LomBank',0,1,0,'{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}',3500000),
(56,'LBOldSpiceVintage','LB Old Spice Vintage',NULL,'{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}','{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}',NULL,'[\"ex_sm_13_office_01c\"]','LomBank',0,1,0,'{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}',3500000),
(57,'LBExecutiveRich','LB Executive Rich',NULL,'{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}','{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}',NULL,'[\"ex_sm_13_office_02b\"]','LomBank',0,1,0,'{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}',3500000),
(58,'LBExecutiveCool','LB Executive Cool',NULL,'{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}','{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}',NULL,'[\"ex_sm_13_office_02c\"]','LomBank',0,1,0,'{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}',3500000),
(59,'LBExecutiveContrast','LB Executive Contrast',NULL,'{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}','{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}',NULL,'[\"ex_sm_13_office_02a\"]','LomBank',0,1,0,'{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}',3500000),
(60,'LBPowerBrokerIce','LB Power Broker Ice',NULL,'{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}','{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}',NULL,'[\"ex_sm_13_office_03a\"]','LomBank',0,1,0,'{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}',3500000),
(61,'LBPowerBrokerConservative','LB Power Broker Conservative',NULL,'{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}','{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}',NULL,'[\"ex_sm_13_office_03b\"]','LomBank',0,1,0,'{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}',3500000),
(62,'LBPowerBrokerPolished','LB Power Broker Polished',NULL,'{\"x\":-1579.53,\"y\":-564.89,\"z\":107.62}','{\"x\":-1576.42,\"y\":-567.57,\"z\":107.62}',NULL,'[\"ex_sm_13_office_03c\"]','LomBank',0,1,0,'{\"x\":-1571.26,\"y\":-575.76,\"z\":107.52}',3500000),
(63,'MazeBankWest','Maze Bank West','{\"x\":-1379.58,\"y\":-499.63,\"z\":32.22}',NULL,NULL,'{\"x\":-1378.95,\"y\":-502.82,\"z\":32.22}','[]',NULL,0,0,1,NULL,0),
(64,'MBWOldSpiceWarm','MBW Old Spice Warm',NULL,'{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}','{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}',NULL,'[\"ex_sm_15_office_01a\"]','MazeBankWest',0,1,0,'{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}',2700000),
(65,'MBWOldSpiceClassical','MBW Old Spice Classical',NULL,'{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}','{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}',NULL,'[\"ex_sm_15_office_01b\"]','MazeBankWest',0,1,0,'{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}',2700000),
(66,'MBWOldSpiceVintage','MBW Old Spice Vintage',NULL,'{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}','{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}',NULL,'[\"ex_sm_15_office_01c\"]','MazeBankWest',0,1,0,'{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}',2700000),
(67,'MBWExecutiveRich','MBW Executive Rich',NULL,'{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}','{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}',NULL,'[\"ex_sm_15_office_02b\"]','MazeBankWest',0,1,0,'{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}',2700000),
(68,'MBWExecutiveCool','MBW Executive Cool',NULL,'{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}','{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}',NULL,'[\"ex_sm_15_office_02c\"]','MazeBankWest',0,1,0,'{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}',2700000),
(69,'MBWExecutive Contrast','MBW Executive Contrast',NULL,'{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}','{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}',NULL,'[\"ex_sm_15_office_02a\"]','MazeBankWest',0,1,0,'{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}',2700000),
(70,'MBWPowerBrokerIce','MBW Power Broker Ice',NULL,'{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}','{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}',NULL,'[\"ex_sm_15_office_03a\"]','MazeBankWest',0,1,0,'{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}',2700000),
(71,'MBWPowerBrokerConvservative','MBW Power Broker Convservative',NULL,'{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}','{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}',NULL,'[\"ex_sm_15_office_03b\"]','MazeBankWest',0,1,0,'{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}',2700000),
(72,'MBWPowerBrokerPolished','MBW Power Broker Polished',NULL,'{\"x\":-1392.74,\"y\":-480.18,\"z\":71.14}','{\"x\":-1389.43,\"y\":-479.01,\"z\":71.14}',NULL,'[\"ex_sm_15_office_03c\"]','MazeBankWest',0,1,0,'{\"x\":-1390.76,\"y\":-479.22,\"z\":72.04}',2700000);

/*Table structure for table `rented_vehicles` */

DROP TABLE IF EXISTS `rented_vehicles`;

CREATE TABLE `rented_vehicles` (
  `vehicle` varchar(60) NOT NULL,
  `plate` varchar(12) NOT NULL,
  `player_name` varchar(255) NOT NULL,
  `base_price` int(11) NOT NULL,
  `rent_price` int(11) NOT NULL,
  `owner` varchar(22) NOT NULL,
  PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `rented_vehicles` */

/*Table structure for table `renzu_clothes` */

DROP TABLE IF EXISTS `renzu_clothes`;

CREATE TABLE `renzu_clothes` (
  `identifier` varchar(64) NOT NULL DEFAULT '',
  `wardrobe` longtext,
  `inventory` longtext,
  PRIMARY KEY (`identifier`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `renzu_clothes` */

/*Table structure for table `renzu_customs` */

DROP TABLE IF EXISTS `renzu_customs`;

CREATE TABLE `renzu_customs` (
  `shop` varchar(64) NOT NULL,
  `inventory` longtext,
  PRIMARY KEY (`shop`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `renzu_customs` */

/*Table structure for table `renzu_jobs` */

DROP TABLE IF EXISTS `renzu_jobs`;

CREATE TABLE `renzu_jobs` (
  `name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `accounts` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `inventory` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  `garage` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `renzu_jobs` */

/*Table structure for table `saveclothes` */

DROP TABLE IF EXISTS `saveclothes`;

CREATE TABLE `saveclothes` (
  `identifier` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL,
  `wardrobe` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin,
  PRIMARY KEY (`identifier`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `saveclothes` */

/*Table structure for table `shops` */

DROP TABLE IF EXISTS `shops`;

CREATE TABLE `shops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `store` varchar(100) NOT NULL,
  `item` varchar(100) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

/*Data for the table `shops` */

insert  into `shops`(`id`,`store`,`item`,`price`) values 
(1,'TwentyFourSeven','bread',30),
(2,'TwentyFourSeven','water',15),
(3,'RobsLiquor','bread',30),
(4,'RobsLiquor','water',15),
(5,'LTDgasoline','bread',30),
(6,'LTDgasoline','water',15);

/*Table structure for table `society_moneywash` */

DROP TABLE IF EXISTS `society_moneywash`;

CREATE TABLE `society_moneywash` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) NOT NULL,
  `society` varchar(60) NOT NULL,
  `amount` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `society_moneywash` */

/*Table structure for table `twitter_accounts` */

DROP TABLE IF EXISTS `twitter_accounts`;

CREATE TABLE `twitter_accounts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) CHARACTER SET utf8 NOT NULL DEFAULT '0',
  `password` varchar(64) COLLATE utf8mb4_bin NOT NULL DEFAULT '0',
  `avatar_url` varchar(255) COLLATE utf8mb4_bin DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=38 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

/*Data for the table `twitter_accounts` */

/*Table structure for table `twitter_likes` */

DROP TABLE IF EXISTS `twitter_likes`;

CREATE TABLE `twitter_likes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) DEFAULT NULL,
  `tweetId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_twitter_likes_twitter_accounts` (`authorId`),
  KEY `FK_twitter_likes_twitter_tweets` (`tweetId`),
  CONSTRAINT `FK_twitter_likes_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`),
  CONSTRAINT `FK_twitter_likes_twitter_tweets` FOREIGN KEY (`tweetId`) REFERENCES `twitter_tweets` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=137 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin;

/*Data for the table `twitter_likes` */

/*Table structure for table `twitter_tweets` */

DROP TABLE IF EXISTS `twitter_tweets`;

CREATE TABLE `twitter_tweets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `authorId` int(11) NOT NULL,
  `realUser` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `likes` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `FK_twitter_tweets_twitter_accounts` (`authorId`),
  CONSTRAINT `FK_twitter_tweets_twitter_accounts` FOREIGN KEY (`authorId`) REFERENCES `twitter_accounts` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=170 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `twitter_tweets` */

/*Table structure for table `user_convictions` */

DROP TABLE IF EXISTS `user_convictions`;

CREATE TABLE `user_convictions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `char_id` int(11) DEFAULT NULL,
  `offense` varchar(255) DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user_convictions` */

/*Table structure for table `user_licenses` */

DROP TABLE IF EXISTS `user_licenses`;

CREATE TABLE `user_licenses` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(60) NOT NULL,
  `owner` varchar(60) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `user_licenses` */

/*Table structure for table `user_mdt` */

DROP TABLE IF EXISTS `user_mdt`;

CREATE TABLE `user_mdt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `char_id` int(11) DEFAULT NULL,
  `notes` varchar(255) DEFAULT NULL,
  `mugshot_url` varchar(255) DEFAULT NULL,
  `bail` bit(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user_mdt` */

/*Table structure for table `user_parkings` */

DROP TABLE IF EXISTS `user_parkings`;

CREATE TABLE `user_parkings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `identifier` varchar(60) DEFAULT NULL,
  `garage` varchar(60) DEFAULT NULL,
  `zone` int(11) NOT NULL,
  `vehicle` longtext,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user_parkings` */

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `identifier` varchar(60) NOT NULL,
  `accounts` longtext,
  `group` varchar(50) DEFAULT 'user',
  `inventory` longtext,
  `job` varchar(20) DEFAULT 'unemployed',
  `job_grade` int(11) DEFAULT '0',
  `loadout` longtext,
  `position` varchar(255) DEFAULT '{"x":-269.4,"y":-955.3,"z":31.2,"heading":205.8}',
  `firstname` varchar(16) DEFAULT NULL,
  `lastname` varchar(16) DEFAULT NULL,
  `dateofbirth` varchar(10) DEFAULT NULL,
  `sex` varchar(1) DEFAULT NULL,
  `height` int(11) DEFAULT NULL,
  `skin` longtext,
  `status` longtext,
  `is_dead` tinyint(1) DEFAULT '0',
  `phone_number` varchar(10) DEFAULT NULL,
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `last_property` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`identifier`),
  UNIQUE KEY `id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

/*Data for the table `users` */

/*Table structure for table `vehicle_categories` */

DROP TABLE IF EXISTS `vehicle_categories`;

CREATE TABLE `vehicle_categories` (
  `name` varchar(60) NOT NULL,
  `label` varchar(60) NOT NULL,
  PRIMARY KEY (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `vehicle_categories` */

insert  into `vehicle_categories`(`name`,`label`) values 
('compacts','Compacts'),
('coupes','Coupés'),
('motorcycles','Motos'),
('muscle','Muscle'),
('offroad','Off Road'),
('sedans','Sedans'),
('sports','Sports'),
('sportsclassics','Sports Classics'),
('super','Super'),
('suvs','SUVs'),
('vans','Vans');

/*Table structure for table `vehicle_mdt` */

DROP TABLE IF EXISTS `vehicle_mdt`;

CREATE TABLE `vehicle_mdt` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `plate` varchar(255) DEFAULT NULL,
  `stolen` bit(1) DEFAULT b'0',
  `notes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `vehicle_mdt` */

/*Table structure for table `vehicle_sold` */

DROP TABLE IF EXISTS `vehicle_sold`;

CREATE TABLE `vehicle_sold` (
  `client` varchar(50) NOT NULL,
  `model` varchar(50) NOT NULL,
  `plate` varchar(50) NOT NULL,
  `soldby` varchar(50) NOT NULL,
  `date` varchar(50) NOT NULL,
  PRIMARY KEY (`plate`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `vehicle_sold` */

/*Table structure for table `vehicle_status` */

DROP TABLE IF EXISTS `vehicle_status`;

CREATE TABLE `vehicle_status` (
  `stats` longtext,
  `plate` varchar(64) NOT NULL DEFAULT '',
  `owner` varchar(64) NOT NULL DEFAULT '',
  PRIMARY KEY (`plate`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

/*Data for the table `vehicle_status` */

/*Table structure for table `vehicles` */

DROP TABLE IF EXISTS `vehicles`;

CREATE TABLE `vehicles` (
  `name` varchar(60) NOT NULL,
  `model` varchar(60) NOT NULL,
  `price` int(11) NOT NULL,
  `category` varchar(60) DEFAULT NULL,
  `shop` varchar(32) NOT NULL DEFAULT 'pdm',
  `stock` int(11) NOT NULL DEFAULT '100',
  PRIMARY KEY (`model`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `vehicles` */

insert  into `vehicles`(`name`,`model`,`price`,`category`,`shop`,`stock`) values 
('Adder','adder',900000,'super','pdm',100),
('Akuma','AKUMA',7500,'motorcycles','pdm',100),
('Alpha','alpha',60000,'sports','pdm',100),
('Ardent','ardent',1150000,'sportsclassics','pdm',100),
('asbo','asbo',8000,'compacts','pdm',100),
('Asea','asea',5500,'sedans','pdm',100),
('asterope','asterope',45000,'sedans','pdm',100),
('Autarch','autarch',1955000,'super','pdm',100),
('Avarus','avarus',18000,'motorcycles','pdm',100),
('Bagger','bagger',13500,'motorcycles','pdm',100),
('Baller','baller2',40000,'suvs','pdm',100),
('Baller Sport','baller3',60000,'suvs','pdm',100),
('Baller Sport','baller4',60000,'suvs','pdm',100),
('Banshee','banshee',70000,'sports','pdm',100),
('Banshee 900R','banshee2',255000,'super','pdm',100),
('Bati 801','bati',12000,'motorcycles','pdm',100),
('Bati 801RR','bati2',19000,'motorcycles','pdm',100),
('Bestia GTS','bestiagts',55000,'sports','pdm',100),
('BF400','bf400',6500,'motorcycles','pdm',100),
('Bf Injection','bfinjection',16000,'offroad','pdm',100),
('Bifta','bifta',12000,'offroad','pdm',100),
('Bison','bison',45000,'vans','pdm',100),
('bison2','bison2',20000,'vans','pdm',100),
('bjxl','bjxl',45000,'suvs','pdm',100),
('Blade','blade',15000,'muscle','pdm',100),
('Blazer','blazer',6500,'offroad','pdm',100),
('Blazer Sport','blazer4',8500,'offroad','pdm',100),
('blazer5','blazer5',1755600,'offroad','pdm',100),
('Blista','blista',8000,'compacts','pdm',100),
('blista2','blista2',45000,'sports','pdm',100),
('blista3','blista3',45000,'sports','pdm',100),
('BMX','bmx',160,'cycles','pdm',100),
('Bobcat XL','bobcatxl',32000,'vans','pdm',100),
('bodhi2','bodhi2',45000,'offroad','pdm',100),
('Brawler','brawler',45000,'offroad','pdm',100),
('Brioso R/A','brioso',18000,'compacts','pdm',100),
('brioso2','brioso2',8000,'compacts','pdm',100),
('Btype','btype',62000,'sportsclassics','pdm',100),
('Btype Hotroad','btype2',155000,'sportsclassics','pdm',100),
('Btype Luxe','btype3',85000,'sportsclassics','pdm',100),
('Buccaneer','buccaneer',18000,'muscle','pdm',100),
('Buccaneer Rider','buccaneer2',24000,'muscle','pdm',100),
('Buffalo','buffalo',12000,'sports','pdm',100),
('Buffalo S','buffalo2',20000,'sports','pdm',100),
('Buffalo3','buffalo3',20000,'sports','pdm',100),
('Bullet','bullet',90000,'super','pdm',100),
('burrito2','burrito2',20000,'vans','pdm',100),
('Burrito','burrito3',19000,'vans','pdm',100),
('burrito4','burrito4',20000,'vans','pdm',100),
('calico','calico',2000,'sports','pdm',100),
('Camper','camper',42000,'vans','pdm',100),
('caracara2','caracara2',20000,'offroad','pdm',100),
('Carbonizzare','carbonizzare',75000,'sports','pdm',100),
('Carbon RS','carbonrs',18000,'motorcycles','pdm',100),
('Casco','casco',30000,'sportsclassics','pdm',100),
('cavalcade','cavalcade',45000,'suvs','pdm',100),
('Cavalcade','cavalcade2',55000,'suvs','pdm',100),
('Cheburek','cheburek',20000,'sedans','pdm',100),
('Cheetah','cheetah',375000,'super','pdm',100),
('cheetah2','cheetah2',20000,'sports','pdm',100),
('Chimera','chimera',38000,'motorcycles','pdm',100),
('Chino','chino',15000,'muscle','pdm',100),
('Chino Luxe','chino2',19000,'muscle','pdm',100),
('Cliffhanger','cliffhanger',9500,'motorcycles','pdm',100),
('clique','clique',45000,'muscle','pdm',100),
('club','club',8000,'compacts','pdm',100),
('cog55','cog55',45000,'sedans','pdm',100),
('Cognoscenti Cabrio','cogcabrio',55000,'coupes','pdm',100),
('Cognoscenti','cognoscenti',55000,'sedans','pdm',100),
('Comet','comet2',65000,'sports','pdm',100),
('Comet 5','comet5',145000,'sports','pdm',100),
('comet6','comet6',2000,'sports','pdm',100),
('Contender','contender',70000,'suvs','pdm',100),
('Coquette','coquette',65000,'sports','pdm',100),
('Coquette Classic','coquette2',40000,'sportsclassics','pdm',100),
('Coquette BlackFin','coquette3',55000,'muscle','pdm',100),
('Cruiser','cruiser',510,'cycles','pdm',100),
('Cyclone','cyclone',1890000,'super','pdm',100),
('cypher','cypher',2000,'sports','pdm',100),
('Daemon','daemon',11500,'motorcycles','pdm',100),
('Daemon High','daemon2',13500,'motorcycles','pdm',100),
('Defiler','defiler',9800,'motorcycles','pdm',100),
('Deluxo','deluxo',4721500,'sportsclassics','pdm',100),
('deveste','deveste',20000,'sports','pdm',100),
('deviant','deviant',45000,'muscle','pdm',100),
('diablous','diablous',45000,'motorcycles','pdm',100),
('diablous2','diablous2',45000,'motorcycles','pdm',100),
('dilettante','dilettante',8000,'compacts','pdm',100),
('dloader','dloader',45000,'offroad','pdm',100),
('Dominator','dominator',35000,'muscle','pdm',100),
('dominator2','dominator2',45000,'muscle','pdm',100),
('dominator3','dominator3',45000,'muscle','pdm',100),
('dominator7','dominator7',2000,'sports','pdm',100),
('dominator8','dominator8',2000,'sports','pdm',100),
('Double T','double',28000,'motorcycles','pdm',100),
('drafter','drafter',20000,'sports','pdm',100),
('Dubsta','dubsta',45000,'suvs','pdm',100),
('Dubsta Luxuary','dubsta2',60000,'suvs','pdm',100),
('Bubsta 6x6','dubsta3',120000,'offroad','pdm',100),
('Dukes','dukes',28000,'muscle','pdm',100),
('dukes3','dukes3',45000,'muscle','pdm',100),
('Dune Buggy','dune',8000,'offroad','pdm',100),
('dynasty','dynasty',20000,'sports','pdm',100),
('elegy','elegy',20000,'sports','pdm',100),
('Elegy','elegy2',38500,'sports','pdm',100),
('ellie','ellie',45000,'muscle','pdm',100),
('emerus','emerus',20000,'super','pdm',100),
('Emperor','emperor',8500,'sedans','pdm',100),
('emperor2','emperor2',45000,'sedans','pdm',100),
('Enduro','enduro',5500,'motorcycles','pdm',100),
('entity2','entity2',20000,'super','pdm',100),
('Entity XF','entityxf',425000,'super','pdm',100),
('Esskey','esskey',4200,'motorcycles','pdm',100),
('euros','euros',2000,'sports','pdm',100),
('everon','everon',45000,'offroad','pdm',100),
('Exemplar','exemplar',32000,'coupes','pdm',100),
('F620','f620',40000,'coupes','pdm',100),
('Faction','faction',20000,'muscle','pdm',100),
('Faction Rider','faction2',30000,'muscle','pdm',100),
('Faction XL','faction3',40000,'muscle','pdm',100),
('fagaloa','fagaloa',20000,'sports','pdm',100),
('Faggio','faggio',1900,'motorcycles','pdm',100),
('Vespa','faggio2',2800,'motorcycles','pdm',100),
('faggio3','faggio3',45000,'motorcycles','pdm',100),
('fcr','fcr',45000,'motorcycles','pdm',100),
('fcr2','fcr2',45000,'motorcycles','pdm',100),
('Felon','felon',42000,'coupes','pdm',100),
('Felon GT','felon2',55000,'coupes','pdm',100),
('Feltzer','feltzer2',55000,'sports','pdm',100),
('Stirling GT','feltzer3',65000,'sportsclassics','pdm',100),
('Fixter','fixter',225,'cycles','pdm',100),
('flashgt','flashgt',20000,'sports','pdm',100),
('FMJ','fmj',185000,'super','pdm',100),
('Fhantom','fq2',17000,'suvs','pdm',100),
('freecrawler','freecrawler',45000,'offroad','pdm',100),
('Fugitive','fugitive',12000,'sedans','pdm',100),
('furia','furia',20000,'super','pdm',100),
('Furore GT','furoregt',45000,'sports','pdm',100),
('Fusilade','fusilade',40000,'sports','pdm',100),
('futo','futo',20000,'sports','pdm',100),
('futo2','futo2',2000,'sports','pdm',100),
('Gargoyle','gargoyle',16500,'motorcycles','pdm',100),
('Gauntlet','gauntlet',30000,'muscle','pdm',100),
('gauntlet2','gauntlet2',45000,'muscle','pdm',100),
('gauntlet3','gauntlet3',45000,'muscle','pdm',100),
('gauntlet4','gauntlet4',45000,'muscle','pdm',100),
('gauntlet5','gauntlet5',45000,'muscle','pdm',100),
('gb200','gb200',20000,'sports','pdm',100),
('Gang Burrito','gburrito',45000,'vans','pdm',100),
('Burrito','gburrito2',29000,'vans','pdm',100),
('Glendale','glendale',6500,'sedans','pdm',100),
('glendale2','glendale2',45000,'sedans','pdm',100),
('gp1','gp1',20000,'super','pdm',100),
('Grabger','granger',50000,'suvs','pdm',100),
('Gresley','gresley',47500,'suvs','pdm',100),
('growler','growler',2000,'sports','pdm',100),
('GT 500','gt500',785000,'sportsclassics','pdm',100),
('Guardian','guardian',450000,'offroad','pdm',100),
('habanero','habanero',45000,'suvs','pdm',100),
('Hakuchou','hakuchou',31000,'motorcycles','pdm',100),
('Hakuchou Sport','hakuchou2',55000,'motorcycles','pdm',100),
('hellion','hellion',45000,'offroad','pdm',100),
('Hermes','hermes',535000,'muscle','pdm',100),
('Hexer','hexer',12000,'motorcycles','pdm',100),
('Hotknife','hotknife',125000,'muscle','pdm',100),
('hotring','hotring',20000,'sports','pdm',100),
('Huntley S','huntley',40000,'suvs','pdm',100),
('Hustler','hustler',625000,'muscle','pdm',100),
('imorgon','imorgon',20000,'sports','pdm',100),
('impaler','impaler',45000,'muscle','pdm',100),
('Infernus','infernus',180000,'super','pdm',100),
('infernus2','infernus2',20000,'sports','pdm',100),
('ingot','ingot',45000,'sedans','pdm',100),
('Innovation','innovation',23500,'motorcycles','pdm',100),
('Intruder','intruder',7500,'sedans','pdm',100),
('Issi','issi2',10000,'compacts','pdm',100),
('issi3','issi3',8000,'compacts','pdm',100),
('issi7','issi7',20000,'sports','pdm',100),
('italigtb','italigtb',20000,'super','pdm',100),
('italigtb2','italigtb2',20000,'super','pdm',100),
('italigto','italigto',20000,'sports','pdm',100),
('italirsx','italirsx',20000,'sports','pdm',100),
('Jackal','jackal',38000,'coupes','pdm',100),
('Jester','jester',65000,'sports','pdm',100),
('Jester(Racecar)','jester2',135000,'sports','pdm',100),
('jester3','jester3',20000,'sports','pdm',100),
('jester4','jester4',2000,'sports','pdm',100),
('Journey','journey',6500,'vans','pdm',100),
('jugular','jugular',20000,'sports','pdm',100),
('kalahari','kalahari',45000,'offroad','pdm',100),
('Kamacho','kamacho',345000,'offroad','pdm',100),
('kanjo','kanjo',8000,'compacts','pdm',100),
('Khamelion','khamelion',38000,'sports','pdm',100),
('komoda','komoda',20000,'sports','pdm',100),
('krieger','krieger',20000,'super','pdm',100),
('Kuruma','kuruma',30000,'sports','pdm',100),
('Landstalker','landstalker',35000,'suvs','pdm',100),
('landstalker2','landstalker2',45000,'suvs','pdm',100),
('RE-7B','le7b',325000,'super','pdm',100),
('locust','locust',20000,'sports','pdm',100),
('Lynx','lynx',40000,'sports','pdm',100),
('Mamba','mamba',70000,'sports','pdm',100),
('Manana','manana',12800,'sportsclassics','pdm',100),
('manana2','manana2',20000,'sports','pdm',100),
('Manchez','manchez',5300,'motorcycles','pdm',100),
('Manchez2','manchez2',5300,'motorcycles','pdm',100),
('Massacro','massacro',65000,'sports','pdm',100),
('Massacro(Racecar)','massacro2',130000,'sports','pdm',100),
('Mesa','mesa',16000,'suvs','pdm',100),
('Mesa Trail','mesa3',40000,'suvs','pdm',100),
('michelli','michelli',20000,'sports','pdm',100),
('Minivan','minivan',13000,'vans','pdm',100),
('minivan2','minivan2',20000,'vans','pdm',100),
('Monroe','monroe',55000,'sportsclassics','pdm',100),
('The Liberator','monster',210000,'offroad','pdm',100),
('Moonbeam','moonbeam',18000,'vans','pdm',100),
('Moonbeam Rider','moonbeam2',35000,'vans','pdm',100),
('nebula','nebula',20000,'sports','pdm',100),
('Nemesis','nemesis',5800,'motorcycles','pdm',100),
('Neon','neon',1500000,'sports','pdm',100),
('nero','nero',20000,'super','pdm',100),
('nero2','nero2',20000,'super','pdm',100),
('Nightblade','nightblade',35000,'motorcycles','pdm',100),
('Nightshade','nightshade',65000,'muscle','pdm',100),
('9F','ninef',65000,'sports','pdm',100),
('9F Cabrio','ninef2',80000,'sports','pdm',100),
('novak','novak',45000,'suvs','pdm',100),
('Omnis','omnis',35000,'sports','pdm',100),
('Oppressor','oppressor',3524500,'super','pdm',100),
('oracle','oracle',45000,'coupes','pdm',100),
('Oracle XS','oracle2',35000,'coupes','pdm',100),
('Osiris','osiris',160000,'super','pdm',100),
('outlaw','outlaw',45000,'offroad','pdm',100),
('Panto','panto',10000,'compacts','pdm',100),
('Paradise','paradise',19000,'vans','pdm',100),
('paragon','paragon',20000,'sports','pdm',100),
('Pariah','pariah',1420000,'sports','pdm',100),
('Patriot','patriot',55000,'suvs','pdm',100),
('patriot2','patriot2',45000,'suvs','pdm',100),
('PCJ-600','pcj',6200,'motorcycles','pdm',100),
('penetrator','penetrator',20000,'super','pdm',100),
('Penumbra','penumbra',28000,'sports','pdm',100),
('penumbra2','penumbra2',20000,'sports','pdm',100),
('peyote','peyote',20000,'sports','pdm',100),
('peyote2','peyote2',45000,'muscle','pdm',100),
('peyote3','peyote3',20000,'sports','pdm',100),
('Pfister','pfister811',85000,'super','pdm',100),
('Phoenix','phoenix',12500,'muscle','pdm',100),
('Picador','picador',18000,'muscle','pdm',100),
('Pigalle','pigalle',20000,'sportsclassics','pdm',100),
('pony','pony',20000,'vans','pdm',100),
('pony2','pony2',20000,'vans','pdm',100),
('Prairie','prairie',12000,'compacts','pdm',100),
('Premier','premier',8000,'sedans','pdm',100),
('previon','previon',2000,'sports','pdm',100),
('primo','primo',45000,'sedans','pdm',100),
('Primo Custom','primo2',14000,'sedans','pdm',100),
('X80 Proto','prototipo',2500000,'super','pdm',100),
('Radius','radi',29000,'suvs','pdm',100),
('raiden','raiden',1375000,'sports','pdm',100),
('rancherxl','rancherxl',45000,'offroad','pdm',100),
('Rapid GT','rapidgt',35000,'sports','pdm',100),
('Rapid GT Convertible','rapidgt2',45000,'sports','pdm',100),
('Rapid GT3','rapidgt3',885000,'sportsclassics','pdm',100),
('raptor','raptor',20000,'sports','pdm',100),
('ratbike','ratbike',45000,'motorcycles','pdm',100),
('ratloader','ratloader',45000,'muscle','pdm',100),
('ratloader2','ratloader2',45000,'muscle','pdm',100),
('Reaper','reaper',150000,'super','pdm',100),
('rebel','rebel',45000,'offroad','pdm',100),
('Rebel','rebel2',35000,'offroad','pdm',100),
('rebla','rebla',45000,'suvs','pdm',100),
('Regina','regina',5000,'sedans','pdm',100),
('remus','remus',2000,'sports','pdm',100),
('Retinue','retinue',615000,'sportsclassics','pdm',100),
('retinue2','retinue2',20000,'sports','pdm',100),
('Revolter','revolter',1610000,'sports','pdm',100),
('rhapsody','rhapsody',8000,'compacts','pdm',100),
('riata','riata',380000,'offroad','pdm',100),
('Rocoto','rocoto',45000,'suvs','pdm',100),
('rt3000','rt3000',2000,'sports','pdm',100),
('Ruffian','ruffian',6800,'motorcycles','pdm',100),
('ruiner','ruiner',45000,'muscle','pdm',100),
('Ruiner 2','ruiner2',5745600,'muscle','pdm',100),
('ruiner3','ruiner3',45000,'muscle','pdm',100),
('Rumpo','rumpo',15000,'vans','pdm',100),
('rumpo2','rumpo2',20000,'vans','pdm',100),
('Rumpo Trail','rumpo3',19500,'vans','pdm',100),
('ruston','ruston',20000,'sports','pdm',100),
('s80','s80',20000,'super','pdm',100),
('Sabre Turbo','sabregt',20000,'muscle','pdm',100),
('Sabre GT','sabregt2',25000,'muscle','pdm',100),
('Sanchez','sanchez',5300,'motorcycles','pdm',100),
('Sanchez Sport','sanchez2',5300,'motorcycles','pdm',100),
('Sanctus','sanctus',25000,'motorcycles','pdm',100),
('Sandking','sandking',55000,'offroad','pdm',100),
('sandking2','sandking2',45000,'offroad','pdm',100),
('Savestra','savestra',990000,'sportsclassics','pdm',100),
('SC 1','sc1',1603000,'super','pdm',100),
('Schafter','schafter2',25000,'sedans','pdm',100),
('Schafter V12','schafter3',50000,'sports','pdm',100),
('schafter4','schafter4',20000,'sports','pdm',100),
('schlagen','schlagen',20000,'sports','pdm',100),
('schwarzer','schwarzer',20000,'sports','pdm',100),
('Scorcher','scorcher',280,'cycles','pdm',100),
('Seminole','seminole',25000,'suvs','pdm',100),
('seminole2','seminole2',45000,'suvs','pdm',100),
('Sentinel','sentinel',32000,'coupes','pdm',100),
('Sentinel XS','sentinel2',40000,'coupes','pdm',100),
('Sentinel3','sentinel3',650000,'sports','pdm',100),
('serrano','serrano',45000,'suvs','pdm',100),
('Seven 70','seven70',39500,'sports','pdm',100),
('ETR1','sheava',220000,'super','pdm',100),
('Shotaro Concept','shotaro',320000,'motorcycles','pdm',100),
('Slam Van','slamvan3',11500,'muscle','pdm',100),
('Sovereign','sovereign',22000,'motorcycles','pdm',100),
('specter','specter',20000,'sports','pdm',100),
('specter2','specter2',20000,'sports','pdm',100),
('speedo','speedo',20000,'vans','pdm',100),
('speedo2','speedo2',20000,'vans','pdm',100),
('speedo4','speedo4',20000,'vans','pdm',100),
('squaddie','squaddie',45000,'suvs','pdm',100),
('stafford','stafford',45000,'sedans','pdm',100),
('stalion','stalion',45000,'muscle','pdm',100),
('Stalion2','stalion2',45000,'muscle','pdm',100),
('stanier','stanier',45000,'sedans','pdm',100),
('Stinger','stinger',80000,'sportsclassics','pdm',100),
('Stinger GT','stingergt',75000,'sportsclassics','pdm',100),
('stratum','stratum',45000,'sedans','pdm',100),
('Streiter','streiter',500000,'sports','pdm',100),
('Stretch','stretch',90000,'sedans','pdm',100),
('Stromberg','stromberg',3185350,'sports','pdm',100),
('stryder','stryder',45000,'motorcycles','pdm',100),
('sugoi','sugoi',20000,'sports','pdm',100),
('Sultan','sultan',15000,'sports','pdm',100),
('sultan2','sultan2',20000,'sports','pdm',100),
('sultan3','sultan3',2000,'sports','pdm',100),
('Sultan RS','sultanrs',65000,'super','pdm',100),
('Super Diamond','superd',130000,'sedans','pdm',100),
('Surano','surano',50000,'sports','pdm',100),
('Surfer','surfer',12000,'vans','pdm',100),
('surfer2','surfer2',20000,'vans','pdm',100),
('surge','surge',45000,'sedans','pdm',100),
('swinger','swinger',20000,'sports','pdm',100),
('T20','t20',300000,'super','pdm',100),
('taco','taco',20000,'vans','pdm',100),
('Tailgater','tailgater',30000,'sedans','pdm',100),
('tailgater2','tailgater2',2000,'sports','pdm',100),
('taipan','taipan',20000,'super','pdm',100),
('Tampa','tampa',16000,'muscle','pdm',100),
('Drift Tampa','tampa2',80000,'sports','pdm',100),
('tempesta','tempesta',20000,'super','pdm',100),
('tezeract','tezeract',20000,'super','pdm',100),
('thrax','thrax',20000,'super','pdm',100),
('Thrust','thrust',24000,'motorcycles','pdm',100),
('tigon','tigon',20000,'super','pdm',100),
('torero','torero',20000,'sports','pdm',100),
('tornado','tornado',20000,'sports','pdm',100),
('tornado2','tornado2',20000,'sports','pdm',100),
('tornado3','tornado3',20000,'sports','pdm',100),
('tornado4','tornado4',20000,'sports','pdm',100),
('tornado5','tornado5',20000,'sports','pdm',100),
('tornado6','tornado6',20000,'sports','pdm',100),
('toros','toros',45000,'suvs','pdm',100),
('Tri bike','tribike',520,'cycles','pdm',100),
('Tri bike','tribike2',520,'cycles','pdm',100),
('Tri bike','tribike3',520,'cycles','pdm',100),
('Trophy Truck','trophytruck',60000,'offroad','pdm',100),
('Trophy Truck Limited','trophytruck2',80000,'offroad','pdm',100),
('Tropos','tropos',40000,'sports','pdm',100),
('tulip','tulip',45000,'muscle','pdm',100),
('turismo2','turismo2',20000,'sports','pdm',100),
('Turismo R','turismor',350000,'super','pdm',100),
('tyrant','tyrant',20000,'super','pdm',100),
('Tyrus','tyrus',600000,'super','pdm',100),
('Vacca','vacca',120000,'super','pdm',100),
('Vader','vader',7200,'motorcycles','pdm',100),
('vagner','vagner',20000,'super','pdm',100),
('vagrant','vagrant',45000,'offroad','pdm',100),
('vamos','vamos',45000,'muscle','pdm',100),
('vectre','vectre',2000,'sports','pdm',100),
('Verlierer','verlierer2',70000,'sports','pdm',100),
('verus','verus',45000,'offroad','pdm',100),
('Vigero','vigero',12500,'muscle','pdm',100),
('vindicator','vindicator',45000,'motorcycles','pdm',100),
('Virgo','virgo',14000,'muscle','pdm',100),
('virgo2','virgo2',45000,'muscle','pdm',100),
('virgo3','virgo3',45000,'muscle','pdm',100),
('Viseris','viseris',875000,'sportsclassics','pdm',100),
('Visione','visione',2250000,'super','pdm',100),
('Voltic','voltic',90000,'super','pdm',100),
('Voltic 2','voltic2',3830400,'super','pdm',100),
('Voodoo','voodoo',7200,'muscle','pdm',100),
('voodoo2','voodoo2',45000,'muscle','pdm',100),
('Vortex','vortex',9800,'motorcycles','pdm',100),
('vstr','vstr',20000,'sports','pdm',100),
('Warrener','warrener',4000,'sedans','pdm',100),
('warrener2','warrener2',20000,'sports','pdm',100),
('Washington','washington',9000,'sedans','pdm',100),
('weevil','weevil',8000,'compacts','pdm',100),
('Windsor','windsor',95000,'coupes','pdm',100),
('Windsor Drop','windsor2',125000,'coupes','pdm',100),
('winky','winky',45000,'offroad','pdm',100),
('Woflsbane','wolfsbane',9000,'motorcycles','pdm',100),
('xa21','xa21',20000,'super','pdm',100),
('XLS','xls',32000,'suvs','pdm',100),
('Yosemite','yosemite',485000,'muscle','pdm',100),
('yosemite2','yosemite2',45000,'muscle','pdm',100),
('yosemite3','yosemite3',45000,'muscle','pdm',100),
('Youga','youga',10800,'vans','pdm',100),
('Youga Luxuary','youga2',14500,'vans','pdm',100),
('youga3','youga3',20000,'vans','pdm',100),
('Z190','z190',900000,'sportsclassics','pdm',100),
('Zentorno','zentorno',1500000,'super','pdm',100),
('Zion','zion',36000,'coupes','pdm',100),
('Zion Cabrio','zion2',45000,'coupes','pdm',100),
('zion3','zion3',20000,'sports','pdm',100),
('Zombie','zombiea',9500,'motorcycles','pdm',100),
('Zombie Luxuary','zombieb',12000,'motorcycles','pdm',100),
('zorrusso','zorrusso',20000,'super','pdm',100),
('zr350','zr350',2000,'sports','pdm',100),
('Z-Type','ztype',220000,'sportsclassics','pdm',100);

/*Table structure for table `weashops` */

DROP TABLE IF EXISTS `weashops`;

CREATE TABLE `weashops` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `zone` varchar(255) NOT NULL,
  `item` varchar(255) NOT NULL,
  `price` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8;

/*Data for the table `weashops` */

insert  into `weashops`(`id`,`zone`,`item`,`price`) values 
(1,'GunShop','WEAPON_PISTOL',300),
(2,'BlackWeashop','WEAPON_PISTOL',500),
(3,'GunShop','WEAPON_FLASHLIGHT',60),
(4,'BlackWeashop','WEAPON_FLASHLIGHT',70),
(5,'GunShop','WEAPON_MACHETE',90),
(6,'BlackWeashop','WEAPON_MACHETE',110),
(7,'GunShop','WEAPON_NIGHTSTICK',150),
(8,'BlackWeashop','WEAPON_NIGHTSTICK',150),
(9,'GunShop','WEAPON_BAT',100),
(10,'BlackWeashop','WEAPON_BAT',100),
(11,'GunShop','WEAPON_STUNGUN',50),
(12,'BlackWeashop','WEAPON_STUNGUN',50),
(13,'GunShop','WEAPON_MICROSMG',1400),
(14,'BlackWeashop','WEAPON_MICROSMG',1700),
(15,'GunShop','WEAPON_PUMPSHOTGUN',3400),
(16,'BlackWeashop','WEAPON_PUMPSHOTGUN',3500),
(17,'GunShop','WEAPON_ASSAULTRIFLE',10000),
(18,'BlackWeashop','WEAPON_ASSAULTRIFLE',11000),
(19,'GunShop','WEAPON_SPECIALCARBINE',15000),
(20,'BlackWeashop','WEAPON_SPECIALCARBINE',16500),
(21,'GunShop','WEAPON_SNIPERRIFLE',22000),
(22,'BlackWeashop','WEAPON_SNIPERRIFLE',24000),
(23,'GunShop','WEAPON_FIREWORK',18000),
(24,'BlackWeashop','WEAPON_FIREWORK',20000),
(25,'GunShop','WEAPON_GRENADE',500),
(26,'BlackWeashop','WEAPON_GRENADE',650),
(27,'GunShop','WEAPON_BZGAS',200),
(28,'BlackWeashop','WEAPON_BZGAS',350),
(29,'GunShop','WEAPON_FIREEXTINGUISHER',100),
(30,'BlackWeashop','WEAPON_FIREEXTINGUISHER',100),
(31,'GunShop','WEAPON_BALL',50),
(32,'BlackWeashop','WEAPON_BALL',50),
(33,'GunShop','WEAPON_SMOKEGRENADE',100),
(34,'BlackWeashop','WEAPON_SMOKEGRENADE',100),
(35,'BlackWeashop','WEAPON_APPISTOL',1100),
(36,'BlackWeashop','WEAPON_CARBINERIFLE',12000),
(37,'BlackWeashop','WEAPON_HEAVYSNIPER',30000),
(38,'BlackWeashop','WEAPON_MINIGUN',45000),
(39,'BlackWeashop','WEAPON_RAILGUN',50000),
(40,'BlackWeashop','WEAPON_STICKYBOMB',500);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
