

ALTER TABLE `waterworks_batch_billing` DROP COLUMN `mobilereading`;
ALTER TABLE `waterworks_bill` MODIFY COLUMN `dtcreated` datetime(6) NULL DEFAULT NULL AFTER `createdby_name`;
ALTER TABLE `waterworks_consumption` DROP FOREIGN KEY `fk_waterworks_consumption_billid`;
ALTER TABLE `waterworks_subarea` 
  MODIFY COLUMN `schedulegroupid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL AFTER `description`;


 CREATE TABLE `waterworks_batch_billing_error`  (
  `objid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `batchid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `billid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `acctid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `action` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `errmsg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  INDEX `fk_waterworks_batch_blling_error_batchid`(`batchid`) USING BTREE,
  INDEX `fk_waterworks_batch_billing_error_acctid`(`acctid`) USING BTREE,
  INDEX `fk_waterworks_batch_billing_error_billid`(`billid`) USING BTREE,
  CONSTRAINT `fk_waterworks_batch_billing_error_acctid` FOREIGN KEY (`acctid`) REFERENCES `waterworks_account` (`objid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_waterworks_batch_billing_error_billid` FOREIGN KEY (`billid`) REFERENCES `waterworks_bill` (`objid`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `fk_waterworks_batch_blling_error_batchid` FOREIGN KEY (`batchid`) REFERENCES `waterworks_batch_billing` (`objid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

CREATE TABLE `waterworks_mobile_reading`  (
  `objid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `billid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `state` int(255) NULL DEFAULT NULL,
  `readingdate` datetime(0) NULL DEFAULT NULL,
  `billprintdate` date NULL DEFAULT NULL,
  `lng` float(255, 0) NULL DEFAULT NULL,
  `lat` float(255, 0) NULL DEFAULT NULL,
  `photo` mediumblob NULL,
  `remarks` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `reading` int(25) NULL DEFAULT NULL,
  `volume` int(10) NULL DEFAULT NULL,
  `amount` decimal(16, 2) NULL DEFAULT NULL,
  `dtuploaded` date NULL DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE,
  INDEX `fk_waterworks_mobile_reading`(`billid`) USING BTREE,
  CONSTRAINT `fk_waterworks_mobile_reading` FOREIGN KEY (`billid`) REFERENCES `waterworks_bill` (`objid`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;

CREATE VIEW `vw_waterworks_batch_billing_error` AS select `err`.`objid` AS `objid`,`err`.`batchid` AS `batchid`,`err`.`billid` AS `billid`,`err`.`acctid` AS `acctid`,`err`.`action` AS `action`,`err`.`errmsg` AS `errmsg`,`wa`.`seqno` AS `seqno`,`wa`.`acctno` AS `acctno`,`wai`.`acctname` AS `acctname` from ((`waterworks_batch_billing_error` `err` join `waterworks_account` `wa` on((`wa`.`objid` = `err`.`acctid`))) join `waterworks_account_info` `wai` on((`wai`.`objid` = `wa`.`acctinfoid`)));