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
import java.util.Calendar;
import java.util.Date;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.etudes.api.app.melete.ModuleShdatesService;
import org.etudes.util.api.AccessAdvisor;
import org.sakaiproject.component.cover.ComponentManager;
import org.sakaiproject.tool.cover.SessionManager;

public class ModuleShdates implements Serializable, ModuleShdatesService
{
	/** nullable persistent field */
	private Boolean addtoSchedule;

	/** nullable persistent field */
	private Date endDate;

	/** nullable persistent field */
	private String endEventId;

	/** identifier field */
	private org.etudes.component.app.melete.Module module;

	/** identifier field */
	private Integer moduleId;

	/** nullable persistent field */
	private Date startDate;

	/** nullable persistent field */
	private String startEventId;

	private boolean valid;

	/** nullable persistent field */
	private int version;

	private boolean visibleFlag;

	/** Dependency (optional, self-injected): AccessAdvisor. */
	protected transient AccessAdvisor accessAdvisor = null;

	/** default constructor */
	public ModuleShdates()
	{
	}

	/** Custom constructor */
	public ModuleShdates(Date startDate, Date endDate, Boolean addtoSchedule)
	{
		this.startDate = startDate;
		this.endDate = endDate;
		this.addtoSchedule = addtoSchedule;
	}

	/** full constructor */
	public ModuleShdates(Date startDate, Date endDate, int version, Boolean addtoSchedule, String startEventId, String endEventId,
			org.etudes.component.app.melete.Module module)
	{
		this.startDate = startDate;
		this.endDate = endDate;
		this.version = version;
		this.addtoSchedule = addtoSchedule;
		this.startEventId = startEventId;
		this.endEventId = endEventId;
		this.module = module;
	}

	/** copy constructor */
	public ModuleShdates(ModuleShdates oldModuleShdates)
	{
		this.startDate = oldModuleShdates.getStartDate();
		this.endDate = oldModuleShdates.getEndDate();
		this.module = null;
	}

	@Override
	public boolean equals(Object obj)
	{
		if (this == obj) return true;
		if (obj == null) return false;
		if (getClass() != obj.getClass()) return false;
		ModuleShdates other = (ModuleShdates) obj;
		if (addtoSchedule == null)
		{
			if (other.addtoSchedule != null) return false;
		}
		else if (!addtoSchedule.equals(other.addtoSchedule)) return false;
		if (endDate == null && other.endDate != null) return false;
		else if (endDate != null && other.endDate == null) return false;
		else if (endDate != null && other.endDate != null)
		{
			endDate = (Date) endDate;
			other.endDate = (Date) other.endDate;
			if (endDate.compareTo(other.endDate) != 0) return false;	
		}
			
		if (moduleId == null)
		{
			if (other.moduleId != null) return false;
		}
		else if (!moduleId.equals(other.moduleId)) return false;
		if (startDate == null && other.startDate != null) return false;
		else if (startDate != null && other.startDate == null) return false;
		else if (startDate != null && other.startDate != null)
		{
			startDate = (Date) startDate;
			other.startDate = (Date) other.startDate;
			try
			{
			if (startDate.compareTo(other.startDate) != 0) return false;
			}
			catch (Exception e)
			{
				e.printStackTrace();
			}
		}
		
		return true;
	}

	/**
	 * {@inheritDoc}
	 */
	public Boolean getAddtoSchedule()
	{
		return this.addtoSchedule;
	}

	/**
	 * {@inheritDoc}
	 */
	public Date getEndDate()
	{
		return this.endDate;
	}

	/**
	 * {@inheritDoc}
	 */
	public String getEndEventId()
	{
		return this.endEventId;
	}

	/**
	 * {@inheritDoc}
	 */
	public org.etudes.api.app.melete.ModuleObjService getModule()
	{
		return this.module;
	}

	/**
	 * {@inheritDoc}
	 */
	public Integer getModuleId()
	{
		return this.moduleId;
	}

	/**
	 * {@inheritDoc}
	 */
	public Date getStartDate()
	{
		return this.startDate;
	}

	/**
	 * {@inheritDoc}
	 */
	public String getStartEventId()
	{
		return this.startEventId;
	}

	/**
	 * {@inheritDoc}
	 */
	public int getVersion()
	{
		return this.version;
	}

	@Override
	public int hashCode()
	{
		final int prime = 31;
		int result = 1;
		result = prime * result + ((addtoSchedule == null) ? 0 : addtoSchedule.hashCode());
		result = prime * result + ((endDate == null) ? 0 : endDate.hashCode());
		result = prime * result + ((moduleId == null) ? 0 : moduleId.hashCode());
		result = prime * result + ((startDate == null) ? 0 : startDate.hashCode());
		return result;
	}

	/**
	 * {@inheritDoc}
	 */
	public boolean isDateFlag()
	{
		if (isStartDateValid() && isEndDateValid())
		{	
		  if ((getStartDate() != null) && (getEndDate() != null))
		  {
			if (getStartDate().compareTo(getEndDate()) >= 0)
			{
				return true;
			}
		  }
		}
		return false;
	}
	
	/**
	 * {@inheritDoc}
	 */
	public boolean isStartDateValid()
	{
		Calendar stCal = null;
		if (getStartDate() != null)
		{
			stCal = Calendar.getInstance();
			stCal.setTime(getStartDate());
			if (stCal.get(Calendar.YEAR) > 9999)
			{
				return false;
			}
		}
		return true;
	}
	
	/**
	 * {@inheritDoc}
	 */
	public boolean isEndDateValid()
	{
		Calendar enCal = null;
		if (getEndDate() != null)
		{
			enCal = Calendar.getInstance();
			enCal.setTime(getEndDate());
			if (enCal.get(Calendar.YEAR) > 9999)
			{
				return false;
			}
		}
		return true;
	}	

	/**
	 * {@inheritDoc}
	 */
	public boolean isVisibleFlag()
	{
		java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(Calendar.getInstance().getTimeInMillis());
		// check if there is an access advisor - if not, that's ok.

		if (((getStartDate() == null) || (getStartDate().before(currentTimestamp)))
				&& ((getEndDate() == null) || (getEndDate().after(currentTimestamp))))
		{
			this.accessAdvisor = (AccessAdvisor) ComponentManager.get(AccessAdvisor.class);
			if ((this.accessAdvisor != null)
					&& (this.accessAdvisor.denyAccess("sakai.melete", getModule().getCoursemodule().getCourseId(), String.valueOf(getModuleId()),
							SessionManager.getCurrentSessionUserId())))
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

	/**
	 * {@inheritDoc}
	 */
	public void setAddtoSchedule(Boolean addtoSchedule)
	{
		this.addtoSchedule = addtoSchedule;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setEndDate(Date endDate)
	{
		this.endDate = endDate;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setEndEventId(String endEventId)
	{
		this.endEventId = endEventId;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setModule(org.etudes.api.app.melete.ModuleObjService module)
	{
		this.module = (Module) module;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setModuleId(Integer moduleId)
	{
		this.moduleId = moduleId;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setStartDate(Date startDate)
	{
		this.startDate = startDate;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setStartEventId(String startEventId)
	{
		this.startEventId = startEventId;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setVersion(int version)
	{
		this.version = version;
	}

	/**
	 * {@inheritDoc}
	 */
	public String toString()
	{
		return new ToStringBuilder(this).append("moduleId", getModuleId()).toString();
	}

}
