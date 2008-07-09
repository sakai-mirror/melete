INSTRUCTIONS TO UPGRADE FROM MELETE 2.4.5 >> MELETE 2.5
For a patched Sakai 2.3, patched Sakai 2.4, OR Sakai 2.5
-----------------------------------------------------
SETUP INSTRUCTIONS

1. Patch Instructions
2. Oracle Code Configuration
3. Internationalize Messages (Optional)
4. Compile Melete 
5. Database Configuration
6. Configure Site Archive to include Melete
7. Sakai 2.5 Portal Icons
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

2. Oracle Code Configuration
   ** SKIP this step if you are NOT using Oracle.**
   
   If you are using Oracle, due to differences in Oracle query behavior, you will need to 
   apply patch located at /patch/migrate_oracle.txt

3. Internationalize Messages (Optional)
	If you want to run Melete in a different language than English, you need to update messages.properties of your language 
	under melete-app/src/bundle and under melete-impl/src/bundle.
	   
4. Compile Melete
     On the command prompt, go to the melete source directory which you placed 
	under sakai and run maven commands just like you did for sakai.
	
	To build, run 'maven sakai:build' and then to deploy 'maven sakai:deploy'
	
	(for more instructions, see section titled 'Sakai Maven Goals' in the 
	"How we build Sakai Using Maven" document provided by Sakai lead developers)

5. Database Configuration
  
	* Melete works with HSQLDB, Oracle or Mysql4.1 Database. The driver used is 
	the MySql Connector/J 3.1.12 (same as Sakai). It has been tested just on Mysql, 
	but it has been deployed successfully with Oracle at many universities. 
	
	* Melete shares the same database as Sakai's and adds a few tables to the database. 
	
	5.1. To setup the Melete tables: 
	
		a. Create a backup of existing Melete tables.
		
		b. You need to run the Melete upgrade script manually
		Mysql Users: /components/src/sql/mysql/melete25_upgrade.sql
		Oracle Users: /components/src/sql/oracle/melete25_upgrade.sql
		
		NOTE: Please make sure secondary index on user_id column of melete_user_preference table is created.
			  Hibernate sometimes doesn't create it.
			   
	5.2. It is necessary to run this script in order for the upgrade to run successfully.
	    As of Melete2.5, we are moving the dtd declaration for the SEQ_XML column in MELETE_MODULE
		from an external reference to an internal inline dtd. The script /components/src/sql/mysql/seqxml_script.sql
		achieves this. Review the script and make sure dtdlocation variable is set up correctly
		for your installation. Execute this script and check the MELETE_MODULE table to make sure
		the SEQ_XML column has been updated correctly.
		
	Start tomcat, make sure there are no errors in the logs.
		
6. Configure Site Archive to include Melete 
	Melete now participates in Site Archive. Modify archive\archive-impl\pack\src\webapp\WEB-INF\components.xml, add
	<value>MeleteSecurityService</value> in the filterServices list.
	
	Compile and deploy archive again.	
	
7. Sakai 2.5 Portal Icons

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
		
		You can get it from melete-app/src/webapp/melete/images

		The file "portal.css" is where the icons are referenced. For the default skin, this file is here:

      webapps/library/skin/default/portal.css

      There is a section in there that lists lots of tools. We want to add one more:

      .icon-sakai-melete
      {
      background-image: url(icons/modules-menu.png);
      }

For future development, tutorials and solutions to common setup problems, see:
http://etudes.org/melete.htm
		