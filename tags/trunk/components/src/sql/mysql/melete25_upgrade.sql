alter table melete_module_shdates drop hide_flag;
CREATE TABLE `melete_bookmarks` (
  `BOOKMARK_ID` int(11) NOT NULL default '0',
  `USER_ID` varchar(99) default NULL,
  `COURSE_ID` varchar(99) default NULL,
  `MODULE_ID` int(11) NOT NULL default '0',
  `SECTION_ID` int(11) NOT NULL default '0',
  PRIMARY KEY  (`BOOKMARK_ID`),
  KEY `MODULE_ID_BOOK_KEY` (`MODULE_ID`),
  KEY `SECTION_ID_BOOK_KEY` (`SECTION_ID`)
);
alter table melete_section add OPEN_WINDOW tinyint(1);
update melete_section set OPEN_WINDOW=1;