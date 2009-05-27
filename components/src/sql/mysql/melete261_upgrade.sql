alter table melete_user_preference add column LICENSE_CODE int(11);
alter table melete_user_preference add column CC_LICENSE_URL varchar(70);
alter table melete_user_preference add column REQ_ATTR tinyint(1);
alter table melete_user_preference add column ALLOW_CMRCL tinyint(1);
alter table melete_user_preference add column ALLOW_MOD int(11);
alter table melete_user_preference add column COPYRIGHT_OWNER varchar(55);
alter table melete_user_preference add column COPYRIGHT_YEAR varchar(25);