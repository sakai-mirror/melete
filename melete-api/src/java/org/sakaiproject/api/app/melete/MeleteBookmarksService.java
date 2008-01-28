/**********************************************************************************
 * $URL$
 * $Id$
 ***********************************************************************************
 *
 * Copyright (c) 2007 The Sakai Foundation.
 * 
 * Licensed under the Educational Community License, Version 1.0 (the "License"); 
 * you may not use this file except in compliance with the License. 
 * You may obtain a copy of the License at
 * 
 *      http://www.opensource.org/licenses/ecl1.php
 * 
 * Unless required by applicable law or agreed to in writing, software 
 * distributed under the License is distributed on an "AS IS" BASIS, 
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
 * See the License for the specific language governing permissions and 
 * limitations under the License.
 *
 **********************************************************************************/

package org.sakaiproject.api.app.melete;

/**
 * 
 */
public interface MeleteBookmarksService
{

	/**
	 * @return Returns the userId.
	 */
	public abstract String getUserId();

	/**
	 * @param userId The userId to set.
	 */
	public abstract void setUserId(String userId);

	public abstract int getBookmarkId();

	public abstract void setBookmarkId(int bookmarkId);

	public abstract String getCourseId();

	public abstract void setCourseId(String courseId);

	public abstract int getModuleId();

	public abstract void setModuleId(int moduleId);

	public abstract int getSectionId();

	public abstract void setSectionId(int sectionId);
	
	public abstract org.sakaiproject.api.app.melete.ModuleObjService getModule();

	public abstract void setModule(
			org.sakaiproject.api.app.melete.ModuleObjService module);
	
	public abstract org.sakaiproject.api.app.melete.SectionObjService getSection();

	public abstract void setSection(
			org.sakaiproject.api.app.melete.SectionObjService section);

}
