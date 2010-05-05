<%@ page import="org.etudes.tool.melete.MeleteSiteAndUserInfo"%>
<!--
 ***********************************************************************************
 * $URL$
 * $Id$  
 ***********************************************************************************
 *
 * Copyright (c) 2008, 2009,2010 Etudes, Inc.
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
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>

<sakai:tool_bar id="topbar">
  <h:commandLink id="viewItem" action="#{navPage.viewAction}" immediate="true" >
	 <h:graphicImage url="/images/preview.png" alt="" title=""height="16" width="16"  styleClass="AuthImgClass"/>
	 <h:outputText  value="#{msgs.topnavbar_view}"/>	
  </h:commandLink>
  
  <h:commandLink id="authorItem" action="#{navPage.authAction}" immediate="true" rendered="#{navPage.isInstructor}">
	 <h:graphicImage url="/images/pen_red.gif" alt="" title=""height="16" width="16"  styleClass="AuthImgClass"/>
	 <h:outputText  value="#{msgs.topnavbar_author}"/>	
	</h:commandLink>
 	
  <h:commandLink id="manageItem" action="#{navPage.manageAction}" immediate="true" rendered="#{navPage.isInstructor}">
	 <h:graphicImage url="/images/folder_document.gif" alt="" title=""height="16" width="16"  styleClass="AuthImgClass"/>
	 <h:outputText  value="#{msgs.topnavbar_manage}"/>	
  </h:commandLink>
 
  <h:commandLink id="prefItem" action="#{navPage.PreferenceAction}" immediate="true">
	 <h:graphicImage url="/images/user1_preferences.gif" alt="" title=""height="16" width="16"  styleClass="AuthImgClass"/>
	 <h:outputText  value="#{msgs.topnavbar_preferences}"/>
  </h:commandLink>
</sakai:tool_bar>
<!-- End code to display images horizontally. -->




