<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html xmlns:v="urn:schemas-microsoft-com:vml" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns="http://www.w3.org/TR/REC-html40">
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="description" content="ETUDES-NG Course Management System, Powered by Sakai">
<meta name="keywords" content="ETUDES-NG course management system, e-learning">
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>




<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>

<!-- End code to put in head section for image pre-loading. -->
<script language="javascript1.2">
function changestatusmessage()
{
	defaultStatus="Done";
}
</script>

<title>Melete - Add Section Confirmation</title>
</head>
<f:view>
<body marginwidth="0" marginheight="0" topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" onLoad="changestatusmessage();setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');">
   <h:form id="AddSectionConfirmForm">
<table border="0" cellpadding="0" cellspacing="0" class ="table3">
	<tr>
		<td valign="top"> 

		</td>
      <!-- This Begins the Main Text Area -->
      <td width="100%" valign="top" >
       <table width="100%"  border="1" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA" style="border-collapse: collapse">
        <tr>
          <td width="100%" height="20" class="maintabledata1">
	          <!-- Begin code to display images horizontally. -->
				<f:subview id="top">
					<jsp:include page="topnavbar.jsp"/> 
				</f:subview>	
					<div class="meletePortletToolBarMessage"><img src="images/check.gif" alt="" width="16" height="16" align="absbottom" border="0"><h:outputText value="#{msgs.confirm_addmodulesection_confirming_section}" /></div>
</td>
        </tr>
              
        <tr>
          <td class="maintabledata3">
		
		  <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#EAEAEA" width="100%" id="AutoNumber1">
		  	<tr><td colspan="2" height="20" class="maintabledata5">&nbsp;</td></tr>
              <tr>
                <td width="100%" valign="top">
                  <br>
                  <table width="85%"  border="1" align="center" cellpadding="10" cellspacing="0" bordercolor="#CCCCCC">
                    <tr class="maintabledata3">
                      <td valign="top"><img src="images/right_check.gif" width="24" height="24" align="absbottom" alt="Confirmation Signal" border="0"></td>
                      <td align="left"><h:outputText value="#{msgs.confirm_addmodulesection_you_have_succes}" /><br>
                        <br> <h:outputText value="#{addSectionPage.section.title}" styleClass="bold" />                 
					  <p align="left"><h:outputText value="#{msgs.confirm_addmodulesection_you_may_continue}"/> <BR>
                      </p></td>
                    </tr>
                  </table><br></td>
              </tr>
			  					              <tr>
                <td height="30" colspan="2">         
                <div align="center">				
									
				<h:commandLink id="preview"  action="#{addSectionPage.previewFromAdd}">
					<h:graphicImage id="editModImg" value="#{msgs.im_view_section}" height="19" styleClass="BottomImgSpace" 
						onmouseover="this.src = '#{msgs.im_view_section_over}'" 
						onmouseout="this.src = '#{msgs.im_view_section}'" 
						onmousedown="this.src = '#{msgs.im_view_section_down}'" 
						onmouseup="this.src = '#{msgs.im_view_section_over}'"/>
    		 </h:commandLink>
           
		
				<h:commandLink id="saveAddAnotherbutton"  action="#{addSectionPage.saveAndAddAnotherSection}">
						<h:graphicImage id="saveAddAnotherImg" value="#{msgs.im_add_another_section}" height="19" styleClass="BottomImgSpace" 
							onmouseover="this.src = '#{msgs.im_add_another_section_over}'" 
							onmouseout="this.src = '#{msgs.im_add_another_section}'" 
							onmousedown="this.src = '#{msgs.im_add_another_section_down}'" 
							onmouseup="this.src = '#{msgs.im_add_another_section_over}'"/>
	                </h:commandLink>				
					
				<h:commandLink id="FinishButton"  action="list_auth_modules">
						<h:graphicImage id="finishImg" value="#{msgs.im_finish}" height="19" styleClass="BottomImgSpace"
							onmouseover="this.src = '#{msgs.im_finish_over}'" 
							onmouseout="this.src = '#{msgs.im_finish}'" 
							onmousedown="this.src = '#{msgs.im_finish_down}'" 
							onmouseup="this.src = '#{msgs.im_finish_over}'" />
	                </h:commandLink>				
</div></td>
              </tr>
			 <tr><td colspan="2" height="20" class="maintabledata5">&nbsp;</td></tr>
            </table>
          </td>
        </tr>
      </table>   
	   </h:form>      
      <p>&nbsp;</p>

</td>
  </tr>
</table>
  <!-- This Ends the Main Text Area -->
 
</body>
</f:view>
</html>