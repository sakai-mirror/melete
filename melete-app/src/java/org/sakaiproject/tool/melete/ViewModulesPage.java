/**********************************************************************************
*
* $Header: /usr/src/sakai/melete-2.4/melete-app/src/java/org/sakaiproject/tool/melete/ViewModulesPage.java,v 1.13 2007/11/07 00:54:16 mallikat Exp $
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
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.sakaiproject.api.app.melete.*;

import javax.faces.component.*;
import java.util.List;
import java.util.Map;
import java.io.Serializable;
import javax.faces.event.ActionEvent;

import javax.faces.context.FacesContext;
import javax.faces.el.ValueBinding;
//import com.sun.faces.util.Util;
import org.sakaiproject.component.app.melete.*;
import org.sakaiproject.api.app.melete.ModuleService;
//import org.sakaiproject.jsf.ToolBean;

/**
 * @author Faculty
 *
 * TODO To change the template for this generated type comment go to
 * Window - Preferences - Java - Code Style - Code Templates
 */
/*
 *
 * Mallika - 1/26/07 - viewsection changes again, typeLink goes to view_section, typeEditor and typeUpload go to view_section_link
 * Mallika - 2/8/07 - consolidated view section pages
 * Mallika - 4/25/07 - Adding prev next
 * Rashmi - 5/10/07 - removed code from constructor
 * Mallika - 5/17/07 - Rearranged code to prevent null ptr exceptions
*/


public class ViewModulesPage implements Serializable/*,ToolBean*/ {


	  /** identifier field */
      private int moduleId;
      private int moduleSeqNo;
      public ModuleDateBeanService mdbean;
      private ModuleDateBeanService prevMdbean;

      private boolean instRole;
      private int sectionSize;
      private String role;
      private String nullString = null;
      private String emptyString = "";
      private int prevSectionSize;
      private int prevSeqNo;
      private int nextSeqNo;


//    This needs to be set later using Utils.getBinding
	  String courseId;


	  private ModuleService moduleService;
	   /** Dependency:  The logging service. */
	  protected Log logger = LogFactory.getLog(ViewModulesPage.class);

	  public ViewModulesPage(){
	  }

     /**
	   * @return Returns the ModuleService.
	   */
	  public ModuleService getModuleService() {
		return moduleService;
	  }

	 /**
	  * @param moduleService The moduleService to set.
	  */
	  public void setModuleService(ModuleService moduleService) {
		this.moduleService = moduleService;
	  }

	  /**
		 * @param logger The logger to set.
	  */
	  public void setLogger(Log logger) {
			this.logger = logger;
	  }
	  public String getNullString() {
	  	return nullString;
	  }

	  public String getEmptyString() {
	  	return emptyString;
	  }


	  public int getModuleId() {
        return this.moduleId;
    }

    public void setModuleId(int moduleId) {
        this.moduleId = moduleId;
    }
    public int getModuleSeqNo() {
        return this.moduleSeqNo;
    }

    public void setModuleSeqNo(int moduleSeqNo) {
        this.moduleSeqNo = moduleSeqNo;
    }

    public int getPrevSeqNo() {
    	return this.prevSeqNo;
    }
    public int getNextSeqNo() {
    	return this.nextSeqNo;
    }
    public int getPrevSectionSize() {
    	return this.prevSectionSize;
    }

    public ModuleDateBeanService getPrevMdbean()
    {
    	if (this.prevMdbean == null)
    	{
    		getMdbean();
    	}
    	return this.prevMdbean;
    }
    public void setPrevMdbean(ModuleDateBeanService prevMdbean){
        this.prevMdbean = prevMdbean;
    }

    public ModuleDateBeanService getMdbean()
    {
      if (this.mdbean == null)
 	  {
    	try {
    	String courseId = getCourseId();
    	 if (this.moduleId > 0)
    	  {
  	  	    this.mdbean = (ModuleDateBeanService) getModuleService().getModuleDateBean(courseId,this.moduleId);
    	  }
    	  else
    	  {
    		this.mdbean = (ModuleDateBeanService) getModuleService().getModuleDateBeanBySeq(courseId,this.moduleSeqNo);
    	  }
    	  if (this.mdbean != null)
    	  {
    	  this.moduleSeqNo = this.mdbean.getModule().getCoursemodule().getSeqNo();
  	  	  this.prevSeqNo = getModuleService().getPrevSeqNo(courseId,this.moduleSeqNo);
  	  	  this.nextSeqNo = getModuleService().getNextSeqNo(courseId,this.moduleSeqNo);
    	  }
  	  	  this.prevSectionSize = 0;
  	  	  if (this.prevSeqNo > 0)
  	  	  {
  	  	    this.prevMdbean = (ModuleDateBeanService) getModuleService().getModuleDateBeanBySeq(getCourseId(),prevSeqNo);
  	  	    if (this.prevMdbean != null)
  	  	    {
  	  	    if (this.prevMdbean.getSectionBeans() != null)
  	  	    {
  	  	      this.prevSectionSize = this.prevMdbean.getSectionBeans().size();
  	  	    }
  	  	    }
  	  	  }

  	  	}
  	  	catch (Exception e)
          {
  		  //e.printStackTrace();
  	  		logger.error(e.toString());
          }
 	  }
  	  	return this.mdbean;
    }

    public void setMdbean(ModuleDateBeanService mdbean){
      this.mdbean = mdbean;
    }
    public int getSectionSize() {
    	if (this.mdbean == null) getMdbean();

    	if (this.mdbean != null)
    	{
    	  if (this.mdbean.getSectionBeans() != null)
    	  {
    	  this.sectionSize = this.mdbean.getSectionBeans().size();
    	  }
    	  else
    	  {
    		this.sectionSize = 0;
    	  }
    	}
    	else
    	{
    		this.sectionSize = 0;
    	}
        return this.sectionSize;
    }

    public boolean getInstRole()
    {
    	FacesContext context = FacesContext.getCurrentInstance();
	  	Map sessionMap = context.getExternalContext().getSessionMap();
	  	if ((String)sessionMap.get("role") !=null)
	  		this.instRole = ((String)sessionMap.get("role")).equals("INSTRUCTOR");
	  	else this.instRole = false;
    	return instRole;
    }

    public void setInstRole(boolean instRole)
    {
    	this.instRole = instRole;
    }

    private String getCourseId()
    {
    	if (courseId == null)
    	{
    	FacesContext context = FacesContext.getCurrentInstance();
      	Map sessionMap = context.getExternalContext().getSessionMap();
    	courseId = (String)sessionMap.get("courseId");
    	}
    	return courseId;
    }

    /*
     *
     * modified by rashmi - 03/10/05
     *  added seperate page for links and upload to show them in frame
     */

    public String viewSection() {

	  FacesContext ctx = FacesContext.getCurrentInstance();
	  	 UIViewRoot root = ctx.getViewRoot();

	        UIData table = (UIData)
	            root.findComponent("viewmoduleform").findComponent("tablesec");

	    ValueBinding binding =
	            Util.getBinding("#{viewSectionsPage}");

	    ViewSectionsPage vsPage = (ViewSectionsPage)
	            binding.getValue(ctx);

	            SectionBean secBean = (SectionBean) table.getRowData();
	            vsPage.setSectionId(secBean.getSection().getSectionId());
	            vsPage.setModuleId(secBean.getSection().getModuleId());
	            vsPage.setModuleSeqNo(secBean.getSection().getModule().getCoursemodule().getSeqNo());
	            vsPage.setSection(null);
	            //added by rashmi on 6/14/05
	            vsPage.setModule(null);


	     String retVal = "view_section_student";

	    //03/10/05  rashmi - added seperate page for links and upload to show them in frame
	    //3/21/05 - mallika - the if condition was slightly ambiguous, so needed to change that

	    if (getInstRole() == true)
	    {

	      retVal = "view_section";

	    }
	    else
	    {
	      retVal = "view_section_student";

	    }
	  	return retVal;
	  }


    /*
     * add by rashmi to navigate to table of contents
     */

    public String goTOC()
	{
		if (getInstRole()) return "list_modules_inst";
		else return "list_modules_student";
	}

    public String goNextSection()
    {
    	  FacesContext ctx = FacesContext.getCurrentInstance();

 	    ValueBinding binding =
 	            Util.getBinding("#{viewSectionsPage}");

 	    ViewSectionsPage vsPage = (ViewSectionsPage)
 	            binding.getValue(ctx);

 	     SectionBean secBean = (SectionBean) this.mdbean.getSectionBeans().get(0);
 	           vsPage.setSectionId(secBean.getSection().getSectionId());
 	            vsPage.setModuleId(secBean.getSection().getModuleId());
 	            vsPage.setModuleSeqNo(secBean.getSection().getModule().getCoursemodule().getSeqNo());
 	            vsPage.setSection(null);
 	            //added by rashmi on 6/14/05
 	            vsPage.setModule(null);


 	     String retVal = "view_section_student";

 	    //03/10/05  rashmi - added seperate page for links and upload to show them in frame
 	    //3/21/05 - mallika - the if condition was slightly ambiguous, so needed to change that

 	    if (getInstRole() == true)
 	    {

 	      retVal = "view_section";

 	    }
 	    else
 	    {
 	      retVal = "view_section_student";

 	    }
 	  	return retVal;
    }
    public String goPrevSection()
    {
    	  FacesContext ctx = FacesContext.getCurrentInstance();

 	    ValueBinding binding =
 	            Util.getBinding("#{viewSectionsPage}");

 	    ViewSectionsPage vsPage = (ViewSectionsPage)
 	            binding.getValue(ctx);

 	     SectionBean secBean = (SectionBean) this.prevMdbean.getSectionBeans().get(this.prevMdbean.getSectionBeans().size()-1);
 	            vsPage.setSectionId(secBean.getSection().getSectionId());
 	            vsPage.setModuleId(secBean.getSection().getModuleId());
 	            vsPage.setModuleSeqNo(secBean.getSection().getModule().getCoursemodule().getSeqNo());
 	            vsPage.setSection(null);
 	            //added by rashmi on 6/14/05
 	            vsPage.setModule(null);

 	     String retVal = "view_section_student";

 	    //03/10/05  rashmi - added seperate page for links and upload to show them in frame
 	    //3/21/05 - mallika - the if condition was slightly ambiguous, so needed to change that

 	    if (getInstRole() == true)
 	    {

 	      retVal = "view_section";

 	    }
 	    else
 	    {
 	      retVal = "view_section_student";

 	    }
 	  	return retVal;
    }
    public String goPrevWhatsNext()
    {
    	FacesContext context = FacesContext.getCurrentInstance();

    	ValueBinding binding =
            Util.getBinding("#{viewNextStepsPage}");
          ViewNextStepsPage vnPage = (ViewNextStepsPage)
            binding.getValue(context);
        if (this.prevMdbean == null) getMdbean();
        if (this.prevMdbean != null)
        {
          if (this.prevMdbean.getSectionBeans() != null)
          {
    	    vnPage.setPrevSecId(((SectionBean)this.prevMdbean.getSectionBeans().get(this.prevMdbean.getSectionBeans().size()-1)).getSection().getSectionId());
          }
          else
          {
        	vnPage.setPrevSecId(0);
          }
          vnPage.setPrevModId(this.prevMdbean.getModule().getModuleId());
          vnPage.setModule(this.prevMdbean.getModule());
        }
        else
        {
        	vnPage.setPrevSecId(0);
        }


    	vnPage.setNextSeqNo(this.moduleSeqNo);


    		return "view_whats_next";

    }
    public String goWhatsNext()
    {
    	FacesContext context = FacesContext.getCurrentInstance();
    	int nextSeqNo = getModuleService().getNextSeqNo(getCourseId(),new Integer(((String)context.getExternalContext().getRequestParameterMap().get("modseqno"))).intValue());

    	ValueBinding binding =
            Util.getBinding("#{viewNextStepsPage}");
          ViewNextStepsPage vnPage = (ViewNextStepsPage)
            binding.getValue(context);
    	vnPage.setPrevSecId(0);
    	vnPage.setPrevModId(this.moduleId);
    	
    	vnPage.setNextSeqNo(this.nextSeqNo);
    	
        if (this.mdbean != null) vnPage.setModule(this.mdbean.getModule());

    		return "view_whats_next";

    }

    public String goPrevNext()
    {
    	FacesContext ctx = FacesContext.getCurrentInstance();
    	this.moduleSeqNo = getModuleService().getNextSeqNo(getCourseId(),new Integer(((String)ctx.getExternalContext().getRequestParameterMap().get("modseqno"))).intValue());
        this.mdbean = null;
        this.moduleId = 0;

    	if (getInstRole())
    	{
    			return "view_module";
    	}
    	else
    	{
    			return "view_module_student";
    	}
    }
    public void viewModule(ActionEvent evt) {
    	FacesContext ctx = FacesContext.getCurrentInstance();
    	UICommand cmdLink = (UICommand)evt.getComponent();
    	List cList = cmdLink.getChildren();
    	UIParameter param = new UIParameter();
    	for (int i=0; i< cList.size(); i++)
    	{
    		Object obj = cList.get(i);
    		if (obj instanceof UIParameter)
    		{
    		  param = (UIParameter) cList.get(i);
    		}
    	}
    	ValueBinding binding =
            Util.getBinding("#{viewModulesPage}");
         ViewModulesPage vmPage = (ViewModulesPage) binding.getValue(ctx);
         vmPage.setModuleId(((Integer)param.getValue()).intValue());
         vmPage.setMdbean(null);
         try {
	  		ModuleService modServ = getModuleService();
	  		CourseModule cMod = (CourseModule)modServ.getCourseModule(((Integer)param.getValue()).intValue(),courseId);
	  		vmPage.setModuleSeqNo(cMod.getSeqNo());
		}
		catch (Exception e)
		{
	  		//e.printStackTrace();
	  		logger.error(e.toString());
		}
    }

    public String redirectToViewModule(){
    	String retVal = "view_module_student";
	    if (getInstRole() == true)
	    {
	    	retVal = "view_module";
	    }
	  else
	    {
	    	retVal = "view_module_student";
	    }
	  	return retVal;

    }
}
