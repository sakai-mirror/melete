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

