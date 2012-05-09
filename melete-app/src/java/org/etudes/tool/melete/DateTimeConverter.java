/*******************************************************************************
 *
 * $URL: https://source.sakaiproject.org/contrib/etudes/melete/branches/allowuntil/melete-app/src/java/org/etudes/tool/melete/Util.java $
 *
 * **********************************************************************************
 *
 * Copyright (c) 2012 Etudes, Inc.
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
 ******************************************************************************/

package org.etudes.tool.melete;

import java.io.Serializable;
import java.util.Date;
import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import org.etudes.util.DateUtil;

/**
 * Wrapper for supporting the timezone
 */
public class DateTimeConverter extends javax.faces.convert.DateTimeConverter
{
	public final static String CONVERTER_ID = "melete.DateTimeConverter";
	private boolean multiLine = false;

	@Override
	public Object getAsObject(FacesContext fc, UIComponent uic, String string)
	{
		Object date = null;
		try
		{
			date = DateUtil.getDateFromString(string);
		}
		catch (Exception e)
		{
			date = super.getAsObject(fc, uic, string);
		}

		return date;
	}

	@Override
	public String getAsString(FacesContext fc, UIComponent uic, Object o)
	{
		Date date = (Date) o;
		String dateZoneStr;
		if (this.multiLine)
		{
			dateZoneStr = DateUtil.getMultiStringFromDate(date);
		}
		else
		{
			dateZoneStr = DateUtil.getStringFromDate(date);
		}
		return dateZoneStr;
	}

	public boolean getMultiLine()
	{
		return multiLine;

	}

	public void setMultiLine(boolean multiLine)
	{
		System.out.println("Coming to setmulti " + multiLine);
		this.multiLine = multiLine;

	}

}
