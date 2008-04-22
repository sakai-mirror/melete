<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
  <h:panelGrid id="LinkPanel2" columns="2" width="80%" columnClasses="col30,col50" border="0">
   	<h:column><h:outputText id="linkText1" value="#{msgs.contentlinkview_link}"/>
   	<h:outputText id="extraspacesUpload0" value="" styleClass="ExtraPaddingClass" />
			 <h:outputLink id="showResourceLink" value="#{addSectionPage.currLinkUrl}" target="_blank" title="Section Resource" styleClass="a1" rendered="#{addSectionPage.displayCurrLink != null}">	  
				<h:outputText id="editlinkText3" value="#{addSectionPage.displayCurrLink}" />
  			 </h:outputLink>
			 <h:outputText id="linkText2" value="#{msgs.contentlinkview_nofile}" rendered="#{addSectionPage.displayCurrLink == null}" styleClass="bold"/>	
			 <h:outputText id="extraspacesUpload1" value="" styleClass="ExtraPaddingClass" />
			  <h:outputText id="extraspacesUpload2" value="" styleClass="ExtraPaddingClass" />
	</h:column>
	<h:column>		  
			   <h:commandLink id="serverViewButton"  action="#{addSectionPage.gotoServerLinkView}" >
					<h:graphicImage id="replaceImg2" value="images/replace2.gif" styleClass="AuthImgClass"/>
					<h:outputText value="#{msgs.contentuploadview_select}" />
             </h:commandLink>	
	</h:column>
	<h:column/>
   <h:column>     
             <h:selectBooleanCheckbox id="windowopen" title="openWindow" value="#{addSectionPage.section.openWindow}" >
		  </h:selectBooleanCheckbox>
		  <h:outputText id="editlinkText_8" value="#{msgs.editcontentlinkserverview_openwindow}" />
        </h:column>        
</h:panelGrid>
