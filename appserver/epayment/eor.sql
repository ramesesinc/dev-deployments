-- MySQL dump 10.13  Distrib 5.7.22, for osx10.13 (x86_64)
--
-- Host: localhost    Database: eor
-- ------------------------------------------------------
-- Server version	5.6.40

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
-- Table structure for table `eor`
--

DROP TABLE IF EXISTS `eor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eor` (
  `objid` varchar(50) NOT NULL,
  `receiptno` varchar(50) DEFAULT NULL,
  `receiptdate` date DEFAULT NULL,
  `txndate` datetime DEFAULT NULL,
  `state` varchar(10) DEFAULT NULL,
  `partnerid` varchar(50) DEFAULT NULL,
  `txntype` varchar(20) DEFAULT NULL,
  `traceid` varchar(50) DEFAULT NULL,
  `tracedate` datetime DEFAULT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `paidby` varchar(255) DEFAULT NULL,
  `paidbyaddress` varchar(255) DEFAULT NULL,
  `payer_objid` varchar(50) DEFAULT NULL,
  `paymethod` varchar(20) DEFAULT NULL,
  `paymentrefid` varchar(50) DEFAULT NULL,
  `remittanceid` varchar(50) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `amount` decimal(16,4) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  UNIQUE KEY `uix_eor_receiptno` (`receiptno`),
  KEY `ix_receiptdate` (`receiptdate`),
  KEY `ix_txndate` (`txndate`),
  KEY `ix_partnerid` (`partnerid`),
  KEY `ix_traceid` (`traceid`),
  KEY `ix_refid` (`refid`),
  KEY `ix_paidby` (`paidby`),
  KEY `ix_payer_objid` (`payer_objid`),
  KEY `ix_paymentrefid` (`paymentrefid`),
  KEY `ix_remittanceid` (`remittanceid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eor_for_email`
--

DROP TABLE IF EXISTS `eor_for_email`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eor_for_email` (
  `objid` varchar(50) CHARACTER SET latin1 NOT NULL,
  `txndate` datetime DEFAULT NULL,
  `email` varchar(255) CHARACTER SET latin1 DEFAULT NULL,
  `mobileno` varchar(50) CHARACTER SET latin1 DEFAULT NULL,
  `state` int(1) DEFAULT NULL,
  `dtsent` datetime DEFAULT NULL,
  `errmsg` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eor_item`
--

DROP TABLE IF EXISTS `eor_item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eor_item` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) DEFAULT NULL,
  `item_objid` varchar(50) DEFAULT NULL,
  `item_code` varchar(100) DEFAULT NULL,
  `item_title` varchar(100) DEFAULT NULL,
  `amount` decimal(16,4) DEFAULT NULL,
  `remarks` varchar(255) DEFAULT NULL,
  `item_fund_objid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `fk_eoritem_eor` (`parentid`),
  KEY `ix_item_objid` (`item_objid`),
  KEY `ix_item_fund_objid` (`item_fund_objid`),
  CONSTRAINT `fk_eoritem_eor` FOREIGN KEY (`parentid`) REFERENCES `eor` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eor_number`
--

DROP TABLE IF EXISTS `eor_number`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eor_number` (
  `objid` varchar(255) NOT NULL,
  `currentno` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eor_payment_error`
--

DROP TABLE IF EXISTS `eor_payment_error`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eor_payment_error` (
  `objid` varchar(50) NOT NULL,
  `txndate` datetime NOT NULL,
  `txntype` varchar(50) NOT NULL,
  `paymentrefid` varchar(50) NOT NULL,
  `errmsg` text NOT NULL,
  `errdetail` longtext,
  PRIMARY KEY (`objid`),
  KEY `ix_txndate` (`txndate`),
  KEY `ix_txntype` (`txntype`),
  KEY `ix_paymentrefid` (`paymentrefid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eor_paymentorder`
--

DROP TABLE IF EXISTS `eor_paymentorder`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eor_paymentorder` (
  `objid` varchar(50) NOT NULL,
  `txndate` datetime DEFAULT NULL,
  `txntype` varchar(50) DEFAULT NULL,
  `txntypename` varchar(100) DEFAULT NULL,
  `payer_objid` varchar(50) DEFAULT NULL,
  `payer_name` text,
  `paidby` text,
  `paidbyaddress` varchar(150) DEFAULT NULL,
  `particulars` varchar(500) DEFAULT NULL,
  `amount` decimal(16,2) DEFAULT NULL,
  `expirydate` date DEFAULT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `refno` varchar(50) DEFAULT NULL,
  `info` text,
  `origin` varchar(100) DEFAULT NULL,
  `controlno` varchar(50) DEFAULT NULL,
  `locationid` varchar(25) DEFAULT NULL,
  `items` mediumtext,
  `state` varchar(20) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobileno` varchar(50) DEFAULT NULL,
  `phoneno` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `fk_eor_payment_order_plugin_handler` (`txntype`),
  CONSTRAINT `fk_eor_payment_order_plugin_handler` FOREIGN KEY (`txntype`) REFERENCES `epayment_plugin` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eor_paymentorder_cancelled`
--

DROP TABLE IF EXISTS `eor_paymentorder_cancelled`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eor_paymentorder_cancelled` (
  `objid` varchar(50) NOT NULL,
  `txndate` datetime DEFAULT NULL,
  `txntype` varchar(50) DEFAULT NULL,
  `txntypename` varchar(100) DEFAULT NULL,
  `payer_objid` varchar(50) DEFAULT NULL,
  `payer_name` longtext,
  `paidby` longtext,
  `paidbyaddress` varchar(150) DEFAULT NULL,
  `particulars` text,
  `amount` decimal(16,2) DEFAULT NULL,
  `expirydate` date DEFAULT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `refno` varchar(50) DEFAULT NULL,
  `info` longtext,
  `origin` varchar(100) DEFAULT NULL,
  `controlno` varchar(50) DEFAULT NULL,
  `locationid` varchar(25) DEFAULT NULL,
  `items` longtext,
  `state` varchar(10) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobileno` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_txndate` (`txndate`),
  KEY `ix_txntype` (`txntype`),
  KEY `ix_payer_objid` (`payer_objid`),
  KEY `ix_payer_name` (`payer_name`(255)),
  KEY `ix_expirydate` (`expirydate`),
  KEY `ix_refid` (`refid`),
  KEY `ix_refno` (`refno`),
  KEY `ix_controlno` (`controlno`),
  KEY `ix_locationid` (`locationid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eor_paymentorder_paid`
--

DROP TABLE IF EXISTS `eor_paymentorder_paid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eor_paymentorder_paid` (
  `objid` varchar(50) NOT NULL,
  `txndate` datetime DEFAULT NULL,
  `txntype` varchar(50) DEFAULT NULL,
  `txntypename` varchar(100) DEFAULT NULL,
  `payer_objid` varchar(50) DEFAULT NULL,
  `payer_name` longtext,
  `paidby` longtext,
  `paidbyaddress` varchar(150) DEFAULT NULL,
  `particulars` text,
  `amount` decimal(16,2) DEFAULT NULL,
  `expirydate` date DEFAULT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `refno` varchar(50) DEFAULT NULL,
  `info` longtext,
  `origin` varchar(100) DEFAULT NULL,
  `controlno` varchar(50) DEFAULT NULL,
  `locationid` varchar(25) DEFAULT NULL,
  `items` longtext,
  `state` varchar(10) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `mobileno` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `ix_txndate` (`txndate`),
  KEY `ix_txntype` (`txntype`),
  KEY `ix_payer_objid` (`payer_objid`),
  KEY `ix_payer_name` (`payer_name`(255)),
  KEY `ix_expirydate` (`expirydate`),
  KEY `ix_refid` (`refid`),
  KEY `ix_refno` (`refno`),
  KEY `ix_controlno` (`controlno`),
  KEY `ix_locationid` (`locationid`),
  CONSTRAINT `fk_eor_paymentorder_paid_txntype` FOREIGN KEY (`txntype`) REFERENCES `epayment_plugin` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eor_remittance`
--

DROP TABLE IF EXISTS `eor_remittance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eor_remittance` (
  `objid` varchar(50) NOT NULL,
  `state` varchar(50) DEFAULT NULL,
  `controlno` varchar(50) DEFAULT NULL,
  `partnerid` varchar(50) DEFAULT NULL,
  `controldate` date DEFAULT NULL,
  `dtcreated` datetime DEFAULT NULL,
  `createdby_objid` varchar(50) DEFAULT NULL,
  `createdby_name` varchar(255) DEFAULT NULL,
  `amount` decimal(16,4) DEFAULT NULL,
  `dtposted` datetime DEFAULT NULL,
  `postedby_objid` varchar(50) DEFAULT NULL,
  `postedby_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eor_remittance_fund`
--

DROP TABLE IF EXISTS `eor_remittance_fund`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eor_remittance_fund` (
  `objid` varchar(100) NOT NULL,
  `remittanceid` varchar(50) DEFAULT NULL,
  `fund_objid` varchar(50) DEFAULT NULL,
  `fund_code` varchar(50) DEFAULT NULL,
  `fund_title` varchar(255) DEFAULT NULL,
  `amount` decimal(16,4) DEFAULT NULL,
  `bankaccount_objid` varchar(50) DEFAULT NULL,
  `bankaccount_title` varchar(255) DEFAULT NULL,
  `bankaccount_bank_name` varchar(255) DEFAULT NULL,
  `validation_refno` varchar(50) DEFAULT NULL,
  `validation_refdate` date DEFAULT NULL,
  PRIMARY KEY (`objid`),
  KEY `fk_eor_remittance_fund_remittance` (`remittanceid`),
  CONSTRAINT `fk_eor_remittance_fund_remittance` FOREIGN KEY (`remittanceid`) REFERENCES `eor_remittance` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `eor_share`
--

DROP TABLE IF EXISTS `eor_share`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `eor_share` (
  `objid` varchar(50) NOT NULL,
  `parentid` varchar(50) NOT NULL,
  `refitem_objid` varchar(50) DEFAULT NULL,
  `refitem_code` varchar(25) DEFAULT NULL,
  `refitem_title` varchar(255) DEFAULT NULL,
  `payableitem_objid` varchar(50) DEFAULT NULL,
  `payableitem_code` varchar(25) DEFAULT NULL,
  `payableitem_title` varchar(255) DEFAULT NULL,
  `amount` decimal(16,4) DEFAULT NULL,
  `share` decimal(16,2) DEFAULT NULL,
  PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `epayment_plugin`
--

DROP TABLE IF EXISTS `epayment_plugin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `epayment_plugin` (
  `objid` varchar(50) NOT NULL,
  `connection` varchar(50) DEFAULT NULL,
  `servicename` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jev`
--

DROP TABLE IF EXISTS `jev`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jev` (
  `objid` varchar(150) NOT NULL,
  `jevno` varchar(50) DEFAULT NULL,
  `jevdate` date DEFAULT NULL,
  `fundid` varchar(50) DEFAULT NULL,
  `dtposted` datetime DEFAULT NULL,
  `txntype` varchar(50) DEFAULT NULL,
  `refid` varchar(50) DEFAULT NULL,
  `refno` varchar(50) DEFAULT NULL,
  `reftype` varchar(50) DEFAULT NULL,
  `amount` decimal(16,4) DEFAULT NULL,
  `state` varchar(32) DEFAULT NULL,
  `postedby_objid` varchar(50) DEFAULT NULL,
  `postedby_name` varchar(255) DEFAULT NULL,
  `verifiedby_objid` varchar(50) DEFAULT NULL,
  `verifiedby_name` varchar(255) DEFAULT NULL,
  `dtverified` datetime DEFAULT NULL,
  `batchid` varchar(50) DEFAULT NULL,
  `refdate` date DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `ix_batchid` (`batchid`) USING BTREE,
  KEY `ix_dtposted` (`dtposted`) USING BTREE,
  KEY `ix_dtverified` (`dtverified`) USING BTREE,
  KEY `ix_fundid` (`fundid`) USING BTREE,
  KEY `ix_jevdate` (`jevdate`) USING BTREE,
  KEY `ix_jevno` (`jevno`) USING BTREE,
  KEY `ix_postedby_objid` (`postedby_objid`) USING BTREE,
  KEY `ix_refdate` (`refdate`) USING BTREE,
  KEY `ix_refid` (`refid`) USING BTREE,
  KEY `ix_refno` (`refno`) USING BTREE,
  KEY `ix_reftype` (`reftype`) USING BTREE,
  KEY `ix_verifiedby_objid` (`verifiedby_objid`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `jevitem`
--

DROP TABLE IF EXISTS `jevitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `jevitem` (
  `objid` varchar(150) NOT NULL,
  `jevid` varchar(150) DEFAULT NULL,
  `accttype` varchar(50) DEFAULT NULL,
  `acctid` varchar(50) DEFAULT NULL,
  `acctcode` varchar(32) DEFAULT NULL,
  `acctname` varchar(255) DEFAULT NULL,
  `dr` decimal(16,4) DEFAULT NULL,
  `cr` decimal(16,4) DEFAULT NULL,
  `particulars` varchar(255) DEFAULT NULL,
  `itemrefid` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  KEY `ix_jevid` (`jevid`) USING BTREE,
  KEY `ix_ledgertype` (`accttype`) USING BTREE,
  KEY `ix_acctid` (`acctid`) USING BTREE,
  KEY `ix_acctcode` (`acctcode`) USING BTREE,
  KEY `ix_acctname` (`acctname`) USING BTREE,
  KEY `ix_itemrefid` (`itemrefid`) USING BTREE,
  CONSTRAINT `fk_jevitem_jevid` FOREIGN KEY (`jevid`) REFERENCES `jev` (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `paymentpartner`
--

DROP TABLE IF EXISTS `paymentpartner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `paymentpartner` (
  `objid` varchar(50) NOT NULL,
  `code` varchar(50) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL,
  `branch` varchar(255) DEFAULT NULL,
  `contact` varchar(255) DEFAULT NULL,
  `mobileno` varchar(32) DEFAULT NULL,
  `phoneno` varchar(32) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `indexno` varchar(3) DEFAULT NULL,
  PRIMARY KEY (`objid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `unpostedpayment`
--

DROP TABLE IF EXISTS `unpostedpayment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `unpostedpayment` (
  `objid` varchar(50) NOT NULL,
  `txndate` datetime NOT NULL,
  `txntype` varchar(50) NOT NULL,
  `txntypename` varchar(150) NOT NULL,
  `paymentrefid` varchar(50) NOT NULL,
  `amount` decimal(16,2) NOT NULL,
  `orgcode` varchar(20) NOT NULL,
  `partnerid` varchar(50) NOT NULL,
  `traceid` varchar(100) NOT NULL,
  `tracedate` datetime NOT NULL,
  `refno` varchar(50) DEFAULT NULL,
  `origin` varchar(50) DEFAULT NULL,
  `paymentorder` longtext,
  `errmsg` text NOT NULL,
  `errdetail` longtext,
  PRIMARY KEY (`objid`),
  UNIQUE KEY `ix_paymentrefid` (`paymentrefid`),
  KEY `ix_txndate` (`txndate`),
  KEY `ix_txntype` (`txntype`),
  KEY `ix_partnerid` (`partnerid`),
  KEY `ix_traceid` (`traceid`),
  KEY `ix_tracedate` (`tracedate`),
  KEY `ix_refno` (`refno`),
  KEY `ix_origin` (`origin`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-10-07 10:37:05
