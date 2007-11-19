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
<script language="javascript1.2">
function showIframe()
{
 
	var str=document.getElementById("viewsectionform:contentType").value;

	if ((str.match("typeLink"))||(str.match("typeEditor")))
	{
		document.getElementById("iframe1").style.visibility="hidden";
		document.getElementById("iframe1").style.display="none";
	}
	
}	

</script>
</head>
<f:view>
<body onLoad="showIframe(),setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');">
<a name="newanchor"></a>
<h:form id="viewsectionform">
<table height="470" border="0" cellpadding="20"  width="100%" bordercolor="#EAEAEA" style="border-collapse: collapse" >
<tr>
	<td vAlign="top" width="100%"> 
<!--Page Content-->
<table  border="0" cellpadding="2" cellspacing="0" bordercolor="#EAEAEA" width="100%">
<tr>
<td align="center">
<f:subview id="topmod">
	<jsp:include page="view_navigate.jsp"/>
</f:subview>

	<h:panelGroup id="bcsecpgroup" binding="#{viewSectionsPage.secpgroup}"/>
</td>
</tr>    
	<tr>	<td>&nbsp;</td>		</tr>     
<tr>
<td align="left">
	 <h:outputText id="modtitle" value="#{viewSectionsPage.module.title}" styleClass="bold style6" >
</h:outputText>

</td>
</tr>    

<tr>
<td align="left">
 <h:outputText id="title" value="#{viewSectionsPage.section.title}" styleClass="bold style7"></h:outputText>     

</td>
</tr>    
<tr>
<td align="left">
<h:outputText value="#{msgs.view_section_student_instructions}"  rendered="#{((viewSectionsPage.section.instr != viewSectionsPage.nullString)&&(viewSectionsPage.section.instr != viewSectionsPage.emptyString))}" styleClass="italics"></h:outputText> &nbsp; <h:outputText id="instr" value="#{viewSectionsPage.section.instr}" rendered="#{((viewSectionsPage.section.instr != viewSectionsPage.nullString)&&(viewSectionsPage.section.instr != viewSectionsPage.emptyString))}"></h:outputText>  
</td>
</tr>    

<tr>
<td align="left">
  <h:inputHidden id="contentType" value="#{viewSectionsPage.section.contentType}"/>
			
	<br> 
		 <h:outputText id="secinstLink" 
                           value="#{msgs.view_section_clicking}" rendered="#{((viewSectionsPage.section.contentType == viewSectionsPage.typeLink)&&(viewSectionsPage.contentLink != viewSectionsPage.nullString))}">
      </h:outputText> 
      <br>
      <br>
	 <h:outputLink id="viewSectionLink"  value="#{viewSectionsPage.contentLink}" target="_blank" rendered="#{((viewSectionsPage.section.contentType == viewSectionsPage.typeLink)&&(viewSectionsPage.contentLink != viewSectionsPage.nullString))}">
      <h:outputText id="sectitleLink" 
                           value="#{viewSectionsPage.linkName}">
      </h:outputText>
    </h:outputLink>
      
  <h:outputText value="#{viewSectionsPage.content}" escape="false" rendered="#{((viewSectionsPage.section.contentType == viewSectionsPage.typeEditor)&&(viewSectionsPage.content != viewSectionsPage.nullString))}"/>
 <iframe   id="iframe1" src="<h:outputText value="#{viewSectionsPage.contentLink}" rendered="#{((viewSectionsPage.section.contentType == viewSectionsPage.typeUpload)&&(viewSectionsPage.contentLink != viewSectionsPage.nullString))}"/>" style="visibility:visible" scrolling="auto" width="100%"  height="700" border="0" frameborder="0"></iframe>
	</td>
	</tr>


<tr>
<td align="left">
&nbsp;
</td>
	</tr>
	<tr>
<td align="center">
<f:subview id="bottommod">
	<jsp:include page="view_navigate.jsp"/>
</f:subview>
</td>
</tr>    
 <!--End Content-->

<tr>
<td>
<TABLE  cellSpacing="0" cellPadding="0" width="100%" border="0" height="20">
  <TR>
   <TD align="center" class="meleteLicenseMsg center" width="100%" height="20">
   <B>
   <!--<A class=copyrighttable  href="http://www.fhda.edu/" target=_blank>-->
  <jsp:include page="license_info.jsp"/> 
		<!--<br>2004 Foothill  College 
	</A>-->
	</B>
	</TD>
  </TR>
</TABLE>
</td>
</tr> 


  </table>
</h:form>
<!--End Content-->
</td>
</tr>
</table>
</body>
</f:view>

</html>
