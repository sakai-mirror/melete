<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>
<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="description" content="ETUDES-NG Course Management System, Powered by Sakai">
<meta name="keywords" content="ETUDES-NG course management system, e-learning">

<title>Melete - Select Resource Item</title>

<link rel="stylesheet" type="text/css" href="rtbc004.css">
<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
</head>
<f:view>

<body marginwidth="0" marginheight="0" topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" onload="setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');">

<h:form id="ServerViewForm" enctype="multipart/form-data">	

<!-- This Begins the Main Text Area -->
	  <table width="100%"  border="1" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA"  style="border-collapse: collapse">
		<tr>
				<td width="1962">
        		<table width="100%"  border="1" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA"  style="border-collapse: collapse">
          			<tr>
            			<td width="100%" height="20" bordercolor="#E2E4E8">
								<div class="meletePortletToolBarMessage"><img src="images/replace2.gif" alt="" width="16" height="16" align="absmiddle"><h:outputText value="#{msgs.editcontentlinkserverview_selecting}"/></div>
						</td>
					</tr>
				 <tr><td>    	<h:messages showDetail="true" showSummary="false" infoClass="BlueClass" errorClass="RedClass"/></td>		  </tr>
					<tr><td>
  					 <h:outputText id="Stext_2" value="#{msgs.editcontentlinkserverview_msg1}"/> 
<!--replace with new link part Begin -->
					<table width="100%" border="0" cellpadding="4" cellspacing="0" bordercolor="#F5F5F5" style="border-collapse: collapse" >
					<tr><td colspan="2"> &nbsp; </td></tr>						
					<tr><td height="20" colspan="2" class="maintabledata8"> <h:outputText id="Stext_add" value="#{msgs.editcontentlinkserverview_replace}" styleClass="bold"/> 									 
					 <tr><td height="20" colspan="2"> 
														<h:outputText id="editlinkText6" value="#{msgs.editcontentlinkserverview_provide}" />
														<h:outputText id="editlinkText7" value=" " styleClass="ExtraPaddingClass"/>
														 <h:inputText id="link" value="#{editSectionPage.linkUrl}" size="40" /> 	
					</td></tr>	
					 <tr><td colspan="2"> &nbsp; </td></tr>	
					</table> </td></tr>       
					     <tr>
					          	<td  colspan="2">
					          	<div align="center">
											<h:commandLink id="addButton_1"  action="#{editSectionPage.setServerUrl}" >
												<h:graphicImage id="addImg2_1" value="#{msgs.im_continue}" styleClass="BottomImgSpace"
												onmouseover="this.src = '#{msgs.im_continue_over}'" 
												onmouseout="this.src = '#{msgs.im_continue}'" 
												onmousedown="this.src = '#{msgs.im_continue_down}'" 
												onmouseup="this.src = '#{msgs.im_continue_over}'"/>
										</h:commandLink> 
				
									<h:commandLink id="cancelButton_1"  action="#{editSectionPage.cancelServerFile}"  immediate="true">
										<h:graphicImage id="cancelImg_1" value="#{msgs.im_cancel}" styleClass="BottomImgSpace" 
											onmouseover="this.src = '#{msgs.im_cancel_over}'" 
											onmouseout="this.src = '#{msgs.im_cancel}'" 
											onmousedown="this.src = '#{msgs.im_cancel_down}'" 
											onmouseup="this.src = '#{msgs.im_cancel_over}'"/>
									</h:commandLink>				
				 </div>					              	
					              	</td>
					            </tr>
	<!-- new link end -->				            		
									
					<tr>
						<td>
							<!-- start main -->
						            <tr>
						              <td width="100%" valign="top" align="center">
										<table width="100%" border="0" cellpadding="4" cellspacing="0" bordercolor="#F5F5F5" style="border-collapse: collapse" >											
							               	<tr valign="top">
							                   	<td colspan="2">	
							                   		<h:outputText value="You have selected "  rendered="#{editSectionPage.renderSelectedResource}" styleClass="blue" />
    												<h:outputText value="#{editSectionPage.selectedResourceName}" rendered="#{editSectionPage.renderSelectedResource}" styleClass="bold"/>
												<h:outputText value=". Click on Continue to complete the process."  rendered="#{editSectionPage.renderSelectedResource}" styleClass="blue"/>
											</td>  </tr>
									<tr><td height="20" colspan="2" class="maintabledata8"> <h:outputText id="Stext3" value="Select an Item" styleClass="bold"/> </td></tr>										   	<tr valign="top">
							                    	<td colspan="2">		                    	
														<h:panelGrid id="uploadSView1" columns="1" width="100%">	
														<h:column>
																			<f:subview id="ResourceListingForm" >	
																					<jsp:include page="edit_list_section_resources.jsp"/> 
																</f:subview>		
														</h:column>													
														</h:panelGrid>
							                    	</td>							                    	
							                  	</tr>						
		             	         	</td>
			                  	</tr>
			              		</table>
						  </td>
			            </tr>
			            <tr>
					          	<td  colspan="2">
					          	<div align="center">
											<h:commandLink id="addButton"  action="#{editSectionPage.setServerUrl}" >
						<h:graphicImage id="addImg2" value="#{msgs.im_continue}" styleClass="BottomImgSpace"
						onmouseover="this.src = '#{msgs.im_continue_over}'" 
						onmouseout="this.src = '#{msgs.im_continue}'" 
						onmousedown="this.src = '#{msgs.im_continue_down}'" 
						onmouseup="this.src = '#{msgs.im_continue_over}'"
				/>
				</h:commandLink> 
				
				<h:commandLink id="cancelButton"  action="#{editSectionPage.cancelServerFile}"  immediate="true">
					<h:graphicImage id="cancelImg" value="#{msgs.im_cancel}" styleClass="BottomImgSpace" 
						onmouseover="this.src = '#{msgs.im_cancel_over}'" 
						onmouseout="this.src = '#{msgs.im_cancel}'" 
						onmousedown="this.src = '#{msgs.im_cancel_down}'" 
						onmouseup="this.src = '#{msgs.im_cancel_over}'"/>
                </h:commandLink>				
				 </div>					              	
					              	</td>
					            </tr>
					     	</table>					
							<!--end  main -->	
			</td>
  		</tr>
	</table>
	<!-- This Ends the Main Text Area -->
	     	</h:form>
</body>
</f:view>
</html> 




