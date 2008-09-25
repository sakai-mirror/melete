/**********************************************************************************
*
* $Header:
*
***********************************************************************************
*
  * Copyright (c) 2008 Etudes, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Portions completed before September 1, 2008 Copyright (c) 2004, 2005, 2006, 2007, 2008 Foothill College, ETUDES Project
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
package org.sakaiproject.api.app.melete;

import java.io.File;
import org.dom4j.Document;


/**
 * <p>MeleteImportExportService provides the methods for import export</p>
 * @author Foothill College
 *
 */
public interface MeleteImportService{

	/**
	 * deletes the file and its children
	 * @param delfile - file to be deleted
	 */
	public void deleteFiles(File delfile);

	/**
	 * Parses the manifest and build modules
	 *
	 * @param document document
	 * @param unZippedDirPath unZipped fiels Directory Path
	 * @exception throws exception
	 */
	public void parseAndBuildModules(Document document, String unZippedDirPath) throws Exception;
	public void copyModules(String fromContext, String toContext);
	public String getDestinationContext();
	public int mergeAndBuildModules(Document ArchiveDoc, String unZippedDirPath, String fromSiteId) throws Exception;

}