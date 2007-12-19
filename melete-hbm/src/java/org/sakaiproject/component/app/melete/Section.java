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
import java.util.Date;
import org.apache.commons.lang.builder.ToStringBuilder;

import org.sakaiproject.api.app.melete.SectionObjService;

/* Filename:
 * Description:
 * Author:
 * Date:
 * Copyright 2004, Foothill College
 * Mallika - 4/24/06 - adding 'untitled section' default title
 */

/** @author Hibernate CodeGenerator */
public class Section implements Serializable,SectionObjService {

	  /** identifier field */
    private Integer sectionId;

    /** nullable persistent field */
    private int moduleId;

    /** persistent field */
    private String title = "Untitled section";

    /** persistent field */
    private String createdByFname;

    /** persistent field */
    private String createdByLname;

    /** nullable persistent field */
    private String modifiedByFname;

    /** nullable persistent field */
    private String modifiedByLname;

    /** nullable persistent field */
    private String instr;

    /** persistent field */
    private String contentType;

  
    /** nullable persistent field */
    private boolean audioContent;

    /** nullable persistent field */
    private boolean videoContent;

    /** nullable persistent field */
    private boolean textualContent;

    /** nullable persistent field */
    private boolean deleteFlag;

    /** persistent field */
    private Date creationDate;

    /** persistent field */
    private Date modificationDate;

    /** nullable persistent field */
    private int version;

    /** nullable persistent field */
    private org.sakaiproject.component.app.melete.Module module;

    /** nullable persistent field */
    private org.sakaiproject.component.app.melete.SectionResource sectionResource;

    /** full constructor */
    public Section(int moduleId, String title, String createdByFname, String createdByLname, String modifiedByFname, String modifiedByLname, String instr, String contentType, boolean audioContent, boolean videoContent, boolean textualContent, boolean deleteFlag, Date creationDate, Date modificationDate, int version, org.sakaiproject.component.app.melete.Module module, org.sakaiproject.component.app.melete.SectionResource sectionResource) {
        this.moduleId = moduleId;
        this.title = title;
        this.createdByFname = createdByFname;
        this.createdByLname = createdByLname;
        this.modifiedByFname = modifiedByFname;
        this.modifiedByLname = modifiedByLname;
        this.instr = instr;
        this.contentType = contentType;
        this.audioContent = audioContent;
        this.videoContent = videoContent;
        this.textualContent = textualContent;
        this.deleteFlag = deleteFlag;
        this.creationDate = creationDate;
        this.modificationDate = modificationDate;
        this.version = version;
        this.module = module;
        this.sectionResource = sectionResource;
    }
    /** Custom constructor */
    public Section(String title, String createdByFname, String createdByLname, String modifiedByFname, String modifiedByLname, String instr, String contentType, boolean audioContent, boolean videoContent, boolean textualContent, boolean deleteFlag, Date creationDate, Date modificationDate) {
        this.title = title;
        this.createdByFname = createdByFname;
        this.createdByLname = createdByLname;
        this.modifiedByFname = modifiedByFname;
        this.modifiedByLname = modifiedByLname;
        this.instr = instr;
        this.contentType = contentType;
        this.audioContent = audioContent;
        this.videoContent = videoContent;
        this.textualContent = textualContent;
        this.deleteFlag = deleteFlag;
        this.creationDate = creationDate;
        this.modificationDate = modificationDate;
    }
    /** default constructor */
    public Section() {
    }

    /** minimal constructor */
    public Section(String title, String createdByFname, String createdByLname, String contentType, Date creationDate, Date modificationDate) {
        this.title = title;
        this.createdByFname = createdByFname;
        this.createdByLname = createdByLname;
        this.contentType = contentType;
        this.creationDate = creationDate;
        this.modificationDate = modificationDate;
    }

    /** copy constructor */
    public Section(Section oldSection) {
           this.title = oldSection.getTitle();
           this.instr = oldSection.getInstr();
           this.contentType = oldSection.getContentType();
           this.audioContent = oldSection.isAudioContent();
           this.videoContent = oldSection.isVideoContent();
           this.textualContent = oldSection.isTextualContent();
           this.deleteFlag = oldSection.isDeleteFlag();
           this.module = null;
           this.sectionResource = null;
    }
    
    public Integer getSectionId() {
        return this.sectionId;
    }

    public void setSectionId(Integer sectionId) {
        this.sectionId = sectionId;
    }

    public int getModuleId() {
        return this.moduleId;
    }

    public void setModuleId(int moduleId) {
        this.moduleId = moduleId;
    }


    public String getTitle() {
        return this.title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCreatedByFname() {
        return this.createdByFname;
    }

    public void setCreatedByFname(String createdByFname) {
        this.createdByFname = createdByFname;
    }

    public String getCreatedByLname() {
        return this.createdByLname;
    }

    public void setCreatedByLname(String createdByLname) {
        this.createdByLname = createdByLname;
    }

    public String getModifiedByFname() {
        return this.modifiedByFname;
    }

    public void setModifiedByFname(String modifiedByFname) {
        this.modifiedByFname = modifiedByFname;
    }

    public String getModifiedByLname() {
        return this.modifiedByLname;
    }

    public void setModifiedByLname(String modifiedByLname) {
        this.modifiedByLname = modifiedByLname;
    }

    public String getInstr() {
        return this.instr;
    }

    public void setInstr(String instr) {
        this.instr = instr;
    }

    public String getContentType() {
        return this.contentType;
    }

    public void setContentType(String contentType) {
        this.contentType = contentType;
    }


    public boolean isAudioContent() {
        return this.audioContent;
    }

    public void setAudioContent(boolean audioContent) {
        this.audioContent = audioContent;
    }

    public boolean isVideoContent() {
        return this.videoContent;
    }

    public void setVideoContent(boolean videoContent) {
        this.videoContent = videoContent;
    }

    public boolean isTextualContent() {
        return this.textualContent;
    }

    public void setTextualContent(boolean textualContent) {
        this.textualContent = textualContent;
    }
    public boolean isDeleteFlag() {
        return this.deleteFlag;
    }

    public void setDeleteFlag(boolean deleteFlag) {
        this.deleteFlag = deleteFlag;
    }

    public Date getCreationDate() {
        return this.creationDate;
    }

    public void setCreationDate(Date creationDate) {
        this.creationDate = creationDate;
    }

    public Date getModificationDate() {
        return this.modificationDate;
    }

    public void setModificationDate(Date modificationDate) {
        this.modificationDate = modificationDate;
    }

    public int getVersion() {
        return this.version;
    }

    public void setVersion(int version) {
        this.version = version;
    }

    public org.sakaiproject.api.app.melete.ModuleObjService getModule() {
        return this.module;
    }

    public void setModule(org.sakaiproject.api.app.melete.ModuleObjService module) {
        this.module = (Module)module;
    }

    public org.sakaiproject.api.app.melete.SectionResourceService getSectionResource() {
        return this.sectionResource;
    }

    public void setSectionResource(org.sakaiproject.api.app.melete.SectionResourceService sectionResource) {
        this.sectionResource = (SectionResource)sectionResource;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("sectionId", getSectionId())
            .toString();
    }

}