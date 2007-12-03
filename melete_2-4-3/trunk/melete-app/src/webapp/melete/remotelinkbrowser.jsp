<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<body marginwidth="0" marginheight="0" topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0">
<f:view>
<h:form id="remotelinkform">
<table border="0" width="100%">
<tr><td>
	<h:dataTable id="table1"  value="#{remoteBrowserFile.remoteBrowserLinkFiles}" var="rbf" width="100%">
		<h:column>
            <h:commandButton id="head1" value="#{rbf.fileName}" ></h:commandButton>
		</h:column>
		<h:column>
           <h:outputText id="head2" value="#{rbf.size}" ></h:outputText>
		</h:column>	
	</h:dataTable>
	</td></tr>
</table>	
</h:form>
</f:view>
</body>

