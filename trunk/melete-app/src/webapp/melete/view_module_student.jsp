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
<script type="text/javascript" language="javascript">
function OpenPrintWindow(print_id, windowName)
{
	
  var _info = navigator.userAgent;
  var _ie = (_info.indexOf("MSIE") > 0 && _info.indexOf("Win") > 0 && _info.indexOf("Windows 3.1") < 0);
	var windowDefaults = "status=no, menubar=no, location=no, scrollbars=yes, resizeable=yes, width=700, height=700, left=20, top=20";
	var newWindow;
	if(!_ie) newWindow = window.open('print_module.jsf?printModuleId='+print_id,windowName,windowDefaults);
	else newWindow = window.open('print_module.jsf?printModuleId='+print_id,null,windowDefaults);
if (window.focus) { newWindow.focus(); } ; // force the window to the front if the browser supports it
return newWindow;

}
</script>
</head>

<f:view>
<body onLoad="setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');">
<h:form id="viewmoduleStudentform">
<table width="100%"  border="0" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA" style="border-collapse: collapse" >
<tr>
		<td width="1962" valign="top">
			<table width="100%" border="0" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA" style="border-collapse: collapse" >
				<tr>
				<td colspan="2">
							<f:subview id="top">
							  <jsp:include page="topnavbar.jsp"/>
							</f:subview>
						</td>
					</tr>	
			<h:inputHidden id="hacktitle" value="#{viewModulesPage.mdbean.module.title}"/>
 <tr>
			<td align="center" colspan="2">
			<f:subview id="topmod">
			<jsp:include page="view_navigate_mod.jsp"/>
			</f:subview>
			</td>
		</tr>                     
<tr>
<td colspan="2">&nbsp;</td>
</tr>             
<tr>
<td align="left">
<h:outputText id="mod_seq" value="#{viewModulesPage.mdbean.cmod.seqNo}. " styleClass="bold style6" rendered="#{listModulesPage.autonumber}"/>
<h:outputText id="title" value="#{viewModulesPage.mdbean.module.title}" styleClass="bold style6" ></h:outputText>
</td>
<td align="right">	
				<h:outputLink id="printModuleLink" value="view_module_student" onclick="OpenPrintWindow(#{viewModulesPage.mdbean.moduleId},'Melete Print Window');" rendered="#{viewModulesPage.printable}">
			    	<f:param id="printmoduleId" name="printModuleId" value="#{viewModulesPage.mdbean.moduleId}" />
	  	  			<h:graphicImage id="printImgLink" value="images/printer.png" alt="#{msgs.list_auth_modules_alt_print}" title="#{msgs.list_auth_modules_alt_print}" styleClass="AuthImgClass"/>
	 		 </h:outputLink>				
			</td>
</tr>

<tr>
<td align="left" colspan="2">
<h:outputText id="description" value="#{viewModulesPage.mdbean.module.description}"  rendered="#{((viewModulesPage.mdbean.module.description != viewModulesPage.nullString)&&(viewModulesPage.mdbean.module.description != viewModulesPage.emptyString))}" />
			<h:outputText id="brval" value="<BR><BR>" escape="false"  rendered="#{((viewModulesPage.mdbean.module.description != viewModulesPage.nullString)&&(viewModulesPage.mdbean.module.description != viewModulesPage.emptyString))}" /> 
</td>
</tr>
            
<tr>
<td align="left" valign="top" colspan="2">
	<h:outputText id="secs" value="#{msgs.view_module_student_content_section}" ></h:outputText>  
			<h:dataTable id="tablesec"  value="#{viewModulesPage.mdbean.sectionBeans}" var="sectionBean" columnClasses="SectionClass"  rowClasses="#{viewModulesPage.mdbean.rowClasses}" rendered="#{viewModulesPage.sectionSize > 0}" styleClass="SectionTableClass">
               	  <h:column>
            		  <h:graphicImage id="bul_gif" value="images/bullet_black.gif" rendered="#{sectionBean.section.title != viewModulesPage.nullString}"/>
			          <h:commandLink id="viewSectionEditor"  action="#{viewModulesPage.viewSection}" rendered="#{sectionBean.section.title != viewModulesPage.nullString}" immediate="true">
				  <h:outputText id="sec_seq" value="#{sectionBean.displaySequence}. " rendered="#{listModulesPage.autonumber}"/>
										  <h:outputText id="sectitleEditor" value="#{sectionBean.section.title}" > </h:outputText>
					  </h:commandLink>
			</h:column>
  </h:dataTable>        
</td>
</tr>
<tr><td colspan="2">&nbsp;</td></tr>             
<tr>
<td align="left" colspan="2">

<h:outputText value="#{msgs.view_module_student_whats_next}"  rendered="#{viewModulesPage.mdbean.module.whatsNext != viewModulesPage.nullString}" styleClass="bold style7"></h:outputText>

</td>
</tr>
<tr>
<td align="left" colspan="2">
<h:outputText id="whatsnext" value="#{viewModulesPage.mdbean.module.whatsNext}">
</h:outputText>     
</td>
</tr>
<tr>
<td colspan="2">&nbsp;</td>
</tr>
<tr>
	<td align="center" colspan="2">
		<f:subview id="bottommod">
			<jsp:include page="view_navigate_mod.jsp"/>
		</f:subview>	  
		
	</td>	
		</tr>
		<tr><td class="maintabledata5" colspan="2">&nbsp;   </td></tr>    
		</table>
</td>
</tr>  

  </table>
<!--End Content-->
</h:form>
</body>
</f:view>

</html>
 
