<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>


<h:panelGrid id="uploadView" columns="1" width="100%" border="0">
	<h:column>
		<h:outputText id="edituploadText1" value="#{msgs.editcontentuploadview_file_uploaded}" />
		<h:outputText id="somespaces_1" value="   " styleClass="ExtraPaddingClass" />			
		<h:outputText id="edituploadText2" value="#{editSectionPage.uploadFileName}" rendered="#{editSectionPage.uploadFileName != null}" styleClass="bold"/>	
	<h:outputText id="edituploadText3" value="#{msgs.editcontentuploadview_nofile}" rendered="#{editSectionPage.uploadFileName == null}" styleClass="bold"/>	
		<h:outputText id="somespaces1" value="" styleClass="ExtraPaddingClass" />		
		<h:commandLink id="serverViewButton"  action="#{editSectionPage.gotoServerView}" >
			<h:graphicImage id="replaceImg2" value="images/replace2.gif" styleClass="AuthImgClass"/>
					<h:outputText value="#{msgs.editcontentuploadview_replace}"/>
                </h:commandLink>		
	</h:column>		
	 <h:column>     	
        <h:outputText id="extraspacesUpload2" value="" styleClass="LotsofPaddingClass" />	
             <h:selectBooleanCheckbox id="windowopen" title="openWindow" value="#{editSectionPage.section.openWindow}" rendered="#{editSectionPage.shouldRenderUpload}">
		  </h:selectBooleanCheckbox>
		  <h:outputText id="editlinkText_8" value="#{msgs.editcontentlinkserverview_openwindow}" rendered="#{editSectionPage.shouldRenderUpload}"/>
        </h:column>     
   </h:panelGrid>
	
