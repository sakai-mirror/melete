<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns="http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="description" content="ETUDES-NG Course Management System, Powered by Sakai">
<meta name="keywords" content="ETUDES-NG course management system, e-learning">

<!--
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


<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
<!-- End code to put in head section for image pre-loading. -->

<title>Melete - Delete Module</title>
</head>
<f:view>
<body marginwidth="0" marginheight="0" topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" onLoad="chooseTab('Author');setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');">
 <h:form id="DeleteModuleForm">
<table border="0" cellpadding="0" cellspacing="0" class ="table3">
	<tr>
		<td valign="top"> 
		</td>
      <!-- This Begins the Main Text Area -->
      <td width="100%" valign="top" >
       <table width="100%"  border="1" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA" style="border-collapse: collapse">
        <tr>
          <td width="100%" height="20" class="maintabledata1">

          <!-- Begin code to display images horizontally. -->
				<f:subview id="top">
					<jsp:include page="topnavbar.jsp"/> 
				</f:subview>
		  <div class="meletePortletToolBarMessage"><img src="images/Warning.gif" width="16" height="16" align="absbottom" border="0"><h:outputText value="#{msgs.delete_module_module}" rendered="#{deleteModulePage.moduleSelected}"/><h:outputText value="#{msgs.delete_module_section_deletion1}" rendered="#{deleteModulePage.sectionSelected}"/><h:outputText value="#{msgs.delete_module_section_deletion2}" /></div>				
				</td>
        </tr>

			   
        <tr>
          <td class="maintabledata3">
		<h:messages id="deletemoduleerror" layout="table" showDetail="true" showSummary="false" infoClass="BlueClass" errorClass="RedClass"/>
		  <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#EAEAEA" width="100%" id="AutoNumber1">
		  	<tr><td  height="20" class="maintabledata5">&nbsp;</td></tr>
              <tr>
                <td width="100%" valign="top">
                    <table width="85%"  border="1" align="center" cellpadding="10" cellspacing="0" bordercolor="#CCCCCC">
                    <tr class="maintabledata3">
                      <td valign="top"><img src="images/Warning.gif" width="24" height="24" align="absbottom" alt="#{msgs.delete_module_deletion_warning}" border="0"></td>
                      <td align="left"><h:outputText value="#{msgs.delete_module_message1}" /><br>
                        <br><h:outputText value="#{msgs.delete_module_module2}" styleClass="bold"  rendered="#{deleteModulePage.moduleSelected}"/>  
						<h:outputText value=": " styleClass="bold"   rendered="#{deleteModulePage.moduleSelected}"/>
						 <h:dataTable id="tablemod"
                         value="#{deleteModulePage.moduleDateBeans}"
                         var="mdbean"
                         rendered="#{deleteModulePage.moduleSelected}">
                         <h:column>
		                 <br><h:outputText value="#{mdbean.module.title}" styleClass="bold"  rendered="#{deleteModulePage.moduleSelected}" />
                         </h:column>
                         </h:dataTable>   
						
                       <h:outputText value="Sections " styleClass="bold"  rendered="#{deleteModulePage.sectionSelected}"/> 
						<h:outputText value=": " styleClass="bold"   rendered="#{deleteModulePage.sectionSelected}"/> 
						<h:dataTable id="tablesec"
                         value="#{deleteModulePage.sectionBeans}"
                         var="secbean"
                         rendered="#{deleteModulePage.sectionSelected}">
                         <h:column>
		                 <br>
<h:outputText value="#{secbean.section.module.title}" styleClass="bold" rendered="#{deleteModulePage.sectionSelected}" /><h:outputText value=": " styleClass="bold"  rendered="#{deleteModulePage.sectionSelected}" />

<h:outputText value="#{secbean.section.title}" styleClass="bold"  rendered="#{deleteModulePage.sectionSelected}" />
                         </h:column>
                         </h:dataTable>    
                        <p align="left"><h:outputText value="#{msgs.delete_module_long1}" /><B><h:outputText value="#{msgs.delete_module_long2}" /></B> <h:outputText value="#{msgs.delete_module_long3}" /><B><h:outputText value="#{msgs.delete_module_long4}" /></B><h:outputText value="#{msgs.delete_module_long5}" />
</p></td>
                    </tr>
                  </table><br></td>
              </tr>
			  					              <tr>
                <td height="30" >         
                <div align="center">				
				<h:commandLink id="delButton"  action="#{deleteModulePage.deleteAction}"  rendered="#{deleteModulePage.sameModuleSectionSelected == false}">
					<h:graphicImage id="continueImg" value="#{msgs.im_continue}" styleClass="BottomImgSpace"
						onmouseover="this.src = '#{msgs.im_continue_over}'" 
						onmouseout="this.src = '#{msgs.im_continue}'" 
						onmousedown="this.src = '#{msgs.im_continue_down}'" 
						onmouseup="this.src = '#{msgs.im_continue_over}'"/>
                </h:commandLink>
                
           		<h:commandLink id="delButton_1"  action="#{deleteModulePage.reConfirmedDeleteAction}" rendered="#{deleteModulePage.sameModuleSectionSelected}">
					<h:graphicImage id="continueImg_1" value="#{msgs.im_continue}" styleClass="BottomImgSpace"
						onmouseover="this.src = '#{msgs.im_continue_over}'" 
						onmouseout="this.src = '#{msgs.im_continue}'" 
						onmousedown="this.src = '#{msgs.im_continue_down}'" 
						onmouseup="this.src = '#{msgs.im_continue_over}'"/>
                </h:commandLink>
                
	<h:commandLink id="cancelButton" action="#{deleteModulePage.backToModules}">
					<h:graphicImage id="cancelImg" value="#{msgs.im_cancel}" styleClass="BottomImgSpace"
						onmouseover="this.src = '#{msgs.im_cancel_over}'" 
						onmouseout="this.src = '#{msgs.im_cancel}'" 
						onmousedown="this.src = '#{msgs.im_cancel_down}'" 
						onmouseup="this.src = '#{msgs.im_cancel_over}'"/>
                </h:commandLink>	
	
			</div></td>
              </tr>
			 <tr><td  height="20" class="maintabledata5">&nbsp;</td></tr>
            </table>
          </td>
        </tr>
      </table>
	</h:form>

</td>
  </tr>
</table>
</td></tr></table>
  <!-- This Ends the Main Text Area -->
</body>
</f:view>
</html>
