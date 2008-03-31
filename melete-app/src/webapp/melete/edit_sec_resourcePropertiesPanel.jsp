	<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

 
	   <h:panelGrid id="propertiesPanel" columns="1" width="100%" styleClass="maintabledata2">
		<h:column>
					<h:outputText id="propertiesPaneltxt" value="#{msgs.editsec_resources_proper_pan_properties}" />
					<h:outputText id="propertiesPaneltxt1" value="#{editSectionPage.secResourceName}" />
		</h:column>
	</h:panelGrid>
	<h:panelGrid id="propertiesPanel2" columns="2" width="82%" cellpadding="3" columnClasses="copyrightColumn1,copyrightColumn2" border="0">
		<h:column>
				 <h:outputText value="#{msgs.editsec_resources_proper_pan_URL}"  rendered="#{editSectionPage.shouldRenderLink}" /><h:outputText value="*" styleClass="required" rendered="#{editSectionPage.shouldRenderLink}"/>
		</h:column>	 
			<h:column>				
					 <h:inputText id="res_name" size="45" value="#{editSectionPage.secResourceName}" styleClass="formtext" rendered="#{editSectionPage.shouldRenderLink}" />		
		</h:column>
		<h:column rendered="#{editSectionPage.shouldRenderLink}">
		
		</h:column>
		<h:column rendered="#{editSectionPage.shouldRenderLink}">
			<h:selectBooleanCheckbox id="windowopen" title="openWindow" value="#{editSectionPage.section.openWindow}" rendered="#{editSectionPage.shouldRenderLink}">
														 </h:selectBooleanCheckbox>
														 <h:outputText id="editlinkText_8" value="#{msgs.editcontentlinkserverview_openwindow}" rendered="#{editSectionPage.shouldRenderLink}"/>
		</h:column>							                  
		<h:column>
					 <h:outputText value="#{msgs.editsec_resources_proper_pan_description}" rendered="#{ !editSectionPage.shouldRenderEditor}"  />											
		</h:column>	
		<h:column>		
			<h:inputTextarea id="res_desc" cols="45" rows="3" value="#{editSectionPage.secResourceDescription}" styleClass="formtext"  
			rendered="#{!editSectionPage.shouldRenderEditor}"  />																			
		</h:column>
						<!-- copyright license code -->
			<h:column>
						  <h:outputText value="#{msgs.editsec_resources_proper_pan_cstatus}"/>	 
			</h:column>	
			<h:column>						
						 <h:selectOneMenu id="licenseCodes" value="#{editSectionPage.m_license.licenseCodes}" valueChangeListener="#{editSectionPage.m_license.hideLicense}" onchange="transferEditordata();this.form.submit();" >
												 <f:selectItems value="#{editSectionPage.m_license.licenseTypes}" />							
							 </h:selectOneMenu>	 		
							 	 <h:outputText value="          " styleClass="ExtraPaddingClass" />
							 <h:outputLink value="licenses_explained.htm" rendered="#{!editSectionPage.shouldRenderNotype}" target="_blank">  <h:graphicImage value="images/help.gif" alt="#{msgs.editsec_resources_proper_pan_learn}" width="16" height="16" /></h:outputLink>		
			</h:column>	
		</h:panelGrid>


<h:panelGrid id="propertiesPanel3" columns="1" width="100%">
					<h:column>
						  <f:subview id="CCLicenseForm" rendered="#{editSectionPage.m_license.shouldRenderCC || editSectionPage.m_license.shouldRenderCopyright ||  editSectionPage.m_license.shouldRenderPublicDomain || editSectionPage.m_license.shouldRenderFairUse}">	
												<jsp:include page="editsection_cclicenseform.jsp"/> 
											</f:subview>
					</h:column>	
		</h:panelGrid>
		
			        <!-- end license code -->		
