/**********************************************************************************
 *
 * $URL$
 * $Id$
 ***********************************************************************************
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

import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.faces.el.ValueBinding;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.etudes.api.app.melete.ModuleObjService;
import org.etudes.api.app.melete.ModuleService;
import org.sakaiproject.util.ResourceLoader;

public class PrintModulePage
{

	/** identifier field */

	private ModuleService moduleService;

	private String printText;

	/** Dependency: The logging service. */
	protected Log logger = LogFactory.getLog(PrintModulePage.class);

	/**
	 * constructor
	 */
	public PrintModulePage()
	{

	}

	/**
	 * Fetch all module and its section content to show in print window.
	 * 
	 * @param moduleId
	 *        The module Id
	 */
	public void processModule(Integer moduleId)
	{
		FacesContext context = FacesContext.getCurrentInstance();
		ValueBinding binding = Util.getBinding("#{meleteSiteAndUserInfo}");
		MeleteSiteAndUserInfo mPage = (MeleteSiteAndUserInfo) binding.getValue(context);
		
		// logger.debug("print process called");
		printText = null;
		FacesContext ctx = FacesContext.getCurrentInstance();
		ResourceLoader bundle = new ResourceLoader("org.etudes.tool.melete.bundle.Messages");
		try
		{
			ModuleObjService printMod = moduleService.getModule(moduleId.intValue());
			printText = moduleService.printModule(printMod, mPage.getCurrentUser().getId());
		}
		catch (Exception e)
		{
			String msg = bundle.getString("print_module_fail");
			printText = msg;
			ctx.addMessage(null, new FacesMessage(FacesMessage.SEVERITY_ERROR, "print_module_fail", msg));
		}
	}

	/**
	 * Reset values.
	 */
	public void resetValues()
	{
		printText = null;
	}

	/**
	 * @return Returns the ModuleService.
	 */
	public ModuleService getModuleService()
	{
		return moduleService;
	}

	/**
	 * @param moduleService
	 *        The moduleService to set.
	 */
	public void setModuleService(ModuleService moduleService)
	{
		this.moduleService = moduleService;
	}

	/**
	 * @return the printText
	 */
	public String getPrintText()
	{
		return this.printText;
	}
}
