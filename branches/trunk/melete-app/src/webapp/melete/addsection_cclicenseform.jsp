<!--  Copyright (c) 2008 Etudes, Inc. -->
 
<!--  Licensed under the Apache License, Version 2.0 (the "License"); -->
<!--   you may not use this file except in compliance with the License.-->
<!--   You may obtain a copy of the License at -->
  
<!--   http://www.apache.org/licenses/LICENSE-2.0 -->
  
<!--   Portions completed before September 1, 2008 Copyright (c) 2004, 2005, 2006, 2007, 2008 Foothill College, ETUDES Project -->
  
<!--   Licensed under the Apache License, Version 2.0 (the "License"); you -->
<!--   may not use this file except in compliance with the License. You may -->
<!--   obtain a copy of the License at -->
  
<!--   http://www.apache.org/licenses/LICENSE-2.0 -->
<!--  Unless required by applicable law or agreed to in writing, software -->
<!--  distributed under the License is distributed on an "AS IS" BASIS, -->
<!--  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or -->
<!--  implied. See the License for the specific language governing -->
<!--  permissions and limitations under the License. -->
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<h:panelGrid id="cclicensetable1" columns="1" columnClasses="maintabledata8" width="100%"  rendered="#{addSectionPage.m_license.shouldRenderCC}">
	<h:outputText value="#{msgs.add_section_cclicense}" />
</h:panelGrid>
	<h:panelGrid id="cclicensetable2" columns="1" width="100%" rendered="#{addSectionPage.m_license.shouldRenderCC}">
	<h:column>
		 <h:outputText value="#{msgs.add_section_cclicense_form_msg1}" />
	 </h:column>
	 <h:column><h:outputText value=""/></h:column>
	 <h:column>
	 	<h:panelGrid id="licenseoptions" columns="2" width="97%" cellpadding="5" cellspacing="5" border="0"> 
		 <h:column>
				  <h:outputText value="#{msgs.add_section_cclicense_form_allow_commercial}"/>
		</h:column>			
		<h:column>  
                  <h:message style="color: red" for="allowCmrcl"/>
				  <h:selectOneRadio id="allowCmrcl" value="#{addSectionPage.m_license.allowCmrcl}">
				  	<f:selectItem itemValue="true" itemLabel="#{msgs.add_section_cclicense_form_allowmod2}"/>
					<f:selectItem  itemValue="false" itemLabel="#{msgs.add_section_cclicense_form_allowmod0}"/>
				  </h:selectOneRadio>
		</h:column>			
		<h:column>  
				   <h:outputText value="#{msgs.add_section_cclicense_form_allow_modification}"/>
    	 </h:column>
		 <h:column>          
				  	<h:message style="color: red" for="allowMod"/>
				    <h:selectOneRadio id="allowMod" value="#{addSectionPage.m_license.allowMod}">
				  	<f:selectItem itemValue="2" itemLabel="#{msgs.add_section_cclicense_form_allowmod2}"/>
					<f:selectItem itemValue="1" itemLabel="#{msgs.add_section_cclicense_form_allowmod1}"/>
					<f:selectItem itemValue="0" itemLabel="#{msgs.add_section_cclicense_form_allowmod0}"/>
				  </h:selectOneRadio>
    	</h:column>
    	<h:column>
		 <h:outputText value="#{msgs.add_section_cclicense_form_lic_holder}"/> 
	 </h:column>
	 <h:column>
			<h:inputText id="copy_owner" value="#{addSectionPage.m_license.copyright_owner}" size="45" styleClass="formtext" />
	 </h:column>
	 <h:column>
		 <h:outputText value="#{msgs.add_section_cclicense_form_lic_year}"/> 
	 </h:column>
	 	 <h:column>
			<h:inputText id="copy_year" value="#{addSectionPage.m_license.copyright_year}" size="45" styleClass="formtext" />
	 </h:column>
		</h:panelGrid>
		</h:column>		
		</h:panelGrid>
		
	<h:panelGrid id="copyrighttable1" columns="1" columnClasses="maintabledata8" width="100%" >
			 <h:outputText value="#{msgs.add_section_cclicense_form_copy_of_aut}" rendered="#{addSectionPage.m_license.shouldRenderCopyright}"/> 
			 <h:outputText value="#{msgs.add_section_cclicense_form_public}" rendered="#{addSectionPage.m_license.shouldRenderPublicDomain}"/> 
			  <h:outputText value="#{msgs.add_section_cclicense_form_fair}" rendered="#{addSectionPage.m_license.shouldRenderFairUse}"/> 
</h:panelGrid>			 
<h:panelGrid id="copyrighttable2" columns="1"  width="100%">
	<h:column>	  
           <h:outputText value="#{msgs.add_section_cclicense_form_msg2}"  rendered="#{addSectionPage.m_license.shouldRenderCopyright}"/>		 
            <h:outputText value="#{msgs.add_section_cclicense_form_msg3}" rendered="#{addSectionPage.m_license.shouldRenderPublicDomain}"/> 	
            <h:outputText value="#{msgs.add_section_cclicense_form_msg4}" rendered="#{addSectionPage.m_license.shouldRenderFairUse}"/> 	 
</h:column>
<h:column>	  
<h:panelGrid id="copyrightoptions" columns="2"  width="82%"  cellpadding="5" cellspacing="5" columnClasses="copyrightColumn1, copyrightColumn2" border="0" rendered="#{!addSectionPage.m_license.shouldRenderCC}">
	 		<h:column>
		 <h:outputText value="#{msgs.add_section_cclicense_form_lic_holder2}"/>  <h:outputText value="*" styleClass="required" rendered="#{addSectionPage.m_license.shouldRenderCopyright}"/>
	 </h:column>	  
	 	 <h:column>
			<h:inputText id="copy_owner1" value="#{addSectionPage.m_license.copyright_owner}" size="45" styleClass="formtext" />
	 </h:column>
	 <h:column>
		 <h:outputText value="#{msgs.add_section_cclicense_form_lic_year2}"/>  <h:outputText value="*" styleClass="required" rendered="#{addSectionPage.m_license.shouldRenderCopyright}"/>
	 </h:column>
	 <h:column>
			<h:inputText id="copy_year1" value="#{addSectionPage.m_license.copyright_year}" size="45" styleClass="formtext" />
	 </h:column>
</h:panelGrid>
</h:column>
</h:panelGrid>	