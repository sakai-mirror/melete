/**********************************************************************************
 *
 * $URL$
 * $Id$  
 ***********************************************************************************
 *
 * Copyright (c) 2008, 2011 Etudes, Inc.
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

import java.util.Date;

public interface ModuleShdatesService
{

	/**
	 * Method to compare moduleshdatesservice objects
	 * 
	 * @param other
	 * @return true if equal, false if not
	 */
	public abstract boolean equals(Object other);

	/**
	 * @return add to schedule boolean flag
	 */
	public abstract Boolean getAddtoSchedule();

	/**
	 * @return end date
	 */
	public abstract Date getEndDate();

	/**
	 * @return end event id
	 */
	public abstract String getEndEventId();

	/**
	 * @return module
	 */
	public abstract org.etudes.api.app.melete.ModuleObjService getModule();

	/**
	 * @return start date
	 */
	public abstract Date getStartDate();

	/**
	 * @return start event id string
	 */
	public abstract String getStartEventId();

	/**
	 * @return version
	 */
	public abstract int getVersion();

	/**
	 * Method to compare objects using hashCode
	 * 
	 * @return int value of hashCode
	 */
	public abstract int hashCode();

	/**
	 * @return valid flag
	 */
	public boolean isValid();

	/**
	 * @return visibleFlag value of visible flag
	 */
	public boolean isVisibleFlag();

	/**
	 * @param addtoSchedule
	 *        add to schedule boolean flag
	 */
	public abstract void setAddtoSchedule(Boolean addtoSchedule);

	/**
	 * @param endDate
	 *        end date
	 */
	public abstract void setEndDate(Date endDate);

	/**
	 * @param endEventId
	 *        end event id
	 */
	public abstract void setEndEventId(String endEventId);

	/**
	 * @param module
	 *        module object
	 */
	public abstract void setModule(org.etudes.api.app.melete.ModuleObjService module);

	/**
	 * @param startDate
	 *        the start date
	 */
	public abstract void setStartDate(Date startDate);

	/**
	 * @param startEventId
	 *        the start event id
	 */
	public abstract void setStartEventId(String startEventId);

	/**
	 * @param version
	 *        the version
	 */
	public abstract void setVersion(int version);

	/**
	 * @return string value of moduleshdatesservice
	 */
	public abstract String toString();
}
