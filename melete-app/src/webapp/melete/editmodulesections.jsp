<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!--
 ***********************************************************************************
 * $URL$
 * $Id$  
 ***********************************************************************************
 *
 * Copyright (c) 2008,2009 Etudes, Inc.
 *
 * Portions completed before September 1, 2008 Copyright (c) 2004, 2005, 2006, 2007, 2008 Foothill College, ETUDES Project
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * permissions and limitations under the License.
 *
 **********************************************************************************
-->
<html>
<head>
<title>Melete - Edit Module Section</title>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="description" content="ETUDES-NG Course Management System, Powered by Sakai">
<meta name="keywords" content="ETUDES-NG course management system, e-learning">
<META HTTP-EQUIV="CACHE-CONTROL" CONTENT="NO-CACHE">
<META HTTP-EQUIV="Pragma" CONTENT="NO-CACHE">

<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>

<link rel="stylesheet" type="text/css" href="rtbc004.css">
<%@ page import="org.sakaiproject.util.ResourceLoader"%>

<% 
	ResourceLoader bundle = new ResourceLoader("org.etudes.tool.melete.bundle.Messages");
	String mensaje=bundle .getString("editmodulesections_uploading");
	
%>

<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
<script type="text/javascript" language="javascript1.2">
function fillupload()
{
		var k =document.getElementById("file1").value;
		document.getElementById("EditSectionForm:filename").value=k;
}

function showupload()
{
	defaultStatus = "Done";
	var str=document.getElementById("EditSectionForm:contentType").value;
	var sferyxdisplay = document.getElementById("EditSectionForm:contentEditorView:sferyxDisplay");  
	
	if(str.match("notype"))
		{		
			if(document.htmleditor != undefined && document.htmleditor != null)
			{
			document.htmleditor.style.visibility="hidden";
			document.htmleditor.style.display="none";
			}
			if (document.getElementById("EditSectionForm:contentEditorView") != undefined && 
			document.getElementById("EditSectionForm:contentEditorView") != null)
			  {
			     document.getElementById("EditSectionForm:contentEditorView").style.visibility="hidden";
			     document.getElementById("EditSectionForm:contentEditorView").style.display="none";
			  }
	
			if(document.getElementById("othereditor") != undefined && document.getElementById("othereditor") != null)
			  {
			      document.getElementById("othereditor").style.visibility="hidden";
			      document.getElementById("othereditor").style.display="none";
			  }
	}
	
	if(sferyxdisplay != undefined && str.match("typeEditor"))
	{	
	 var k1=document.getElementById("EditSectionForm:contentEditorView:contentTextArea").value;     
	 if(k1 != undefined && k1 !=null)
		 {
		 document.htmleditor.setContent(k1); //May use initialURLEncodedContent param instead
        	}
	}

	if(!str.match("typeEditor"))
	{		
		if(document.htmleditor != undefined && document.htmleditor != null)
			{
				document.htmleditor.style.visibility="hidden";
				document.htmleditor.style.display="none";
			}
			if (document.getElementById("EditSectionForm:contentEditorView") != undefined && 
			document.getElementById("EditSectionForm:contentEditorView") != null)
            {
                  document.getElementById("EditSectionForm:contentEditorView").style.visibility="hidden";
                  document.getElementById("EditSectionForm:contentEditorView").style.display="none";
            }		
	}
}	

function transferEditordata()
{
	var sferyxdisplay = document.getElementById("EditSectionForm:contentEditorView:sferyxDisplay");
	if ((sferyxdisplay != undefined )&&(document.htmleditor!=undefined && document.htmleditor!= null))
	{
	  	var k = document.htmleditor.getBodyContent();
	  	 if(document.getElementById("EditSectionForm:contentEditorView:contentTextArea") != undefined && 
	  	 document.getElementById("EditSectionForm:contentEditorView:contentTextArea") != null)
			 {
                document.getElementById("EditSectionForm:contentEditorView:contentTextArea").value=k;
		document.htmleditor.uploadMultipartContent(true);
         	}
	}	
}

function showmessage()
{
		if (document.getElementById("file1").value.length  >  0)
		   {
		   window.defaultStatus="<%=mensaje%>";
		   } 
  }

function previewSec()
{
transferEditordata();
window.open('editpreviewEditor.jsf');
}
</script>
</head>
<f:view>
<body marginwidth="0" marginheight="0" topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" onLoad="showupload(),setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');">

      <!-- This Begins the Main Text Area -->
	<h:form id="EditSectionForm" enctype="multipart/form-data">	
			  <h:inputHidden id="formName" value="EditSectionForm"/>  

<table border="0" cellpadding="0" cellspacing="0" class ="table3">
	<tr>
		<td valign="top"> &nbsp;
		
		</td>
	<td width="1962"  valign="top">
        <table width="100%"  border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse" bordercolor="#EAEAEA">
          <tr>
			<td width="100%" height="20" > 
			<!-- top nav bar -->
		<f:subview id="top">
			<jsp:include page="topnavbar.jsp"/> 
		</f:subview>
		<div class="meletePortletToolBarMessage"><img src="images/document_edit.gif" alt="" width="16" height="16" align="absbottom"><h:outputText value="#{msgs.editmodulesections_editing_section}" /> </div>
		 </td></tr>
		  <tr>
            <td height="20" class="maintabledata8">            	   
	     		<h:commandLink id="editPrevButton" onmousedown="transferEditordata();" action="#{editSectionPage.editPrevSection}" rendered="#{editSectionPage.hasPrev}">
 					 <h:outputText id="text4_4" value="#{msgs.editmodulesections_edit_prev}"/>
				</h:commandLink> 
				<h:outputText id="text4_5" value="#{msgs.editmodulesections_edit_prev}" rendered="#{!editSectionPage.hasPrev}"/>
				&laquo;
     			<h:commandLink id="TOCButton"  onmousedown="transferEditordata();" action="#{editSectionPage.goTOC}">
						<h:outputText id="toc" value="#{msgs.editmodulesections_TOC}" />
					</h:commandLink>
				&raquo;   
	     		<h:commandLink id="editNextButton" onmousedown="transferEditordata();" action="#{editSectionPage.editNextSection}" rendered="#{editSectionPage.hasNext}">
 					 <h:outputText id="text4_2" value="#{msgs.editmodulesections_edit_next}"/>
				</h:commandLink>
				<h:outputText id="text4_6" value="#{msgs.editmodulesections_edit_next}" rendered="#{!editSectionPage.hasNext}"/>
				  <h:outputText id="text4_3" value=" / "/>				
	     		<h:commandLink onmousedown="transferEditordata();" action="#{editSectionPage.saveAndAddAnotherSection}">
 					 <h:outputText id="text5" value="#{msgs.editmodulesections_add_new}"/>
				</h:commandLink> 
			</td>
          </tr>	
          <tr>
          	<td class="maintabledata8">
          		<h:outputText id="text4" value="#{editSectionPage.module.title}" /> &raquo; <h:outputText id="text4_1" value="#{editSectionPage.section.title}" /> 
          	</td>
          </tr>	 
     	  <tr>
            <td  class="maintabledata7">
			 <h:messages id="editsectionerror"  layout="table" showDetail="true" showSummary="false" infoClass="BlueClass" errorClass="RedClass"/>
			</td>
          </tr>
		  <tr>
            <td class="maintabledata3">
			<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#EAEAEA" width="100%" id="AutoNumber1" >
              <tr >
                <td width="100%" height="35" valign="top">
				<table style="BORDER-COLLAPSE: collapse" bordercolor=#111111 cellspacing=0 cellpadding=0 width=100% border="0">
                  <tbody>
                    <tr>
                      <td align=left valign=top>
					  <table style="BORDER-COLLAPSE: collapse" bordercolor=#111111 cellspacing=0 cellpadding=0 width="99%" border="0">
                          <tbody>
                            <tr>
                              <td align="left" valign="top">
							  <table  bordercolor="#111111" cellspacing="0" cellpadding="4" width="100%" border="0">
                                   <tr>
                                    <td align="left" valign="top"><h:outputText id="text7" value="#{msgs.editmodulesections_section_title}" /><span class="required">*</span></td>
                                    <td width="600" align="left" valign="top">
									<h:inputText id="title" value="#{editSectionPage.section.title}" size="45"  required="true" styleClass="formtext"/>
									</td>
                                  </tr>
                                  <tr>
                                    <td align="left" valign="top"><h:outputText id="text8" value="#{msgs.editmodulesections_author}"/></td>
                                    <td align="left" valign="top"><h:outputText value="#{editSectionPage.section.createdByFname}" styleClass="formtext"/>&nbsp;<h:outputText value="#{editSectionPage.section.createdByLname}" styleClass="formtext"/></td>
                                  </tr>
								  <tr>
                                    <td align="left" valign="top"><h:outputText id="text9" value="#{msgs.editmodulesections_instructions}" /></td>
                                    <td align="left" valign="top">
										  <h:inputTextarea id="instr" cols="45" rows="5" value="#{editSectionPage.section.instr}" styleClass="formtext">
											<f:validateLength maximum="250" minimum="1"/>
									</h:inputTextarea>
									</td>
                                  </tr>
                                  <tr>
                                    <td align="left" valign="top"> <h:outputText id="text10" value="#{msgs.editmodulesections_modality}" /><span class="required">*</span></td>
                                    <td align="left" valign="top"><h:outputText id="text11" value="#{msgs.editmodulesections_message1} "/>
									</td>
									  </tr>	
								  <tr>
								  <td>&nbsp;</td>
                                    <td valign="top">
                        			<h:selectBooleanCheckbox id="contentext" title="textualContent" value="#{editSectionPage.section.textualContent}" >
									</h:selectBooleanCheckbox>
									<h:outputText  id="text12" value="#{msgs.editmodulesections_textual_content}"/>
									</td>
									  </tr>	
								  <tr>
								    <td>&nbsp;</td>
                                    <td valign="top">									
									<h:selectBooleanCheckbox id="contentvideo" title="videoContent" value="#{editSectionPage.section.videoContent}" >
									</h:selectBooleanCheckbox>
									<h:outputText  id="text13" value="#{msgs.editmodulesections_visual_content}"/>
									</td>
									  </tr>	
								  <tr>
								    <td>&nbsp;</td>
                                    <td  valign="top">
									<h:selectBooleanCheckbox id="contentaudio" title="audioContent" value="#{editSectionPage.section.audioContent}" >
									</h:selectBooleanCheckbox>
									<h:outputText id="text14" value="#{msgs.editmodulesections_auditory_content}"/>			
										</td>
									  </tr>	
									  <tr>
								  	  <td  align="left" valign="middle"><h:outputText id="text15" value="#{msgs.editmodulesections_content_type}" rendered="#{editSectionPage.shouldRenderContentTypeSelect}" /></td>
                                 	  <td> 
										<h:inputHidden id="contentType"  value="#{editSectionPage.section.contentType}"  />	  								  	
										  <h:selectOneMenu id="contentType1" value="#{editSectionPage.section.contentType}" valueChangeListener="#{editSectionPage.showHideContent}" onchange="this.form.submit();"  tabindex="6" rendered="#{editSectionPage.shouldRenderContentTypeSelect}">
											<f:selectItems value="#{editSectionPage.allContentTypes}" />											
										 </h:selectOneMenu>
											 </td>
											 </tr>
									<tr><td colspan="2" >
										 <f:subview id="ContentLinkView" rendered="#{editSectionPage.shouldRenderLink}">
											<jsp:include page="editContentLinkView.jsp"/> 
										</f:subview>
										 <f:subview id="ContentLTIView" rendered="#{editSectionPage.shouldRenderLTI}">
											<jsp:include page="editContentLTIView.jsp"/> 
										</f:subview>
										<f:subview id="ContentUploadView" rendered="#{editSectionPage.shouldRenderUpload}">
											<jsp:include page="editContentUploadView.jsp"/> 
										</f:subview>	
									</td></tr>	
									<tr> 
										 <td colspan="2" align="center"> 										
											 <f:subview id="contentEditorView" rendered="#{editSectionPage.shouldRenderEditor && authorPreferences.shouldRenderSferyx}">
												<jsp:include page="contentSferyxEditor.jsp"/> 
												 <h:inputHidden id="contentTextArea" value="#{editSectionPage.contentEditor}" />
												 <h:inputHidden id="sferyxDisplay" value="#{authorPreferences.shouldRenderSferyx}" />
											</f:subview>
											<sakai:inputRichText id="otherMeletecontentEditor" value="#{editSectionPage.contentEditor}"  rows="50" cols="90" width="700" rendered="#{editSectionPage.shouldRenderEditor && authorPreferences.shouldRenderFCK}" collectionBase="#{editSectionPage.FCK_CollId}" />											
											</td>
									  </tr>	
								  <tr>
								   <td colspan="2">
												<f:subview id="ResourcePropertiesPanel" rendered="#{editSectionPage.meleteResource !=null && !editSectionPage.shouldRenderNotype}">
													<jsp:include page="edit_sec_resourcePropertiesPanel.jsp"/>
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
                </table>
                </td>
              </tr>
              <tr>
                <td>
                  <div class="actionBar" align="left">
              		<h:commandButton id="submitsave" action="#{editSectionPage.save}" rendered="#{editSectionPage.shouldRenderEditor}" onclick="transferEditordata()" value="#{msgs.im_save}" accesskey="#{msgs.save_access}" title="#{msgs.im_save_text}" styleClass="BottomImgSave"/>
					<h:commandButton id="submitsave1" action="#{editSectionPage.save}" rendered="#{editSectionPage.shouldRenderUpload}" onclick="showmessage()" value="#{msgs.im_save}" accesskey="#{msgs.save_access}" title="#{msgs.im_save_text}" styleClass="BottomImgSave"/>
					<h:commandButton id="submitsave2" action="#{editSectionPage.save}" rendered="#{!editSectionPage.shouldRenderEditor && !editSectionPage.shouldRenderUpload}" value="#{msgs.im_save}" accesskey="#{msgs.save_access}" title="#{msgs.im_save_text}" styleClass="BottomImgSave"/>
					<h:commandButton id="previewEditor" action="#{editSectionPage.getPreviewPage}" onclick="transferEditordata()"  rendered="#{editSectionPage.shouldRenderEditor}" value="#{msgs.im_preview}" accesskey="#{msgs.view_access}" title="#{msgs.im_preview_text}" styleClass="BottomImgPreview"/>
					<h:commandButton id="preview" action="#{editSectionPage.getPreviewPage}" rendered="#{editSectionPage.shouldRenderEditor == false}" value="#{msgs.im_preview}" accesskey="#{msgs.view_access}" title="#{msgs.im_preview_text}" styleClass="BottomImgPreview"/>
					<h:commandButton id="cancelButton" immediate="true" action="#{editSectionPage.cancel}" value="#{msgs.im_cancel}" accesskey="#{msgs.cancel_access}" title="#{msgs.im_cancel_text}" styleClass="BottomImgCancel"/>
       			 </div></td>
              </tr>
              <tr>
                <td height="20">&nbsp;</td>
              </tr>
              <tr>
                <td>
                    <div class="actionBar" align="left">
                		<h:commandButton id="saveAddAnotherbutton"  action="#{editSectionPage.saveAndAddAnotherSection}" value="#{msgs.im_add_another_section}"  accesskey="#{msgs.add_access}" title="#{msgs.im_add_another_section_text}" onclick="transferEditordata()" styleClass="BottomImgAdd"/>
						<h:commandButton id="FinishButton" action="#{editSectionPage.Finish}" value="#{msgs.im_finish}" accesskey="#{msgs.finish_access}" title="#{msgs.im_finish_text}" onclick="transferEditordata()" styleClass="BottomImgFinish"/>		
					</div></td>
		          </tr>
            </table>
			
			</td>
          </tr>
        </table>
       </h:form>  
	   <p class="bold"><span class="required">*</span>&nbsp; <h:outputText value="#{msgs.editmodulesections_required}" /></p>

	 </td>
  </tr>  
</table>

  <!-- This Ends -->
</body>
</f:view>
</html>
