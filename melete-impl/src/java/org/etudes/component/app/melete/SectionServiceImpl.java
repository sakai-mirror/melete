/**********************************************************************************
 *
 * $Header: /usr/src/sakai/melete-2.4/melete-impl/src/java/org/sakaiproject/component/app/melete/SectionServiceImpl.java,v 1.13 2007/06/25 17:03:13 rashmim Exp $
 * $Id$
 ***********************************************************************************
 *
 * Copyright (c) 2008, 2009, 2010, 2011 Etudes, Inc.
 *
 * Portions completed before September 1, 2008 Copyright (c) 2004, 2005, 2006, 2007, 2008 Foothill College, ETUDES Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
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
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.Map;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.dom4j.Element;
import org.hibernate.Session;
import org.etudes.api.app.melete.MeleteResourceService;
import org.etudes.api.app.melete.MeleteSecurityService;
import org.etudes.api.app.melete.MeleteUserPreferenceService;
import org.etudes.api.app.melete.SectionResourceService;
import org.etudes.api.app.melete.SectionService;
import org.etudes.api.app.melete.ModuleObjService;
import org.etudes.api.app.melete.SectionObjService;
import org.etudes.api.app.melete.SectionTrackViewObjService;
import org.etudes.api.app.melete.exception.MeleteException;
import org.etudes.api.app.melete.MeleteCHService;


/**
 * @author Rashmi
 *
 * This is the class implementing SectionService interface.
 */
public class SectionServiceImpl implements Serializable, SectionService
{
	private SectionDB sectiondb;
	private Section section = null;
	private Log logger = LogFactory.getLog(SectionServiceImpl.class);
	private MeleteLicenseDB meleteLicenseDB;
	private MeleteCHService meleteCHService;

	public SectionServiceImpl()
	{
		sectiondb= getSectiondb();
	}

	public int changeLicenseForAll(String courseId, MeleteUserPreferenceService mup) throws Exception
	{
		try
		{
			return sectiondb.changeLicenseForAll(courseId, (MeleteUserPreference)mup);
		}
		catch (Exception e)
		{
			throw new MeleteException("all_license_change_fail");
		}	
	}

	public int cleanUpDeletedSections() throws Exception
	{
		int noOfDeleted = sectiondb.cleanUpDeletedSections();
		return noOfDeleted;
	}

	public void deassociateSectionResource(SectionObjService section, SectionResourceService secResource) throws Exception
	{
		try{
			sectiondb.deassociateSectionResource((Section)section, (SectionResource)secResource);
		}catch(Exception ex)
		{
			logger.debug("EditSectionPage --deassociateSectionResource failed");
			throw new MeleteException(ex.toString());
		}
	}
	/*
	 * deleteResource object
	 */
	public void deleteResource(MeleteResourceService melResource) throws Exception
	{
		try{
			sectiondb.deleteResource((MeleteResource)melResource);
		}catch(Exception ex)
		{
			logger.debug("AddSectionPage --delete resource failed");
			throw new MeleteException(ex.toString());
		}
	}
	public void deleteResourceInUse(String delResourceId) throws Exception
	{
		sectiondb.deleteResourceInUse(delResourceId);
	}

	public void deleteSection(SectionObjService sec, String courseId, String userId) throws MeleteException
	{
		try
		{
			sectiondb.deleteSection((Section)sec, courseId, userId);
		}
		catch (Exception ex)
		{
			throw new MeleteException("delete_module_fail");
		}
	}


	/*
	 * delete section resource object
	 */
	public void deleteSectionResourcebyId(String sectionId)
	{
		try
		{
			sectiondb.deleteSectionResourcebyId(sectionId);
		}catch(Exception ex)
		{
			logger.debug("editSectionPage --delete section resource failed");
		}
	}

	public void deleteSections(List sectionBeans, String courseId, String userId) throws MeleteException
	{
		List secList = null;
		for (ListIterator i = sectionBeans.listIterator(); i.hasNext(); )
		{
			SectionBean secbean = (SectionBean)i.next();

			Section sec = (Section) secbean.getSection();
			deleteSection(sec, courseId, userId);
		}
	}

	public void destroy()
	{
		logger.debug(this +".destroy()");
	}	

	public void editSection(SectionObjService section ) throws Exception
	{
		try{
			// edit Section
			sectiondb.editSection((Section)section);
		}
		catch(MeleteException mex)
		{
			throw mex;
		}
		catch(Exception ex)
		{
			throw new MeleteException("add_section_fail");
		}
	}

	public void editSection(SectionObjService section, MeleteResourceService melResource ) throws MeleteException
	{
		try{
			// edit Section
			sectiondb.editSection((Section)section, (MeleteResource) melResource);
		}
		catch(MeleteException mex)
		{
			throw mex;
		}
		catch(Exception ex)
		{
			throw new MeleteException("add_section_fail");
		}
	}


	public List findResourceInUse(String selResourceId, String courseId)
	{
		List resourceUseList = null;
		//found in section resources so break
		resourceUseList = sectiondb.checkInSectionResources(selResourceId);
		if (resourceUseList != null && resourceUseList.size() > 0)
		{
			return resourceUseList;
		}
		else
		{
			resourceUseList = sectiondb.findResourceInUse(selResourceId, courseId);
		}
		return resourceUseList;
	}

	/**
	 * Count of all active sections in a site
	 * @param course_id
	 * @return
	 */
	public int getNumberOfActiveSections(String course_id)
	{
		try
		{
			return sectiondb.getAllActiveSectionsCount(course_id);
		}
		catch(Exception e)
		{
			return 0;
		}
	}

	/**
	 * all viewed sections 
	 * @param course_id
	 * @return
	 */
	public Map <Integer, List<String>> getNumberOfViewedSections(String course_id)
	{
		try
		{
			return sectiondb.getAllViewedSectionsCount(course_id);
		}
		catch(Exception e)
		{
			return null;
		}
	}
	/**
	 * @param allowCmrcl
	 * @param allowMod
	 * fetches the cc license url from database based on user selected values.
	 * ReqAttr value is always true.
	 * @return
	 */
	public String[] getCCLicenseURL(boolean reqAttr, boolean allowCmrcl, int allowMod)
	{
		try{
			return getMeleteLicenseDB().fetchCcLicenseURL(new Boolean(reqAttr),new Boolean(allowCmrcl), new Integer(allowMod));
		}catch(Exception ex)
		{
			// need to work on it
			return null;
		}
	}

	/**
	 * @return Returns the meleteLicenseDB.
	 */
	public MeleteLicenseDB getMeleteLicenseDB() 
	{
		return meleteLicenseDB;
	}

	/*
	 * Gets the available module licenses from db
	 * like copyright, cc license, public domain etc
	 */
	public ArrayList getMeleteLicenses()
	{
		try{
			ArrayList licenses = new ArrayList();
			licenses = getMeleteLicenseDB().getLicenseTypes();

			return licenses;
		}catch(Exception ex)
		{
			// need to work on it
			return null;
		}

	}
	public MeleteResourceService getMeleteResource(String selResourceId)
	{
		MeleteResource mr = null;
		try{
			mr = sectiondb.getMeleteResource(selResourceId);
		}catch(Exception ex)
		{
			logger.debug("AddSectionPage --add section resource failed");
		}
		return mr;
	}

	public SectionObjService getNextSection(String curr_id, String seqXML) throws Exception
	{
		SubSectionUtilImpl SectionUtil = new SubSectionUtilImpl();
		org.w3c.dom.Document sectionDocument = SectionUtil.getSubSectionW3CDOM(seqXML);
		org.w3c.dom.Element currItem = sectionDocument.getElementById(curr_id);
		org.w3c.dom.Element nextItem = SectionUtil.getNextSection(currItem);
		if (nextItem != null)
		{
			SectionObjService nextSection = getSection(Integer.parseInt(nextItem.getAttribute("id")));
			return nextSection;
		}
		return null;
	}

	public SectionObjService getPrevSection(String curr_id, String seqXML) throws Exception
	{
		SubSectionUtilImpl SectionUtil = new SubSectionUtilImpl();
		org.w3c.dom.Document sectionDocument = SectionUtil.getSubSectionW3CDOM(seqXML);
		org.w3c.dom.Element currItem = sectionDocument.getElementById(curr_id);
		org.w3c.dom.Element prevItem = SectionUtil.getPrevSection(sectionDocument,currItem);
		if (prevItem != null)
		{
			SectionObjService prevSection = getSection(Integer.parseInt(prevItem.getAttribute("id")));
			return prevSection;
		}
		return null;
	}

	public SectionObjService getSection(int sectionId)
	{
		Section section = new Section();
		try {
			section = sectiondb.getSection(sectionId);
		}catch (Exception e)
		{
			logger.debug(e.toString());
		}
		return section;
	}

	/**
	 * @return Returns the sectiondb.
	 */
	public SectionDB getSectiondb() 
	{
		return sectiondb;
	}

	// Added by UPV to show section numbering
	public String getSectionDisplaySequence(SectionObjService section) 
	{
		try {
			if (section==null) {return null;};
			ModuleObjService module =section.getModule();
			Map sections = module.getSections();
			List sectionsList = null;
			SubSectionUtilImpl sutil = new SubSectionUtilImpl();
			String startDispSeq = new Integer(module.getCoursemodule().getSeqNo()).toString();
			sutil.traverseDom(module.getSeqXml(),startDispSeq);
			List xmlSecList = sutil.getXmlSecList();
			if(xmlSecList != null)
			{
				sectionsList = new ArrayList();
				for (ListIterator k = xmlSecList.listIterator(); k.hasNext(); ){
					SecLevelObj slObj = (SecLevelObj)k.next();
					if (section.getSectionId().equals(slObj.getSectionId())) {return slObj.getDispSeq();};

				}
			}
		}catch (Exception e)
		{
			logger.debug(e.toString());
		}
		return null;
	}

	/*
	 * get section resource object
	 */
	public SectionResourceService getSectionResource(String secResourceId)
	{
		SectionResource sr = null;
		try{
			sr = sectiondb.getSectionResource(secResourceId);
		}catch(Exception ex)
		{
			logger.debug("AddSectionPage --add section resource failed");
		}
		return sr;
	}

	/*
	 * get section resource object
	 */
	public SectionResourceService getSectionResourcebyId(String sectionId)
	{
		SectionResource sr = null;
		try{
			sr = sectiondb.getSectionResourcebyId(sectionId);
		}catch(Exception ex)
		{
			logger.debug("AddSectionPage --add section resource failed");
		}
		return sr;
	}

	public String getSectionTitle(int sectionId) 
	{
		String secTitle = null;
		try {
			secTitle = sectiondb.getSectionTitle(sectionId);
		}catch (Exception e)
		{
			logger.debug(e.toString());
		}
		return secTitle;
	}

	public Map<String, Date> getSectionViewDates(String sectionId) throws Exception
	{
		if (sectionId == null) return null;
		return sectiondb.getSectionUsersViewDate(new Integer(sectionId).intValue());		
	}
	
	public Integer getSectionViewersCount(String sectionId)
	{
		if (sectionId == null) return 0;
		return sectiondb.getSectionViewersCount(new Integer(sectionId).intValue());	
	}

	public List getSortSections(ModuleObjService module)
	{
		try {
			Map sections = module.getSections();
			List sectionsList = null;
			SubSectionUtilImpl sutil = new SubSectionUtilImpl();
			String startDispSeq = new Integer(module.getCoursemodule().getSeqNo()).toString();
			sutil.traverseDom(module.getSeqXml(),startDispSeq);
			List xmlSecList = sutil.getXmlSecList();
			if(xmlSecList != null)
			{
				sectionsList = new ArrayList();
				for (ListIterator k = xmlSecList.listIterator(); k.hasNext(); ){
					SecLevelObj slObj = (SecLevelObj)k.next();
					if (slObj != null)
					{
						Section sec =(Section)sections.get(new Integer(slObj.getSectionId()));
						String addBefore ="| - ";
						for(int i=0;i < slObj.getLevel(); i++)addBefore = addBefore + "- ";
						SectionBean secBean = new SectionBean(sec);
						secBean.setDisplaySequence(addBefore + slObj.getDispSeq());
						sectionsList.add(secBean);
					}
				}
			}
			return sectionsList;
		}catch (Exception e)
		{
			logger.debug(e.toString());
		}
		return null;
	}

	/**
	 * Final initialization, once all dependencies are set.
	 */
	public void init()
	{
		if (logger.isDebugEnabled()) logger.debug(this +".init()");

		List ccLicenseList = meleteLicenseDB.getCcLicense();
		if (ccLicenseList != null && ccLicenseList.size() == 0)
		{
			ArrayList ccLicenses = new ArrayList();
			ccLicenses.add(new CcLicense(false, false, 0, "http://creativecommons.org/licenses/publicdomain/","Public Domain Dedication"));
			ccLicenses.add(new CcLicense(true, false, 0, "http://creativecommons.org/licenses/by-nc-nd/2.0/","Attribution-NonCommercial-NoDerivs"));
			ccLicenses.add(new CcLicense(true, false, 1, "http://creativecommons.org/licenses/by-nc-sa/2.0/","Attribution-NonCommercial-ShareAlike"));
			ccLicenses.add( new CcLicense(true, false, 2, "http://creativecommons.org/licenses/by-nc/2.0/","Attribution-NonCommercial"));
			ccLicenses.add( new CcLicense(true, true, 0, "http://creativecommons.org/licenses/by-nd/2.0/","Attribution-NoDerivs"));
			ccLicenses.add( new CcLicense(true, true, 1, "http://creativecommons.org/licenses/by-sa/2.0/","Attribution-ShareAlike"));
			ccLicenses.add( new CcLicense(true, true, 2, "http://creativecommons.org/licenses/by/2.0/","Attribution"));
			meleteLicenseDB.createCcLicense(ccLicenses);
		}

		List moduleLicenseList = meleteLicenseDB.getLicenseTypes();
		if (moduleLicenseList != null && moduleLicenseList.size() == 0)
		{
			ArrayList moduleLicenses = new ArrayList();
			moduleLicenses.add(new MeleteLicense(new Integer(0), "I have not determined copyright yet"));
			moduleLicenses.add( new MeleteLicense(new Integer(1), "Copyright of Author"));
			moduleLicenses.add(new MeleteLicense(new Integer(2), "Public Domain"));
			moduleLicenses.add( new MeleteLicense(new Integer(3), "Creative Commons License"));
			moduleLicenses.add( new MeleteLicense(new Integer(4), "Fair Use Exception"));
			meleteLicenseDB.createMeleteLicense(moduleLicenses);
		}



		logger.info(this +".init() completed successfully");
	}

	/*
	 * add section resource association and resource object
	 */
	public void insertMeleteResource(SectionObjService section, MeleteResourceService melResource) throws Exception
	{
		try{
			sectiondb.insertMeleteResource((Section)section, (MeleteResource)melResource);
		}catch(Exception ex)
		{
			logger.debug("AddSectionPage --add section resource failed");
			throw new MeleteException(ex.toString());
		}
	}

	/*
	 * add resource object
	 */
	public void insertResource( MeleteResourceService melResource) throws Exception
	{
		try{
			sectiondb.insertResource((MeleteResource)melResource);
		}catch(Exception ex)
		{
			logger.debug("AddSectionPage --add resource failed");
			throw new MeleteException(ex.toString());
		}
	}

	public Integer insertSection(ModuleObjService module, SectionObjService section) throws MeleteException
	{
		try{
			// insert new Section
			logger.debug("dtd in insersection - impl layer");
			Integer newsectionId = sectiondb.addSection((Module)module, (Section)section, false);
			return newsectionId;

		}catch(Exception ex)
		{
			logger.debug("section business --add section failed");
			throw new MeleteException("add_section_fail");
		}
	}

	/*
	 * add section resource association
	 */
	public void insertSectionResource(SectionObjService section, MeleteResourceService melResource) throws Exception
	{
		try{
			sectiondb.insertSectionResource((Section)section, (MeleteResource)melResource);
		}catch(Exception ex)
		{
			logger.debug("AddSectionPage --add section resource failed");
			throw new MeleteException(ex.toString());
		}
	}

	public void insertSectionTrack(SectionTrackViewObjService stv)
	{
		try{
			sectiondb.insertSectionTrack(stv);
		}catch(Exception ex)
		{
			logger.error("ViewSectionPage --add section track failed for user "+stv.getUserId()+" for section "+stv.getSectionId());
		}
	}
	/**
	 * @param meleteCHService the meleteCHService to set
	 */
	public void setMeleteCHService(MeleteCHService meleteCHService)
	{
		this.meleteCHService = meleteCHService;
	}
	/**
	 * @param meleteLicenseDB The meleteLicenseDB to set.
	 */
	public void setMeleteLicenseDB(MeleteLicenseDB meleteLicenseDB) 
	{
		this.meleteLicenseDB = meleteLicenseDB;
	}

	// Mallika's methods
	public void setSection(SectionObjService sec)
	{
		section = (Section)sec;
	}
	/**
	 * @param sectiondb The sectiondb to set.
	 */
	public void setSectiondb(SectionDB sectiondb)
	{
		this.sectiondb = sectiondb;
	}

	/*
	 * update resource object
	 */
	public void updateResource(MeleteResourceService melResource) throws Exception
	{
		try{
			sectiondb.updateResource((MeleteResource)melResource);
		}catch(Exception ex)
		{
			logger.debug("EditSectionPage --update resource failed");
			throw new MeleteException(ex.toString());
		}
	}

	public void updateSectionResource(SectionObjService section, SectionResourceService secResource) throws Exception
	{
		try{
			sectiondb.updateSectionResource((Section)section, (SectionResource)secResource);
		}catch(Exception ex)
		{
			logger.debug("EditSectionPage --updateSectionResource failed");
			throw new MeleteException(ex.toString());
		}
	}
}
