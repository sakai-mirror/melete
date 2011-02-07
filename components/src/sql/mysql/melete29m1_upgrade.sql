CREATE TABLE `melete_section_track_view` (
  `SECTION_ID` int(11) NOT NULL default '0',
  `USER_ID` varchar(99) default NULL,
  `VIEW_DATE` datetime default NULL,
  PRIMARY KEY  (`SECTION_ID`,`USER_ID`),
  CONSTRAINT `FK_MSTV_MS` FOREIGN KEY(`SECTION_ID`) REFERENCES `melete_section`(`SECTION_ID`)
);
