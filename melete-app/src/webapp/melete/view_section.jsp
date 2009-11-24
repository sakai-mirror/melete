<!--
 ***********************************************************************************
 * $URL$
 * $Id$  
 ***********************************************************************************
 *
 * Copyright (c) 2008, 2009 Etudes, Inc.
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
<html>
<head>
<title>Melete - Modules: Author Student View</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>
<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
</head>

<f:view>
<body onLoad="setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');">
<a name="newanchor"></a>
<h:form id="viewsectionform">       
<table height="470" border="0" cellpadding="20"  width="100%" bordercolor="#EAEAEA" style="border-collapse: collapse" >
<tr>
	<td vAlign="top" width="100%"> 
			<table  border="0" cellpadding="2" cellspacing="0" bordercolor="#EAEAEA" width="99%">
					<tr>
					<td colspan="2">
								<f:subview id="top" rendered="#{viewSectionsPage.instRole == true}">
												  <jsp:include page="topnavbar.jsp"/> 
									</f:subview>
								<div class="meletePortletToolBarMessage"><img src="images/preview.png" alt="" width="16" height="16" align="absmiddle"><h:outputText value="#{msgs.view_section_viewing_student}" /></div>	
					</td>
				</tr>
	<!--Page Content-->

	<tr>
		<td colspan="2" align="center">
					<f:subview id="topmod">
						<jsp:include page="view_navigate.jsp"/>
					</f:subview>
				<h:panelGroup id="bcsecpgroup" binding="#{viewSectionsPage.secpgroup}"/>
			</td>
</tr> 
<tr>
		<td colspan="2" align="left">  &nbsp;		</td>
</tr> 
<tr>
    	<td colspan="2" align="left">  
	        <h:outputText id="mod_seq" value="#{viewSectionsPage.moduleSeqNo}. " styleClass="bold style6" rendered="#{viewSectionsPage.autonumber}"/>
		<h:outputText id="modtitle" value="#{viewSectionsPage.module.title}" styleClass="bold style6"></h:outputText>
		</td>
</tr> 

<tr>
		<td colspan="2" align="left">  
	        <h:outputText id="sec_seq" value="#{viewSectionsPage.sectionDisplaySequence}. " styleClass="bold style7" rendered="#{viewSectionsPage.autonumber}"/>
		  <h:outputText id="title" value="#{viewSectionsPage.section.title}" styleClass="bold style7"></h:outputText>     
		</td>
		
</tr> 

<tr>
		<td colspan="2" align="left">  
				<h:outputText value="#{msgs.view_section_instructions} "  rendered="#{((viewSectionsPage.section.instr != viewSectionsPage.nullString)&&(viewSectionsPage.section.instr != viewSectionsPage.emptyString))}"  styleClass="italics"></h:outputText> <h:outputText id="instr" value="#{viewSectionsPage.section.instr}" rendered="#{((viewSectionsPage.section.instr != viewSectionsPage.nullString)&&(viewSectionsPage.section.instr != viewSectionsPage.emptyString))}"></h:outputText>     
		</td>
</tr> 
<tr>
	<td colspan="2" align="left">
		    <h:inputHidden id="contentType" value="#{viewSectionsPage.section.contentType}"/>
			 <h:inputHidden id="openWindow" value="#{viewSectionsPage.section.openWindow}"/>
			
		<br> 
       <h:outputText escape="false" value="<a target='new_window' href='" rendered="#{((viewSectionsPage.section.contentType == viewSectionsPage.typeLink || viewSectionsPage.section.contentType == viewSectionsPage.typeUpload || viewSectionsPage.section.contentType == viewSectionsPage.typeLTI)&&(viewSectionsPage.contentLink != viewSectionsPage.nullString)&&(viewSectionsPage.section.openWindow == true))}"/>
       <h:outputText value="#{viewSectionsPage.contentLink}" rendered="#{((viewSectionsPage.section.contentType == viewSectionsPage.typeLink || viewSectionsPage.section.contentType == viewSectionsPage.typeUpload || viewSectionsPage.section.contentType == viewSectionsPage.typeLTI)&&(viewSectionsPage.contentLink != viewSectionsPage.nullString)&&(viewSectionsPage.section.openWindow == true))}"/>
       <h:outputText escape="false" value="'>#{viewSectionsPage.linkName}</a>" rendered="#{((viewSectionsPage.section.contentType == viewSectionsPage.typeLink || viewSectionsPage.section.contentType == viewSectionsPage.typeUpload || viewSectionsPage.section.contentType == viewSectionsPage.typeLTI)&&(viewSectionsPage.contentLink != viewSectionsPage.nullString)&&(viewSectionsPage.section.openWindow == true))}"/>

    <h:outputText id="contentFrame" value="<iframe id=\"iframe1\" src=\"#{viewSectionsPage.content}\" style=\"visibility:visible\" scrolling= \"auto\" width=\"100%\" height=\"700\"
    border=\"0\" frameborder= \"0\"></iframe>" rendered="#{((viewSectionsPage.section.contentType ==viewSectionsPage.typeLink)&&(viewSectionsPage.linkName !=
    viewSectionsPage.nullString)&&(viewSectionsPage.section.openWindow == false))}" escape="false" />

   <h:outputText value="#{viewSectionsPage.content}" escape="false" rendered="#{((viewSectionsPage.section.contentType == viewSectionsPage.typeEditor)&&(viewSectionsPage.content != viewSectionsPage.nullString))}"/>

	<h:outputText id="contentUploadFrame" value="<iframe id=\"iframe2\" src=\"#{viewSectionsPage.contentLink}\" style=\"visibility:visible\" scrolling= \"auto\" width=\"100%\" height=\"700\"
    border=\"0\" frameborder= \"0\"></iframe>" rendered="#{((viewSectionsPage.section.contentType == viewSectionsPage.typeUpload)&&(viewSectionsPage.section.openWindow == false))}" escape="false" />

	<h:outputText id="contentLTI" value="#{viewSectionsPage.contentLTI}" 
              rendered="#{((viewSectionsPage.section.contentType == viewSectionsPage.typeLTI)&&(viewSectionsPage.section.openWindow == false))}" escape="false" />
	</td>
	</tr>


 <tr>
<td colspan="2" align="left"> &nbsp;</td>
</tr>
<tr>
<td colspan="2" align="center">
					<f:subview id="bottommod">
						<jsp:include page="view_navigate.jsp"/>
					</f:subview>
</td>
</tr>
</table>
</td>
</tr>
<tr><td>
<table width="100%" height="20" border="0" cellpadding="3" cellspacing="0" >
   	<tr>
	 <td align="center" class="meleteLicenseMsg center"><B>
  			<jsp:include page="license_info.jsp"/>      
         </B></td></tr>
	    </table>
</td></tr>
</table>
</h:form>
</body>
</f:view>
</html>
