/**********************************************************************************
*
* $Header: /usr/src/sakai/melete-2.4/melete-api/src/java/org/sakaiproject/api/app/melete/MeleteMigrateStatusService.java,v 1.2 2007/05/07 21:16:21 mallikat Exp $
*
***********************************************************************************
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
package org.sakaiproject.api.app.melete;

/**
 * Filename:
 * Description:
 * Author:
 * Date:
 * Copyright 2004, Foothill College
 */
public interface MeleteMigrateStatusService {
	public abstract Integer getStartFlag();

	public abstract void setStartFlag(Integer startFlag);

	public abstract Integer getCompleteFlag();

	public abstract void setCompleteFlag(Integer completeFlag);

	public abstract String toString();
}