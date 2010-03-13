<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!--
 ***********************************************************************************
 * $URL$
 * $Id$  
 ***********************************************************************************
 *
 * Copyright (c) 2008 Etudes, Inc.
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
<%@include file="accesscheck.jsp" %>

<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="description" content="ETUDES-NG Course Management System, Powered by Sakai">
<meta name="keywords" content="ETUDES-NG course management system, e-learning">


<title>Melete - User Preference</title>
<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
</head>

<f:view>
<body marginwidth="0" marginheight="0" topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" onload="setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');" >
 <h:form id="UserPreferenceForm">
<table>
	<tr>
		<td valign="top"></td>
    	<td width="1962" valign="top">
        	<table width="100%"  border="0" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA"  style="border-collapse: collapse">
          		<tr>
            		<td width="100%" height="20" bordercolor="#E2E4E8">
					<!-- top nav bar -->
						<f:subview id="top">
								<jsp:include page="topnavbar.jsp"/> 
						</f:subview>
		  <div class="meletePortletToolBarMessage"><img src="images/user1_preferences.gif" alt="" width="16" height="16" align="absbottom" border="0"><h:outputText value="#{msgs.author_preference_user_preference}" /></div>				
				</td>
        </tr>
        </table>
        <table width="100%"  border="1" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA"  style="border-collapse: collapse">
          
        <tr>
          <td class="maintabledata3">
          	<h:messages showDetail="true" showSummary="false" infoClass="BlueClass" errorClass="RedClass"/>
		  <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#EAEAEA" width="100%" id="AutoNumber1">
		  	<tr>
		  		<td height="20" class="maintabledata5"><h:outputText id="t1_1" value="#{msgs.author_preference_global_preference}" styleClass="bold"/> </td></tr>
            <tr>
                <td align="center">                	
                	<h:panelGrid id="editorPrefPanel" columns="1" width="95%" cellpadding="0" cellspacing="3" border="0" rendered="#{authorPreferences.shouldRenderEditorPanel}">
                	 <h:column>
                		<h:outputText id="t1" value="#{msgs.author_preference_editor_select}" styleClass="bold"/>
                	</h:column>
                	 <h:column>
						<h:selectOneRadio value="#{authorPreferences.userEditor}" layout="pageDirection">
							<f:selectItems value="#{authorPreferences.availableEditors}" />
						</h:selectOneRadio>	
					</h:column>
				   </h:panelGrid>		
				<h:panelGrid id="collapsePrefPanel" columns="1" width="95%" cellpadding="0" cellspacing="3" border="0">
				<h:column>
				 	<h:outputText id="t2" value="#{msgs.author_preference_view_select}"  styleClass="bold"/>      
				 </h:column>
               	 <h:column>
					<h:selectOneRadio value="#{authorPreferences.userView}" layout="pageDirection">
						<f:selectItem itemLabel="#{msgs.author_preference_Expanded}" itemValue="true" />
						<f:selectItem itemLabel="#{msgs.author_preference_Collapsed}" itemValue="false"/>
					</h:selectOneRadio>	
				</h:column>
				 </h:panelGrid>
<h:panelGrid id="LTIPrefPanel" columns="1" width="95%" cellpadding="0" cellspacing="3" border="0">
				<h:column>
				 	<h:outputText id="LTI1" value="#{msgs.author_preference_LTI_select}"  styleClass="bold"/>      
				 </h:column>
               	 <h:column>
					<h:selectOneRadio value="#{authorPreferences.showLTI}" layout="pageDirection">
						<f:selectItem itemLabel="#{msgs.author_preference_yes}" itemValue="true" />
						<f:selectItem itemLabel="#{msgs.author_preference_no}" itemValue="false"/>
					</h:selectOneRadio>	
				</h:column>
				<h:column>
				 </h:column>
                <h:column>
				<jsp:include page="licenseform.jsp"/>
				 </h:column>	
				 </h:panelGrid>
				</td></tr>			
				<tr>
					 <td class="maintabledata3" >
          	    	  <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#EAEAEA" width="100%" id="AutoNumber2">
						<tr>
						<td  height="20" class="maintabledata5"><h:outputText id="t3_1" value="#{msgs.author_preference_site_preference}"  styleClass="bold"/>          </td></tr>
						<tr>
							  <td align="center">
                				<table border="0" cellpadding="0" cellspacing="3" width="95%">
                				<tr><td>
								 <h:outputText id="t3" value="#{msgs.author_preference_material_printable}"  styleClass="bold"/>          
								 </td></tr>
								<tr>
						   <td>
							<h:selectOneRadio value="#{authorPreferences.materialPrintable}" layout="pageDirection">
										<f:selectItem itemLabel="#{msgs.author_preference_yes}" itemValue="true" />
										<f:selectItem itemLabel="#{msgs.author_preference_no}" itemValue="false"/>
								</h:selectOneRadio>	
					</td></tr></table>
                				<table border="0" cellpadding="0" cellspacing="3" width="95%">
                				<tr><td>
								 <h:outputText id="t4" value="#{msgs.author_preference_autonumber}"  styleClass="bold"/>          
								 </td></tr>
								<tr>
						   <td>
							<h:selectOneRadio value="#{authorPreferences.materialAutonumber}" layout="pageDirection">
										<f:selectItem itemLabel="#{msgs.author_preference_yes}" itemValue="true" />
										<f:selectItem itemLabel="#{msgs.author_preference_no}" itemValue="false"/>
								</h:selectOneRadio>	
					</td></tr></table>
					</td></tr></table>
					</td></tr>									
              <tr>
                <td>         
                <div class="actionBar" align="left">	
                <h:commandButton action="#{authorPreferences.setUserChoice}" value="#{msgs.im_set}" accesskey="#{msgs.set_access}" title="#{msgs.im_set_text}" styleClass="BottomImgSet"/>
			</div></td>
              </tr>			
            </table>
          </td>
        </tr>
      </table>
	</h:form>
  <!-- This Ends the Main Text Area -->
</body>
</f:view>
</html>
