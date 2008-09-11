<html>
<head>

<link href="rtbc004.css" type="text/css" rel="stylesheet" />


<title>Melete - Modules: Student View</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>
<link href="/library/skin/tool_base.css" type="text/css" rel="stylesheet" media="all" />
<link href="/library/skin/default/tool.css" type="text/css" rel="stylesheet" media="all" />
<link href="rtbc004.css" type="text/css" rel="stylesheet" media="all" />
<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
</head>
<f:view>
<body onLoad="setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');">
<a name="newanchor"></a>
<h:form id="viewsectionStudentform">
<table height="470" border="0" cellpadding="20"  width="100%" bordercolor="#EAEAEA" style="border-collapse: collapse" >
<tr>
	<td width="100%" valign="top"> 
<!--Page Content-->
<table  border="0" cellpadding="2" cellspacing="0" bordercolor="#EAEAEA" width="100%" style="border-collapse: collapse" >
<tr>
					<td colspan="2">
								<f:subview id="top">
												  <jsp:include page="topnavbar.jsp"/> 
									</f:subview>	
					</td>
				</tr>
<tr>
<td colspan="2" align="center">
<f:subview id="topmod">
	<jsp:include page="view_navigate.jsp"/>
</f:subview>

	<h:panelGroup id="bcsecpgroup" binding="#{viewSectionsPage.secpgroup}"/>
</td>
</tr>    
	<tr>	<td colspan="2">&nbsp;</td>		</tr>     
<tr>
<td colspan="2" align="left">
         <h:outputText id="mod_seq" value="#{viewSectionsPage.moduleSeqNo}. " styleClass="bold style6" rendered="#{viewSectionsPage.autonumber}"/>
	 <h:outputText id="modtitle" value="#{viewSectionsPage.module.title}" styleClass="bold style6" >
</h:outputText>

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
<h:outputText value="#{msgs.view_section_student_instructions} "  rendered="#{((viewSectionsPage.section.instr != viewSectionsPage.nullString)&&(viewSectionsPage.section.instr != viewSectionsPage.emptyString))}" styleClass="italics"></h:outputText><h:outputText id="instr" value="#{viewSectionsPage.section.instr}" rendered="#{((viewSectionsPage.section.instr != viewSectionsPage.nullString)&&(viewSectionsPage.section.instr != viewSectionsPage.emptyString))}"></h:outputText>  
</td>
</tr>    

<tr>
	<td colspan="2" align="left">
		    <h:inputHidden id="contentType" value="#{viewSectionsPage.section.contentType}"/>
			 <h:inputHidden id="openWindow" value="#{viewSectionsPage.section.openWindow}"/>
			
		<br>
      
	 <h:outputLink id="viewSectionLink"  value="#{viewSectionsPage.contentLink}" target="_blank" rendered="#{((viewSectionsPage.section.contentType == viewSectionsPage.typeLink)&&(viewSectionsPage.contentLink != viewSectionsPage.nullString)&&(viewSectionsPage.section.openWindow == true))}">
      <h:outputText id="sectitleLink" 
                           value="#{viewSectionsPage.linkName}">
      </h:outputText>
    </h:outputLink>
    <h:outputLink id="viewSectionUpload"  value="#{viewSectionsPage.contentLink}" target="_blank" rendered="#{((viewSectionsPage.section.contentType == viewSectionsPage.typeUpload)&&(viewSectionsPage.contentLink != viewSectionsPage.nullString)&&(viewSectionsPage.section.openWindow == true))}">
      <h:outputText id="sectitleUpload" 
                           value="#{viewSectionsPage.linkName}">
      </h:outputText>
    </h:outputLink>
    <h:outputText id="contentFrame" value="<iframe id=\"iframe1\" src=\"#{viewSectionsPage.content}\" style=\"visibility:visible\" scrolling= \"auto\" width=\"100%\" height=\"700\" border=\"0\" frameborder= \"0\"></iframe>" rendered="#{((viewSectionsPage.section.contentType ==viewSectionsPage.typeLink)&&(viewSectionsPage.linkName !=
    viewSectionsPage.nullString)&&(viewSectionsPage.section.openWindow == false))}" escape="false" />
    
  <h:outputText value="#{viewSectionsPage.content}" escape="false" rendered="#{((viewSectionsPage.section.contentType == viewSectionsPage.typeEditor)&&(viewSectionsPage.content != viewSectionsPage.nullString))}"/>
	<h:outputText id="contentUploadFrame" value="<iframe id=\"iframe2\" src=\"#{viewSectionsPage.contentLink}\" style=\"visibility:visible\" scrolling= \"auto\" width=\"100%\" height=\"700\"
    border=\"0\" frameborder= \"0\"></iframe>" rendered="#{((viewSectionsPage.section.contentType ==viewSectionsPage.typeUpload)&&(viewSectionsPage.section.openWindow == false))}" escape="false" />
	</td> 
	</tr>


<tr>
<td colspan="2" align="left">
&nbsp;
</td>
	</tr>
	<tr>
<td colspan="2" align="center">
<f:subview id="bottommod">
	<jsp:include page="view_navigate.jsp"/>
</f:subview>
</td>
</tr>
</table></td>
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
