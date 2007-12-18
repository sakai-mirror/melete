<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>
<html">
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="description" content="ETUDES-NG Course Management System, Powered by Sakai">
<meta name="keywords" content="ETUDES-NG course management system, e-learning">


<title>Melete - User Preference</title>
<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
</head>

<f:view>
<body marginwidth="0" marginheight="0" topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" onload="setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');" >
 <h:form id="UserPreferenceForm">
<table>
	<tr>
		<td valign="top"></td>
    	<td width="1962" valign="top">
        	<table width="100%"  border="1" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA"  style="border-collapse: collapse">
          		<tr>
            		<td width="100%" height="20" bordercolor="#E2E4E8">
					<!-- top nav bar -->
						<f:subview id="top">
								<jsp:include page="topnavbar.jsp"/> 
						</f:subview>
		  <div class="meletePortletToolBarMessage"><img src="images/user1_preferences.gif" width="16" height="16" align="absbottom" border="0"><h:outputText value="#{msgs.author_preference_user_preference}" /></div>				
				</td>
        </tr>
        <tr>
          <td class="maintabledata3" valign="top">
          	<h:messages showDetail="true" showSummary="false" infoClass="BlueClass" errorClass="RedClass"/>
		  <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#EAEAEA" width="100%" id="AutoNumber1">
		  	<tr><td  height="20" class="maintabledata5" ><h:outputText id="t1" value="#{msgs.author_preference_editor_select}" rendered="#{navPage.shouldRenderPreferences}" styleClass="tableheader2"/>          </td></tr>
              <tr>
                <td>
						<table border="0" cellpadding="0" cellspacing="0" width="100%">
						<tr>
					<td>
							<h:selectOneRadio value="#{authorPreferences.userEditor}" rendered="#{navPage.shouldRenderPreferences}" layout="pageDirection">
										<f:selectItems value="#{authorPreferences.availableEditors}" />
								</h:selectOneRadio>	
					</td>	
					</tr>		
					</table></td></tr>		
			<tr><td  height="20" class="maintabledata5" ><h:outputText id="t2" value="#{msgs.author_preference_view_select}"  styleClass="tableheader2"/>          </td></tr>
              <tr>
                <td>
						<table border="0" cellpadding="0" cellspacing="0" width="100%">
						<tr>
					<td>
							<h:selectOneRadio value="#{authorPreferences.userView}" layout="pageDirection">
										<f:selectItem itemLabel="Expanded" itemValue="true" />
										<f:selectItem itemLabel="Collapsed" itemValue="false"/>
								</h:selectOneRadio>	
					</td>	
					</tr>		
					</table></td></tr>								
              <tr>
                <td height="30" >         
                <div align="center">				
				<h:commandLink id="SetButton"  action="#{authorPreferences.setUserChoice}">
					<h:graphicImage id="setImg" value="#{msgs.im_set}" styleClass="BottomImgSpace"
						onmouseover="this.src = '#{msgs.im_set_over}'" 
						onmouseout="this.src = '#{msgs.im_set}'" 
						onmousedown="this.src = '#{msgs.im_set_down}'" 
						onmouseup="this.src = '#{msgs.im_set_over}'"/>
                </h:commandLink>	
			</div></td>
              </tr>
			 <tr><td  height="20" class="maintabledata5">&nbsp;</td></tr>
            </table>
          </td>
        </tr>
      </table>
	</h:form>
        <p><a href="#top" class="style3"><h:outputText value="#{msgs.author_preference_back_to_top}" /></a></p>
</td>
  </tr>
</table>
</td></tr></table>
  <!-- This Ends the Main Text Area -->
</body>
</f:view>
</html>
