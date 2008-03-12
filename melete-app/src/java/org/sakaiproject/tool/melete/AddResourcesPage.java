
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
import java.util.Iterator;
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
import javax.faces.event.*;

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
  private int removeLinkIndex;
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

  public void resetValues()
  {
	  this.utList = null;
	  this.numberItems = null;
	  this.fileType = null;
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


	  }
	  try
	  {
		if (this.fileType.equals("upload"))
		{
			if (emptyCounter == 10) throw new MeleteException("all_uploads_empty");
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
      if(this.fileType.equals("link"))
      {
      Iterator utIterator = utList.iterator();
      while (utIterator.hasNext())
      {
    	  UrlTitleObj utObj = (UrlTitleObj) utIterator.next();
    	  try
    	  {
            if (this.fileType.equals("link"))
            {
              secContentMimeType=getMeleteCHService().MIME_TYPE_LINK;
              String linkUrl = utObj.getUrl();
              secResourceName = utObj.getTitle();
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

  public void updateNumber(ValueChangeEvent event)throws AbortProcessingException
  {
          UIInput numberItemsInput = (UIInput)event.getComponent();

          this.numberItems = (String)numberItemsInput.getValue();

          if (Integer.parseInt(this.numberItems) > this.utList.size())
          {
        	  int newItemsCount = Integer.parseInt(this.numberItems) - this.utList.size();
        	  for (int i=0; i< newItemsCount; i++)
        	  {
        		UrlTitleObj utObj = new UrlTitleObj("http://","");
      			this.utList.add(utObj);
        	  }
          }
          if (Integer.parseInt(this.numberItems) < this.utList.size())
          {
        	  int listSize = this.utList.size();
        	   for (int i=Integer.parseInt(this.numberItems); i< listSize; i++)
        	  {

        		  this.utList.remove(Integer.parseInt(this.numberItems));
        	  }
          }


  }

  public void removeLink(ActionEvent evt)
  {
	  FacesContext ctx = FacesContext.getCurrentInstance();
      UICommand cmdLink = (UICommand)evt.getComponent();
	  String selclientId = cmdLink.getClientId(ctx);
	  selclientId = selclientId.substring(selclientId.indexOf(':')+1);
	  selclientId = selclientId.substring(selclientId.indexOf(':')+1);
	  String rowId = selclientId.substring(0,selclientId.indexOf(':'));
	  this.removeLinkIndex = Integer.parseInt(rowId);
	  if (Integer.parseInt(this.numberItems) > 1)
	  {	  
	    this.numberItems = String.valueOf(Integer.parseInt(this.numberItems) - 1);
	    this.utList.remove(this.removeLinkIndex);
	  }  
	  else
	  {
		  this.utList = new ArrayList();
		  this.utList.add(new UrlTitleObj("http://",""));
	  }

  }

  public String redirectToLinkUpload()
  {
	  return "link_upload_view";
  }

  public String cancel()
  {
	  resetValues();
	  return "manage_content";
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
	if (this.utList == null)
	{
	utList = new ArrayList();
	if (this.fileType.equals("link"))
	{
		for (int i=0; i< Integer.parseInt(this.numberItems); i++)
		{
			UrlTitleObj utObj = new UrlTitleObj("http://","");
			utList.add(utObj);
		}
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

