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

import org.sakaiproject.api.app.melete.*;

/** @author Hibernate CodeGenerator */
public class ModuleShdates implements Serializable,ModuleShdatesService {

    /** identifier field */
    private Integer moduleId;

    /** nullable persistent field */
    private Date startDate;

    /** nullable persistent field */
    private Date endDate;

    /** nullable persistent field */
    private int version;

    /** identifier field */
    private org.sakaiproject.component.app.melete.Module module;

    /** full constructor */
    public ModuleShdates( Date startDate, Date endDate, int version, org.sakaiproject.component.app.melete.Module module) {
        this.startDate = startDate;
        this.endDate = endDate;
        this.version = version;
        this.module = module;
    }

    /** Custom constructor */
    public ModuleShdates(Date startDate, Date endDate) {
        this.startDate = startDate;
        this.endDate = endDate;
    }

    /** default constructor */
    public ModuleShdates() {
    }

    /** copy constructor */
    public ModuleShdates(ModuleShdates oldModuleShdates)
    {
        this.startDate = oldModuleShdates.getStartDate();
        this.endDate = oldModuleShdates.getEndDate();
        this.module = null;
    }


    public Integer getModuleId() {
        return this.moduleId;
    }

    public void setModuleId(Integer moduleId) {
        this.moduleId = moduleId;
    }

    public Date getStartDate() {
        return this.startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return this.endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
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
        this.module = (Module) module;
    }


    public String toString() {
        return new ToStringBuilder(this)
            .append("moduleId", getModuleId())
            .toString();
    }

}
