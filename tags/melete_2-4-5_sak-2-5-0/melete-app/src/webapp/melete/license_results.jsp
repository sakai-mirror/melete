<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<h:panelGrid id="cclicensetable" columns="1" rendered="#{!addModulePage.copyright}" >
	<h:column>
 <h:outputText value="#{msgs.license_results_1}" /> 
  <h:outputLink value="#{addModulePage.agreeResultUrl}" target="_blank"> 
	 <f:verbatim></f:verbatim>
	 <h:outputText value="#{addModulePage.agreeResult}" />
	 </h:outputLink>
	 <h:outputText value="#{msgs.license_results_2}" /> 
  </h:column>
</h:panelGrid>

<h:panelGrid id="cclicenseresultstable" columns="1" rendered="#{addModulePage.copyright &&  !addModulePage.fairuse}" >
	<h:column>
		 <h:outputText value="#{msgs.license_results_3} " /> 
		 <h:outputText value="#{addModulePage.agreeResultUrl}" styleClass="italics"/>
	 	  <h:outputText value="#{msgs.license_results_4}"/> 
  </h:column>
</h:panelGrid>

<h:panelGrid id="cclicenseresultstable1" columns="1" rendered="#{addModulePage.fairuse}" >
	<h:column>
		 <h:outputText value="#{msgs.license_results_5}" /> 
	
  </h:column>
</h:panelGrid>