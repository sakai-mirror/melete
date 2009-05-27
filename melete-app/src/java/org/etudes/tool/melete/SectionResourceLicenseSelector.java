/**********************************************************************************
 *
 * $URL$
 *
 ***************************************************************************************
 * Copyright (c) 2008 Etudes, Inc.
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
 **************************************************************************/
package org.etudes.tool.melete;

import java.util.ArrayList;
import java.util.Iterator;

import javax.faces.component.UIInput;
import javax.faces.component.UIViewRoot;
import javax.faces.context.FacesContext;
import javax.faces.event.AbortProcessingException;
import javax.faces.event.ValueChangeEvent;
import javax.faces.model.SelectItem;

import org.etudes.component.app.melete.MeleteResource;
import org.etudes.component.app.melete.MeleteUserPreference;
import org.etudes.api.app.melete.MeleteLicenseService;
import org.etudes.api.app.melete.SectionResourceService;
import org.etudes.api.app.melete.SectionService;
import org.etudes.api.app.melete.exception.MeleteException;
import org.etudes.api.app.melete.exception.UserErrorException;
import org.sakaiproject.util.ResourceLoader;
/**
 * @author Rashmi
 *
 * This class captures and process the license selected by user.
 * Mallika - 3/5/07 - setting license info for license code 0
 */
public class SectionResourceLicenseSelector {
	protected SectionService sectionService;
	public String formName;
	  private ArrayList licenseTypes;
	  private String licenseCodes;

	  //constants
	  public final static String NO_CODE = "0";
	  public final static String Copyright_CODE = "1";
	  public final static String PD_CODE = "2";
	  public final static String CC_CODE = "3";
	  public final static String FU_CODE = "4";

	  private boolean shouldRenderCC;
	  private boolean shouldRenderCopyright;
	  private boolean shouldRenderPublicDomain;
	  private boolean shouldRenderFairUse;

	  private String copyright_owner;
	  private String copyright_year;

	  private String allowCmrcl;
	  private String allowMod="1";
	  private String reqAttr;
	  private MeleteResource melResource;

	  public void setInitialValues(String formName, SectionService sectionService, MeleteResource melResource)
	  {
	  	this.formName = formName;
	  	this.sectionService = sectionService;
	  	allowCmrcl="false";
		allowMod ="1";
		reqAttr = "false";
		copyright_owner=null;
		copyright_year=null;
		this.melResource = melResource;

		if(melResource !=null)
			setLicenseCodes(String.valueOf(melResource.getLicenseCode()));
		else setLicenseCodes(null);

		if(melResource !=null && formName.equals("EditSectionForm") && !licenseCodes.equals(CC_CODE))
		{
			this.melResource.setAllowCmrcl(false);
			this.melResource.setAllowMod(1);
		}
	  }

	  public void setInitialValues(String formName, SectionService sectionService, MeleteUserPreference mup)
	  {
	  	this.formName = formName;
	  	this.sectionService = sectionService;

	  	if (mup != null)
	  	{
	  		setLicenseCodes(String.valueOf(mup.getLicenseCode()));
	  		setAllowCmrcl(String.valueOf(mup.isAllowCmrcl()));
	  		setAllowMod(String.valueOf(mup.getAllowMod()));
	  		setReqAttr(String.valueOf(mup.isReqAttr()));
	  		setCopyright_owner(mup.getCopyrightOwner());
	  		setCopyright_year(mup.getCopyrightYear());
	  	}
	  	else
	  	{
	  	  allowCmrcl="false";
		  allowMod ="1";
		  reqAttr = "false";
		  copyright_owner=null;
		  copyright_year=null;
		  setLicenseCodes(null);
	  	}
	  }

	  /*
		 * This method reads the user preference for type_upload, type_editor etc
		 * and sets the license code accordingly. if nothing is specified then default
		 * Fair Use Exception.
		 */
		public void setLicensePreference()
		{
			// Default is Not determined yet
			licenseCodes = NO_CODE;
			allowCmrcl ="false";
	        allowMod = "1";
	        }

		// license code
		public ArrayList getLicenseTypes()
		{
			FacesContext ctx = FacesContext.getCurrentInstance();
			 ResourceLoader bundle = new ResourceLoader("org.etudes.tool.melete.bundle.Messages");
			  if(sectionService == null)
			  		sectionService = getSectionService();


		  if(licenseTypes == null || licenseTypes.size() == 0)
			{
		      licenseTypes = new ArrayList();
		      ArrayList allLicenseTypes = new ArrayList();
		      allLicenseTypes = sectionService.getMeleteLicenses();

		      // Adding available list to select box
		      if(allLicenseTypes == null || allLicenseTypes.size()==0)
		      {
		    	String nolicenseMsg = bundle.getString("add_section_noLicense");
		      	licenseTypes.add(new SelectItem(nolicenseMsg, nolicenseMsg));
		      	 return licenseTypes;
		      }

		      Iterator itr = allLicenseTypes.iterator();
	    	  while (itr.hasNext()) {
	    	  		MeleteLicenseService  license = (MeleteLicenseService ) itr.next();
	    	  		String value = license.getCode().toString();
	    	  		String label = license.getDescription();
	    	  		label = bundle.getString("add_section_license_"+value);
	    	  		licenseTypes.add(new SelectItem(value, label));
	    		}

		    }
		  return licenseTypes;
		}

		/*
		 *
		 */
		public void hideLicense(ValueChangeEvent event)throws AbortProcessingException
		{

			FacesContext ctx = FacesContext.getCurrentInstance();
		  	UIViewRoot root = ctx.getViewRoot();
			UIInput licenseSelect = (UIInput)event.getComponent();

			shouldRenderCC = licenseSelect.getValue().equals(CC_CODE);
			shouldRenderCopyright = licenseSelect.getValue().equals(Copyright_CODE);
			shouldRenderPublicDomain = licenseSelect.getValue().equals(PD_CODE);
			shouldRenderFairUse = licenseSelect.getValue().equals(FU_CODE);

			allowCmrcl="false";
			allowMod ="1";
			reqAttr = "false";
			copyright_owner=null;
			copyright_year=null;

			if (!(licenseSelect.getValue().equals("0")))
			{
			if(root.findComponent(this.formName).findComponent("CCLicenseForm") != null)
	             root.findComponent(this.formName).findComponent("CCLicenseForm").setRendered(Boolean.TRUE.booleanValue());
			}

		}

		/*
		 *
		 */
		public MeleteResource processLicenseInformation(MeleteResource meleteSectionResource)
		{
			String[] result = new String[2];
			 if(licenseCodes.equals(CC_CODE))
			 	{
			 		result = sectionService.getCCLicenseURL(new Boolean("true").booleanValue(), new Boolean(allowCmrcl).booleanValue(), new Integer(allowMod).intValue());
			 		meleteSectionResource.setCcLicenseUrl(result[0]);
			 		meleteSectionResource.setLicenseCode(new Integer(CC_CODE).intValue());
			 		meleteSectionResource.setReqAttr(true);
			 		meleteSectionResource.setAllowCmrcl(new Boolean(allowCmrcl).booleanValue());
			 		meleteSectionResource.setAllowMod(new Integer(allowMod).intValue());
			 		meleteSectionResource.setCopyrightOwner(copyright_owner);
			 		meleteSectionResource.setCopyrightYear(copyright_year);
			 	}
			 else if(licenseCodes.equals(PD_CODE))
			 {

		 	  	result = sectionService.getCCLicenseURL(new Boolean("false").booleanValue(), new Boolean("false").booleanValue(), new Integer("0").intValue());
		 	  	meleteSectionResource.setCcLicenseUrl(result[0]);
		 	  	meleteSectionResource.setLicenseCode(new Integer(PD_CODE).intValue());
		 	  	meleteSectionResource.setReqAttr(false);
		 	  	meleteSectionResource.setAllowCmrcl(false);
		 	  	meleteSectionResource.setAllowMod(0);
		 	  	meleteSectionResource.setCopyrightOwner(copyright_owner);
			 	meleteSectionResource.setCopyrightYear(copyright_year);
			 }
			 else if (licenseCodes.equals(Copyright_CODE))
			 {
			 	meleteSectionResource.setCcLicenseUrl("Copyright (c) " + copyright_owner+", " + copyright_year);
			 	meleteSectionResource.setLicenseCode(new Integer(Copyright_CODE).intValue());
			 	meleteSectionResource.setCopyrightOwner(copyright_owner);
			 	meleteSectionResource.setCopyrightYear(copyright_year);
			 }
			 else if(licenseCodes.equals(FU_CODE))
			 {
			 	meleteSectionResource.setCcLicenseUrl("Copyrighted Material - subject to fair use exception");
			 	meleteSectionResource.setLicenseCode(new Integer(FU_CODE).intValue());
			 	meleteSectionResource.setCopyrightOwner(copyright_owner);
			 	meleteSectionResource.setCopyrightYear(copyright_year);
			 }
			 else if(licenseCodes.equals(NO_CODE))
			 	{
			 		meleteSectionResource.setCcLicenseUrl(null);
			 		meleteSectionResource.setLicenseCode(new Integer(NO_CODE).intValue());
			 		meleteSectionResource.setReqAttr(false);
			 		meleteSectionResource.setAllowCmrcl(false);
			 		meleteSectionResource.setAllowMod(0);
			 		meleteSectionResource.setCopyrightOwner(null);
			 		meleteSectionResource.setCopyrightYear(null);
			 	}
			 return meleteSectionResource;
		}

		public MeleteUserPreference processLicenseInformation(MeleteUserPreference mup)
		{
			String[] result = new String[2];
			 if(licenseCodes.equals(CC_CODE))
			 	{
			 		result = sectionService.getCCLicenseURL(new Boolean("true").booleanValue(), new Boolean(allowCmrcl).booleanValue(), new Integer(allowMod).intValue());
			 		mup.setCcLicenseUrl(result[0]);
			 		mup.setLicenseCode(new Integer(CC_CODE).intValue());
			 		mup.setReqAttr(true);
			 		mup.setAllowCmrcl(new Boolean(allowCmrcl).booleanValue());
			 		mup.setAllowMod(new Integer(allowMod).intValue());
			 		mup.setCopyrightOwner(copyright_owner);
			 		mup.setCopyrightYear(copyright_year);
			 	}
			 else if(licenseCodes.equals(PD_CODE))
			 {

		 	  	result = sectionService.getCCLicenseURL(new Boolean("false").booleanValue(), new Boolean("false").booleanValue(), new Integer("0").intValue());
		 	  	mup.setCcLicenseUrl(result[0]);
		 	  	mup.setLicenseCode(new Integer(PD_CODE).intValue());
		 	  	mup.setReqAttr(false);
		 	  	mup.setAllowCmrcl(false);
		 	  	mup.setAllowMod(0);
		 	  	mup.setCopyrightOwner(copyright_owner);
			 	mup.setCopyrightYear(copyright_year);
			 }
			 else if (licenseCodes.equals(Copyright_CODE))
			 {
			 	mup.setCcLicenseUrl("Copyright (c) " + copyright_owner+", " + copyright_year);
			 	mup.setLicenseCode(new Integer(Copyright_CODE).intValue());
			 	mup.setCopyrightOwner(copyright_owner);
			 	mup.setCopyrightYear(copyright_year);
			 }
			 else if(licenseCodes.equals(FU_CODE))
			 {
			 	mup.setCcLicenseUrl("Copyrighted Material - subject to fair use exception");
			 	mup.setLicenseCode(new Integer(FU_CODE).intValue());
			 	mup.setCopyrightOwner(copyright_owner);
			 	mup.setCopyrightYear(copyright_year);
			 }
			 else if(licenseCodes.equals(NO_CODE))
			 	{
			 		mup.setCcLicenseUrl(null);
			 		mup.setLicenseCode(new Integer(NO_CODE).intValue());
			 		mup.setReqAttr(false);
			 		mup.setAllowCmrcl(false);
			 		mup.setAllowMod(0);
			 		mup.setCopyrightOwner(null);
			 		mup.setCopyrightYear(null);
			 	}
			 return mup;
		}

		public void setLicenseCodes(String licenseCodes)
		{
			this.licenseCodes = licenseCodes;
			if(licenseCodes == null) return;
			if(licenseCodes.equals(CC_CODE)) shouldRenderCC = true;
			else shouldRenderCC = false;
			if(licenseCodes.equals(Copyright_CODE)) shouldRenderCopyright = true;
			else shouldRenderCopyright = false;
			if(licenseCodes.equals(PD_CODE)) shouldRenderPublicDomain = true;
			else shouldRenderPublicDomain = false;
			if(licenseCodes.equals(FU_CODE)) shouldRenderFairUse = true;
			else shouldRenderFairUse = false;

		}

		public String getLicenseCodes()
		{
			// in case of edit section find from secResource object
	       	if (licenseCodes == null)
	       	{
	   			setLicensePreference();
	       	}
			return licenseCodes;
		}

		public void checkForRequiredFields() throws UserErrorException
		{
			if(copyright_owner == null || copyright_owner.trim().length() == 0)
				throw new UserErrorException("copyright_info_required");

			if(copyright_year == null || copyright_year.trim().length() == 0)
				throw new UserErrorException("copyright_info_required");
		}


		 public String getAllowCmrcl(){
	        if(formName.equals("EditSectionForm"))
	        	allowCmrcl = String.valueOf(melResource.isAllowCmrcl());
			return allowCmrcl;
			}

		  /**
		 * @param allowCmrcl
		 */
		public void setAllowCmrcl(String allowCmrcl){
		  	this.allowCmrcl = allowCmrcl;
		   }

		 public String getAllowMod(){
			 if(formName.equals("EditSectionForm"))
				 allowMod = String.valueOf(melResource.getAllowMod());
		   return allowMod;
			}

		  /**
		 * @param allowMod
		 */
		public void setAllowMod(String allowMod){
			  this.allowMod = allowMod;
		   }

	    public String getReqAttr(){
					return reqAttr;
			}

		  /**
		 * @param reqAttr
		 */
		public void setReqAttr(String reqAttr){
			  	this.reqAttr = reqAttr;
		   }

		public boolean getShouldRenderCC()
		{
			return this.shouldRenderCC;
		}

		public boolean getShouldRenderCopyright()
		{
			return this.shouldRenderCopyright;
		}

	/**
	 * @return Returns the copyright_owner.
	 */
	public String getCopyright_owner() {
		if(copyright_owner == null)
		{
			if (melResource != null)
			{
			  copyright_owner = melResource.getCopyrightOwner();
			}
		}
		return copyright_owner;
	}
	/**
	 * @param copyright_owner The copyright_owner to set.
	 */
	public void setCopyright_owner(String copyright_owner) {
		this.copyright_owner = copyright_owner;
	}
	/**
	 * @return Returns the copyright_year.
	 */
	public String getCopyright_year() {
		if(copyright_year == null)
		{
			if (melResource != null)
			{
			  this.copyright_year = melResource.getCopyrightYear();
			}
		}
		return copyright_year;
	}
	/**
	 * @param copyright_year The copyright_year to set.
	 */
	public void setCopyright_year(String copyright_year) {
		this.copyright_year = copyright_year;
	}
		/**
		   * @return Returns the ModuleService.
		   */
		  public SectionService getSectionService() {
			return sectionService;
		  }

		/**
		  * @param moduleService The moduleService to set.
		  */
		  public void setSectionService(SectionService sectionService) {
			this.sectionService = sectionService;
		  }
	/**
	 * @param shouldRenderCC The shouldRenderCC to set.
	 */
	public void setShouldRenderCC(boolean shouldRenderCC) {
		this.shouldRenderCC = shouldRenderCC;
	}
	/**
	 * @param shouldRenderCopyright The shouldRenderCopyright to set.
	 */
	public void setShouldRenderCopyright(boolean shouldRenderCopyright) {
		this.shouldRenderCopyright = shouldRenderCopyright;
	}
	/**
	 * @return Returns the shouldRenderFairUse.
	 */
	public boolean isShouldRenderFairUse() {
		return shouldRenderFairUse;
	}
	/**
	 * @param shouldRenderFairUse The shouldRenderFairUse to set.
	 */
	public void setShouldRenderFairUse(boolean shouldRenderFairUse) {
		this.shouldRenderFairUse = shouldRenderFairUse;
	}
	/**
	 * @return Returns the shouldRenderPublicDomain.
	 */
	public boolean isShouldRenderPublicDomain() {
		return shouldRenderPublicDomain;
	}
	/**
	 * @param shouldRenderPublicDomain The shouldRenderPublicDomain to set.
	 */
	public void setShouldRenderPublicDomain(boolean shouldRenderPublicDomain) {
		this.shouldRenderPublicDomain = shouldRenderPublicDomain;
	}

}
