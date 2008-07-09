MELETE 2.5 SETUP INSTRUCTIONS
For a patched Sakai 2.3, patched Sakai 2.4, OR Sakai 2.5

Melete is a lesson builder tool for Sakai (A.K.A. Modules). To work with Melete source, you need the same development environment as Sakai, essentially Java 1.4 and Maven 1.0.2.

-----------------------------------------------------
SETUP INSTRUCTIONS

1. Patch Instructions
2. Configuring Melete  
3. Configuring Commercial Sferyx Editor (Optional)
4. Oracle Code Configuration
5. Internationalize Messages (Optional)
6. Compile Melete 
7. Database Configuration
8. Configure Site Archive to include Melete
9. Update Sakai Roles (under realms)
10. Sakai 2.5 Portal Icons
---------------------------------

1. Patch Instructions
   a. Sakai 2.3.x Patch Instructions
	** SKIP this step if you will run Melete with Sakai 2.4.**
	
	If you are using Sakai 2.3, you need to execute a patch that enables Sakai
	2.3 to run with Melete 2.5. The patch is at /patch/melete25patchsak23.sh.
	
	Instructions for running the path are in /patch/patch-SAK2.3_for_melete2.5.txt.
   
   b. Sakai 2.4.x Patch Instructions
	** SKIP this step if you will run Melete with Sakai 2.3.**
	
	If you are using Sakai 2.4, you need to execute a patch that enables Sakai
	2.4 to run with Melete 2.5. The patch is at /patch/melete25patchsak24.sh.
	
	Instructions for running the path are in /patch/patch-SAK2.4_for_melete2.5.txt.	
	
	NOTE: No patch is needed for Sakai 2.5

	
2. Configuring Melete 2.5 
       
  2.1 Packagingdir settings
	
	The dependency files for the export process are in the /var/melete/packagefiles directory in the Melete source code.
    Copy the /var directory and its contents into a directory. 

	Eg. If you are on unix/linux, and your packaging directory path is /var/melete/packagefiles, specify this in the following manner in web.xml
               
        <!-- Settings for packaging directory --> 
        <context-param>
		     <param-name>packagingdir</param-name>
		     <param-value>/var/melete/packagefiles</param-value>
	      </context-param>		    
        
	      
  2.2 Upload size settings for IMS import file
	
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
   apply patch located at /patch/migrate_oracle.txt

5. Internationalize Messages (Optional)
	If you want to run Melete in a different language than English, you need to update messages.properties of your language 
	under melete-app/src/bundle and under melete-impl/src/bundle.
	
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
	
	7.1 Set up the Melete tables: 
	
	You can either run the sql script manually; it is provided under
	/components/src/sql/mysql/melete25.sql, 
	
	OR
	
	When tomcat starts, hibernate will generate the melete tables 
	on its own by reading xml files. 
	
	NOTE: a. Make sure secondary indices on user_id column of melete_user_preference table and on course_id of melete_course_module table
	 		 are created.Hibernate sometimes doesn't create it. 
		  b. Melete stores content in the database tables as well as in the /private/meleteDocs folder in ContentHosting. 
        	 Through Melete, users only have access to the /private/meleteDocs folder and not other parts of Resources.

8. Configure Site Archive to include Melete 
	Melete now participates in Site Archive. Modify archive\archive-impl\pack\src\webapp\WEB-INF\components.xml, add
	<value>MeleteSecurityService</value> in the filterServices list.
	
	Compile and deploy archive again.	
	
9. Update Sakai Roles (under realms) to include Melete permissions

	(If you are simply upgrading Melete in your Sakai instance, no roles changes are needed)

	9.1. Log on as Sakai admin. Check appropriate Melete permissions under the roles in
	 !site.template.course. 
	
	* Check melete.author for teacher, instructor, faculty types of roles (maintain).
	* Check melete.student for student types of custom roles that you have (access).
		
	9.2. If you have project sites and related roles in !site.template.project, appropriate 
	permissions (melete.student or melete.author) need to be checked as defined above.
		
   CAUTION: 
	a. IF YOU FAIL TO CHECK THE MELETE.STUDENT AND MELETE.AUTHOR PERMISSIONS 
		FOR YOUR ROLES, MELETE WILL NOT WORK PROPERLY. 
	b. IF YOU ADD MELETE TO _EXISTING SITES_, USERS WILL NOT HAVE THE MELETE
		PERMISSIONS THAT YOU CHECKED. YOU WILL NEED TO USE !SITE.HELPER OR OTHER 
		SCRIPT TO PROPAGATE THE MELETE PERMISSION TO EXISTING SITES. 		

10. Sakai 2.5 Portal Icons

Sakai 2.5 and later supports icons in the portal for each tool. Sakai comes with icons for the tools that are bundled, and you can make a few simple edits to add icons for other tools such as Mneme. The icons are part of the Sakai skin. The skin files are in the "library" webapp, which is located in your deployed tomcat in the folder

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
		