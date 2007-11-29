/**********************************************************************************
*
* $Header: /usr/src/sakai/melete-2.4/melete-impl/src/java/org/sakaiproject/component/app/melete/MeleteAuthorPrefServiceImpl.java,v 1.4 2007/05/29 18:57:37 mallikat Exp $
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

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.sakaiproject.api.app.melete.MeleteAuthorPrefService;
import org.sakaiproject.api.app.melete.MeleteUserPreferenceService;
import org.sakaiproject.api.app.melete.exception.MeleteException;

public class MeleteAuthorPrefServiceImpl implements Serializable, MeleteAuthorPrefService{
private Log logger = LogFactory.getLog(MeleteAuthorPrefServiceImpl.class);
private MeleteUserPreferenceDB userPrefdb;


public void insertUserChoice(MeleteUserPreferenceService mup) throws Exception
	{
		try{
			userPrefdb.setUserPreferences((MeleteUserPreference)mup);
		}catch(Exception e)
			{
			logger.error("melete user pref business --add editor choice failed");
			 throw new MeleteException("add_editorchoice_fail");

			}
		return;
	}

public MeleteUserPreferenceService getUserChoice(String user_id)
	{
	MeleteUserPreference mup = null;
		try{
			mup = userPrefdb.getUserPreferences(user_id);
		}catch(Exception e)
			{
			logger.error("melete user pref business --get editor choice failed");
			}
		return mup;
	}

/**
	 * @param logger The logger to set.
	 */
	public void setLogger(Log logger)
	  {
	    this.logger = logger;
	  }
	/**
	 * @return Returns the UserPrefdb
	 */
	public MeleteUserPreferenceDB getUserPrefdb() {
		return userPrefdb;
	}
	/**
	 * @param UserPrefdb The UserPrefdb to set.
	 */
	public void setUserPrefdb(MeleteUserPreferenceDB userPrefdb) {
		this.userPrefdb = userPrefdb;
	}

}
