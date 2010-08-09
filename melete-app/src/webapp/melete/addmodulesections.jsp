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
<sakai:view title="Modules: Add Module Sections" toolCssHref="rtbc004.css">
<%@include file="accesscheck.jsp" %>

<%@ page import="javax.faces.application.FacesMessage, org.sakaiproject.util.ResourceLoader, org.etudes.tool.melete.AddSectionPage"%>

<% 
	ResourceLoader bundle = new ResourceLoader("org.etudes.tool.melete.bundle.Messages");
	String mensaje=bundle .getString("addmodulesections_uploading");
	String mensaje2=bundle .getString("addmodulesections_done");

	final javax.faces.context.FacesContext facesContext = javax.faces.context.FacesContext.getCurrentInstance();
	AddSectionPage aSectionPage = (AddSectionPage)facesContext.getApplication().getVariableResolver().resolveVariable(facesContext, "addSectionPage");
	request.setAttribute("attr_sId",aSectionPage.getSection().getSectionId().toString());
%>

<style type="text/css">
<!--
.style1 {color: #FFFFFF}
-->
</style>

<script language="javascript1.2">
  var XMLHttpRequestObject = false;
try
{
if(window.XMLHttpRequest) {
	XMLHttpRequestObject = new XMLHttpRequest();
} else if(window.ActiveXObject) {
	XMLHttpRequestObject = new ActiveXObject("Microsoft.XMLHTTP");
}
}catch(e){XMLHttpRequestObject = false;}

  function clearmessage()
 {
		   window.defaultStatus="<%=mensaje2%>";
  }


function contentChangeSubmit()
{
	   document.getElementById("AddSectionForm:contentChange").value = "true";
}

function saveEditor()
{
	var result;
	var sferyxdisplay = document.getElementById("AddSectionForm:contentEditorView:sferyxDisplay");
	if ((sferyxdisplay != undefined )&&(document.htmleditor!=undefined && document.htmleditor!= null))
	{	  	
		// document.htmleditor.saveToDefaultLocation();  
		document.htmleditor.addAdditionalDynamicParameter('mode',document.getElementById("AddSectionForm:mode").value);
        document.htmleditor.addAdditionalDynamicParameter('mId',document.getElementById("AddSectionForm:mId").value);
        document.htmleditor.addAdditionalDynamicParameter('sId',document.getElementById("AddSectionForm:sId").value);
        if(document.getElementById("AddSectionForm:rId") != undefined || document.getElementById("AddSectionForm:rId") != null)
      	  document.htmleditor.addAdditionalDynamicParameter('resourceId',document.getElementById("AddSectionForm:rId").value);
         document.htmleditor.addAdditionalDynamicParameter('uId',document.getElementById("AddSectionForm:uId").value);		  
		result = document.htmleditor.uploadMultipartContent(true);		 
		
		// show large file error message to the user as form submit fails now.
		if(!result)
			{
			try{
				if(XMLHttpRequestObject){
					var obj = document.getElementById("errMsg1");
					var sourceobj = escape(document.getElementById("AddSectionForm:sId").value);
					var sourceobj1 = escape(document.getElementById("AddSectionForm:uId").value);
					XMLHttpRequestObject.open("GET", '/etudes-melete-tool/melete/addErrorMessage.jsf'+ '?sId='+ sourceobj + '&uId='+sourceobj1 +'&msg=embed_image_size_exceed');
					
					XMLHttpRequestObject.onreadystatechange = function()
					{
					  if(XMLHttpRequestObject.readyState == 4 && XMLHttpRequestObject.status == 200)
						  obj.innerHTML = XMLHttpRequestObject.responseText;
					}
					XMLHttpRequestObject.send(null);
				  }
			  }catch(e){result = false;}
			} 		
	}	
	return result;	
}

</script>

      <!-- This Begins the Main Text Area -->
	<h:form id="AddSectionForm" enctype="multipart/form-data" onsubmit=" return saveEditor();">	
	  <h:inputHidden id="mode" value="Add"/>
	  <h:inputHidden id="mId" value="#{addSectionPage.module.moduleId}"/>
	  <h:inputHidden id="sId" value="#{addSectionPage.section.sectionId}"/>
	  <h:inputHidden id="rId" value="#{addSectionPage.meleteResource.resourceId}" rendered="#{addSectionPage.meleteResource !=null}"/>
	  <h:inputHidden id="uId" value="#{addSectionPage.currUserId}"/>
	  
	<!-- top nav bar -->
		<f:subview id="top">
			<jsp:include page="topnavbar.jsp"/> 
		</f:subview>
		<div class="meletePortletToolBarMessage"><img src="images/document_add.gif" alt="" width="16" height="16" align="absmiddle"><h:outputText value="#{msgs.addmodulesections_adding_section}" /> </div>	
		<h:messages id="addsectionerror" layout="table" showDetail="true" showSummary="false" infoClass="BlueClass" errorClass="RedClass"/>
		<div id="errMsg1" style="color:red"><p> </p></div>
		
        <table class="maintableCollapseWithBorder">
          <tr>
            <td>
                     <table class="maintableCollapseWithNoBorder">
                                <tr>
						            <td colspan="2" height="20" class="maintabledata5">
						            	<h:commandButton id="TOCButton" action="#{addSectionPage.goTOC}" value="#{msgs.addmodulesections_TOC}"  accesskey="#{msgs.toc_access}" title="#{msgs.im_toc_text}" styleClass="BottomImgTOC"/>
										 &raquo; <h:outputText id="text11" value="#{addSectionPage.module.title}" />  &raquo; <h:outputText id="add_new_section" value="#{msgs.addmodulesections_add_new_section}" />
									</td>
						          </tr>
                                  <tr>
                                    <td class="col1" align="left" valign="top"><h:outputText id="text7" value="#{msgs.addmodulesections_section_title}" /><span class="required">*</span></td>
                                    <td class="col2" align="left" valign="top">
										<h:inputText id="title" value="#{addSectionPage.section.title}" size="45" required="true" styleClass="formtext" title="Title"/>
										
									</td>
                                  </tr>
                                  <tr>
                                    <td class="col1" align="left" valign="top"><h:outputText id="text6" value="#{msgs.addmodulesections_author}" /></td>
                                    <td class="col2" align="left" valign="top"><h:outputText id="author" value="#{addSectionPage.author}" styleClass="formtext"/></td>
                                   </tr>
                                   <tr>
                                    <td class="col1" align="left" valign="top"><h:outputText id="text5" value="#{msgs.addmodulesections_instructions}" /></td>
                                    <td class="col2" align="left" valign="top">
									  <h:inputTextarea id="instr" cols="45" rows="5" value="#{addSectionPage.section.instr}" styleClass="formtext" >
											<f:validateLength maximum="250" minimum="1"/>
									</h:inputTextarea>													
									</td>
                                  </tr>
                                <tr>
                                    <td class="col1" align="left" valign="top"> <h:outputText id="modality" value="#{msgs.addmodulesections_modality}" /><span class="required">*</span></td>
                                    <td class="col2" align="left" valign="top"><h:outputText id="text4" value="#{msgs.addmodulesections_message1} "/>
									</td>
									  </tr>	
								  <tr>
								  <td class="col1">&nbsp;</td>
                                    <td class="col2" valign="top">
                        			<h:selectBooleanCheckbox id="contentext" title="textualContent" value="#{addSectionPage.section.textualContent}">
									</h:selectBooleanCheckbox>
									<h:outputText  id="text12" value="#{msgs.addmodulesections_textual_content}" />
									</td>
									  </tr>	
								  <tr>
								    <td class="col1">&nbsp;</td>
                                    <td class="col2" valign="top">									
									<h:selectBooleanCheckbox id="contentvideo" title="videoContent" value="#{addSectionPage.section.videoContent}" >
									</h:selectBooleanCheckbox>
									<h:outputText  id="text13" value="#{msgs.addmodulesections_visual_content}" />
									</td>
									  </tr>	
								  <tr>
								    <td class="col1">&nbsp;</td>
                                    <td class="col2" valign="top">
									<h:selectBooleanCheckbox  id="contentaudio" title="audioContent" value="#{addSectionPage.section.audioContent}" >
									</h:selectBooleanCheckbox>
									<h:outputText id="text14" value="#{msgs.addmodulesections_auditory_content}"/>			
										</td>
									  </tr>	
									 
								  <tr>
								  	  <td class="col1" align="left" valign="middle"><h:outputText id="text15" value="#{msgs.addmodulesections_content_type}" /></td>
                                 	  <td class="col2"> 
										   <h:inputHidden id="contentChange" value=""/>								  
												  <h:selectOneMenu id="contentType" value="#{addSectionPage.section.contentType}" valueChangeListener="#{addSectionPage.showHideContent}" onchange="contentChangeSubmit();this.form.submit();"  >
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
											 <f:subview id="ContentLTIView" rendered="#{addSectionPage.shouldRenderLTI}">
												<jsp:include page="ContentLTIView.jsp"/> 
											</f:subview>	
									     </td>
									     </tr>
									     <tr>			
										 <td colspan="2"> 
												
											<f:subview id="contentEditorView" rendered="#{addSectionPage.shouldRenderEditor && authorPreferences.shouldRenderSferyx}">
														<jsp:include page="contentSferyxEditor.jsp"/> 	
																										
													 <h:inputHidden id="sferyxDisplay" value="#{authorPreferences.shouldRenderSferyx}" />
											</f:subview>																																

											<f:subview id="othereditor" rendered="#{addSectionPage.shouldRenderEditor && authorPreferences.shouldRenderFCK}">
												<sakai:inputRichText  id="otherMeletecontentEditor" value="#{addSectionPage.contentEditor}"  rows="50" cols="90" width="700" rendered="#{addSectionPage.shouldRenderEditor && authorPreferences.shouldRenderFCK}" collectionBase="#{addSectionPage.FCK_CollId}" />
											</f:subview>

										</td>
										</tr>
										<tr>
										<td colspan="2">
										<f:subview id="ResourcePropertiesPanel" rendered="#{!addSectionPage.shouldRenderNotype}">
											<jsp:include page="sec_resourcePropertiesPanel.jsp"/>
										</f:subview>
									</td>	
									</tr>
									</table>	 
									
	          <div class="actionBar" align="left">	
				<h:commandButton id="submitsave" action="#{addSectionPage.save}" rendered="#{addSectionPage.shouldRenderEditor}" value="#{msgs.im_add_button}"  accesskey="#{msgs.add_access}" title="#{msgs.im_add_button_text}" styleClass="BottomImgAdd"/>
				<h:commandButton id="submitsave1" action="#{addSectionPage.save}" rendered="#{addSectionPage.shouldRenderUpload}" onclick="clearmessage()" value="#{msgs.im_add_button}"  accesskey="#{msgs.add_access}" title="#{msgs.im_add_button_text}" styleClass="BottomImgAdd"/>
				<h:commandButton id="submitsave2" action="#{addSectionPage.save}" rendered="#{!addSectionPage.shouldRenderEditor && !addSectionPage.shouldRenderUpload}" value="#{msgs.im_add_button}"  accesskey="#{msgs.add_access}" title="#{msgs.im_add_button_text}" styleClass="BottomImgAdd"/>
				<h:commandButton id="submitsave3" action="#{addSectionPage.saveIntermediate}" rendered="#{addSectionPage.shouldRenderEditor}" value="#{msgs.im_save}"  accesskey="#{msgs.save_access}" title="#{msgs.im_save_text}" styleClass="BottomImgSave"/>
				<h:commandButton id="cancelButton" immediate="true" action="#{addSectionPage.cancel}" value="#{msgs.im_cancel}"  onclick="clearmessage()" accesskey="#{msgs.cancel_access}" title="#{msgs.im_cancel_text}" styleClass="BottomImgCancel"/>
			
			 </div>
			</td>
          </tr>
        </table>
		<p ><span class="required">*</span>&nbsp;<h:outputText value="#{msgs.addmodulesections_required}" /></p>
	
</h:form>
</sakai:view>
</f:view>

