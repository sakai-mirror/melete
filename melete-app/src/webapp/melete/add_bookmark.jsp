<%@ page import="org.etudes.tool.melete.BookmarkPage,javax.faces.application.FacesMessage, java.util.ResourceBundle"%>

<!--
 ***********************************************************************************
 * $URL: https://source.sakaiproject.org/contrib/etudes/melete/trunk/melete-app/src/webapp/melete/add_bookmark.jsp $
 * $Id: add_bookmark.jsp 64898 2009-11-24 22:26:14Z mallika@etudes.org $  
 ***********************************************************************************
 *
 * Copyright (c) 2010 Etudes, Inc.
 *
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

<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>

<f:view>
<sakai:view title="Modules: Add bookmarks" toolCssHref="rtbc004.css">

<script language="javascript1.2">
function validate_required(value,alerttxt)
{
if (value==null||value=="")
    {
    alert(alerttxt);return false;
    }
  else
    {
    return true;
    }
  
}

function validate_form()
{
	if (validate_required(document.getElementById("AddBookmarkForm:title").value,"Title is required")==false)
	  {
   	     document.getElementById("AddBookmarkForm:title").focus();
		  return false;
	}
}
</script>

<%
final javax.faces.context.FacesContext facesContext = javax.faces.context.FacesContext.getCurrentInstance();
final BookmarkPage bookmarkPage = (BookmarkPage)facesContext.getApplication().getVariableResolver().resolveVariable(facesContext, "bookmarkPage");
bookmarkPage.setBookmark(null);
String sectionId = (String)request.getParameter("sectionId");
String sectionTitle = (String)request.getParameter("sectionTitle");
bookmarkPage.setSectionId(sectionId);
bookmarkPage.setSectionTitle(sectionTitle);
%>

<h:form id="AddBookmarkForm">
<h:messages id="addbookmarkerror" layout="table" showDetail="true" showSummary="false" infoClass="BlueClass" errorClass="RedClass"/>
<table cellspacing="0" cellpadding="10" width="100%" border="0" align="center">
	<tr>
		<td>
			<table class="forumline" cellspacing="1" cellpadding="4" width="100%" border="0">
				<tr>
					<th class="thHead" height="25" colspan="2">
						<h:outputText value="#{msgs.add_bookmark_headtitle}" rendered="#{bookmarkPage.bookmark.bookmarkId == 0}"/>
						<h:outputText value="#{msgs.add_bookmark_editheadtitle}" rendered="#{bookmarkPage.bookmark.bookmarkId != 0}"/>
						
					</th>
				</tr>
				<tr>
					<td width="20%"><span class="gen"><h:outputText value="#{msgs.add_bookmark_title}" /> <span class="required">*</span></td>
					<td>	<h:inputText id="title" size="45" value="#{bookmarkPage.bookmark.title}" required="true" styleClass="formtext" />
				</td>
				</tr>
                
                <tr>
					<td width="20%" valign="top"><span class="gen"><h:outputText value="#{msgs.add_bookmark_notes}" /></td>
					<td>	<h:inputTextarea id="notes" cols="45" rows="20" value="#{bookmarkPage.bookmark.notes}" styleClass="formtext" />
				</td>
				</tr>
				
				<tr>
					<td width="20%"><span class="gen"><h:outputText value="#{msgs.add_bookmark_lastvisited}" /></td>
					<td>	 
					<h:selectBooleanCheckbox id="flaglastvisited" title="flaglastvisited" value="#{bookmarkPage.bookmark.lastVisited}" >
		            </h:selectBooleanCheckbox>
				</td>
				</tr>
				

				<tr>
					<td colspan="2" align="center">
					<div class="actionBar" align="left">
				
				    <h:inputHidden id="sectionId" value="#{bookmarkPage.sectionId}"/>
				    <h:inputHidden id="sectionTitle" value="#{bookmarkPage.sectionTitle}"/>
				    
          	        <h:commandButton action="#{bookmarkPage.addBookmark}" value="#{msgs.im_add_button}" accesskey="#{msgs.add_access}" title="#{msgs.im_add_button_text}" styleClass="BottomImgAdd"  onclick="return validate_form();" rendered="#{bookmarkPage.bookmark.bookmarkId == 0}" />
          	        <h:commandButton action="#{bookmarkPage.addBookmark}"  value="#{msgs.im_save}" accesskey="#{msgs.save_access}" title="#{msgs.im_save_text}" styleClass="BottomImgAdd" onclick="return validate_form();" rendered="#{bookmarkPage.bookmark.bookmarkId != 0}" />
          	        
			        </div>
					</tr>
					
			</table>
			<p><span class="required">*</span>&nbsp;<h:outputText value="#{msgs.add_bookmark_required}" /></p>
		</td>
	</tr>
</table>

</h:form>
</sakai:view>
</f:view>
