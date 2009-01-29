/**********************************************************************************
 *
 * $URL$
 * $Id$  
 ***********************************************************************************
 *
 * Copyright (c) 2008,2009 Etudes, Inc.
 *
 * Portions completed before September 1, 2008 Copyright (c) 2004, 2005, 2006, 2007, 2008 Foothill College, ETUDES Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
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
 
INSTRUCTIONS TO UPGRADE FROM MELETE 2.5 >> MELETE 2.6
For a patched Sakai 2.3, patched Sakai 2.4, OR Sakai 2.5
-----------------------------------------------------
SETUP INSTRUCTIONS

1. Patch Instructions
2. Internationalize Messages (Optional)
3. Compile Melete 
4. Database Configuration
---------------------------------

1. Patch Instructions
   a. Sakai 2.3.x Patch Instructions
	** SKIP this step if you will run Melete with Sakai 2.4.**
	
	If you are using Sakai 2.3, you need to execute a patch that enables Sakai
	2.3 to run with Melete 2.6. The patch is at /patch/meletepatchsak23.sh.
	
	Instructions for running the patch are in /patch/patch-SAK2.3_for_melete.txt.
   
   b. Sakai 2.4.x Patch Instructions
	** SKIP this step if you will run Melete with Sakai 2.3.**
	
	If you are using Sakai 2.4, you need to execute a patch that enables Sakai
	2.4 to run with Melete 2.6. The patch is at /patch/meletepatchsak24.sh.
	
	Instructions for running the patch are in /patch/patch-SAK2.4_for_melete.txt.	
	
	NOTE: No patch is needed for Sakai 2.5

2. Internationalize Messages (Optional)
	If you want to run Melete in a different language than English, you need to update messages.properties of your language 
	under melete-app/src/bundle and under melete-impl/src/bundle.
	   
3. Compile Melete
    At the command prompt, go to the melete source directory which you placed 
	under sakai and run maven commands just like you did for sakai.
	
	3.1 Sakai 2.4 and previous versions
	
	Note: Undeploy any previous Melete versions from your source before deploying Melete 2.6 as artifacts name has changed. 
	
	To build(using Maven version 1), run 'maven sakai:build' and then to deploy 'maven sakai:deploy'
	
	(for more instructions, see section titled 'Sakai Maven Goals' in the 
	"How we build Sakai Using Maven" document provided by Sakai lead developers)
	
	3.2 Sakai 2.5 and above versions
	
	To build and deploy(using Maven version 2), run 'mvn clean install sakai:deploy'
	
	Note: If you are using sakai version other than 2.5.0 before building change the version in pom.xml. The default version in pom.xml is <version>2.5.0</version>. Sakai version can be obtained from master/pom.xml from version element.

	NOTE: For Oracle, you will need to apply a patch to handle NULL values. There is no patch available for Melete 2.6.Feel free to contact us at dev@etudes.org for melete-2.4.5 patch that you can work from.
	
4. Database Configuration
  
	* Melete works with HSQLDB, Oracle or Mysql4.1 Database. The driver used is 
	the MySql Connector/J 3.1.12 (same as Sakai). It has been tested just on Mysql, 
	but it has been deployed successfully with Oracle at many universities. 
	
	* Melete shares the same database as Sakai's and adds a few tables to the database. 
	
	4.1. To setup the Melete tables: 
	
		a. You need to run the Melete upgrade script manually
		Mysql Users: /components/src/sql/mysql/melete26_upgrade.sql
		Oracle Users: /components/src/sql/oracle/melete26_upgrade.sql
		
		NOTE: a. Please make sure secondary index on user_id column of melete_user_preference table is created.
			  Hibernate sometimes doesn't create it.
		      b. We see duplicate indices created by hibernate on module_id column of melete_course_module and melete_module_shdates table.
	         	section_id column of melete_section_resource table. please remove the duplicate keys. It will improve the performance.	   	
	
	Start tomcat, make sure there are no errors in the logs.
		
For future development, tutorials and solutions to common setup problems, see:
http://etudes.org/melete.htm
		