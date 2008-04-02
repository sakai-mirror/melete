INSTRUCTIONS TO UPGRADE FROM MELETE 2.3m2 >> MELETE 2.4
For Sakai 2.5
-----------------------------------------------------
SETUP INSTRUCTIONS

1. Configuring Melete  
2. Upload size settings for IMS import file
3. Configuring Sferyx Editor (Optional)
4. Oracle Code Configuration
5. Compile Melete 
6. Database Configuration
7. Run migrate process
8. Adding melete icon to sakai site left menu
---------------------------------

1. Configuring Melete 2.4 

    The settings below need to be performed in the /melete-app/src/webapp/WEB-INF/web.xml file.

    1.1. Packagingdir settings
	
	The dependency files for the export process are in the /var/melete/packagefiles directory in the Melete source code.
    Copy the /var directory and its contents into a directory. 
	Eg. If you are on unix/linux, and your packaging directory path is /var/melete/packagefiles, specify this in the following manner in web.xml
               
        <!-- Settings for packaging directory --> 
        <context-param>
		     <param-name>packagingdir</param-name>
		     <param-value>/var/melete/packagefiles</param-value>
	      </context-param>	
	       <!-- Settings for scorm packaging directory --> 
        <context-param>
		     <param-name>packagingscormdir</param-name>
		     <param-value>/var/melete/packagefiles/packagefilesscorm</param-value>
	      </context-param>		
	      
   1.2. Meletedocs settings
            
	Specify the absolute path to your current meleteDocs directory in the meleteDocsDir 
	parameter of web.xml.
        
	Eg. If you are on unix/linux, if your current meleteDocs directory is /var/meleteDocs, 
	specify this in the following manner in web.xml.
           
        <!-- Settings for meleteDocs directory -->
        <context-param>
				 <param-name>meleteDocsDir</param-name>
				 <param-value>/var/meleteDocs</param-value>
		</context-param>
			      
2. Upload size settings for IMS import file
	
	By setting this sakai property, system administrators can set a different file upload 
	limit for Melete IMS CP import than the upload max limit for content files. If this 
	property is not set, then melete assumes the max value as 50MB.

	content.upload.ceiling=50		
	
3. Configuring Commercial Sferyx Editor (Optional)

                       ***** BEGIN OPTIONAL STEP ******
					   
   3.1 SFERYX SOURCE
		a. Purchase a license and binary source for Sferyx (http://www.sferyx.com)
		b. Add the purchased applet jar file under /melete-app/src/webapp. 
		c. Change settings in melete web.xml for enabling uploads of embedded media
			 *  Create a directory for enabling uploads of embedded media via the Sferyx editor.
			 * Make sure the owner and group of this directory is the same as that of the tomcat instances. 
			 * Specify the absolute path to this directory in web.xml under the uploadDir 
			 context-param settings *AND* under the Orielly filter's settings.

				Eg. If you are on unix/linux, and your uploads directory is /var/uploads, 
				specify this in the following manner in web.xml
				
				<!--Context param area->
				 <context-param>
					 <param-name>uploadDir</param-name>
					 <param-value>/var/uploads</param-value>
				</context-param>
				
				<!-- Oreilly filter settings -->
				 <init-param>
						<param-name>uploadDir</param-name>
						<param-value>/var/uploads</param-value>
				</init-param>	      

	3.2. DEFAULT MELETE EDITOR 
		 This is done by specifying the following property. For example, if the 
		 default Melete editor is Sferyx,
		
			melete.wysiwyg.editor=Sferyx Editor
		
		If this property is NOT set, the code uses the editor specified by the wysiwyg.editor property.
		
	3.3. LIST OF AVAILABLE MELETE EDITORS 
		The preference feature allows users to select the editor for Melete content authoring. 
		List the editor choices for users in sakai.properties as specified below. For example, 
		if the user has two choices, Sferyx and FCK Editor, the settings will be as follows:
			
		melete.wysiwyg.editor.count=2
		melete.wysiwyg.editor1=Sferyx Editor
		melete.wysiwyg.editor2=FCK Editor
			
		NOTE : Please make sure that the names have proper spaces as this is used to display 
		the labels of the available editors on the Preferences page.
		
                              ***** END OF OPTIONAL STEP **********

4. Oracle Code Configuration
   ** SKIP this step if you are NOT using Oracle.**
   
   If you are using Oracle, due to differences in Oracle query behavior, you will need to 
   perform the following step:
   Replace two methods (migrateMeleteDocs and processLicenseInformation) 
   in /melete-impl/src/java/org/sakaiproject/component/app/melete/ModuleServiceImpl.java
   with their corresponding Oracle versions, located at /patch/migrate_oracle.txt
   
5. Compile Melete
     On the command prompt, go to the melete source directory which you placed 
	under sakai and run maven commands just like you did for sakai.
	
	To build, run 'mvn clean install' and then to deploy 'mvn sakai:deploy'
	
	(for more instructions, see section titled 'Sakai Maven Goals' in the 
	"How we build Sakai Using Maven" document provided by Sakai lead developers)

6. Database Configuration
  
	* Melete works with HSQLDB, Oracle or Mysql4.1/5.0.x Database. The driver used is 
	the same as Sakai. It has been tested just on Mysql, 
	but it has been deployed successfully with Oracle at many universities. 
	
	* Melete shares the same database as Sakai's and adds a few tables to the database. 
	
	7.1. To setup the Melete tables: 
	
		a. Create a backup of the entire sakai database since this upgrade 
		requires migration of content.
	
		b. You need to run the Melete upgrade script manually
		Mysql Users: /components/src/sql/mysql/melete24_upgrade.sql
		Oracle Users: /components/src/sql/oracle/melete24_upgrade.sql
	
		c. As of Melete2.4, the column LICENSE_CODE in MELETE_MODULE  and the table 
		MELETE_MODULE_LICENSE are no longer needed.
		
		Note: The following queries may vary in syntax for Oracle users.
		In order to drop the column, you first need to drop the constraint on the column.
	
		To determine the name of the constraint, use:
		SHOW CREATE TABLE melete_module;
	
		To drop the foreign key constraint on the LICENSE_CODE column, use:
		ALTER TABLE melete_module DROP FOREIGN KEY <foreign_key_constraint_name>;
	
		Now, drop the LICENSE_CODE column and the MELETE_MODULE_LICENSE table:
		ALTER TABLE melete_module DROP COLUMN LICENSE_CODE;
		DROP TABLE melete_module_license;
	
        NOTE: Melete stores content in the database tables as well as in the /private/meleteDocs folder in ContentHosting. 
        Through Melete, users only have access to the /private/meleteDocs folder and not other parts of Resources.
		    
	
7. Run migrate process 

This is a MANDATORY step. The migrate process moves Melete content that currently resides in your meleteDocs directory to ContentHosting. It can only be run by administrators. Depending on amount of content, migration can take a few hours. 

	7.1. In sakai.properties, specify the following property and set it to true.

 	  melete.migrate=true
   
	7.2. Start tomcat. Make sure there are no errors in the logs as tomcat starts. 
		Log in as administrator. 

	7.3. Click on the Modules link in any of your courses. Melete content will migrate 
	from the filesystem to contentHosting for all courses. Upon successful completion, 
	you will see a message saying the process has completed. 

	7.4. Upon successful migration, please remove the melete.migrate property from sakai.properties.
   
   Troubleshooting:
   
   If the migrate process fails, the logs need to be checked for errors. 
   
   Once the errors are corrected, log in as administrator into Sakai, 
   go to My workspace->Resources, expand the /private folder 
   and delete the meleteDocs folder under it.

   Further, the following commands need to be run:
   DELETE FROM melete_migrate_status;
   DELETE FROM melete_section_resource;
   DELETE FROM melete_resource;
   
   Now, the process may be restarted by following the instructions above. The process 
   will restart from scratch and migrate content from the filesystem to contentHosting.

8. Adding melete icon to sakai site left menu
 
     If you are using sakai's default cascading style sheet create the icons folder under tomcat/webapps/library/skin/default/
     and copy the image modules-menu.png from melete-app/src/webapp/images/sakai-menu to
     tomcat/webapps/library/skin/default/icons. 
 
     Add the below line to tomcat/webapps/library/skin/default/portal.css
        
     .icon-sakai-melete-tool{
     	background-image: url(icons/modules-menu.png);
     }
     
For future development, tutorials and solutions to common setup problems, see:
http://etudesproject.org/melete.htm   