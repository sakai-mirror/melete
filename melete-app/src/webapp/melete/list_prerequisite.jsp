<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="org.etudes.tool.melete.PrintModulePage,javax.faces.application.FacesMessage, java.util.ResourceBundle"%>
<!--
 ***********************************************************************************
 * $URL: https://source.sakaiproject.org/contrib/etudes/melete/branches/Mel2.8.1_CM/melete-app/src/webapp/melete/print_module.jsp $
 * $Id: print_module.jsp 72457 2011-02-01 19:52:16Z rashmi@etudes.org $  
 ***********************************************************************************
 *
 * Copyright (c) 2011 Etudes, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * permissions and limitations under the License.
 *
 **********************************************************************************
-->
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>

<f:view>
<sakai:view title="Modules: Prerequisite" toolCssHref="/etudes-melete-tool/rtbc004.css">
<%@include file="meleterightscheck.jsp" %>
<form id="prerequisiteForm" >
     <table width="100%" class="maintabledata2" cellspacing="4" cellpadding="4">
          <tr>
            <td width="100%" height="20" text-align="center">	
            	<%
				final javax.faces.context.FacesContext facesContext = javax.faces.context.FacesContext.getCurrentInstance();
				final org.sakaiproject.util.ResourceLoader msg = (org.sakaiproject.util.ResourceLoader)facesContext.getApplication().getVariableResolver().resolveVariable(facesContext, "msgs");
				String prereqMsg = msg.getString("prerequisite_msg");
				String okMsg = msg.getString("prerequisite_ok_msg");
				String blockMsg = (String)request.getParameter("blockMsg");
				%>			
				<p> <%=prereqMsg%>
					<ul>
					<li> <%=blockMsg%> </li>
					</ul>	
				</p>				
		</td></tr>
		<tr><td>
			<input type="button" onClick="window.close();" value="<%=okMsg%>" class="BottomImgFinish"/>
		</td></tr>	
		<tr><td>
			&nbsp;
		</td></tr>			 
	</table>
</form>
</sakai:view>
</f:view>