
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
 * Created on Oct 10, 2006  @author Rashmi
 *
 * Captures author preferences
 *
 *
 */
package org.sakaiproject.tool.melete;

import java.util.ArrayList;
import java.util.Map;
import java.util.Set;
import java.io.InputStream;

import org.sakaiproject.util.ResourceLoader;

import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.faces.model.SelectItem;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.sakaiproject.api.app.melete.exception.MeleteException;
import org.sakaiproject.api.app.melete.MeleteCHService;
import org.sakaiproject.component.cover.ServerConfigurationService;
import org.sakaiproject.entity.api.ResourcePropertiesEdit;

public class AddResourcesPage {
  private String fileType;
  private int numberItems;
  private int maxUploadSize;
  protected MeleteCHService meleteCHService;

  /** Dependency:  The logging service. */
	protected Log logger = LogFactory.getLog(AddResourcesPage.class);

  public AddResourcesPage()
  {
  }

  public int getNumberItems()
  {
	return this.numberItems;
  }

  public void setNumberItems(int numberItems)
  {
	this.numberItems = numberItems;
  }

  public int getMaxUploadSize()
  {
        /*
         * get from session
         */
          FacesContext context = FacesContext.getCurrentInstance();
          Map sessionMap = context.getExternalContext().getSessionMap();


         int sz = Integer.parseInt((String)sessionMap.get("maxSize"));
          if (logger.isDebugEnabled()) logger.debug("Size is "+sz);


        return sz;
  }

  public String addItems()
  {
	  byte[] secContentData;
	  String secResourceName;
	  String secContentMimeType;


	  if(this.fileType.equals("upload"))
      {
             for (int i=1; i<=10; i++)
             {
               try
               {
                 FacesContext context = FacesContext.getCurrentInstance();
                 org.apache.commons.fileupload.FileItem fi = (org.apache.commons.fileupload.FileItem) context.getExternalContext().getRequestMap().get("file"+i);

                 if(fi !=null && fi.getName() != null && fi.getName().length() !=0)
                 {
                   validateUploadFileName(fi.getName());
                   // filename on the client
                   secResourceName = fi.getName();
                   if (secResourceName.indexOf("/") != -1)
                   {
                     secResourceName = secResourceName.substring(secResourceName.lastIndexOf("/")+1);
                   }
                   if (secResourceName.indexOf("\\") != -1)
                   {
                     secResourceName = secResourceName.substring(secResourceName.lastIndexOf("\\")+1);
                   }
                   if (logger.isDebugEnabled()) logger.debug("Rsrc name is "+secResourceName);
                   if (logger.isDebugEnabled()) logger.debug("upload section content data " + (int)fi.getSize());
                   secContentData= new byte[(int)fi.getSize()];
                   InputStream is = fi.getInputStream();
                   is.read(secContentData);

                   secContentMimeType = fi.getContentType();
                   if (logger.isDebugEnabled()) logger.debug("file upload success" + secContentMimeType);
                   if (logger.isDebugEnabled()) logger.debug("new names for upload content is" + secContentMimeType +"," + secResourceName);
                   ResourcePropertiesEdit res = getMeleteCHService().fillInSectionResourceProperties(false,secResourceName,"");
                   if (logger.isDebugEnabled()) logger.debug("add resource now " + secContentData );
                   try
                   {
        	         String newResourceId = getMeleteCHService().addResourceItem(secResourceName,secContentMimeType,getMeleteCHService().getUploadCollectionId(),secContentData,res );
   		           }
   		           catch(MeleteException me)
   			       {
   			         logger.error("error in creating resource for section content");
   			         throw me;
   			       }
   		           catch(Exception e)
   			       {
   			         logger.error("error in creating resource for section content");
   			         e.printStackTrace();
   			         throw new MeleteException("add_section_fail");
   			       }
                  }
                  else
                  {
                      logger.info("File being uploaded is NULL");
                      continue;
                  }
                }
               	catch(Exception e)
                {
                    logger.error("file upload FAILED" + e.toString());
                }

             }
        }
	    return "manage_content";
      }

  public boolean validateUploadFileName(String name) throws MeleteException
  {
    if (logger.isDebugEnabled()) logger.debug("file name for validation is" + name);
        if(name.indexOf("#") != -1)
  	  	{
  	  	logger.error("embedded FILE contains hash or other characters " + name);
	    throw new MeleteException("embed_img_bad_filename");
  	  	}
     return true;
  }


public MeleteCHService getMeleteCHService()
{
	return this.meleteCHService;
}

public void setMeleteCHService(MeleteCHService meleteCHService)
{
	this.meleteCHService = meleteCHService;
}

public String getFileType()
{
	return this.fileType;
}

public void setFileType(String fileType)
{
	this.fileType = fileType;
}
}
