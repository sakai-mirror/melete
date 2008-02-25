/*******************************************************************************
 * 
 * $Header:
 * /usr/src/sakai/melete_2-1-0/melete-app/src/java/org/sakaiproject/tool/melete/Util.java,v
 * 1.1 2005/11/23 21:37:24 murthyt Exp $
 * 
 * **********************************************************************************
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
 ******************************************************************************/
package org.sakaiproject.tool.melete;

import javax.faces.FactoryFinder;
import javax.faces.application.ApplicationFactory;
import javax.faces.el.ValueBinding;

public class Util {
	public static ValueBinding getBinding(String bindingName) {
		ApplicationFactory factory = (ApplicationFactory) FactoryFinder
				.getFactory(FactoryFinder.APPLICATION_FACTORY);
		ValueBinding binding = factory.getApplication().createValueBinding(
				bindingName);
		return binding;
	}

	//Diego del Blanco y David Roldán - 2/14/06 -- For avoiding the xxxxxxx
	// patterns...
	public static String replace(String s, String one, String another) {
		// In a string replace one substring with another
		if (s.equals(""))
			return "";
		String res = "";
		int i = s.indexOf(one, 0);
		int lastpos = 0;
		while (i != -1) {
			res += s.substring(lastpos, i) + another;
			lastpos = i + one.length();
			i = s.indexOf(one, lastpos);
		}
		res += s.substring(lastpos); // the rest
		return res;
	}
}
