<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>

<h:panelGrid id="LinkPanel" columns="2" columnClasses="col30,col50" width="80%" border="0">
  <h:column>
  	<h:outputText id="editlinkText1" value="#{msgs.editcontentlinkview_link1}"/>
	<h:outputText id="somespaces_1" value="   " styleClass="ExtraPaddingClass" />		
    <h:outputLink id="showResourceLink" value="#{editSectionPage.currLinkUrl}" target="_blank" title="Section Resource" styleClass="a1" rendered="#{editSectionPage.displayCurrLink != null}">	  
  		<h:outputText id="editlinkText3" value="#{editSectionPage.displayCurrLink}" />
  	</h:outputLink>	
		<h:outputText id="editlinkText4" value="#{msgs.editcontentlinkview_noURL}" rendered="#{editSectionPage.displayCurrLink == null}" styleClass="bold"/>
		<h:outputText id="somespaces1" value=" " styleClass="ExtraPaddingClass" />
	</h:column>
	<h:column>					
			<h:commandLink id="serverViewButton"  action="#{editSectionPage.gotoServerLinkView}" styleClass="a1">
				<h:graphicImage id="replaceImg2" value="images/replace2.gif" styleClass="AuthImgClass"/>
					<h:outputText value="#{msgs.editcontentlinkview_replace}"/>
                </h:commandLink>		
  </h:column>
  <h:column/>
   <h:column>     	
             <h:selectBooleanCheckbox id="windowopen" title="openWindow" value="#{editSectionPage.section.openWindow}" >
		  </h:selectBooleanCheckbox>
		  <h:outputText id="editlinkText_8" value="#{msgs.editcontentlinkserverview_openwindow}" />
        </h:column>   				  
</h:panelGrid>	

	


