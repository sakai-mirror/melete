/**********************************************************************************
 *
 * $URL$
 * $Id$  
 ***********************************************************************************
 *
 * Copyright (c) 2008, 2011 Etudes, Inc.
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

package org.etudes.tool.melete;

import java.util.Date;
import org.etudes.component.app.melete.CourseModule;

public class MeleteDateComparator implements java.util.Comparator<CourseModule>
{

	/**
	 * Check to see if archived dates are equal
	 * 
	 * @return result of comparison
	 */
	public int compare(CourseModule o1, CourseModule o2)
	{
		Date d1 = ((CourseModule) o1).getDateArchived();
		Date d2 = ((CourseModule) o2).getDateArchived();
		return d1.compareTo(d2);
	}

}
