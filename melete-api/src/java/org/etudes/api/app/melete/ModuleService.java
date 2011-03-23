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

import java.util.*;

import org.etudes.api.app.melete.exception.MeleteException;

/* Mallika - 3/22/05 - Added methods for moduledatebeanservice
 * Mallika - 3/28/05 - Catching exception in updateProperties
 * Mallika - 4/18/05 - Added method to delete module
 * Rashmi - 4/21-22 add methods for sort modules
 * Rashmi - 07/07/07 - removed season and yr from method signature of insert properties
 * Mallika - 8/1/06 - adding code to delete modules
 * Rashmi - 1/3/07 - remove license methods
 * Mallika - 11/6/07 - adding methods to get prev and next seq no
 */

public interface ModuleService{

	public void insertProperties(ModuleObjService module, ModuleShdatesService moduleshdates,String userId, String courseId) throws Exception;

	public List getViewModules(String userId, String courseId, boolean fromCourseMap);

	public List getModuleDateBeans(String userId, String courseId);

	public void setModuleDateBeans(List moduleDateBeansList);

	public ModuleDateBeanService getModuleDateBean(String userId, String courseId,  int moduleId);

	public ModuleDateBeanService getModuleDateBeanBySeq(String userId, String courseId,  int seqNo);

	public void setModuleDateBean(ModuleDateBeanService mdBean);

	public List getModules(String courseId);

	public void setModules(List modules) ;

	public void updateProperties(List moduleDateBeans, String courseId)  throws Exception;

	public void archiveModules(List selModBeans, List moduleDateBeans, String courseId) throws Exception;

	public ModuleObjService getModule(int moduleId);

	public void setModule(ModuleObjService mod);

	public List getArchiveModules(String course_id);

	public void restoreModules(List modules, String courseId) throws Exception;

	public CourseModuleService getCourseModule(int moduleId,  String courseId) throws Exception;

	public void deleteModules(List delModules, String courseId, String userId) throws Exception;
	public boolean checkCalendar();
	public int getNextSeqNo(String userId, String courseId, int currSeqNo);
	public int getPrevSeqNo(String userId, String courseId, int currSeqNo);

	public org.w3c.dom.Document getSubSectionW3CDOM(String sectionsSeqXML);

	public boolean updateSeqXml(String courseId) throws Exception;

	public void createSubSection(ModuleObjService module, List secBeans) throws MeleteException;

	public void bringOneLevelUp(ModuleObjService module, List secBeans) throws MeleteException;

	/**
	 * Sorts the module in the specified direction (One up/down, all up/all down).
	 * 
	 * @param module
	 *        ModuleObjService object
	 * @param course_id
	 *        The course id
	 * @param Direction
	 *        direction to move(allUp, up, down, allDown)
	 * @throws "sort_fail" MeleteException
	 */
	public void sortModule(ModuleObjService module, String course_id, String Direction) throws MeleteException;

	/**
	 * Sorts the section in the specified direction (One up/down, all up/all down). Updates the module sequence XMl accordingly.
	 * 
	 * @param module
	 *        ModuleObjService object
	 * @param section_id
	 *        The section id
	 * @param Direction
	 *        direction to move the section (allUp, up, down, allDown)
	 * @throws "sort_fail" MeleteException
	 */
	public void sortSectionItem(ModuleObjService module, String section_id, String Direction) throws MeleteException;

	/**
	 * Creates a duplicate copy. The copied Module title and its sections title are appended with (Copied date)
	 * 
	 * @param module
	 *        ModuleObjService object
	 * @param courseId
	 *        The course id
	 * @param userId
	 *        The user Id
	 * @throws "copy_fail" MeleteException
	 */
	public void copyModule(ModuleObjService module, String courseId, String userId) throws MeleteException;

	/**
	 * Moves the list of sections to the module. Updates the old and selected module sequence XML. For composed sections, moves the file to selected module's content collection.
	 * 
	 * @param sectionBeans
	 *        List of Sections to be moved
	 * @param selectedModule
	 *        The selected ModuleObjService Object 
	 * @throws MeleteException
	 *         "move_section_fail" MeleteException
	 */
	public void moveSections(List sectionBeans, ModuleObjService selectedModule) throws MeleteException;
	
	/**
	 * Gets the module and its sections contents in a printable fashion.
	 * 
	 * @param module
	 *        ModuleObjService Object
	 * @return
	 * @throws "print_module_fail" MeleteException
	 */
	public String printModule(ModuleObjService module) throws MeleteException;

	/**
	 * Part of melete admin tool. Cleans database and removes the deleted modules.
	 * 
	 * @return
	 * @throws Exception
	 *         "cleanup_module_fail" MeleteException
	 */
	public int cleanUpDeletedModules() throws Exception;
	
	/**
	 * Get the number of active modules in a site.
	 * 
	 * @param courseId
	 *        The course Id
	 * @return
	 */
	public int getCourseModuleSize(String courseId);
	
	/**
	 * Gets the earliest start date(if defined) of all the modules 
	 * @param course_id		Course id
	 * @return If start date exists for the modules gets the earliest start date of all modules else returns null
	 */
	public Date getMinStartDate(String course_id);
	
	/**
	 * Apply base date to all module start and end dates
	 * @param course_id		Course id
	 * @param days_diff		Time difference in days
	 */	
	public void applyBaseDateTx(String course_id, int days_diff);
	
	/**
	 * Update module's dates from Coursemap
	 * 
	 * @param modShdates
	 *        ModuleShdatesService Object
	 * @throws Exception
	 *         "edit_module_multiple_users" MeleteException and Hibernate Exception
	 */
	public void updateModuleDates(ModuleShdatesService modShdates) throws Exception;
	 
	/**
	 * Check if user has edit access.
	 * 
	 * @param user_id
	 *        The user Id
	 * @param course_id
	 *        The course Id
	 * @return
	 */
	public boolean checkEditAccess(String user_id, String course_id);

	/**
	 * Checks if a module is open or closed at a given time
	 * 
	 * @param startDate
	 * @param endDate
	 * @return invalid if not able to determine the status. open if module is open and active. 
	 *         closed if module is closed. later if module is not opened yet.
	 */
	public String isSectionModuleOpen(Date startDate, Date endDate);
	
	/**
	 * Get the number of sections read by a user from a module
	 * 
	 * @param user_id
	 *        The user Id
	 * @param module_id
	 *        The module Id
	 * @return
	 */
	public int getNumberOfSectionsReadFromModule(String user_id, int module_id);
	
    /**
	 * Checks if the module is completely read by the user
	 * 
	 * @param user_id
	 *        The user Id
	 * @param module_id
	 *        The module Id
	 * @return true if read completely
	 */
	public boolean isModuleCompleted(String user_id, int module_id);

	/**
	 * Get the number of modules completely read by the users of the site
	 * 
	 * @param course_id
	 *        The Course Id
	 * @return Map<user Id, count of completely read modules>
	 */
	public Map<String, Integer> getNumberOfModulesCompletedByUserId(String course_id);
}