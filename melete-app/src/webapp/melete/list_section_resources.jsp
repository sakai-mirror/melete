<!--
 ***********************************************************************************
 * $URL$
 * $Id$  
 ***********************************************************************************
 *
 * Copyright (c) 2008, 2009 Etudes, Inc.
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
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>


  <h:panelGrid id="selresPanel" columns="1" width="100%">
   	<h:column>
		<h:outputText id="resource_text" value="#{msgs.list_section_resources_select}" rendered="#{addSectionPage.shouldRenderResources}" />			
	</h:column>		
	<h:column>
		<h:outputText value="#{msgs.list_section_resources_currently}" rendered="#{addSectionPage.renderSelectedResource}" /><h:outputText value="#{addSectionPage.secResourceName}" rendered="#{addSectionPage.renderSelectedResource}" />
	</h:column>											
</h:panelGrid>

<!-- navigation with showing 15 recs --> 
<h:panelGrid id="selresNavigationPanel" columns="2"  width="100%" border="0" columnClasses="TitleWid4,ActionWid2" rendered="#{addSectionPage.expandAllFlag && addSectionPage.listNav.displayNav}" >
<h:column/>
<h:column>
 <h:outputText id="nav_spaces_left1" value="" styleClass="ExtraPaddingClass" />
	<h:outputText value="#{msgs.list_section_resources_viewing}" /><h:outputText value="#{addSectionPage.listNav.displayStartIndex}" /><h:outputText value=" - " /><h:outputText value="#{addSectionPage.listNav.displayEndIndex}" /> <h:outputText value=" "/><h:outputText value="#{msgs.list_section_resources_of}" /> <h:outputText value="#{addSectionPage.listNav.totalSize -1}" /> 		
	 <h:outputText id="nav_spaces_right" value="" styleClass="ExtraPaddingClass" />
</h:column>
<h:column/>
   	<h:column>
   		<h:graphicImage id="leftImg_disable" value="images/nav_left_disable.jpg" alt="#{msgs.list_section_resources_previous}" styleClass="ModCheckClass" style="border:0" rendered="#{!addSectionPage.listNav.displayPrev}" />
		<h:commandLink id="prev_nav"  action="#{addSectionPage.listNav.goPrev}" rendered="#{addSectionPage.listNav.displayPrev}">		
						 <h:graphicImage id="leftImg" value="images/nav_left.jpg" alt="#{msgs.list_section_resources_previous2}" styleClass="ModCheckClass" style="border:0" />
		   </h:commandLink>		 
		   	 <h:outputText id="nav_spaces_left" value="" styleClass="ExtraPaddingClass" />
		  <h:selectOneMenu id="chunkSize"  valueChangeListener="#{addSectionPage.listNav.changeChunkSize}" onchange="this.form.submit();">
								<f:selectItem itemValue="30" itemLabel="#{msgs.list_section_resources_show30}"/>	
								<f:selectItem itemValue="100" itemLabel="#{msgs.list_section_resources_show100}"/>	
								<f:selectItem itemValue="-1" itemLabel="#{msgs.list_section_resources_showall}"/>	
		 </h:selectOneMenu>
		 <h:outputText id="nav_spaces" value="" styleClass="ExtraPaddingClass" />
				<h:commandLink id="next_nav" action="#{addSectionPage.listNav.goNext}" rendered="#{addSectionPage.listNav.displayNext}">
							 <h:graphicImage id="rightImg" value="images/nav_right.jpg" alt="#{msgs.list_section_resources_next}" styleClass="ModCheckClass" style="border:0" />
			   </h:commandLink>	 
			   <h:graphicImage id="rightImg_disable" value="images/nav_right_disable.jpg" alt="#{msgs.list_section_resources_next2}" styleClass="ModCheckClass" style="border:0" rendered="#{!addSectionPage.listNav.displayNext}"/> 
   	  </h:column>											
</h:panelGrid>
   <!-- navigation ends -->            		 
   
			 <h:dataTable id="table"  value="#{addSectionPage.displayResourcesList}"  var="curr_resources"  border="0" headerClass="tableheader2" columnClasses="TitleWid3,ActionWid" rowClasses="row1,row2"  width="100%"  rendered="#{addSectionPage.expandAllFlag}">
				  <h:column>
					   <f:facet name="header">
							<h:panelGroup>
								<h:commandLink id="ascType" action="#{addSectionPage.sortResourcesAsc}" immediate="true" rendered="#{addSectionPage.sortAscFlag}">
								    <h:graphicImage id="asc_Type_img" alt="#{msgs.manage_res_list_alt_asc}" title="#{msgs.manage_res_list_alt_asc}" value="images/sortascending.gif" styleClass="ExpClass"/>
								 </h:commandLink>     
								 <h:commandLink id="descType" action="#{addSectionPage.sortResourcesDesc}" immediate="true" rendered="#{!addSectionPage.sortAscFlag}">
								    <h:graphicImage id="des_Type_img" alt="#{msgs.manage_res_list_alt_desc}" title="#{msgs.manage_res_list_alt_desc}" value="images/sortdescending.gif" styleClass="ExpClass"/>
								 </h:commandLink>        
					            
							  <h:outputText value="#{msgs.list_section_resources_title2}" />
							 </h:panelGroup> 
						 </f:facet>
					 <h:outputText id="emp_space" value="     "  styleClass="ExtraPaddingClass" rendered="#{curr_resources.resource_id != addSectionPage.selResourceIdFromList}"/>	
					 <h:graphicImage id="check_gif" alt="#{msgs.list_section_resources_check}" value="images/checkon.gif" rendered="#{curr_resources.resource_id == addSectionPage.selResourceIdFromList}"/>
					 <h:graphicImage id="contenttype_gif" alt="#{msgs.list_section_resources_content_url}" title="#{msgs.list_section_resources_content_url}" value="images/url.gif" styleClass="ExpClass" rendered="#{addSectionPage.shouldRenderLink}"/>
					 <h:graphicImage id="contenttype_gifLTI" alt="#{msgs.edit_list_resources_content_url}" title="#{msgs.edit_list_resources_content_url}" value="images/web_service.png" styleClass="ExpClass" rendered="#{addSectionPage.shouldRenderLTI}"/>
					<h:graphicImage id="contenttype_gif1" alt="#{msgs.edit_list_resources_content_upload}" 
						title="#{msgs.edit_list_resources_content_upload}" value="#{curr_resources.resource_gif}" styleClass="ExpClass" rendered="#{editSectionPage.shouldRenderUpload}"/>
							<h:outputText id="emp_spacebefore" value="       "  styleClass="ExtraPaddingClass"/>
							<h:outputLink id="showResourceLink" value="#{curr_resources.resource_url}" target="_blank" title="Section Resource" styleClass="a1">
								  <h:outputText value="#{curr_resources.resource_title}" />
						  </h:outputLink>
				    </h:column>
				    <h:column>
				    <f:facet name="header">
							 <h:outputText id="t2" value="#{msgs.list_section_resources_actions2}" />
					 </f:facet>
					  <h:graphicImage id="linkgif" alt="" value="images/link2me.png" styleClass="AuthImgClass" />
				      <h:outputText id="emp_space-3" value=" " />
				     <h:commandLink id="linkaction" actionListener="#{addSectionPage.selectedResourceAction}"  action="#{addSectionPage.redirectLink}" immediate="true">
				     <f:param name="linkactionParam" value="#{curr_resources.resource_id}" />
						<h:outputText value="#{msgs.list_section_resources_link}" />
					 </h:commandLink>	
					  <h:outputText id="emp_space-1" value="     "  styleClass="ExtraPaddingClass" />
					 <h:graphicImage id="delgif" alt="" value="images/delete.gif" styleClass="AuthImgClass" />
					 <h:outputText id="emp_space-2" value=" " />
					 <h:commandLink id="deleteaction" actionListener="#{addSectionPage.selectedResourceDeleteAction}"  action="#{addSectionPage.redirectDeleteLink}" immediate="true" >
				    		<f:param name="linkactionParam1" value="#{curr_resources.resource_id}" />
				    		<f:param name="linkactionParam2" value="#{curr_resources.resource_title}" />
				    		<h:outputText id="deltext" value="#{msgs.list_section_resources_del}"  />
					 </h:commandLink>	
				    </h:column>
              </h:dataTable>
