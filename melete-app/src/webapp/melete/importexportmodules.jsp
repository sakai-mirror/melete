<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://javascript4jsf.dev.java.net/" prefix="j4j" %>
<html">
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="description" content="ETUDES-NG Course Management System, Powered by Sakai">
<meta name="keywords" content="ETUDES-NG course management system, e-learning">


<title>Melete - Import/Export Modules</title>
<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
<%@ page import="javax.faces.application.FacesMessage, java.util.ResourceBundle"%>

<% 
	String status = (String)request.getAttribute("upload.status");
		if( status != null && !status.equalsIgnoreCase("ok"))
		{
			final javax.faces.context.FacesContext facesContext = javax.faces.context.FacesContext.getCurrentInstance();
			ResourceBundle bundle = ResourceBundle.getBundle("org.sakaiproject.tool.melete.bundle.Messages", facesContext.getViewRoot().getLocale());
			String infoMsg = bundle.getString("error_importing_large");
			FacesMessage msg = new FacesMessage(null, infoMsg);
			msg.setSeverity(FacesMessage.SEVERITY_ERROR);
			facesContext.addMessage(null, msg);			
		}
%>
<script language="javascript1.2">
function showprocessMsg()
{
 document.getElementById("importexportform:processmsg").style.visibility="visible";
}
</script>
</head>

<f:view>
<body marginwidth="0" marginheight="0" topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" onload="setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');" >
<h:form id="importexportform" enctype="multipart/form-data">
<j4j:param name="upload.max" value="#{exportMeleteModules.uploadmax}" method="get" />
<!-- This Begins the Main Text Area -->

<table>
	<tr>
		<td valign="top"></td>
    	<td width="1962" valign="top">
        	<table width="100%"  border="1" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA"  style="border-collapse: collapse">
          		<tr>
            		<td width="100%" height="20" bordercolor="#E2E4E8">
					<!-- top nav bar -->
						<f:subview id="top">
								<jsp:include page="topnavbar.jsp"/> 
						</f:subview>
						<div class="meletePortletToolBarMessage"><img src="images/import1.gif" alt="" width="16" height="16" align="absmiddle"><h:outputText value="#{msgs.importexportmodules_importing_or_exporting}" /></div>
					</td>
				</tr>
				<tr>
					<td class="maintabledata3" valign="top">
						<!-- main page contents -->
						<h:messages showDetail="true" showSummary="false" infoClass="BlueClass" errorClass="RedClass"/></br>
						<table border="1" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA"  style="border-collapse: collapse" width="100%" id="AutoNumber1">
		  					<tr>
		  						<th class="leftheader maintabledata5 style4" colspan="2" height="20"><h:outputText value="#{msgs.importexportmodules_export_modules}" /></th>
		  					</tr>
                  			<tr>
                   				<td colspan="2" class="maintabledata3"><h:outputText value="#{msgs.importexportmodules_message1}" /></td>
                  			</tr>
                  			<!--
                  			<tr>
                    			<td colspan="2" class="maintabledata3">File Exported
									<select name="select" class="formtext">
                      				<option selected>Select one or all Modules</option>
                     	 			<option>All Modules</option>
                      				</select>
                      			</td>
                  			</tr>
                  			-->
                  			<tr>
                    			<td colspan="2" class="maintabledata3">&nbsp;</td>
                    		</tr>
                    		
                    		<tr>
                    			<td colspan="2" class="maintabledata7">
									<div align="center">
										<h:commandLink id="exportModule"  action="#{exportMeleteModules.exportModules}" >
											<h:graphicImage id="exportModuleImg" value="#{msgs.im_export}" styleClass="BottomImgSpace" 
											onmouseover="this.src = '#{msgs.im_export_over}'" 
											onmouseout="this.src = '#{msgs.im_export}'" 
											onmousedown="this.src = '#{msgs.im_export_down}'" 
						   				  	onmouseup="this.src = '#{msgs.im_export_over}'"/>
                						</h:commandLink>
										<h:commandLink id="cancel"  action="#{manageModulesPage.cancel}" immediate="true">
											<h:graphicImage id="cancelImg" value="#{msgs.im_cancel}" styleClass="BottomImgSpace" 
											onmouseover="this.src = '#{msgs.im_cancel_over}'" 
											onmouseout="this.src = '#{msgs.im_cancel}'" 
											onmousedown="this.src = '#{msgs.im_cancel_down}'" 
						   				  	onmouseup="this.src = '#{msgs.im_cancel_over}'"/>
                						</h:commandLink>
									</div>
								</td>
				    		</tr>
				    		
				    		
				    		
				    		
				    		
				    		<tr>
		  						<th class="leftheader maintabledata5 style4" colspan="2" height="20"><h:outputText value="#{msgs.importexportmodules_exportscorm_modules}" /></th>
		  					</tr>
                  			<tr>
                   				<td colspan="2" class="maintabledata3"><h:outputText value="#{msgs.importexportmodulesscorm_message}" /></td>
                   				
                  			</tr>                  			
                  			<tr>
                    			<td colspan="2" class="maintabledata3">&nbsp;</td>
                    		</tr>
                    		
                    		<tr>
                    			<td colspan="2" class="maintabledata7">
									<div align="center">
										<h:commandLink id="exportModuleScorm"  action="#{exportMeleteModules.exportScormModules}" >
											<h:graphicImage id="exportModuleScormImg" value="#{msgs.im_export}" styleClass="BottomImgSpace" 
											onmouseover="this.src = '#{msgs.im_export_over}'" 
											onmouseout="this.src = '#{msgs.im_export}'" 
											onmousedown="this.src = '#{msgs.im_export_down}'" 
						   				  	onmouseup="this.src = '#{msgs.im_export_over}'"/>
                						</h:commandLink>
										<h:commandLink id="cancelScorm"  action="#{manageModulesPage.cancel}" immediate="true">
											<h:graphicImage id="cancelScormImg" value="#{msgs.im_cancel}" styleClass="BottomImgSpace" 
											onmouseover="this.src = '#{msgs.im_cancel_over}'" 
											onmouseout="this.src = '#{msgs.im_cancel}'" 
											onmousedown="this.src = '#{msgs.im_cancel_down}'" 
						   				  	onmouseup="this.src = '#{msgs.im_cancel_over}'"/>
                						</h:commandLink>
									</div>
								</td>
				    		</tr>
				    		
				    		
				    		
				    		
				    		
				    		
                  			
			  				<tr>
			  					<th class="leftheader maintabledata5 style4" colspan="2" height="20"><h:outputText value="#{msgs.importexportmodules_import_ims}" /></th>
			  				</tr>
                  			<tr>
                    			<td colspan="2" class="maintabledata3"><h:outputText value="#{msgs.importexportmodules_message2}" /></td>
                  			</tr>
                  			<tr>
                    			<td colspan="2" class="maintabledata3">
                    				<h:outputText value="#{msgs.importexportmodules_upload_ims}" />
                    				<input type="file" name="impfile" class="formtext">
                    			</td>
                  			</tr>
                  			<tr>
                  				<td colspan="2" class="maintabledata3">&nbsp;</td>
                  			</tr>
                  			<tr>
                    			<td colspan="2">
	                    			<div align="center">
										<h:commandLink id="importModule"  action="#{exportMeleteModules.importModules}" >
											<h:graphicImage id="importModuleImg" value="#{msgs.im_import}" styleClass="BottomImgSpace" onclick="showprocessMsg()"
											onmouseover="this.src = '#{msgs.im_import_over}'" 
											onmouseout="this.src = '#{msgs.im_import}'" 
											onmousedown="this.src = '#{msgs.im_import_down}'" 
						   				  	onmouseup="this.src = '#{msgs.im_import_over}'"/>
                						</h:commandLink>
										<h:commandLink id="importcancel"  action="#{manageModulesPage.cancel}" immediate="true">
											<h:graphicImage id="importcancelImg" value="#{msgs.im_cancel}" styleClass="BottomImgSpace" 
											onmouseover="this.src = '#{msgs.im_cancel_over}'" 
											onmouseout="this.src = '#{msgs.im_cancel}'" 
											onmousedown="this.src = '#{msgs.im_cancel_down}'" 
						   				  	onmouseup="this.src = '#{msgs.im_cancel_over}'"/>
                						</h:commandLink>           
                					<h:outputLabel id="processmsg" value="Processing..." styleClass="orange" style="visibility:hidden" /> 	     						                					
									</div>	
								</td>
              				</tr>
			  				<tr>
			  					<td class="maintabledata5" colspan="2">&nbsp;</td>
			  				</tr>
			  
			  
           				</table>
   
            
		  			</td>
		  		</tr>
		  	</table> 
		  	<p>&nbsp;</p>
		</td>
  	</tr>
</table>
</h:form>
<!-- This Ends the Main Text Area -->

</body>
</f:view>
</html>	  
