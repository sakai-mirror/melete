<!--  Copyright (c) 2008 Etudes, Inc. -->
 
<!--  Licensed under the Apache License, Version 2.0 (the "License"); -->
<!--   you may not use this file except in compliance with the License.-->
<!--   You may obtain a copy of the License at -->
  
<!--   http://www.apache.org/licenses/LICENSE-2.0 -->
  
<!--   Portions completed before September 1, 2008 Copyright (c) 2004, 2005, 2006, 2007, 2008 Foothill College, ETUDES Project -->
  
<!--   Licensed under the Apache License, Version 2.0 (the "License"); you -->
<!--   may not use this file except in compliance with the License. You may -->
<!--   obtain a copy of the License at -->
  
<!--   http://www.apache.org/licenses/LICENSE-2.0 -->
<!--  Unless required by applicable law or agreed to in writing, software -->
<!--  distributed under the License is distributed on an "AS IS" BASIS, -->
<!--  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or -->
<!--  implied. See the License for the specific language governing -->
<!--  permissions and limitations under the License. -->
<html>
<head>
<title>Melete: Add Module Sections</title>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="description" content="ETUDES-NG Course Management System, Powered by Sakai">
<meta name="keywords" content="ETUDES-NG course management system, e-learning">
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<META HTTP-EQUIV="Pragma" CONTENT="NO-CACHE">

<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>

<%@ page import="javax.faces.application.FacesMessage, org.sakaiproject.util.ResourceLoader"%>

<% 
	ResourceLoader bundle = new ResourceLoader("org.sakaiproject.tool.melete.bundle.Messages");
	String mensaje=bundle .getString("addmodulesections_uploading");
	String mensaje2=bundle .getString("addmodulesections_done");

%>
<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
<style type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
</style>
</head>
<script language="javascript1.2">

function showupload()
{
	var str=document.getElementById("AddSectionForm:contentType").value;
	var sferyxdisplay = document.getElementById("AddSectionForm:contentEditorView:sferyxDisplay");
	if(str.match("notype"))
	{		
		if(document.htmleditor != undefined && document.htmleditor != null )
		{
		document.htmleditor.style.visibility="hidden";
		document.htmleditor.style.display="none";
		}
		if (document.getElementById("AddSectionForm:contentEditorView:EditorPanel") != undefined &&
		    document.getElementById("AddSectionForm:contentEditorView:EditorPanel") != null)
		  {
		     document.getElementById("AddSectionForm:contentEditorView:EditorPanel").style.visibility="hidden";
		     document.getElementById("AddSectionForm:contentEditorView:EditorPanel").style.display="none";
		  }

		if(document.getElementById("othereditor") != undefined && document.getElementById("othereditor") != null)
		  {
		      document.getElementById("othereditor").style.visibility="hidden";
		      document.getElementById("othereditor").style.display="none";
		  }
	}
	
		
	if(!str.match("typeEditor"))
	{	
	// avoid js error if sferyx is not available	
		if(document.htmleditor != undefined && document.htmleditor != null)
		{
			document.htmleditor.style.visibility="hidden";
			document.htmleditor.style.display="none";
		}
		if (document.getElementById("AddSectionForm:contentEditorView") != undefined && 
		document.getElementById("AddSectionForm:contentEditorView") != null)
            {
                  document.getElementById("AddSectionForm:contentEditorView").style.visibility="hidden";
                  document.getElementById("AddSectionForm:contentEditorView").style.display="none";
            }
	}	
	
	if(sferyxdisplay != undefined && str.match("typeEditor"))	
		{	
		 var k1=document.getElementById("AddSectionForm:contentEditorView:contentTextArea").value;     
			if(k1 != undefined && k1 != null) document.htmleditor.setContent(k1); //May use initialURLEncodedContent param instead
		  }

    //This check is to hide fckeditor		  
    if(!str.match("typeEditor"))
	{
		document.getElementById("othereditor").style.visibility="hidden";
		document.getElementById("othereditor").style.display="none";
	}		  
 }	

function transferEditordata()
{
    var str=document.getElementById("AddSectionForm:contentType").value;
    if (str == "typeEditor")
    {
	if(document.htmleditor!= undefined && document.htmleditor!= null)
	{
	  window.defaultStatus="Adding content....";
	  	var k =document.htmleditor.getBodyContent();
	  		 if(document.getElementById("AddSectionForm:contentEditorView:contentTextArea") !=undefined &&
	  		   document.getElementById("AddSectionForm:contentEditorView:contentTextArea") != null)
			 {
				document.getElementById("AddSectionForm:contentEditorView:contentTextArea").value=k;
			}
		document.htmleditor.uploadMultipartContent(true);     
	}
	}
			
}
  
  function clearmessage()
 {
		   window.defaultStatus="<%=mensaje2%>";
  }


function contentChangeSubmit()
{
	   document.getElementById("AddSectionForm:contentChange").value = "true";
}
</script>
<f:view>
<body marginwidth="0" marginheight="0" topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" onload="showupload(),setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');" >
      <!-- This Begins the Main Text Area -->
	<h:form id="AddSectionForm" enctype="multipart/form-data">		
<table width="100%"  border="0" cellpadding="0" cellspacing="0" class ="table3">
	<tr>
		<td valign="top"> &nbsp;
		</td>

    <td width="100%"  valign="top">
        <table width="100%"  border="1" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA"  style="border-collapse: collapse">
          <tr>
            <td width="100%"  >
					<!-- top nav bar -->
		<f:subview id="top">
							<jsp:include page="topnavbar.jsp"/> 
						</f:subview>
						<div class="meletePortletToolBarMessage"><img src="images/document_add.gif" alt="" width="16" height="16" align="absmiddle"><h:outputText value="#{msgs.addmodulesections_adding_section}" /> </div>
		</td></tr>
	
		  <tr><td>
			 <h:messages id="addsectionerror" layout="table" showDetail="true" showSummary="false" infoClass="BlueClass" errorClass="RedClass"/>
  		  </td></tr>
          <tr>
            <td height="20" class="maintabledata8">
					<h:commandLink id="TOCButton"  action="#{addSectionPage.cancel}"  immediate="true">
						<h:outputText id="toc" value="#{msgs.addmodulesections_TOC}" />
					</h:commandLink> &raquo; <h:outputText id="text11" value="#{addSectionPage.module.title}" />  &raquo; <h:outputText id="add_new_section" value="#{msgs.addmodulesections_add_new_section}" />
			</td>
          </tr>
          <tr>
            <td class="maintabledata3">
			<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#EAEAEA" width="100%" id="AutoNumber1" height="98">
              <tr bgcolor="#FFFFFF">
                <td width="100%" height="35" valign="top"><table style="BORDER-COLLAPSE: collapse" bordercolor=#111111 cellspacing=0 
      cellpadding=0 width=100% border=0>
                  <tbody>
                    <tr>
                      <td align="left" valign="top"><table style="BORDER-COLLAPSE: collapse" bordercolor=#111111 cellspacing=0 
      cellpadding=0 width="100%" border="0">
                          <tbody>
                            <tr>
                              <td align="left" valign="top style="white-space:nowrap">
                              <table style="white-space:nowrap" bordercolor="#111111" cellspacing="0" cellpadding="4" width="100%" border="0">
                                  <tr>
                                    <td align="left" valign="top"><h:outputText id="text7" value="#{msgs.addmodulesections_section_title}" /><span class="required">*</span></td>
                                    <td width="600" align="left" valign="top">
										<h:inputText id="title" value="#{addSectionPage.section.title}" size="45" required="true" styleClass="formtext" title="Title" tabindex="1"/>
										
									</td>
                                  </tr>
                                  <tr>
                                    <td align="left" valign="top"><h:outputText id="text6" value="#{msgs.addmodulesections_author}" /></td>
                                    <td align="left" valign="top"><h:outputText id="author" value="#{addSectionPage.author}" styleClass="formtext"/></td>
                                   </tr>
                                   <tr>
                                    <td align="left" valign="top"><h:outputText id="text5" value="#{msgs.addmodulesections_instructions}" /></td>
                                    <td align="left" valign="top">
									  <h:inputTextarea id="instr" cols="45" rows="5" value="#{addSectionPage.section.instr}" styleClass="formtext" tabindex="2">
											<f:validateLength maximum="250" minimum="1"/>
									</h:inputTextarea>													
									</td>
                                  </tr>
                                <tr>
                                    <td align="left" valign="top"> <h:outputText id="modality" value="#{msgs.addmodulesections_modality}" /><span class="required">*</span></td>
                                    <td align="left" valign="top"><h:outputText id="text4" value="#{msgs.addmodulesections_message1} "/>
									</td>
									  </tr>	
								  <tr>
								  <td>&nbsp;</td>
                                    <td valign="top">
                        			<h:selectBooleanCheckbox id="contentext" title="textualContent" value="#{addSectionPage.section.textualContent}" tabindex="3">
									</h:selectBooleanCheckbox>
									<h:outputText  id="text12" value="#{msgs.addmodulesections_textual_content}" />
									</td>
									  </tr>	
								  <tr>
								    <td>&nbsp;</td>
                                    <td valign="top">									
									<h:selectBooleanCheckbox id="contentvideo" title="videoContent" value="#{addSectionPage.section.videoContent}" tabindex="4">
									</h:selectBooleanCheckbox>
									<h:outputText  id="text13" value="#{msgs.addmodulesections_visual_content}" />
									</td>
									  </tr>	
								  <tr>
								    <td>&nbsp;</td>
                                    <td  valign="top">
									<h:selectBooleanCheckbox  id="contentaudio" title="audioContent" value="#{addSectionPage.section.audioContent}" tabindex="5">
									</h:selectBooleanCheckbox>
									<h:outputText id="text14" value="#{msgs.addmodulesections_auditory_content}"/>			
										</td>
									  </tr>	
									 
								  <tr>
								  	  <td  align="left" valign="middle"><h:outputText id="text15" value="#{msgs.addmodulesections_content_type}" /></td>
                                 	  <td> 
										   <h:inputHidden id="contentChange" value=""/>								  
												  <h:selectOneMenu id="contentType" value="#{addSectionPage.section.contentType}" valueChangeListener="#{addSectionPage.showHideContent}" onchange="contentChangeSubmit();this.form.submit();"  tabindex="6">
													<f:selectItems value="#{addSectionPage.allContentTypes}" />
											 </h:selectOneMenu>
										</td>
										</tr>
										<tr> 
										 <td colspan="2">
											 <f:subview id="ContentLinkView" rendered="#{addSectionPage.shouldRenderLink}">
												<jsp:include page="ContentLinkView.jsp"/> 
											</f:subview>											
				                           				<f:subview id="ContentUploadView" rendered="#{addSectionPage.shouldRenderUpload}">
												<jsp:include page="ContentUploadView.jsp"/> 
											</f:subview>
											<!--add LTI option by Dr.Chuck -->
											 <f:subview id="ContentLTIView" rendered="#{addSectionPage.shouldRenderLTI}">
												<jsp:include page="ContentLTIView.jsp"/> 
											</f:subview>	
									     </td>
									     </tr>
									     <tr>			
										 <td colspan="2" align="center"> 
												
											<f:subview id="contentEditorView" rendered="#{addSectionPage.shouldRenderEditor && authorPreferences.shouldRenderSferyx}">
														<jsp:include page="contentSferyxEditor.jsp"/> 
													<h:inputHidden id="contentTextArea" value="#{addSectionPage.contentEditor}" />
													 <h:inputHidden id="sferyxDisplay" value="#{authorPreferences.shouldRenderSferyx}" />
											</f:subview>																																
											<div id="othereditor" style="visibility:visible"><sakai:inputRichText  id="otherMeletecontentEditor" value="#{addSectionPage.contentEditor}"  rows="50" cols="90" width="700" rendered="#{addSectionPage.shouldRenderEditor && authorPreferences.shouldRenderFCK}" collectionBase="#{addSectionPage.FCK_CollId}" /></div>
										</td></tr>	 
									<tr>
									<td colspan="2">
										<f:subview id="ResourcePropertiesPanel" rendered="#{!addSectionPage.shouldRenderNotype}">
											<jsp:include page="sec_resourcePropertiesPanel.jsp"/>
										</f:subview>
									</td>	
									</tr>									 
									<tr><td colspan="2">&nbsp;</td></tr>
                              </table>
							  </td>
                            </tr>
                          </tbody>
                      </table></td>
                    </tr>
                  </tbody>
                </table></td>
              </tr>
              <tr>
                <td height="20" bgcolor="#FFFFFF"><div align="center">
				
				<h:commandLink id="submitsave"  action="#{addSectionPage.save}"  tabindex="8" rendered="#{addSectionPage.shouldRenderEditor}">
						<h:graphicImage id="addImg" value="#{msgs.im_add_button}" styleClass="BottomImgSpace" onclick="transferEditordata()"
						onmouseover="this.src = '#{msgs.im_add_button_over}'" 
						onmouseout="this.src = '#{msgs.im_add_button}'" 
						onmousedown="this.src = '#{msgs.im_add_button_down}'" 
						onmouseup="this.src = '#{msgs.im_add_button_over}'"
				/>
				</h:commandLink> 
				
	<h:commandLink id="submitsave1"  action="#{addSectionPage.save}"  tabindex="8" rendered="#{addSectionPage.shouldRenderUpload}">
						<h:graphicImage id="addImg1" value="#{msgs.im_add_button}" styleClass="BottomImgSpace" onclick="showmessage()"
						onmouseover="this.src = '#{msgs.im_add_button_over}'" 
						onmouseout="this.src = '#{msgs.im_add_button}'" 
						onmousedown="this.src = '#{msgs.im_add_button_down}'" 
						onmouseup="this.src = '#{msgs.im_add_button_over}'"
				/>
				</h:commandLink> 
								
				<h:commandLink id="submitsave2"  action="#{addSectionPage.save}"  tabindex="8" rendered="#{!addSectionPage.shouldRenderEditor && !addSectionPage.shouldRenderUpload}">
						<h:graphicImage id="addImg2" value="#{msgs.im_add_button}" styleClass="BottomImgSpace"
						onmouseover="this.src = '#{msgs.im_add_button_over}'" 
						onmouseout="this.src = '#{msgs.im_add_button}'" 
						onmousedown="this.src = '#{msgs.im_add_button_down}'" 
						onmouseup="this.src = '#{msgs.im_add_button_over}'"
				/>
				</h:commandLink> 
				
				<h:commandLink id="cancelButton"  action="#{addSectionPage.cancel}"  immediate="true" tabindex="9">
					<h:graphicImage id="cancelImg" value="#{msgs.im_cancel}" styleClass="BottomImgSpace" onclick="clearmessage()"
						onmouseover="this.src = '#{msgs.im_cancel_over}'" 
						onmouseout="this.src = '#{msgs.im_cancel}'" 
						onmousedown="this.src = '#{msgs.im_cancel_down}'" 
						onmouseup="this.src = '#{msgs.im_cancel_over}'"/>
                </h:commandLink>				
				 </div></td>
              </tr>  
            </table>
			</td>
          </tr>
        </table>
		<p class="bold"><span class="required">*</span>&nbsp;<h:outputText value="#{msgs.addmodulesections_required}" /></p>
	 </td>
  </tr>
</table>
</h:form>
</body>
</f:view>
</html>
