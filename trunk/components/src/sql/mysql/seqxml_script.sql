set @dtdlocation='/var/melete/packagefiles/moduleSeq.dtd';
set @doctype_dtd=concat('<!DOCTYPE module SYSTEM \"',@dtdlocation);
set @doctype_dtd=concat(@doctype_dtd,'\">');

drop table if exists melete_module_seqxml;
create table melete_module_seqxml as select * from melete_module;
update melete_module set seq_xml=replace(seq_xml,@doctype_dtd,'<!DOCTYPE module [
  <!ELEMENT module (section+)>
  <!ELEMENT section (section*)>
  <!ATTLIST section id ID #REQUIRED>
]>') where seq_xml is not NULL;






