ALTER TABLE `waterworks_account` MODIFY COLUMN `excludeinbatch` int(10) NULL DEFAULT NULL AFTER `lat`;
ALTER TABLE `waterworks_account` ADD COLUMN `mobileno` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `excludeinbatch`;
ALTER TABLE `waterworks_account` ADD COLUMN `email` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL AFTER `mobileno`;

ALTER TABLE `waterworks_batch_billing` DROP COLUMN `dtcreated`;
ALTER TABLE `waterworks_batch_billing` DROP COLUMN `createdby_objid`;
ALTER TABLE `waterworks_batch_billing` DROP COLUMN `createdby_name`;
ALTER TABLE `waterworks_batch_billing` DROP COLUMN `postedby_objid`;
ALTER TABLE `waterworks_batch_billing` DROP COLUMN `postedby_name`;
ALTER TABLE `waterworks_batch_billing` DROP INDEX `ix_dtcreated`;
ALTER TABLE `waterworks_batch_billing` DROP INDEX `ix_createdby_objid`;
ALTER TABLE `waterworks_batch_billing` DROP INDEX `ix_postedby_objid`;
ALTER TABLE `waterworks_batch_billing` ADD COLUMN `mobilereading` int(255) NULL DEFAULT NULL AFTER `readingdate`;


CREATE OR REPLACE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `vw_waterworks_account` AS select `wa`.`objid` AS `objid`,`wa`.`state` AS `state`,`wa`.`acctno` AS `acctno`,`wa`.`acctinfoid` AS `acctinfoid`,`wa`.`dtstarted` AS `dtstarted`,`wa`.`applicationid` AS `applicationid`,`wa`.`remarks` AS `remarks`,`wa`.`ukey` AS `ukey`,`wa`.`seqno` AS `seqno`,`wa`.`billid` AS `billid`,`wa`.`lng` AS `lng`,`wa`.`lat` AS `lat`,`wa`.`excludeinbatch` AS `excludeinbatch`,`wa`.`mobileno` AS `mobileno`,`wa`.`email` AS `email`,`ai`.`acctname` AS `acctname`,`ai`.`owner_objid` AS `owner_objid`,`ai`.`owner_name` AS `owner_name`,`ai`.`address_type` AS `address_type`,`ai`.`address_text` AS `address_text`,`ai`.`address_barangay_objid` AS `address_barangay_objid`,`ai`.`address_barangay_name` AS `address_barangay_name`,`ai`.`address_city` AS `address_city`,`ai`.`address_province` AS `address_province`,`ai`.`address_municipality` AS `address_municipality`,`ai`.`address_unitno` AS `address_unitno`,`ai`.`address_street` AS `address_street`,`ai`.`address_subdivision` AS `address_subdivision`,`ai`.`address_bldgno` AS `address_bldgno`,`ai`.`address_bldgname` AS `address_bldgname`,`ai`.`address_pin` AS `address_pin`,`ai`.`stuboutid` AS `stuboutid`,`ai`.`subareaid` AS `subareaid`,`ai`.`meterid` AS `meterid`,`ai`.`classificationid` AS `classificationid`,`ai`.`units` AS `units`,`ai`.`attributes` AS `attributes`,`ai`.`meterstate` AS `meterstate` from ((`waterworks_account` `wa` join `waterworks_account_info` `ai` on((`wa`.`acctinfoid` = `ai`.`objid`))) left join `waterworks_meter` `wm` on((`ai`.`meterid` = `wm`.`objid`)));
CREATE OR REPLACE ALGORITHM = UNDEFINED DEFINER = `root`@`localhost` SQL SECURITY DEFINER VIEW `vw_waterworks_bill` AS select `wb`.`objid` AS `objid`,`wb`.`billno` AS `billno`,`wb`.`billdate` AS `billdate`,`wb`.`acctid` AS `acctid`,`wb`.`acctinfoid` AS `acctinfoid`,`wb`.`batchid` AS `batchid`,`wb`.`txnmode` AS `txnmode`,`wb`.`periodid` AS `periodid`,`wb`.`expirydate` AS `expirydate`,`wb`.`state` AS `state`,`wb`.`balanceforward` AS `balanceforward`,`wb`.`billed` AS `billed`,`wb`.`billrefno` AS `billrefno`,`wb`.`printed` AS `printed`,`wb`.`remarks` AS `remarks`,`wb`.`createdby_objid` AS `createdby_objid`,`wb`.`createdby_name` AS `createdby_name`,`wb`.`dtcreated` AS `dtcreated`,`wb`.`validitydate` AS `validitydate`,`wb`.`initial` AS `initial`,`wb`.`step` AS `step`,`wb`.`consumptionid` AS `consumptionid`,`wb`.`totalcredits` AS `totalcredits`,`wb`.`totalprevunpaid` AS `totalprevunpaid`,`wb`.`totalbillunpaid` AS `totalbillunpaid`,`wb`.`billamount` AS `billamount`,`wb`.`totalsurcharge` AS `totalsurcharge`,`wb`.`totalpayment` AS `totalpayment`,`wb`.`totaldiscount` AS `totaldiscount`,`a`.`acctno` AS `acctno`,`ai`.`acctname` AS `acctname`,`a`.`state` AS `acctstate`,`a`.`seqno` AS `seqno`,`ai`.`subareaid` AS `subareaid`,`ai`.`address_text` AS `address_text`,`ai`.`classificationid` AS `classificationid`,`ai`.`stuboutid` AS `stuboutid`,`ai`.`meterid` AS `meterid`,`ai`.`meterstate` AS `meterstate`,`sarea`.`schedulegroupid` AS `subarea_schedulegroupid`,`sarea`.`code` AS `subarea_code`,`sarea`.`barangay_name` AS `subarea_barangay_name`,`area`.`code` AS `area_code`,`p`.`objid` AS `period_objid`,`p`.`year` AS `period_year`,`p`.`month` AS `period_month`,`p`.`fromdate` AS `period_fromdate`,`p`.`todate` AS `period_todate`,`p`.`readingdate` AS `period_readingdate`,`p`.`readingenddate` AS `period_readingenddate`,`p`.`billdate` AS `period_billdate`,`p`.`billingenddate` AS `period_billingenddate`,`p`.`discdate` AS `period_discdate`,`p`.`duedate` AS `period_duedate`,`p`.`billexpirydate` AS `period_billexpirydate` from (((((`waterworks_bill` `wb` join `waterworks_account` `a` on((`a`.`objid` = `wb`.`acctid`))) join `waterworks_account_info` `ai` on((`wb`.`acctinfoid` = `ai`.`objid`))) join `waterworks_subarea` `sarea` on((`ai`.`subareaid` = `sarea`.`objid`))) join `waterworks_area` `area` on((`sarea`.`areaid` = `area`.`objid`))) join `waterworks_billing_period` `p` on((`wb`.`periodid` = `p`.`objid`)));

CREATE TABLE `waterworks_disconnection_notice`  (
  `objid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `state` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `groupname` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `acctid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `acctinfoid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dtcreated` date NULL DEFAULT NULL,
  `createdby_objid` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `createdby_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dtfiled` date NULL DEFAULT NULL,
  `startyear` int(255) NULL DEFAULT NULL,
  `startmonth` int(255) NULL DEFAULT NULL,
  `endyear` int(255) NULL DEFAULT NULL,
  `endmonth` int(255) NULL DEFAULT NULL,
  `amtdue` decimal(16, 2) NULL DEFAULT NULL,
  `duedate` date NULL DEFAULT NULL,
  PRIMARY KEY (`objid`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Compact;



INSERT INTO sys_var (name,value,datatype)
VALUES
('waterworks_batch_print_size', '20', 'integer'),
('waterworks_batch_process_size', '20', 'integer');

UPDATE waterworks_account SET excludeinbatch = 0;

