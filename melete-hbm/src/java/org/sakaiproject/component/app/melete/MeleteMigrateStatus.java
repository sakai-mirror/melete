/**********************************************************************************
 *
 * $URL$
 *
 ***********************************************************************************
 *
 * Copyright (c) 2008 Etudes, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
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
package org.sakaiproject.component.app.melete;

import java.io.Serializable;
import org.apache.commons.lang.builder.ToStringBuilder;

import org.sakaiproject.api.app.melete.MeleteMigrateStatusService;

/** @author Hibernate CodeGenerator */
public class MeleteMigrateStatus implements Serializable,MeleteMigrateStatusService {

    /** identifier field */
    private Integer startFlag;
    private Integer completeFlag;

    /** full constructor */
    public MeleteMigrateStatus(Integer startFlag, Integer completeFlag) {
        this.startFlag = startFlag;
        this.completeFlag = completeFlag;
    }

    /** default constructor */
    public MeleteMigrateStatus() {
    }

    public Integer getStartFlag() {
        return this.startFlag;
    }

    public void setStartFlag(Integer startFlag) {
        this.startFlag = startFlag;
    }

    public Integer getCompleteFlag() {
        return this.completeFlag;
    }

    public void setCompleteFlag(Integer completeFlag) {
        this.completeFlag = completeFlag;
    }

    public String toString() {
        return new ToStringBuilder(this)
            .append("startFlag", getStartFlag())
            .append("completeFlag", getCompleteFlag())
            .toString();
    }

}
