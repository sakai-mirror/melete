<%@ page import="org.etudes.tool.melete.MeleteSiteAndUserInfo"%>
<%
final javax.faces.context.FacesContext accFacesContext = javax.faces.context.FacesContext.getCurrentInstance();
final MeleteSiteAndUserInfo accMeleteSiteAndUserInfo = (MeleteSiteAndUserInfo)accFacesContext.getApplication().getVariableResolver().resolveVariable(accFacesContext, "meleteSiteAndUserInfo");

boolean rightsCheck = accMeleteSiteAndUserInfo.checkMeleteRights();
if (rightsCheck == false)
{
   response.sendError(401,"You are not authorized to view this page");
}   
%>