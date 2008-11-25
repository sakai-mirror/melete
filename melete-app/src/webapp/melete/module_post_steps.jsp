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


<title>Melete - Module Post Steps</title>
<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
</head>

<f:view>
<body marginwidth="0" marginheight="0" topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" onload="setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');" >

<h:form id="ModulePostStepsForm">
<!-- This Begins the Main Text Area -->
<table width="100%"  border="1" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA" style="border-collapse: collapse">
        <tr>
          <td width="100%" class="maintabledata1">
			  	<!-- top nav bar -->
						<f:subview id="top">
								<jsp:include page="topnavbar.jsp"/> 
						</f:subview>
						<div class="meletePortletToolBarMessage"><img src="images/view_next.gif" alt="" width="16" height="16" align="absbottom"><h:outputText value="#{msgs.module_post_steps_whats_next}" /> </div>
					</td>
				</tr>
			    </tr>
				<tr><td height="20" class="maintabledata3"><h:messages showDetail="true" showSummary="false" infoClass="BlueClass" errorClass="RedClass"/></td></tr>
			<tr>
			  <td class="maintabledata3">
				  <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#EAEAEA" width="100%" id="AutoNumber1">
              <tr>
                <td valign="top">
				<table border="0" cellspacing="0" cellpadding="3">
				  <tr><td height="20" class="maintabledata5">
							  <h:outputText id="text5" value="#{msgs.module_post_steps_message1}"/> 
				  </td></tr>
				  <tr><td>&nbsp;</td></tr>
                  <tr>
                    <td>
                    <h:outputText id="text6" value="#{msgs.module_post_steps_message2}"/> </td>
                  </tr>
                  <tr><td>&nbsp;</td></tr>
                  <tr>
                    <td>  <h:outputText id="text4"  value="#{moduleNextStepsPage.mdBean.module.title}" /></td>
                  </tr>
                  <tr><td><h:message style="color: red" for="nextsteps"/></td></tr>
                  <tr>
                    <td>
                    <h:inputTextarea id="nextsteps" cols="65" rows="7" value="#{moduleNextStepsPage.mdBean.module.whatsNext}" styleClass="formtext"> <f:validateLength maximum="700" minimum="1" /> </h:inputTextarea>   </td>
                  </tr>
                </table>  
                    </td>
              </tr>
              <tr>
                <td height="30"><div align="center">          
                <h:commandLink id="addsteps"  action="#{moduleNextStepsPage.addPostSteps}" rendered="#{moduleNextStepsPage.mdBean.module.whatsNext == moduleNextStepsPage.isNull}">
						<h:graphicImage id="addImg" value="#{msgs.im_add_button}" styleClass="BottomImgSpace" 
							onmouseover="this.src = '#{msgs.im_add_button_over}'" 
							onmouseout="this.src = '#{msgs.im_add_button}'" 
							onmousedown="this.src = '#{msgs.im_add_button_down}'" 
							onmouseup="this.src = '#{msgs.im_add_button_over}'"/>
				</h:commandLink>       			
							
					 <h:commandLink id="savesteps"  action="#{moduleNextStepsPage.savePostSteps}" rendered="#{moduleNextStepsPage.mdBean.module.whatsNext != moduleNextStepsPage.isNull}">
						<h:graphicImage id="saveImg" value="#{msgs.im_save}" styleClass="BottomImgSpace" 
						onmouseover="this.src = '#{msgs.im_save_over}'" 
						onmouseout="this.src = '#{msgs.im_save}'" 
						onmousedown="this.src = '#{msgs.im_save_down}'" 
						onmouseup="this.src = '#{msgs.im_save_over}'"/>
				</h:commandLink>       	
				
						<h:commandLink id="cancel"  action="#{moduleNextStepsPage.cancelChanges}" immediate="true" >
							<h:graphicImage id="cancelModImg" value="#{msgs.im_cancel}" styleClass="BottomImgSpace" 
											onmouseover="this.src = '#{msgs.im_cancel_over}'" 
											onmouseout="this.src = '#{msgs.im_cancel}'" 
											onmousedown="this.src = '#{msgs.im_cancel_down}'" 
						   				  	onmouseup="this.src = '#{msgs.im_cancel_over}'"/>
						   </h:commandLink>				  	
                                </div></td>
              </tr>
			 <tr><td height="20" class="maintabledata5">&nbsp;</td></tr>
            </table>
          </td>
        </tr>
      </table>      
      <p>&nbsp;</p>

       
</td>
  </tr>
</table>
		</h:form>
<!-- This Ends the Main Text Area -->

</body>
</f:view>
</html>	  		
