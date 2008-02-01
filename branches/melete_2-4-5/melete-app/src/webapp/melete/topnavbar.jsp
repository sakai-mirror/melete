<%@ page import="org.sakaiproject.tool.melete.MeleteSiteAndUserInfo"%>
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>

<%
final javax.faces.context.FacesContext facesContext = javax.faces.context.FacesContext.getCurrentInstance();

final MeleteSiteAndUserInfo meleteSiteAndUserInfo = (MeleteSiteAndUserInfo)facesContext.getApplication().getVariableResolver().resolveVariable(facesContext, "meleteSiteAndUserInfo");
 meleteSiteAndUserInfo.populateMeleteSession();
%>
<link href="rtbc004.css" type="text/css" rel="stylesheet" media="all" />

<sakai:view_container>
<sakai:view_content>

<sakai:tool_bar id="topbar">
<sakai:tool_bar_item id="viewItem" action="#{navPage.viewAction}" value="#{msgs.topnavbar_view}"  immediate="true"/>
<sakai:tool_bar_item id="authorItem" action="#{navPage.authAction}" value="#{msgs.topnavbar_author}" immediate="true"/>
<sakai:tool_bar_item id="manageItem" action="#{navPage.manageAction}" value="#{msgs.topnavbar_manage}"  immediate="true"/>
<sakai:tool_bar_item id="prefItem" action="#{navPage.PreferenceAction}" value="#{msgs.topnavbar_preferences}"   immediate="true"/>
</sakai:tool_bar>
<!-- End code to display images horizontally. -->

</sakai:view_content>
</sakai:view_container>
</html>
