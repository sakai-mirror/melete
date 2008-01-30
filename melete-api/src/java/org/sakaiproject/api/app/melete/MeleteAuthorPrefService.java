/**********************************************************************************
*
* $Header: /usr/src/sakai/melete-2.4/melete-api/src/java/org/sakaiproject/api/app/melete/MeleteAuthorPrefService.java,v 1.3 2007/05/21 18:33:11 mallikat Exp $
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
package org.sakaiproject.api.app.melete;

import java.util.Set;

import org.sakaiproject.api.app.melete.MeleteUserPreferenceService;
/*
* author Rashmi - 10/11/06 
 */
public interface MeleteAuthorPrefService{
	public void insertUserChoice(MeleteUserPreferenceService mup) throws Exception;
	public MeleteUserPreferenceService getUserChoice(String user_id);
	public void insertUserSiteChoice(MeleteSitePreferenceService msp) throws Exception;
	public MeleteSitePreferenceService getSiteChoice(String site_id);
}