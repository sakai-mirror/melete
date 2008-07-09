/*
 * Created on Jan 10, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package org.sakaiproject.api.app.melete;
/**
 * @author Faculty
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
 */
public interface SectionResourceService {
	/**
	 * @return Returns the section.
	 */
	public abstract org.sakaiproject.api.app.melete.SectionObjService getSection();

	/**
	 * @param section The section to set.
	 */
	public abstract void setSection(
			org.sakaiproject.api.app.melete.SectionObjService section);

	public abstract String toString();

	/**
	 * @return Returns the sectionId.
	 */
	public abstract Integer getSectionId();

	/**
	 * @param sectionId The sectionId to set.
	 */
	public abstract void setSectionId(Integer sectionId);
	
	/**
	 * @return Returns the resource.
	 */
	public abstract org.sakaiproject.api.app.melete.MeleteResourceService getResource();

	/**
	 * @param resource The resource to set.
	 */
	public abstract void setResource(
			org.sakaiproject.api.app.melete.MeleteResourceService resource);
}