<%@ page import="org.sakaiproject.tool.melete.MeleteSiteAndUserInfo,java.util.Iterator,javax.faces.application.FacesMessage"%>
<html>
<head>
<title>Melete</title>
</head>
<body>
<%
System.out.println("MELETE MAIN PAGE CALLED!!!!");
out.println("MELETE MAIN PAGE CALLED!!!!");
final javax.faces.context.FacesContext facesContext = javax.faces.context.FacesContext.getCurrentInstance();

final MeleteSiteAndUserInfo meleteSiteAndUserInfo = (MeleteSiteAndUserInfo)facesContext.getApplication().getVariableResolver().resolveVariable(facesContext, "meleteSiteAndUserInfo");
String navpage = meleteSiteAndUserInfo.processNavigate();

System.out.println("navpage is "+navpage);
String navpageurl = navpage +".jsf";
Iterator it = facesContext.getMessages();

if (it != null)
{

 while (it.hasNext())
  {
   FacesMessage fm = (FacesMessage)it.next();
    request.setAttribute("msg",fm.getDetail());
 }
}
else
{
  System.out.println("Returned iterator is null");
}			
%>
<br />
<jsp:forward page="<%=navpageurl%>"/>
</body>
</html> 
