/**********************************************************************************
 *
 * $URL$
 * $Id$
 ***********************************************************************************
 *
 * Copyright (c) 2008,2009,2010,2011 Etudes, Inc.
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
package org.etudes.component.app.melete;

import java.io.Serializable;
import java.util.Date;
import java.util.Calendar;

import org.apache.commons.lang.builder.ToStringBuilder;
import org.sakaiproject.component.cover.ComponentManager;
import org.sakaiproject.tool.cover.SessionManager;
import org.etudes.api.app.melete.*;
import org.etudes.util.api.AccessAdvisor;

/** @author Hibernate CodeGenerator */
public class ModuleShdates implements Serializable,ModuleShdatesService {

    /** identifier field */
    private Integer moduleId;

    /** nullable persistent field */
    private Date startDate;

    /** nullable persistent field */
    private Date endDate;

    /** nullable persistent field */
    private int version;

    /** nullable persistent field */
    private Boolean addtoSchedule;

    /** nullable persistent field */
    private String startEventId;

    /** nullable persistent field */
    private String endEventId;

    /** identifier field */
    private org.etudes.component.app.melete.Module module;

    private boolean visibleFlag;
    
    private boolean valid;
    
    /** Dependency (optional, self-injected): AccessAdvisor. */
	protected transient AccessAdvisor accessAdvisor = null;    

    /** full constructor */
    public ModuleShdates(Date startDate, Date endDate, int version, Boolean addtoSchedule, String startEventId, String endEventId, org.etudes.component.app.melete.Module module) {
        this.startDate = startDate;
        this.endDate = endDate;
        this.version = version;
        this.addtoSchedule = addtoSchedule;
        this.startEventId = startEventId;
        this.endEventId = endEventId;
        this.module = module;
    }

    /** Custom constructor */
    public ModuleShdates(Date startDate, Date endDate, Boolean addtoSchedule) {
        this.startDate = startDate;
        this.endDate = endDate;
        this.addtoSchedule = addtoSchedule;
    }

    /** default constructor */
    public ModuleShdates() {
    }

    /** copy constructor */
    public ModuleShdates(ModuleShdates oldModuleShdates)
    {
        this.startDate = oldModuleShdates.getStartDate();
        this.endDate = oldModuleShdates.getEndDate();
        this.module = null;
    }


    public Integer getModuleId() {
        return this.moduleId;
    }

    public void setModuleId(Integer moduleId) {
        this.moduleId = moduleId;
    }


    public Date getStartDate() {
        return this.startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return this.endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public int getVersion() {
        return this.version;
    }

    public void setVersion(int version) {
        this.version = version;
    }



	public void setAddtoSchedule(Boolean addtoSchedule)
	{
		this.addtoSchedule = addtoSchedule;
	}

	public  Boolean getAddtoSchedule()
	{
		return this.addtoSchedule;
	}

	public String getStartEventId()
	{
		return this.startEventId;
	}

	public void setStartEventId(String startEventId)
	{
		this.startEventId = startEventId;
	}

	public String getEndEventId()
	{
		return this.endEventId;
	}

	public void setEndEventId(String endEventId)
	{
		this.endEventId = endEventId;
	}


    public org.etudes.api.app.melete.ModuleObjService getModule() {
        return this.module;
    }

    public void setModule(org.etudes.api.app.melete.ModuleObjService module) {
        this.module = (Module) module;
    }

    public boolean isVisibleFlag()
    {
    	java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(Calendar.getInstance().getTimeInMillis());
    	// check if there is an access advisor - if not, that's ok.

    	if (((getStartDate() == null)||(getStartDate().before(currentTimestamp)))&&((getEndDate() == null)||(getEndDate().after(currentTimestamp))))
    	{
    		this.accessAdvisor = (AccessAdvisor) ComponentManager.get(AccessAdvisor.class);
    		if ((this.accessAdvisor != null)&&(this.accessAdvisor.denyAccess("sakai.melete", getModule().getCoursemodule().getCourseId(), String.valueOf(getModuleId()), SessionManager.getCurrentSessionUserId())))
    		{	
    			return false;
    		}
    		else
    		{
    			return true;
    		}
    	}
    	else
    	{
    		return false;
    	}
    }	

    public boolean isValid()
    {
    	Calendar stCal = null;
		Calendar enCal = null;
    	if (getStartDate() != null)
		{
			stCal = Calendar.getInstance();
			stCal.setTime(getStartDate());
			if (stCal.get(Calendar.YEAR) > 9999)
			{
			  return false;
			}
		}
		if (getEndDate() != null)
		{
			enCal = Calendar.getInstance();
			enCal.setTime(getEndDate());
			if (enCal.get(Calendar.YEAR) > 9999)
			{
			  return false;
			}
		}
		if ((getStartDate() != null)&&(getEndDate() != null))
		{
		  if (getStartDate().compareTo(getEndDate()) >= 0)
		  {
			return false;
		  }
	     }
		return true;
    }
    
    public String toString() {
        return new ToStringBuilder(this)
            .append("moduleId", getModuleId())
            .toString();
    }

}
