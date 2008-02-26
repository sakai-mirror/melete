
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

import org.sakaiproject.util.ResourceLoader;

import javax.faces.application.FacesMessage;
import javax.faces.context.FacesContext;
import javax.faces.model.SelectItem;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import org.sakaiproject.component.cover.ServerConfigurationService;

public class ManageResourcesPage {
  private String fileType;
  private int numberItems;
  private boolean shouldRenderUpload;
  
  /** Dependency:  The logging service. */
	protected Log logger = LogFactory.getLog(ManageResourcesPage.class);

  public ManageResourcesPage()
  {
  }

  
public String addItems()
{
	shouldRenderUpload = true;
	return "manage_content";
}
public String getFileType()
{
	return this.fileType;
}

public void setFileType(String fileType)
{
	this.fileType = fileType;
}

public int getNumberItems()
{
	return this.numberItems;
}

public void setNumberItems(int numberItems)
{
	this.numberItems = numberItems;
}

public boolean isShouldRenderUpload()
{
	return this.shouldRenderUpload;
}

public void setShouldRenderUpload(boolean shouldRenderUpload)
{
	this.shouldRenderUpload = shouldRenderUpload;
}


}
