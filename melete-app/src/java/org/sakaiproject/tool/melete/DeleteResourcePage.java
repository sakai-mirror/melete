/**********************************************************************************
*
* $Header: /usr/src/sakai/melete-2.4/melete-app/src/java/org/sakaiproject/tool/melete/DeleteResourcePage.java,v 1.10 2007/06/27 16:28:53 rashmim Exp $
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
package org.sakaiproject.tool.melete;

import java.io.Serializable;

import org.sakaiproject.util.ResourceLoader;
import java.util.List;

import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.faces.el.ValueBinding;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.sakaiproject.api.app.melete.MeleteCHService;
import org.sakaiproject.api.app.melete.SectionService;
import org.sakaiproject.api.app.melete.exception.MeleteException;
import org.sakaiproject.util.ResourceLoader;
/**
 * @author Rashmi
 *
 */

public class DeleteResourcePage implements Serializable{

	 /** Dependency:  The logging service. */
	protected Log logger = LogFactory.getLog(DeleteModulePage.class);
	private SectionService sectionService;
	private MeleteCHService meleteCHService;
	
	private String fromPage;
	private boolean warningFlag;
	private String delResourceName;
	private String delResourceId;
	private String courseId;
	
    public DeleteResourcePage(){
    }

  	public void resetValues()
  	{
  		warningFlag = false;
  		fromPage = "";
  		delResourceId = null;
  		delResourceName = null;
  		courseId = null;
  	}
	
  	public void setFromPage(String fromPage)
  	{
  		this.fromPage = fromPage;
  	}
  	
  	public void processDeletion(String delResourceId, String courseId)
  	{
  		this.delResourceId = delResourceId;
  		this.courseId = courseId;
  		List<String> res_in_use = sectionService.findResourceInUse(delResourceId,courseId);
		if(res_in_use != null)	logger.debug("res_in_use size " + res_in_use.size());
		if (res_in_use != null && res_in_use.size() > 0)
			warningFlag = true;		
  	}
  	
  	public void setResourceName(String title)
  	{
  		delResourceName = title;
  	}
  	
  	public String deleteResource()
  	{
  		FacesContext context = FacesContext.getCurrentInstance();
		try
		{
			// delete from content resource
			meleteCHService.removeResource(this.delResourceId);
			sectionService.deleteResourceInUse(this.delResourceId, this.courseId);
			if (fromPage.startsWith("edit"))
			{
				ValueBinding binding = Util.getBinding("#{editSectionPage}");
				EditSectionPage editPage = (EditSectionPage) binding.getValue(context);
				logger.debug("calling refresh of list ");
				editPage.refreshCurrSiteResourcesList();
			}
			else
			{
				ValueBinding binding = Util.getBinding("#{addSectionPage}");
				AddSectionPage addPage = (AddSectionPage) binding.getValue(context);
				addPage.refreshCurrSiteResourcesList();
			}		
			return fromPage;
		}
		catch (Exception e)
		{
			logger.error("error in delete resource" + e.toString());
			ResourceLoader bundle = new ResourceLoader("org.sakaiproject.tool.melete.bundle.Messages");
			String errMsg = bundle.getString(e.getMessage());
			context.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, e.getMessage(), errMsg));
			return "#";
		}
	}
  	
  	public String cancelDeleteResource()
  	{
  		return fromPage;
  	}
  	
	/**
	 * @return Returns the SectionService.
	 */
	public SectionService getSectionService() {
		return sectionService;
	}
	/**
	 * @param SectionService The SectionService to set.
	 */
	public void setSectionService(SectionService sectionService) {
		this.sectionService = sectionService;
	}
	/**
	 * @param meleteCHService the meleteCHService to set
	 */
	public void setMeleteCHService(MeleteCHService meleteCHService)
	{
		this.meleteCHService = meleteCHService;
	}

	public void setLogger(Log logger) {
		this.logger = logger;
	}

	/**
	 * @return the warningFlag
	 */
	public boolean isWarningFlag()
	{
		return this.warningFlag;
	}

	/**
	 * @param warningFlag the warningFlag to set
	 */
	public void setWarningFlag(boolean warningFlag)
	{
		this.warningFlag = warningFlag;
	}

	/**
	 * @return the delResourceName
	 */
	public String getDelResourceName()
	{
		return this.delResourceName;
	}
	
 }
