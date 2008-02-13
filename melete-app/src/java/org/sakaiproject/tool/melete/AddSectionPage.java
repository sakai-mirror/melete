/**********************************************************************************
*
* $Header: /usr/src/sakai/melete-2.4/melete-app/src/java/org/sakaiproject/tool/melete/AddSectionPage.java,v 1.23 2007/06/26 16:19:33 rashmim Exp $
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

package org.sakaiproject.tool.melete;

import java.util.*;
import java.io.File;
import java.io.Serializable;
import javax.faces.component.UIInput;
import javax.faces.context.FacesContext;
import javax.faces.event.AbortProcessingException;
import javax.faces.event.ValueChangeEvent;
import javax.faces.application.FacesMessage;
import org.sakaiproject.util.ResourceLoader;

import org.sakaiproject.api.app.melete.exception.MeleteException;
import org.sakaiproject.component.app.melete.MeleteResource;
import org.sakaiproject.content.api.ContentResourceEdit;
import org.sakaiproject.entity.api.ResourcePropertiesEdit;


//import org.sakaiproject.jsf.ToolBean;


/**
 * @author Rashmi
 *
 * This class is the backing bean for AddModuleSections.jsp.
 * Rashmi - 5/31/07 - add upload is similar to edit upload and goes to next page to get the file
 */

public class AddSectionPage extends SectionPage implements Serializable{
	private boolean sizeWarning=false;

	public AddSectionPage(){
		setFormName("AddSectionForm");
		shouldRenderNotype = true;
		}

	/**
	 * @return sizeWarning
	 * render sizeWarning message if this flag is true
	 */
	public boolean getSizeWarning()
	{
		return this.sizeWarning;
	}

	/**
	 * @param sizeWarning
	 * to set sizeWarning to true if section save is successful.
	 */
	public void setSizeWarning(boolean sizeWarning)
	{
		this.sizeWarning = sizeWarning;
	}

    /**
     * return content editor
    */
    public String getContentEditor()
    {
		ResourceLoader bundle = new ResourceLoader("org.sakaiproject.tool.melete.bundle.Messages");
          if(this.contentEditor == null || this.contentEditor.length()== 0)
          {
                  this.contentEditor = new String("Compose content here");
          }
          return this.contentEditor;
    }

	/**
	 * instantiates saving of a section.
	 * Validate required fields - modality and if content is there then copyright.
	 * If section has content then save section resource and resource using content hosting
	 * otherwise just save a section.
	 * If sucess set success flag and show the success message.
	 * if any error, display error message to the user.
	 * revised - to get all error messages at one time
	 **/
	public String saveHere()
	{
		checkUploadExists();
		setSuccess(false);
		FacesContext context = FacesContext.getCurrentInstance();
        ResourceLoader bundle = new ResourceLoader("org.sakaiproject.tool.melete.bundle.Messages");

        //validation 1:	   modality is required.
	     if (!validateModality())
	     {
	     	String errMsg = bundle.getString("add_section_modality_reqd");
			context.addMessage (null, new FacesMessage(FacesMessage.SEVERITY_ERROR,"add_section_modality_reqd",errMsg));
			return "failure";
	     }
	     try
		 {
	     //validation 2: if content is provided then check for copyright license
	     if(!section.getContentType().equals("notype") && getM_license().getLicenseCodes().equals(SectionResourceLicenseSelector.Copyright_CODE))
	     {
	     	getM_license().checkForRequiredFields();	     
	     }

	    //validation 3: if upload a new file check fileName format - moved to uploadSerctionContent()
	  	// validation 4: check link url - moved to addresourcetoMeleteCollection()
	 	
	   //   save section
		    if (logger.isDebugEnabled()) logger.debug("AddSectionpage:inserting section");
		     String uploadHomeDir = context.getExternalContext().getInitParameter("uploadDir");

			String addCollId = getMeleteCHService().getCollectionId( section.getContentType(), module.getModuleId());
			if(section.getContentType().equals("typeExistUpload")) section.setContentType("typeUpload");
			if(section.getContentType().equals("typeExistLink")) section.setContentType("typeLink");

			// step 1: insert section
			Integer newSectionId = sectionService.insertSection(module,section);
			section.setSectionId(newSectionId);
			section.setModule(module);

//			Step2: if section has content then only create section resource and resource
			if(!section.getContentType().equals("notype"))
			{
				meleteResource = getM_license().processLicenseInformation(getMeleteResource());

			//	step 2.1:existing resource is selected for section content				
				if(!section.getContentType().equals("typeEditor") && selResourceIdFromList != null)
					{
					if (logger.isDebugEnabled()) logger.debug("existing resource is selected");
					meleteResource.setResourceId(selResourceIdFromList);
					getMeleteCHService().editResourceProperties(selResourceIdFromList, secResourceName, secResourceDescription);
					}
				else
					{
			//	Step 2.2: add the new resource to course site module /uploads collection
				// in case of upload, resource is added on clicking Continue	
					if(!section.getContentType().equals("typeUpload"))
						{
						selResourceIdFromList = null;
						String newResourceId = addResourceToMeleteCollection(uploadHomeDir,addCollId);
						meleteResource.setResourceId(newResourceId);
						}
					// in case of Upload if change in resource properties save that
					else 
						{
						getMeleteCHService().editResourceProperties(meleteResource.getResourceId(), secResourceName, secResourceDescription);
						}
					}

			//step 3: insert section resource in melete table i.e. if new resource then insert in melete resource table
			//	otherwise just insert in sectionResource table
				if(selResourceIdFromList == null) sectionService.insertMeleteResource(section, meleteResource);
				else sectionService.insertSectionResource(section, meleteResource);
			}

		}
	     catch(MeleteException mex)
			{
			logger.error("error in inserting section "+ mex.toString());
			//rollback and delete section
			sectionService.deleteSection(section, null);
			String errMsg = bundle.getString(mex.getMessage());
			context.addMessage (null, new FacesMessage(FacesMessage.SEVERITY_ERROR,mex.getMessage(),errMsg));
			return "failure";
			}
		catch(Exception ex)
			{
			logger.error("error in inserting section "+ ex.toString());
			sectionService.deleteSection(section, null);
			String errMsg = bundle.getString("add_section_fail");
			context.addMessage (null, new FacesMessage(FacesMessage.SEVERITY_ERROR,"add_section_fail",errMsg));
			ex.printStackTrace();
			return "failure";
			}

		return "success";
	}

	public String save()
	{
		setSuccess(false);
		if(!saveHere().equals("failure"))
		{
		setSuccess(true);
		return "confirm_addmodulesection";
		}
		return "addmodulesections";
	}

	/*
	 *  on clicking link 2 me the page navigates back to add module section
	 */
	public String redirectLink()
	{
		return "addmodulesections";
	}

	/*
	 * on clicking expandAll resource listing shows
	 */
	public String expandAllResources()
	{
		expandAllFlag = true;
		return "addmodulesections";
	}

	/*
	 * on clicking expandAll resource listing shows
	 */
	public String collapseAllResources()
	{
		expandAllFlag = false;
		return "addmodulesections";
	}


	/**
	 * save the section, if not saved yet and then refresh the page to
	 * add more sections.
	 **/
	public String saveAndAddAnotherSection()
	{

	     // create new instance of section model
	     resetSectionValues();
	     setSizeWarning(false);

		return "addmodulesections";
	}

	/**
	 * returns failure if the section has not been saved first.
	 * returns finish to redirect to addmodulefinish page.
	 * */
	public String Finish()
	{
			return "list_auth_modules";
	}

	public String previewFromAdd()
	{

		try{
			if(!section.getContentType().equals("notype"))
			{
			  if (this.section.getContentType().equals("typeEditor"))
			  {
				this.previewContentData = this.contentEditor;
				return "addpreview";
			  }
			  else
			  {
	    	      this.previewContentData = getMeleteCHService().getResourceUrl(meleteResource.getResourceId());
	               return "addpreview";
	           }
			}
			else
			{
				this.previewContentData = null;
				return "addpreview";
			}
  	     } catch (Exception e) {
			logger.error(e.toString());
		  }
		return "#";
	}

	  public String gotoServerView()
	  {
	  	logger.debug("going to server view page");
	  	expandAllFlag = true;  	    
 	    renderSelectedResource = false;
 	    selResourceIdFromList = null; 	    
 	    currSiteResourcesList = null;
 	    getCurrSiteResourcesList();
 	    return "ContentUploadServerView";
	  }

	  public String setServerFile()
	  {
	  	FacesContext ctx = FacesContext.getCurrentInstance();
	  	ResourceLoader bundle = new ResourceLoader("org.sakaiproject.tool.melete.bundle.Messages");
	  	try
		{
	  		// local file is selected so create a resource to move on
	  	  if(selResourceIdFromList == null)
	  		{	  		
            	   String addCollectionId = getMeleteCHService().getUploadCollectionId();
            	   String uploadHomeDir = ctx.getExternalContext().getInitParameter("uploadDir");
            	   String newResourceId = addResourceToMeleteCollection(uploadHomeDir,addCollectionId);
				   meleteResource.setResourceId(newResourceId);
				   String rUrl = getMeleteCHService().getResourceUrl(newResourceId);
	               String checkDup = rUrl.substring(rUrl.lastIndexOf("/")+1);
	               if(!checkDup.equals(secResourceName))secResourceName = checkDup;
            	}
            
	  		ctx.renderResponse();
		}
		catch(Exception e)
			{
			logger.error("error in set server file for add section content");
			e.printStackTrace();
			String errMsg = bundle.getString(e.getMessage());
     		ctx.addMessage (null, new FacesMessage(FacesMessage.SEVERITY_ERROR,"",errMsg));
			return "ContentUploadServerView";
			}
	  		return "addmodulesections";
	  }

	  public String cancelServerFile()
	  {
	  		selResourceIdFromList = null;
	  		renderSelectedResource = false;
	  		return "addmodulesections";
	  }
}