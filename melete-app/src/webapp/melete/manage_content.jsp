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
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>
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
<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="description" content="ETUDES-NG Course Management System, Powered by Sakai">
<meta name="keywords" content="ETUDES-NG course management system, e-learning">


<title>Melete - Manage Content</title>
<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
</head>

<f:view>
<body marginwidth="0" marginheight="0" topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" onload="setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');" >
 <h:form id="ManageContentForm">
<table>
	<tr>
		<td valign="top"></td>
    	<td width="1962" valign="top">
        	<table width="100%"  border="1" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA"  style="border-collapse: collapse">
          		<tr>
            		<td width="100%" height="20" bordercolor="#E2E4E8">
					<!-- top nav bar -->
						<f:subview id="top">
								<jsp:include page="topnavbar.jsp"/> 
						</f:subview>
		  <div class="meletePortletToolBarMessage"><img src="images/manage_content.png" width="16" height="16" align="absbottom" border="0"><h:outputText value="#{msgs.manage_content_title}" /></div>				
				</td>
        </tr>
        <tr>
          <td class="maintabledata3">
          	<h:messages showDetail="true" showSummary="false" infoClass="BlueClass" errorClass="RedClass"/>
		  <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#EAEAEA" width="100%" id="AutoNumber1">
		  	<tr>
		  		<td height="20" class="maintabledata5"><h:outputText id="t1_1" value="#{msgs.manage_content_new_item}" styleClass="tableheader2"/> </td></tr>
            <tr>
                <td align="center">
                	<table border="0" cellpadding="0" cellspacing="3" width="95%">
                	<tr>
                		<td colspan="2">
                		<h:outputText id="t1" value="#{msgs.manage_content_add_item}" />
       
						  <h:selectOneMenu id="fileType" value="#{manageResourcesPage.fileType}"  >

						    <f:selectItem itemValue="upload" itemLabel="#{msgs.manage_content_upload}"/>	
							<f:selectItem itemValue="link" itemLabel="#{msgs.manage_content_link}"/>	
						 </h:selectOneMenu>
					</td>	
			</tr>	
			<tr>
                		<td colspan="2">
                		<h:outputText id="t2" value="#{msgs.manage_content_number}"/>
                	
						  <h:selectOneMenu id="number" value="#{manageResourcesPage.numberItems}" >
						    <f:selectItem itemValue="1" itemLabel="#{msgs.manage_content_one}"/>	
							<f:selectItem itemValue="2" itemLabel="#{msgs.manage_content_two}"/>	
							<f:selectItem itemValue="3" itemLabel="#{msgs.manage_content_three}"/>	
							<f:selectItem itemValue="4" itemLabel="#{msgs.manage_content_four}"/>
							<f:selectItem itemValue="5" itemLabel="#{msgs.manage_content_five}"/>	
							<f:selectItem itemValue="6" itemLabel="#{msgs.manage_content_six}"/>
							<f:selectItem itemValue="7" itemLabel="#{msgs.manage_content_seven}"/>	
							<f:selectItem itemValue="8" itemLabel="#{msgs.manage_content_eight}"/>
							<f:selectItem itemValue="9" itemLabel="#{msgs.manage_content_nine}"/>	
							<f:selectItem itemValue="10" itemLabel="#{msgs.manage_content_ten}"/>
						 </h:selectOneMenu>
					</td>	
			</tr>	
			</table>
				</td></tr>						
				</table></td></tr>
										
              <tr>
                <td height="30" >         
                <div align="center">	
                <h:commandLink id="continueButton"  action="#{manageResourcesPage.addItems}"  tabindex="9">
					<h:graphicImage id="continueImg" value="#{msgs.im_continue}" styleClass="BottomImgSpace" 
						onmouseover="this.src = '#{msgs.im_continue_over}'" 
						onmouseout="this.src = '#{msgs.im_continue}'" 
						onmousedown="this.src = '#{msgs.im_continue_down}'" 
						onmouseup="this.src = '#{msgs.im_continue_over}'"/>
                </h:commandLink>				
				<h:commandLink id="cancelButton"  action="#{manageResourcesPage.cancel}"  immediate="true" tabindex="9">
					<h:graphicImage id="cancelImg" value="#{msgs.im_cancel}" styleClass="BottomImgSpace"
						onmouseover="this.src = '#{msgs.im_cancel_over}'" 
						onmouseout="this.src = '#{msgs.im_cancel}'" 
						onmousedown="this.src = '#{msgs.im_cancel_down}'" 
						onmouseup="this.src = '#{msgs.im_cancel_over}'"/>
                </h:commandLink>	
			</div></td>
              </tr>
			 
			 <tr><td  height="20" class="maintabledata5">&nbsp;</td></tr>
			 <tr>
        		 <td align="center">
				  <f:subview id="DeleteResourceView">
						<jsp:include page="manage_delete_resources.jsp"/> 
				  </f:subview>	
				</td>
			</tr>									

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
