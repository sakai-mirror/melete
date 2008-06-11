<html>
<head>

<link rel="stylesheet" href="rtbc004.css" type="text/css">
<title>Melete - Modules: Author Student View</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>
<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
<script language="javascript1.2">
function showIframe()
{
 	var contentTypeStr=document.getElementById("viewsectionform:contentType").value;
    var openWindowStr=document.getElementById("viewsectionform:openWindow").value;
  
	if (contentTypeStr.match("typeEditor")||(contentTypeStr.match("typeUpload")&&openWindowStr.match("true"))||(contentTypeStr.match("typeLink")&&openWindowStr.match("true")))
	{
		document.getElementById("iframe1").style.visibility="hidden";
		document.getElementById("iframe1").style.display="none";
		
		document.getElementById("iframe2").style.visibility="hidden";
		document.getElementById("iframe2").style.display="none";
	}
	if (contentTypeStr.match("typeLink")&&openWindowStr.match("false"))
	{
	    document.getElementById("iframe2").style.visibility="hidden";
		document.getElementById("iframe2").style.display="none";
	}
	if (contentTypeStr.match("typeUpload")&&openWindowStr.match("false"))
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
		<h:outputText id="modtitle" value="#{viewSectionsPage.module.title}" styleClass="bold style6"></h:outputText>
		</td>
</tr> 

<tr>
		<td align="left">  
		  <h:outputText id="title" value="#{viewSectionsPage.section.title}" styleClass="bold style7"></h:outputText>     
		</td>
		<td align="right">
		<h:commandLink id="bmarkLink" action="#{viewSectionsPage.createBookmark}" immediate="true" rendered="#{viewSectionsPage.bookmarkStatus == false}">
		  <h:outputText  id="bmarkText1" value="#{msgs.bookmark_text}"/>
	    </h:commandLink>  
	    <h:graphicImage id="bmark_gif" value="images/bookmark.png" rendered="#{viewSectionsPage.bookmarkStatus == true}" styleClass="ExpClass"/>        
	    <h:outputText  id="bmarkText2" value="#{msgs.bookmarked_text}" rendered="#{viewSectionsPage.bookmarkStatus == true}"/>
	    <h:outputText id="seperatorMsg" value=" | "  rendered="#{viewSectionsPage.bookmarkStatus == true}"/>
	    <h:commandLink id="clearLink" action="#{viewSectionsPage.clearBookmark}" immediate="true"  rendered="#{viewSectionsPage.bookmarkStatus == true}">
		  <h:outputText  id="clearText" value="#{msgs.clear_bookmark_text}"/>
	    </h:commandLink>    
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
		 <h:outputText id="secinstLink" escape="false"
                           value="#{msgs.view_section_clicking}<BR><BR>" rendered="#{(((viewSectionsPage.section.contentType == viewSectionsPage.typeUpload)||(viewSectionsPage.section.contentType == viewSectionsPage.typeLink))&&(viewSectionsPage.contentLink != viewSectionsPage.nullString)&&(viewSectionsPage.section.openWindow == true))}">
      </h:outputText> 
      
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
      <iframe   id="iframe1" src="<h:outputText value="#{viewSectionsPage.content}" rendered="#{((viewSectionsPage.section.contentType == viewSectionsPage.typeLink)&&(viewSectionsPage.linkName != viewSectionsPage.nullString)&&(viewSectionsPage.section.openWindow == false))}"/>" style="visibility:visible" scrolling="auto" width="100%"  height="700" border="0" frameborder="0"></iframe>
      
  <h:outputText value="#{viewSectionsPage.content}" escape="false" rendered="#{((viewSectionsPage.section.contentType == viewSectionsPage.typeEditor)&&(viewSectionsPage.content != viewSectionsPage.nullString))}"/>
 
 <iframe   id="iframe2" src="<h:outputText value="#{viewSectionsPage.contentLink}" rendered="#{((viewSectionsPage.section.contentType == viewSectionsPage.typeUpload)&&(viewSectionsPage.contentLink != viewSectionsPage.nullString)&&(viewSectionsPage.section.openWindow==false))}"/>" style="visibility:visible" scrolling="auto" width="100%"  height="700" border="0" frameborder="0"></iframe>
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
<tr>
<td colspan="2">

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
