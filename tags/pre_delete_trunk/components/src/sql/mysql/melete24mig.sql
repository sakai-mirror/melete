
CREATE TABLE `melete_migrate_status` (START_FLAG tinyint(1),COMPLETE_FLAG tinyint(1));
INSERT INTO `melete_migrate_status`(START_FLAG,COMPLETE_FLAG) values(1,1);
CREATE INDEX COURSE_ID_IDX ON `melete_course_module` (COURSE_ID);                               