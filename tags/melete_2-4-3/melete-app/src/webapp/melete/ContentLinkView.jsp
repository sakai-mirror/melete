<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
  <h:panelGrid id="LinkPanel2" columns="2" width="83%" columnClasses="copyrightColumn1,copyrightColumn2" border="0">
   	<h:column><h:outputText id="linkText1" value="#{msgs.contentlinkview_link}"/></h:column>
   	<h:column>
			 <h:inputText id="link" value="#{addSectionPage.linkUrl}" size="45" rendered="#{addSectionPage.shouldRenderLink}"/> 
		  </h:column>		  
</h:panelGrid>
