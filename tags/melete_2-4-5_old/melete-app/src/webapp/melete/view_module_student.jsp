<html>
<head>

<link rel="stylesheet" href="rtbc004.css" type="text/css">

<title>Melete - View Module</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<link href="/library/skin/tool_base.css" type="text/css" rel="stylesheet" media="all" />
<link href="/library/skin/default/tool.css" type="text/css" rel="stylesheet" media="all" />
<link href="rtbc004.css" type="text/css" rel="stylesheet" media="all" />
<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
</head>

<f:view>
<body onLoad="setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');">
<h:form id="viewmoduleStudentform">
<table width="100%"  border="0" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA" style="border-collapse: collapse" >
<tr>
		<td width="1962" valign="top">
			<table width="100%" border="0" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA" style="border-collapse: collapse" >
 <tr>
			<td align="center">
			<f:subview id="topmod">
			<jsp:include page="view_navigate_mod.jsp"/>
			</f:subview>
			</td>
		</tr>                     
<tr>
<td>&nbsp;</td>
</tr>             
<tr>
<td align="left" width="100%">
<h:outputText id="title" value="#{viewModulesPage.mdbean.module.title}" styleClass="bold style6" ></h:outputText>
</td>
</tr>

<tr>
<td align="left">
<h:outputText id="description" value="#{viewModulesPage.mdbean.module.description}">
</h:outputText>  
</td>
</tr>
<tr>
<td>&nbsp;</td>
</tr>             
<tr>
<td align="left" valign="top">
	<h:outputText id="secs" value="#{msgs.view_module_student_content_section}" ></h:outputText>  
			<h:dataTable id="tablesec"  value="#{viewModulesPage.mdbean.sectionBeans}" var="sectionBean" columnClasses="SectionClass"  rowClasses="#{viewModulesPage.mdbean.rowClasses}" rendered="#{viewModulesPage.sectionSize > 0}" styleClass="SectionTableClass">
               	  <h:column>
					   <h:outputText id="disp_seq" value="#{sectionBean.displaySequence}"/>
                       <h:outputText id="emp_space2" value=" "/> <h:commandLink id="viewSectionEditor"  action="#{viewModulesPage.viewSection}" rendered="#{sectionBean.section.title != viewModulesPage.nullString}">
										  <h:outputText id="sectitleEditor" value="#{sectionBean.section.title}" > </h:outputText>
					  </h:commandLink>
			</h:column>
  </h:dataTable>        
</td>
</tr>
<tr><td>&nbsp;</td></tr>             
<tr>
<td align="left">

<h:outputText value="#{msgs.view_module_student_whats_next}"  rendered="#{viewModulesPage.mdbean.module.whatsNext != viewModulesPage.nullString}" styleClass="bold style7"></h:outputText>

</td>
</tr>
<tr>
<td align="left">
<h:outputText id="whatsnext" value="#{viewModulesPage.mdbean.module.whatsNext}">
</h:outputText>     
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
<!--End Content-->
</h:form>
</body>
</f:view>

</html>
 