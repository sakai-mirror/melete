<%@ page import="org.sakaiproject.tool.melete.PrintModulePage,javax.faces.application.FacesMessage, java.util.ResourceBundle"%>
<html>
<link rel="stylesheet" href="rtbc004.css" type="text/css" media="all">
<link href="/library/skin/tool_base.css" type="text/css" rel="stylesheet" media="all" />
<link href="/library/skin/default/tool.css" type="text/css" rel="stylesheet" media="all" />
<title>Melete - Print Module</title>
<body">
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