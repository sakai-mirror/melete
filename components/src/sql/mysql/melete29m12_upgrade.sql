ALTER TABLE melete_special_access add column ALLOWUNTIL_DATE datetime default NULL;
ALTER TABLE melete_special_access add column OVERRIDE_ALLOWUNTIL tinyint(1) default '0';


ALTER TABLE melete_module_shdates add column ALLOWUNTIL_DATE datetime default NULL;

alter table melete_module drop column LEARN_OBJ;
alter table melete_module drop column INSTITUTE;