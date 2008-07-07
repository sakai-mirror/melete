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

<title>Melete - Add Module Confirmation</title>
</head>
<f:view>
<body marginwidth="0" marginheight="0" topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" onLoad="setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');">
 <h:form id="AddModuleConfirmForm">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class ="table3">
	<tr>
	  <!-- This Begins the Main Text Area -->
      <td width="100%" valign="top" >
       <table width="100%"  border="1" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA" style="border-collapse: collapse">
        <tr>
          <td width="100%" height="20" class="maintabledata1">
		    <!-- Begin code to display images horizontally. -->
				<f:subview id="top">
					<jsp:include page="topnavbar.jsp"/> 
				</f:subview>
				<div class="meletePortletToolBarMessage"><img src="images/check.gif" alt="" width="16" height="16" align="absbottom" border="0"> <h:outputText value="#{msgs.confirm_addmodule_confirming_module_addition}" /> </div>
				</td>
        </tr>
     
        <tr>
          <td class="maintabledata3">

		  <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#EAEAEA" width="100%" id="AutoNumber1">
		  	<tr><td  height="20" class="maintabledata5">&nbsp;</td></tr>
              <tr>
                <td width="100%" align="center">
                    <table width="85%"  border="1" align="center" cellpadding="15" cellspacing="0" bordercolor="#CCCCCC">
                    <tr class="maintabledata3">
                      <td valign="top"><img src="images/right_check.gif" width="24" height="24" align="absbottom" alt="#{msgs.confirm_addmodule_confirmation_signal}" border="0"></td>
                      <td align="left"><h:outputText value="#{msgs.confirm_addmodule_you_have_succes}" /><br>
                        <br><h:outputText value="#{addModulePage.module.title}" styleClass="bold"  />
                        <p align="left"><h:outputText value="#{msgs.confirm_addmodule_continue_adding}" /></p></td>
                    </tr>
                  </table><br></td>
              </tr>
			  					              <tr>
                <td height="30" >         
                <div align="center">				
				<h:commandLink id="sectionButton"  action="#{addModulePage.addContentSections}" rendered="#{addModulePage.success}">
					<h:graphicImage id="sectionsImg" value="#{msgs.im_add_content_sections}" styleClass="BottomImgSpace"
						onmouseover="this.src = '#{msgs.im_add_content_sections_over}'" 
						onmouseout="this.src = '#{msgs.im_add_content_sections}'" 
						onmousedown="this.src = '#{msgs.im_add_content_sections_down}'" 
						onmouseup="this.src = '#{msgs.im_add_content_sections_over}'"/>
                </h:commandLink>
		
			<h:commandLink id="returnButton"  action="#{addModulePage.backToModules}" >
					<h:graphicImage id="returnModImg" value="#{msgs.im_return_to_modules}"  styleClass="BottomImgSpace"
						onmouseover="this.src = '#{msgs.im_return_to_modules_over}'" 
						onmouseout="this.src = '#{msgs.im_return_to_modules}'" 
						onmousedown="this.src = '#{msgs.im_return_to_modules_down}'" 
	   				  	onmouseup="this.src = '#{msgs.im_return_to_modules_over}'"
					/>
                </h:commandLink>
			</div></td>
              </tr>
			 <tr><td  height="20" class="maintabledata5">&nbsp;</td></tr>
            </table>
          </td>
        </tr>
      </table>
	</h:form>

</td>
  </tr>
</table>
</td></tr></table>
  <!-- This Ends the Main Text Area -->
</body>
</f:view>
</html>
