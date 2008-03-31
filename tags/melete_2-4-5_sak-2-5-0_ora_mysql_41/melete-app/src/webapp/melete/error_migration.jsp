<html>
<head>
<link rel="stylesheet" href="rtbc004.css" type="text/css">

<title>Melete - Modules: Migration Error</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>
<%
/*The following piece of java code needs to stay above the loadBundle tag, otherwise the request attribute gets replaced by msg*/

String msg = null;
if (request.getAttribute("msg") != null)
{	
  msg = (String) request.getAttribute("msg");	
}  
%>


<%@ page import="javax.faces.application.FacesMessage, java.util.ResourceBundle, java.util.Iterator, java.lang.String"%>
<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>

</head>
<f:view>

<body onload="setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');" >
<h:form id="errormigrate">
<%
if (msg != null)
{	
  final javax.faces.context.FacesContext facesContext = javax.faces.context.FacesContext.getCurrentInstance();
  FacesMessage facesMsg = new FacesMessage(null, msg);
  facesMsg.setSeverity(FacesMessage.SEVERITY_ERROR);
  facesContext.addMessage(null, facesMsg);		
}  
%>
<table border="0" height="350" cellpadding="0" cellspacing="0" class ="table3">
<tr>
		<td valign="top"> &nbsp;</td>
		<td width="1962"  valign="top">
			<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolor="#EAEAEA" style="border-collapse: collapse">
				<tr>
					<td>
					<BR>
					 <h:messages id="migrationerror" layout="table" showDetail="true" showSummary="false" infoClass="BlueClass" errorClass="RedClass"/>
  		         </td>
			   </tr>
			</table>   
</td>
</tr>
</table>
</h:form>
</body>

</f:view>
</html>

 

 
