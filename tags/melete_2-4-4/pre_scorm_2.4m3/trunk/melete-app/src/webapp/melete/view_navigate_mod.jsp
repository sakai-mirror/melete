<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<h:panelGrid columns="5"  style=" border-width:medium; border-color: #E2E4E8">
	<h:column>
     	<h:commandLink id="prevItem" action="#{viewModulesPage.goPrevSection}" immediate="true" rendered="#{((viewModulesPage.prevMdbean != viewModulesPage.nullMdbean)&&((viewModulesPage.prevMdbean.module.whatsNext == viewModulesPage.nullString)||(viewModulesPage.prevMdbean.module.whatsNext == viewModulesPage.emptyString))&&(viewModulesPage.moduleSeqNo > 1)&&(viewModulesPage.prevSectionSize > 0))}">
			<h:outputText  value="#{msgs.view_navigate_mod_prev}"/>	
     	</h:commandLink>
     	<h:commandLink id="goPrevWhatsNext" action="#{viewModulesPage.goPrevWhatsNext}" immediate="true" rendered="#{((viewModulesPage.prevMdbean != viewModulesPage.nullMdbean)&&(viewModulesPage.prevMdbean.module.whatsNext != viewModulesPage.nullString)&&(viewModulesPage.prevMdbean.module.whatsNext != viewModulesPage.emptyString)&&(viewModulesPage.moduleSeqNo > 1))}">
			<h:outputText  value="#{msgs.view_navigate_mod_prev2}"/>	
     	</h:commandLink>
     	<h:commandLink id="prevMod" action="#{viewModulesPage.goPrevNext}" immediate="true" rendered="#{((viewModulesPage.prevMdbean != viewModulesPage.nullMdbean)&&((viewModulesPage.prevMdbean.module.whatsNext == viewModulesPage.nullString)||(viewModulesPage.prevMdbean.module.whatsNext == viewModulesPage.emptyString))&&(viewModulesPage.moduleSeqNo > 1)&&(viewModulesPage.prevSectionSize == 0))}">
			<h:outputText  value="#{msgs.view_navigate_mod_prev3}"/>	
			 <f:param name="modseqno" value="#{viewModulesPage.prevSeqNo}" />
     	</h:commandLink>
	</h:column>
		<h:column>
				<h:outputText value=" | "/>	
		</h:column>
	<h:column>
	<h:commandLink id="TOCitem" action="#{viewModulesPage.goTOC}" immediate="true">
				  <h:outputText  value="#{msgs.view_navigate_mod_TOC}"/>
			</h:commandLink>  
	</h:column>
			<h:column>
				<h:outputText value=" | "/>	
		</h:column>
	<h:column>
		<h:commandLink id="nextItem" action="#{viewModulesPage.goNextSection}" immediate="true" rendered="#{(viewModulesPage.sectionSize > 0)}">
		  <h:outputText  value="#{msgs.view_navigate_mod_next}"></h:outputText>
     </h:commandLink>
      <h:commandLink id="whatsNext" action="#{viewModulesPage.goWhatsNext}" immediate="true" rendered="#{((viewModulesPage.mdbean.module.whatsNext != viewModulesPage.nullString)&&(viewModulesPage.mdbean.module.whatsNext != viewModulesPage.emptyString)&&(viewModulesPage.sectionSize == 0))}">
		  <h:outputText  value="#{msgs.view_navigate_mod_next2}"></h:outputText>
		   <f:param name="modseqno" value="#{viewModulesPage.moduleSeqNo}" />
     </h:commandLink>   
     <h:commandLink id="nextMod" action="#{viewModulesPage.goPrevNext}" immediate="true" rendered="#{(((viewModulesPage.mdbean.module.whatsNext == viewModulesPage.nullString)||(viewModulesPage.mdbean.module.whatsNext == viewModulesPage.emptyString))&&(viewModulesPage.sectionSize == 0)&&(viewModulesPage.moduleSeqNo < viewModulesPage.nextSeqNo))}">
			<h:outputText  value="#{msgs.view_navigate_mod_next3}"/>	
			 <f:param name="modseqno" value="#{viewModulesPage.nextSeqNo}" />
     	</h:commandLink>
   
	</h:column>
</h:panelGrid>