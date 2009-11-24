<!--
 ***********************************************************************************
 *
 * Copyright (c) 2008,2009 Etudes, Inc.
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

<title>Melete - Select Resource Item</title>

<link rel="stylesheet" type="text/css" href="rtbc004.css">
<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
<script language="javascript1.2">
function contentChangeSubmit()
{
    if ( document.getElementById("ServerViewForm:contentChange") )
           document.getElementById("ServerViewForm:contentChange").value = "true";
}
</script>
</head>
<f:view>

<body marginwidth="0" marginheight="0" topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" onload="setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');">

<h:form id="LtiServerViewForm" enctype="multipart/form-data">	

<!-- This Begins the Main Text Area -->
	  <table width="100%"  border="1" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA"  style="border-collapse: collapse">
		<tr>
				<td width="1962">
        		<table width="100%"  border="1" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA"  style="border-collapse: collapse">
          			<tr><td width="100%" height="20" bordercolor="#E2E4E8">
          			<!-- top nav bar -->
		                <f:subview id="top">
			              <jsp:include page="topnavbar.jsp"/> 
		                </f:subview>
					<div class="meletePortletToolBarMessage"><img src="images/replace2.gif" alt="" width="16" height="16" align="absmiddle"><h:outputText value="#{msgs.editcontentlinkserverview_selecting}"/></div>
				</td></tr>
				 <tr><td>
					<h:messages showDetail="true" showSummary="false" infoClass="BlueClass" errorClass="RedClass"/>
				</td></tr>
				<tr><td>
  					 <h:outputText id="Stext_2" value="#{msgs.editcontentlinkserverview_msg1}"/> 
  				</td></tr>
  				<tr><td> &nbsp; </td></tr>						
				<tr><td height="20" colspan="2"> <h:outputText id="Stext_add" value="#{msgs.editcontentltiserverview_replace}" styleClass="bold"/> </td></tr>	 
<!--replace with new link part Begin -->
				<tr><td>
					<table width="59%" border="0" cellpadding="4" cellspacing="0" bordercolor="#F5F5F5" style="border-collapse: collapse" >
					 <tr> <td><h:outputText id="format_text" value="#{msgs.editcontentltiserverview_format}"/>
					 	</td>
					 	<td>						  
						<h:selectOneMenu id="LTIDisplay" value="#{addSectionPage.LTIDisplay}" 
							valueChangeListener="#{addSectionPage.toggleLTIDisplay}" 
							onchange="contentChangeSubmit();this.form.submit();" 
							immediate="true" >
						<f:selectItem itemValue="Basic" itemLabel="#{msgs.addmodulesections_basic_lti}"/>
						<f:selectItem itemValue="Advanced" itemLabel="#{msgs.addmodulesections_advanced_lti}"/>
						</h:selectOneMenu>
						<h:inputHidden id="contentChange" value=""/>
					</td></tr>
					                         
						<f:subview id="LTIBasic" rendered="#{addSectionPage.shouldLTIDisplayBasic}">
							<jsp:include page="lti_basic.jsp"/>
						</f:subview> 
						                                                                 
						<f:subview id="LTIAdvanced" rendered="#{addSectionPage.shouldLTIDisplayAdvanced}">
							<jsp:include page="lti_advanced.jsp"/>
						</f:subview>
								
					 <tr><td colspan="2"> <h:selectBooleanCheckbox id="windowopen" title="openWindow" value="#{addSectionPage.section.openWindow}" />												
						<h:outputText id="editLTIText_8" value="#{msgs.editcontentlinkserverview_openwindow}" /> </td></tr>	
					</table> 
					</td></tr>       
					     <tr><td>
					     	<div class="actionBar" align="left">
					     	 <h:commandButton id="addButton_1" action="#{addSectionPage.setServerLTI}" value="#{msgs.im_continue}" tabindex="" accesskey="#{msgs.continue_access}" title="#{msgs.im_continue_text}" styleClass="BottomImgContinue"/>
						     <h:commandButton id="cancelButton_1" immediate="true" action="#{addSectionPage.cancelServerFile}" value="#{msgs.im_cancel}" tabindex="" accesskey="#{msgs.cancel_access}" title="#{msgs.im_cancel_text}" styleClass="BottomImgCancel"/>
				 	    	</div>
					    </td></tr>
	<!-- new link end -->
					
	<!-- start main -->
			            <tr><td width="100%" valign="top" align="center">
					
								<f:subview id="ResourceListingForm" >	
									<jsp:include page="list_resources.jsp"/> 
								</f:subview>		
							
	             	            </td></tr>
			             	
				<tr><td>
				  <div class="actionBar" align="left">
		     	     <h:commandButton id="addButton" action="#{addSectionPage.setServerLTI}" value="#{msgs.im_continue}" tabindex="" accesskey="#{msgs.continue_access}" title="#{msgs.im_continue_text}" styleClass="BottomImgContinue"/>
			 	     <h:commandButton id="cancelButton" immediate="true" action="#{addSectionPage.cancelServerFile}" value="#{msgs.im_cancel}" tabindex="" accesskey="#{msgs.cancel_access}" title="#{msgs.im_cancel_text}" styleClass="BottomImgCancel"/>	
				 </div>					              	
		              	</td></tr>
		     	</table>					
<!--end  main -->	
		</td></tr>
	</table>
	<!-- This Ends the Main Text Area -->
	     	</h:form>
</body>
</f:view>
</html> 
