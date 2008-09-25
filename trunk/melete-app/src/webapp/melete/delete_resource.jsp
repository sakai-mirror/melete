<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="description" content="ETUDES-NG Course Management System, Powered by Sakai">
<meta name="keywords" content="ETUDES-NG course management system, e-learning">

<!--  Copyright (c) 2008 Etudes, Inc. -->
 
<!--  Licensed under the Apache License, Version 2.0 (the "License"); -->
<!--   you may not use this file except in compliance with the License.-->
<!--   You may obtain a copy of the License at -->
  
<!--   http://www.apache.org/licenses/LICENSE-2.0 -->
  
<!--   Portions completed before September 1, 2008 Copyright (c) 2004, 2005, 2006, 2007, 2008 Foothill College, ETUDES Project -->
  
<!--   Licensed under the Apache License, Version 2.0 (the "License"); you -->
<!--   may not use this file except in compliance with the License. You may -->
<!--   obtain a copy of the License at -->
  
<!--   http://www.apache.org/licenses/LICENSE-2.0 -->
<!--  Unless required by applicable law or agreed to in writing, software -->
<!--  distributed under the License is distributed on an "AS IS" BASIS, -->
<!--  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or -->
<!--  implied. See the License for the specific language governing -->
<!--  permissions and limitations under the License. -->
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
<!-- End code to put in head section for image pre-loading. -->
<link rel="stylesheet" href="rtbc004.css" type="text/css">
<title>Melete - Delete Resource</title>
</head>
<f:view>
<body marginwidth="0" marginheight="0" topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" onLoad="setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');">
 <h:form id="DeleteResourceForm">
  <table width="100%"  border="1" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA"  style="border-collapse: collapse">
       <!-- This Begins the Main Text Area -->
      <td width="100%" valign="top" >
       <table width="100%"  border="1" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA" style="border-collapse: collapse">
        <tr>
          <td width="100%" height="20" class="maintabledata1">          
		  <div class="meletePortletToolBarMessage"><img src="images/Warning.gif" width="16" height="16" align="absbottom" border="0">
		     <h:outputText value="#{msgs.delete_resource_deletion_warning}" /></div>				
		  </td>
        </tr>
        <!-- show table with delete resources -->
        <tr><td width="100%" height="20" class="maintabledata5"></td></tr>
        <tr> 
        <td width="100%" valign="top">
           <h:messages id="deleteResourceError" layout="table" showDetail="true" showSummary="false" infoClass="BlueClass" errorClass="RedClass"/>
           <table width="85%"  border="1" align="center" cellpadding="10" cellspacing="5" bordercolor="#CCCCCC" style="border-collapse: collapse">
        	<tr>
        		<td> <img src="images/Warning.gif" border="0">
        		</td>
        		<td> 
        			<h:outputText value="#{msgs.delete_resource_message1}" />
        			<br/> <br/>    			
        			<!--datatable or panelgrid to display res names -->
        			<h:outputText value="#{deleteResourcePage.delResourceName}" styleClass="bold" />
        			<br/> <br/>    
        			<!--datatable or panelgrid to display warning message in red -->
        			
        			 <h:panelGrid id="WarningPanel" columns="1" width="85%" border="1" styleClass="RedBorderClass" rendered="#{deleteResourcePage.warningFlag}">
        			 <h:column>
        			 	<h:outputText value="#{msgs.delete_resource_in_use_warning}" styleClass="red" />
        			 </h:column>        			 
        			 </h:panelGrid> 
        			<br/>
        			<h:outputText value="#{msgs.delete_resource_long1}" />
        			<h:outputText value="#{msgs.delete_resource_long2}"  styleClass="bold"/>
        			<h:outputText value="#{msgs.delete_resource_long3}" />
        			<h:outputText value="#{msgs.delete_resource_long4}"  styleClass="bold"/>
        			<h:outputText value="#{msgs.delete_resource_long5}" />
        		</td>
        	</tr>
           </table>
        </td></tr>
          <tr>
                <td height="30" >         
                <div align="center">				
				<h:commandLink id="delButton" action="#{deleteResourcePage.deleteResource}">
					<h:graphicImage id="continueImg" value="#{msgs.im_continue}" styleClass="BottomImgSpace"
						onmouseover="this.src = '#{msgs.im_continue_over}'" 
						onmouseout="this.src = '#{msgs.im_continue}'" 
						onmousedown="this.src = '#{msgs.im_continue_down}'" 
						onmouseup="this.src = '#{msgs.im_continue_over}'"/>
                </h:commandLink>                
                          
				<h:commandLink id="cancelButton" action="#{deleteResourcePage.cancelDeleteResource}">
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
      </td></tr></table>

  <!-- This Ends the Main Text Area -->
  	</h:form>
</body>
</f:view>
</html>
