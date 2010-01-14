/**********************************************************************************
 *
 * $URL$
 * $Id$  
 ***********************************************************************************
 *
 * Copyright (c) 2008,2009,2010 Etudes, Inc.
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
 
MELETE 2.7.2 SETUP INSTRUCTIONS
For Sakai 2.6.x

Melete is a lesson builder tool for Sakai (A.K.A. Modules). To work with Melete source, you need the same development environment as Sakai, essentially Java 1.5 and Maven 2.

-----------------------------------------------------
SETUP INSTRUCTIONS

1. Configuring Melete  
2. Configuring Commercial Sferyx Editor (Optional)
3. Internationalize Messages (Optional)
4. Compile Melete 
5. Database Configuration
6. Update Sakai Roles (under realms)
7. Sakai 2.5 (or Higher) Portal Icons
---------------------------------

1. Configuring Melete 2.7.2
       
  1.1 Packagingdir settings
	
	The dependency files for IMS-SCORM import/export processes are in the /var/melete/packagefiles directory in the Melete source code.
    
    	a. Copy the /var directory and its contents into a directory. Make sure the owner and group of the directory is same as tomcat user.

	b. Configure melete.packagingDir setting in Sakai.properties 
	   Eg. If you are on unix/linux, and your packaging directory path is /var/melete/packagefiles, specify in sakai.properties.
     	   
     	   melete.packagingDir =/var/melete/packagefiles        
	      
  1.2 Upload size settings for IMS import file
	
	By setting this sakai property, system administrators can set a different file upload limit for Melete IMS CP import than the
	upload max limit for content files. If this property is not set, then melete assumes max value as 50MB.

	content.upload.ceiling=50

2. Configuring Commercial Sferyx Editor (Optional)

                       ***** BEGIN OPTIONAL STEP ******
					   
  2.1 SFERYX SOURCE
		a. Purchase a license and binary source for Sferyx (http://www.sferyx.com)
		b. Download sferyx from https://source.sakaiproject.org/contrib/etudes/sferyx/trunk and place it under sakai source directory.
		c. Place the purchased applet jar file under /src/webapp/sferyx. 
		d. Create a directory for enabling uploads of embedded media via the Sferyx editor.Make sure the owner and group of this directory is   the same as that of the tomcat instances. 
		e. Configure melete.uploadDir setting in sakai.properties for enabling uploads of embedded media. Specify the absolute path to this directory in sakai.properties as melete.uploadDir
		
			   melete.uploadDir=/var/uploads
		
		f. Compile and deploy sferyx webapp using maven.			 
				
 2.2. DEFAULT MELETE EDITOR 
		 This is done by specifying the following property. For example, if default Melete editor is Sferyx,
		
			melete.wysiwyg.editor=Sferyx Editor
		
		If this property is NOT set, the code uses the editor specified by the wysiwyg.editor property.
		
 2.3. LIST OF AVAILABLE MELETE EDITORS 
		The preference feature allows users to select the editor for Melete content authoring. 
		List the editor choices for users in sakai.properties as specified below. For example, 
		if the user has two choices, Sferyx and FCK Editor, the settings will be as follows:
			
		melete.wysiwyg.editor.count=2
		melete.wysiwyg.editor1=Sferyx Editor
		melete.wysiwyg.editor2=FCK Editor
			
		NOTE : Please make sure that the names have proper spaces as this is used to display 
		the labels of the available editors on the Preferences page.
		
                              ***** END OF OPTIONAL STEP **********

3. Internationalize Messages (Optional)
	If you want to run Melete in a different language than English, you need to update messages.properties of your language 
	under melete-app/src/bundle and under melete-impl/src/bundle.
	
4. Compile Melete
	 At the command prompt, go to the melete source directory which you placed under sakai and run maven commands just 
	 like you did for sakai.
	
	To build and deploy Melete, run 'mvn clean install sakai:deploy'
	
	Note: If you are using sakai version other than 2.6.1 before building change the version in pom.xml. The default version in pom.xml is <version>2.6.1</version>. Sakai version can be obtained from master/pom.xml from version element.
	      
	
5. Database Configuration

	* Melete works with HSQLDB, Oracle or Mysql Database. It has been tested on Mysql4 and Mysql 5, but it has been deployed successfully with Oracle at many universities. 
	
	* Melete shares the same database as Sakai's and adds a few tables to the database. 
	
	5.1 Set up the Melete tables: 
	
	You can either run the sql script manually; it is provided under
	/components/src/sql/mysql/melete27.sql, 
	
	OR
	
	Turn on auto.ddl and when tomcat starts, hibernate will generate the melete tables on its own by reading xml files. 
	
	NOTE: Auto.ddl does not create some indices.
	      a. Make sure secondary indices on user_id column of melete_user_preference table and on course_id of melete_course_module table
	 	 are created.Hibernate sometimes doesn't create it. 
	      b. We see duplicate indices created by hibernate on module_id column of melete_course_module and melete_module_shdates table.
	         section_id column of melete_section_resource table. please remove the duplicate keys. It will improve the performance.
	      c. Melete stores content in the database tables as well as in the /private/meleteDocs folder in ContentHosting. 
        	 Through Melete, users only have access to the /private/meleteDocs folder and not other parts of Resources.

6. Update Sakai Roles (under realms) to include Melete permissions

	(If you are simply upgrading Melete in your Sakai instance, no roles changes are needed)

	6.1. Log on as Sakai admin. Check appropriate Melete permissions under the roles in
	 !site.template.course. 
	
	* Check melete.author for teacher, instructor, faculty types of roles (maintain).
	* Check melete.student for student types of custom roles that you have (access).
		
	6.2. If you have project sites and related roles in !site.template.project, appropriate 
	permissions (melete.student or melete.author) need to be checked as defined above.
		
   CAUTION: 
	a. IF YOU FAIL TO CHECK THE MELETE.STUDENT AND MELETE.AUTHOR PERMISSIONS 
		FOR YOUR ROLES, MELETE WILL NOT WORK PROPERLY. 
	b. IF YOU ADD MELETE TO _EXISTING SITES_, USERS WILL NOT HAVE THE MELETE
		PERMISSIONS THAT YOU CHECKED. YOU WILL NEED TO USE !SITE.HELPER OR OTHER 
		SCRIPT TO PROPAGATE THE MELETE PERMISSION TO EXISTING SITES. 		

7. Sakai 2.5.x (or Higher) Portal Icons

Sakai 2.5 and later supports icons in the portal for each tool. Sakai comes with icons for the tools that are bundled, and you can make a few simple edits to add icons for other tools such as Melete. The icons are part of the Sakai skin. The skin files are in the "library" webapp, which is located in your deployed tomcat in the folder

webapps/library/skin

The skin has to be enhanced in two ways:

    * make the new icons available
    * change the skin .css file to reference them

There is a "default" skin, and perhaps, depending on your customizations of Sakai, other skins. You need to make these changes for the skins that you are using. 

The following instructions show how to change the "default" skin, in the "library/skin/default" folder. To change the others, apply these same changes to the other skins, located in folders under "library/skin/".

		You can add an icon for Melete here:
		webapps/library/skin/default/icons/

		Create this folder, and download the icon into it:

		The Melete tool icon is modules-menu.png 
		
		You can get it from melete-app/src/webapp/images

		The file "portal.css" is where the icons are referenced. For the default skin, this file is here:

      webapps/library/skin/default/portal.css

      There is a section in there that lists lots of tools. We want to add one more:

      .icon-sakai-melete
      {
      background-image: url(icons/modules-menu.png);
      }

For future development, tutorials and solutions to common setup problems, see:
http://etudes.org/melete.htm

Questions? Contact sakai-dev@collab.sakaiproject.org or dev@etudes.org		