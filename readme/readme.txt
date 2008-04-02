MELETE 2.4 SETUP INSTRUCTIONS
For Sakai 2.5

Melete is a lesson builder tool for Sakai (A.K.A. Modules). To work with Melete source, you need the same development environment as Sakai, essentially Java 1.5 and Maven 2.0.8.

-----------------------------------------------------
SETUP INSTRUCTIONS

1. Configuring Melete  
2. Configuring Commercial Sferyx Editor (Optional)
3. Compile Melete 
4. Database Configuration
5. Update Sakai Roles (under realms)


---------------------------------

1. Configuring Melete 2.4 
       
  1.1 Packagingdir settings
	
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
	      
  1.2 Upload size settings for IMS import file
	
	By setting this sakai property, system administrators can set a different file upload 
	limit for Melete IMS CP import than the upload max limit for content files. If this 
	property is not set, then melete assumes the max value as 50MB.

	content.upload.ceiling=50

2. Configuring Commercial Sferyx Editor (Optional)

                       ***** BEGIN OPTIONAL STEP ******
					   
  2.1 SFERYX SOURCE
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

 2.2. DEFAULT MELETE EDITOR 
		 This is done by specifying the following property. For example, if the 
		 default Melete editor is Sferyx,
		
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

3. Compile Melete
	 On the command prompt, go to the melete source directory which you placed 
	under sakai and run maven commands just like you did for sakai.
	
	To build, run 'mvn clean install' and then to deploy 'mvn sakai:deploy'
	
	(for more instructions, see section titled 'Sakai Maven Goals' in the 
	"How we build Sakai Using Maven" document provided by Sakai lead developers)
	
4. Database Configuration

	* Melete works with HSQLDB, Oracle or Mysql4.1/5.0.x Database. The driver used is 
	the same as Sakai. It has been tested just on Mysql, 
	but it has been deployed successfully with Oracle at many universities. 
	
	* Melete shares the same database as Sakai's and adds a few tables to the database. 
	
	4.1 Set up the Melete tables: 
	
	You can either run the sql script manually; it is provided under
	/components/src/sql/mysql/melete24.sql, 
	
	OR
	
	When tomcat starts, hibernate will generate the melete tables 
	on its own by reading xml files. If you have hibernate create tables for you,
	please also run the /components/src/sql/mysql/melete24mig.sql script manually since some 
	entities are not created by Hibernate.
	
	NOTE: Melete stores content in the database tables as well as in the /private/meleteDocs folder in ContentHosting. 
        Through Melete, users only have access to the /private/meleteDocs folder and not other parts of Resources.
	

5. Update Sakai Roles (under realms) to include Melete permissions

	(If you are simply upgrading Melete in your Sakai instance, no roles changes are needed)

	5.1. Log on as Sakai admin. Check appropriate Melete permissions under the roles in
	 !site.template.course. 
	
	* Check melete.author for teacher, instructor, faculty types of roles (maintain).
	* Check melete.student for student types of custom roles that you have (access).
		
	5.2. If you have project sites and related roles in !site.template.project, appropriate 
	permissions (melete.student or melete.author) need to be checked as defined above.
		
   CAUTION: 
	a. IF YOU FAIL TO CHECK THE MELETE.STUDENT AND MELETE.AUTHOR PERMISSIONS 
		FOR YOUR ROLES, MELETE WILL NOT WORK PROPERLY. 
	b. IF YOU ADD MELETE TO _EXISTING SITES_, USERS WILL NOT HAVE THE MELETE
		PERMISSIONS THAT YOU CHECKED. YOU WILL NEED TO USE !SITE.HELPER OR OTHER 
		SCRIPT TO PROPAGATE THE MELETE PERMISSION TO EXISTING SITES. 		

For future development, tutorials and solutions to common setup problems, see:
http://etudesproject.org/melete.htm
		