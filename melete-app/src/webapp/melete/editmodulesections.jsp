<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%--
 ***********************************************************************************
 * $URL$
 * $Id$  
 ***********************************************************************************
 *
 * Copyright (c) 2008,2009,2010 Etudes, Inc.
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
--%>

<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>

<f:view>
<sakai:view title="Modules: Edit Module Sections" toolCssHref="rtbc004.css">
<%@include file="accesscheck.jsp" %>
<script type="text/javascript" language="javascript" src="js/sharedscripts.js"></script>

<%@ page import="org.sakaiproject.util.ResourceLoader, javax.faces.application.FacesMessage,org.etudes.tool.melete.AddResourcesPage, org.etudes.tool.melete.EditSectionPage"%>

<% 
	ResourceLoader bundle = new ResourceLoader("org.etudes.tool.melete.bundle.Messages");
	String mensaje=bundle.getString("editmodulesections_uploading");

	final javax.faces.context.FacesContext facesContext = javax.faces.context.FacesContext.getCurrentInstance();
	final EditSectionPage eSectionPage = (EditSectionPage)facesContext.getApplication().getVariableResolver().resolveVariable(facesContext, "editSectionPage");
	if(eSectionPage.getSection() != null && eSectionPage.getSection().getSectionId() != null)
	{
		request.setAttribute("attr_sId",eSectionPage.getSection().getSectionId().toString());	
	}
%>

<script type="text/javascript" language="javascript1.2">
var XMLHttpRequestObject = false;

if(window.XMLHttpRequest) {
	XMLHttpRequestObject = new XMLHttpRequest();
} else if(window.ActiveXObject) {
	XMLHttpRequestObject = new ActiveXObject("Microsoft.XMLHTTP");
}
function saveEditor()
{
	var result;
	var sferyxdisplay = document.getElementById("EditSectionForm:contentEditorView:sferyxDisplay");
	if ((sferyxdisplay != undefined )&&(document.htmleditor!=undefined && document.htmleditor!= null))
	{	  	
		// document.htmleditor.saveToDefaultLocation();  
		document.htmleditor.addAdditionalDynamicParameter('mode',document.getElementById("EditSectionForm:mode").value);
        document.htmleditor.addAdditionalDynamicParameter('mId',document.getElementById("EditSectionForm:mId").value);
        document.htmleditor.addAdditionalDynamicParameter('sId',document.getElementById("EditSectionForm:sId").value);
        if(document.getElementById("EditSectionForm:rId") != undefined || document.getElementById("EditSectionForm:rId") != null)
      	  document.htmleditor.addAdditionalDynamicParameter('resourceId',document.getElementById("EditSectionForm:rId").value);
       document.htmleditor.addAdditionalDynamicParameter('uId',document.getElementById("EditSectionForm:uId").value);		  
		
		result = document.htmleditor.uploadMultipartContent(true);	
		
		// show large file error message to the user as form submit fails now.
		if(!result)
			{
			if(XMLHttpRequestObject){
				var obj = document.getElementById("errMsg1");
				var sourceobj="";
				var sourceobj1="";
			    if(document.getElementById("EditSectionForm:sId") != undefined || document.getElementById("EditSectionForm:sId") != null)
					sourceobj = escape(document.getElementById('EditSectionForm:sId').value);
				 if(document.getElementById("EditSectionForm:uId") != undefined || document.getElementById("EditSectionForm:uId") != null)	
					sourceobj1 = escape(document.getElementById('EditSectionForm:uId').value);
					
				XMLHttpRequestObject.open("GET", '/etudes-melete-tool/melete/addErrorMessage.jsf'+ '?sId='+ sourceobj + '&uId='+sourceobj1 +'&msg=embed_image_size_exceed');
				XMLHttpRequestObject.onreadystatechange = function()
				{
				  if(XMLHttpRequestObject.readyState == 4 && XMLHttpRequestObject.status == 200)
					  obj.innerHTML = XMLHttpRequestObject.responseText;
				}
				XMLHttpRequestObject.send(null);
			  }
			} 	    	
	}	
	return result;	
}

function showmessage()
{
		if (document.getElementById("file1").value.length  >  0)
		   {
		   window.defaultStatus="<%=mensaje%>";
		   } 
  }


function saveSection()
{
	var elementToGet = "EditSectionForm"+ ":" + "saveForBookmarkbutton";  
	var form = document.forms['EditSectionForm'];  
	if (form != null)
	{
	   var button = form.elements[elementToGet];  
	   button.click();
	 }
	 else
	 {
	   //Do nothing
	 }  
}
</script>

      <!-- This Begins the Main Text Area -->
	<h:form id="EditSectionForm" enctype="multipart/form-data" onsubmit="return saveEditor()">	
			  <h:inputHidden id="formName" value="EditSectionForm"/>  
			  <h:inputHidden id="mode" value="Edit"/>
			  <h:inputHidden id="mId" value="#{editSectionPage.module.moduleId}"/>
			  <h:inputHidden id="sId" value="#{editSectionPage.section.sectionId}"/>
			  <h:inputHidden id="rId" value="#{editSectionPage.meleteResource.resourceId}" rendered="#{editSectionPage.meleteResource !=null}"/>
			  <h:inputHidden id="uId" value="#{editSectionPage.currUserId}"/>
		<!-- top nav bar -->
		<f:subview id="top">
			<jsp:include page="topnavbar.jsp"/> 
		</f:subview>
		<div class="meletePortletToolBarMessage"><img src="images/document_edit.gif" alt="" width="16" height="16" align="absbottom"><h:outputText value="#{msgs.editmodulesections_editing_section}" /> </div>
		<h:messages id="editsectionerror"  layout="table" showDetail="true" showSummary="false" infoClass="BlueClass" errorClass="RedClass"/>
        <div id="errMsg1" style="color:red"><p> </p></div>
        <div class="right">
          <h:outputLink id="bookmarkSectionLink" value="editmodulesections" onclick="saveSection();var w=OpenBookmarkWindow(#{editSectionPage.section.sectionId},'Melete Bookmark Window');w.focus();">
	         <f:param id="sectionId" name="sectionId" value="#{editSectionPage.section.sectionId}" />
	         <h:graphicImage id="bul_gif" value="images/bookmark-it.png" alt="" styleClass="AuthImgClass"/>
	         <h:outputText id="bookmarktext" value="#{msgs.bookmark_text}" > </h:outputText>
           </h:outputLink>		
            <h:outputText value="|"/> 
           <h:commandLink id="myBookmarksLink" action="#{bookmarkPage.gotoMyBookmarks}">
             <h:graphicImage id="mybook_gif" value="images/my-bookmarks.png" alt="" styleClass="AuthImgClass"/>
             <h:outputText id="mybks" value="#{msgs.my_bookmarks}" />									
             <f:param name="fromPage" value="editmodulesections" /> 
           </h:commandLink>
        </div>
        <table class="maintableCollapseWithBorder">
     	   <tr>
            <td class="maintabledata3">
				  <table class="maintableCollapseWithNoBorder">
                   <!-- table header -->
	                   <tr>
			            <td colspan="2" height="20" class="maintabledata2">            	   
				     		<h:commandLink id="editPrevButton" onmousedown="return saveEditor();" action="#{editSectionPage.editPrevSection}" rendered="#{editSectionPage.hasPrev}">
			 					 <h:outputText id="text4_4" value="#{msgs.editmodulesections_edit_prev}"/>
							</h:commandLink> 
							<h:outputText id="text4_5" value="#{msgs.editmodulesections_edit_prev}" rendered="#{!editSectionPage.hasPrev}"/>
							&laquo;
			     			<h:commandLink id="TOCButton"  onmousedown="return saveEditor();" action="#{editSectionPage.goTOC}">
									<h:outputText id="toc" value="#{msgs.editmodulesections_TOC}" />
								</h:commandLink>
							&raquo;   
				     		<h:commandLink id="editNextButton" onmousedown="return saveEditor();" action="#{editSectionPage.editNextSection}" rendered="#{editSectionPage.hasNext}">
			 					 <h:outputText id="text4_2" value="#{msgs.editmodulesections_edit_next}"/>
							</h:commandLink>
							<h:outputText id="text4_6" value="#{msgs.editmodulesections_edit_next}" rendered="#{!editSectionPage.hasNext}"/>
							  <h:outputText id="text4_3" value=" / "/>				
				     		<h:commandLink onmousedown="return saveEditor();" action="#{editSectionPage.saveAndAddAnotherSection}">
			 					 <h:outputText id="text5" value="#{msgs.editmodulesections_add_new}"/>
							</h:commandLink> 						   	
						</td>
			          </tr>	
			          <tr>
			          	<td colspan="2" class="maintabledata9" >
			     			<h:outputText id="text4" value="#{editSectionPage.module.title}" /> &raquo; <h:outputText id="text4_1" value="#{editSectionPage.section.title}" />
			          	</td>
			          </tr>	 
	                   <!-- end table header -->
                                   <tr>
                                    <td class="col1" align="left" valign="top"><h:outputText id="text7" value="#{msgs.editmodulesections_section_title}" /><span class="required">*</span></td>
                                    <td class="col2" align="left" valign="top">
									<h:inputText id="title" value="#{editSectionPage.section.title}" size="45"  required="true" styleClass="formtext"/>
									</td>
                                  </tr>
                                  <tr>
                                    <td class="col1" align="left" valign="top"><h:outputText id="text8" value="#{msgs.editmodulesections_author}"/></td>
                                    <td class="col2" align="left" valign="top"><h:outputText value="#{editSectionPage.section.createdByFname}" styleClass="formtext"/>&nbsp;<h:outputText value="#{editSectionPage.section.createdByLname}" styleClass="formtext"/></td>
                                  </tr>
								  <tr>
                                    <td class="col1" align="left" valign="top"><h:outputText id="text9" value="#{msgs.editmodulesections_instructions}" /></td>
                                    <td class="col2" align="left" valign="top">
										  <h:inputTextarea id="instr" cols="45" rows="5" value="#{editSectionPage.section.instr}" styleClass="formtext">
											<f:validateLength maximum="250" minimum="1"/>
									</h:inputTextarea>
									</td>
                                  </tr>
                                  <tr>
                                    <td class="col1" align="left" valign="top"> <h:outputText id="text10" value="#{msgs.editmodulesections_modality}" /><span class="required">*</span></td>
                                    <td class="col2" align="left" valign="top"><h:outputText id="text11" value="#{msgs.editmodulesections_message1} "/>
									</td>
									  </tr>	
								  <tr>
								  <td class="col1">&nbsp;</td>
                                    <td class="col2" valign="top">
                        			<h:selectBooleanCheckbox id="contentext" title="textualContent" value="#{editSectionPage.section.textualContent}" >
									</h:selectBooleanCheckbox>
									<h:outputText  id="text12" value="#{msgs.editmodulesections_textual_content}"/>
									</td>
									  </tr>	
								  <tr>
								    <td class="col1">&nbsp;</td>
                                    <td class="col2" valign="top">									
									<h:selectBooleanCheckbox id="contentvideo" title="videoContent" value="#{editSectionPage.section.videoContent}" >
									</h:selectBooleanCheckbox>
									<h:outputText  id="text13" value="#{msgs.editmodulesections_visual_content}"/>
									</td>
									  </tr>	
								  <tr>
								    <td class="col1">&nbsp;</td>
                                    <td class="col2" valign="top">
									<h:selectBooleanCheckbox id="contentaudio" title="audioContent" value="#{editSectionPage.section.audioContent}" >
									</h:selectBooleanCheckbox>
									<h:outputText id="text14" value="#{msgs.editmodulesections_auditory_content}"/>			
										</td>
									  </tr>	
									  <tr>
								  	  <td  class="col1" align="left" valign="middle"><h:outputText id="text15" value="#{msgs.editmodulesections_content_type}" rendered="#{editSectionPage.shouldRenderContentTypeSelect}" /></td>
                                 	  <td class="col2"> 
										<h:inputHidden id="contentType"  value="#{editSectionPage.section.contentType}"  />	  								  	
										  <h:selectOneMenu id="contentType1" value="#{editSectionPage.section.contentType}" valueChangeListener="#{editSectionPage.showHideContent}" onchange="this.form.submit();"  rendered="#{editSectionPage.shouldRenderContentTypeSelect}">
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
										 <td colspan="2">
						 									
											 <f:subview id="contentEditorView" rendered="#{editSectionPage.shouldRenderEditor && authorPreferences.shouldRenderSferyx}">
												<jsp:include page="contentSferyxEditor.jsp" />
     											 <h:inputHidden id="sferyxDisplay" value="#{authorPreferences.shouldRenderSferyx}" />
											</f:subview>
											<f:subview id="othereditor" rendered="#{editSectionPage.shouldRenderEditor && authorPreferences.shouldRenderFCK}">
												<sakai:inputRichText id="otherMeletecontentEditor" value="#{editSectionPage.contentEditor}"  rows="50" cols="90" width="700" rendered="#{editSectionPage.shouldRenderEditor && authorPreferences.shouldRenderFCK}" collectionBase="#{editSectionPage.FCK_CollId}" />
											</f:subview>										
											</td>
									  </tr>	
								  <tr>
								   <td colspan="2">
												<f:subview id="ResourcePropertiesPanel" rendered="#{editSectionPage.meleteResource !=null && !editSectionPage.shouldRenderNotype}">
													<jsp:include page="edit_sec_resourcePropertiesPanel.jsp"/>
												</f:subview>
									</td>	
									</tr>																									
		                           </table>
                </td>
              </tr>
              <tr>
                <td>
                  <div class="actionBar" align="left">
              		<h:commandButton id="submitsave" action="#{editSectionPage.save}" rendered="#{editSectionPage.shouldRenderEditor}" value="#{msgs.im_save}" accesskey="#{msgs.save_access}" title="#{msgs.im_save_text}" styleClass="BottomImgSave"/>
					<h:commandButton id="submitsave1" action="#{editSectionPage.save}" rendered="#{editSectionPage.shouldRenderUpload}" onclick="showmessage()" value="#{msgs.im_save}" accesskey="#{msgs.save_access}" title="#{msgs.im_save_text}" styleClass="BottomImgSave"/>
					<h:commandButton id="submitsave2" action="#{editSectionPage.save}" rendered="#{!editSectionPage.shouldRenderEditor && !editSectionPage.shouldRenderUpload}" value="#{msgs.im_save}" accesskey="#{msgs.save_access}" title="#{msgs.im_save_text}" styleClass="BottomImgSave"/>
					<h:commandButton id="previewEditor" action="#{editSectionPage.getPreviewPage}" rendered="#{editSectionPage.shouldRenderEditor}" value="#{msgs.im_preview}" accesskey="#{msgs.preview_access}" title="#{msgs.im_preview_text}" styleClass="BottomImgPreview"/>
					<h:commandButton id="preview" action="#{editSectionPage.getPreviewPage}" rendered="#{editSectionPage.shouldRenderEditor == false}" value="#{msgs.im_preview}" accesskey="#{msgs.preview_access}" title="#{msgs.im_preview_text}" styleClass="BottomImgPreview"/>
					
					<h:commandButton id="saveAddAnotherbutton"  action="#{editSectionPage.saveAndAddAnotherSection}" value="#{msgs.im_add_another_section}"  accesskey="#{msgs.add_access}" title="#{msgs.im_add_another_section_text}" styleClass="BottomImgAdd"/>
						<h:commandButton id="FinishButton" action="#{editSectionPage.Finish}" value="#{msgs.im_finish}" accesskey="#{msgs.finish_access}" title="#{msgs.im_finish_text}" styleClass="BottomImgFinish"/>
						<h:commandButton id="saveForBookmarkbutton"  action="#{editSectionPage.save}" style="display: none; visibility: hidden;"/>
       			 </div></td>
              </tr>
              
            </table>
			
			
	   <p><span class="required">*</span>&nbsp; <h:outputText value="#{msgs.editmodulesections_required}" /></p>
  </h:form>
	 

  <!-- This Ends -->
</sakai:view>
</f:view>

