/**********************************************************************************
*
* $Header: 
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

import org.sakaiproject.api.app.melete.MeleteUserPreferenceService;

/** @author Hibernate CodeGenerator */
public class MeleteUserPreference implements Serializable,MeleteUserPreferenceService {

    /** identifier field */
    private String userId;

    /** nullable persistent field */
    private String editorChoice;
    
    private boolean viewExpChoice;

    private boolean printable;
    
    private int prefId;
   
	/** full constructor
	 * @param userId
	 * @param editorChoice
	 */
	public MeleteUserPreference(String userId, String editorChoice, boolean viewExpChoice, boolean printable) {
		this.userId = userId;
		this.editorChoice = editorChoice;
		this.viewExpChoice = viewExpChoice;
		this.printable = printable;
	}
		
	/**
	 *  default
	 */
	public MeleteUserPreference() {
		this.viewExpChoice = true;
		this.printable = false;
	}
		
	/**
	 * @return Returns the editorChoice.
	 */
	public String getEditorChoice() {
		return editorChoice;
	}
	/**
	 * @param editorChoice The editorChoice to set.
	 */
	public void setEditorChoice(String editorChoice) {
		this.editorChoice = editorChoice;
	}
	/**
	 * @return Returns the userId.
	 */
	public String getUserId() {
		return userId;
	}
	/**
	 * @param userId The userId to set.
	 */
	public void setUserId(String userId) {
		this.userId = userId;
	}
    public String toString() {
        return new ToStringBuilder(this)
            .append("prefId", getPrefId())
            .toString();
    }

	/**
	 * @return Returns the prefId.
	 */
	public int getPrefId() {
		return prefId;
	}
	/**
	 * @param prefId The prefId to set.
	 */
	public void setPrefId(int prefId) {
		this.prefId = prefId;
	}

	public boolean isViewExpChoice() {
		return viewExpChoice;
	}

	public void setViewExpChoice(boolean viewExpChoice) {
		this.viewExpChoice = viewExpChoice;
	}
	
}
