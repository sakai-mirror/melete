INSTRUCTIONS TO UPGRADE FROM MELETE 2.3m2 >> MELETE 2.4
For Sakai 2.4 OR a patched Sakai 2.3.x
-----------------------------------------------------
SETUP INSTRUCTIONS

1. Patch Instructions
2. Melete Source
3. Configuring Melete  
4. Configuring Sferyx Editor (Optional)
5. Oracle Code Configuration
6. Compile Melete 
7. Database Configuration
8. Run migrate process
---------------------------------

1. Patch Instructions
   a. Sakai 2.3.x Patch Instructions
	** SKIP this step if you will run Melete with Sakai 2.4.**
	
	If you are using Sakai 2.3, you need to execute a patch that enables Sakai
	2.3 to run with Melete 2.4. The patch is at /patch/melete24patchsak23.sh.
	
	Instructions for running the path are in /patch/patch-SAK2.3_for_melete2.4.txt.
   
   b. Sakai 2.4.x Patch Instructions
	** SKIP this step if you will run Melete with Sakai 2.3.**
	
	If you are using Sakai 2.4, you need to execute a patch that enables Sakai
	2.4 to run with Melete 2.4. The patch is at /patch/melete24patchsak24.sh.
	
	Instructions for running the path are in /patch/patch-SAK2.4_for_melete2.4.txt.	
	
2. Melete Source

Melete is a lesson builder tool for Sakai (A.K.A. Modules). All the source code for the release is included in the .tar.gz and .zip files. To work with Melete source, you need the same development environment as Sakai, essentially Java 1.4 and Maven 1.0.2.

	2.1. Make a backup of your existing Melete2.3m2 directory!

	2.2. Unzip the melete 2.4 source code zip file and place the melete source under Sakai.
	
3. Configuring Melete 2.4 

    The settings below need to be performed in the /melete-app/src/webapp/WEB-INF/web.xml file.

    3.1. Packagingdir settings
	
	The dependency files for the export process are in the /melete/packagefiles directory in the melete source code. Copy the /melete directory and its contents into a directory. Ensure that this directory and its children have read and write permissions. Specify the absolute path to this directory in web.xml. 
	
	Eg. If you are on unix/linux, and your packaging directory path is /var/melete/packagefiles, specify this in the following manner in web.xml
               
        <!-- Settings for packaging directory --> 
        <context-param>
		     <param-name>packagingdir</param-name>
		     <param-value>/var/melete/packagefiles</param-value>
	      </context-param>		
	      
   3.2. Meletedocs settings
            
	Specify the absolute path to your current meleteDocs directory in the meleteDocsDir 
	parameter of web.xml.
        
	Eg. If you are on unix/linux, if your current meleteDocs directory is /var/meleteDocs, 
	specify this in the following manner in web.xml.
           
        <!-- Settings for meleteDocs directory -->
        <context-param>
				 <param-name>meleteDocsDir</param-name>
				 <param-value>/var/meleteDocs</param-value>
		</context-param>	      
		
4. Configuring Commercial Sferyx Editor (Optional)

                       ***** BEGIN OPTIONAL STEP ******
					   
   4.1 SFERYX SOURCE
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

	4.2. DEFAULT MELETE EDITOR 
		 This is done by specifying the following property. For example, if the 
		 default Melete editor is Sferyx,
		
			melete.wysiwyg.editor=Sferyx Editor
		
		If this property is NOT set, the code uses the editor specified by the wysiwyg.editor property.
		
	4.3. LIST OF AVAILABLE MELETE EDITORS 
		The preference feature allows users to select the editor for Melete content authoring. 
		List the editor choices for users in sakai.properties as specified below. For example, 
		if the user has two choices, Sferyx and FCK Editor, the settings will be as follows:
			
		melete.wysiwyg.editor.count=2
		melete.wysiwyg.editor1=Sferyx Editor
		melete.wysiwyg.editor2=FCK Editor
			
		NOTE : Please make sure that the names have proper spaces as this is used to display 
		the labels of the available editors on the Preferences page.
		
                              ***** END OF OPTIONAL STEP **********

5. Oracle Code Configuration
   ** SKIP this step if you are NOT using Oracle.**
   
   If you are using Oracle, due to differences in Oracle query behavior, you will need to 
   perform the following step:
   Replace two methods (migrateMeleteDocs and processLicenseInformation) 
   in /melete-impl/src/java/org/sakaiproject/component/app/melete/ModuleServiceImpl.java
   with their corresponding Oracle versions, located at /patch/migrate_oracle.txt
   
6. Compile Melete
     On the command prompt, go to the melete source directory which you placed 
	under sakai and run maven commands just like you did for sakai.
	
	To build, run 'maven sakai:build' and then to deploy 'maven sakai:deploy'
	
	(for more instructions, see section titled 'Sakai Maven Goals' in the 
	"How we build Sakai Using Maven" document provided by Sakai lead developers)

7. Database Configuration
  
	* Melete works with HSQLDB, Oracle or Mysql4.1 Database. The driver used is 
	the MySql Connector/J 3.1.12 (same as Sakai). It has been tested just on Mysql, 
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
	
	    
	
8. Run migrate process 

This is a MANDATORY step. The migrate process moves Melete content that currently resides in your meleteDocs directory to ContentHosting. It can only be run by administrators. Depending on amount of content, migration can take a few hours. 

	8.1. In sakai.properties, specify the following property and set it to true.

 	  melete.migrate=true
   
	8.2. Start tomcat. Make sure there are no errors in the logs as tomcat starts. 
		Log in as administrator. 

	8.3. Click on the Modules link in any of your courses. Melete content will migrate 
	from the filesystem to contentHosting for all courses. Upon successful completion, 
	you will see a message saying the process has completed. 

	8.4. The melete.migrate property can now be removed from sakai.properties. 
   
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