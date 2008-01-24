<html>
<head>
<link rel="stylesheet" href="rtbc004.css" type="text/css">

<title>Melete - Modules: Author View</title>
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
<%@ page import="javax.faces.application.FacesMessage, java.util.Iterator, java.lang.String, org.sakaiproject.util.ResourceLoader"%>

<% 
	ResourceLoader bundle = new ResourceLoader("org.sakaiproject.tool.melete.bundle.Messages");
	String mensaje=bundle .getString("JS_date");
	
%>

<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
<script type="text/javascript" language="JavaScript" src="js/calendar2.js"></script>
<script type="text/javascript" language="javascript">

function showSdateCal(index)
{
  var string2 = "listauthmodulesform:table:"+index+":startDate";
  //alert(string2);
  //alert(document.getElementById(string2).value);
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
function showEdateCal(index)
{
  var string2 = "listauthmodulesform:table:"+index+":endDate";
  //alert(string2);
  // alert(document.getElementById(string2).value);
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

function OpenPrintWindow(windowURL,windowName)
{
var windowDefaults = "status=no, menubar=no, location=no, scrollbars=yes, resizeable=yes, width=700, height=500, left=20, top=20";
var newWindow = window.open(windowURL, windowName,windowDefaults);
if (window.focus) { newWindow.focus(); } ; // force the window to the front if the browser supports it
return newWindow;

}
</script>
</head>


<f:view>

<body onload="setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');" >
<h:form id="listauthmodulesform">
<%

if (msg != null)
{	
  final javax.faces.context.FacesContext facesContext = javax.faces.context.FacesContext.getCurrentInstance();
  FacesMessage facesMsg = new FacesMessage(null, msg);
  facesMsg.setSeverity(FacesMessage.SEVERITY_INFO);
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
						<f:subview id="top">
							<jsp:include page="topnavbar.jsp"/> 
						</f:subview>
						<div class="meletePortletToolBarMessage"><img src="images/pen_red.gif" alt="" width="16" height="16" align="absbottom"><h:outputText value="#{msgs.list_auth_modules_authoring_options}" /> </div>
				 </td>
			</tr>
			<tr><td>
					<f:subview id="authtop">
							<jsp:include page="authnavbar.jsp"/> 
					</f:subview>
			</td>
		</tr>
<!--Page Content-->
	
		<tr>
		<td align="left">
			<h:messages showDetail="true" showSummary="false" infoClass="BlueClass" errorClass="RedClass"/>
			 <table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#EAEAEA" width="100%" id="AutoNumber1" > 
                   <tr class="maintabledata3">
				   <td colspan="7">
				     <h:dataTable id="table" 
                  value="#{listAuthModulesPage.moduleDateBeans}"
                  var="mdbean"   border="0"  headerClass="tableheader" rowClasses="row1,row2" columnClasses="ModCheckClass,TitleWid,ModCheckClass,ModCheckClass,ModCheckClass,ModCheckClass,ModCheckClass" 
                  styleClass="maintabledata1"
				  width="100%" binding="#{listAuthModulesPage.table}">
                      
    <h:column>
    <f:facet name="header">
    <h:panelGroup>
      <h:commandLink id="expandAllAction" action="#{listAuthModulesPage.expandAllAction}" immediate="true">
     	<h:graphicImage id="exp_all_gif" alt="#{msgs.list_auth_modules_authoring_expand}" title="#{msgs.list_auth_modules_authoring_expand}" value="images/expand-collapse.gif"   rendered="#{listAuthModulesPage.expandAllFlag != listAuthModulesPage.trueFlag}" styleClass="ExpClass"/>
      </h:commandLink>
      <h:commandLink id="collapseAllAction" action="#{listAuthModulesPage.collapseAllAction}" immediate="true">
        <h:graphicImage id="col_all_gif" alt="#{msgs.list_auth_modules_authoring_collapse}" title="#{msgs.list_auth_modules_authoring_collapse}" value="images/collapse-expand.gif"   rendered="#{listAuthModulesPage.expandAllFlag == listAuthModulesPage.trueFlag}" styleClass="ExpClass"/>
      </h:commandLink>      
    </h:panelGroup> 
     </f:facet>
            
      <h:selectBooleanCheckbox value="#{mdbean.selected}" valueChangeListener="#{listAuthModulesPage.selectedModuleSection}"/>
         <h:graphicImage id="err_gif" value="images/pin_red.gif" rendered="#{mdbean.dateFlag == listAuthModulesPage.trueFlag}" styleClass="ExpClass"/>
    </h:column>
  
               
        <h:column>
 <f:facet name="header">
             <h:outputText id="t2" value="#{msgs.list_auth_modules_title}" />
             </f:facet>
					
     <h:commandLink id="viewSections" action="#{listAuthModulesPage.showAuthSections}" immediate="true">
        <h:graphicImage id="exp_gif" value="images/expand.gif" rendered="#{((mdbean.moduleId != listAuthModulesPage.showModuleId)&&(mdbean.sectionBeans != listAuthModulesPage.nullList)&&(listAuthModulesPage.expandAllFlag != listAuthModulesPage.trueFlag))}" styleClass="ExpClass"/>
        <h:inputHidden id="moduleShowId" value="#{mdbean.moduleId}"/>
      </h:commandLink>  
     <h:commandLink id="hideSections" action="#{listAuthModulesPage.hideAuthSections}" immediate="true">
        <h:graphicImage id="col_gif" value="images/collapse.gif" rendered="#{(((mdbean.moduleId == listAuthModulesPage.showModuleId)&&(mdbean.sectionBeans != listAuthModulesPage.nullList))||((listAuthModulesPage.expandAllFlag == listAuthModulesPage.trueFlag)&&(mdbean.sectionBeans != listAuthModulesPage.nullList)))}" styleClass="ExpClass"/>
         <h:inputHidden id="moduleHideId" value="#{mdbean.moduleId}"/>
      </h:commandLink>    
      <h:outputText id="emp_spacemod" value=" "/>
      <h:outputText id="mod_seq" value="#{mdbean.cmod.seqNo}."/>
      <h:outputText id="emp_spacemod2" value=" "/>
      
      <h:commandLink id="editMod" actionListener="#{listAuthModulesPage.editModule}"  action="#{listAuthModulesPage.redirectToEditModule}">     
                   <h:outputText id="title2" value="#{mdbean.truncTitle}">
               </h:outputText>
      </h:commandLink>
      <h:dataTable id="tablesec" rendered="#{((mdbean.moduleId == listAuthModulesPage.showModuleId)||(listAuthModulesPage.expandAllFlag == listAuthModulesPage.trueFlag))}"
                  value="#{mdbean.sectionBeans}"
                  var="sectionBean" columnClasses="SectionClass" rowClasses="#{mdbean.rowClasses}" width="300">
               <h:column>
              <h:selectBooleanCheckbox value="#{sectionBean.selected}"  valueChangeListener="#{listAuthModulesPage.selectedSection}"/> 
               <h:outputText id="emp_space" value=" "/>
               <h:outputText id="disp_seq" value="#{sectionBean.displaySequence}"/>
              <h:outputText id="emp_space2" value=" "/>
       
              <h:commandLink id="editSec" actionListener="#{listAuthModulesPage.editSection}"  action="#{listAuthModulesPage.redirectToEditSection}">   
                 <h:outputText id="sectitle" 
                            value="#{sectionBean.truncTitle}">
                </h:outputText>
              </h:commandLink>
            </h:column>
          </h:dataTable>
     
        </h:column>      
       <h:column>
        <f:facet name="header">
             <h:outputText id="t4" value="#{msgs.list_auth_modules_start_date}" />
             </f:facet>
             
                <h:inputText id="startDate"
                           value="#{mdbean.moduleShdate.startDate}" >
            <f:convertDateTime pattern="MM/dd/yyyy hh:mm a"/>
            </h:inputText>
          
                           
            <f:facet name="footer">
              <h:commandLink id="saveChanges" action="#{listAuthModulesPage.saveChanges}"  rendered="#{listAuthModulesPage.nomodsFlag == false}">
                 <h:graphicImage id="save" value="#{msgs.im_save_over}" styleClass="CmdImgClass"/>
               
              </h:commandLink>                 
            </f:facet>
         </h:column>
         <h:column>
              <f:facet name="header">
             <h:outputText id="t5" value="" />
             </f:facet>
          
           <h:outputLink id="viewsdateCal" onclick="showSdateCal(#{listAuthModulesPage.table.rowIndex})" value="#">
            <h:graphicImage id="sdateCal" value="images/date.png" styleClass="DatePickerClass"/>
           </h:outputLink>            
        </h:column>
        <h:column>
               <f:facet name="header">
				 <h:outputText id="t6" value="#{msgs.list_auth_modules_end_date}" />
             </f:facet>
             
            <h:inputText id="endDate" 
                           value="#{mdbean.moduleShdate.endDate}" >
               <f:convertDateTime pattern="MM/dd/yyyy hh:mm a"/>
            </h:inputText>
            <f:facet name="footer">
            <h:commandLink id="cancelChanges" action="#{listAuthModulesPage.cancelChanges}" immediate="true" rendered="#{listAuthModulesPage.nomodsFlag == false}">
                <h:graphicImage id="cancel" value="#{msgs.im_cancel_over}" styleClass="CmdImgClass"/>
           
              </h:commandLink>                      
            </f:facet>           
         </h:column>
         <h:column>
              <f:facet name="header">
             <h:outputText id="t7" value="" />
             </f:facet>
          <h:outputLink id="viewedateCal" onclick="showEdateCal(#{listAuthModulesPage.table.rowIndex})" value="#">
            <h:graphicImage id="edateCal" value="images/date.png" styleClass="DatePickerClass"/>
           </h:outputLink>                
            
        </h:column>
	   	<h:column>
          <f:facet name="header">
        	 <h:outputText id="t8" value="#{msgs.list_auth_modules_actions}" />
          </f:facet>
       	   <h:outputText id="emp_space6" value="  " styleClass="ExtraPaddingClass" />
           <h:commandLink id="viewNextsteps" action="#{listAuthModulesPage.viewNextsteps}" >
			   <h:graphicImage id="vns_gif" value="images/add.gif" alt="#{msgs.list_auth_modules_next_steps}" title="#{msgs.list_auth_modules_next_steps}" styleClass="AddImgClass"  rendered="#{mdbean.module.whatsNext == listAuthModulesPage.isNull}"/>      
			   <h:graphicImage id="vns1_gif" value="images/view_next.gif" styleClass="AddImgClass"  rendered="#{mdbean.module.whatsNext != listAuthModulesPage.isNull}"/>        		   
           </h:commandLink>
           <h:outputText id="emp_space4" value="  " styleClass="ExtraPaddingClass" />
		  <h:commandLink id="duplicateModule" action="#{listAuthModulesPage.duplicateAction}">
		  	  <h:graphicImage id="duplicateImg" value="images/page_copy.png" styleClass="AuthImgClass"/>
		  </h:commandLink>
		     <h:outputText id="emp_space5" value="  " styleClass="ExtraPaddingClass" />
		     <h:outputLink id="printModuleLink" value="print_module" onclick="OpenPrintWindow(this.href,'Melete Print Window');this.href='#';">
		    	<f:param id="printmoduleId" name="printModuleId" value="#{listAuthModulesPage.printModuleId}" />
		  	  <h:graphicImage id="printImgLink" value="images/printer.png" styleClass="AuthImgClass"/>
		  </h:outputLink>
        </h:column>
	    
          
    </h:dataTable>   
				   
 
    </br>
	<h:outputText id="nomodmsg" value="#{msgs.list_auth_modules_no_modules_available}" rendered="#{listAuthModulesPage.nomodsFlag == true}" style="text-align:left"/>
	</td></tr>
	  <tr > <td colspan="7" height="20" class="maintabledata5">&nbsp;  </td> </tr>
                 </table>
</td>
</tr>
</table> 
 

<!--End Content-->

 <p> <h:outputLink styleClass="style3" value="#top" rendered="#{listModulesPage.nomodsFlag == false}">  <f:verbatim> <h:outputText value="#{msgs.list_auth_modules_back_to_top}" /> </f:verbatim> </h:outputLink>
</p>
</td>
</tr>
</table>
</h:form>
</body>

</f:view>
</html>

 

 