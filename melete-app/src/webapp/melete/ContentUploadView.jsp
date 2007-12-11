<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>

	<h:panelGrid id="uploadView1" columns="1" width="100%" styleClass="left">
		<h:column>
			<h:outputText id="uploadText1" value="#{msgs.contentuploadview_upload}" rendered="#{addSectionPage.shouldRenderUpload}"/>				
			<h:outputText id="extraspacesUpload" value="    " styleClass="ExtraPaddingClass" />	
			<h:outputText id="uploadText2" value="#{addSectionPage.uploadFileName}" rendered="#{addSectionPage.uploadFileName != null}" styleClass="bold"/>	
			<h:outputText id="uploadText3" value="#{msgs.contentuploadview_nofile}" rendered="#{addSectionPage.uploadFileName == null}" styleClass="bold"/>	
			<h:outputText id="somespaces1" value="" styleClass="ExtraPaddingClass" />
			<h:commandLink id="serverViewButton"  action="#{addSectionPage.gotoServerView}" >
					<h:graphicImage id="replaceImg2" value="images/replace2.gif" styleClass="AuthImgClass"/>
					<h:outputText value="#{msgs.contentuploadview_select}" />
             </h:commandLink>	
          </h:column>      
</h:panelGrid>
		
		
	