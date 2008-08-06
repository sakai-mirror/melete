<%@ page import="org.sakaiproject.tool.melete.AddResourcesPage,javax.faces.application.FacesMessage, java.util.ResourceBundle"%>
<% 
	final javax.faces.context.FacesContext facesContext = javax.faces.context.FacesContext.getCurrentInstance();
	final org.sakaiproject.util.ResourceLoader msg = (org.sakaiproject.util.ResourceLoader)facesContext.getApplication().getVariableResolver().resolveVariable(facesContext, "msgs");
	String badFileMsg = msg.getString("img_bad_filename");	
	final AddResourcesPage addPage = (AddResourcesPage)facesContext.getApplication().getVariableResolver().resolveVariable(facesContext, "addResourcesPage");
	String up_field = request.getParameter("up_field");	
	    	
   if(!addPage.validateFile(up_field))
	  	  	{
	  	  	  response.getWriter().write(badFileMsg);
	  	  	}		  		
%>