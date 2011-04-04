/**********************************************************************************
 *
 * $URL$
 * $Id$  
 ***********************************************************************************
 *
 * Copyright (c) 2008,2009,2010,2011 Etudes, Inc.
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
import org.apache.commons.lang.builder.ToStringBuilder;

public class SectionBean implements Serializable
{

	protected boolean selected;
	protected String truncTitle;
	protected String displaySequence;

	/** nullable persistent field */
	protected Section section;

	/** default constructor */
	public SectionBean()
	{
	}

	/** full constructor */
	public SectionBean(Section section)
	{
		this.section = (Section) section;
	}

	/**
	 * Get the display sequence of a section based on user preference and sub section level.
	 * 
	 * @return
	 */
	public String getDisplaySequence()
	{
		return displaySequence;
	}

	/**
	 * Get the section.
	 * 
	 * @return
	 */
	public Section getSection()
	{
		return this.section;
	}

	/**
	 * Get the title truncated to 30 characters. Note:Not in use anymore
	 * 
	 * @return
	 */
	public String getTruncTitle()
	{
		return truncTitle;
	}

	/**
	 * Checks if section is selected by the user.
	 * 
	 * @return
	 */
	public boolean isSelected()
	{
		return selected;
	}

	/**
	 * Set the display sequence.
	 * 
	 * @param displaySequence
	 *        the sub section level sequence
	 */
	public void setDisplaySequence(String displaySequence)
	{
		this.displaySequence = displaySequence;
	}

	/**
	 * Set the section.
	 * 
	 * @param section
	 *        The section
	 */
	public void setSection(Section section)
	{
		this.section = (Section) section;
	}

	/**
	 * Set the user selection
	 * 
	 * @param selected
	 *        selected
	 */
	public void setSelected(boolean selected)
	{
		this.selected = selected;
	}

	/**
	 * Set the title truncated to 30 characters.
	 * 
	 * @return
	 */
	public void setTruncTitle(String truncTitle)
	{
		this.truncTitle = truncTitle;
	}

	/**
	 * {@inheritDoc}
	 */

	public String toString()
	{
		return new ToStringBuilder(this).toString();
	}

}
