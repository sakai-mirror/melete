/**********************************************************************************
*
* $Header: /usr/src/sakai/melete-2.4/melete-app/src/java/org/sakaiproject/tool/melete/ModuleValidator.java,v 1.5 2007/05/10 13:08:46 ddelblanco Exp $
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

import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.validator.Validator;
import javax.faces.validator.ValidatorException;
import javax.faces.application.FacesMessage;

//import com.sun.faces.util.MessageFactory;

import org.sakaiproject.util.ResourceLoader;
import java.util.StringTokenizer;
/**
 * @author Rashmi
 *
 * This class validates user input for title, keywords and if learning objectives or
 * description is there.
 *
 * for title , rules are special characters allowed are , / - & _
 * for keywords, rules are warn user if keywords is more than 3 words and not
 *  comma seperated.
 *
 * Revision -- 12/13 added invalid-title_len for cases like '    5' and '    5'.
 * Revised by rashmi on 6/14/05 - min length allowed is 3 chars
 * Mallika - 4/24/06 - adding + to title
 * Mallika - 5/31/06 - adding ! to title
 * Rashmi - 1/2/07 - add ing : to title
 **/

public class ModuleValidator implements Validator {

	public void validate(FacesContext context, UIComponent component, Object value)
	throws ValidatorException
	{
		String val = (String) value;
		val = val.trim();
		int len =val.length();

		if(len < 3 || len > 50)
		{
			ResourceLoader bundle = new ResourceLoader("org.sakaiproject.tool.melete.bundle.Messages");
			String errMsg = "";
	     	errMsg = bundle.getString("invalid_title_len");
	        throw new ValidatorException(new FacesMessage(errMsg));
		}
		if (!isValidTitle(val))
		{
			ResourceLoader bundle = new ResourceLoader("org.sakaiproject.tool.melete.bundle.Messages");
			String errMsg = "";
	     	errMsg = bundle.getString("invalid_title");
	        throw new ValidatorException(new FacesMessage(errMsg));
		}
	}
	/**
	 * @param title
	 * @return
	 * Revision -- 11/29 Rashmi
	 * check if string is empty or just spaces
	 *
	 */
	public boolean isValidTitle(String title)
	{
		int len =title.length();

		for(int i=0; i < len; i++)
		{
			char c = title.charAt(i);

			if (!Character.isLetterOrDigit(c))
				if(!(c == ' ' ||c == ',' || c=='/' || c=='-' || c=='&' || c=='_' || c=='\'' || c=='.' || c=='?' || c=='+' || c=='!' || c==':'))
				{
					return false;
				}
		}
		return true;
	}


}