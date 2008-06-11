INSTRUCTIONS TO UPGRADE FROM MELETE 2.4.5 >> MELETE 2.5
For a patched Sakai 2.3 OR Sakai 2.4
-----------------------------------------------------
SETUP INSTRUCTIONS

1. Patch Instructions
2. Configuring Melete  
3. Upload size settings for IMS import file
4. Configuring Sferyx Editor (Optional)
5. Oracle Code Configuration
6. Compile Melete 
7. Database Configuration
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
	
2. Configuring Melete 2.5 

    The settings below need to be performed in the /melete-app/src/webapp/WEB-INF/web.xml file.

    2.1. Packagingdir settings
	
	The dependency files for the export process are in the /var/melete/packagefiles directory in the Melete source code.
    Copy the /var directory and its contents into a directory. 
	Eg. If you are on unix/linux, and your packaging directory path is /var/melete/packagefiles, specify this in the following manner in web.xml
               
        <!-- Settings for packaging directory --> 
        <context-param>
		     <param-name>packagingdir</param-name>
		     <param-value>/var/melete/packagefiles</param-value>
	      </context-param>		
	      
			      
3. Upload size settings for IMS import file
	
	By setting this sakai property, system administrators can set a different file upload 
	limit for Melete IMS CP import than the upload max limit for content files. If this 
	property is not set, then melete assumes the max value as 50MB.

	content.upload.ceiling=50		
	
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
	
		a. Create a backup of existing Melete tables.
		
		b. You need to run the Melete upgrade script manually
		Mysql Users: /components/src/sql/mysql/melete25_upgrade.sql
		Oracle Users: /components/src/sql/oracle/melete25_upgrade.sql
		
	7.2. It is necessary to run this script in order for the upgrade to run successfully.
	    As of Melete2.5, we are moving the dtd declaration for the SEQ_XML column in MELETE_MODULE
		from an external reference to an internal inline dtd. The script /components/src/sql/mysql/seqxml_script.sql
		achieves this. Review the script and make sure dtdlocation variable is set up correctly
		for your installation. Execute this script and check the MELETE_MODULE table to make sure
		the SEQ_XML column has been updated correctly.
		
	Start tomcat, make sure there are no errors in the logs.
		

For future development, tutorials and solutions to common setup problems, see:
http://etudesproject.org/melete.htm   