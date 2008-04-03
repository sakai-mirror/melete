<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<<%@ page import="org.sakaiproject.tool.melete.MeleteSiteAndUserInfo"%>
<%
final javax.faces.context.FacesContext facesContext = javax.faces.context.FacesContext.getCurrentInstance();

final MeleteSiteAndUserInfo meleteSiteAndUserInfo = (MeleteSiteAndUserInfo)facesContext.getApplication().getVariableResolver().resolveVariable(facesContext, "meleteSiteAndUserInfo");
String browseloca = meleteSiteAndUserInfo.getRemoteBrowseLocation() ;
%>
<body marginwidth="0" marginheight="0" topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0">

<f:view>
<h:form id="commonform">
<table border="0" width="100%">
<tr bgcolor="#CCCCCC">
<td>	<h:outputText id="cc2" value="#{msgs.commonfilebrowser_common_files}"></h:outputText> &raquo; 
	<a href="<%=browseloca%>">
				<h:outputText id="cc" value="#{msgs.commonfilebrowser_uploaded_files}"></h:outputText>
	</a>
</td>
</tr>
<tr><td>
	<h:dataTable id="table1"  value="#{remoteBrowserFile.remoteCommonFiles}" var="rbf" width="100%">
		<h:column>
            <h:commandButton id="head1" value="#{rbf.fileName}" ></h:commandButton>
		</h:column>
		<h:column>
           <h:outputText id="head2" value="#{rbf.size}" ></h:outputText>
		</h:column>
		<h:column>
           <h:outputText id="head3" value="#{rbf.modifiedDate}" ></h:outputText>
		</h:column>
	</h:dataTable>
	</td></tr>
</table>	
</h:form>
</f:view>
