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
import org.apache.commons.lang.builder.ToStringBuilder;

import org.sakaiproject.api.app.melete.MeleteLicenseService;

/** @author Hibernate CodeGenerator */
public class MeleteLicense implements Serializable,MeleteLicenseService {

    /** identifier field */
    private Integer code;

    /** nullable persistent field */
    private String description;

    /** full constructor */
    public MeleteLicense(Integer code, String description) {
        this.code = code;
        this.description = description;
    }

    /** default constructor */
    public MeleteLicense() {
    }

    /** minimal constructor */
    public MeleteLicense(Integer code) {
        this.code = code;
    }

    public Integer getCode() {
        return this.code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getDescription() {
        return this.description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("code", getCode())
            .toString();
    }

}
