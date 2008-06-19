alter table melete_module_shdates drop hide_flag;

alter table melete_module modify title varchar(255); 
alter table melete_section modify title varchar(255);
alter table melete_section add OPEN_WINDOW tinyint(1);
update melete_section set OPEN_WINDOW=1;
drop table melete_module_student_privs;
CREATE TABLE `melete_site_preference` (
  `PREF_SITE_ID` varchar(99) NOT NULL default '',
  `PRINTABLE` tinyint(1) default NULL,
  PRIMARY KEY (`PREF_SITE_ID`)
  );
CREATE INDEX USER_ID_IDX ON melete_user_preference(USER_ID);