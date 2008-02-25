<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<h:panelGrid id="navWhatsNextItems" columns="5"  style=" border-width:medium; border-color: #E2E4E8">
	<h:column>
     	<h:commandLink id="prevItem" action="#{viewNextStepsPage.goPrevItem}" immediate="true">
			<h:outputText id="prevItemMsg"  value="#{msgs.view_navigate_ws_prev}"/>	
			 <f:param name="prevmodid" value="#{viewNextStepsPage.prevModId}" />
			 <f:param name="prevsecid" value="#{viewNextStepsPage.prevSecId}" />
     	</h:commandLink>
	</h:column>
		<h:column>
				<h:outputText id="seperatorMsg1" value=" | "/>	
		</h:column>
	<h:column>
	<h:commandLink id="TOCitem" action="#{viewNextStepsPage.goTOC}" immediate="true">
				  <h:outputText  id="TOCMsg" value="#{msgs.view_navigate_ws_TOC}"/>
			</h:commandLink>  
	</h:column>
			<h:column>
				<h:outputText id="seperatorMsg2" value=" | "/>	
		</h:column>
	<h:column>
     <h:commandLink id="nextMod" action="#{viewNextStepsPage.goNextModule}" immediate="true" rendered="#{viewNextStepsPage.moduleSeqNo < viewNextStepsPage.nextSeqNo}">
			<h:outputText  id="nextItemMsg" value="#{msgs.view_navigate_ws_next}"/>	
			 <f:param name="modseqno" value="#{viewNextStepsPage.nextSeqNo}" />
     	</h:commandLink>
   
	</h:column>
</h:panelGrid>	