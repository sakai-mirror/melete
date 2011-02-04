/**********************************************************************************
 *
 * $URL: https://source.sakaiproject.org/contrib/etudes/melete/trunk/melete-api/src/java/org/etudes/api/app/melete/BookmarkObjService.java $
 *
 ***********************************************************************************
 * Copyright (c) 2010 Etudes, Inc.
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
 ****************************************************************************************/
package org.etudes.api.app.melete;

import java.util.Date;

public interface SectionTrackViewObjService {

	public abstract int getSectionId();
	
	public abstract void setSectionId(int sectionId);
	
	/**
	 * @return the userId
	 */
	public abstract String getUserId();

	/**
	 * @param userId the userId to set
	 */
	public abstract void setUserId(String userId);
	
	public abstract Date getViewDate();

	public abstract void setViewDate(Date viewDate);	

	
	/**
	 * @return the section
	 */
	public abstract org.etudes.api.app.melete.SectionObjService getSection();

	/**
	 * @param section the section to set
	 */
	public abstract void setSection(org.etudes.api.app.melete.SectionObjService section);
	
	
}