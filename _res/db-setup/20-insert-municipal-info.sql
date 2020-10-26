
set @_PROVINCE_PIN   = '000'; 
set @_PROVINCE_NAME  = 'TEST PROVINCE'; 

set @_MUNICIPAL_PIN  = '000-00'; 
set @_MUNICIPAL_NAME = 'TEST MUNICIPAL'; 

-- 
-- Please change the above parameters 
-- to match your actual LGU information 
-- 

delete from sys_orgclass;

INSERT INTO `sys_orgclass` (`name`, `title`, `parentclass`, `handler`) 
VALUES ('PROVINCE', 'PROVINCE', NULL, 'province');

INSERT INTO `sys_orgclass` (`name`, `title`, `parentclass`, `handler`) 
VALUES ('MUNICIPALITY', 'MUNICIPALITY', 'PROVINCE', 'municipality');

INSERT INTO `sys_orgclass` (`name`, `title`, `parentclass`, `handler`) 
VALUES ('BARANGAY', 'BARANGAY', 'MUNICIPALITY', 'barangay');

-- 
-- province information 
-- 
INSERT INTO `sys_org` (
	`objid`, `name`, `orgclass`, `code`, `root` 
) 
VALUES (
	REPLACE(@_PROVINCE_PIN,'-',''),  @_PROVINCE_NAME, 
	'PROVINCE',  @_PROVINCE_PIN,  0
);

INSERT INTO `province` (
	`objid`, `state`, `indexno`, 
	`pin`, `name`, `fullname`, 
	`governor_title`, `governor_office`, 
	`assessor_title`, `assessor_office`, 
	`treasurer_title`, `treasurer_office` 
) VALUES (
	REPLACE(@_PROVINCE_PIN,'-',''), 'DRAFT', @_PROVINCE_PIN, 
	@_PROVINCE_PIN, @_PROVINCE_NAME, @_PROVINCE_NAME, 
	'GOVERNOR', 'OFFICE OF THE GOVERNOR', 
	'PROVINCIAL ASSESSOR', 'OFFICE OF THE PROVINCIAL ASSESSOR', 
	'PROVINCIAL TREASURER', 'OFFICE OF THE PROVINCIAL TREASURER' 
);


-- 
-- municipal information 
-- 
INSERT INTO `sys_org` (
	`objid`, `name`, `orgclass`, 
	`parent_objid`, `parent_orgclass`, 
	`code`, `root` 
) 
VALUES (
	REPLACE(@_MUNICIPAL_PIN,'-',''),  @_MUNICIPAL_NAME, 'MUNICIPALITY', 
	REPLACE(@_PROVINCE_PIN,'-',''),  'PROVINCE',  @_MUNICIPAL_PIN,  1 
);

INSERT INTO `municipality` (
	`objid`, `state`, `indexno`, 
	`pin`, `name`, `fullname`, `parentid`, 
	`mayor_title`, `mayor_office`, 
	`assessor_title`, `assessor_office`, 
	`treasurer_title`, `treasurer_office`
) VALUES (
	REPLACE(@_MUNICIPAL_PIN,'-',''), 'DRAFT', SUBSTRING(@_MUNICIPAL_PIN, 5), 
	@_MUNICIPAL_PIN, @_MUNICIPAL_NAME, @_MUNICIPAL_NAME, REPLACE(@_PROVINCE_PIN,'-',''), 
	'MUNICIPAL MAYOR', 'OFFICE OF THE MAYOR', 
	'MUNICIPAL ASSESSOR', 'OFFICE OF THE MUNICIPAL ASSESSOR', 
	'MUNICIPAL TREASURER', 'OFFICE OF THE MUNICIPAL TREASURER'
);


-- 
-- update sys_var
-- 
update sys_var set value='municipality' where name='lgu_type'; 
update sys_var set value=@_MUNICIPAL_NAME where name='lgu_name'; 
update sys_var set value=REPLACE(@_MUNICIPAL_PIN,'-','') where name='lgu_objid'; 
delete from sys_var where name in ('LIQUIDATINGOFFICER_NAME','LIQUIDATINGOFFICER_TITLE'); 

update sys_var set value='ba4d084b31b41fbe55302c0429d93c81' where name='sa_pwd'; 
