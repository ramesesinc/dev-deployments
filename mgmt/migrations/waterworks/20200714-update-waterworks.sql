ALTER TABLE `waterworks_account` 
ADD CONSTRAINT `fk_waterworks_account_applicationid` FOREIGN KEY (`applicationid`) REFERENCES `waterworks_newconnection` (`objid`) 
ON DELETE RESTRICT ON UPDATE RESTRICT;

ALTER TABLE `waterworks_meter` DROP FOREIGN KEY `fk_waterworks_meter_currentacctid`;

ALTER TABLE `waterworks_meter` 
ADD CONSTRAINT `fk_waterworks_meter_currentacctid` 
FOREIGN KEY (`currentacctid`) REFERENCES `waterworks_account` (`objid`) ON DELETE RESTRICT ON UPDATE RESTRICT;