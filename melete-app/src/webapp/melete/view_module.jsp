<html>
<head>

<link rel="stylesheet" href="rtbc004.css" type="text/css">

<title>Melete - View Module</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
</head>
<f:view>
<body onLoad="setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');">

<h:form id="viewmoduleform">
<table width="100%"  border="0" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA" style="border-collapse: collapse" >
	<tr>
		<td valign="top">
<table border="0" class="table3" >
<tr>
		<td valign="top"> &nbsp;	</td>
		<td width="1962" valign="top">
			<table width="100%" border="0" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA" style="border-collapse: collapse" >
			<tr>
				<td>
							<f:subview id="top" rendered="#{viewModulesPage.instRole == true}">
							  <jsp:include page="topnavbar.jsp"/>
							</f:subview>
						<div class="meletePortletToolBarMessage"><img src="images/preview.png" alt="" width="16" height="16" align="absmiddle"><h:outputText value="#{msgs.view_module_studente_side}" /></div>		
						</td>
					</tr>		

	<!--Page Content-->
	<!-- The getmdbean method correctly determines the prev and next seq nos in the backing bean -->
	<!-- The hidden field below has been added just to get the getmdbean method to execute first -->
    <h:inputHidden id="hacktitle" value="#{viewModulesPage.mdbean.module.title}"/>
		 <tr>
			<td align="center">
			<f:subview id="topmod">
			<jsp:include page="view_navigate_mod.jsp"/>
			</f:subview>
			</td>
		</tr>     
		<tr>	<td>&nbsp;</td>		</tr>      
		<tr>
			<td align="left">
				<h:outputText id="title" value="#{viewModulesPage.mdbean.module.title}" styleClass="bold style6" ></h:outputText>				
			</td>
		</tr>
		<tr>
			<td align="left">
			<h:outputText id="description" value="#{viewModulesPage.mdbean.module.description}"  rendered="#{((viewModulesPage.mdbean.module.description != viewModulesPage.nullString)&&(viewModulesPage.mdbean.module.description != viewModulesPage.emptyString))}" />
			<h:outputText id="brval" value="<BR><BR>" escape="false"  rendered="#{((viewModulesPage.mdbean.module.description != viewModulesPage.nullString)&&(viewModulesPage.mdbean.module.description != viewModulesPage.emptyString))}" />
			</td>
		</tr>
		
		<td valign="top">
			<h:outputText id="secs" value="#{msgs.view_module_content_section}" ></h:outputText>  
			<h:dataTable id="tablesec"  value="#{viewModulesPage.mdbean.sectionBeans}" var="sectionBean" columnClasses="SectionClass" rowClasses="#{viewModulesPage.mdbean.rowClasses}" rendered="#{viewModulesPage.sectionSize > 0}" styleClass="SectionTableClass">
          	
		  <h:column>
		      <h:graphicImage id="bmark_gif" value="images/bookmark.png" rendered="#{sectionBean.bookmarkFlag == true}" styleClass="ExpClass"/>
          	   <h:outputText id="emp_space" value=" " styleClass="ExtraPaddingClass" rendered="#{((viewModulesPage.mdbean.bookmarkFlag == true)&&(sectionBean.bookmarkFlag != true))}"/>
            
          	   <h:graphicImage id="bul_gif" value="images/bullet_black.gif" rendered="#{sectionBean.section.title != viewModulesPage.nullString}"/>
					  <h:commandLink id="viewSectionEditor"  action="#{viewModulesPage.viewSection}" rendered="#{sectionBean.section.title != viewModulesPage.nullString}">
							  <h:outputText id="sectitleEditor" value="#{sectionBean.section.title}" > </h:outputText>
					  </h:commandLink>
			</h:column>
		</h:dataTable>        
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>             

	<tr>
		<td align="left">
			<h:outputText value="#{msgs.view_module_next}"  rendered="#{viewModulesPage.mdbean.module.whatsNext != viewModulesPage.nullString}" styleClass="bold style7"></h:outputText>
		</td>
	</tr>
	<tr>
	<td align="left">
		<h:outputText id="whatsnext" value="#{viewModulesPage.mdbean.module.whatsNext}"></h:outputText>     
	</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td align="center">
		<f:subview id="bottommod">
			<jsp:include page="view_navigate_mod.jsp"/>
		</f:subview>	  
		
		</td>
		</tr>
		<tr><td class="maintabledata5">&nbsp;   </td></tr>    
	</table>
  </td>
</tr>  
 </table>
</td>
</tr>  
 </table>
<!--End Content-->
</h:form>
</body>
</f:view>

</html>
 
