ALTER TABLE melete_special_access add column ALLOWUNTIL_DATE datetime default NULL;
ALTER TABLE melete_special_access add column OVERRIDE_ALLOWUNTIL tinyint(1) default '0';