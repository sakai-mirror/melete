/**********************************************************************************
 *
 * $URL$
 * $Id$
 ***********************************************************************************
 *
 * Copyright (c) 2008,2009 Etudes, Inc.
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

import java.io.File;
import java.io.FileInputStream;
import java.net.MalformedURLException;
import java.net.UnknownHostException;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.ListIterator;
import java.util.ArrayList;
import java.util.Map;
import java.util.Set;
import java.util.HashSet;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.net.URLDecoder;

import org.dom4j.Attribute;
import org.dom4j.Document;
import org.dom4j.Element;
import org.dom4j.Namespace;
import org.dom4j.Node;
import org.dom4j.QName;
import org.dom4j.XPath;
import org.etudes.component.app.melete.MeleteUtil;
import org.etudes.api.app.melete.MeleteCHService;
import org.etudes.api.app.melete.MeleteImportService;
import org.etudes.api.app.melete.MeleteSecurityService;
import org.sakaiproject.component.cover.ServerConfigurationService;
import org.sakaiproject.content.cover.ContentTypeImageService;
import org.sakaiproject.content.cover.ContentHostingService;
import org.sakaiproject.content.api.ContentResource;
import org.sakaiproject.content.api.ContentCollection;
import org.sakaiproject.entity.api.ResourceProperties;
import org.sakaiproject.entity.api.Reference;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.sakaiproject.thread_local.api.ThreadLocalManager;
import org.sakaiproject.tool.cover.ToolManager;
import org.sakaiproject.user.cover.UserDirectoryService;
import org.etudes.api.app.melete.exception.MeleteException;
import org.sakaiproject.entity.api.Entity;
import org.sakaiproject.entity.api.ResourcePropertiesEdit;
import org.sakaiproject.exception.IdUnusedException;
import org.sakaiproject.util.ResourceLoader;
import org.sakaiproject.util.Validator;
import org.sakaiproject.entity.cover.EntityManager;
import org.sakaiproject.entity.api.Reference;
/**
 * MeleteImportServiceImpl is the implementation of MeleteImportService
 * that provides the methods for import export
 *
 * @author Murthy @ Foothill college
 * @version
 *
 * Mallika - 2/2/07 - adding check on import too for missing files
 * Rashmi - 2/6/07 -  revised wrt Content hosting
 * Rashmi - 2/11/07 - preserve license terms
 * Mallika - 5/2/07 - Added checks to see if resources already exist in uploads collection
 * Mallika - 5/3/07 - Fix for entire url
 * Rashmi - 5/7/07 - revised check for adding resources in uploads
 * Mallika - 5/14/07 - Reordered code so we only read from unzipped dirs if item doesnt' exist in resources and meletedocs
 * Mallika - 5/15/07 - Rearranged code for import from site
 * Mallika - 6/7/07 - Added null check condition for copyIntoFolder
 * Mallika - 6/11/07 - Moved null check to replace method
 * Mallika - 6/22/07 - Fix for ME-433
 * Mallika - 7/24/07 - Added embed tag processing
 */
public class MeleteImportServiceImpl implements MeleteImportService{
	/*******************************************************************************
	* Dependencies
	*******************************************************************************/
	/** Dependency:  The logging service. */
	protected Log logger = LogFactory.getLog(MeleteImportServiceImpl.class);
	private ThreadLocalManager threadLocalManager = org.sakaiproject.thread_local.cover.ThreadLocalManager.getInstance();

	protected SectionDB sectionDB;
	protected ModuleDB moduleDB;
	protected ModuleShdates moduleShdates;
	private MeleteCHService meleteCHService;
	private MeleteLicenseDB meleteLicenseDB;
	private MeleteUserPreferenceDB meleteUserPrefDB;

	private SubSectionUtilImpl sectionUtil;

	/**default namespace and metadata namespace*/
	protected String DEFAULT_NAMESPACE_URI = "http://www.imsglobal.org/xsd/imscp_v1p1";
	protected String IMSMD_NAMESPACE_URI ="http://www.imsglobal.org/xsd/imsmd_v1p2";

	protected int RESOURCE_LICENSE_CODE = 0; //not determined yet
	protected String RESOURCE_LICENSE_URL = "I have not determined copyright yet"; //No license
	protected int RESOURCE_LICENSE_COPYRIGHT_CODE = 1; //Copyright of author
	protected int RESOURCE_LICENSE_PD_CODE = 2; //		Public Domain
	protected int RESOURCE_LICENSE_CC_CODE = 3; //Creative Commons
	protected int RESOURCE_LICENSE_FAIRUSE_CODE = 4; //FairUse Exception

	protected MeleteUtil meleteUtil = new MeleteUtil();
	static final String REFERENCE_ROOT = Entity.SEPARATOR+"meleteDocs";


	/**
	 * Final initialization, once all dependencies are set.
	 */
	public void init(){
		logger.debug(this +".init()");
	}

	/**
	 * Final cleanup.
	 */
	public void destroy(){
		logger.debug(this +".destroy()");
	}

	private void buildModuleTitle(Element titleEle, Module module)
	{
		boolean moduleTitleFlag = false;
		if (titleEle != null)
		{
			String title = titleEle.getTextTrim();
			if (title != null && title.length() != 0)
			{
				module.setTitle(title);
				moduleTitleFlag = true;
			}
		}
		if(!moduleTitleFlag) module.setTitle("Untitled Module");
		return;
	}

	private boolean buildModuleDescription(Element descEle, Module module)
	{
		boolean descr = false;
		if (descEle != null && descEle.element("imsmd:langstring") != null)
		{
			String desc = descEle.element("imsmd:langstring").getText();
			module.setDescription(desc.trim());
			descr = true;
		}
		return descr;
	}

	private boolean buildModuleKeyword(Element keywordEle, Module module)
	{
		boolean keywords = false;

		if (keywordEle != null && keywordEle.element("imsmd:langstring") != null)
		{
			String modkeyword = keywordEle.element("imsmd:langstring").getText();
			module.setKeywords(modkeyword.trim());
			keywords = true;
		}
		return keywords;
	}


	private void removeNamespaces(Element elem)
	{
		elem.setQName(QName.get(elem.getName(), Namespace.NO_NAMESPACE, elem.getQualifiedName()));
		Node n = null;
		for (int i = 0; i < elem.content().size(); i++)
		{
			n = (Node) elem.content().get(i);
			if (n.getNodeType() == Node.ATTRIBUTE_NODE) ((Attribute) n).setNamespace(Namespace.NO_NAMESPACE);
			if (n.getNodeType() == Node.ELEMENT_NODE) removeNamespaces((Element) n);
		}
	}

	public int mergeAndBuildModules(Document ArchiveDoc, String unZippedDirPath, String fromSiteId) throws Exception
	{
		if (logger.isDebugEnabled()) logger.debug("Entering mergeAndBuildModules");

		int count = 0;
		try
		{
			Element rootEle = ArchiveDoc.getRootElement();

			Map uris = new HashMap();
			uris.put("imscp", DEFAULT_NAMESPACE_URI);
			uris.put("imsmd", IMSMD_NAMESPACE_URI);

			// organizations
			List elements = rootEle.selectNodes("//organization/item");
			logger.debug("sz of elements is" + elements.size());
			count = elements.size();
			for (Iterator iter = elements.iterator(); iter.hasNext();)
			{
				Element element = (Element) iter.next();

				//build module
				Module module = new Module();
				boolean keywords = false;
				boolean descr = false;
				for (Iterator iter1 = element.elementIterator(); iter1.hasNext();)
				{
					Element childele = (Element) iter1.next();

					if (childele.getName().equals("title")) buildModuleTitle(childele, module);
					if (childele.getName().equals("imsmd:lom"))
					{
						List<Element> modulegeneralList = childele.elements();
						List moduleMetadataList = modulegeneralList.get(0).elements();

						for (Iterator iter2 = moduleMetadataList.iterator(); iter2.hasNext();)
						{
							Element metaElement = (Element) iter2.next();

							if (metaElement.getName().equals("imsmd:description")) descr = buildModuleDescription(metaElement, module);
							if (!descr) module.setDescription("    ");
							if (metaElement.getName().equals("imsmd:keyword")) keywords = buildModuleKeyword(metaElement, module);
							if (!keywords) module.setKeywords(module.getTitle());
						}
					}

				}
				createModule(module, fromSiteId);
			// build sections

				sectionUtil = new SubSectionUtilImpl();
				Document seqDocument = sectionUtil.createSubSection4jDOM();

				for (Iterator iter3 = element.elementIterator("item"); iter3.hasNext();)
				{
					Element itemelement = (Element) iter3.next();

					if (itemelement.attributeValue("identifier").startsWith("NEXTSTEPS"))
						mergeWhatsNext(itemelement, ArchiveDoc, module, unZippedDirPath);
					else mergeSection(itemelement, ArchiveDoc, module, addBlankSection(null, seqDocument), unZippedDirPath, seqDocument, fromSiteId);
				}

				// update module seqXml
				logger.debug("checking seqXML now at the end of buildModule process" + seqDocument.asXML());
				module.setSeqXml(seqDocument.asXML());
				moduleDB.updateModule(module);

			}
		}
		catch (Exception e)
		{
			// no organization tag so create one flat module
			e.printStackTrace();
		}

		if (logger.isDebugEnabled()) logger.debug("Exiting mergeAndBuildModules");
		return count;
	}

	private void processManageResources(Element rootEle, String unZippedDirPath, String fromSiteId, Document document) throws Exception
	{
		String melResourceName = null;
		String melResourceDescription = null;
		String res_mime_type = null;
		byte[] melContentData = null;
		boolean encodingFlag = false;
		String newResourceId = "";
		String fromCRName = null;
		String urlTitle = "";

		//Processing Manage resources
//		 resources
		//List elements = rootEle.selectNodes("/resource");
		List elements = rootEle.elements();
		int count = elements.size();
		for (Iterator iter = elements.iterator(); iter.hasNext();)
		{
			Element element = (Element) iter.next();

			if (element.attributeValue("identifier").startsWith("MANAGERESOURCE"))
			{
						Attribute resHrefAttr = element.attribute("href");

						if (resHrefAttr != null)
						{
							String hrefVal = resHrefAttr.getValue();
							// check if file is missing
							if (hrefVal != null && hrefVal.length() != 0
									&& !(hrefVal.startsWith("http://") || hrefVal.startsWith("https://") || hrefVal.startsWith("mailto:")))
							{
								if (!meleteUtil.checkFileExists(unZippedDirPath + File.separator + hrefVal))
								{
									logger.info("content file for section is missing so move ON");
									continue;
								}
							}
							// end missing file check

							// create meleteResourceObject
							 List resElements = element.elements();
							//typeLink resource
							if (hrefVal.startsWith("http://") || hrefVal.startsWith("https://") || hrefVal.startsWith("mailto:"))
							{
							  if(resElements != null)
							  {
								urlTitle = null;
								for(int i=0; i < resElements.size(); i++)
								{
									Element urlTitleElement = (Element)resElements.get(i);
									if(urlTitleElement.getQualifiedName().equalsIgnoreCase("imsmd:title")){
										urlTitle = urlTitleElement.selectSingleNode( ".//imsmd:langstring").getText();
										break;
									}
								}
							  }

							  // make last part of link as title
							  if(urlTitle.equals(""))
							  {
								urlTitle = hrefVal.substring(hrefVal.lastIndexOf("/")+1);
								if(urlTitle == null || urlTitle.length() == 0)
								{
									urlTitle = hrefVal.substring(0,hrefVal.lastIndexOf("/"));
									urlTitle = urlTitle.substring(urlTitle.lastIndexOf("/")+1);
								}
							  }
							  melResourceName = urlTitle;
						  }
						  else
			           	  {
							// uploaded file
							boolean contentSet = false;
							melResourceName = hrefVal.substring(hrefVal.lastIndexOf("/") + 1);
							// Check if this is coming in from IMS Import
							if (resElements != null)
							{
			                			//Load up the resource to look at it
								String contentEditor = new String(meleteUtil.readFromFile(new File(unZippedDirPath + File.separator + hrefVal)));
								urlTitle = null;
								for(int i=0; i < resElements.size(); i++)
								{
									Element urlTitleElement = (Element)resElements.get(i);
									if(urlTitleElement.getQualifiedName().equalsIgnoreCase("imsmd:title")){
										urlTitle = urlTitleElement.selectSingleNode( ".//imsmd:langstring").getText();
									}
								}
								if ( urlTitle != null ) melResourceName = urlTitle;
							}

						  }

 						  for (int i = 0; i < resElements.size(); i++)
						  {
							Element resDescElement = (Element) resElements.get(i);
							if (resDescElement.getQualifiedName().equalsIgnoreCase("imsmd:description"))
							{
								melResourceDescription = resDescElement.selectSingleNode(".//imsmd:langstring").getText();
								break;
							}
						  }

						 // Everything here is going to uploads collection
						try{
							// check if the item has already been imported to this site (in uploads collection)
							String checkResourceId = "/private/meleteDocs/"+fromSiteId+"/uploads/"+melResourceName;
					 		getMeleteCHService().checkResource(checkResourceId);
					 		}catch (IdUnusedException ex)
							{
						 		// actual insert
						 		// if not found in meleteDocs collection include it
						 		String uploadCollId = getMeleteCHService().getUploadCollectionId(fromSiteId);

							  	// data is generally large so read it only if need to insert
								if(hrefVal.startsWith("http://") || hrefVal.startsWith("https://") || hrefVal.startsWith("mailto:"))
								{
//								 	 link points to Site Resources item so move it to MeleteDocs collection
									if(hrefVal.indexOf("/access/content/group") != -1 || hrefVal.indexOf("/access/meleteDocs") != -1)
									{
										String fileResourceName= hrefVal.substring(hrefVal.lastIndexOf("/")+1);
								//		logger.debug("SITE RES ITEM" + fileResourceName);
								//		if(!(fileResourceName.endsWith(".html") || fileResourceName.endsWith(".htm")))
								//		{
											if(resElements != null){
												String fileName = ((Element)resElements.get(0)).attributeValue("href");
												logger.debug("fileName read now is:" + fileName);
												melContentData = meleteUtil.readFromFile(new File(unZippedDirPath + File.separator+ fileName));
												res_mime_type = fileName.substring(fileName.lastIndexOf(".")+1);
												res_mime_type = ContentTypeImageService.getContentType(res_mime_type);
												}

									//		logger.debug("first add resource" + fileResourceName);
											ResourcePropertiesEdit res = getMeleteCHService().fillInSectionResourceProperties(encodingFlag,fileResourceName,melResourceDescription);
											newResourceId = getMeleteCHService().addResourceItem(fileResourceName, res_mime_type,uploadCollId,melContentData,res );

											// this section points to the link location of added resource item
											String secondResName = getMeleteCHService().getResourceUrl(newResourceId);
									 		melContentData =secondResName.getBytes();
									 		res_mime_type=getMeleteCHService().MIME_TYPE_LINK;
									//	}
									}
									else
								  	{
								  	  res_mime_type=getMeleteCHService().MIME_TYPE_LINK;
									  melContentData = new byte[hrefVal.length()];
							          melContentData = hrefVal.getBytes();
								  	}
								}
								else
								{ //typeUpload resource
								  	res_mime_type = melResourceName.substring(melResourceName.lastIndexOf(".")+1);
								  	res_mime_type = ContentTypeImageService.getContentType(res_mime_type);

						 		  if (resElements != null)
						 		  {
						 			melContentData = meleteUtil.readFromFile(new File(unZippedDirPath + File.separator+ hrefVal));
						 		  }

								}
						 		ResourcePropertiesEdit res = getMeleteCHService().fillInSectionResourceProperties(encodingFlag,melResourceName,melResourceDescription);
						 		newResourceId = getMeleteCHService().addResourceItem(melResourceName, res_mime_type,uploadCollId,melContentData,res );
						 	} // catch end
						} // resHrefAttr check end
			}
		}//End for loop
	}

	/**
	 * Parses the manifest and build modules
	 *
	 * @param document document
	 * @param unZippedDirPath unZipped fiels Directory Path
	 * @exception throws exception
	 */
	public void parseAndBuildModules(Document document, String unZippedDirPath) throws Exception
	{
		if (logger.isDebugEnabled()) logger.debug("Entering parseAndBuildModules");

		Map uris = new HashMap();
		uris.put("imscp", DEFAULT_NAMESPACE_URI);
		uris.put("imsmd", IMSMD_NAMESPACE_URI);

		try
		{
			// organizations
			XPath xpath = document.createXPath("/imscp:manifest/imscp:organizations/imscp:organization");
			xpath.setNamespaceURIs(uris);

			Element eleOrg = (Element) xpath.selectSingleNode(document);

			// build module
			// loop thru organization elements - item elements
			List elements = eleOrg.elements();
			for (Iterator iter = elements.iterator(); iter.hasNext();)
			{
				Element element = (Element) iter.next();
				buildModule(element, document, unZippedDirPath,ToolManager.getCurrentPlacement().getContext() );

			}
			xpath = document.createXPath("/imscp:manifest/imscp:resources");
			xpath.setNamespaceURIs(uris);

			eleOrg = (Element) xpath.selectSingleNode(document);
			processManageResources(eleOrg, unZippedDirPath, ToolManager.getCurrentPlacement().getContext(), document);

		}
		catch (Exception e)
		{
			// no organization tag so create one flat module
			buildFlatModule(document, unZippedDirPath,ToolManager.getCurrentPlacement().getContext());
		}

		if (logger.isDebugEnabled()) logger.debug("Exiting parseAndBuildModules");
	}

	/*
	 * Builds one big module and each resource element becomes a section
	 */
	  private void buildFlatModule(Document document, String unZippedDirPath, String courseId) throws Exception
	  {
		  if (logger.isDebugEnabled())
				logger.debug("Entering buildFlatModule..." );

//			create module object
			Module module = new Module();
			module.setTitle("Untitled Module");
			module.setKeywords("Untitled Module");
			module.setDescription("    ");
			createModule(module, courseId);

			// read all resources tag and create section
			Map uris = new HashMap();
			uris.put("imscp", DEFAULT_NAMESPACE_URI);
			uris.put("imsmd", IMSMD_NAMESPACE_URI);

			// resources
			XPath xpath = document.createXPath("/imscp:manifest/imscp:resources");
			xpath.setNamespaceURIs(uris);

			Element eleAllResources = (Element) xpath.selectSingleNode(document);

			sectionUtil = new SubSectionUtilImpl();
			Document seqDocument = sectionUtil.createSubSection4jDOM();

			// build section
			// loop thru resources elements - resource elements
			List elements = eleAllResources.elements();
			for (Iterator iter = elements.iterator(); iter.hasNext();)
			{
				Element eleRes = (Element) iter.next();
				Section section = buildDefaultSection(module,addBlankSection(null, seqDocument));

				MeleteResource meleteResource= new MeleteResource();
				//default to no license
				meleteResource.setLicenseCode(RESOURCE_LICENSE_CODE);
				meleteResource.setCcLicenseUrl(RESOURCE_LICENSE_URL);

				Attribute resHrefAttr = eleRes.attribute("href");

				if (resHrefAttr != null)
				{
					String hrefVal = resHrefAttr.getValue();

					// check if file is missing
					if (hrefVal != null && hrefVal.length() != 0
							&& !(hrefVal.startsWith("http://") || hrefVal.startsWith("https://") || hrefVal.startsWith("mailto:")))
					{
						if (!meleteUtil.checkFileExists(unZippedDirPath + File.separator + hrefVal))
						{
							logger.info("content file for section is missing so move ON");
							return;
						}
					}
					// end missing file check

					List resElements = eleRes.elements();
					createContentResource(module, section, meleteResource, hrefVal, resElements, unZippedDirPath, courseId);

				} // resHrefAttr check end
			}
			// update module seqXml
			logger.debug("checking seqXML now at the end of buildModule process" + seqDocument.asXML());
			module.setSeqXml(seqDocument.asXML());
			moduleDB.updateModule(module);
	  }

	  /*
	   * build default section without reading ims item element
	   */
	  private Section buildDefaultSection(Module module, Element sectionElement) throws Exception
	  {
		  	String userId = UserDirectoryService.getCurrentUser().getEid();
			String firstName = UserDirectoryService.getCurrentUser().getFirstName();
			String lastName = UserDirectoryService.getCurrentUser().getLastName();

			Section section = new Section();
			section.setTextualContent(true);
			section.setCreatedByFname(firstName);
			section.setCreatedByLname(lastName);
			section.setContentType("notype");
			section.setTitle("Untitled Section");

			// save section object
			Integer new_section_id = sectionDB.addSection(module, section, true);
			section.setSectionId(new_section_id);
			sectionElement.addAttribute("id", new_section_id.toString());

			return section;
	  }

	/**
	 * Builds the module for each Item element under organization
	 *
	 * @param eleItem item element
	 * @exception throws exception
	 * revised by rashmi - change the whole structure of accessing elements
	 */
	private void buildModule(Element eleItem, Document document, String unZippedDirPath, String courseId)
	throws Exception {

		if (logger.isDebugEnabled())
			logger.debug("Entering buildModule..." );

//		create module object
		Module module = new Module();
		boolean moduleTitleFlag = false;
		if (eleItem.attribute("isvisible") != null)
		{
			if (((Attribute)eleItem.attribute("isvisible")).getValue().equals("false"))
			{
			CourseModule cmod = new CourseModule(courseId, -1, true, null, false, module);
			module.setCoursemodule(cmod);
			}
		}
		if (eleItem.elements("title") != null && eleItem.elements("title").size() != 0)
		{
			Element titleEle = (Element) eleItem.elements("title").get(0);
			if (titleEle != null)
			{
				String title = titleEle.getTextTrim();
				if (title != null && title.length() != 0)
				{
					module.setTitle(title);
					moduleTitleFlag = true;
				}
			}
		}
		if(!moduleTitleFlag) module.setTitle("Untitled Module");


		boolean keywords = false;
		boolean descr = false;
		if (eleItem.selectNodes("./imsmd:lom/imsmd:general") != null && eleItem.selectNodes("./imsmd:lom/imsmd:general").size() != 0)
		{
			Element generalElement = (Element) eleItem.selectNodes("./imsmd:lom/imsmd:general").get(0);
			List moduleMetadataList = generalElement.elements();
			for (Iterator iter = moduleMetadataList.iterator(); iter.hasNext();)
			{
				Element metaElement = (Element) iter.next();

				if (metaElement.getName().equals("description"))
				{
					String desc = metaElement.selectSingleNode(".//imsmd:langstring").getText();
					module.setDescription(desc.trim());
					descr = true;
				}

				if (metaElement.getName().equals("keyword"))
				{
					String modkeyword = metaElement.selectSingleNode(".//imsmd:langstring").getText();
					if (modkeyword != null)
					{
						module.setKeywords(modkeyword.trim());
						keywords = true;
					}
				}
			}
		}
		if (!keywords) module.setKeywords(module.getTitle());
		if (!descr) module.setDescription("    ");
		createModule(module, courseId);

// 		build sections
		try
		{
			sectionUtil = new SubSectionUtilImpl();
			Document seqDocument = sectionUtil.createSubSection4jDOM();

			for (Iterator iter = eleItem.elementIterator("item"); iter.hasNext();)
			{
				Element element = (Element) iter.next();

				if (element.attributeValue("identifier").startsWith("NEXTSTEPS"))
					buildWhatsNext(element, document, module, unZippedDirPath);
				else buildSection(element, document, module, addBlankSection(null, seqDocument), unZippedDirPath, seqDocument, courseId);
			}

			// update module seqXml
		//	logger.debug("checking seqXML now at the end of buildModule process" + seqDocument.asXML());
			module.setSeqXml(seqDocument.asXML());
			moduleDB.updateModule(module);
		}
		catch (Exception e)
		{
			e.printStackTrace();
			throw e;
		}
		if (logger.isDebugEnabled()) logger.debug("Exiting buildModule...");
	}

	private Element addBlankSection(Element parentElement, Document seqDocument)
	{
		if(parentElement == null)
			parentElement = seqDocument.getRootElement();
		Element newSectionElement = parentElement.addElement("section");
		return newSectionElement;
	}
	/*
	 * build license information
	 * add by rashmi
	 */

	private void buildLicenseInformation(MeleteResource meleteResource,String licenseUrl)
	{
		int lcode = RESOURCE_LICENSE_CODE ;

		if(licenseUrl.startsWith("Copyright (c)"))
		{
			 lcode = RESOURCE_LICENSE_COPYRIGHT_CODE;
			 // remove copyright(c) phrase
			 String otherInfo = licenseUrl.substring(13);
			 otherInfo = otherInfo.trim();
			 int commaPos = otherInfo.indexOf(",");
			 if (commaPos != -1)
			 {
				 processLicenseStr(otherInfo, meleteResource);
			 }

		}
		else if(licenseUrl.startsWith("Public Domain"))
		{
			lcode = RESOURCE_LICENSE_PD_CODE;
			int nameIdx = licenseUrl.indexOf(",");
			String licensename = licenseUrl.trim();
			if(nameIdx != -1)
			{
				 licensename = licenseUrl.substring(0,nameIdx) ;
				 String otherInfo = licenseUrl.substring(nameIdx +1);
				 otherInfo = otherInfo.trim();
				 if(otherInfo != null )
				 {
					 int commaPos = otherInfo.indexOf(",");
					 if (commaPos != -1)
					 {
						 processLicenseStr(otherInfo, meleteResource);
					 }
					 else
					 {
						 meleteResource.setCopyrightOwner(otherInfo);
					 }

			     }
			}
			CcLicense ccl = meleteLicenseDB.fetchCcLicenseUrl(licensename);
			licenseUrl = ccl.getUrl();

		}else if(licenseUrl.startsWith("Creative Commons"))
		{
			lcode = RESOURCE_LICENSE_CC_CODE;
			//remove "creative commons" phrase from the name
			licenseUrl = licenseUrl.substring(17);
			int nameIdx = licenseUrl.indexOf(",");
			String licensename = licenseUrl.trim();
			if(nameIdx != -1)
			{
				 licensename = licenseUrl.substring(0,nameIdx) ;
				 String otherInfo = licenseUrl.substring(nameIdx +1);
				 otherInfo = otherInfo.trim();
				 if(otherInfo != null )
				 {
					 int commaPos = otherInfo.indexOf(",");
					 if (commaPos != -1)
					 {
						 processLicenseStr(otherInfo, meleteResource);
					 }
					 else
					 {
						 meleteResource.setCopyrightOwner(otherInfo);
					 }

			      }
			}
			CcLicense ccl = meleteLicenseDB.fetchCcLicenseUrl(licensename);
			licenseUrl = ccl.getUrl();
			meleteResource.setReqAttr(true);
			meleteResource.setAllowCmrcl(ccl.isAllowCmrcl());
			meleteResource.setAllowMod(ccl.getAllowMod());

		}
			else if(licenseUrl.startsWith("Copyrighted Material"))
		{
			lcode = RESOURCE_LICENSE_FAIRUSE_CODE;
			int nameIdx = licenseUrl.indexOf(",");
			String licensename = licenseUrl.trim();
			if(nameIdx != -1)
			{
				 licensename = licenseUrl.substring(0,nameIdx) ;
				 String otherInfo = licenseUrl.substring(nameIdx +1);
				 otherInfo = otherInfo.trim();
				 if(otherInfo != null)
				 {
					 int commaPos = otherInfo.indexOf(",");
					 if (commaPos != -1)
					 {
					   processLicenseStr(otherInfo, meleteResource);
					 }
					 else
					 {
						 meleteResource.setCopyrightOwner(otherInfo);
					 }

			      }
			}
			licenseUrl = licensename;
		}

		meleteResource.setLicenseCode(lcode);
		meleteResource.setCcLicenseUrl(licenseUrl);
	}

	private void processLicenseStr(String otherInfo, MeleteResource meleteResource)
	{
		String firstStr=null, secondStr=null;
		int commaPos = otherInfo.indexOf(",");
		 while (commaPos != -1)
		   {
			 firstStr = otherInfo.substring(0,commaPos).trim();
			 secondStr = otherInfo.substring(commaPos+1).trim();
		    if (!(Character.isDigit(firstStr.charAt(firstStr.length()-1)))&&(Character.isDigit(secondStr.charAt(0))))
		     {
		       break;
		     }
		     else
		     {
		       commaPos = otherInfo.indexOf(",",commaPos+1);
		     }

		   }
		   meleteResource.setCopyrightOwner(firstStr);
		   meleteResource.setCopyrightYear(secondStr);
	}

	/*
	 * build whats next
	 * added by rashmi
	 */
	private void buildWhatsNext(Element eleItem,Document  document,Module module,String unZippedDirPath) throws Exception
	{
		Attribute identifierref = eleItem.attribute("identifierref");
		Element eleRes;

		if (identifierref != null) {
			eleRes = getResource(identifierref.getValue(), document);
			String hrefVal = eleRes.attributeValue("href");
			String nextsteps = new String(meleteUtil.readFromFile(new File(unZippedDirPath + File.separator+ hrefVal)));
			module.setWhatsNext(nextsteps);
			ModuleDateBean mdbean = new ModuleDateBean();
			mdbean.setModuleId(module.getModuleId().intValue());
			mdbean.setModule(module);
			mdbean.setModuleShdate(module.getModuleshdate());
			ArrayList mdbeanList = new ArrayList();
			mdbeanList.add(mdbean);
			moduleDB.updateModuleDateBeans(mdbeanList);
		}

	}

	private void mergeWhatsNext(Element eleItem,Document  document,Module module,String unZippedDirPath) throws Exception
	{
		Attribute identifierref = eleItem.attribute("identifierref");
		Element eleRes;

		if (identifierref != null) {
			eleRes = getMergeResource(identifierref.getValue(), document);
			String hrefVal = eleRes.attributeValue("href");
			String nextsteps = new String(meleteUtil.readFromFile(new File(unZippedDirPath + File.separator+ hrefVal)));
			module.setWhatsNext(nextsteps);
			moduleDB.updateModule(module);
		}

	}
	/**
	 * creates the module
	 * @param module Module
	 */
	private void createModule(Module module, String courseId)throws Exception {
		if (logger.isDebugEnabled())
			logger.debug("Entering createModule...");

		String userId = UserDirectoryService.getCurrentUser().getId();
		String firstName = UserDirectoryService.getCurrentUser()
				.getFirstName();
		String lastName = UserDirectoryService.getCurrentUser()
				.getLastName();

		module.setUserId(userId);
		module.setCreatedByFname(firstName);
		module.setCreatedByLname(lastName);
		module.setModuleshdate(getModuleShdates());
		if (module.getCoursemodule() != null)
		{
			if (module.getCoursemodule().isArchvFlag() == true)
		   {
			CourseModule cmod = new CourseModule(courseId, -1, true, null, false, module);

			moduleDB.addArchivedModule(module, getModuleShdates(), userId, courseId, (CourseModule)module.getCoursemodule());
	       }
		}
		else
		{
			moduleDB.addModule(module, getModuleShdates(), userId, courseId);
		}
		if (logger.isDebugEnabled())
			logger.debug("Exiting createModule...");
	}

	/**
	 * Builds section for each item under module item
	 * @param eleItem item element
	 * @param document document
	 * @param module Module
	 * @throws Exception
	 */
	private void buildSection(Element eleItem, Document document, Module module, Element seqElement, String unZippedDirPath, Document seqDocument, String courseId)
			throws Exception {
		if (logger.isDebugEnabled())
			logger.debug("Entering buildSection...");

		Attribute identifier = eleItem.attribute("identifier");
	//	logger.debug("importing ITEM " + identifier.getValue());

		Attribute identifierref = eleItem.attribute("identifierref");
		Element eleRes;

		Section section = new Section();
		MeleteResource meleteResource = new MeleteResource();
		boolean sectionTitleFlag = false;
		boolean sectionCopyrightFlag= false;

		List elements = eleItem.elements();
		for (Iterator iter = elements.iterator(); iter.hasNext();) {
			Element element = (Element) iter.next();

			//title
			if (element.getQualifiedName().equalsIgnoreCase("title")) {
				section.setTitle(element.getTextTrim());
				sectionTitleFlag = true;
			}
			//item
			else if (element.getQualifiedName().equalsIgnoreCase("item")) {
				//call recursive here
				buildSection(element,document, module, addBlankSection(seqElement, seqDocument), unZippedDirPath, seqDocument, courseId);
			}
			//metadata
			else if (element.getQualifiedName().equalsIgnoreCase("imsmd:lom")){
				// section instructions
				Element DescElement = null;
				if(eleItem.selectNodes("./imsmd:lom/imsmd:general/imsmd:description") != null && (eleItem.selectNodes("./imsmd:lom/imsmd:general/imsmd:description").size() != 0))
					DescElement = (Element)eleItem.selectNodes("./imsmd:lom/imsmd:general/imsmd:description").get(0);

					if(DescElement != null)
					{
					String instr = DescElement.selectSingleNode( ".//imsmd:langstring").getText();
					section.setInstr(instr.trim());
					}

					//				 read license information
				Element rightsElement = null;
				if(eleItem.selectNodes("./imsmd:lom/imsmd:rights") != null && (eleItem.selectNodes("./imsmd:lom/imsmd:rights").size() != 0))
		            rightsElement = (Element)eleItem.selectNodes("./imsmd:lom/imsmd:rights").get(0);

					if(rightsElement != null)
					{
					Element licenseElement = rightsElement.element("description");
					String licenseUrl = licenseElement.selectSingleNode( ".//imsmd:langstring").getText();
					if(licenseUrl != null)
						buildLicenseInformation(meleteResource,licenseUrl);
						sectionCopyrightFlag = true;
					}
				}
			// license end
		}
		// other attributes
	//	logger.debug("setting section attribs");
		String userId = UserDirectoryService.getCurrentUser().getEid();
		String firstName = UserDirectoryService.getCurrentUser().getFirstName();
		String lastName = UserDirectoryService.getCurrentUser().getLastName();

		section.setTextualContent(true);
		section.setCreatedByFname(firstName);
		section.setCreatedByLname(lastName);
		section.setContentType("notype");

		if(!sectionTitleFlag)section.setTitle("Untitled Section");

		//default to no license
		if(!sectionCopyrightFlag)
		{
			meleteResource.setLicenseCode(RESOURCE_LICENSE_CODE);
			meleteResource.setCcLicenseUrl(RESOURCE_LICENSE_URL);
		}
		// save section object
		Integer new_section_id = sectionDB.addSection(module, section, true);
		section.setSectionId(new_section_id);
		seqElement.addAttribute("id", new_section_id.toString());

		// now melete resource object
		if (identifierref != null)
		{
			eleRes = getResource(identifierref.getValue(), document);
			if (eleRes != null)
			{
				Attribute resHrefAttr = eleRes.attribute("href");

				if (resHrefAttr != null)
				{
					String hrefVal = resHrefAttr.getValue();
					// logger.debug("hrefVal:" + hrefVal);
					// check if file is missing
					if (hrefVal != null && hrefVal.length() != 0
							&& !(hrefVal.startsWith("http://") || hrefVal.startsWith("https://") || hrefVal.startsWith("mailto:")))
					{
						if (!meleteUtil.checkFileExists(unZippedDirPath + File.separator + hrefVal))
						{
							logger.info("content file for section is missing so move ON");
							return;
						}
					}
					// end missing file check

					// create meleteResourceObject
					List resElements = eleRes.elements();
					createContentResource(module, section, meleteResource, hrefVal, resElements, unZippedDirPath, courseId);

				} // resHrefAttr check end
			}
		}

		if (logger.isDebugEnabled()) logger.debug("Exiting buildSection...");
	}

	/**
	 * Builds section for each item under module item
	 * @param eleItem item element
	 * @param document document
	 * @param module Module
	 * @throws Exception
	 */
	private void mergeSection(Element eleItem, Document document, Module module, Element seqElement,String unZippedDirPath, Document seqDocument, String courseId)
			throws Exception {
		if (logger.isDebugEnabled()) logger.debug("Entering mergeSection...");

		Attribute identifier = eleItem.attribute("identifier");
		// // logger.debug("importing ITEM " + identifier.getValue());

		Attribute identifierref = eleItem.attribute("identifierref");
		Element eleRes;

		Section section = new Section();
		MeleteResource meleteResource = new MeleteResource();
		boolean sectionTitleFlag = false;
		boolean sectionCopyrightFlag = false;

		List elements = eleItem.elements();
		for (Iterator iter = elements.iterator(); iter.hasNext();)
		{
			Element element = (Element) iter.next();

			// title
			if (element.getQualifiedName().equalsIgnoreCase("title"))
			{
				section.setTitle(element.getTextTrim());
				sectionTitleFlag = true;
			}
			// item
			else if (element.getQualifiedName().equalsIgnoreCase("item"))
			{
				// call recursive here
				buildSection(element, document, module, addBlankSection(seqElement, seqDocument), unZippedDirPath, seqDocument, courseId);
			}
			// metadata
			else if (element.getName().equalsIgnoreCase("imsmd:lom"))
			{
				// section instructions
				List<Element> modulegeneralList = element.elements();
				List moduleMetadataList = modulegeneralList.get(0).elements();

				for (Iterator iter2 = moduleMetadataList.iterator(); iter2.hasNext();)
				{
					Element metaElement = (Element) iter2.next();

					if (metaElement.getName().equals("imsmd:description") && metaElement.element("imsmd:langstring") != null)
					{
						String instr = metaElement.element("imsmd:langstring").getText();
						section.setInstr(instr.trim());
					}
				}

				// read license information
				if(modulegeneralList.size() > 1)
				{
				List rightList = modulegeneralList.get(1).elements();
				for (Iterator iter3 = rightList.iterator(); iter3.hasNext();)
				{
					Element rightsElement = (Element) iter3.next();

					if (rightsElement.getName().equals("imsmd:description") && rightsElement.element("imsmd:langstring") !=null )
					{
						String licenseUrl = rightsElement.element("imsmd:langstring").getText();
						if (licenseUrl != null)
						{
							buildLicenseInformation(meleteResource, licenseUrl);
							sectionCopyrightFlag = true;
						}
					}
				 }
				}
			 }
			// license end
		}
		// other attributes
		// logger.debug("setting section attribs");
		String userId = UserDirectoryService.getCurrentUser().getEid();
		String firstName = UserDirectoryService.getCurrentUser().getFirstName();
		String lastName = UserDirectoryService.getCurrentUser().getLastName();

		section.setTextualContent(true);
		section.setCreatedByFname(firstName);
		section.setCreatedByLname(lastName);
		section.setContentType("notype");

		if (!sectionTitleFlag) section.setTitle("Untitled Section");

		// default to no license
		if (!sectionCopyrightFlag)
		{
			meleteResource.setLicenseCode(RESOURCE_LICENSE_CODE);
			meleteResource.setCcLicenseUrl(RESOURCE_LICENSE_URL);
		}
		// save section object
		Integer new_section_id = sectionDB.addSection(module, section, true);
		section.setSectionId(new_section_id);
		seqElement.addAttribute("id", new_section_id.toString());

		// now melete resource object
		if (identifierref != null)
		{
			eleRes = getMergeResource(identifierref.getValue(), document);
			if (eleRes != null)
			{
				Attribute resHrefAttr = eleRes.attribute("href");

				if (resHrefAttr != null)
				{
					String hrefVal = resHrefAttr.getValue();

					// check if file is missing
					if (hrefVal != null && hrefVal.length() != 0
							&& !(hrefVal.startsWith("http://") || hrefVal.startsWith("https://") || hrefVal.startsWith("mailto:")))
					{
						if (!meleteUtil.checkFileExists(unZippedDirPath + File.separator + hrefVal))
						{
							logger.info("content file for section is missing so move ON");
							return;
						}
					}
					// end missing file check

					// create meleteResourceObject
					List resElements = eleRes.elements();
					createContentResource(module, section, meleteResource, hrefVal, resElements, unZippedDirPath, courseId);

				} // resHrefAttr check end
			}
		}

		if (logger.isDebugEnabled()) logger.debug("Exiting mergeSection...");
	}



	/**
	 * creates section dependent file
	 *
	 * @param hrefVal
	 *        href value of the item
	 */
	private String uploadSectionDependentFile(String hrefVal, String courseId, boolean imsImport, String unZippedDirPath) {
		try {
			String filename = null;
			String res_mime_type = null;
			byte[] melContentData = null;

			if (hrefVal.lastIndexOf('/') != -1)
				filename = hrefVal.substring( hrefVal.lastIndexOf('/') + 1);

			if (filename != null && filename.trim().length() > 0){

				try{
					String checkResourceId = Entity.SEPARATOR + "private" + Entity.SEPARATOR + "meleteDocs" +Entity.SEPARATOR+courseId+Entity.SEPARATOR+"uploads"+Entity.SEPARATOR+filename;
					// logger.debug("looking for resource in uploadsectiondep" + checkResourceId);
					getMeleteCHService().checkResource(checkResourceId);

					// 	found it so return it
					return getMeleteCHService().getResourceUrl(checkResourceId);
				}catch (IdUnusedException ex)
				{
					//find mime type and get name and contents
					if (imsImport)
					{
						//This is executed by IMP import
						melContentData = meleteUtil.readFromFile(new File(unZippedDirPath + File.separator
								+ hrefVal));
					}
					else
					{
						//This is executed by import from site
						// logger.debug("reading resource properties in import from site");
						ContentResource cr = getMeleteCHService().getResource(hrefVal);
						melContentData = cr.getContent();
					}
					return addResource(filename, melContentData, courseId);
				}
				catch(Exception e)
				{
					logger.debug(e.toString());
				}
			}
		} catch (Exception e) {
			if (logger.isErrorEnabled())
				logger.error("ImportMeleteModules : uploadSectionDependentFile() :"+ e.toString());
		}
		return "";
	}

	private String addResource(String filename, byte[] melContentData, String courseId) throws Exception
	{
		// logger.debug("adding resource through addresource()" + filename);
		addToThreadList(filename,"MELETE_secondaryHTMLResources");
		String uploadCollId = getMeleteCHService().getUploadCollectionId(courseId);
 		String res_mime_type = filename.substring(filename.lastIndexOf(".")+1);
		res_mime_type = ContentTypeImageService.getContentType(res_mime_type);

 		 ResourcePropertiesEdit res = getMeleteCHService().fillEmbeddedImagesResourceProperties(filename);
 		 String newResourceId = getMeleteCHService().addResourceItem(filename, res_mime_type,uploadCollId,melContentData,res);
 		 // create melete resource object
		  MeleteResource meleteResource = new MeleteResource();
     	 meleteResource.setResourceId(newResourceId);
     	 //set default license info to "I have not determined copyright yet" option
     	 meleteResource.setLicenseCode(0);
     	 sectionDB.insertResource(meleteResource);
     	return getMeleteCHService().getResourceUrl(newResourceId);
	}
	/**
	 * creates the section
	 * @param module Module
	 * @param section Section
	 * @param hrefVal href value of the item
	 * @return @throws
	 *         MalformedURLException
	 * @throws UnknownHostException
	 * @throws MeleteException
	 * @throws Exception
	 */
	private void createContentResource(Module module,Section section,MeleteResource meleteResource, String hrefVal,List resElements, String unZippedDirPath, String courseId)
	throws MalformedURLException, UnknownHostException, MeleteException, Exception {
		String melResourceName = null;
		String melResourceDescription = null;
		String res_mime_type = null;
		byte[] melContentData = null;
		boolean encodingFlag = false;
		String newResourceId = "";
		String fromCRName = null;

		if (logger.isDebugEnabled())
			logger.debug("Entering createSection...");

		//This code fixes resource description transfer for import from site
		if (resElements == null)
		{
			 ContentResource cr = getMeleteCHService().getResource(hrefVal);
		     if (cr == null) return;
		     melResourceDescription = cr.getProperties().getProperty(ResourceProperties.PROP_DESCRIPTION);
		     if (section.getContentType().equals("typeLink"))
		     {
		    	 hrefVal = new String(cr.getContent());
		    	 fromCRName = cr.getProperties().getProperty(ResourceProperties.PROP_DISPLAY_NAME);
		     }

		}//End code

		//html file
		if (!(hrefVal.startsWith("http://") || hrefVal.startsWith("https://") || hrefVal.startsWith("mailto:"))&&
				(hrefVal.lastIndexOf('/') != -1 && hrefVal.substring(hrefVal.lastIndexOf('/') +1).startsWith("Section"))
				 && (hrefVal.lastIndexOf('.') != -1	&& (hrefVal.substring(hrefVal.lastIndexOf('.') + 1).equalsIgnoreCase("html")
				|| hrefVal.substring(hrefVal.lastIndexOf('.') + 1).equalsIgnoreCase("htm")))) {
			//This is for typeEditor sections
			section.setContentType("typeEditor");
			res_mime_type= getMeleteCHService().MIME_TYPE_EDITOR;
			String contentEditor = null;

			String addCollId = "";
			if (resElements != null)
			{
                //This part called by IMS import
				contentEditor = new String(meleteUtil.readFromFile(new File(unZippedDirPath + File.separator + hrefVal)));
//				 create objects for embedded images
				ArrayList content = createContentFile(contentEditor, (Module)module, (Section)section, resElements, unZippedDirPath, courseId, new HashSet<String>(),null);
				contentEditor = (String)content.get(0);
				addCollId = getMeleteCHService().getCollectionId(section.getContentType(), module.getModuleId());
			}
			else
			{
				//This part called by import from site
				  ContentResource cr = getMeleteCHService().getResource(hrefVal);
				  contentEditor = new String(cr.getContent());
				   ArrayList content = createContentFile(contentEditor, (Module)module, (Section)section, null, unZippedDirPath, courseId,new HashSet<String>() ,null);
				  contentEditor = (String)content.get(0);
				  addCollId = getMeleteCHService().getCollectionId(courseId, section.getContentType(), module.getModuleId());
			}

             melContentData = new byte[contentEditor.length()];
             melContentData = contentEditor.getBytes();
             encodingFlag = true;
             melResourceName = "Section_" + section.getSectionId().toString();
             melResourceDescription="compose content";
             // no need to perform check just add it for section_xxx.html files

             ResourcePropertiesEdit res = getMeleteCHService().fillInSectionResourceProperties(encodingFlag,melResourceName,melResourceDescription);
             newResourceId = getMeleteCHService().addResourceItem(melResourceName, res_mime_type,addCollId,melContentData,res );
 			 meleteResource.setResourceId(newResourceId);
 			 sectionDB.insertMeleteResource((Section)section, (MeleteResource)meleteResource);
 			 return;
		}

			//This part is executed by both IMS import and import from site

			if (hrefVal.startsWith("http://") || hrefVal.startsWith("https://") || hrefVal.startsWith("mailto:")) {
//				link
				section.setContentType("typeLink");
				//The statement below means- for IMS import all link sections
				//are opened in a new window. For Import from site, they preserve
				//the setting in the site being imported from
				if (resElements != null) section.setOpenWindow(true);
				// get url title if provided in IMS
				String urlTitle = "";
				if(resElements != null)
				 {
					for(int i=0; i < resElements.size(); i++)
					{
						Element urlTitleElement = (Element)resElements.get(i);
						if(urlTitleElement.getQualifiedName().equalsIgnoreCase("imsmd:title")){
							urlTitle = urlTitleElement.selectSingleNode( ".//imsmd:langstring").getText();
							break;
						}
					}
				 } else {
					// Import from Site
					if(!hrefVal.equals(fromCRName))
						urlTitle = fromCRName;
				 }

				// make last part of link as title
				if(urlTitle.equals(""))
				{
					urlTitle = hrefVal.substring(hrefVal.lastIndexOf("/")+1);
					if(urlTitle == null || urlTitle.length() == 0)
					{
						urlTitle = hrefVal.substring(0,hrefVal.lastIndexOf("/"));
						urlTitle = urlTitle.substring(urlTitle.lastIndexOf("/")+1);
					}

				}
				melResourceName = urlTitle;
			}
			else
           		{
				// uploaded file
				boolean contentSet = false;
				melResourceName = hrefVal.substring(hrefVal.lastIndexOf("/") + 1);
				// Check if this is coming in from IMS Import
				if (resElements != null)
				{
                			//Load up the resource to look at it
					String contentEditor = new String(meleteUtil.readFromFile(new File(unZippedDirPath + File.separator + hrefVal)));
					if ( isLTIDocument(contentEditor) ) {
						section.setContentType("typeLTI");
						contentSet = true;
					}
					String urlTitle = null;
					for(int i=0; i < resElements.size(); i++)
					{
						Element urlTitleElement = (Element)resElements.get(i);
						if(urlTitleElement.getQualifiedName().equalsIgnoreCase("imsmd:title")){
							urlTitle = urlTitleElement.selectSingleNode( ".//imsmd:langstring").getText();
						}
					}
					if ( urlTitle != null ) melResourceName = urlTitle;
				}
				if ( ! contentSet ) section.setContentType("typeUpload");
			}

			// read resource description
			if (resElements != null)
			{
				for (int i = 0; i < resElements.size(); i++)
				{
					Element resDescElement = (Element) resElements.get(i);
					if (resDescElement.getQualifiedName().equalsIgnoreCase("imsmd:description"))
					{
						melResourceDescription = resDescElement.selectSingleNode(".//imsmd:langstring").getText();
						break;
					}
				}
			}
			 // Everything here is going to uploads collection
			try{
				// check if the item has already been imported to this site (in uploads collection)
				addToThreadList(melResourceName, "MELETE_importResources");
		 		String checkResourceId = "/private/meleteDocs/"+courseId+"/uploads/"+melResourceName;
		 		getMeleteCHService().checkResource(checkResourceId);
		 		meleteResource.setResourceId(checkResourceId);		 				 		
		 		sectionDB.insertSectionResource((Section)section, (MeleteResource)meleteResource);
			 	}catch (IdUnusedException ex)
				{
			 		// actual insert
			 		// if not found in meleteDocs collection include it
			 		String uploadCollId = getMeleteCHService().getUploadCollectionId(courseId);

				  	// data is generally large so read it only if need to insert
					if(section.getContentType().equals("typeLink"))
					{
//					 	 link points to Site Resources item so move it to MeleteDocs collection
						if(hrefVal.indexOf("/access/content/group") != -1 || hrefVal.indexOf("/access/meleteDocs") != -1)
						{
							String fileResourceName= hrefVal.substring(hrefVal.lastIndexOf("/")+1);
							// logger.debug("SITE RES ITEM" + fileResourceName);
					  			if(resElements != null){
									String fileName = ((Element)resElements.get(0)).attributeValue("href");
									// logger.debug("fileName read now is:" + fileName);
									melContentData = meleteUtil.readFromFile(new File(unZippedDirPath + File.separator+ fileName));
									res_mime_type = fileName.substring(fileName.lastIndexOf(".")+1);
									res_mime_type = ContentTypeImageService.getContentType(res_mime_type);
									}
								else
						 		  {
						 			//This is executed by import from site
						 			String findEntity = hrefVal.substring(hrefVal.indexOf("/access")+7);
									Reference ref = EntityManager.newReference(findEntity);
									String ref_id = ref.getId();
									// logger.debug("ref properties" + ref.getType() +"," +ref.getId());
									if(ref.getType().equals("sakai:meleteDocs"))
										ref_id = ref_id.substring(ref_id.indexOf("/content")+ 8);
						 			ContentResource cr = getMeleteCHService().getResource(ref_id);
									melContentData = cr.getContent();
									res_mime_type = cr.getContentType();
						 		  }
								try
								{
									String checkResourceId = "/private/meleteDocs/"+courseId+"/uploads/"+fileResourceName;
		 							getMeleteCHService().checkResource(checkResourceId);
		 							newResourceId = checkResourceId;
								}
								catch(IdUnusedException iue)
								{
								// logger.debug("first add resource" + fileResourceName);
								ResourcePropertiesEdit res = getMeleteCHService().fillInSectionResourceProperties(encodingFlag,fileResourceName,melResourceDescription);
								//Add to the list
								addToThreadList(fileResourceName, "MELETE_secondaryHTMLResources");
								newResourceId = getMeleteCHService().addResourceItem(fileResourceName, res_mime_type,uploadCollId,melContentData,res );
								MeleteResource firstResource = new MeleteResource();
								firstResource.setResourceId(newResourceId);
				            	sectionDB.insertResource(firstResource);
								}
								// this section points to the link location of added resource item
								String secondResName = getMeleteCHService().getResourceUrl(newResourceId);
						 		melContentData =secondResName.getBytes();
						 		res_mime_type=getMeleteCHService().MIME_TYPE_LINK;

						}
						else
					  	{
					  	  res_mime_type=getMeleteCHService().MIME_TYPE_LINK;
						  melContentData = new byte[hrefVal.length()];
				          melContentData = hrefVal.getBytes();
					  	}
					}
					if (section.getContentType().equals("typeUpload") || section.getContentType().equals("typeLTI"))
					{
					  if ( section.getContentType().equals("typeLTI") )
					  {
					  	res_mime_type = getMeleteCHService().MIME_TYPE_LTI;
					  }
					  else
					  {
					  	res_mime_type = melResourceName.substring(melResourceName.lastIndexOf(".")+1);
					  	res_mime_type = ContentTypeImageService.getContentType(res_mime_type);
					  }
			 		  if (resElements != null)
			 		  {
			 			melContentData = meleteUtil.readFromFile(new File(unZippedDirPath + File.separator+ hrefVal));
			 		  }
			 		  else
			 		  {
			 			//This is executed by import from site
			 			// logger.debug("reading resource properties in import from site");
			 			ContentResource cr = getMeleteCHService().getResource(hrefVal);
						melContentData = cr.getContent();
				  		res_mime_type = cr.getContentType();
						if ( getMeleteCHService().MIME_TYPE_LTI.equals(res_mime_type) ) {
							section.setContentType("typeLTI");
						}
			 		  }
					}
			 		// logger.debug("add resource type="+res_mime_type+" name=" + melResourceName);
			 		ResourcePropertiesEdit res = getMeleteCHService().fillInSectionResourceProperties(encodingFlag,melResourceName,melResourceDescription);
			 		addToThreadList(melResourceName, "MELETE_secondaryHTMLResources");
			 		newResourceId = getMeleteCHService().addResourceItem(melResourceName, res_mime_type,uploadCollId,melContentData,res );
			 		meleteResource.setResourceId(newResourceId);
			 		sectionDB.insertMeleteResource((Section)section, (MeleteResource)meleteResource);
				} // catch end

		if (logger.isDebugEnabled())
			logger.debug("Exiting createSection...");
	}

	private boolean isLTIDocument(String content)
	{
		return ( content != null && content.startsWith("<?xml version=\"1.0\" encoding=\"UTF-8\"?>")
                         && content.indexOf("<toolInstance") > 0 && content.indexOf("</toolInstance>") > 0 ) ;
	}

	/* @param document document
	 * @return resource element
	 * @throws Exception
	 */
	private Element getResource(String resName, Document document)
			throws Exception {
		if (logger.isDebugEnabled())
			logger.debug("Entering getResource...");

		Map uris = new HashMap();
		uris.put("imscp", DEFAULT_NAMESPACE_URI);
		uris.put("imsmd", IMSMD_NAMESPACE_URI);

		//resource
		XPath xpath = document
				.createXPath("/imscp:manifest/imscp:resources/imscp:resource[@identifier = '"
						+ resName + "']");
		xpath.setNamespaceURIs(uris);

		Element eleRes = (Element) xpath.selectSingleNode(document);

		if (logger.isDebugEnabled())
			logger.debug("Exiting getResource...");

		return eleRes;
	}

	private Element getMergeResource(String resName, Document document) throws Exception
	{
		if (logger.isDebugEnabled()) logger.debug("Entering getResource...");

		Map uris = new HashMap();
		uris.put("imscp", DEFAULT_NAMESPACE_URI);
		uris.put("imsmd", IMSMD_NAMESPACE_URI);

		// resource
		XPath xpath = document.createXPath("//resource[@identifier = '" + resName + "']");
		xpath.setNamespaceURIs(uris);

		Element eleRes = (Element) xpath.selectSingleNode(document);

		if (logger.isDebugEnabled()) logger.debug("Exiting getResource...");

		return eleRes;
}


	/**
	 *
	 * create an instance of moduleshdates. Revised to open a course for one
	 * year by default --Rashmi 12/6 Revised on 12/20 Rashmi to set start
	 * default time as 8:00 am and end date time as 11:59 pm
	 */
	private ModuleShdates getModuleShdates() {
		if (moduleShdates == null) {
			moduleShdates = new ModuleShdates();
			//comment code below to not assign any dates on IMS CP import
	/*		GregorianCalendar cal = new GregorianCalendar();
			cal.set(Calendar.HOUR, 8);
			cal.set(Calendar.MINUTE, 0);
			cal.set(Calendar.SECOND, 0);
			cal.set(Calendar.AM_PM, Calendar.AM);
			moduleShdates.setStartDate(cal.getTime());
			cal.add(Calendar.YEAR, 1);
			cal.set(Calendar.HOUR, 11);
			cal.set(Calendar.MINUTE, 59);
			cal.set(Calendar.SECOND, 0);
			cal.set(Calendar.AM_PM, Calendar.PM);
			moduleShdates.setEndDate(cal.getTime());*/
		}
		return moduleShdates;
	}

	/**
	 *
	 * uploaded or new content written file is temp stored at c:\\uploads.
	 * filename format of temporary file is moduleidSectionTitle.html later on,
	 * when saving module, this file will be stored under right directory
	 * structure under module dir with name as section_"seq".html
	 *
	 * IMP NOTE: NEED TO READ IP ADDRESS FROM SESSION OR SOMEWHERE ELSE
	 */
	private ArrayList createContentFile(String contentEditor, Module module, Section section, List resElements, String unZippedDirPath, String courseId, Set<String> checkEmbedHTMLResources, String parentRef)throws Exception{
		//save uploaded img inside content editor to destination directory
		String checkforimgs = contentEditor;
		int imgindex = -1;
		String imgSrcPath, imgName, imgLoc;

		int startSrc =0;
		int endSrc = 0;

		while (checkforimgs != null) {
			ArrayList embedData = meleteUtil.findEmbedItemPattern(checkforimgs);
			checkforimgs = (String)embedData.get(0);
			if (embedData.size() > 1)
			{
				startSrc = ((Integer)embedData.get(1)).intValue();
				endSrc = ((Integer)embedData.get(2)).intValue();
			}
			if (endSrc <= 0) break;

			imgSrcPath = checkforimgs.substring(startSrc, endSrc);

			// changed on 10/16/06 - add https condition too
			if (resElements != null)
			{
				//This part executed by IMS import
				if (!(imgSrcPath.startsWith("http://")|| imgSrcPath.startsWith("https://")) )
				{
					// if img src is in library or any other inside sakai path then don't process
					if(!imgSrcPath.startsWith("/"))
					{
						checkforimgs = checkforimgs.substring(endSrc);
						String imgActualPath="";
						for (Iterator iter = resElements.iterator(); iter.hasNext();) {
							Element element = (Element) iter.next();
							if (element.getQualifiedName().equalsIgnoreCase("file")) {
								Attribute hrefAttr = element.attribute("href");
								if ((hrefAttr.getValue().indexOf(imgSrcPath)) != -1)
								{
									imgActualPath = hrefAttr.getValue().trim();
									break;
								}
							}
						}

						if(imgActualPath == null || imgActualPath.length() == 0)
						{
							imgindex = -1;
							startSrc=0; endSrc = 0;
							continue;
						}

						//look for embedded data within resources html file
						if(imgSrcPath.endsWith(".htm") || imgSrcPath.endsWith(".html"))
						{
							if(!checkEmbedHTMLResources.contains(imgActualPath)) {
								checkEmbedHTMLResources.add(imgActualPath);
								File f = new File(unZippedDirPath + File.separator + imgActualPath);
								if(f.isFile())
								{
									String embedContentData = new String(meleteUtil.readFromFile(f));
									ArrayList contentData = createContentFile(embedContentData, module, section, resElements, unZippedDirPath, courseId, checkEmbedHTMLResources,null);
									embedContentData = (String)contentData.get(0);
									checkEmbedHTMLResources = (Set)contentData.get(1);
									String filename = imgActualPath.substring( imgActualPath.lastIndexOf('/') + 1);
									try
									{
										String checkResourceId = Entity.SEPARATOR + "private" + Entity.SEPARATOR + "meleteDocs" +Entity.SEPARATOR+courseId+Entity.SEPARATOR+"uploads"+Entity.SEPARATOR+filename;
										getMeleteCHService().checkResource(checkResourceId);
									}catch (IdUnusedException ex)
									{
										addResource(filename, embedContentData.getBytes(), courseId);
									}
									catch(Exception e){
										logger.debug("error adding a secondary html resource on ims import");
									}
								}
							} else
							{
								// logger.debug("already processed file" + imgActualPath);
								imgindex = -1;
								startSrc=0; endSrc = 0;
								String replacementStr = "/access/meleteDocs/content/private/meleteDocs/" + courseId + "/uploads/" + imgSrcPath.substring(imgSrcPath.lastIndexOf('/') + 1);
								String patternStr = imgSrcPath;
								contentEditor = meleteUtil.replace(contentEditor,patternStr, replacementStr);
								continue;
							}
						}
						contentEditor = ReplaceEmbedMediaWithResourceURL(contentEditor, imgSrcPath, imgActualPath, courseId, true, unZippedDirPath);
					} // if check for images
				} //if http check end
			}//IMS import (original code) ends here
			else
			{
				//This part executed by import from site
				String imgActualPath = "";

				//make it full url
				if(imgSrcPath.indexOf("://") == -1 && imgSrcPath.indexOf("/") == -1)
				{
					if(parentRef != null)
					{
						contentEditor = meleteUtil.replace(contentEditor,imgSrcPath, parentRef + imgSrcPath);
						imgSrcPath = parentRef + imgSrcPath;
					}
				}
				// if img src is in library or any other inside sakai path then don't process
				if(imgSrcPath.indexOf("/access") !=-1)
				{
					String findEntity = imgSrcPath.substring(imgSrcPath.indexOf("/access")+7);
					Reference ref = EntityManager.newReference(findEntity);
					// logger.debug("ref properties" + ref.getType() +"," +ref.getId());

					if(ref.getType().equals(ContentHostingService.APPLICATION_ID) || ref.getType().equals(MeleteSecurityService.APPLICATION_ID))
					{
						if(ref.getType().equals(ContentHostingService.APPLICATION_ID) && ref.getId().startsWith("/group"))
						{
							//							Item resides in resources
							checkforimgs = checkforimgs.substring(endSrc);
							imgActualPath = ref.getId();
						}
						if (ref.getType().equals(MeleteSecurityService.APPLICATION_ID))
						{

							//Item resides in meleteDocs, so need not check under resources
							checkforimgs = checkforimgs.substring(endSrc);
							imgActualPath = ref.getId().replaceFirst("/content","");
						}

						String importResName = imgActualPath.substring(imgActualPath.lastIndexOf('/')+1);
						addToThreadList(importResName, "MELETE_importResources");

						if(ref.getId().endsWith(".htm") || ref.getId().endsWith(".html"))
						{
							// if not processed yet then add to the set
							if(checkEmbedHTMLResources.contains(imgActualPath)) {
								logger.debug("FOUND ALREADY PROCESSED HTML FILE" + imgActualPath);
								addToThreadList(importResName, "MELETE_secondaryHTMLResources");
								imgindex = -1;
								startSrc=0; endSrc = 0;
								String replacementStr = "/access/meleteDocs/content/private/meleteDocs/" + courseId + "/uploads/" + imgSrcPath.substring( imgSrcPath.lastIndexOf('/') + 1);
								String patternStr = imgSrcPath;
								contentEditor = meleteUtil.replace(contentEditor,patternStr, replacementStr);
								continue;
							}
							checkEmbedHTMLResources.add(imgActualPath);
							// look for its embedded data
							ContentResource embedResource = getMeleteCHService().getResource(imgActualPath);
							if(embedResource.getContentLength() > 0)
							{
								String moreContentData = new String(embedResource.getContent());
								String parentStr = "/access/content" + ref.getId().substring(0,ref.getId().lastIndexOf("/")+1);
								ArrayList contentData = createContentFile(moreContentData, module, section, null, unZippedDirPath, courseId,checkEmbedHTMLResources,parentStr);
								moreContentData = (String)contentData.get(0);
								checkEmbedHTMLResources = (Set)contentData.get(1);
								String filename = imgActualPath.substring( imgActualPath.lastIndexOf('/') + 1);
								try
								{
									String checkResourceId = Entity.SEPARATOR + "private" + Entity.SEPARATOR + "meleteDocs" +Entity.SEPARATOR+courseId+Entity.SEPARATOR+"uploads"+Entity.SEPARATOR+filename;
									getMeleteCHService().checkResource(checkResourceId);
								}catch (IdUnusedException ex)
								{
									addResource(filename, moreContentData.getBytes(), courseId);
								}
								catch(Exception e){
									logger.debug("error adding a resource on import from site");
								}
							}
						}
						contentEditor = ReplaceEmbedMediaWithResourceURL(contentEditor, imgSrcPath, imgActualPath, courseId, false, unZippedDirPath);

					}
					// for other inside sakai paths
					else checkforimgs = checkforimgs.substring(endSrc);
				}
			}
			//Import from site ends here
			imgindex = -1;
			startSrc=0; endSrc = 0;
		}
		ArrayList returnData = new ArrayList();
		returnData.add(contentEditor);
		returnData.add(checkEmbedHTMLResources);
		return returnData;
	}

	private String ReplaceEmbedMediaWithResourceURL(String contentEditor, String imgSrcPath, String imgActualPath, String courseId, boolean imsImport, String unZippedDirPath)
	{
		String replacementStr = uploadSectionDependentFile(imgActualPath, courseId, imsImport, unZippedDirPath);

		//Upon import, embedded media was getting full url without code below
		if (replacementStr.startsWith(ServerConfigurationService.getServerUrl()))
		{
			replacementStr = replacementStr.replace(ServerConfigurationService.getServerUrl(), "");
		}
		Pattern pattern = Pattern.compile(Pattern.quote(imgSrcPath));
		// Replace all occurrences of pattern in input
		// logger.debug("pattern:" + imgSrcPath );
		contentEditor = meleteUtil.replace(contentEditor,imgSrcPath, replacementStr);

		return contentEditor;
	}

	/*METHODS USED BY IMPORT FROM SITE BEGIN*/
	public void copyModules(String fromContext, String toContext)
	{
		//Copy the uploads collection
	   	buildModules(fromContext, toContext);
	   	transferManageItems(fromContext, toContext);
  	//   	setMeleteSitePreference(fromContext, toContext);
	}

	private void setMeleteSitePreference(String fromContext, String toContext)
	{
		MeleteSitePreference fromMsp = meleteUserPrefDB.getSitePreferences(fromContext);
		meleteUserPrefDB.setSitePreferences(toContext,fromMsp.isPrintable(),fromMsp.isAutonumber());
	}

	private void buildModules(String fromContext, String toContext)
	{
//		Get modules in site A
		Map sectionList = null;
		MeleteResource toMres = null;
		int fromSecId, toSecId;

		List fromModuleList = moduleDB.getActivenArchiveModules(fromContext);

		//Iterate through all modules in site A
		if (fromModuleList == null || fromModuleList.size() <= 0) return;

		for (ListIterator i = fromModuleList.listIterator(); i.hasNext(); )
		{
			Module fromMod = (Module) i.next();
			String fromModSeqXml = fromMod.getSeqXml();

			//Copy module properties and insert, seqXml is null for now
			Module toMod = new Module(fromMod.getTitle(), fromMod.getLearnObj(), fromMod.getDescription(), fromMod.getKeywords(), fromMod.getCreatedByFname(), fromMod.getCreatedByLname(), fromMod.getUserId(), fromMod.getModifiedByFname(), fromMod.getModifiedByLname(), fromMod.getInstitute(), fromMod.getWhatsNext(), fromMod.getCreationDate(), fromMod.getModificationDate(), null);
			ModuleShdates toModshdate = new ModuleShdates(((ModuleShdates)fromMod.getModuleshdate()).getStartDate(), ((ModuleShdates)fromMod.getModuleshdate()).getEndDate());
			if (fromMod.getCoursemodule().isArchvFlag() == false)
			{
			  try{
			  moduleDB.addModule(toMod, toModshdate, fromMod.getUserId(), toContext);
			  }catch(Exception ex3){
				  // logger.debug("error importing module");
			  }
			}
			else
			{
				CourseModule toCmod = new CourseModule(toContext, -1, true, fromMod.getCoursemodule().getDateArchived(), false, toMod);
				try{
					  moduleDB.addArchivedModule(toMod, toModshdate, fromMod.getUserId(), toContext, toCmod);
				}
				catch(Exception ex3){
					// logger.debug("error importing archived module");
				}

			}

			sectionList = fromMod.getSections();
			//Iterate throug sections of a module
			if (sectionList != null)
			{
				int mapSize = sectionList.size();
				if (mapSize > 0)
				{
					Iterator keyValuePairs = sectionList.entrySet().iterator();
					while (keyValuePairs.hasNext())
					{
						Map.Entry entry = (Map.Entry) keyValuePairs.next();
						Section fromSec = (Section) entry.getValue();
						fromSecId = fromSec.getSectionId().intValue();
						Section toSec = new Section(fromSec.getTitle(), fromSec.getCreatedByFname(), fromSec.getCreatedByLname(), fromSec.getModifiedByFname(), fromSec.getModifiedByLname(), fromSec.getInstr(), fromSec.getContentType(), fromSec.isAudioContent(), fromSec.isVideoContent(), fromSec.isTextualContent(), fromSec.isOpenWindow(), fromSec.isDeleteFlag(), fromSec.getCreationDate(), fromSec.getModificationDate());
						// logger.debug("copied section open window value" + toSec.getTitle()+"," + toSec.isOpenWindow() );
						try
						{
							//Insert into the SECTION table
							sectionDB.addSection(toMod, toSec, false);
							toSecId = toSec.getSectionId().intValue();
							//Replace old references of sections to new references in SEQ xml
							//TODO : Move the update seqxml lower down so sequence does not update
							//if exception is thrown
							if(!fromSec.getContentType().equals("notype") && fromSec.getSectionResource() != null)
							{
								toMres = new MeleteResource((MeleteResource)fromSec.getSectionResource().getResource());
								toMres.setResourceId(null);
								createContentResource(toMod,toSec,toMres,((MeleteResource)fromSec.getSectionResource().getResource()).getResourceId(),null,null,toContext);
							}
							if (fromModSeqXml!=null)
								fromModSeqXml = fromModSeqXml.replace(Integer.toString(fromSecId), Integer.toString(toSecId));

						}
						catch(Exception ex)
						{
							if (logger.isDebugEnabled()) {
								// logger.debug("error in inserting section "+ ex.toString());
								ex.printStackTrace();
							}
							//rollback and delete section
							try
							{
								sectionDB.deleteSection(toSec,toContext, null);
							}
							catch (Exception ex2)
							{
								logger.debug("Error in deleting section "+ex2.toString());
							}
						}

					}

					//Finally, update the seqXml for the module

				    Module secModule = moduleDB.getModule(toMod.getModuleId().intValue());
				    secModule.setSeqXml(fromModSeqXml);
					try
					{
						moduleDB.updateModule(secModule);
					}
					catch (Exception ex)
					{
						logger.debug("error in updating module");
					}

				}
			}

		}
		// if siteAction is collecting success data on import from site
		if(threadLocalManager.get("IMPORTSITE_PROCESS") != null)
		{
			HashMap hm = (HashMap)threadLocalManager.get("IMPORTSITE_PROCESS"); 
			StringBuffer importstatus = (StringBuffer) hm.get(fromContext);
			ResourceLoader rl = new ResourceLoader("melete_license");

			// remove the ones from importResources
			List<String> importResources = (ArrayList)threadLocalManager.get("MELETE_importResources" );
			List<String> multipleReferred = (ArrayList)threadLocalManager.get("MELETE_secondaryHTMLResources");
			logger.debug("RASHMI __import resources:" + importResources.toString());
			logger.debug("multipleReferred resources:" + multipleReferred.toString());

			if(multipleReferred != null && multipleReferred.size() > 0)
			{
				for(String s:multipleReferred)
				{
					//remove first occurance
					if(importResources.indexOf(s) != -1)importResources.remove(importResources.indexOf(s));
				}
			}
			logger.debug("import resources size after all removal:" + importResources.size());
			if(importResources != null && importResources.size() > 0)
			{
				//make a Set now to remove duplicates
				Set meleteSkippedFiles = new HashSet<String>(importResources);
				String meleteimportstatus = meleteSkippedFiles.toString();
				meleteimportstatus = meleteimportstatus.substring(1,meleteimportstatus.length()-1);
				try
				{
					meleteimportstatus = URLDecoder.decode(meleteimportstatus,"UTF-8");
				} catch (Exception e){ 	}
				logger.debug("meleteimportstatus:" + meleteimportstatus);
				meleteimportstatus="<li>"+rl.getString("import_site_resourceException") + meleteimportstatus +"</li>";
				if(importstatus == null) new StringBuffer();
				importstatus.append(meleteimportstatus);
			}
			hm.put(fromContext, importstatus);
			threadLocalManager.set("IMPORTSITE_PROCESS",hm);
		} // SiteAction if end
	}

	private void transferManageItems(String fromContext, String toContext)
	{
		long totalstart = System.currentTimeMillis();

		String fromUploadsColl = Entity.SEPARATOR+"private"+ REFERENCE_ROOT+ Entity.SEPARATOR+fromContext+Entity.SEPARATOR+"uploads"+Entity.SEPARATOR;
		String toUploadsColl = Entity.SEPARATOR+"private"+ REFERENCE_ROOT+ Entity.SEPARATOR+toContext+Entity.SEPARATOR+"uploads"+Entity.SEPARATOR;

		List fromContextList = meleteCHService.getMemberNamesCollection(fromUploadsColl);

		List toContextList = meleteCHService.getMemberNamesCollection(toUploadsColl);

		if ((fromContextList != null)&&(toContextList != null))
		{
			ListIterator memIt = fromContextList.listIterator();
			List replaceContextList = new ArrayList();
		 	while(memIt !=null && memIt.hasNext())
		 	{
		 		String resId = (String) memIt.next();
		 		resId = resId.replace(fromContext, toContext);
		 		replaceContextList.add(resId);
		 	}
		 	if (replaceContextList != null)
		 	{
		 		if (replaceContextList.size() > 0)
		 		{
		 			replaceContextList.removeAll(toContextList);
		 			if (replaceContextList.size() > 0)
		 			{
		 				ListIterator repIt = replaceContextList.listIterator();
		 				while (repIt != null && repIt.hasNext())
		 				{
		 					String resId = (String) repIt.next();
		 					resId = resId.replace(toContext,fromContext);
		 					byte[] melContentData;
		 					String res_mime_type,melResourceName;
		 					try
		 					{
		 					  ContentResource cr = getMeleteCHService().getResource(resId);
							  melContentData = cr.getContent();
							  res_mime_type = cr.getContentType();
							  melResourceName =  cr.getProperties().getProperty(ResourceProperties.PROP_DISPLAY_NAME);
							  try
							  {
								// check if the item has already been imported to this site (in uploads collection)
							 	String checkResourceId = toUploadsColl+melResourceName;
							 	getMeleteCHService().checkResource(checkResourceId);
							  }
							  catch (IdUnusedException ex)
							  {
							    ResourcePropertiesEdit res = getMeleteCHService().fillInSectionResourceProperties(false,melResourceName,"");
			 				    try
			 				    {
						 		  String newResourceId = getMeleteCHService().addResourceItem(melResourceName, res_mime_type,toUploadsColl,melContentData,res );
						 		}
			 				    catch(Exception e)
			 				    {
			 						logger.debug("Error thrown in exporting of manage resources");
			 						logger.debug(e.toString());
			 				    }
							  }
		 					}
		 					catch(IdUnusedException unuse)
		 					{
		 						// if file not found exception or content is missing continue working
		 						logger.debug("error in reading resource content in exporting manage resources");
		 					}
		 					catch(Exception e)
		 					{
		 						logger.error("error in reading resource in export manage resource");
		 					}

		 				}//End while repIt
		 			}//End if
		 		}
		 	}
		}

		long totalend = System.currentTimeMillis();

		logger.debug("TRANSFER took "+(totalend-totalstart)+" millisecs");

	}
	/*METHODS USED BY IMPORT FROM SITE END*/

	/**
	 * deletes the file and its children
	 * @param delfile - file to be deleted
	 */
	public void deleteFiles(File delfile){

		if (delfile.isDirectory()){
			File files[] = delfile.listFiles();
			int i = files.length;
			while (i > 0)
				deleteFiles(files[--i]);

			delfile.delete();
		}else
			delfile.delete();

	}

	public String getContentSourceInfo(Document document)
	{
		Map uris = new HashMap();
		uris.put("imscp", DEFAULT_NAMESPACE_URI);
		uris.put("imsmd", IMSMD_NAMESPACE_URI);

		try
		{
			// description
			XPath xpath = document.createXPath("/imscp:manifest/imscp:metadata/imsmd:lom/imsmd:rights/imsmd:description");
			xpath.setNamespaceURIs(uris);

			Element eleOrg = (Element) xpath.selectSingleNode(document);
			if (eleOrg != null)
			{
				// logger.debug("got desc element" + eleOrg.toString());
				return eleOrg.selectSingleNode( ".//imsmd:langstring").getText();
			}
			else return null;
		}
		catch(Exception e)
		{
			logger.debug("error in reading other contact info" + e.toString());
			e.printStackTrace();
			return null;
		}
	}

	private void addToThreadList(String name, String key)
	{
		if(name == null || key == null) return;
		ArrayList updateList = (ArrayList)threadLocalManager.get(key);
		if(updateList != null)
		{
			updateList.add(name);
			threadLocalManager.set(key,updateList);
		}
	}


	/**
	 * @return Returns the meleteCHService.
	 */
	public MeleteCHService getMeleteCHService() {
		return meleteCHService;
	}
	/**
	 * @param meleteCHService The meleteCHService to set.
	 */
	public void setMeleteCHService(MeleteCHService meleteCHService) {
		this.meleteCHService = meleteCHService;
	}

	public void setModuleDB(ModuleDB moduleDB) {
		this.moduleDB = moduleDB;
	}

	/**
	 * @param sectionDB The sectionDB to set.
	 */
	public void setSectionDB(SectionDB sectionDB) {
		this.sectionDB = sectionDB;
	}



	/**
	 * @return Returns the meleteLicenseDB.
	 */
	public MeleteLicenseDB getMeleteLicenseDB() {
		return meleteLicenseDB;
	}
	/**
	 * @param meleteLicenseDB The meleteLicenseDB to set.
	 */
	public void setMeleteLicenseDB(MeleteLicenseDB meleteLicenseDB) {
		this.meleteLicenseDB = meleteLicenseDB;
	}
	/**
	 * @return the meleteUserPrefDB
	 */
	public MeleteUserPreferenceDB getMeleteUserPrefDB()
	{
		return this.meleteUserPrefDB;
	}
	/**
	 * @param meleteUserPrefDB the meleteUserPrefDB to set
	 */
	public void setMeleteUserPrefDB(MeleteUserPreferenceDB meleteUserPrefDB)
	{
		this.meleteUserPrefDB = meleteUserPrefDB;
	}
}
