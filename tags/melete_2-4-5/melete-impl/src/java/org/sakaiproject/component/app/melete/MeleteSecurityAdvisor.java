/*
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
 * Created on Jan 19, 2007
 * @author Faculty
 * 
 */
package org.sakaiproject.component.app.melete;
import org.sakaiproject.authz.api.SecurityAdvisor;


public class MeleteSecurityAdvisor implements SecurityAdvisor {

	   public SecurityAdvice isAllowed(String userId, String function, String reference) {
	      return SecurityAdvice.ALLOWED;
	   }
}
