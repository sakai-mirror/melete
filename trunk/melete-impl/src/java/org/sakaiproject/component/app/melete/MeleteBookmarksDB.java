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
 * Created on Oct 11, 2006
 *
 * author Rashmi
 */
package org.sakaiproject.component.app.melete;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.hibernate.HibernateException;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.StaleObjectStateException;
import org.hibernate.Transaction;


public class MeleteBookmarksDB {
	private HibernateUtil hibernateUtil;
	private Log logger = LogFactory.getLog(MeleteBookmarksDB.class);

	/**
	 * default constructor
	 */
	public MeleteBookmarksDB() {

	}

	public void setBookmarks(MeleteBookmarks mb) throws Exception
	{
		Transaction tx = null;
	 	try
		{

	      Session session = hibernateUtil.currentSession();

	      tx = session.beginTransaction();


	      session.save(mb);

	      tx.commit();

	    }
	 	catch(StaleObjectStateException sose)
	     {
			if(tx !=null) tx.rollback();
			logger.error("stale object exception" + sose.toString());
			throw sose;
	     }
	    catch (HibernateException he)
	    {
		  logger.error(he.toString());
		  throw he;
	    }
	    catch (Exception e) {
	      if (tx!=null) tx.rollback();
	      logger.error(e.toString());
	      throw e;
	    }
	    finally
		{
	    	try
			  {
		      	hibernateUtil.closeSession();
			  }
		      catch (HibernateException he)
			  {
				  logger.error(he.toString());
				  throw he;
			  }
		}
	}

	public List getBookmarks(String userId, String courseId, Integer moduleId)
	{
		List mbList = new ArrayList();
		try{
		     Session session = getHibernateUtil().currentSession();
		     Query q = null;
		     if (moduleId == null)
		     {
		       q=session.createQuery("select mb from MeleteBookmarks as mb where mb.userId =:userId and mb.courseId = :courseId");
		     }
		     else
		     {
		       q=session.createQuery("select mb from MeleteBookmarks as mb where mb.userId =:userId and mb.courseId = :courseId and mb.moduleId = :moduleId");
			   q.setParameter("moduleId", moduleId.intValue());
		     }
			  q.setParameter("userId",userId);
			  q.setParameter("courseId",courseId);
			 mbList = q.list();

		     getHibernateUtil().closeSession();

		} catch(Exception ex)
		{
			//ex.printStackTrace();
			logger.error(ex.toString());
		}
		return mbList;

	}

	public void deleteBookmark(MeleteBookmarks mb) throws Exception
	{
		Transaction tx = null;
		Query q = null;
	 	try
		{

	      Session session = hibernateUtil.currentSession();
	      String bookmarkQuery = "select mb from MeleteBookmarks as mb where mb.userId =:userId and mb.courseId = :courseId and mb.moduleId = :moduleId";
	      if (mb.getSectionId() != 0)
	      {
	    	  bookmarkQuery = bookmarkQuery.concat(" and mb.sectionId = :sectionId");
	      }
	      q=session.createQuery(bookmarkQuery);

		  q.setParameter("userId",mb.getUserId());
		  q.setParameter("courseId",mb.getCourseId());
		  q.setParameter("moduleId", mb.getModuleId());
		  if (mb.getSectionId() != 0)
	      {
		   q.setParameter("sectionId", mb.getSectionId());
	      }

		  Iterator itr = q.iterate();
		  tx = session.beginTransaction();

		  MeleteBookmarks mbObj = null;
		  while (itr.hasNext())
		  {
			 mbObj = (MeleteBookmarks) itr.next();
		    ((Map)((Module)mbObj.getModule()).getBookmarks()).remove(new Integer(mbObj.getBookmarkId()));
            session.saveOrUpdate(mbObj.getModule());
            ((Map)((Section)mbObj.getSection()).getBookmarks()).remove(new Integer(mbObj.getBookmarkId()));
            session.saveOrUpdate(mbObj.getSection());
            session.delete(mbObj);
		  }

	      tx.commit();

	    }
	 	catch(StaleObjectStateException sose)
	     {
			if(tx !=null) tx.rollback();
			logger.error("stale object exception" + sose.toString());
			throw sose;
	     }
	    catch (HibernateException he)
	    {
		  logger.error(he.toString());
		  throw he;
	    }
	    catch (Exception e) {
	      if (tx!=null) tx.rollback();
	      logger.error(e.toString());
	      throw e;
	    }
	    finally
		{
	    	try
			  {
		      	hibernateUtil.closeSession();
			  }
		      catch (HibernateException he)
			  {
				  logger.error(he.toString());
				  throw he;
			  }
		}
	}

	public void deleteAllBookmarks(String userId, String courseId) throws Exception
	{
		Transaction tx = null;
	 	try
		{

	      Session session = hibernateUtil.currentSession();

	      tx = session.beginTransaction();
	      int deletedEntities = session.createQuery("delete MeleteBookmarks where userId =:userId and courseId = :courseId")
	        .setString( "userId",userId)
	        .setString( "courseId",courseId)
	        .executeUpdate();


	      tx.commit();
	      logger.info("Deleted "+deletedEntities+" bookmarks");

	    }
	 	catch(StaleObjectStateException sose)
	     {
			if(tx !=null) tx.rollback();
			logger.error("stale object exception" + sose.toString());
			throw sose;
	     }
	    catch (HibernateException he)
	    {
		  logger.error(he.toString());
		  throw he;
	    }
	    catch (Exception e) {
	      if (tx!=null) tx.rollback();
	      logger.error(e.toString());
	      throw e;
	    }
	    finally
		{
	    	try
			  {
		      	hibernateUtil.closeSession();
			  }
		      catch (HibernateException he)
			  {
				  logger.error(he.toString());
				  throw he;
			  }
		}
	}

	/**
	 * @return Returns the hibernateUtil.
	 */
	public HibernateUtil getHibernateUtil() {
		return hibernateUtil;
	}
	/**
	 * @param hibernateUtil The hibernateUtil to set.
	 */
	public void setHibernateUtil(HibernateUtil hibernateUtil) {
		this.hibernateUtil = hibernateUtil;
	}

	/**
	 * @param logger The logger to set.
	 */
	public void setLogger(Log logger) {
		this.logger = logger;
	}


}
