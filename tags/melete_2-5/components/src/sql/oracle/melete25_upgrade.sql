alter table melete_module_shdates drop column hide_flag;

alter table melete_module modify title varchar2(255); 
alter table melete_section modify title varchar2(255);
alter table melete_section add OPEN_WINDOW number(1);
update melete_section set OPEN_WINDOW=1;
drop table melete_module_student_privs;
CREATE TABLE melete_site_preference (
  PREF_SITE_ID varchar2(99) default '' NOT NULL,
  PRINTABLE number(1) default NULL,
  AUTONUMBER number(1) default '0' NOT NULL,
  PRIMARY KEY (PREF_SITE_ID)
  );
CREATE INDEX USER_ID_IDX ON melete_user_preference(USER_ID);
