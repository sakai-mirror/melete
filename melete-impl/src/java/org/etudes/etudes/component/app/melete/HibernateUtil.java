/**********************************************************************************
*
* $URL$
*
***********************************************************************************
*
* Copyright (c) 2008 Etudes, Inc.
*
* Portions completed before September 1, 2008 Copyright (c) 2004, 2005, 2006, 2007, 2008 Foothill College, ETUDES Project
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
package org.etudes.component.app.melete;
import java.io.Serializable;

import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.SessionFactory;

public class HibernateUtil implements Serializable{

    public SessionFactory sessionFactory;

	  public ThreadLocal session = new ThreadLocal();

    public Session currentSession() throws HibernateException {

    	try{
    	Session s = (Session) session.get();
    	  // Open a new Session, if this Thread has none yet
        if (s == null) {
            s = sessionFactory.openSession();
            session.set(s);
        }
    	
    	
        return s;
    	}
    	finally{}
    }

	    public void closeSession() throws HibernateException {
	        Session s = (Session) session.get();
	        session.set(null);
	        if (s != null)
	            s.close();
	    }
		/**
		 * @return Returns the sessionFactory.
		 */
		public SessionFactory getSessionFactory() {
			return sessionFactory;
		}
		/**
		 * @param sessionFactory The sessionFactory to set.
		 */
		public void setSessionFactory(SessionFactory sessionFactory) {
			this.sessionFactory = sessionFactory;
		}
}		