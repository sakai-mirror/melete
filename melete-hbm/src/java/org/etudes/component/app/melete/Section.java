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

import java.util.Date;
import org.apache.commons.lang.builder.ToStringBuilder;

import org.etudes.api.app.melete.SectionObjService;

public class Section implements SectionObjService
{
	/** nullable persistent field */
	private boolean audioContent;

	/** persistent field */
	private String contentType;

	/** persistent field */
	private String createdByFname;

	/** persistent field */
	private String createdByLname;

	/** persistent field */
	private Date creationDate;

	/** nullable persistent field */
	private boolean deleteFlag;

	/** nullable persistent field */
	private String instr;

	/** persistent field */
	private Date modificationDate;

	/** nullable persistent field */
	private String modifiedByFname;

	/** nullable persistent field */
	private String modifiedByLname;

	/** nullable persistent field */
	private org.etudes.component.app.melete.Module module;

	/** nullable persistent field */
	private int moduleId;

	/** nullable persistent field */
	private boolean openWindow;

	/** identifier field */
	private Integer sectionId;

	/** nullable persistent field */
	private org.etudes.component.app.melete.SectionResource sectionResource;

	/** nullable persistent field */
	private boolean textualContent;

	/** persistent field */
	private String title = "Untitled section";

	/** nullable persistent field */
	private int version;

	/** nullable persistent field */
	private boolean videoContent;

	/** default constructor */
	public Section()
	{
	}

	/** full constructor */
	public Section(int moduleId, String title, String createdByFname, String createdByLname, String modifiedByFname, String modifiedByLname,
			String instr, String contentType, boolean audioContent, boolean videoContent, boolean textualContent, boolean openWindow,
			boolean deleteFlag, Date creationDate, Date modificationDate, int version, org.etudes.component.app.melete.Module module,
			org.etudes.component.app.melete.SectionResource sectionResource)
	{
		this.moduleId = moduleId;
		this.title = title;
		this.createdByFname = createdByFname;
		this.createdByLname = createdByLname;
		this.modifiedByFname = modifiedByFname;
		this.modifiedByLname = modifiedByLname;
		this.instr = instr;
		this.contentType = contentType;
		this.audioContent = audioContent;
		this.videoContent = videoContent;
		this.textualContent = textualContent;
		this.openWindow = openWindow;
		this.deleteFlag = deleteFlag;
		this.creationDate = creationDate;
		this.modificationDate = modificationDate;
		this.version = version;
		this.module = module;
		this.sectionResource = sectionResource;
	}

	/** copy constructor */
	public Section(Section oldSection)
	{
		this.title = oldSection.getTitle();
		this.instr = oldSection.getInstr();
		this.contentType = oldSection.getContentType();
		this.audioContent = oldSection.isAudioContent();
		this.videoContent = oldSection.isVideoContent();
		this.textualContent = oldSection.isTextualContent();
		this.openWindow = oldSection.isOpenWindow();
		this.deleteFlag = oldSection.isDeleteFlag();
		this.module = null;
		this.sectionResource = null;
	}

	/** minimal constructor */
	public Section(String title, String createdByFname, String createdByLname, String contentType, Date creationDate, Date modificationDate)
	{
		this.title = title;
		this.createdByFname = createdByFname;
		this.createdByLname = createdByLname;
		this.contentType = contentType;
		this.creationDate = creationDate;
		this.modificationDate = modificationDate;
	}

	/** Custom constructor */
	public Section(String title, String createdByFname, String createdByLname, String modifiedByFname, String modifiedByLname, String instr,
			String contentType, boolean audioContent, boolean videoContent, boolean textualContent, boolean openWindow, boolean deleteFlag,
			Date creationDate, Date modificationDate)
	{
		this.title = title;
		this.createdByFname = createdByFname;
		this.createdByLname = createdByLname;
		this.modifiedByFname = modifiedByFname;
		this.modifiedByLname = modifiedByLname;
		this.instr = instr;
		this.contentType = contentType;
		this.audioContent = audioContent;
		this.videoContent = videoContent;
		this.textualContent = textualContent;
		this.openWindow = openWindow;
		this.deleteFlag = deleteFlag;
		this.creationDate = creationDate;
		this.modificationDate = modificationDate;
	}

	@Override
	public boolean equals(Object obj)
	{
		if (this == obj) return true;
		if (obj == null) return false;
		if (getClass() != obj.getClass()) return false;
		Section other = (Section) obj;
		if (audioContent != other.audioContent) return false;
		if (contentType == null)
		{
			if (other.contentType != null) return false;
		}
		else if (!contentType.equals(other.contentType)) return false;
		if (deleteFlag != other.deleteFlag) return false;
		if (instr == null || instr.length() == 0)
		{
			if (other.instr != null && other.instr.trim().length() != 0) return false;
		}
		else if (!instr.equals(other.instr)) return false;
		if (moduleId != other.moduleId) return false;
		if (openWindow != other.openWindow) return false;
		if (textualContent != other.textualContent) return false;
		if (title == null)
		{
			if (other.title != null) return false;
		}
		else if (!title.equals(other.title)) return false;
		if (videoContent != other.videoContent) return false;
		return true;
	}

	/**
	 * {@inheritDoc}
	 */
	public String getContentType()
	{
		return this.contentType;
	}

	/**
	 * {@inheritDoc}
	 */
	public String getCreatedByFname()
	{
		return this.createdByFname;
	}

	/**
	 * {@inheritDoc}
	 */
	public String getCreatedByLname()
	{
		return this.createdByLname;
	}

	/**
	 * {@inheritDoc}
	 */
	public Date getCreationDate()
	{
		return this.creationDate;
	}

	/**
	 * {@inheritDoc}
	 */
	public String getInstr()
	{
		return this.instr;
	}

	/**
	 * {@inheritDoc}
	 */
	public Date getModificationDate()
	{
		return this.modificationDate;
	}

	/**
	 * {@inheritDoc}
	 */
	public String getModifiedByFname()
	{
		return this.modifiedByFname;
	}

	/**
	 * {@inheritDoc}
	 */
	public String getModifiedByLname()
	{
		return this.modifiedByLname;
	}

	/**
	 * {@inheritDoc}
	 */
	public org.etudes.api.app.melete.ModuleObjService getModule()
	{
		return this.module;
	}

	/**
	 * {@inheritDoc}
	 */
	public int getModuleId()
	{
		return this.moduleId;
	}

	/**
	 * {@inheritDoc}
	 */
	public Integer getSectionId()
	{
		return this.sectionId;
	}

	/**
	 * {@inheritDoc}
	 */
	public org.etudes.api.app.melete.SectionResourceService getSectionResource()
	{
		return this.sectionResource;
	}

	/**
	 * {@inheritDoc}
	 */
	public String getTitle()
	{
		return this.title;
	}

	/**
	 * {@inheritDoc}
	 */
	public int getVersion()
	{
		return this.version;
	}

	@Override
	public int hashCode()
	{
		final int prime = 31;
		int result = 1;
		result = prime * result + (audioContent ? 1231 : 1237);
		result = prime * result + ((contentType == null) ? 0 : contentType.hashCode());
		result = prime * result + (deleteFlag ? 1231 : 1237);
		result = prime * result + ((instr == null) ? 0 : instr.hashCode());
		result = prime * result + moduleId;
		result = prime * result + (openWindow ? 1231 : 1237);
		result = prime * result + (textualContent ? 1231 : 1237);
		result = prime * result + ((title == null) ? 0 : title.hashCode());
		result = prime * result + (videoContent ? 1231 : 1237);
		return result;
	}
	
	/**
	 * {@inheritDoc}
	 */
	public boolean isAudioContent()
	{
		return this.audioContent;
	}

	/**
	 * {@inheritDoc}
	 */
	public boolean isDeleteFlag()
	{
		return this.deleteFlag;
	}

	/**
	 * {@inheritDoc}
	 */
	public boolean isOpenWindow()
	{
		return this.openWindow;
	}

	/**
	 * {@inheritDoc}
	 */
	public boolean isTextualContent()
	{
		return this.textualContent;
	}

	/**
	 * {@inheritDoc}
	 */
	public boolean isVideoContent()
	{
		return this.videoContent;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setAudioContent(boolean audioContent)
	{
		this.audioContent = audioContent;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setContentType(String contentType)
	{
		this.contentType = contentType;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setCreatedByFname(String createdByFname)
	{
		this.createdByFname = createdByFname;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setCreatedByLname(String createdByLname)
	{
		this.createdByLname = createdByLname;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setCreationDate(Date creationDate)
	{
		this.creationDate = creationDate;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setDeleteFlag(boolean deleteFlag)
	{
		this.deleteFlag = deleteFlag;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setInstr(String instr)
	{
		this.instr = instr;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setModificationDate(Date modificationDate)
	{
		this.modificationDate = modificationDate;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setModifiedByFname(String modifiedByFname)
	{
		this.modifiedByFname = modifiedByFname;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setModifiedByLname(String modifiedByLname)
	{
		this.modifiedByLname = modifiedByLname;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setModule(org.etudes.api.app.melete.ModuleObjService module)
	{
		this.module = (Module) module;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setModuleId(int moduleId)
	{
		this.moduleId = moduleId;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setOpenWindow(boolean openWindow)
	{
		this.openWindow = openWindow;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setSectionId(Integer sectionId)
	{
		this.sectionId = sectionId;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setSectionResource(org.etudes.api.app.melete.SectionResourceService sectionResource)
	{
		this.sectionResource = (SectionResource) sectionResource;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setTextualContent(boolean textualContent)
	{
		this.textualContent = textualContent;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setTitle(String title)
	{
		this.title = title;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setVersion(int version)
	{
		this.version = version;
	}

	/**
	 * {@inheritDoc}
	 */
	public void setVideoContent(boolean videoContent)
	{
		this.videoContent = videoContent;
	}

	/**
	 * {@inheritDoc}
	 */
	public String toString()
	{
		return new ToStringBuilder(this).append("sectionId", getSectionId()).toString();
	}

}
