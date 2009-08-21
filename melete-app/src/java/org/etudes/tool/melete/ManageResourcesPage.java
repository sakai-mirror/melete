/**********************************************************************************
 *
 * $URL$
 * $Id$  
 ***********************************************************************************
 *
 * Copyright (c) 2008 Etudes, Inc.
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

package org.etudes.tool.melete;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Pattern;

import org.sakaiproject.util.ResourceLoader;

import javax.faces.application.FacesMessage;
import javax.faces.component.UIData;
import javax.faces.component.UIViewRoot;
import javax.faces.context.FacesContext;

import javax.faces.el.ValueBinding;
import javax.faces.event.ActionEvent;

import javax.faces.model.SelectItem;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.sakaiproject.component.cover.ServerConfigurationService;
import org.sakaiproject.content.cover.ContentTypeImageService;
import org.sakaiproject.content.api.ContentResource;
import org.sakaiproject.entity.api.ResourceProperties;
import org.etudes.api.app.melete.MeleteCHService;

public class ManageResourcesPage {
  private String fileType;
  private String numberItems;


  /** Dependency:  The logging service. */
	protected Log logger = LogFactory.getLog(ManageResourcesPage.class);
	private MeleteCHService meleteCHService;

// delet resource variables
	private boolean sortAscFlag;
	private List<DisplayResources> displayResourcesList;
	private List<DisplayResources> allResourcesList;
	private RemoteFilesListingNav listNav;

  public ManageResourcesPage()
  {
	  sortAscFlag=true;
  }

  static Comparator<DisplayResources> ManageResourcesComparatorDesc = new Comparator<DisplayResources>() {
      public int compare(DisplayResources o1, DisplayResources o2) {
             return -1 * (o1.compareTo(o2));
      }
   };

public String addItems()
{
	FacesContext ctx = FacesContext.getCurrentInstance();
	ValueBinding binding =
        Util.getBinding("#{addResourcesPage}");
    AddResourcesPage arPage = (AddResourcesPage)binding.getValue(ctx);
    arPage.resetValues();
    arPage.setNumberItems(this.numberItems);
	if (this.fileType.equals("upload"))
	{
		arPage.setFileType("upload");
		return "file_upload_view";
	}
	if (this.fileType.equals("link"))
	{
		arPage.setFileType("link");
		return "link_upload_view";
	}
	return "manage_content";
}

public void resetValues()
{
	this.fileType = "upload";
	this.numberItems = "1";
	sortAscFlag = true;
	displayResourcesList = null;
	allResourcesList = null;
	listNav = null;
	getListNav();
	getAllResourcesList();
}

public String cancel()
{
	return "modules_author_manage";
}
public String getFileType()
{
	return this.fileType;
}

public void setFileType(String fileType)
{
	this.fileType = fileType;
}

public String getNumberItems()
{
	return this.numberItems;
}

public void setNumberItems(String numberItems)
{
	this.numberItems = numberItems;
}


// code for delete Resource
public String sortResourcesAsc()
{
	sortAscFlag=false;
	listNav.resetCurrIndex();
	sortList();
	return "#";
}


public String sortResourcesDesc()
{
	sortAscFlag=true;
	listNav.resetCurrIndex();
	sortList();
	return "#";
}


public void refreshCurrSiteResourcesList()
{
	displayResourcesList = null;
	allResourcesList = null;
	getListNav();
	getAllResourcesList();
	logger.debug("display nav bar" + getListNav().isDisplayNav());
}

private void sortList()
{
	if(sortAscFlag) java.util.Collections.sort(allResourcesList);
	else Collections.sort(allResourcesList,ManageResourcesComparatorDesc);
}

public List<DisplayResources> getAllResourcesList()
{
	try{
		if(allResourcesList == null)
		{
			logger.debug("from getallResourcesList - i am null");
			// get current site upload collection
			String uploadCollId = getMeleteCHService().getUploadCollectionId();

			// get list of all resources for upload type for the current site
			allResourcesList = new ArrayList<DisplayResources>();
			List<ContentResource> allmembers = null;
			allmembers = getMeleteCHService().getListofMediaFromCollection(uploadCollId);

			if(allmembers == null) return null;
			Iterator<ContentResource> allmembers_iter = allmembers.iterator();
			String serverUrl = ServerConfigurationService.getServerUrl();
			while(allmembers_iter != null && allmembers_iter.hasNext())
			{
				ContentResource cr = allmembers_iter.next();
				String displayName = cr.getProperties().getProperty(ResourceProperties.PROP_DISPLAY_NAME);
				if (displayName.length() > 50) displayName = displayName.substring(0,50) + "...";
			//	String rUrl = cr.getUrl().replaceAll(" ", "%20");
				String rUrl = getMeleteCHService().getResourceUrl(cr.getId());
				boolean rType = cr.getContentType().equals(getMeleteCHService().MIME_TYPE_LINK);			
				boolean rTypeLTI = cr.getContentType().equals(getMeleteCHService().MIME_TYPE_LTI);	
				String rgif=  serverUrl + "/library/image/sakai/url.gif";
				if(!rType && !rTypeLTI)
				{
				String contentextension = cr.getContentType();
		 		rgif = ContentTypeImageService.getContentTypeImage(contentextension);
		 	//	logger.debug("image provided for" + displayName +" is " +rgif);
		 		if(rgif.startsWith("sakai"))
		 			rgif = rgif.replace("sakai", (serverUrl + "/library/image/sakai"));
		 		else if (rgif.startsWith("/sakai"))
		 			rgif = rgif.replace("/sakai", (serverUrl + "/library/image/sakai"));
				}
				else if(rTypeLTI)
				{			
					rgif = "images/web_service.png";
				}
				allResourcesList.add(new DisplayResources(displayName, cr.getId(),rUrl,rType,rgif,rTypeLTI));
			}
			getListNav().setTotalSize(allResourcesList.size()+1);
			Collections.sort(allResourcesList);
		}


		} catch (Exception e){
			if (logger.isDebugEnabled()) {
			logger.debug("error in creating list for server residing files" + e.toString());
			e.printStackTrace();
				}
			}

	return allResourcesList;
}

public List<DisplayResources> getDisplayResourcesList()
{
	try{
		if(allResourcesList == null) getAllResourcesList();

		if(allResourcesList != null)
		{
			int fromIndex = getListNav().getCurrIndex();
			int toIndex = getListNav().getEndIndex();

			logger.debug("from and to index and total size" + fromIndex + "," +toIndex +"," +allResourcesList.size());
			displayResourcesList = null;
			if(fromIndex >= 0 && toIndex > fromIndex && toIndex <= allResourcesList.size())
			{
				displayResourcesList = (List)allResourcesList.subList(fromIndex,toIndex);
				logger.debug("displayResourcesList" + displayResourcesList.size());
			}
		}
	} catch (Exception e){
		if (logger.isDebugEnabled()) {
			logger.debug("error in creating displayList for server residing files" + e.toString());
			e.printStackTrace();
			}
		}

	return displayResourcesList;
}



public void selectedResourceDeleteAction(ActionEvent evt)
{
	FacesContext ctx = FacesContext.getCurrentInstance();
	Map sessionMap = ctx.getExternalContext().getSessionMap();
	String courseId = (String)sessionMap.get("courseId");
	UIViewRoot root = ctx.getViewRoot();
	UIData table = (UIData) root.findComponent("ManageContentForm:DeleteResourceView").findComponent("table");
	DisplayResources selectedDr = (DisplayResources) table.getRowData();
	logger.debug("selected row to delete " + selectedDr.getResource_id());

	ValueBinding binding =Util.getBinding("#{deleteResourcePage}");
	DeleteResourcePage delResPage = (DeleteResourcePage) binding.getValue(ctx);
	delResPage.resetValues();
	delResPage.setFromPage("manage_content");

	delResPage.setResourceName(selectedDr.getResource_title());
	delResPage.processDeletion(selectedDr.getResource_id(), courseId);
	return;
}

public String redirectDeleteLink()
{
	 return "delete_resource";
}


/**
 * @return the sortAscFlag
 */
public boolean isSortAscFlag()
{
	return this.sortAscFlag;
}

/*
*
* inner class to set required content resource values for display
*
*/
public class DisplayResources implements Comparable<DisplayResources>
{
	String resource_title;
	String resource_id;
	String resource_url;
	boolean typeLink;
	String resource_gif;
	boolean typeLTI;

	public boolean isTypeLTI() {
		return typeLTI;
	}
	public void setTypeLTI(boolean typeLTI) {
		this.typeLTI = typeLTI;
	}
	public DisplayResources(String resource_title,String resource_id, String resource_url, boolean isTypeLink,String resource_gif,boolean typeLTI)
	{
		this.resource_title = resource_title;
		this.resource_id = resource_id;
		this.resource_url = resource_url;
		this.typeLink = isTypeLink;
		this.resource_gif = resource_gif;
		this.typeLTI = typeLTI;
	}
	/**
	 * @return Returns the resource_id.
	 */
	public String getResource_id() {
		return resource_id;
	}
	/**
	 * @param resource_id The resource_id to set.
	 */
	public void setResource_id(String resource_id) {
		this.resource_id = resource_id;
	}
	/**
	 * @return Returns the resource_title.
	 */
	public String getResource_title() {
		return resource_title;
	}
	/**
	 * @param resource_title The resource_title to set.
	 */
	public void setResource_title(String resource_title) {
		this.resource_title = resource_title;
	}
	/**
	 * @return Returns the resource_url.
	 */
	public String getResource_url() {
		return resource_url;
	}
	/**
	 * @param resource_url The resource_url to set.
	 */
	public void setResource_url(String resource_url) {
		this.resource_url = resource_url;
	}
	/**
	 * @return the isTypeLink
	 */
	public boolean isTypeLink()
	{
		return this.typeLink;
	}
	/**
	 * @param isTypeLink the isTypeLink to set
	 */
	public void setTypeLink(boolean isTypeLink)
	{
		this.typeLink = isTypeLink;
	}

	public String toString()
	{
		return resource_title;
	}
	public int compareTo(DisplayResources n) {
		int res = 0;
		if(this.typeLTI) res = 1;
		// both are link or upload than equal
		if(this.typeLink == n.isTypeLink() && this.typeLTI == n.isTypeLTI())
			res= this.resource_title.compareToIgnoreCase(n.getResource_title());
		
		// this is link and n is upload
		if(this.typeLink && (!n.isTypeLink() || n.isTypeLTI())) res = -1;

		// this is upload and n is link
		if(!this.typeLink && n.isTypeLink()) res = 1;
		
		if(!this.typeLink && n.isTypeLTI()) res = -1;
				
		return res;
	}
	/**
	 * @return the resource_gif
	 */
	public String getResource_gif()
	{
		return this.resource_gif;
	}
	/**
	 * @param resource_gif the resource_gif to set
	 */
	public void setResource_gif(String resource_gif)
	{
		this.resource_gif = resource_gif;
	}
}

/**
 * @return the meleteCHService
 */
public MeleteCHService getMeleteCHService()
{
	return this.meleteCHService;
}


/**
 * @param meleteCHService the meleteCHService to set
 */
public void setMeleteCHService(MeleteCHService meleteCHService)
{
	this.meleteCHService = meleteCHService;
}

/**
 * @return Returns the listNav.
 */
public RemoteFilesListingNav getListNav() {
	if(listNav == null)
	{
		listNav = new RemoteFilesListingNav(0,0,30);
		listNav.setFromPage("manage_content");
	}
	return listNav;
}

}

