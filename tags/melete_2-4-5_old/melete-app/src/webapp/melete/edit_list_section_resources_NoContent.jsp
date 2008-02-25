<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>


  <h:panelGrid id="selresPanel" columns="1" width="100%">
   	<h:column>
		<h:outputText id="resource_text" value="Select a Resource" rendered="#{editSectionPage.shouldRenderResources}" />	
	</h:column>		
	<h:column>
		<h:outputText value="Currently selected resource: " rendered="#{editSectionPage.renderSelectedResource}" /><h:outputText value="#{editSectionPage.secResourceName}" rendered="#{editSectionPage.renderSelectedResource}" styleClass="bold"/>
	</h:column>											
</h:panelGrid>		
              
<!-- navigation with showing 15 recs --> 
<h:panelGrid id="selresNavigationPanel" columns="2" width="auto" border="0" columnClasses="TitleWid4,ActionWid2" rendered="#{editSectionPage.expandAllFlag && editSectionPage.listNav.displayNav}">
<h:column/>
<h:column>
	<h:outputText id="nav_spaces_left1" value="" styleClass="ExtraPaddingClass" />
		<h:outputText value="#{msgs.edit_list_resources_nc_viewing}" /><h:outputText value="#{editSectionPage.listNav.displayStartIndex}" /><h:outputText value=" - " /><h:outputText value="#{editSectionPage.listNav.displayEndIndex}" /><h:outputText value=" " />  <h:outputText value="#{msgs.edit_list_resources_nc_of}" /> <h:outputText value="#{editSectionPage.listNav.totalSize -1}" /> 
		<h:outputText id="nav_spaces_right" value="" styleClass="ExtraPaddingClass" />
</h:column>
<h:column/>
   	<h:column>
   		<h:graphicImage id="leftImg_disable" value="images/nav_left_disable.jpg" alt="#{msgs.edit_list_resources_nc_previous}" styleClass="ModCheckClass" style="border:0" rendered="#{!editSectionPage.listNav.displayPrev}" />
		<h:commandLink id="prev_nav"  action="#{editSectionPage.listNav.goPrev}" rendered="#{editSectionPage.listNav.displayPrev}">		
						 <h:graphicImage id="leftImg" value="images/nav_left.jpg" alt="#{msgs.edit_list_resources_nc_previous2}" styleClass="ModCheckClass" style="border:0" />
		   </h:commandLink>		 
		   <h:outputText id="nav_spaces_left" value="" styleClass="ExtraPaddingClass" />
		  <h:selectOneMenu id="chunkSize">
								<f:selectItem itemValue="15" itemLabel="#{msgs.edit_list_resources_nc_show15}"/>	
		 </h:selectOneMenu>
	 	 <h:outputText id="nav_spaces" value="" styleClass="ExtraPaddingClass" />
				<h:commandLink id="next_nav" action="#{editSectionPage.listNav.goNext}" rendered="#{editSectionPage.listNav.displayNext}">
							 <h:graphicImage id="rightImg" value="images/nav_right.jpg" alt="#{msgs.edit_list_resources_nc_next}" styleClass="ModCheckClass" style="border:0"/>
			   </h:commandLink>	 
			   <h:graphicImage id="rightImg_disable" value="images/nav_right_disable.jpg" alt="#{msgs.edit_list_resources_nc_next2}" styleClass="ModCheckClass" style="border:0" rendered="#{!editSectionPage.listNav.displayNext}"/> 
   	  </h:column>											
</h:panelGrid>
   <!-- navigation ends -->   
                 		 
			 <h:dataTable id="table"  value="#{editSectionPage.displayResourcesList}"  var="curr_resources"  border="0" headerClass="tableheader2" columnClasses="TitleWid3,ActionWid" rowClasses="row1,row2"  width="100%"  rendered="#{editSectionPage.expandAllFlag}">
				  <h:column>
					   <f:facet name="header">
							<h:panelGroup>
								<h:commandLink id="collapseAllAction" action="#{editSectionPage.collapseAllResources}" immediate="true">
								    <h:graphicImage id="col_all_gif" alt="#{msgs.edit_list_resources_nc_collapse_all}" title="#{msgs.edit_list_resources_nc_collapse_all2}" value="images/collapse-expand.gif" rendered="#{editSectionPage.shouldRenderResources && editSectionPage.expandAllFlag}" styleClass="ExpClass"/>
								 </h:commandLink>           
							  <h:outputText value="#{msgs.edit_list_resources_nc_title2}" />
							 </h:panelGroup> 
						 </f:facet>
						  <h:outputText id="emp_space" value="     "  styleClass="ExtraPaddingClass" rendered="#{curr_resources.resource_id != editSectionPage.selResourceIdFromList}"/>	
						 <h:graphicImage id="check_gif" alt="#{msgs.edit_list_resources_nc_check}" value="images/checkon.gif" rendered="#{curr_resources.resource_id == editSectionPage.selResourceIdFromList}"/>			
						<h:graphicImage id="contenttype_gif" alt="#{msgs.edit_list_resources_nc_content}" value="images/url.gif" styleClass="ExpClass" rendered="#{editSectionPage.shouldRenderLink}"/>
						<h:graphicImage id="contenttype_gif1" alt="#{msgs.edit_list_resources_nc_content}" value="images/image.gif" styleClass="ExpClass" rendered="#{editSectionPage.shouldRenderUpload}"/>
							<h:outputText id="emp_spacebefore" value="       "  styleClass="ExtraPaddingClass"/>
						  <h:outputLink id="showResourceLink" value="#{curr_resources.resource_url}" target="_blank" title="Section Resource" styleClass="a1">
								  <h:outputText value="#{curr_resources.resource_title}" />
						  </h:outputLink>
				    </h:column>
				    <h:column>
				    <f:facet name="header">
							 <h:outputText id="t2" value="#{msgs.edit_list_resources_nc_actions2}" />
					 </f:facet>
				     <h:commandLink id="linkaction" actionListener="#{editSectionPage.selectedResourceAction}"  action="#{editSectionPage.redirectLinktoEdit}" immediate="true">
				     <f:param name="linkactionParam" value="#{curr_resources.resource_id}" />
						<h:outputText value="#{msgs.edit_list_resources_nc_link}" />
					 </h:commandLink>	
				    </h:column>
              </h:dataTable>   
      	
