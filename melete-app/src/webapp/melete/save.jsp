<%@ page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@ page import="org.apache.commons.fileupload.disk.DiskFileItem"%>
<%@ page import="java.util.*"%>
<%@ page import="java.io.*"%>
<%@ page import="javax.faces.context.FacesContext,  org.etudes.tool.melete.AddResourcesPage"%>
<!--
 ***********************************************************************************
 * $URL$
 * $Id$  
 ***********************************************************************************
 *
 * Copyright (c) 2008, 2009, 2010 Etudes, Inc.
 *
 * Portions completed before September 1, 2008 Copyright (c) 2004, 2005, 2006, 2007, 2008 Foothill College, ETUDES Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * permissions and limitations under the License.
 *
 **********************************************************************************
-->
<%
			System.out.println("SAVE PAGE CALLED !!!!");
			final javax.faces.context.FacesContext facesContext = javax.faces.context.FacesContext.getCurrentInstance();
			final AddResourcesPage aResourcePage = (AddResourcesPage)facesContext.getApplication().getVariableResolver().resolveVariable(facesContext, "addResourcesPage");
						
			String collId = aResourcePage.getCollectionId(request.getParameter("courseId"));
			Map newEmbeddedResources = new HashMap();
			int count = 1;
			for (Enumeration e = request.getAttributeNames(); e.hasMoreElements();)
				{
					String oneKey = (String) e.nextElement();
			
					if(oneKey.startsWith("sferyx"))
					{
							// store the image at uploads directory
						try {
							org.apache.commons.fileupload.disk.DiskFileItem item = (org.apache.commons.fileupload.disk.DiskFileItem)request.getAttribute(oneKey);
							String fileName = item.getName();
							int lastSlash = fileName.lastIndexOf("/");
							fileName = fileName.substring(lastSlash + 1);
							
							// for word paste files
							lastSlash = fileName.lastIndexOf("\\");
							if(lastSlash != -1)
								fileName = fileName.substring(lastSlash + 1);
							
							/* bad characters in name throw error
							// if filename contains pound char then throw error
							if(fileName.indexOf("#") != -1)
					  	  	{
					  	  	logger.debug("embedded FILE contains hash or other characters " + fileName);
			  	  		    throw new MeleteException("embed_img_bad_filename");
					  	  	}
							// if filename contains percentage sign then throw error
							if(fileName.indexOf("%") != -1)
							{
								try
								{
									String cName = URLDecoder.decode(fileName,"UTF-8");
								}catch(Exception decodex){
									logger.debug("embedded FILE contains percentage or other characters " + fileName);
									throw new MeleteException("embed_img_bad_filename1");
								}						
							}
							*/
							
							InputStream in = item.getInputStream();
							byte[] buf = new byte[(int)item.getSize()];
							in.read(buf);
							
							String embed_ResId = aResourcePage.addItem(fileName,(String)item.getContentType(),collId , buf);
							in.close();
							aResourcePage.addtoMeleteResource(embed_ResId);
							
							newEmbeddedResources.put((count + fileName), embed_ResId);
							count++;
						}  catch (Exception ex) {
							// do nothing
						}
					} // if end
				} // for end	
		
		try
		{
			if(request.getParameter("html_content") != null)
			{			
				aResourcePage.saveSectionHtmlItem(collId, request.getParameter("courseId"), request.getParameter("resourceId"), request.getParameter("mId"), request.getParameter("sId"), newEmbeddedResources, request.getParameter("html_content") );
			}				
		}  catch (Exception ex) {
							// do nothing
							ex.printStackTrace();
						}
%>