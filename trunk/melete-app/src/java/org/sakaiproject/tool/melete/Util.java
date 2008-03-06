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

import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.UnknownHostException;

import javax.faces.FactoryFinder;
import javax.faces.application.ApplicationFactory;
import javax.faces.el.ValueBinding;

import org.sakaiproject.api.app.melete.exception.MeleteException;

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

	 /*
     * validate uploaded file name to see there are no reserver characters
     * only allowed pattern is [a-zA-z0-9]_-.
     * revised on 3/31 to remove path name
     */
    public static void validateUploadFileName(String name) throws MeleteException
    {
            if(name.indexOf("#") != -1)
	  	  	{
	  	    throw new MeleteException("embed_img_bad_filename");
	  	  	}
    }

    /*
     * This method throws a MeleteException if the url does not start with
     * http:// or https://
     */
    public static void validateLink(String linkUrl) throws MeleteException
    {
    	 if( !(linkUrl.startsWith("http://") || linkUrl.startsWith("https://")))
    	{
    	  throw new MeleteException("add_section_bad_url_format");
    	}

        /*try
        {
        if(!linkUrl.startsWith(serverConfigurationService.getServerUrl()))
   	 	{
         		URL url = new URL(linkUrl);
                 HttpURLConnection uc = (HttpURLConnection) url.openConnection();
                 uc.setFollowRedirects(true);
                 uc.setInstanceFollowRedirects(false);
                 String serverReplies = uc.getResponseMessage();
                 // if link is ok server replies "OK" otherwise its null or "Not Found"
                 if(serverReplies != null && serverReplies.equals("OK"))
         		  		return "OK";
         		else return "Link possibly broken or not found";
   	 	}	else return "OK";
        }
        catch(MalformedURLException me)
        {
           logger.error(me.toString());
           errMsg = "add_section_bad_url";
           throw new MeleteException(errMsg);
        }
        catch(UnknownHostException ue)
        {
           logger.error(ue.toString());
           errMsg = "add_section_bad_url";
           throw new MeleteException(errMsg);
        }
        catch(Exception e)
        {
           logger.error(e.toString());
           errMsg = "add_section_bad_link";
           throw new MeleteException(errMsg);
        }*/
    }

}
