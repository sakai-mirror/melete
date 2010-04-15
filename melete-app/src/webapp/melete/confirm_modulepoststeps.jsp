<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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

<f:view>
<sakai:view title="Modules: Post Steps Confirmation" toolCssHref="rtbc004.css">
<%@include file="accesscheck.jsp" %>

<h:form id="PostStepsConfirmForm">
	<f:subview id="top">
		<jsp:include page="topnavbar.jsp"/> 
	</f:subview>	
	<div class="meletePortletToolBarMessage"><img src="images/check.gif" alt="" width="16" height="16" align="absbottom">Confirmation </div>
     <table width="100%"  border="1" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA" style="border-collapse: collapse">
       <tr>
          <td class="maintabledata3">

		  <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#EAEAEA" width="100%" id="AutoNumber1">
		  	<tr><td colspan="2" height="20" class="maintabledata5">&nbsp;</td></tr>
              <tr>
                <td width="100%" valign="top">
                  <br>
                  <table width="85%"  border="1" align="center" cellpadding="10" cellspacing="0" bordercolor="#CCCCCC">
                    <tr class="maintabledata3">
                      <td valign="top"><img src="images/right_check.gif" width="24" height="24" align="absbottom" alt="#{msgs.confirm_modulepoststeps_confirmation_signal}"></td>
                      <td align="left">You have successfully added next steps to the module: <br>
                        <br> <h:outputText value="#{moduleNextStepsPage.mdBean.module.title}" styleClass="bold" />                 
					  </td>
                    </tr>
                  </table></td>
              </tr>
           </table>
          <div class="actionBar" align="left">				
			<h:commandButton id="ReturntoModules" action="#{moduleNextStepsPage.returnToModules}" value="#{msgs.im_finish}" accesskey="#{msgs.finish_access}" title="#{msgs.im_finish_text}" styleClass="BottomImgSpace"/>					
	      </div>
          </td>
        </tr>
      </table>   
	   </h:form>    
    
  <!-- This Ends the Main Text Area --> 
</sakai:view>
</f:view>

