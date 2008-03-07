
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
import java.util.List;
import java.io.InputStream;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.UnknownHostException;
import javax.faces.component.*;

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
  private String numberItems;
  private int maxUploadSize;
  private List utList;
  protected MeleteCHService meleteCHService;
  private UIData table;

  /** Dependency:  The logging service. */
  protected Log logger = LogFactory.getLog(AddResourcesPage.class);

  public AddResourcesPage()
  {
  }

  public String getNumberItems()
  {
	return this.numberItems;
  }

  public void setNumberItems(String numberItems)
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

	  FacesContext context = FacesContext.getCurrentInstance();
	  ResourceLoader bundle = new ResourceLoader("org.sakaiproject.tool.melete.bundle.Messages");
	  String addCollId = getMeleteCHService().getUploadCollectionId();

	  //Code that validates required fields
	  int emptyCounter = 0;
	  String linkValue, titleValue;
	  boolean emptyLinkFlag = false;
	  boolean emptyTitleFlag = false;
	  for (int i=1; i<=10; i++)
	  {
		if (this.fileType.equals("upload"))
		{
			org.apache.commons.fileupload.FileItem fi = (org.apache.commons.fileupload.FileItem) context.getExternalContext().getRequestMap().get("file"+i);
			if(fi == null || fi.getName() == null || fi.getName().length() ==0)
            {
		    emptyCounter = emptyCounter + 1;
		    }
		 }
		if (this.fileType.equals("link"))
		{
			linkValue = (String)context.getExternalContext().getRequestMap().get("link"+i);
			titleValue = (String)context.getExternalContext().getRequestMap().get("title"+i);
			if (((linkValue == null)||(linkValue.trim().length() == 0))&&((titleValue == null)||(titleValue.trim().length() == 0)))
			{
			  emptyCounter = emptyCounter + 1;
			}
			else
			{
				if (((linkValue == null)||(linkValue.trim().length() == 0))&&((titleValue != null)&&(titleValue.trim().length() > 0)))
				{
					emptyLinkFlag = true;
					break;
				}
				if (((linkValue != null)&&(linkValue.trim().length() > 0))&&((titleValue == null)||(titleValue.trim().length() == 0)))
				{
					emptyTitleFlag = true;
					break;
				}
			}
		}

	  }
	  try
	  {
		if (this.fileType.equals("upload"))
		{
			if (emptyCounter == 10) throw new MeleteException("all_uploads_empty");
		}
		if (this.fileType.equals("link"))
		{
			if (emptyCounter == 10) throw new MeleteException("all_links_empty");
			if (emptyLinkFlag == true) throw new MeleteException("link_empty");
			if (emptyTitleFlag == true) throw new MeleteException("title_empty");
		}
	  }
	  catch (MeleteException mex)
      {
		  String errMsg = bundle.getString(mex.getMessage());
	      context.addMessage (null, new FacesMessage(FacesMessage.SEVERITY_ERROR,mex.getMessage(),errMsg));
		  return "failure";
      }

      for (int i=1; i<=10; i++)
      {
    	try
        {
        if(this.fileType.equals("upload"))
        {
              org.apache.commons.fileupload.FileItem fi = (org.apache.commons.fileupload.FileItem) context.getExternalContext().getRequestMap().get("file"+i);

              if(fi !=null && fi.getName() != null && fi.getName().length() !=0)
              {
                 Util.validateUploadFileName(fi.getName());
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

                 addItem(secResourceName,secContentMimeType, addCollId, secContentData);
               }
               else
               {
                  logger.info("File being uploaded is NULL");
                  continue;
                }
            }//End if filetype is upload
            if (this.fileType.equals("link"))
            {
              secContentMimeType=getMeleteCHService().MIME_TYPE_LINK;
              String linkUrl = (String) context.getExternalContext().getRequestMap().get("link"+i);
              secResourceName = (String) context.getExternalContext().getRequestMap().get("title"+i);
              Util.validateLink(linkUrl);

              if ((linkUrl != null)&&(linkUrl.trim().length() > 0)&&(secResourceName != null)&&(secResourceName.trim().length() > 0))
              {
                secContentData = new byte[linkUrl.length()];
                secContentData = linkUrl.getBytes();
                addItem(secResourceName,secContentMimeType, addCollId, secContentData);
              }
             }//End if filetype is link
            }
            catch (MeleteException mex)
            {
              String errMsg = bundle.getString(mex.getMessage());
      	      context.addMessage (null, new FacesMessage(FacesMessage.SEVERITY_ERROR,mex.getMessage(),errMsg));
			  return "failure";
            }
            catch(Exception e)
            {
              logger.error("file upload FAILED" + e.toString());
             }
           }

	    return "manage_content";
      }


  private void addItem(String secResourceName, String secContentMimeType,String addCollId, byte[] secContentData) throws MeleteException
  {
	  ResourcePropertiesEdit res = getMeleteCHService().fillInSectionResourceProperties(false,secResourceName,"");
      if (logger.isDebugEnabled()) logger.debug("add resource now " + secContentData );
      try
      {
        String newResourceId = getMeleteCHService().addResourceItem(secResourceName,secContentMimeType, addCollId, secContentData,res );
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
	     throw new MeleteException("add_item_fail");
	   }
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

public List getUtList()
{
	utList = new ArrayList();
	if (this.fileType.equals("link"))
	{
		for (int i=0; i< Integer.parseInt(this.numberItems); i++)
		{
			UrlTitleObj utObj = new UrlTitleObj("hello","hello");
			utList.add(utObj);
		}
	}
	return this.utList;
}

public void setUtList(List utList)
{
	this.utList = utList;
}
public class UrlTitleObj{
	String url,title;
	public UrlTitleObj(String url, String title)
	{
		this.url = url;
		this.title = title;
	}
	public String getUrl()
	{
		return this.url;
	}
	public void setUrl(String url)
	{
		this.url = url;
	}
	public String getTitle()
	{
		return this.title;
	}
	public void setTitle(String title)
	{
		this.title = title;
	}
}
public UIData getTable()
{
	return this.table;
}

public void setTable(UIData table)
{
	this.table = table;
}

}

