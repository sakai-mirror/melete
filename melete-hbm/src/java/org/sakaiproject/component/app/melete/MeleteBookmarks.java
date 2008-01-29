/**********************************************************************************
*
* $Header:
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
package org.sakaiproject.component.app.melete;

import java.io.Serializable;
import org.apache.commons.lang.builder.ToStringBuilder;
import org.sakaiproject.api.app.melete.MeleteBookmarksObjService;

/** @author Hibernate CodeGenerator */
public class MeleteBookmarks implements Serializable, MeleteBookmarksObjService {

	/** identifier field */
	private int bookmarkId;

    private String userId;

    private String courseId;

    /** nullable persistent field */
    private int moduleId;

    /** nullable persistent field */
    private int sectionId;

    /** nullable persistent field */
    private org.sakaiproject.component.app.melete.Module module;

    /** nullable persistent field */
    private org.sakaiproject.component.app.melete.Section section;


	/** full constructor
	 * @param userId
     * @param courseId
     * @param moduleId
     * @param sectionId
	 */
	public MeleteBookmarks(String userId, String courseId, int moduleId, int sectionId, org.sakaiproject.component.app.melete.Module module, org.sakaiproject.component.app.melete.Section section) {
		this.userId = userId;
		this.courseId = courseId;
		this.moduleId = moduleId;
		this.sectionId = sectionId;
		this.module = module;
		this.section = section;
	}

	/**
	 *  default
	 */
	public MeleteBookmarks() {
	}


	/**
	 * {@inheritDoc}
	 */
	public String getUserId() {
		return userId;
	}
	/**
	 * {@inheritDoc}
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}
    public String toString() {
        return new ToStringBuilder(this)
            .append("bookmarkId", getBookmarkId())
            .append("userId", getUserId())
            .append("courseId", getCourseId())
            .append("moduleId", getModuleId())
            .append("sectionId", getSectionId())
            .toString();
    }

	/**
	 * {@inheritDoc}
	 */
	public int getBookmarkId()
	{
		return this.bookmarkId;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setBookmarkId(int bookmarkId)
	{
		this.bookmarkId = bookmarkId;
	}

	/**
	 * {@inheritDoc}
	 */
	public String getCourseId()
	{
		return this.courseId;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setCourseId(String courseId)
	{
		this.courseId = courseId;
	}

	/**
	 * {@inheritDoc}
	 */
	public int getModuleId()
	{
		return this.moduleId;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setModuleId(int moduleId)
	{
		this.moduleId = moduleId;
	}

	/**
	 * {@inheritDoc}
	 */
	public int getSectionId()
	{
		return this.sectionId;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setSectionId(int sectionId)
	{
		this.sectionId = sectionId;
	}

	public org.sakaiproject.component.app.melete.Module getModule()
	{
		return this.module;
	}

	public void setModule(org.sakaiproject.api.app.melete.ModuleObjService module)
	{
		this.module = (Module)module;
	}

	public org.sakaiproject.component.app.melete.Section getSection()
	{
		return this.section;
	}

	public void setSection(org.sakaiproject.api.app.melete.SectionObjService section)
	{
		this.section = (Section)section;
	}


}
