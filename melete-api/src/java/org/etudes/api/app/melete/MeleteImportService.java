/**********************************************************************************
 *
 * $URL$
 * $Id$  
 ***********************************************************************************
 *
 * Copyright (c) 2008, 2009 Etudes, Inc.
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
package org.etudes.api.app.melete;

import java.io.File;
import org.dom4j.Document;

public interface MeleteImportService
{
	/**
	 * deletes the file and its children
	 * 
	 * @param delfile
	 *        file to be deleted
	 */
	public void deleteFiles(File delfile);

	/**
	 * Get the package's content provider contact information from rights description of manifest tag.
	 * 
	 * @param document
	 *        Document
	 * @return
	 */
	public String getContentSourceInfo(Document document);

	/**
	 * Merges melete data in the Sakai archive Document object
	 * 
	 * @param ArchiveDoc
	 *        Sakai generated Archive Document Object
	 * @param unZippedDirPath
	 *        Unzipped directory path
	 * @param fromSiteId
	 *        The site Id
	 * @return the count of merged modules
	 * @throws Exception
	 */
	public int mergeAndBuildModules(Document ArchiveDoc, String unZippedDirPath, String fromSiteId) throws Exception;

	/**
	 * Reads IMS package. Parses the manifest file and import modules.
	 * 
	 * @param document
	 *        document
	 * @param unZippedDirPath
	 *        unZipped files Directory Path
	 * @exception throws exception
	 */
	public void parseAndBuildModules(Document document, String unZippedDirPath) throws Exception;
}
