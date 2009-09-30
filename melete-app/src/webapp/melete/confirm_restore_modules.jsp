<!--
 ***********************************************************************************
 * $URL$
 * $Id$  
 ***********************************************************************************
 *
 * Copyright (c) 2008,2009 Etudes, Inc.
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

<title>Melete - Manage Modules</title>
<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
</head>

<f:view>
<body marginwidth="0" marginheight="0" topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" onLoad="setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');">
 <h:form id="RestoreConfirmForm">
<!-- This Begins the Main Text Area -->
 <table >
	<tr>
    <td width="1962" valign="top" >
        <table width="100%"  border="1" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA"  style="border-collapse: collapse">
          <tr>
            <td width="100%" height="20" bordercolor="#E2E4E8">
			<!-- top nav bar --> 
		<f:subview id="top">
			<jsp:include page="topnavbar.jsp"/> 
		</f:subview>
		<div class="meletePortletToolBarMessage"><img src="images/check.gif" alt="" width="16" height="16" align="absbottom"><h:outputText value="#{msgs.confirm_restore_modules_modules_restored}" /></div>
		</td></tr>
		
		<tr><td class="maintabledata3">
		<!-- main contents -->
		<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#EAEAEA" width="100%" id="AutoNumber1">
		  	<tr><td colspan="2" height="20" class="maintabledata5">&nbsp;</td></tr>
              <tr>
                <td width="100%" valign="top">
                  <br>
                  <table width="100%"  border="1" align="center" cellpadding="10" cellspacing="0" bordercolor="#CCCCCC">
                    <tr class="maintabledata3">
                      <td valign="top"><h:graphicImage id="right_check" value="images/right_check.gif" width="24" height="24"  alt="#{msgs.confirm_restore_modules_confirmation_signal}" title="#{msgs.confirm_restore_modules_confirmation_signal}"/></td>
                      <td align="left"><h:outputText value="#{msgs.confirm_restore_modules_message1}" /></br>
					  		<br>
                       		<h:dataTable id="confirmrestoretable" value="#{manageModulesPage.restoreModulesList}" var="rml" width="140%" columnClasses="bold">
							<h:column>
								 <h:outputText id="modname" value="#{rml.module.title}"/>
							</h:column>
							</h:dataTable>		
							<br>
					   <span class="style5"><h:outputText value="#{msgs.confirm_restore_modules_note}" /></span>                      </td>
                    </tr>
					
                  </table><br></td>
              </tr>
			    <tr>
                <td colspan="2">         
                <div class="actionBar" align="left">	
               	<h:commandButton action="#{manageModulesPage.returnToModules}" value="#{msgs.im_return_to_modules}" accesskey="#{msgs.return_access}" title="#{msgs.im_return_to_modules_text}" styleClass="BottomImgReturn"/>
			
				</div>

				</td>
              </tr>			
            </table>
		<!--end  main -->
			  </td></tr></table> 
		</td>
  </tr>
</table>
</h:form>
<!-- This Ends the Main Text Area -->

</body>

</f:view>

</html>	  
