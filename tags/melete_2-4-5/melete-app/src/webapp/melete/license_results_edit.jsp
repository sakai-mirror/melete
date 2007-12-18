<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<h:panelGrid id="cclicensetable" columns="1" rendered="#{!editModulePage.copyright}" >
	<h:column>
	 <h:outputText value="#{msgs.license_results_edit1}" /> 
	  <h:outputLink value="#{editModulePage.agreeResultUrl}" target="_blank"> 
		 <f:verbatim></f:verbatim>
		 <h:outputText value="#{editModulePage.agreeResult}" />
	 </h:outputLink>
	  <h:outputText value="#{msgs.license_results_edit2}" /> 	 
  </h:column>
</h:panelGrid>
<h:panelGrid id="cclicenseresultsedittable" columns="1" rendered="#{editModulePage.copyright && !editModulePage.fairuse}" >
	<h:column>
		 <h:outputText value="#{msgs.license_results_edit3} " /> 
		 <h:outputText value="#{editModulePage.agreeResultUrl}" styleClass="italics"/>
	 	  <h:outputText value="#{msgs.license_results_edit4} "/> 
	</h:column>
</h:panelGrid>

<h:panelGrid id="cclicenseresultstable1" columns="1" rendered="#{editModulePage.fairuse}" >
	<h:column>
		 <h:outputText value="#{msgs.license_results_edit5} " /> 
		  <h:outputText value="#{editModulePage.agreeResultUrl}" styleClass="italics"/>
	 	  <h:outputText value="#{msgs.license_results_edit6} " /> 	 
	
  </h:column>
</h:panelGrid>
