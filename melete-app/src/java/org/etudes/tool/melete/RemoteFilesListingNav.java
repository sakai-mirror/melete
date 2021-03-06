/**********************************************************************************
 *
 * $URL$
 *
 ***************************************************************************************
 * Copyright (c) 2008, 2009 Etudes, Inc.
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
 *******************************************************************************/

package org.etudes.tool.melete;

import javax.faces.component.UIInput;
import javax.faces.event.AbortProcessingException;
import javax.faces.event.ValueChangeEvent;

public class RemoteFilesListingNav
{
	private int totalSize;
	private int currIndex;
	private int chunkSize;
	private int endIndex;
	private boolean displayPrev;
	private boolean displayNext;
	private int displayStartIndex;
	private int displayEndIndex;
	private boolean displayNav;
	private String fromPage;

	/**
	 * default constructor
	 */
	public RemoteFilesListingNav()
	{
		totalSize = 0;
		currIndex = 0;
		chunkSize = 0;
		displayPrev = false;
		displayNext = false;
		fromPage = "#";
	}

	/**
	 * Full constructor
	 * 
	 * @param totalSize
	 * @param currIndex
	 * @param chunkSize
	 */
	public RemoteFilesListingNav(int totalSize, int currIndex, int chunkSize)
	{
		this.totalSize = totalSize;
		this.currIndex = currIndex;
		this.chunkSize = chunkSize;
		this.endIndex = currIndex + chunkSize;
		displayPrev = false;
		displayNext = false;
		fromPage = "#";
	}

	/**
	 * Get the current start index
	 * 
	 * @return
	 */
	public int getCurrIndex()
	{
		if (currIndex <= 0) currIndex = 0;
		return currIndex;
	}

	/**
	 * Change the pagination size. Refreshes the page and starts with new chunk size.
	 * 
	 * @param event
	 * @throws AbortProcessingException
	 */
	public void changeChunkSize(ValueChangeEvent event) throws AbortProcessingException
	{
		UIInput chunkSelect = (UIInput) event.getComponent();

		this.chunkSize = Integer.parseInt((String) chunkSelect.getValue());
		// -1 implies all resources need to be displayed
		if (this.chunkSize == -1) this.chunkSize = totalSize - 1;
		resetCurrIndex();
	}

	/**
	 * Get the end Index
	 * 
	 * @return
	 */
	public int getEndIndex()
	{

		if (endIndex >= totalSize - 1) endIndex = totalSize - 1;
		if ((totalSize + 1) <= chunkSize) endIndex = totalSize - 1;

		return endIndex;
	}

	/**
	 * Reset all indices.
	 */
	public void resetCurrIndex()
	{
		this.currIndex = 0;
		this.endIndex = currIndex + chunkSize;
		if (endIndex >= totalSize - 1) this.endIndex = totalSize - 1;

		displayPrev = false;
		displayNext = false;
	}

	/**
	 * Process start and end indices for the previous page
	 * 
	 * @return the start page
	 */
	public String goPrev()
	{
		currIndex = currIndex - chunkSize;
		if (currIndex < 0) currIndex = 0;
		endIndex = currIndex + chunkSize;
		return fromPage;
	}

	/**
	 * Process start and end indices for the next page
	 * 
	 * @return the start page
	 */
	public String goNext()
	{
		currIndex = currIndex + chunkSize;
		endIndex = currIndex + chunkSize;
		if (endIndex >= totalSize - 1) endIndex = totalSize - 1;
		return fromPage;
	}

	/**
	 * @return Returns the displayNext.
	 */
	public boolean isDisplayNext()
	{
		if ((totalSize + 1) > chunkSize)
		{
			if (endIndex < totalSize - 1) displayNext = true;

			if (endIndex >= totalSize - 1) displayNext = false;
		}
		else
			displayNext = false;
		return displayNext;
	}

	/**
	 * @return Returns the displayPrev.
	 */
	public boolean isDisplayPrev()
	{
		if (currIndex >= chunkSize)
			displayPrev = true;
		else
			displayPrev = false;
		return displayPrev;
	}

	/**
	 * @return Returns the totalSize.
	 */
	public int getTotalSize()
	{
		return totalSize;
	}

	/**
	 * @param totalSize
	 *        The totalSize to set.
	 */
	public void setTotalSize(int totalSize)
	{
		this.totalSize = totalSize;
	}

	/**
	 * @return Returns the displayEndIndex.
	 */
	public int getDisplayEndIndex()
	{
		// displayEndIndex = endIndex + 1;
		displayEndIndex = getEndIndex();
		return displayEndIndex;
	}

	/**
	 * @return Returns the displayStartIndex.
	 */
	public int getDisplayStartIndex()
	{
		displayStartIndex = currIndex + 1;
		return displayStartIndex;
	}

	/**
	 * If the number of resources are less than 30 then don't show navigation bar
	 * 
	 * @return Returns the displayNav.
	 */
	public boolean isDisplayNav()
	{
		if ((totalSize - 1 <= chunkSize) && (chunkSize == 30))
			displayNav = false;
		else
			displayNav = true;
		return displayNav;
	}

	/**
	 * @param displayNav
	 *        The displayNav to set.
	 */
	public void setDisplayNav(boolean displayNav)
	{
		this.displayNav = displayNav;
	}

	/**
	 * @param fromPage
	 *        the fromPage to set
	 */
	public void setFromPage(String fromPage)
	{
		this.fromPage = fromPage;
	}

	/**
	 * Get the pagination size
	 * 
	 * @return
	 */
	public int getChunkSize()
	{
		return this.chunkSize;
	}

	/**
	 * Set the pagination size
	 * 
	 * @param chunkSize
	 */
	public void setChunkSize(int chunkSize)
	{
		this.chunkSize = chunkSize;
	}

}
