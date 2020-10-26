
set @_PROVINCE_PIN   = '000'; 
set @_PROVINCE_NAME  = 'TEST PROVINCE'; 

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
-- update sys_var
-- 
update sys_var set value='province' where name='lgu_type'; 
update sys_var set value=@_PROVINCE_NAME where name='lgu_name'; 
update sys_var set value=REPLACE(@_PROVINCE_PIN,'-','') where name='lgu_objid'; 
delete from sys_var where name in ('LIQUIDATINGOFFICER_NAME','LIQUIDATINGOFFICER_TITLE'); 

update sys_var set value='ba4d084b31b41fbe55302c0429d93c81' where name='sa_pwd'; 


-- 
-- remove bpls roles
-- 
delete from sys_usergroup_member where usergroup_objid in (
	select objid from sys_usergroup where domain='BPLS' 
)
;
delete from sys_usergroup_permission where usergroup_objid in (
	select objid from sys_usergroup where domain='BPLS' 
)
;
delete from sys_usergroup where domain='BPLS'
;

-- 
-- remove bpls workflow
-- 
delete from sys_wf_transition where processname='business_application'
;
delete from sys_wf_node where processname='business_application'
;
delete from sys_wf where name='business_application'
;

-- 
-- remove bpls rulesets
-- 
delete from sys_rule_actiondef_param where parentid in (
	select distinct ra.actiondef
	from sys_ruleset rs, sys_ruleset_actiondef ra 
	where rs.name in ('bpassessment','bpbilling','bpinfo','bprequirement') 
		and ra.ruleset = rs.name 
)
;
delete from sys_rule_actiondef where objid in (
	select distinct ra.actiondef
	from sys_ruleset rs, sys_ruleset_actiondef ra
	where rs.name in ('bpassessment','bpbilling','bpinfo','bprequirement') 
		and ra.ruleset = rs.name 
)
;
delete from sys_rule_fact_field where parentid in (
	select distinct rf.objid 
	from sys_ruleset rs, sys_ruleset_fact rsf, sys_rule_fact rf 
	where rs.name in ('bpassessment','bpbilling','bpinfo','bprequirement') 
		and rsf.ruleset = rs.name 
		and rf.objid = rsf.rulefact 
)
;
delete from sys_rule_fact where objid in (
	select distinct rsf.rulefact 
	from sys_ruleset rs, sys_ruleset_fact rsf 
	where rs.name in ('bpassessment','bpbilling','bpinfo','bprequirement') 
		and rsf.ruleset = rs.name 
)
;
delete from sys_ruleset_actiondef where ruleset in ('bpassessment','bpbilling','bpinfo','bprequirement')
;
delete from sys_ruleset_fact where ruleset in ('bpassessment','bpbilling','bpinfo','bprequirement')
;
delete from sys_rulegroup where ruleset in ('bpassessment','bpbilling','bpinfo','bprequirement')
;
delete from sys_ruleset where name in ('bpassessment','bpbilling','bpinfo','bprequirement')
;
