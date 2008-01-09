<html>
<head>
<link rel="stylesheet" href="rtbc004.css" type="text/css">
<title>Melete - Move Sections</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
</head>
<f:view>
<body onLoad="setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');">
<h:form id="moveSectionsForm">

<table border="0" height="350" cellpadding="0" cellspacing="0" class ="table3">
	<tr>
		<td valign="top"> 		&nbsp;		</td>
		<td width="1962" valign="top">
		  <table width="100%" border="1" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA" style="border-collapse: collapse">
			<tr>
				<td>
					<f:subview id="top">
						<jsp:include page="topnavbar.jsp"/> 
					</f:subview>
					<div class="meletePortletToolBarMessage"><img src="images/page_go.png" alt="" width="16" height="16" align="absbottom"><h:outputText value="#{msgs.move_sections_msg}" /> </div>
				</td>
			</tr>
			<tr>
				<td class="maintabledata3">
					<h:messages id="movesectionerror" layout="table" showDetail="true" showSummary="false" infoClass="BlueClass" errorClass="RedClass"/>
					<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#EAEAEA" width="100%" id="AutoNumber1" >
        				<tr class="maintabledata5">
        				<td valign="top">
						  <h:dataTable id="table"  
		                	  value="#{moveSectionsPage.moduleDateBeans}" 
		                  	  var="mdbean"  rowClasses="row1,row2" columnClasses="ModCheckClass,titleWid"
		                  	  border="0" width="100%" rendered="#{moveSectionsPage.nomodsFlag == false}" >
	       					 <h:column>	       					  
	       					     <h:selectOneRadio id="select_module_id" valueChangeListener="#{moveSectionsPage.selectedModuleChange}" >
	       					     	<f:selectItem itemValue="" itemLabel="" /> 
	       					     </h:selectOneRadio>
	       					 </h:column>
	       					  <h:column>
	       					     <f:facet name="header">
	            				 	<h:outputText id="t2" value="#{msgs.move_sections_title}" />
	         				    </f:facet>
	         				     <h:outputText id="modtitle" value="#{mdbean.module.title}" />	         				 
	           				 </h:column>     
         			</h:dataTable>
         			<h:outputText id="no_modules_text" value="#{msgs.move_section_no_Modules}" rendered="#{moveSectionsPage.nomodsFlag}" />
         		    </td></tr>
         		    <tr>
			          <td height="20" align="center" >
			          <div align="center">
			          		 <h:commandLink id="moveSectionChanges" action="#{moveSectionsPage.move}"  rendered="#{moveSectionsPage.nomodsFlag == false}">
	             					    <h:graphicImage id="save" value="#{msgs.im_save_over}" styleClass="CmdImgClass"/>
	              		              </h:commandLink>	
							
							
							<h:commandLink id="cancelButton" immediate="true" action="#{moveSectionsPage.cancel}"  >
								<h:graphicImage id="cancelImg" value="#{msgs.im_cancel}" styleClass="BottomImgSpace"
									onmouseover="this.src = '#{msgs.im_cancel_over}'" 
									onmouseout="this.src = '#{msgs.im_cancel}'" 
									onmousedown="this.src = '#{msgs.im_cancel_down}'" 
									onmouseup="this.src = '#{msgs.im_cancel_over}'"/>
			                </h:commandLink>
			                </div>
     				   </td></tr>
         		    </table>
         		</td></tr>
         	</table>
      </td></tr></table>
      </h:form>
     </body>
   </f:view>     		    		   