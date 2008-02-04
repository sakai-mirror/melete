<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>

<%@ page import="org.sakaiproject.util.ResourceLoader"%>

<% 
	ResourceLoader bundle = new ResourceLoader("org.sakaiproject.tool.melete.bundle.Messages");
	String mensaje=bundle .getString("JS_date");
	
%>

<LINK href="rtbc004.css" type=text/css rel=stylesheet />
<title>Melete - Add Module</title>

<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
</head>
<script language="JavaScript" src="js/calendar2.js"></script>
<script language="javascript">
function newWindow(newContent){
  winContent = window.open(newContent, 'nextWin', 'right=0, top=20,width=750,height=600, toolbar=no,scrollbars=yes, resizable=no') }
function showSdateCal()
{
  var string2 = "AddModuleForm:startDate";
  //alert(string2);
  var string2val = document.getElementById(string2).value;
  var dt;
    if((null == string2val) || (string2val.length == 0)) dt = new Date();
  else dt = new Date(document.getElementById(string2).value);
  
   if (!isNaN(dt))
  { 
    var cal2 = new calendar2(document.getElementById(string2));
    cal2.popup();
    document.getElementById(string2).select();
  }
  else
  {
    alert('<%=mensaje%>');
     document.getElementById(string2).select();
  }
}
function showEdateCal()
{
  var string2 = "AddModuleForm:endDate";
  //alert(string2);
  // var dt = new Date(document.getElementById(string2).value);
  var string2val = document.getElementById(string2).value;
  var dt;
    if((null == string2val) || (string2val.length == 0)) dt = new Date();
  else dt = new Date(document.getElementById(string2).value);
  
   if (!isNaN(dt))
  { 
    var cal2 = new calendar2(document.getElementById(string2));
    cal2.popup();
    document.getElementById(string2).select();
  }
  else
  {
    alert('<%=mensaje%>');
     document.getElementById(string2).select();
  }
} 
</script>
<f:view>
<body onLoad="setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');">
<h:form id="AddModuleForm">
<table border="0" cellpadding="0" cellspacing="0" class ="table3">
	<tr>
		<td valign="top"> &nbsp;</td>
	<td width="1962"  valign="top">
        <table width="100%"  border="1" cellpadding="3" cellspacing="0" style="border-collapse: collapse" bordercolor="#EAEAEA">
          <tr>
			<td width="100%" height="20" class="maintabledata1"> 
					<f:subview id="top">
							<jsp:include page="topnavbar.jsp"/> 
						</f:subview>
						<div class="meletePortletToolBarMessage"><img src="images/document_add.gif" alt="" width="16" height="16" align="absbottom"><h:outputText value="#{msgs.add_module_adding_module}" /> </div>
				</td>
			</tr>
		<!--Page Content-->
	  <tr>
   		 <td height="20" class="maintabledata2"> <h:outputText value="#{msgs.add_module_define_properties}" /> 		 
		 </td>
	  </tr>  	
  <tr>  
    <td  class="maintabledata3">	
	<h:messages id="addmoduleerror" layout="table" showDetail="true" showSummary="false" infoClass="BlueClass" errorClass="RedClass"/>
	<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#EAEAEA" width="100%" id="AutoNumber1" height="57">
        <tr bgcolor="#FFFFFF">
          <td width="100%" height="35" valign="top">
		  	<table width="98%" border="0" align="center" cellpadding="4" cellspacing="0" class="table3">
			<tr> 
				<td>&nbsp;</td>
				<td> </td>
			</tr>
			   <tr>
                <td  align="left" valign="top"> <h:outputText value="#{msgs.add_module_module_title}" /> <span class="required">*</span></td>
                <td  align="left" valign="top">
					<h:inputText id="title" size="45" value="#{addModulePage.module.title}" required="true" styleClass="formtext" tabindex="1">
						<f:validateLength maximum="50" minimum="3" />										
					</h:inputText>
				</td>
              </tr>
			  <tr>
				<td>&nbsp;</td>
				<td> <h:message style="color: red" for="description"/></td>
			</tr>
              <tr>
                <td width="233" align="left" valign="top"><h:outputText value="#{msgs.add_module_descr_over_object}" /> </td>
                <td width="472" align="left" valign="top">
				<h:inputTextarea id="description" cols="45" rows="5" value="#{addModulePage.module.description}" styleClass="formtext" tabindex="2">
					<f:validateLength maximum="500" minimum="1"/>
				</h:inputTextarea>	
				</td>
              </tr>
			   <tr>
				<td>&nbsp;</td>
				<td> <h:message style="color: red" for="keywords"/></td>
			</tr>
              <tr>
                <td align="left" valign="top"><h:outputText value="#{msgs.add_module_keywords}" />				
                 </td>
                <td align="left" valign="top">
				<h:inputTextarea id="keywords" cols="45" rows="3" value="#{addModulePage.module.keywords}"  styleClass="formtext" tabindex="3">
						<f:validateLength maximum="250" minimum="3" />
				</h:inputTextarea>		
				</td>
              </tr>
			  <tr>
			  <td colspan="2">&nbsp;</td>
			  </tr>
              <tr>
                <td width="233" align="left" valign="top"><h:outputText value="#{msgs.add_module_added_by}" /></td>
                <td width="472" align="left" valign="top">
				<h:outputText value="#{addModulePage.author}"  styleClass="formtext"/></td>
              </tr>
			  <tr>
			  <td colspan="2">&nbsp;</td>
			  </tr>
              <tr>
                <td align="left" valign="top"><h:outputText value="#{msgs.add_module_term_year}" /></td>
                <td align="left" valign="top">
					<h:outputText id="season" value="#{addModulePage.season}"/>				 
				   </td>
              </tr>
			   <tr>
				<td>&nbsp;</td>
				<td> <h:message style="color: red" for="startDate"/></td>
			</tr>
              <tr>
                <td width="233" align="left" valign="top"><h:outputText value="#{msgs.add_module_start_date}" />
				</td>
                <td width="472" align="left" valign="top">
					  <a name="startCalender"></a> <h:inputText id="startDate" 
                           value="#{addModulePage.startDate}" size="22" styleClass="formtext" tabindex="4">
		        	      <f:convertDateTime pattern="M/d/yyyy hh:mm a"/>
        		    </h:inputText>
		            <h:outputLink id="viewsdateCal" onclick="showSdateCal()" value="#startCalender" tabindex="5">
        	    		<h:graphicImage id="sdateCal"  value="images/date.png" styleClass="DatePickerClass"/>
           			</h:outputLink>
					 </td>
              </tr>
			   <tr>
				<td>&nbsp;</td>
				<td> <h:message style="color: red" for="endDate"/></td>
			</tr>
              <tr>
                <td width="233" align="left" valign="top"><h:outputText value="#{msgs.add_module_end_date}" /></td>
                <td width="472" align="left" valign="top">
				<a name="endCalender"></a><h:inputText id="endDate" 
                           value="#{addModulePage.endDate}" size="22" styleClass="formtext" tabindex="6">
             			  <f:convertDateTime pattern="M/d/yyyy hh:mm a"/>
          		 </h:inputText>
          <h:outputLink id="viewedateCal" onclick="showEdateCal()" value="#endCalender" tabindex="7">
            <h:graphicImage id="edateCal"  value="images/date.png" styleClass="DatePickerClass"/>
           </h:outputLink>
					 </td>
              </tr>			  
		 </table>
	</td>
  </tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr>
          <td height="20" align="center" colspan="2">
          <div align="center">
          		<h:commandLink id="submitsave"  action="#{addModulePage.save}"  tabindex="10">
					<h:graphicImage id="addImg" value="#{msgs.im_add_button}" styleClass="BottomImgSpace" 
						onmouseover="this.src = '#{msgs.im_add_button_over}'" 
						onmouseout="this.src = '#{msgs.im_add_button}'" 
						onmousedown="this.src = '#{msgs.im_add_button_down}'" 
						onmouseup="this.src = '#{msgs.im_add_button_over}'"/>
						
                </h:commandLink>
				
				
				<h:commandLink id="cancelButton" immediate="true" action="#{addModulePage.cancel}"  tabindex="11">
					<h:graphicImage id="cancelImg" value="#{msgs.im_cancel}" styleClass="BottomImgSpace"
						onmouseover="this.src = '#{msgs.im_cancel_over}'" 
						onmouseout="this.src = '#{msgs.im_cancel}'" 
						onmousedown="this.src = '#{msgs.im_cancel_down}'" 
						onmouseup="this.src = '#{msgs.im_cancel_over}'"/>
                </h:commandLink>
                </div>
        </td></tr>
		
</table>
	<!-- here -->
	</td>
	</tr>	
	</table>
	</h:form>
	</td>
    </tr>	
</table> 


</body>
</f:view>
</html>