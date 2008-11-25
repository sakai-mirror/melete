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
<html><head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="description" content="ETUDES-NG Course Management System, Powered by Sakai">
<meta name="keywords" content="ETUDES-NG course management system, e-learning">

<link rel="stylesheet" type="text/css" href="rtbc004.css">
<title>Melete - Sort Modules</title>
<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
</head>

<f:view>
<body marginwidth="0" marginheight="0" topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" onload="setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');" >
<h:form id="SortModuleForm">
<!-- This Begins the Main Text Area -->

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
						<div class="meletePortletToolBarMessage"><img src="images/document_exchange.gif" alt="" width="16" height="16" align="absmiddle"><h:outputText value="#{msgs.sort_modules_top_message}" /> </div>
					</td>
				</tr>
				<tr>
					<td class="maintabledata3" valign="top">
						<!-- main page contents -->
			 			<h:messages id="sorterror" layout="table" style="color : red" />
						<table width="100%"  border="1" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA" style="border-collapse: collapse">
			   				    <tr>
                    			<td colspan="3">
									<table width="40%"  border="0" cellspacing="0" cellpadding="0">
                				      <tr>
				                        <td class="style2"><h:outputText value="#{msgs.sort_modules_sort}" /></td>
										<td><div>
										 <!-- Begin code to display images horizontally. -->
											<h:graphicImage id="Sort_Modules-horz"
								   							alt="#{msgs.sort_modules_sort_modules}"
								   							url="images/Sort_Modules-down2.gif"
								     						 width="85" height="20" styleClass="BottomImgSpace"/>
								     						 
					     			<h:commandLink id="sortsec"  action="#{manageModulesPage.gotoSortSections}" immediate="true" >					 
										<h:graphicImage id="sortSectionsImg" value="images/Sort_Sections.gif" width="85" height="20" styleClass="BottomImgSpace" 
													onmouseover="this.src = 'images/Sort_Sections-over.gif'" 
													onmouseout="this.src = 'images/Sort_Sections.gif'" 
													onmousedown="this.src = 'images/Sort_Sections-down.gif'" 
													onmouseup="this.src = 'images/Sort_Sections-over.gif'"/>
										</h:commandLink>			
										<!-- End code to display images horizontally. -->
										</div></td>
									  </tr>
									</table>
								</td>
							  </tr>
							   <tr>
								<th class="tableheader style4 " height="20"><h:outputText value="#{msgs.sort_modules_curr_seq}" /> </th>
								<th class="tableheader">&nbsp;</th>
								<th class="tableheader style4" height="20"><h:outputText value="#{msgs.sort_modules_new_seq}" /></th>
							  </tr>
							  <tr>
								<td width="45%" valign="top" class="maintabledata3">
									<table align="center" width="100%"  border="1" cellpadding="3" cellspacing="0"  bordercolor="#EAEAEA" style="border-collapse: collapse" id="current">
									  <tr>
										<td>
										<table width="100%" border="0" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" style="border-collapse: collapse">
											<tr>
											 <td align="left" class="maintabledata3">
												 <h:selectOneListbox id="modulecurrList" disabled="true" size="#{manageModulesPage.showSize}" style="width:300px">
															 <f:selectItems value="#{manageModulesPage.currList}" />							
												 </h:selectOneListbox>
											   </td>
											</tr>
										</table></td> 
									</tr>
            		    		   </table>                      
		                    	  </td>
        			            <td width="6%" class="maintabledata3" ></td>
                    			<td width="49%" valign="top" class="maintabledata3">
									<table align="center" width="100%"  border="1" cellpadding="1" cellspacing="0" bordercolor="#CCCCCC" bgcolor="#EEEEEE" style="border-collapse: collapse" id="new">
									  <tr>
										 <td width="100%">
											<table width="100%" border="0" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" style="border-collapse: collapse">
											<tr>
                       						 <td align="left">
                       						 	 <h:selectOneListbox id="modulenewList" value="#{manageModulesPage.newSelectedModule}" size="#{manageModulesPage.showSize}" style="width:300px">
															 <f:selectItems value="#{manageModulesPage.newList}" />							
													 </h:selectOneListbox>
											  </td>                        
											 </tr>
											</table></td> 
				                        <td width="15" align="center">			
				                        <h:commandLink id="all_up"  action="#{manageModulesPage.MoveItemAllUpAction}">		
										 <h:graphicImage id="allupImg" value="images/up_end.gif" alt="Move All Up" width="20" height="20" styleClass="BottomImgSpace" />
								   </h:commandLink>	           
									<h:commandLink id="up_one"  action="#{manageModulesPage.MoveItemUpAction}">		
										 <h:graphicImage id="upImg" value="images/up.gif" alt="Move Up" width="20" height="20" styleClass="BottomImgSpace" />
								   </h:commandLink>		 
 									<h:commandLink id="down_one"  action="#{manageModulesPage.MoveItemDownAction}">	 
										 <h:graphicImage id="downImg" value="images/down.gif" alt="Move Down" width="20" height="20" styleClass="BottomImgSpace" />
 									   </h:commandLink>	
 									   <h:commandLink id="all_down"  action="#{manageModulesPage.MoveItemAllDownAction}">		
										 <h:graphicImage id="downImg1" value="images/down_end.gif" alt="Move All Down" width="20" height="20" styleClass="BottomImgSpace" />
								   </h:commandLink>	    					
									  </td>
				                      </tr>
                				    </table></td>
				                  </tr>
                				 <tr><td colspan="3" class="maintabledata5">&nbsp;</td>
				 				</tr>
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