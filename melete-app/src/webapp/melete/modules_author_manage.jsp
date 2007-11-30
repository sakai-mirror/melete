<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>
<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="description" content="ETUDES-NG Course Management System, Powered by Sakai">
<meta name="keywords" content="ETUDES-NG course management system, e-learning">

<title>Melete - Manage Modules</title>


<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>

</head>
<f:view>
<body marginwidth="0" marginheight="0" topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" onload="setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');">
<h:form id="ManageModuleForm">

<!-- This Begins the Main Text Area -->
	
	<table>
		<tr>
				<td width="1962">
        		<table width="100%"  border="1" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA"  style="border-collapse: collapse">
          			<tr>
            			<td width="100%" height="20" bordercolor="#E2E4E8">
							<!-- top nav bar --> 
							<f:subview id="top">
								<jsp:include page="topnavbar.jsp"/> 
							</f:subview>
							<div class="meletePortletToolBarMessage"><img src="images/folder_document.gif" alt="" width="16" height="16" align="absmiddle"><h:outputText value="#{msgs.modules_author_manage_managing_options}" /></div>
						</td>
					</tr>
					<tr>
						<td>
							<!-- start main -->
					<h:messages showDetail="true" showSummary="false" infoClass="BlueClass" errorClass="RedClass"/>
							<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#EAEAEA" width="100%" id="AutoNumber1">
							  	<tr><td colspan="2" class="maintabledata5">&nbsp;
							  		</td></tr>
					            <tr>
						              <td width="100%" valign="top">
											<table width="100%" border="1" cellpadding="4" cellspacing="0" bordercolor="#F5F5F5" style="border-collapse: collapse" >
							                  	<tr rowspan="5" valign="top">
							                    	<td align="center" class="menu left">
								                    	<h:commandLink id="goto" action="#{manageModulesPage.goToRestoreModules}">
															<h:graphicImage id="image"
									   							alt="#{msgs.modules_author_manage_restore_inactive}"
									   							url="images/folder_out.gif"
									   							 styleClass="AuthImgClass"/>
									   							<h:outputText id="re" value="#{msgs.modules_author_manage_restore}" />
														</h:commandLink>
							                    	</td>
							                    	<td  align="left"><h:outputText value="#{msgs.modules_author_manage_restore_inactive_to_active_list}" /></td>
							                  	</tr>
							                   	<tr>
													<td align="center" class="menu left">
														<h:commandLink id="sortgoto" action="#{manageModulesPage.goToSortModules}">
															<h:graphicImage id="image1"
									   							alt="#{msgs.modules_author_manage_sort_alt}"
									   							url="images/document_exchange.gif"
									   							 styleClass="AuthImgClass"/>
									   							 <h:outputText id="sort" value="#{msgs.modules_author_manage_sort}" />
														</h:commandLink>
													</td>
													<td align="left"> <h:outputText id="sort1" value="#{msgs.modules_author_manage_sort_text}" /></td>
											  </tr>
					                           	<tr rowspan="5" valign="top">
							                    	<td align="center" class="menu left">
								                    	<h:commandLink id="goto_impexp" action="#{manageModulesPage.importExportModules}">
															<h:graphicImage id="image_impexp"
									   							alt="#{msgs.modules_author_manage_import_export}"
									   							url="images/import1.gif"
									   							styleClass="AuthImgClass"/>
									   							<h:outputText id="import" value="#{msgs.modules_author_manage_import_export}" />
														</h:commandLink>
							                    	</td>
							                    	<td  align="left"><h:outputText value="#{msgs.modules_author_manage_import_export_modules}" /></td>
							                  	</tr>							                  	

						              		</table>
									  </td>
					            </tr>
					            <tr>
					              	<td  colspan="2" class="maintabledata5">&nbsp;</td>
					            </tr>
					     	</table>
					
							<!--end  main -->
			  			</td>
			  		</tr>
			  	</table> 
			</td>
  		</tr>
	</table>
	<!-- This Ends the Main Text Area -->
	     	</h:form>
</body>
</f:view>
</html> 
