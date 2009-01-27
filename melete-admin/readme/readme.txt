/**********************************************************************************
 *
 * $URL$
 * $Id$
 ***********************************************************************************
 *
 * Copyright (c) 2009 Etudes, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you
 * may not use this file except in compliance with the License. You may
 * obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * permissions and limitations under the License.
 *
 **********************************************************************************/

MELETE ADMIN TOOL SETUP INSTRUCTIONS

Melete Admin tool is an administrative tool which lets admin users to clean up old deleted modules and sections and clean up their resources from database and the file System. To work with Melete Admin source, you need the same development environment as Sakai, essentially Java 1.4 and Maven 1.0.2.

-----------------------------------------------------
SETUP INSTRUCTIONS

1. Add to the Admin Workspace	

	1.1. Log on as Sakai admin. Add this new tool sakai.meleteAdmin in the Administrative Workspace.
	
	1.2 To add Tool, go to Sites and pick !admin and than Edit Pages and add a new Page and provide the title for this new Tool like 'Melete Admin' and than add a new tool sakai.meleteAdmin. 		
	
	
NOTE : IT IS RECOMMENDED TO CREATE BACKUPS OF DATABASE AND THE FILE SYSTEM WHERE CONTENT RESIDES BEFORE RUNNING THIS TOOL.

Melete before version 2.5 left behind deleted data and this tool cleans up such data from database and file storage. If you have used previous versions than you might consider running this tool.
There are few queries you can run to find out the numbers and make the decision.

To find deleted modules:
SELECT GROUP_CONCAT(cmod.module_id),count(cmod.module_id),cmod.course_id, s.title from melete_course_module cmod,SAKAI_SITE s where cmod.delete_flag = 1 and cmod.course_id = s.site_id GROUP BY cmod.course_id order by s.title;

To find deleted sections from active modules:
SELECT GROUP_CONCAT(sec.section_id),count(sec.section_id),GROUP_CONCAT(sec.module_id),cmod.course_id, s.title
FROM melete_section sec,melete_course_module cmod, SAKAI_SITE s
where sec.delete_flag = 1 AND sec.module_id = cmod.module_id AND
cmod.course_id NOT IN (select c1.course_id from melete_course_module c1 where c1.delete_flag =1)
AND cmod.delete_flag = 0 AND cmod.course_id = s.site_id GROUP BY cmod.course_id order by s.title;

We tested this tool on our production data and we had 17513 deleted modules and 4853 deleted sections from active modules and in all affecting 3005 sites.
It took us around 3 hrs to cleanup deleted data.