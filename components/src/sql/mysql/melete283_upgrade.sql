alter table melete_special_access add column OVERRIDE_START tinyint(1) default '0';
alter table melete_special_access add column OVERRIDE_END tinyint(1) default '0';
update melete_special_access set OVERRIDE_START = 1;
update melete_special_access set OVERRIDE_END = 1;
