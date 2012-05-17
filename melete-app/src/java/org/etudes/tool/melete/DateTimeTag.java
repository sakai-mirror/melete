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

import javax.faces.webapp.ConverterTag;
import javax.faces.convert.Converter;
import javax.servlet.jsp.JspException;

public class DateTimeTag extends ConverterTag
{

	private boolean multiLine = false;
	private String type = null;
	private String pattern = null;
	
	public String getPattern()
	{
		return pattern;
	}

	public void setPattern(String pattern)
	{
		this.pattern = pattern;
	}

	public String getType()
	{
		return type;
	}

	public void setType(String type)
	{
		this.type = type;
	}

	public String getDateStyle()
	{
		return dateStyle;
	}

	public void setDateStyle(String dateStyle)
	{
		this.dateStyle = dateStyle;
	}

	public String getTimeStyle()
	{
		return timeStyle;
	}

	public void setTimeStyle(String timeStyle)
	{
		this.timeStyle = timeStyle;
	}

	private String dateStyle = null;
	private String timeStyle = null;


	public DateTimeTag()
	{
		super();
		setConverterId(DateTimeConverter.CONVERTER_ID);
	}

	protected Converter createConverter() throws JspException
	{
		DateTimeConverter converter = (DateTimeConverter) super.createConverter();
		converter.setMultiLine(multiLine);
		if (type != null) 
		{
			converter.setType(type);
		}
		if (dateStyle != null) 
		{
			converter.setDateStyle(dateStyle);
		}
		if (timeStyle != null) converter.setTimeStyle(timeStyle);
		if (pattern != null) converter.setPattern(pattern);
		return converter;
	}

	public void release()
	{
		super.release();
		multiLine = false;
	}

	public boolean getMultiLine()
	{
		return multiLine;
	}

	public void setMultiLine(boolean multiLine)
	{
		this.multiLine = multiLine;
	}

}
