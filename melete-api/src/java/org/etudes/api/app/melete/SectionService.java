/**********************************************************************************
 *
 * $URL$
 * $Id$  
 ***********************************************************************************
 *
 * Copyright (c) 2008, 2009, 2010, 2011 Etudes, Inc.
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

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

public interface SectionService{

	public Integer insertSection(ModuleObjService module, SectionObjService section) throws Exception;
	public void editSection(SectionObjService section, MeleteResourceService melResource) throws Exception;
	public void editSection(SectionObjService section ) throws Exception;
	public SectionObjService getSection(int sectionId);
	public String getSectionTitle(int sectionId);

	/* this method inserts the association in between section and resource and updates melete resource object*/
	public void insertSectionResource(SectionObjService section, MeleteResourceService melResource) throws Exception;

	/* this method inserts the association and inserts a new melete resource*/
	public void insertMeleteResource(SectionObjService section, MeleteResourceService melResource) throws Exception;
	public void insertResource(MeleteResourceService melResource) throws Exception;
	public void updateResource(MeleteResourceService melResource) throws Exception;
	public void deleteResource(MeleteResourceService melResource) throws Exception;

	// used by view pages -- Mallika pages
   public void setSection(SectionObjService sec);

   public List getSortSections(ModuleObjService module);
   public String getSectionDisplaySequence(SectionObjService module);
   
   public void insertSectionTrack(SectionTrackViewObjService stv);

   public void deleteSection(SectionObjService sec, String courseId, String userId) throws Exception;
   public void deleteSections(List sectionBeans, String courseId, String userId) throws Exception;

   public ArrayList getMeleteLicenses();
   public String[] getCCLicenseURL(boolean reqAttr, boolean allowCmrcl, int allowMod);
   public SectionResourceService getSectionResource(String secResourceId);
   public SectionResourceService getSectionResourcebyId(String sectionId);
   public void deleteSectionResourcebyId(String sectionId);   
   public MeleteResourceService getMeleteResource(String selResourceId);
   public void deassociateSectionResource(SectionObjService section, SectionResourceService secResource) throws Exception;
	/**
	 * Update sectionResource and change the resource associated with a section
	 * 
	 * @param section
	 *        The section
	 * @param secResource
	 *        The section resource
	 * @throws Exception
	 */
	public void updateSectionResource(SectionObjService section, SectionResourceService secResource) throws Exception;

	/**
	 * Find all sections where the resource is used.
	 * 
	 * @param selResourceId
	 *        The resource id
	 * @param courseId
	 *        The site Id
	 * @return a list of SectionObjService
	 */
	public List findResourceInUse(String selResourceId, String courseId);

	/**
	 * Delete the resource which is in use by other sections
	 * 
	 * @param delResourceId
	 *        The resource id
	 * @throws Exception
	 */
	public void deleteResourceInUse(String delResourceId) throws Exception;

	/**
	 * Clean up database. Removes the orphaned deleted sections. Part of the melete admin tool to cleanup deleted modules and sections before deep delete.
	 * 
	 * @return
	 * @throws Exception
	 */
	public int cleanUpDeletedSections() throws Exception;

	/**
	 * Get the next section. Reads section sequence xml and returns the next section.
	 * 
	 * @param curr_id
	 *        The current section id
	 * @param seqXML
	 *        The sequence XML
	 * @return next section or null if its the last section of a module.
	 * @throws Exception
	 */
	public SectionObjService getNextSection(String curr_id, String seqXML) throws Exception;

	/**
	 * Get the previous section. Reads the section sequence xml and returns the previous section.
	 * 
	 * @param curr_id
	 *        The current section id
	 * @param seqXML
	 *        The sequence XML
	 * @return previous section or null if its the first section of a module.
	 * @throws Exception
	 */
	public SectionObjService getPrevSection(String curr_id, String seqXML) throws Exception;

	/**
	 * Change license for all sections with the preferred one.
	 * 
	 * @param courseId
	 *        The course id
	 * @param mup
	 *         The Preferred license
	 * @return count of affected sections
	 * @throws Exception
	 */
	public int changeLicenseForAll(String courseId, MeleteUserPreferenceService mup) throws Exception;

	/**
	 * Get all users view date information for a section.
	 * 
	 * @param sectionId
	 *        the section id
	 * @return a Map<userId, ViewDate> information for a section.
	 * 
	 * @throws Exception
	 * 
	 */
	public Map<String, Date> getSectionViewDates(String sectionId) throws Exception;

	/**
	 * Get the total number of active sections in a site. This doesn't count sections of the archived module.
	 * 
	 * @param courseId
	 *        the site Id
	 * @return count
	 */
	public int getNumberOfActiveSections(String courseId);

	/**
	 * Get all sections viewed so far in the site.
	 * 
	 * @param courseId
	 *        the site Id
	 * @return Map <sectionId, List of user ids> of all viewed sections
	 */
	public Map<Integer, List<String>> getNumberOfViewedSections(String courseId);
	
	/**
	 * Get number of sections viewed per user of a site.
	 * 
	 * @param courseId
	 *        the site Id
	 * @return Map <userId, count of sections> of all viewed sections
	 */
	public Map<String, Integer> getNumberOfSectionViewedByUserId(String courseId);
	
}
