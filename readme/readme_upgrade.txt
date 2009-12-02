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
 
INSTRUCTIONS TO UPGRADE FROM MELETE 2.6 >> MELETE 2.7
For a patched Sakai 2.3, patched Sakai 2.4, OR Sakai 2.5
-----------------------------------------------------
SETUP INSTRUCTIONS
1. Melete Settings in Sakai.properties
2. Internationalize Messages
3. Sferyx Configuration
4. Compile Melete 
5. Database Changes
---------------------------------

1. Melete Settings in Sakai.properties 
	The upload Directory and packagingDir settings are moved from melete's web.xml file and are now read from sakai.properties.
	melete.uploadDir=/var/uploads
	melete.packagingDir =/var/melete/packagefiles
	
2. Internationalize Messages 
	If you are running Melete in a different language than English, you need to update messages.properties of your language 
	under melete-app/src/bundle and under melete-impl/src/bundle.
	Image buttons are no longer required and is read from messages.properties file as text.
	   
3. Sferyx Configuration 
	Sferyx applet is moved out of melete webapp and now lives in its own webapp.This is to simplify melete rollout process.
		a. Download sferyx from https://source.sakaiproject.org/contrib/etudes/sferyx/trunk and place it under sakai source directory.
		b. Place your purchased applet jar file under /src/webapp/sferyx. 
		c. Compile and deploy sferyx webapp using maven.
		
	NOTE: Make sure you configured melete.uploadDir setting in Step 1.
		       
4. Compile Melete
    At the command prompt, go to the melete source directory which you placed under sakai and run maven commands just like you
    did for sakai.
	
	4.1 Sakai 2.4 and previous versions
	
	Note: Undeploy any previous Melete versions from your source before deploying Melete 2.7 as artifacts name has changed. 
	
	To build(using Maven version 1), run 'maven sakai:build' and then to deploy 'maven sakai:deploy'
	
	(for more instructions, see section titled 'Sakai Maven Goals' in the 
	"How we build Sakai Using Maven" document provided by Sakai lead developers)
	
	4.2 Sakai 2.5 and above versions
	
	To build and deploy(using Maven version 2), run 'mvn clean install sakai:deploy'
	
	Note: If you are using sakai version other than 2.5.0 before building change the version in pom.xml. The default version in pom.xml is <version>2.5.0</version>. Sakai version can be obtained from master/pom.xml from version element.

	
5. Database Changes
  	Few tables are modified. Run the upgrade script manually.
  	  Mysql Users: /components/src/sql/mysql/melete27_upgrade.sql
	  Oracle Users: /components/src/sql/oracle/melete27_upgrade.sql		
	
	Start tomcat, make sure there are no errors in the logs.
		
For future development, tutorials and solutions to common setup problems, see:
http://etudes.org/melete.htm
		