<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!--
 ***********************************************************************************
 * $URL$
 * $Id$  
 ***********************************************************************************
 *
 * Copyright (c) 2008, 2009 Etudes, Inc.
 *
 * Portions completed before September 1, 2008 Copyright (c) 2004, 2005, 2006, 2007, 2008 Foothill College, ETUDES Project
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
<html>

<title>Melete - Modules: Author View</title>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>

<%@include file="accesscheck.jsp" %>
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
	ResourceLoader bundle = new ResourceLoader("org.etudes.tool.melete.bundle.Messages");
	String mensaje=bundle .getString("JS_date");
	
%>

<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
<script type="text/javascript" language="JavaScript" src="js/calendar2.js"></script>
<script type="text/javascript" language="javascript" src="js/sharedscripts.js"></script>
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


function selectAll()
{
  var listSizeStr = "listauthmodulesform:listSize";
  var listSizeVal = document.getElementById(listSizeStr).value;
  if (document.getElementById("listauthmodulesform:table:allmodcheck") != null)
  {	  
  if (document.getElementById("listauthmodulesform:table:allmodcheck").checked == true)
  {	  
    for (i=0;i<parseInt(listSizeVal);i++)
    {
	  var modchStr = "listauthmodulesform:table:"+i+":modCheck";
	  if (document.getElementById(modchStr).checked == false)
	  {	  
	    document.getElementById(modchStr).checked=true;
	  }  	  
    }
  } 
  else
  {	  
	  resetCheck();
   } 	   	  
  }
}

function resetCheck()
{
	 var inputs = document.getElementsByTagName("input");
	  for (var i = 0; i < inputs.length; i++) {   
		  if (inputs[i].type == "checkbox") {   
		  inputs[i].checked = false;
		  }
	  }	  
}

function resetAllMod()
{
	if (document.getElementById("listauthmodulesform:table:allmodcheck") != null)
	{	
	  document.getElementById("listauthmodulesform:table:allmodcheck").checked=false;
	}
}

</script>
</head>


<f:view>

<body onload="resetCheck();setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');" >
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
<table border="0" width="100%" height="350" cellpadding="2" cellspacing="0" class ="table3">
<tr>		
		<td valign="top">
			<table width="100%" border="1" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA" style="border-collapse: collapse">
				<tr>
					<td height="20" class="maintabledata1">
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
			 <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#EAEAEA" width="100%" height="100%" id="AutoNumber1" > 
                   <tr>
				   <td colspan="5">
				     <h:dataTable id="table" 
                  value="#{listAuthModulesPage.moduleDateBeans}"
                  var="mdbean"   border="0"  headerClass="tableheader" rowClasses="row1,row2" columnClasses="ListModCheckClass,ListTitleClass,ListDateClass,ListDateClass,ListActionClass" 
                  styleClass="maintabledata1" cellpadding="3" 
				  width="100%" binding="#{listAuthModulesPage.table}" summary="#{msgs.list_auth_modules_summary}">
                      
    <h:column>
    <f:facet name="header">
    <h:panelGroup>
       <h:selectBooleanCheckbox id="allmodcheck" value="#{listAuthModulesPage.selectAllFlag}" onclick="selectAll()" valueChangeListener="#{listAuthModulesPage.selectAllModules}"  rendered="#{listAuthModulesPage.nomodsFlag == false}"/>   
    </h:panelGroup> 
     </f:facet>
                      
      <h:selectBooleanCheckbox id="modCheck" value="#{mdbean.selected}" onclick="resetAllMod()" valueChangeListener="#{listAuthModulesPage.selectedModuleSection}" />
         <h:graphicImage id="err_gif" value="images/pin_red.gif" rendered="#{mdbean.dateFlag == listAuthModulesPage.trueFlag}" styleClass="ExpClass"/>
    </h:column>
  
               
   <h:column>
 	<f:facet name="header">
 	 <h:panelGroup>
      <h:commandLink id="expandCollapseAction" action="#{listAuthModulesPage.expandCollapseAction}" immediate="true">
     	<h:graphicImage id="exp_all_gif" alt="#{msgs.list_auth_modules_authoring_expand_all}" title="#{msgs.list_auth_modules_authoring_expand}" value="images/expand-collapse.gif"   rendered="#{listAuthModulesPage.expandAllFlag != listAuthModulesPage.trueFlag}" styleClass="ExpClass"/>
        <h:graphicImage id="col_all_gif" alt="#{msgs.list_auth_modules_authoring_collapse_all}" title="#{msgs.list_auth_modules_authoring_collapse}" value="images/collapse-expand.gif"   rendered="#{listAuthModulesPage.expandAllFlag == listAuthModulesPage.trueFlag}" styleClass="ExpClass"/>
      </h:commandLink>  
      <h:outputText id="t2" value="#{msgs.list_auth_modules_title}" />
     </h:panelGroup>        
    </f:facet>
					
     <h:commandLink id="showHideSections" action="#{listAuthModulesPage.showHideSections}" immediate="true">
        <h:graphicImage id="exp_gif" alt="#{msgs.list_auth_modules_authoring_expand}" value="images/expand.gif" rendered="#{((mdbean.moduleId != listAuthModulesPage.showModuleId)&&(mdbean.sectionBeans != listAuthModulesPage.nullList)&&(listAuthModulesPage.expandAllFlag != listAuthModulesPage.trueFlag))}" styleClass="ExpClass"/>
        <h:graphicImage id="col_gif" alt="#{msgs.list_auth_modules_authoring_collapse}" value="images/collapse.gif" rendered="#{(((mdbean.moduleId == listAuthModulesPage.showModuleId)&&(mdbean.sectionBeans != listAuthModulesPage.nullList))||((listAuthModulesPage.expandAllFlag == listAuthModulesPage.trueFlag)&&(mdbean.sectionBeans != listAuthModulesPage.nullList)))}" styleClass="ExpClass"/>
     </h:commandLink>    
     
      <h:outputText id="mod_seq" value="#{mdbean.cmod.seqNo}. " />
      
      <h:commandLink id="editMod" actionListener="#{listAuthModulesPage.editModule}"  action="#{listAuthModulesPage.redirectToEditModule}">     
             <f:param name="modidx" value="#{listAuthModulesPage.table.rowIndex}" />
                   <h:outputText id="title2" value="#{mdbean.module.title}">
               </h:outputText>
      </h:commandLink>
      <h:dataTable id="tablesec" rendered="#{((mdbean.moduleId == listAuthModulesPage.showModuleId)||(listAuthModulesPage.expandAllFlag == listAuthModulesPage.trueFlag))}"
                  value="#{mdbean.sectionBeans}" cellpadding="2" 
                  var="sectionBean" rowClasses="#{mdbean.rowClasses}" width="95%" binding="#{listAuthModulesPage.secTable}" summary="#{msgs.list_auth_modules_sections_summary}">
               <h:column>
              <h:selectBooleanCheckbox value="#{sectionBean.selected}"  valueChangeListener="#{listAuthModulesPage.selectedSection}"/> 
               <h:outputText id="disp_seq" value="#{sectionBean.displaySequence}. " />
                             
              <h:commandLink id="editSec" actionListener="#{listAuthModulesPage.editSection}"  action="#{listAuthModulesPage.redirectToEditSection}">
                <f:param name="modidx" value="#{listAuthModulesPage.table.rowIndex}" />
               <f:param name="secidx" value="#{listAuthModulesPage.secTable.rowIndex}" />   
                 <h:outputText id="sectitle" 
                            value="#{sectionBean.section.title}">
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
                           value="#{mdbean.moduleShdate.startDate}" styleClass="ListDateInput">
            <f:convertDateTime type="both" dateStyle="medium" timeStyle="short"/>
            </h:inputText>
            <h:outputLink id="viewsdateCal" onclick="showSdateCal(#{listAuthModulesPage.table.rowIndex})" value="#">
            <h:graphicImage id="sdateCal" value="images/date.png" alt="#{msgs.list_auth_modules_alt_popup_cal}" title="#{msgs.list_auth_modules_alt_popup_cal}" styleClass="ListDatePickerClass"/>
           </h:outputLink> 
           <h:outputText id="emp_space_startCal" value=" "/>
         </h:column>
         
        <h:column>
               <f:facet name="header">
				 <h:outputText id="t6" value="#{msgs.list_auth_modules_end_date}" />
             </f:facet>
             
            <h:inputText id="endDate" 
                           value="#{mdbean.moduleShdate.endDate}" styleClass="ListDateInput">
               <f:convertDateTime  type="both" dateStyle="medium" timeStyle="short"/>
            </h:inputText>
             <h:outputLink id="viewedateCal" onclick="showEdateCal(#{listAuthModulesPage.table.rowIndex})" value="#">
            <h:graphicImage id="edateCal" value="images/date.png" alt="#{msgs.list_auth_modules_alt_popup_cal}" title="#{msgs.list_auth_modules_alt_popup_cal}" styleClass="ListDatePickerClass"/>
           </h:outputLink>
           <h:outputText id="emp_spaceEndCal" value=" "/>
         </h:column>
         <h:column>
          <f:facet name="header">
        	 <h:outputText id="t8" value="#{msgs.list_auth_modules_actions}" />
          </f:facet>
       	   <h:outputText id="emp_space6" value="  " styleClass="ExtraPaddingClass" />
           <h:commandLink id="viewNextsteps" action="#{listAuthModulesPage.viewNextsteps}" >
			   <h:graphicImage id="vns_gif" value="images/add.gif" alt="#{msgs.list_auth_modules_alt_add_steps}" title="#{msgs.list_auth_modules_alt_add_steps}" styleClass="AddImgClass"  rendered="#{mdbean.module.whatsNext == listAuthModulesPage.isNull}"/>      
			   <h:graphicImage id="vns1_gif" value="images/view_next.gif" alt="#{msgs.list_auth_modules_alt_next_steps}" title="#{msgs.list_auth_modules_alt_next_steps}" styleClass="AddImgClass"  rendered="#{mdbean.module.whatsNext != listAuthModulesPage.isNull}"/>        		   
           </h:commandLink>
           <h:outputText id="emp_space4" value="  " styleClass="ExtraPaddingClass" />
		  <h:commandLink id="duplicateModule" action="#{listAuthModulesPage.duplicateAction}">
		  	  <h:graphicImage id="duplicateImg" value="images/page_copy.png" alt="#{msgs.list_auth_modules_alt_duplicate}" title="#{msgs.list_auth_modules_alt_duplicate}" styleClass="AuthImgClass"/>
		  </h:commandLink>
		     <h:outputText id="emp_space5" value="  " styleClass="ExtraPaddingClass" />
		     <h:outputLink id="printModuleLink" value="list_auth_modules" onclick="OpenPrintWindow(#{listAuthModulesPage.printModuleId},'Melete Print Window');">
		       	<h:graphicImage id="printImgLink" value="images/printer.png" alt="#{msgs.list_auth_modules_alt_print}" title="#{msgs.list_auth_modules_alt_print}" styleClass="AuthImgClass"/>
		  </h:outputLink>
  	  	   
		    <h:outputText id="emp_space7" value="  " styleClass="ExtraPaddingClass" />
        </h:column>
	    
          
    </h:dataTable>   
    <h:inputHidden id="listSize" value="#{listAuthModulesPage.listSize}"/>   
	<h:outputText id="nomodmsg" value="#{msgs.list_auth_modules_no_modules_available}" rendered="#{listAuthModulesPage.nomodsFlag == true}" style="text-align:left"/>
	</td></tr>
	  <tr > <td colspan="5">
	  <div class="actionBar" align="left">
	   <h:commandButton id="saveChanges" action="#{listAuthModulesPage.saveChanges}" rendered="#{listAuthModulesPage.nomodsFlag == false}" value="#{msgs.im_save}" accesskey="#{msgs.save_access}" title="#{msgs.im_save_text}" styleClass="BottomImgSave"/>
	   <h:commandButton id="cancelChanges" immediate="true" action="#{listAuthModulesPage.cancelChanges}" rendered="#{listAuthModulesPage.nomodsFlag == false}" value="#{msgs.im_cancel}"  accesskey="#{msgs.cancel_access}" title="#{msgs.im_cancel_text}" styleClass="BottomImgCancel"/>
	  </div>
	  </td> </tr>
                 </table>
</td>
</tr>
</table> 
 

<!--End Content-->
</td>
</tr>
</table>
</h:form>
</body>

</f:view>
</html>

 

 
