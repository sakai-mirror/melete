/*
 * Created on Jun 4, 2007
 *
 * TODO To change the template for this generated file go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
package org.sakaiproject.component.app.melete;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;
import org.dom4j.Namespace;
import org.dom4j.QName;
import org.sakaiproject.api.app.melete.MeleteCHService;
import org.sakaiproject.api.app.melete.MeleteExportService;
import org.sakaiproject.api.app.melete.MeleteSecurityService;
import org.sakaiproject.api.app.melete.exception.MeleteException;
import org.sakaiproject.api.app.melete.util.XMLHelper;
import org.xml.sax.SAXException;
import org.sakaiproject.component.cover.ServerConfigurationService;
import org.sakaiproject.util.Validator;
import org.sakaiproject.entity.cover.EntityManager;
import org.sakaiproject.entity.api.Reference;
import org.sakaiproject.content.api.ContentResource;
import org.sakaiproject.entity.api.ResourceProperties;
import org.sakaiproject.exception.IdUnusedException;
import org.sakaiproject.content.cover.ContentHostingService;
import org.doomdark.uuid.UUID;
import org.doomdark.uuid.UUIDGenerator;
/**
 * @author Faculty
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
public class MeleteExportServiceImpl implements MeleteExportService{

	/** Dependency:  The logging service. */
	protected Log logger = LogFactory.getLog(MeleteExportServiceImpl.class);

	/**default namespace and metadata namespace*/
	protected String DEFAULT_NAMESPACE_URI = "http://www.imsglobal.org/xsd/imscp_v1p1";
	protected String IMSMD_NAMESPACE_URI ="http://www.imsglobal.org/xsd/imsmd_v1p2";

	protected int RESOURCE_LICENSE_CODE = 0; //not determined yet
	protected String RESOURCE_LICENSE_URL = "I have not determined copyright yet"; //No license
	protected int RESOURCE_LICENSE_COPYRIGHT_CODE = 1; //Copyright of author
	protected int RESOURCE_LICENSE_PD_CODE = 2; //		Public Domain
	protected int RESOURCE_LICENSE_CC_CODE = 3; //Creative Commons
	protected int RESOURCE_LICENSE_FAIRUSE_CODE = 4; //FairUse Exception

	private MeleteCHService meleteCHService;
	private MeleteLicenseDB meleteLicenseDB;
	protected SectionDB sectionDB;
	private SubSectionUtilImpl sectionUtil;
	private org.w3c.dom.Element currItem = null;
	/**
	 * Establish my logger component dependency.
	 * @param logger the logger component.
	 */
	public void setLogger(Log logger){
		this.logger = logger;
	}
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


	/**
	 * creates document root element "manifest" and adds the namespaces
	 *
	 * @return returns the manifest element
	 * @throws  Exception
	 */
	public Element createManifest() throws Exception {
		Element root = DocumentHelper.createElement("manifest");
		//Set up the necessary namespaces
		root.setQName(new QName("manifest", new Namespace(null,	DEFAULT_NAMESPACE_URI)));
		root.add(new Namespace("imsmd",IMSMD_NAMESPACE_URI));
		root.add(new Namespace("xsi", "http://www.w3.org/2001/XMLSchema-instance"));

		/*root.addAttribute("xsi:schemaLocation",
				"http://www.imsglobal.org/xsd/imscp_v1p1 "
						+ "http://www.imsglobal.org/xsd/imscp_v1p1.xsd "
						+ "http://www.imsglobal.org/xsd/imsmd_v1p2 "
						+ "http://www.imsglobal.org/xsd/imsmd_v1p2.xsd ");
		*/

		root.addAttribute("identifier", "Manifest-" + getUUID().toString());
		root.addAttribute("version", "IMS CP 1.1.4");
		return root;
	}

	/**
	 * creates document root element "manifest" from the default manifest file
	 * and adds the namespaces
	 * @param xmlFile - Default manifest file
	 * @return returns the manifest element
	 * @throws  Exception
	 */
	public Element getManifest(File xmlFile) throws Exception {
		try {
			Document document = XMLHelper.getSaxReader().read(xmlFile);
			Element root = document.getRootElement();
			Element rootnew = root.createCopy();
			List childEleList  = rootnew.elements();
			childEleList.clear();

			this.DEFAULT_NAMESPACE_URI = rootnew.getNamespaceURI();

			List nslist = rootnew.declaredNamespaces();

			for (int i=0; i<nslist.size(); i++){
				if (((Namespace)nslist.get(i)).getPrefix().equals("imsmd")){
					this.IMSMD_NAMESPACE_URI = ((Namespace)nslist.get(i)).getURI();
					break;
				}
			}
			rootnew.addAttribute("identifier", "Manifest-" + getUUID().toString());
			return rootnew;
		} catch (DocumentException de) {
			throw de;
		} catch (SAXException se) {
			throw se;
		}catch (Exception e) {
			throw e;
		}
	}

	/**
	 * create manifest metadata element with schema and schemaversion elements
	 *
	 * @return - returns metadata element
	 */
	public Element createManifestMetadata() {
        Element metadata = createDefaultNSElement("metadata", "metadata");

        //schema element
        Element schema = createDefaultNSElement("schema", "schema");
        schema.setText("IMS Content");
        metadata.add(schema);

        //schema version element
        Element schemaVersion = createDefaultNSElement("schemaversion", "schemaversion");
        schemaVersion.setText("1.1.4");
        metadata.add(schemaVersion);

        return metadata;
    }


	/**
	 * creates the default namespace element
	 * @param elename - element name
	 * @param qname - qualified name
	 * @return - returns the default namespace element
	 */
	public Element createDefaultNSElement(String elename, String qname) {
		Element metadata = DocumentHelper.createElement(elename);
        metadata.setQName(new QName(qname,new Namespace(null, DEFAULT_NAMESPACE_URI)));
		return metadata;
	}


	/**
	 * creates the LOM metadata element
	 * @param elename - element name
	 * @param qname - qualified name
	 * @return - returns the metadata element
	 */
	public Element createLOMElement(String elename, String qname) {

		Element imsmdlom = DocumentHelper.createElement(elename);
		imsmdlom.setQName(new QName(qname,new Namespace("imsmd", IMSMD_NAMESPACE_URI)));

		return imsmdlom;
	}

	/**
	 * creates metadata title element
	 * @param title - title
	 * @return - returns the title element
	 */
	public Element createMetadataTitle(String title) {
		//imsmd:title
        Element imsmdtitle = createLOMElement("imsmd:title", "title");

        //imsmd:langstring
        Element imsmdlangstring = createLOMElement("imsmd:langstring", "langstring");
        //imsmdlangstring.addAttribute("xml:lang", "en-US");
        imsmdlangstring.setText(title);

        imsmdtitle.add(imsmdlangstring);

        return imsmdtitle;
	}

	/**
	 * creates metadata description element
	 * @param description - description
	 * @return - returns the metadata description element
	 */
	public Element createMetadataDescription(String description) {
		//imsmd:description
		Element mdDesc = createLOMElement("imsmd:description", "description");

		//imsmd:langstring
		Element mdLangString = createLOMElement("imsmd:langstring", "langstring");
		//mdLangString.addAttribute("xml:lang", "en-US");
		mdLangString.setText(description);

		mdDesc.add(mdLangString);

		return mdDesc;
	}

	/*
	 * create keyword element
	 * add by rashmi
	 */
	public Element createMetadataKeyword(String keyword) {
		//imsmd:keyword
		Element mdKeyword = createLOMElement("imsmd:keyword", "keyword");

		//imsmd:langstring
		Element mdLangString = createLOMElement("imsmd:langstring", "langstring");
		//mdLangString.addAttribute("xml:lang", "en-US");
		mdLangString.setText(keyword);

		mdKeyword.add(mdLangString);

		return mdKeyword;
	}

	/*
	 * create copyright element
	 * add by rashmi
	 */
	public Element createMetadataCopyright(int licenseCode)
	{
		//imsmd:copyright
		Element mdCopyright = createLOMElement("imsmd:copyrightandotherrestrictions", "copyrightandotherrestrictions");

		Element mdSource = createLOMElement("imsmd:source", "source");
		Element mdLangString = createLOMElement("imsmd:langstring", "langstring");
		mdLangString.setText("Melete");
		mdSource.add(mdLangString);
		mdCopyright.add(mdSource);
		// if public domain then no restrictions are applied
		// and for all other licenses restrictions are applied
		Element mdValue = createLOMElement("imsmd:value", "value");
		Element mdLangString1 = createLOMElement("imsmd:langstring", "langstring");
		if(licenseCode != RESOURCE_LICENSE_PD_CODE)
			mdLangString1.setText("yes");
		else mdLangString1.setText("no");
		mdValue.add(mdLangString1);
		mdCopyright.add(mdValue);

		return mdCopyright;
	}

	/*
	 * create license url for manifest file
	 * add by rashmi
	 */
	private String createLicenseUrl (int lcode, String lurl, String owner, String year)
	{
		if(lcode == RESOURCE_LICENSE_CODE) return RESOURCE_LICENSE_URL;
		if (lcode == RESOURCE_LICENSE_COPYRIGHT_CODE) return lurl;

		if(lcode == RESOURCE_LICENSE_PD_CODE || lcode == RESOURCE_LICENSE_CC_CODE)
		{
			lurl = meleteLicenseDB.fetchCcLicenseName(lurl);
			if(lcode == RESOURCE_LICENSE_CC_CODE)
						lurl = "Creative Commons " + lurl;
		}
		if(owner != null && (owner=owner.trim()).length() !=0) {lurl = lurl + "," + owner;}
		if(year != null && (year = year.trim()).length() !=0) {lurl = lurl + "," + year;}

		return lurl;
	}

	/*
	 *  process section type and create resource element object
	 */
	private void createResourceElement(Section section, Element resource, byte[] content_data1, File resoucesDir, String imagespath, String sectionFileName,int i) throws Exception
	{
		if (section.getContentType().equals("typeLink")){
			String linkData = new String(content_data1);

			if(linkData.startsWith(ServerConfigurationService.getServerUrl()) && linkData.indexOf("/access/content/group")!= -1)
			{
				String link_resource_id = replace(linkData,ServerConfigurationService.getServerUrl()+"/access/content","");

				// read resource and create a file
				ArrayList link_content = new ArrayList();
				byte[] linkdata =setContentResourceData(link_resource_id, link_content);
				if(linkdata == null) {resource =null;return;}
				if(!((String)link_content.get(2)).equals(getMeleteCHService().MIME_TYPE_LINK))
		 		{
					logger.debug("link resource points to site res item as file. Include file in zip");
					// Site resource item is file and not URL
		 		String resfileName = Validator.escapeResourceName((String)link_content.get(0));
				File resfile = new File(resoucesDir+ "/"+ resfileName);
				createFileFromContent(linkdata, resfile.getAbsolutePath());

				Element file = resource.addElement("file");
				file.addAttribute("href", "resources/"+ resfileName);
		 		}
			}
//			 resource will always point to link location otherwise it changes type to upload on import
			resource.addAttribute("href", linkData);
			// preserve url title
			if(!sectionFileName.equals(linkData))
			{
			Element urlTitle = createLOMElement("imsmd:title", "title");
			Element imsmdlangstring = createLOMElement("imsmd:langstring", "langstring");
	        imsmdlangstring.setText(sectionFileName);
	        urlTitle.add(imsmdlangstring);
	        resource.add(urlTitle);
			}
		}else if (section.getContentType().equals("typeEditor")){
			Element file = resource.addElement("file");
			String fileName = sectionFileName;

			if (fileName.startsWith("module_"))
			{
				int und_index = fileName.indexOf("_",7);
				fileName = fileName.substring(und_index+1, fileName.length());
		    }

			file.addAttribute("href", "resources/"+ fileName);
			resource.addAttribute("href", "resources/"+ fileName);

			//read the content to modify the path for images

			//replace image path and create image files
			String modSecContent = replaceImagePath(new String(content_data1), imagespath, resource);

			//create the file
			File resfile = new File(resoucesDir+ "/"+fileName);
			createFileFromContent( modSecContent.getBytes(), resfile.getAbsolutePath());
		}else if(section.getContentType().equals("typeUpload")){
			Element file = resource.addElement("file");
			String fileName = Validator.escapeResourceName(sectionFileName);

            if (fileName.startsWith("module_"))
			{
				int und_index = fileName.indexOf("_",7);
				fileName = fileName.substring(und_index+1, fileName.length());
		    }

			file.addAttribute("href", "resources/"+ fileName);
			resource.addAttribute("href", "resources/"+ fileName);

			//create the file
			File resfile = new File(resoucesDir+ "/"+ fileName);
			createFileFromContent(content_data1, resfile.getAbsolutePath());
		}
	}

	public int createSectionElement(Element ParentSection, Section section, int i, int k, Element resources, File resoucesDir, String imagespath) throws Exception
	{
			Element secElement = ParentSection.addElement("item");
			secElement.addAttribute("identifier", "ITEM"+ k);
			Element secTitleEle = secElement.addElement("title");
			secTitleEle.setText(section.getTitle());
			int item_ref_num = k;
			logger.debug("now processing createSectionElement" + section.getTitle());
			// dtd specifies nested item tag to be before imsmd tags.
			if(currItem.hasChildNodes())
			{
				int size = currItem.getChildNodes().getLength();
				logger.debug("processing childNodes of " + section.getTitle() + "and no of child nodes are:" +  size);
				int childNo = 0;
				while(childNo < size)
				{
						currItem = sectionUtil.getNextSection(currItem);
						k = createSectionElement(secElement, sectionDB.getSection(Integer.parseInt(currItem.getAttribute("id"))), i,++k, resources,resoucesDir,imagespath);
						childNo++;
				}
			}

			Element imsmdlom = createLOMElement("imsmd:lom", "lom");
			//add section instructions
			if (section.getInstr() != null && section.getInstr().trim().length() > 0)
			   {
				Element imsmdgeneral = imsmdlom.addElement("imsmd:general");
				imsmdgeneral.add(createMetadataDescription(section.getInstr()));
			   }
			// add section instructions end

			// if content exists then create resource object otherwise just create item object
			if(section.getSectionResource() != null)
			{
				MeleteResource meleteResource = (MeleteResource)section.getSectionResource().getResource();
				String content_resource_id = meleteResource.getResourceId();
				ArrayList content_data = new ArrayList();
				byte[] content_data1 =setContentResourceData(content_resource_id,content_data);

				if(content_data1 == null || content_data == null) return k;
				//Rashmi - if no resources are written then see if createResourceElement needs a return type
				Element resource = resources.addElement("resource");
				resource.addAttribute("identifier","RESOURCE"+ item_ref_num);
				resource.addAttribute("type ","webcontent");
				createResourceElement(section, resource, content_data1, resoucesDir, imagespath,(String)content_data.get(0),i);
				secElement.addAttribute("identifierref", resource.attributeValue("identifier"));
				// add copyright information - rashmi
				Element imsmdright = imsmdlom.addElement("imsmd:rights");
				imsmdright.add(createMetadataCopyright(meleteResource.getLicenseCode()));

				// add license description
				Element mdLicenseDesc = createLOMElement("imsmd:description", "description");
				Element mdLangString2 = createLOMElement("imsmd:langstring", "langstring");
				String lurl = createLicenseUrl(meleteResource.getLicenseCode(),meleteResource.getCcLicenseUrl(),meleteResource.getCopyrightOwner(),meleteResource.getCopyrightYear());
				mdLangString2.setText(lurl);
				mdLicenseDesc.add(mdLangString2);
				imsmdright.add(mdLicenseDesc);
				// copyright info add end

				secElement.add(imsmdlom);
			}	// end if contents
	return k;
	}
	/**
	 * adds organization and resource items tomanifest
	 * @param modDateBeans - module date beans
	 * @param packagedir - package directory
	 * @return - returns the list of manifest elements
	 * @throws Exception
	 */
	public List generateOrganizationResourceItems(List modList, File packagedir)throws Exception{
		String probEncounteredSections ="";
		try{
			String packagedirpath = packagedir.getAbsolutePath();
			String resourcespath  = packagedirpath + File.separator + "resources";
			File resoucesDir = new File(resourcespath);
			if (!resoucesDir.exists())resoucesDir.mkdir();
			String imagespath  = resoucesDir.getAbsolutePath() + File.separator + "images";

			Element organizations = createOrganizations();
			Element resources = createResources();
			Element organization = addOrganization(organizations);
			organizations.addAttribute("default", organization.attributeValue("identifier"));

			Iterator modIter = modList.iterator();
			int i = 0,k=0;
			//create item for each module and items under the module item for
			// scetions
			while (modIter.hasNext()){
				Module module = (Module) modIter.next();

				Element modMainItem = organization.addElement("item");
				modMainItem.addAttribute("identifier", "MF01_ORG1_MELETE_MOD"+ ++i);

				Element title = modMainItem.addElement("title");
				if (module.getTitle() != null && module.getTitle().trim().length() > 0)
					title.setText(module.getTitle());

				String sectionsSeqList = module.getSeqXml();
				sectionUtil = new SubSectionUtilImpl();

				if (sectionsSeqList != null){
					sectionUtil.getSubSectionW3CDOM(sectionsSeqList);
					currItem = null;
					//create items and resources for sections
					while ((currItem = sectionUtil.getNextSection(currItem)) != null){
						logger.debug("exporting item from generateOrgan" + currItem.getAttribute("id"));
						Section section = sectionDB.getSection(Integer.parseInt(currItem.getAttribute("id")));
						try{
							// create secElement only if data exists
							logger.debug("exporting section from generateOrgan" + section.getTitle());
							k = createSectionElement(modMainItem, section, i,++k, resources,resoucesDir,imagespath);
							} // if end add secElement only if content exists
						catch(Exception e){
							logger.error("err in exporting section" + e.toString());
							Section probSection = sectionDB.getSection(Integer.parseInt(currItem.getAttribute("id")));
							probEncounteredSections += module.getTitle() +" section: "+ probSection.getTitle();
							logger.debug("problems found in impl" + probEncounteredSections);
							throw new MeleteException(probEncounteredSections);
						//	continue;
							}
					}
					//		 add next steps as the last section of the module by rashmi
					if (module.getWhatsNext() != null && module.getWhatsNext().trim().length() > 0)
					{
						Element whatsNextElement = modMainItem.addElement("item");
						whatsNextElement.addAttribute("identifier", "NEXTSTEPS"+ ++k);

						Element nextTitleEle = whatsNextElement.addElement("title");
						nextTitleEle.setText("NEXTSTEPS");

						Element resource = resources.addElement("resource");
						resource.addAttribute("identifier","RESOURCE"+ k);
						resource.addAttribute("type ","webcontent");

//						create the file
						File resfile = new File(resoucesDir+ "/module_"+ i +"_nextsteps.html");
						createFileFromContent( module.getWhatsNext().getBytes(), resfile.getAbsolutePath());
						whatsNextElement.addAttribute("identifierref", resource.attributeValue("identifier"));
						Element file = resource.addElement("file");
						file.addAttribute("href", "resources/module_"+ i +"_nextsteps.html");
						resource.addAttribute("href", "resources/module_"+ i +"_nextsteps.html");
					}
				// add next steps end

				}
				//add module description thru metadata
				Element imsmdlom = createLOMElement("imsmd:lom", "lom");
				Element imsmdgeneral = imsmdlom.addElement("imsmd:general");

				if (module.getDescription() != null && module.getDescription().trim().length() > 0)
					imsmdgeneral.add(createMetadataDescription(module.getDescription()));

				// add keyword if available - rashmi
				if (module.getKeywords() != null && module.getKeywords().trim().length() > 0)
					imsmdgeneral.add(createMetadataKeyword(module.getKeywords()));

				modMainItem.add(imsmdlom);

			}
			ArrayList manElements = new ArrayList();
			manElements.add(organizations);
			manElements.add(resources);
			manElements.add(probEncounteredSections);
			return manElements;

		}catch(Exception e){
			logger.debug("i am catching it");
			throw e;
		}

	}

	/*
	 * get resource information from content resource object
	 */
	private byte[] setContentResourceData(String resourceId, ArrayList data)throws Exception
	{
		try{
			if(resourceId != null)
	    	{
			resourceId = URLDecoder.decode(resourceId,"UTF-8");
	       	ContentResource cr = getMeleteCHService().getResource(resourceId);
	       	if(cr == null)return null;

	       	data.add(cr.getProperties().getProperty(ResourceProperties.PROP_DISPLAY_NAME));
	       	data.add(cr.getProperties().getProperty(ResourceProperties.PROP_DESCRIPTION));
	       	data.add(cr.getContentType());
	       	return cr.getContent();
	    	}
		}
		catch(IdUnusedException unuse){
			// if file not found exception or content is missing continue working
			logger.error("error in reading resource content in export section");
			}
		catch(Exception e){
			logger.error("error in reading resource in export section");
			throw e;
		}
		return null;
	}

	/**
	 * replace image path in the section content for uploaded images thru
	 * content editor and create the image files under resources/images
	 * @param secContent
	 * @param imagespath
	 * @param resource
	 * @return the content with modifed image path
	 */
	private String replaceImagePath(String secContent, String imagespath, Element resource)throws Exception{
		StringBuffer strBuf = new StringBuffer();
		String checkforimgs = secContent;
		int imgindex = -1;

		String imgSrcPath, imgName, imgLoc;
		String modifiedSecContent = new String(secContent);
	//	meletedocsdirpath = meleteDocsDirPath;

		try {
			File imagesDir = new File(imagespath);

			if (!imagesDir.exists())
				imagesDir.mkdir();

			Pattern p1 = Pattern.compile("<[iI][mM][gG]\\s|<[aA]\\s|<[eE][mM][bB][eE][dD]\\s");
			Pattern pi = Pattern.compile(">|\\s[sS][rR][cC]\\s*=");
			Pattern pa = Pattern.compile(">|\\s[hH][rR][eE][fF]\\s*=");
			Pattern ps = Pattern.compile("\\S");
			Pattern pe = Pattern.compile("\\s|>");

			while(checkforimgs !=null) {

			        // look for <img or <a
			        Matcher m = p1.matcher(checkforimgs);
				if (!m.find()) // found anything?
				    break;
				checkforimgs = checkforimgs.substring(m.start());
				// look for src= or href=
				if (checkforimgs.startsWith("<i") ||
					    checkforimgs.startsWith("<I") ||
					    checkforimgs.startsWith("<e") ||
					    checkforimgs.startsWith("<E"))
				    m = pi.matcher(checkforimgs);
				else
				    m = pa.matcher(checkforimgs);
				// end = start+1 means that we found a >
				// i.e. the attribute we're looking for isn't there
				if (!m.find() || (m.end() == m.start() + 1)) {
				    // prevent infinite loop by consuming the <
				    checkforimgs = checkforimgs.substring(1);
				    continue;
				}

				checkforimgs = checkforimgs.substring(m.end());

				// look for start of arg, a non-whitespace
			        m = ps.matcher(checkforimgs);
				if (!m.find()) // found anything?
				    break;

				checkforimgs = checkforimgs.substring(m.start());

				int startSrc = 0;
				int endSrc = 0;

				// handle either quoted or nonquoted arg
				if (checkforimgs.startsWith("\"") ||
				    checkforimgs.startsWith("\'")) {
				    String quotestr = checkforimgs.substring(0,1);
				    startSrc = 1;
				    endSrc = checkforimgs.indexOf(quotestr, startSrc);
				} else {
				    startSrc = 0;
				    // ends with whitespace or >
				    m = pe.matcher(checkforimgs);
				    if (!m.find()) // found anything?
					continue;
				    endSrc = m.start();
				}

				imgSrcPath = checkforimgs.substring(startSrc, endSrc);
				if(imgSrcPath.indexOf("/access") !=-1)
				{
				String findEntity = imgSrcPath.substring(imgSrcPath.indexOf("/access")+7);
				Reference ref = EntityManager.newReference(findEntity);
				logger.debug("ref properties" + ref.getType() +"," +ref.getId());

				if(ref.getType().equals(ContentHostingService.APPLICATION_ID) || ref.getType().equals(MeleteSecurityService.APPLICATION_ID))
				{
					String img_resource_id =ref.getId() ;
					if(ref.getType().equals(MeleteSecurityService.APPLICATION_ID))
						img_resource_id =img_resource_id.replaceFirst("/content","");

					if(ref.getType().equals(ContentHostingService.APPLICATION_ID) && !ref.getId().startsWith("/group"))
					{
						// not a site resource item so make it a full URL
						String patternStr = imgSrcPath;
						String replacementStr =ServerConfigurationService.getServerUrl() + imgSrcPath;
						modifiedSecContent = replace(modifiedSecContent,patternStr, replacementStr);
						return modifiedSecContent;
					}

					ArrayList img_content = new ArrayList();
					byte[] img_data =setContentResourceData(img_resource_id, img_content);
					if(img_data == null) continue;
					imgName= (String)img_content.get(0);
					imgName = Validator.escapeResourceName(imgName);
					createFileFromContent(img_data,imagesDir.getAbsolutePath()+File.separator+ imgName);

					String patternStr = imgSrcPath;
					String replacementStr = "images/"+ imgName;
					Pattern pattern = Pattern.compile(Pattern.quote(patternStr));

					// Replace all occurrences of pattern in input
					modifiedSecContent = replace(modifiedSecContent,patternStr, replacementStr);

					//add image to resources element
					Element file = resource.addElement("file");
					file.addAttribute("href", "resources/images/"+ imgName);
					}
				}
				else if(imgSrcPath.startsWith("/")){
					//internal link resides somewhere within sakai
					String patternStr = imgSrcPath;
					String replacementStr =ServerConfigurationService.getServerUrl() + imgSrcPath;
					modifiedSecContent = replace(modifiedSecContent,patternStr, replacementStr);
					return modifiedSecContent;
				}

			}
		}catch (Exception e) {
			throw e;
		}

		return modifiedSecContent;
	}

	public String replace(String s, String one, String another) {
		// In a string replace one substring with another
		if (s.equals(""))
			return "";
		if ((one == null)||(one.length() == 0))
		{
			return s;
		}
		String res = "";
		int i = s.indexOf(one, 0);
		int lastpos = 0;
		while (i != -1) {
			res += s.substring(lastpos, i) + another;
			lastpos = i + one.length();
			i = s.indexOf(one, lastpos);
		}
		res += s.substring(lastpos); // the rest
		return res;
}

	/*
	 * REMOVE WITH MELTEDOCS MIGRATION PROGRAMME
	 */
	public byte[] readFromFile(File contentfile) throws Exception{

		FileInputStream fis = null;
		try{
			fis = new FileInputStream(contentfile);

			byte buf[] = new byte[(int)contentfile.length()];
			fis.read(buf);
			return buf;
	  	}catch(Exception ex){
	  		throw ex;
	  		}finally{
	  		if (fis != null)
	  			fis.close();
	  		}
	}

	 public boolean checkFileExists(String filePath)
	 {
	 boolean success = false;
	 try {
	        File file = new File(filePath);

	        // Create file if it does not exist
	        success = file.exists();
	        if (success) {

	        } else {
 //	        	 File did not exist and was created
	        	logger.info("File "+filePath+" does not exist");
	        }
	    } catch (Exception e) {
	    	logger.error("error in checkFileExists"+ e.toString());
	  		e.printStackTrace();
	    }

	    return success;
	 }

	/**
	 * creates file from input path to output path
	 * @param inputpath - input path for file
	 * @param outputpath - output path for file
	 * @throws Exception
	 */
	public void createFile(String inputurl, String outputurl)throws Exception{
		FileInputStream in = null;
		FileOutputStream out = null;
		try {
			File inputFile = new File(inputurl);
			File outputFile = new File(outputurl);
			in = new FileInputStream(inputFile);
			out = new FileOutputStream(outputFile);
			int c;
			int len;
			byte buf[] = new byte[102400];
			while ((len = in.read(buf)) > 0) {
				out.write(buf, 0, len);
			}
		} catch (FileNotFoundException e) {
			logger.error(e.toString());
		} catch (IOException e) {
			throw e;
		} finally{
			try {
				if (in != null)
					in.close();
			} catch (IOException e1) {
			}
			try {
				if (out != null)
					out.close();
			} catch (IOException e2) {
			}
		}
	}

	/**
	 * creates file from input path to output path
	 * @param inputpath - input path for file
	 * @param outputpath - output path for file
	 * @throws Exception
	 */
	public void createFileFromContent(byte[] content, String outputurl)throws Exception{
		FileOutputStream fout = new FileOutputStream(new File(outputurl));
		try {
			fout.write(content);
			fout.flush();
		} catch (IOException e) {
			throw e;
		} catch (Exception e) {
			throw e;
		} finally {
			if (fout != null)
				fout.close();
		}
	}

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

	/**
	 * gets UUID
	 * @return - returns the UUID
	 */
	private UUID getUUID() {
		return UUIDGenerator.getInstance().generateRandomBasedUUID();
	}


	/**
	 * creates organizations element
	 * @return returns organizations element
	 */
	private Element createOrganizations(){
		return createDefaultNSElement("organizations", "organizations");
	}


	/**
	 * creates resources element
	 * @return returns resources element
	 */
	private Element createResources(){

		return createDefaultNSElement("resources", "resources");
	}

	/**
	 * add organization for melete modules
	 * @param organizations - organizations element
	 */
	private Element addOrganization(Element organizations) {
		Element organization = organizations.addElement("organization");
		organization.addAttribute("identifier", "MF01_ORG1_MELETE");
		organization.addAttribute("structure", "hierarchical");

		return organization;
	}

	/**
	 * @return Returns the meleteCHService.
	 */
	public MeleteCHService getMeleteCHService() {
		return meleteCHService;
	}
	/**
	 * @return Returns the meleteLicenseDB.
	 */
	public MeleteLicenseDB getMeleteLicenseDB() {
		return meleteLicenseDB;
	}
	/**
	 * @return Returns the sectionDB.
	 */
	public SectionDB getSectionDB() {
		return sectionDB;
	}
	/**
	 * @param sectionDB The sectionDB to set.
	 */
	public void setSectionDB(SectionDB sectionDB) {
		this.sectionDB = sectionDB;
	}
	/**
	 * @param meleteCHService The meleteCHService to set.
	 */
	public void setMeleteCHService(MeleteCHService meleteCHService) {
		this.meleteCHService = meleteCHService;
	}
	/**
	 * @param meleteLicenseDB The meleteLicenseDB to set.
	 */
	public void setMeleteLicenseDB(MeleteLicenseDB meleteLicenseDB) {
		this.meleteLicenseDB = meleteLicenseDB;
	}
}
