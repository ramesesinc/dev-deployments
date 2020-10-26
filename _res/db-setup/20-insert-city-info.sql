
set @_CITY_PIN       = '000'; 
set @_CITY_NAME      = 'TEST CITY'; 

-- 
-- Please change the above parameters 
-- to match your actual LGU information 
-- 

delete from sys_orgclass;

INSERT INTO `sys_orgclass` (`name`, `title`, `parentclass`, `handler`) 
VALUES ('PROVINCE', 'PROVINCE', NULL, 'province');

INSERT INTO `sys_orgclass` (`name`, `title`, `parentclass`, `handler`) 
VALUES ('CITY', 'CITY', NULL, 'city');

INSERT INTO `sys_orgclass` (`name`, `title`, `parentclass`, `handler`) 
VALUES ('DISTRICT', 'DISTRICT', 'CITY', 'district');

INSERT INTO `sys_orgclass` (`name`, `title`, `parentclass`, `handler`) 
VALUES ('BARANGAY', 'BARANGAY', 'DISTRICT', 'barangay');

-- 
-- city information 
-- 
INSERT INTO `sys_org` (
	`objid`, `name`, `orgclass`, `code`, `root` 
) 
VALUES (
	REPLACE(@_CITY_PIN,'-',''),  @_CITY_NAME, 'CITY', @_CITY_PIN,  1 
);

INSERT INTO `city` (
	`objid`, `state`, `indexno`, 
	`pin`, `name`, `fullname`, 
	`mayor_title`, `mayor_office`, 
	`assessor_title`, `assessor_office`, 
	`treasurer_title`, `treasurer_office`
) VALUES (
	@_CITY_PIN, 'DRAFT', @_CITY_PIN, 
	@_CITY_PIN, @_CITY_NAME, @_CITY_NAME, 
	'CITY MAYOR', 'OFFICE OF THE CITY MAYOR', 
	'CITY ASSESSOR', 'OFFICE OF THE CITY ASSESSOR', 
	'CITY TREASURER', 'OFFICE OF THE CITY TREASURER'
);


-- 
-- update sys_var
-- 
update sys_var set value='city' where name='lgu_type'; 
update sys_var set value=@_CITY_NAME where name='lgu_name'; 
update sys_var set value=@_CITY_PIN where name='lgu_objid'; 
delete from sys_var where name in ('LIQUIDATINGOFFICER_NAME','LIQUIDATINGOFFICER_TITLE'); 

update sys_var set value='ba4d084b31b41fbe55302c0429d93c81' where name='sa_pwd'; 
