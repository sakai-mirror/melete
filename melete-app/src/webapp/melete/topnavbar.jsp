<%@ page import="org.etudes.tool.melete.MeleteSiteAndUserInfo"%>
<!--
 ***********************************************************************************
 * $URL$
 * $Id$  
 ***********************************************************************************
 *
 * Copyright (c) 2008, 2009 Etudes, Inc.
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
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>

<%
final javax.faces.context.FacesContext facesContext = javax.faces.context.FacesContext.getCurrentInstance();

final MeleteSiteAndUserInfo meleteSiteAndUserInfo = (MeleteSiteAndUserInfo)facesContext.getApplication().getVariableResolver().resolveVariable(facesContext, "meleteSiteAndUserInfo");
 meleteSiteAndUserInfo.populateMeleteSession();
%>
<link href="rtbc004.css" type="text/css" rel="stylesheet" media="all" />

<sakai:view_container>
<sakai:view_content>

<sakai:tool_bar id="topbar">
<sakai:tool_bar_item id="viewItem" action="#{navPage.viewAction}" value="#{msgs.topnavbar_view}"  immediate="true"/>
<sakai:tool_bar_item id="authorItem" action="#{navPage.authAction}" value="#{msgs.topnavbar_author}" immediate="true"  rendered="#{navPage.isInstructor}"/>
<sakai:tool_bar_item id="manageItem" action="#{navPage.manageAction}" value="#{msgs.topnavbar_manage}"  immediate="true"  rendered="#{navPage.isInstructor}"/>
<sakai:tool_bar_item id="prefItem" action="#{navPage.PreferenceAction}" value="#{msgs.topnavbar_preferences}"   immediate="true"/>
</sakai:tool_bar>
<!-- End code to display images horizontally. -->

</sakai:view_content>
</sakai:view_container>

