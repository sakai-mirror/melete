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
 * Created on Mar 8, 2007
 *  @author Rashmi
 * 	this class provides navigation through the remote files listing like show 15 at a time
 *  05/24/07 - Rashmi - changed totalsize to totalsize + 1 in few checks to fix partial listing
 *  					when list is less than chunkSize
 */
package org.sakaiproject.tool.melete;

public class RemoteFilesListingNav {

	private int totalSize;
	private int currIndex;
	private int chunkSize;
	private int endIndex;
	private boolean displayPrev;
	private boolean displayNext;
	private int displayStartIndex;
	private int displayEndIndex;
	private boolean displayNav;

	public RemoteFilesListingNav()
	{
		totalSize = 0;
		currIndex = 0;
		chunkSize = 0;
		displayPrev = false;
		displayNext = false;
	}

	public RemoteFilesListingNav(int totalSize,int currIndex,int chunkSize)
	{
		this.totalSize = totalSize;
		this.currIndex = currIndex;
		this.chunkSize = chunkSize;
		this.endIndex = currIndex + chunkSize;
		displayPrev = false;
		displayNext = false;
	}

	public int getCurrIndex()
	{
		if(currIndex <= 0)
				currIndex  = 0;

		return currIndex;
	}

	public int getEndIndex()
	{

		if(endIndex >= totalSize-1)
			endIndex = totalSize-1;
		if((totalSize + 1) <= chunkSize)endIndex = totalSize-1;


		return endIndex;
	}

	public String goPrev()
	{
		currIndex = currIndex - chunkSize;
		endIndex = currIndex + chunkSize;
		return "#";
	}

	public String goNext()
	{
		currIndex = currIndex + chunkSize;
		endIndex = currIndex + chunkSize;
		if(endIndex >= totalSize-1)
			endIndex = totalSize-1;

		return "#";
	}

	/**
	 * @return Returns the displayNext.
	 */
	public boolean isDisplayNext() {
		if((totalSize + 1) > chunkSize)
		{
			if(endIndex < totalSize -1)
				displayNext = true;

			 if(endIndex >= totalSize -1)
			 	displayNext = false;
		}
		else displayNext = false;
		return displayNext;
	}
	/**
	 * @return Returns the displayPrev.
	 */
	public boolean isDisplayPrev() {
		if(currIndex >= chunkSize)
			displayPrev = true;
		else displayPrev = false;
		return displayPrev;
	}
	/**
	 * @return Returns the totalSize.
	 */
	public int getTotalSize() {
		return totalSize;
	}
	/**
	 * @param totalSize The totalSize to set.
	 */
	public void setTotalSize(int totalSize) {
		this.totalSize = totalSize;
	}
	/**
	 * @return Returns the displayEndIndex.
	 */
	public int getDisplayEndIndex() {
	//	displayEndIndex = endIndex + 1;
		displayEndIndex = endIndex;
		return displayEndIndex;
	}
	/**
	 * @return Returns the displayStartIndex.
	 */
	public int getDisplayStartIndex() {
		displayStartIndex = currIndex+1;
		return displayStartIndex;
	}
	/**
	 * @return Returns the displayNav.
	 */
	public boolean isDisplayNav() {
		if((totalSize + 1) > chunkSize)
			displayNav = true;
		else displayNav = false;
		return displayNav;
	}
	/**
	 * @param displayNav The displayNav to set.
	 */
	public void setDisplayNav(boolean displayNav) {
		this.displayNav = displayNav;
	}
}
