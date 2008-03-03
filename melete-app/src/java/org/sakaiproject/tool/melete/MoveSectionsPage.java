/**********************************************************************************
 *
 * $Header: /usr/src/sakai/melete-2.4/melete-app/src/java/org/sakaiproject/tool/melete/MoveSectionsPage.java,v 1.5 2007/11/07 00:54:16 rashmim Exp $
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

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.sakaiproject.api.app.melete.*;
import org.sakaiproject.util.ResourceLoader;

import javax.faces.application.Application;
import javax.faces.application.FacesMessage;
import javax.faces.model.SelectItem;
import javax.faces.component.html.*;
import javax.faces.component.*;

import java.util.ArrayList;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.io.*;

import javax.faces.context.FacesContext;
import javax.faces.el.ValueBinding;
import javax.faces.event.AbortProcessingException;
import javax.faces.event.ValueChangeEvent;

import org.sakaiproject.component.app.melete.*;
import org.sakaiproject.api.app.melete.ModuleObjService;
import org.sakaiproject.api.app.melete.ModuleService;
import org.sakaiproject.api.app.melete.SectionService;

public class MoveSectionsPage implements Serializable
{

	/** identifier field */

	private ModuleObjService selectedModule;

	private ModuleService moduleService;

	private List<SectionBean> sectionBeans;
	
	private List<ModuleDateBean> moduleDateBeans;	
	
	private ArrayList<SelectItem> availableModules;
	
	private boolean nomodsFlag;
	
	private String courseId;
	
	private String userId;
	
	private String selectId ;
	
	
	/** Dependency:  The logging service. */
	protected Log logger = LogFactory.getLog(MoveSectionsPage.class);

	public MoveSectionsPage()
	{

	}

	public String move()
	{
		logger.debug("move called");
		FacesContext ctx = FacesContext.getCurrentInstance();
		ResourceLoader bundle = new ResourceLoader("org.sakaiproject.tool.melete.bundle.Messages");
		try{
			if(selectId != null) selectedModule = moduleService.getModule(new Integer(selectId).intValue());
			
			if(selectedModule == null)
			{
				String msg = bundle.getString("select_one_move_section");
				ctx.addMessage (null, new FacesMessage(FacesMessage.SEVERITY_ERROR,"select_one_move_section",msg));
				return "move_section";
			}
		moduleService.moveSections(sectionBeans, selectedModule);	
		}catch(Exception e)
		{			
			String msg = bundle.getString("move_section_fail");
			ctx.addMessage (null, new FacesMessage(FacesMessage.SEVERITY_ERROR,"move_section_fail",msg));		
		}
		
		return "list_auth_modules";
	}
	
	public String cancel()
	{
		return "list_auth_modules";
	}
	
	public List<SelectItem> getAvailableModules()
	{
		FacesContext context = FacesContext.getCurrentInstance();
		ResourceLoader bundle = new ResourceLoader("org.sakaiproject.tool.melete.bundle.Messages");
		
		try
		{
			if(availableModules == null)
			{
				availableModules = new ArrayList<SelectItem>(0);
				ModuleService moduleService = getModuleService();			
				moduleDateBeans = moduleService.getModuleDateBeans(getUserId(), getCourseId());			
				if(moduleDateBeans == null || moduleDateBeans.size() == 0)
				{
					nomodsFlag = true;
					return availableModules;
				}
				nomodsFlag = false;
				for(ModuleDateBean md:moduleDateBeans)
				{
					availableModules.add(new SelectItem(new Integer(md.getModuleId()).toString(),md.getModule().getTitle()));
				}
				selectId = new Integer(moduleDateBeans.get(0).getModuleId()).toString();
			}
		}catch(Exception ex)
		{
			String msg = bundle.getString("move_section_fail");
			context.addMessage (null, new FacesMessage(FacesMessage.SEVERITY_ERROR,"move_section_fail",msg));		
		}
		return availableModules;
}
	
	public void resetValues()
	{
		moduleDateBeans = null;	
		availableModules = null;
		selectedModule = null;
		sectionBeans = null;
		selectId = null;
	}
	
	/**
	 * @param logger The logger to set.
	 */
	public void setLogger(Log logger)
	{
		this.logger = logger;
	}

	/**
	 * @param sectionBeans the sectionBeans to set
	 */
	public void setSectionBeans(List<SectionBean> sectionBeans)
	{
		this.sectionBeans = sectionBeans;
	}

	/**
	 * @return Returns the ModuleService.
	 */
	public ModuleService getModuleService()
	{
		return moduleService;
	}

	/**
	 * @param moduleService The moduleService to set.
	 */
	public void setModuleService(ModuleService moduleService)
	{
		this.moduleService = moduleService;
	}

	/**
	 * @return the nomodsFlag
	 */
	public boolean isNomodsFlag()
	{
		return this.nomodsFlag;
	}
	
	private String getCourseId()
	{
		if (courseId == null)
		{
		FacesContext context = FacesContext.getCurrentInstance();
	  	Map sessionMap = context.getExternalContext().getSessionMap();
		courseId = (String)sessionMap.get("courseId");
		}
		return courseId;
	}
	private String getUserId()
	{
		if (userId == null)
		{
		FacesContext context = FacesContext.getCurrentInstance();
	  	Map sessionMap = context.getExternalContext().getSessionMap();
		userId = (String)sessionMap.get("userId");
		}
		return userId;
	}	

	/**
	 * @return the selectId
	 */
	public String getSelectId()
	{
		return this.selectId;
	}

	/**
	 * @param selectId the selectId to set
	 */
	public void setSelectId(String selectId)
	{
		this.selectId = selectId;	
	}
}
