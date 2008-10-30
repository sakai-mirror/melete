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

<link rel="stylesheet" href="rtbc004.css" type="text/css">
<title>Melete - Modules: Author Student View</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>
<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
</head>

<f:view>
<body onLoad="setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');">
<a name="newanchor"></a>
<h:form id="viewNSsectionform">       
<table height="470" border="0" cellpadding="20"  width="100%" bordercolor="#EAEAEA" style="border-collapse: collapse" >
<tr>
	<td valign="top" width="100%"> 
			<table  border="0" cellpadding="2" cellspacing="0" bordercolor="#EAEAEA" width="99%" style="border-collapse: collapse" >
					<tr>
					<td>
								<f:subview id="top">
												  <jsp:include page="topnavbar.jsp"/> 
									</f:subview>
								<div class="meletePortletToolBarMessage">
								<h:graphicImage id="previewtopimg" value="images/preview.png" styleClass="AuthMessageImgClass" rendered="#{viewNextStepsPage.instRole == true}"/>
								<h:outputText value="#{msgs.view_whats_next_viewing}" rendered="#{viewNextStepsPage.instRole == true}"/>
								</div>	
					</td>
				</tr>
	<!--Page Content-->

	<tr>
		<td align="center">
					<f:subview id="topmod">
						<jsp:include page="view_navigate_wn.jsp"/>
					</f:subview>
				<h:panelGroup id="bcsecpgroup" binding="#{viewNextStepsPage.secpgroup}"/>
			</td>
</tr> 
<tr>
		<td align="left">  &nbsp;		</td>
</tr> 

<tr>
		<td align="left">  
				<h:outputText value="#{msgs.view_whats_next_whats_next}"   styleClass="bold style7"></h:outputText>      
		</td>
</tr> 
<tr>
		<td align="left">  
				<h:outputText id="wnext" value="#{viewNextStepsPage.module.whatsNext}"></h:outputText>     
		</td>
</tr> 

 <tr>
<td align="left"> &nbsp;</td>
</tr>
<tr>
<td align="center">
					<f:subview id="bottommod">
						<jsp:include page="view_navigate_wn.jsp"/>
					</f:subview>
</td>
</tr>                
<tr>
<td>

<table width="100%" height="20" border="0" cellpadding="3" cellspacing="0" >
   	<tr>
	 <td align="center" class="meleteLicenseMsg center"><B><!--<a 

class=copyrighttable
      href="http://www.fhda.edu/" target=_blank>--> 
  <jsp:include page="license_info.jsp"/>
      <!--</a><br>-->
         </B></TD></TR>
	    </TABLE>


</td>
</tr> 


  </table>

<!--End Content-->
</td>
</tr>
</table>
</h:form>
</body>
</f:view>
</html>
