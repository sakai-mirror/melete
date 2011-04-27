/**********************************************************************************
 *
 * $URL: https://source.sakaiproject.org/contrib/etudes/melete/trunk/melete-app/src/java/org/etudes/tool/melete/LicensePage.java $
 * $Id: LicensePage.java 60573 2009-05-19 20:17:20Z mallika@etudes.org $
 ***********************************************************************************
 *
 * Copyright (c) 2008, 2009, 2010, 2011 Etudes, Inc.
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
 **********************************************************************************/
package org.etudes.tool.melete;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Iterator;
import java.util.List;

import javax.faces.component.UICommand;
import javax.faces.component.UIParameter;
import javax.faces.context.FacesContext;
import javax.faces.el.ValueBinding;
import javax.faces.event.ActionEvent;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.etudes.api.app.melete.MeleteCHService;
import org.etudes.api.app.melete.SectionService;
import org.sakaiproject.component.cover.ServerConfigurationService;
import org.sakaiproject.content.api.ContentResource;
import org.sakaiproject.content.cover.ContentTypeImageService;
import org.sakaiproject.entity.api.ResourceProperties;

public class ListResourcesPage
{
	/*
	 * 
	 * inner class to set required content resource values for display
	 */
	public class DisplaySecResources implements Comparable<DisplaySecResources>
	{
		String resource_gif;
		String resource_id;
		String resource_title;
		String resource_url;
		boolean typeLink;
		boolean typeLTI;

		/**
		 * constructor
		 * 
		 * @param resource_title
		 * @param resource_id
		 * @param resource_url
		 * @param isTypeLink
		 * @param resource_gif
		 * @param typeLTI
		 */
		public DisplaySecResources(String resource_title, String resource_id, String resource_url, boolean isTypeLink, String resource_gif,
				boolean typeLTI)
		{
			this.resource_title = resource_title;
			this.resource_id = resource_id;
			this.resource_url = resource_url;
			this.typeLink = isTypeLink;
			this.resource_gif = resource_gif;
			this.typeLTI = typeLTI;
		}

		/**
		 * @return result of comparison
		 */
		public int compareTo(DisplaySecResources n)
		{
			int res = 0;
			if (this.typeLTI) res = 1;
			// both are link or upload than equal
			if (this.typeLink == n.isTypeLink() && this.typeLTI == n.isTypeLTI())
				res = this.resource_title.compareToIgnoreCase(n.getResource_title());

			// this is link and n is upload
			if (this.typeLink && (!n.isTypeLink() || n.isTypeLTI())) res = -1;

			// this is upload and n is link
			if (!this.typeLink && n.isTypeLink()) res = 1;

			if (!this.typeLink && n.isTypeLTI()) res = -1;

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
		 * @return Returns the resource_id.
		 */
		public String getResource_id()
		{
			return resource_id;
		}

		/**
		 * @return Returns the resource_title.
		 */
		public String getResource_title()
		{
			return resource_title;
		}

		/**
		 * @return Returns the resource_url.
		 */
		public String getResource_url()
		{
			return resource_url;
		}

		/**
		 * @return value of typeLink
		 */
		public boolean isTypeLink()
		{
			return this.typeLink;
		}

		/**
		 * @return value of typeLTI
		 */
		public boolean isTypeLTI()
		{
			return typeLTI;
		}

		/**
		 * @param resource_gif
		 *        the resource_gif to set
		 */
		public void setResource_gif(String resource_gif)
		{
			this.resource_gif = resource_gif;
		}

		/**
		 * @param resource_id
		 *        The resource_id to set.
		 */
		public void setResource_id(String resource_id)
		{
			this.resource_id = resource_id;
		}

		/**
		 * @param resource_title
		 *        The resource_title to set.
		 */
		public void setResource_title(String resource_title)
		{
			this.resource_title = resource_title;
		}

		/**
		 * @param resource_url
		 *        The resource_url to set.
		 */
		public void setResource_url(String resource_url)
		{
			this.resource_url = resource_url;
		}

		/**
		 * @param typeLink
		 *        value to set
		 */
		public void setTypeLink(boolean isTypeLink)
		{
			this.typeLink = isTypeLink;
		}

		/**
		 * @param typeLTI
		 *        typeLTI value to set
		 */
		public void setTypeLTI(boolean typeLTI)
		{
			this.typeLTI = typeLTI;
		}

		/*
		 * @return value of resource_title
		 */
		public String toString()
		{
			return resource_title;
		}
	}

	/**
	 * The comparator to sort list ascending or descending
	 */
	static Comparator<DisplaySecResources> SectionResourcesComparatorDesc = new Comparator<DisplaySecResources>()
	{
		public int compare(DisplaySecResources o1, DisplaySecResources o2)
		{
			return -1 * (o1.compareTo(o2));
		}
	};
	public String fromPage;
	public String secResourceName;
	private boolean callFromSection;
	private List<DisplaySecResources> displayResourcesList;
	private RemoteFilesListingNav listNav;
	private boolean renderSelectedResource = false;
	private String selResourceIdFromList;
	private boolean sortAscFlag;
	protected List<DisplaySecResources> currSiteResourcesList;
	/** Dependency: The logging service. */
	protected Log logger = LogFactory.getLog(ListResourcesPage.class);
	protected MeleteCHService meleteCHService;
	protected SectionService sectionService;
	protected ServerConfigurationService serverConfigurationService;

	protected boolean shouldRenderLink = false;

	protected boolean shouldRenderLTI = false;

	protected boolean shouldRenderUpload = false;

	/**
	 * Default constructor
	 */
	public ListResourcesPage()
	{
	}

	/**
	 * Lists resources by fetching the appropriate ones(links/upload/lti/all) depending on page that this method is invoked from
	 * 
	 * @return Returns the currSiteResourcesList.
	 */
	public List<DisplaySecResources> getCurrSiteResourcesList()
	{
		try
		{
			if (currSiteResourcesList == null)
			{
				logger.debug("from getCurrSiteResourcesList - i am null");
				// get current site upload collection
				FacesContext ctx = FacesContext.getCurrentInstance();
				ValueBinding binding = Util.getBinding("#{meleteSiteAndUserInfo}");
				MeleteSiteAndUserInfo mPage = (MeleteSiteAndUserInfo) binding.getValue(ctx);
				String uploadCollId = getMeleteCHService().getUploadCollectionId(mPage.getCurrentSiteId());

				// get list of all resources for upload type for the current site
				currSiteResourcesList = new ArrayList<DisplaySecResources>();

				List<?> allmembers = null;
				if (this.fromPage == null) return null;

				// to create list of resource whose type is typeUpload
				if (this.fromPage.equals("ContentUploadServerView") || this.fromPage.equals("editContentUploadServerView"))
				{
					allmembers = getMeleteCHService().getListofFilesFromCollection(uploadCollId);
				}

				if (this.fromPage.equals("ContentLinkServerView") || this.fromPage.equals("editContentLinkServerView"))
				{
					allmembers = getMeleteCHService().getListofLinksFromCollection(uploadCollId);
				}

				if (this.fromPage.equals("ContentLTIServerView") || this.fromPage.equals("editContentLTIServerView"))
				{
					allmembers = getMeleteCHService().getListFromCollection(uploadCollId, MeleteCHService.MIME_TYPE_LTI);
				}

				if (this.fromPage.equals("manage_content"))
				{
					allmembers = getMeleteCHService().getListofMediaFromCollection(uploadCollId);
				}

				if (allmembers == null)
				{
					return null;
				}
				Iterator<?> allmembers_iter = allmembers.iterator();
				String serverUrl = ServerConfigurationService.getServerUrl();
				while (allmembers_iter != null && allmembers_iter.hasNext())
				{
					ContentResource cr = (ContentResource) allmembers_iter.next();
					String displayName = cr.getProperties().getProperty(ResourceProperties.PROP_DISPLAY_NAME);
					if (displayName.length() > 50) displayName = displayName.substring(0, 50) + "...";
					String rUrl = getMeleteCHService().getResourceUrl(cr.getId());
					boolean rType = cr.getContentType().equals(MeleteCHService.MIME_TYPE_LINK);
					boolean rTypeLTI = cr.getContentType().equals(MeleteCHService.MIME_TYPE_LTI);
					String rgif = serverUrl + "/library/image/sakai/url.gif";
					if (!rType && !rTypeLTI)
					{
						String contentextension = cr.getContentType();
						rgif = ContentTypeImageService.getContentTypeImage(contentextension);
						// logger.debug("image provided for" + displayName +" is " +rgif);
						if (rgif.startsWith("sakai"))
							rgif = rgif.replace("sakai", (serverUrl + "/library/image/sakai"));
						else if (rgif.startsWith("/sakai")) rgif = rgif.replace("/sakai", (serverUrl + "/library/image/sakai"));
					}
					else if (rTypeLTI)
					{
						rgif = "images/web_service.png";
					}
					currSiteResourcesList.add(new DisplaySecResources(displayName, cr.getId(), rUrl, rType, rgif, rTypeLTI));
				}
				java.util.Collections.sort(currSiteResourcesList);
				getListNav().setTotalSize(currSiteResourcesList.size() + 1);
				getListNav().resetCurrIndex();
			}
		}
		catch (Exception e)
		{
			logger.warn("error in creating list for server residing files" + e.toString());
		}
		return currSiteResourcesList;
	}

	/**
	 * Responsible for displaying listing in chunks
	 * 
	 * @return resource list in chunks
	 */
	public List<DisplaySecResources> getDisplayResourcesList()
	{
		try
		{
			if (currSiteResourcesList == null) getCurrSiteResourcesList();
			if (currSiteResourcesList != null)
			{
				int fromIndex = getListNav().getCurrIndex();
				int toIndex = getListNav().getEndIndex();

				logger.debug("from and to index and total size" + fromIndex + "," + toIndex + "," + currSiteResourcesList.size());
				displayResourcesList = null;
				if (fromIndex >= 0 && toIndex > fromIndex && fromIndex <= currSiteResourcesList.size() && toIndex <= currSiteResourcesList.size())
				{
					displayResourcesList = (List<DisplaySecResources>) currSiteResourcesList.subList(fromIndex, toIndex);
					logger.debug("displayResourcesList" + displayResourcesList.size());
				}
			}
		}
		catch (Exception e)
		{
			logger.warn("error in creating displayList for server residing files" + e.toString());
		}
		return displayResourcesList;
	}

	/**
	 * @return page that the user is on(such as manage_content or section listing pages)
	 */
	public String getFromPage()
	{
		return fromPage;
	}

	/**
	 * @return Returns the listNav(30 resources on a page).
	 */
	public RemoteFilesListingNav getListNav()
	{
		if (listNav == null)
		{
			listNav = new RemoteFilesListingNav(0, 0, 30);
		}

		return listNav;
	}

	/**
	 * @return Returns the meleteCHService.
	 */
	public MeleteCHService getMeleteCHService()
	{
		return meleteCHService;
	}

	/**
	 * @return resource name that is selected
	 */
	public String getSecResourceName()
	{
		return secResourceName;
	}

	/**
	 * @return Returns the selResourceIdFromList.
	 */
	public String getSelResourceIdFromList()
	{
		return selResourceIdFromList;
	}

	/**
	 * @return value of sort flag
	 */
	public boolean getSortAscFlag()
	{
		return this.sortAscFlag;
	}

	/**
	 * @return false if fromPage is manage_content, true otherwise
	 */
	public boolean isCallFromSection()
	{
		if (this.fromPage != null)
		{
			if (this.fromPage.equals("manage_content"))
			{
				callFromSection = false;
			}
			else
			{
				callFromSection = true;
			}
		}
		else
		{
			callFromSection = true;
		}
		return callFromSection;
	}

	/**
	 * @return value of renderSelectedResource
	 */
	public boolean isRenderSelectedResource()
	{
		return renderSelectedResource;
	}

	/**
	 * @return value that determines if link resources are rendered
	 */
	public boolean isShouldRenderLink()
	{
		return shouldRenderLink;
	}

	/**
	 * @return value that determines if lti resources are rendered
	 */
	public boolean isShouldRenderLTI()
	{
		return shouldRenderLTI;
	}

	/**
	 * @return value that determines if lti resources are rendered
	 */
	public boolean isShouldRenderUpload()
	{
		return shouldRenderUpload;
	}

	/**
	 * @return delete_resource page
	 */
	public String redirectDeleteLink()
	{
		return "delete_resource";
	}

	/**
	 * Redirects user to page they came from
	 * 
	 * @return value of page they came from(list_resources or section listing pages)
	 */
	public String redirectLink()
	{
		return this.fromPage;
	}

	/**
	 * Refresh the list.
	 */
	public void refreshCurrSiteResourcesList()
	{
		currSiteResourcesList = null;
		getCurrSiteResourcesList();
		return;
	}

	/**
	 * Method that executes when a resource is clicked on values of selected resource are set
	 * 
	 * @param evt
	 *        ActionEvent object
	 */
	public void selectedResourceAction(ActionEvent evt)
	{
		FacesContext ctx = FacesContext.getCurrentInstance();
		UICommand cmdLink = (UICommand) evt.getComponent();

		// List<UIComponent> cList = cmdLink.getChildren();
		// UIComponent comp = (UIComponent) cList.get(0);
		// Mallika - Needed to add the if condition below since param tags aren't being
		// rendered if file size is too large

		/*
		 * if (!(comp instanceof UIOutput)) { UIParameter param = (UIParameter) comp; this.selResourceIdFromList = (String) param.getValue(); } else {
		 */
		String selclientId = cmdLink.getClientId(ctx);
		selclientId = selclientId.substring(selclientId.indexOf(':') + 1);
		selclientId = selclientId.substring(selclientId.indexOf(':') + 1);
		selclientId = selclientId.substring(selclientId.indexOf(':') + 1);
		String resId = selclientId.substring(0, selclientId.indexOf(':'));
		int selResIndex = Integer.parseInt(resId);
		selResIndex = selResIndex + getListNav().getCurrIndex();
		this.selResourceIdFromList = ((DisplaySecResources) currSiteResourcesList.get(selResIndex)).getResource_id();
		this.secResourceName = ((DisplaySecResources) currSiteResourcesList.get(selResIndex)).getResource_title();
		// }
		this.renderSelectedResource = true;
		if (logger.isDebugEnabled()) logger.debug("selected resource id by user is " + this.selResourceIdFromList);

		// populate properties panel with the selected resource
		/*
		 * try{ ContentResource cr= getMeleteCHService().getResource(selResourceIdFromList); this.secResourceName = cr.getProperties().getProperty(ResourceProperties.PROP_DISPLAY_NAME); this.secResourceDescription =
		 * cr.getProperties().getProperty(ResourceProperties.PROP_DESCRIPTION); if(cr.getContentLength() > 0) currLinkUrl = new String(cr.getContent()); //get resource object MeleteResource existResource =
		 * (MeleteResource)sectionService.getMeleteResource(selResourceIdFromList); //just take resource properties from this object as its assoc with another section if(existResource != null) { meleteResource = existResource; ValueBinding binding =
		 * Util.getBinding("#{licensePage}");
		 * 
		 * LicensePage lPage = (LicensePage)binding.getValue(ctx); lPage.setInitialValues(formName, existResource);
		 * 
		 * // render selected file name selectedResourceName = secResourceName; renderSelectedResource = true; if (logger.isDebugEnabled()) logger.debug("values changed in resource action for res name and desc" + secResourceName + secResourceDescription);
		 * } ctx.renderResponse(); }
		 * 
		 * catch(Exception ex) { logger.debug("error while accessing content resource" + ex.toString()); }
		 */
		ctx.renderResponse();
		return;
	}

	/**
	 * Sets delete resource page with selected resource values
	 * 
	 * @param evt
	 *        ActionEvent object
	 */
	public void selectedResourceDeleteAction(ActionEvent evt)
	{
		FacesContext ctx = FacesContext.getCurrentInstance();
		ValueBinding binding = Util.getBinding("#{meleteSiteAndUserInfo}");
		MeleteSiteAndUserInfo mPage = (MeleteSiteAndUserInfo) binding.getValue(ctx);

		String courseId = mPage.getCurrentSiteId();
		// UIViewRoot root = ctx.getViewRoot();
		/*
		 * UIData table = (UIData) root.findComponent("ServerViewForm:ResourceListingForm").findComponent("table"); DisplaySecResources selectedDr = (DisplaySecResources) table.getRowData();
		 * 
		 * logger.debug("selected row to delete " + selectedDr.getResource_id());
		 */
		UICommand cmdLink = (UICommand) evt.getComponent();

		List<?> cList = cmdLink.getChildren();
		if (cList == null || cList.size() < 2) return;
		UIParameter param1 = (UIParameter) cList.get(0);
		UIParameter param2 = (UIParameter) cList.get(1);

		binding = Util.getBinding("#{deleteResourcePage}");
		DeleteResourcePage delResPage = (DeleteResourcePage) binding.getValue(ctx);
		delResPage.resetValues();
		delResPage.setFromPage(this.fromPage);
		/*
		 * if(this.formName.equals("UploadServerViewForm")) delResPage.setFromPage("ContentUploadServerView"); if(this.formName.equals("EditUploadServerViewForm")) delResPage.setFromPage("editContentUploadServerView");
		 * if(this.formName.equals("ServerViewForm")) delResPage.setFromPage("ContentLinkServerView"); if(this.formName.equals("EditServerViewForm")) delResPage.setFromPage("editContentLinkServerView"); if(this.formName.equals("LtiServerViewForm"))
		 * delResPage.setFromPage("ContentLTIServerView"); if(this.formName.equals("EditLtiServerViewForm")) delResPage.setFromPage("editContentLTIServerView");
		 */

		/*
		 * delResPage.setResourceName(selectedDr.getResource_title()); delResPage.processDeletion(selectedDr.getResource_id(), courseId);
		 */

		delResPage.setResourceName((String) param2.getValue());
		delResPage.processDeletion((String) param1.getValue(), courseId);
		return;
	}

	/**
	 * @param callFromSection
	 *        The callFromSection to set.
	 */
	public void setCallFromSection(boolean callFromSection)
	{
		this.callFromSection = callFromSection;
	}

	/**
	 * @param fromPage
	 *        value of page that user is on
	 */
	public void setFromPage(String fromPage)
	{
		this.fromPage = fromPage;
	}

	/**
	 * @param listNav
	 *        The listNav to set.
	 */
	public void setListNav(RemoteFilesListingNav listNav)
	{
		this.listNav = listNav;
	}

	/**
	 * @param meleteCHService
	 *        meleteChService to set
	 */
	public void setMeleteCHService(MeleteCHService meleteCHService)
	{
		this.meleteCHService = meleteCHService;
	}

	/**
	 * @param renderSelectedResource
	 *        boolean value that determines if selected resource is rendered
	 */
	public void setRenderSelectedResource(boolean renderSelectedResource)
	{
		this.renderSelectedResource = renderSelectedResource;
	}

	/**
	 * @param secResourceName
	 *        resource name to select
	 */
	public void setSecResourceName(String secResourceName)
	{
		this.secResourceName = secResourceName;
	}

	/**
	 * @param selResourceIdFromList
	 *        string value to set
	 */
	public void setSelResourceIdFromList(String selResourceIdFromList)
	{
		this.selResourceIdFromList = selResourceIdFromList;
	}

	/**
	 * @param serverConfigurationService
	 *        The ServerConfigurationService to set.
	 */
	public void setServerConfigurationService(ServerConfigurationService serverConfigurationService)
	{
		this.serverConfigurationService = serverConfigurationService;
	}

	/**
	 * @param shouldRenderLink
	 *        value that determines if link resources are rendered
	 */
	public void setShouldRenderLink(boolean shouldRenderLink)
	{
		this.shouldRenderLink = shouldRenderLink;
	}

	/**
	 * @param shouldRenderLTI
	 *        value that determines if lti resources are rendered
	 */
	public void setShouldRenderLTI(boolean shouldRenderLTI)
	{
		this.shouldRenderLTI = shouldRenderLTI;
	}

	/**
	 * @param shouldRenderUpload
	 *        value that determines if upload resources are rendered
	 */
	public void setShouldRenderUpload(boolean shouldRenderUpload)
	{
		this.shouldRenderUpload = shouldRenderUpload;
	}

	/**
	 * @param sortAscFlag
	 *        value of sort flag
	 */
	public void setSortAscFlag(boolean sortAscFlag)
	{
		this.sortAscFlag = sortAscFlag;
	}

	/**
	 * Reset flag and index and sort list
	 * 
	 * @return the list resources page
	 */
	public String sortResourcesAsc()
	{
		sortAscFlag = false;
		listNav.resetCurrIndex();
		sortList();
		return "#";
	}

	/**
	 * Reset flag and index and sort list
	 * 
	 * @return the list resources page
	 */
	public String sortResourcesDesc()
	{
		sortAscFlag = true;
		listNav.resetCurrIndex();
		sortList();
		return "#";
	}

	/**
	 * Sort resources list depending on value of sortAscFlag
	 * 
	 */
	private void sortList()
	{
		if (sortAscFlag)
			java.util.Collections.sort(currSiteResourcesList);
		else
			Collections.sort(currSiteResourcesList, SectionResourcesComparatorDesc);
	}

	/**
	 * Reset all values of page
	 * 
	 */
	void resetValues()
	{
		setRenderSelectedResource(false);
		setSelResourceIdFromList(null);
		setSecResourceName(null);
		setSortAscFlag(true);
		setListNav(null);
		refreshCurrSiteResourcesList();
	}

}
