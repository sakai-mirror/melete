<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>

<h:panelGrid columns="7" columnClasses="menu MainTableClass" cellspacing="5" style=" border-width:medium; border-color: #E2E4E8" width="570">
<h:column>
<h:graphicImage id="addModuleImg" value="images/document_add.gif" styleClass="AuthImgClass"/>
	<h:commandLink id="addAction" action="#{listAuthModulesPage.AddModuleAction}" immediate="true">
  		<h:outputText  value="#{msgs.authnavbar_add_module}"/>
	</h:commandLink>
</h:column>
<h:column>
<h:graphicImage id="addContentImg" value="images/document_add.gif" styleClass="AuthImgClass"/>
	<h:commandLink id="addContAction" action="#{listAuthModulesPage.AddContentAction}">
  		<h:outputText  value="#{msgs.authnavbar_add_content}"/>
	</h:commandLink>
</h:column>
<h:column>
<h:graphicImage id="editModImg" value="images/document_edit.gif" styleClass="AuthImgClass" />
<h:commandLink id="editAction" action="#{listAuthModulesPage.editAction}">
  <h:outputText  value="#{msgs.authnavbar_edit}"/>
</h:commandLink>    
</h:column>
<h:column>
	<h:graphicImage id="indentLeftImg" value="images/indent_left.png" styleClass="AuthImgClass"/>
  <h:commandLink id="BringUpSubSectionAction" action="#{listAuthModulesPage.BringSubSectionLevelUpAction}">
  	<h:outputText  value="#{msgs.authnavbar_left}"/>
  </h:commandLink>
</h:column>
<h:column>
	<h:graphicImage id="indentRightImg" value="images/indent_right.png" styleClass="AuthImgClass"/>
  <h:commandLink id="CreateSubSectionAction" action="#{listAuthModulesPage.CreateSubSectionAction}">
  	<h:outputText  value="#{msgs.authnavbar_right}"/>
  </h:commandLink>
</h:column>
<!--h:column-->
   <!--h:commandLink id="MoveUpAction" action="#{listAuthModulesPage.MoveItemUpAction}"-->
		<!--h:graphicImage id="MoveUpImg" value="images/sort_up.png" styleClass="AuthImgClass"/-->
  <!--/h:commandLink-->
   <!--h:commandLink id="MoveDownAction" action="#{listAuthModulesPage.MoveItemDownAction}"-->
		<!--h:graphicImage id="MoveDownImg" value="images/sort_down.png" styleClass="AuthImgClass"/-->
  <!--/h:commandLink-->
    	<!--h:outputLabel value="#{msgs.authnavbar_sort}" /-->
<!--/h:column-->
<h:column>
	<h:graphicImage id="deleteImg" value="images/delete.gif" styleClass="AuthImgClass"/>
	<h:commandLink id="delAction" action="#{listAuthModulesPage.deleteAction}">
        <h:outputText  id="del" value="#{msgs.authnavbar_delete}"></h:outputText>
     </h:commandLink>
	</h:column>
<h:column>
	<h:graphicImage id="inactiveImg" value="images/folder_out.gif" styleClass="AuthImgClass"/>
  <h:commandLink id="inactiveAction" action="#{listAuthModulesPage.InactivateAction}">
  	<h:outputText  value="#{msgs.authnavbar_make_inactive}"/>
  </h:commandLink>
</h:column>
</h:panelGrid>
<!-- End code to display images horizontally. -->
