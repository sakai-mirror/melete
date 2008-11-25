<%@ page import="org.sakaiproject.tool.melete.PrintModulePage,javax.faces.application.FacesMessage, java.util.ResourceBundle"%>
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
<html>
<head>
<link rel="stylesheet" href="rtbc004.css" type="text/css" media="all" >
<link href="/library/skin/tool_base.css" type="text/css" rel="stylesheet" media="all" />
<link href="/library/skin/default/tool.css" type="text/css" rel="stylesheet" media="all" />
<title>Melete - Print Module</title>
</head>
<body>
<form id="printModuleForm" >
     <table width="100%" border="1" align="center" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA"  style="border-collapse: collapse">
          <tr>
            <td width="100%" height="20" >	
            	<%
				final javax.faces.context.FacesContext facesContext = javax.faces.context.FacesContext.getCurrentInstance();
				final org.sakaiproject.util.ResourceLoader msg = (org.sakaiproject.util.ResourceLoader)facesContext.getApplication().getVariableResolver().resolveVariable(facesContext, "msgs");
				String printMsg = msg.getString("print_module_msg");
%>			
				<div class="meletePortletToolBarMessage"><img src="images/printer.png" alt="" width="16" height="16" align="absmiddle" onclick="javascript:window.print()"> <a href="#" onclick="javascript:window.print()"><%=printMsg%></a> </div>
		</td></tr>

		<tr><td colspan="2" height="20" class="maintabledata5">&nbsp;</td></tr>	
		  <tr><td>
			<%
final PrintModulePage printModulePage = (PrintModulePage)facesContext.getApplication().getVariableResolver().resolveVariable(facesContext, "printModulePage");
String selected_module_id = (String)request.getParameter("printModuleId");

if(selected_module_id != null)
	{
	printModulePage.processModule(new Integer(selected_module_id));
	out.println(printModulePage.getPrintText());	
	}	
%> 
		</td></tr>		 
	</table>
</form>
</body>
</html>