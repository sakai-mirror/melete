/**********************************************************************************
*
* $Header:
*
***********************************************************************************
*
* Copyright (c) 2004, 2005, 2006, 2007 Foothill College, ETUDES Project 
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
import org.sakaiproject.api.app.melete.exception.MeleteException;
import org.sakaiproject.content.api.ContentResource;
import org.sakaiproject.content.api.ContentCollection;
import org.sakaiproject.entity.api.ResourcePropertiesEdit;
import java.util.List;
/*
 * Created on Sep 18, 2006 by rashmi
 *
 *  This is a basic class to do all content hosting service work through melete
 */
public interface MeleteCHService{

	 public static final String MIME_TYPE_EDITOR="text/html";
	 public static final String MIME_TYPE_LINK="text/url";

	 public String addCollectionToMeleteCollection(String meleteItemColl,String CollName);
	 public String addResourceItem(String name, String res_mime_type,String addCollId, byte[] secContentData, ResourcePropertiesEdit res) throws Exception;

	 public ResourcePropertiesEdit fillInSectionResourceProperties(boolean encodingFlag,String secResourceName, String secResourceDescription);
	 public ResourcePropertiesEdit fillEmbeddedImagesResourceProperties(String name);
	 public void editResourceProperties(String selResourceIdFromList, String secResourceName, String secResourceDescription);

	 public String getCollectionId( String contentType,Integer modId );
	 public String getUploadCollectionId();
	 
	 //Methods used by migrate program - BEG
	 public String getCollectionId(String courseId,String contentType,Integer modId );
	 public String getUploadCollectionId(String courseId);
	 //Methods used by migrate program - END
	 
     public List getListofImagesFromCollection(String collId);
	 public List getListofLinksFromCollection(String collId);
	 public String findLocalImagesEmbeddedInEditor(String uploadHomeDir, String contentEditor)throws MeleteException;
	 public ContentResource getResource(String resourceId) throws Exception;
	 public void checkResource(String resourceId) throws Exception;
	 public void editResource(String resourceId, String contentEditor) throws Exception;
	 public List getAllResources(String uploadCollId);
	 public String getResourceUrl(String resourceId);
	 public void copyIntoFolder(String fromColl,String toColl);
	 public ContentCollection getCollection(String toColl);	 
}

