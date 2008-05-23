/**********************************************************************************
*
* $Header: /usr/src/sakai/melete-2.4/melete-impl/src/java/org/sakaiproject/component/app/melete/MeleteBookmarksServiceImpl.java,v 1.4 2007/05/29 18:57:37 mallikat Exp $
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
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.sakaiproject.api.app.melete.MeleteBookmarksService;
import org.sakaiproject.api.app.melete.MeleteBookmarksObjService;
import org.sakaiproject.api.app.melete.MeleteUserPreferenceService;
import org.sakaiproject.api.app.melete.exception.MeleteException;

public class MeleteBookmarksServiceImpl implements Serializable, MeleteBookmarksService{
private Log logger = LogFactory.getLog(MeleteBookmarksServiceImpl.class);
private MeleteBookmarksDB bookmarksdb;


  /**
 * {@inheritDoc}
 */
public void insertBookmark(MeleteBookmarksObjService mb) throws Exception
  {
	try{
		bookmarksdb.setBookmarks((MeleteBookmarks)mb);
	}catch(Exception e)
	{
		logger.error("melete bookmarks business --add bookmark failed");
		 throw new MeleteException("add_bookmark_fail");
	}
	return;
  }

public int getBookmarksCount(String userId, String courseId)
{
	 int bookmarksCount = 0;
		try{
			bookmarksCount = bookmarksdb.getBookmarksCount(userId, courseId);
		}catch(Exception e)
		{
			logger.error("melete bookmarks business --get bookmarks count failed");
		}
		return bookmarksCount;	
}

public List getBookmarks(String userId, String courseId)
{
  List bookmarks = null;
	try{
		bookmarks = bookmarksdb.getBookmarks(userId, courseId);
	}catch(Exception e)
	{
		logger.error("melete bookmarks business --get bookmarks failed");
	}
	return bookmarks;
}
public List getBookmarks(String userId, String courseId, Integer moduleId)
{
  List bookmarks = null;
	try{
		bookmarks = bookmarksdb.getBookmarks(userId, courseId, moduleId);
	}catch(Exception e)
	{
		logger.error("melete bookmarks business --get bookmarks failed");
	}
	return bookmarks;
}
public List getBookmarks(String userId, String courseId, Integer moduleId, Integer sectionId)
{
  List bookmarks = null;
	try{
		bookmarks = bookmarksdb.getBookmarks(userId, courseId, moduleId, sectionId);
	}catch(Exception e)
	{
		logger.error("melete bookmarks business --get bookmarks failed");
	}
	return bookmarks;
}

  /**
 * {@inheritDoc}
 */


  /**
 * {@inheritDoc}
 */
public void deleteBookmark(MeleteBookmarksObjService mb)  throws Exception
  {
	try{
		bookmarksdb.deleteBookmark((MeleteBookmarks)mb);
	}catch(Exception e)
	{
	  logger.error("melete bookmarks business --delete bookmark failed");
	  throw new MeleteException("Clear_bookmarks_fail");
	}
  }

  /**
 * {@inheritDoc}
 */
public void deleteAllBookmarks(String userId, String courseId) throws Exception
  {
	try{
		bookmarksdb.deleteAllBookmarks(userId, courseId);
	}catch(Exception e)
		{
		logger.error("melete bookmarks business --delete bookmark failed");
		 throw new MeleteException("Clear_bookmarks_fail");
		}	
  }

  /**
	 * @param logger The logger to set.
	 */
  public void setLogger(Log logger)
  {
	    this.logger = logger;
  }

  public MeleteBookmarksDB getBookmarksdb()
  {
	return this.bookmarksdb;
  }

  public void setBookmarksdb(MeleteBookmarksDB bookmarksdb)
  {
	this.bookmarksdb = bookmarksdb;
  }
	
}
