/**********************************************************************************
 *
 * $URL: https://source.sakaiproject.org/contrib/etudes/melete/trunk/melete-app/src/java/org/etudes/tool/melete/BookmarkPage.java $
 * $Id: BookmarkPage.java 56408 2008-12-19 21:16:52Z mallika@etudes.org $
 ***********************************************************************************
 * Copyright (c) 2010 Etudes, Inc.
 *
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

package org.etudes.tool.melete;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.etudes.component.app.melete.*;
import org.etudes.api.app.melete.*;
import org.sakaiproject.util.ResourceLoader;

import javax.faces.application.Application;
import javax.faces.application.FacesMessage;
import javax.faces.component.html.*;
import javax.faces.component.*;

import java.util.List;
import java.util.ListIterator;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import java.io.*;

import javax.faces.context.FacesContext;
import javax.faces.el.ValueBinding;
import javax.faces.event.AbortProcessingException;
import javax.faces.event.ValueChangeEvent;

import org.etudes.api.app.melete.BookmarkService;
import org.etudes.api.app.melete.BookmarkObjService;

public class BookmarkPage implements Serializable
{

	/** identifier field */

	private BookmarkObjService bookmark;

	private BookmarkService bookmarkService;

	private String sectionId;

	/** Dependency:  The logging service. */
	protected Log logger = LogFactory.getLog(BookmarkPage.class);

	public BookmarkPage()
	{

	}


	public String addBookmark()
	{
	  FacesContext context = FacesContext.getCurrentInstance();
	  Map sessionMap = context.getExternalContext().getSessionMap();

	  if (bookmarkService == null)
	    bookmarkService = getBookmarkService();

	  /*if (bookmark == null)
	    bookmark = new Bookmark();*/

	    this.bookmark.setSiteId((String)sessionMap.get("courseId"));
	    this.bookmark.setUserId((String)sessionMap.get("userId"));
	    this.bookmark.setSectionId(Integer.parseInt(this.sectionId));
	    try
	    {
	      bookmarkService.insertBookmark(this.bookmark);
	    }catch(Exception ex)
		{
		   //TODO replace this with add bookmark fail msg
			/*String errMsg = bundle.getString("add_module_fail");
			addMessage(context, "Error Message", errMsg, FacesMessage.SEVERITY_ERROR);
			return "add_module";*/
		}
		return "confirm_bookmark";

	}
	public void resetValues()
	{

	}

    public BookmarkObjService getBookmark() {
	  FacesContext context = FacesContext.getCurrentInstance();
	  Map sessionMap = context.getExternalContext().getSessionMap();
	  if (bookmark == null)
	  {
		  bookmark = bookmarkService.getBookmark((String)sessionMap.get("userId"),(String)sessionMap.get("courseId"),Integer.parseInt(this.sectionId));
          if (bookmark == null) bookmark = new Bookmark();
	  }
	return bookmark;
    }

   public void setBookmark(BookmarkObjService bookmark) {
    this.bookmark = bookmark;
  }

  public String getSectionId() {
      return sectionId;
   }

   public void setSectionId(String sectionId) {
     this.sectionId = sectionId;
   }
	/**
	 * @return Returns the BookmarkService.
	 */
	public BookmarkService getBookmarkService()
	{
		return bookmarkService;
	}

	/**
	 * @param bookmarkService The bookmarkService to set.
	 */
	public void setBookmarkService(BookmarkService bookmarkService)
	{
		this.bookmarkService = bookmarkService;
	}


}
