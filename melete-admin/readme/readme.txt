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
For a patched Sakai 2.3 OR Sakai 2.4

Melete Admin tool is an administrative tool which lets admin users to clean up old deleted modules and sections and clean up their resources from database and the file System. To work with Melete Admin source, you need the same development environment as Sakai, essentially Java 1.4 and Maven 1.0.2.

-----------------------------------------------------
SETUP INSTRUCTIONS

1. Compile Melete Admin Tool
2. Add to the Admin Workspace

---------------------------------

1. Compile Melete Admin Tool
	 On the command prompt, go to the melete Admin source directory which you placed 
	under sakai and run maven commands just like you did for sakai.
	
	To build, run 'maven sakai:build' and then to deploy 'maven sakai:deploy'
	
	(for more instructions, see section titled 'Sakai Maven Goals' in the 
	"How we build Sakai Using Maven" document provided by Sakai lead developers)
	
	NOTE : This Admin tool depends on Melete code so make sure Melete 2.5 has been compiled and deployed before.

2. Add to the Admin Workspace	

	2.1. Log on as Sakai admin. Add this new tool sakai.meleteAdmin in the Administrative Workspace.
	
	2.2 To add Tool, go to Sites and pick !admin and than Edit Pages and add a new Page and provide the title for this new Tool like 'Melete Admin' and than add a new tool sakai.meleteAdmin. 		
	
	
NOTE : IT IS RECOMMENDED TO CREATE BACKUPS OF DATABASE AND THE FILE SYSTEM WHERE CONTENT RESIDES BEFORE RUNNING THIS TOOL.