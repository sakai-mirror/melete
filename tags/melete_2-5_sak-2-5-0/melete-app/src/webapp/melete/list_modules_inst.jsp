<html>
<head>
<link rel="stylesheet" href="rtbc004.css" type="text/css">
<title>Melete - Modules: Student View</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
<script type="text/javascript" language="javascript">
function OpenPrintWindow(print_id, windowName)
{
	
  var _info = navigator.userAgent;
  var _ie = (_info.indexOf("MSIE") > 0 && _info.indexOf("Win") > 0 && _info.indexOf("Windows 3.1") < 0);
	var windowDefaults = "status=no, menubar=no, location=no, scrollbars=yes, resizeable=yes, width=700, height=700, left=20, top=20";
	var newWindow;
	if(!_ie) newWindow = window.open('print_module.jsf?printModuleId='+print_id,windowName,windowDefaults);
	else newWindow = window.open('print_module.jsf?printModuleId='+print_id,null,windowDefaults);
if (window.focus) { newWindow.focus(); } ; // force the window to the front if the browser supports it
return newWindow;

}
</script>
</head>
<f:view>
<body onLoad="setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');">
<h:form id="listmodulesform">

<table border="0" height="350" cellpadding="0" cellspacing="0" class ="table3">
<tr>
		<td valign="top"> 
		&nbsp;
		</td>
	<td width="1962" valign="top">
<table width="100%" border="1" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA" style="border-collapse: collapse">
<tr>
<td colspan="2">
<f:subview id="top">
<jsp:include page="topnavbar.jsp"/> 
</f:subview>
</td>
</tr>
<tr>
<td colspan="2">

<div class="meletePortletToolBarMessage"><img src="images/preview.png" alt="" width="16" height="16" align="absbottom"><h:outputText value="#{msgs.list_modules_inst_viewing_student}" /> </div>

</td>
</tr>
<tr>
<td colspan="2" class="maintabledata3">
<h:messages showDetail="true" showSummary="false"/>
<table border="1" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#EAEAEA" width="100%" id="AutoNumber1" >
        <tr class="maintabledata5">
          <th  height="20" width="40%" class="tableheader2">
       <h:commandLink id="expandAllAction" action="#{listModulesPage.expandAllAction}" immediate="true">
     	<h:graphicImage id="exp_all_gif" alt="#{msgs.list_modules_inst_expand_all}" title="#{msgs.list_modules_inst_expand_all}" value="images/expand-collapse.gif"   rendered="#{listModulesPage.expandAllFlag != listModulesPage.trueFlag}" styleClass="ExpClass"/>
      </h:commandLink>
      <h:commandLink id="collapseAllAction" action="#{listModulesPage.collapseAllAction}" immediate="true">
        <h:graphicImage id="col_all_gif" alt="#{msgs.list_modules_inst_collapse_all}" title="#{msgs.list_modules_inst_collapse_all}" value="images/collapse-expand.gif"   rendered="#{listModulesPage.expandAllFlag == listModulesPage.trueFlag}" styleClass="ExpClass"/>
      </h:commandLink>           
          
          </th>
          <th  height="20"  width="5%"  class="leftheader"></th>  
          <th  height="20"  width="25%"  class="leftheader"><h:outputText value="#{msgs.list_modules_inst_start_date}" /></th>
          <th  height="20"   width="25%"  class="leftheader"><h:outputText value="#{msgs.list_modules_inst_end_date}" /></th>
          <th  height="20"  width="5%"  class="leftheader"></th>           
        </tr>
	<tr> <td colspan="5" valign="top">
 <h:dataTable id="table"  
                  value="#{listModulesPage.moduleDateBeans}" 
                  var="mdbean"  rowClasses="row1,row2" columnClasses="titleWid,ModCheckClass,dateWid1,dateWid2,ModCheckClass"
                  border="0" width="100%" binding="#{listModulesPage.modTable}">
        <h:column>       
      
            <h:commandLink id="viewSections" action="#{listModulesPage.showSections}" immediate="true">
        <h:graphicImage id="exp_gif" value="images/expand.gif" rendered="#{((mdbean.moduleId != listModulesPage.showModuleId)&&(mdbean.sectionBeans != listModulesPage.nullList)&&(listModulesPage.expandAllFlag != listModulesPage.trueFlag))}" styleClass="ExpClass"/>
         <h:inputHidden id="moduleShowId" value="#{mdbean.moduleId}"/>
      </h:commandLink>
 <h:commandLink id="hideSections" action="#{listModulesPage.hideSections}" immediate="true">
        <h:graphicImage id="col_gif" value="images/collapse.gif" rendered="#{(((mdbean.moduleId == listModulesPage.showModuleId)&&(mdbean.sectionBeans != listModulesPage.nullList))||((listModulesPage.expandAllFlag == listModulesPage.trueFlag)&&(mdbean.sectionBeans != listModulesPage.nullList)))}" styleClass="ExpClass"/>
         <h:inputHidden id="moduleHideId" value="#{mdbean.moduleId}"/>
      </h:commandLink>   
       <h:outputText id="mod_seq" value="#{mdbean.cmod.seqNo}. " rendered="#{listModulesPage.autonumber}"/>
       <h:commandLink id="viewModule"  actionListener="#{listModulesPage.viewModule}" action="#{listModulesPage.redirectToViewModule}" immediate="true"  
          rendered="#{mdbean.visibleFlag == listModulesPage.trueFlag}">
          <f:param name="modidx" value="#{listModulesPage.modTable.rowIndex}" />
              <h:outputText id="title"
                           value="#{mdbean.module.title}">
         </h:outputText>             
       </h:commandLink>
      <h:commandLink id="viewModule2"  actionListener="#{listModulesPage.viewModule}" action="#{listModulesPage.redirectToViewModule}"  immediate="true" 
         rendered="#{mdbean.visibleFlag != listModulesPage.trueFlag}">      
         <f:param name="modidx" value="#{listModulesPage.modTable.rowIndex}" />
         <h:outputText id="title2"
                           value="#{mdbean.module.title}" styleClass="italics">
         </h:outputText>                 
       </h:commandLink>    
                
          
           <h:dataTable id="tablesec" rendered="#{(((mdbean.moduleId == listModulesPage.showModuleId)||(listModulesPage.expandAllFlag == listModulesPage.trueFlag)))}"
                  value="#{mdbean.sectionBeans}"
                  var="section" columnClasses="SectionClass" rowClasses="#{mdbean.rowClasses}"  width="95%" binding="#{listModulesPage.secTable}">
                   <h:column>                         
               <h:graphicImage id="bul_gif" value="images/bullet_black.gif"/>
	       <h:outputText id="sec_seq" value="#{section.displaySequence}. " rendered="#{listModulesPage.autonumber}"/>
           <h:commandLink id="viewSectionEditor"  actionListener="#{listModulesPage.viewSection}" action="#{listModulesPage.redirectToViewSection}" rendered="#{((section.section.contentType == listModulesPage.typeLink)&&(mdbean.visibleFlag == listModulesPage.trueFlag))}" immediate="true">
                  <f:param name="modidx" value="#{listModulesPage.modTable.rowIndex}" />
               <f:param name="secidx" value="#{listModulesPage.secTable.rowIndex}" />
               <h:outputText id="sectitleEditor" 
                           value="#{section.section.title}">
               </h:outputText>
             </h:commandLink>
            <h:commandLink id="viewSectionEditor2"  actionListener="#{listModulesPage.viewSection}" action="#{listModulesPage.redirectToViewSection}" rendered="#{((section.section.contentType == listModulesPage.typeLink)&&(mdbean.visibleFlag != listModulesPage.trueFlag))}" immediate="true">
                  <f:param name="modidx" value="#{listModulesPage.modTable.rowIndex}" />
               <f:param name="secidx" value="#{listModulesPage.secTable.rowIndex}" />
               <h:outputText id="sectitleEditor2" 
                           value="#{section.section.title}" styleClass="italics">
               </h:outputText>
             </h:commandLink>             
           <h:commandLink id="viewSectionLink"  actionListener="#{listModulesPage.viewSection}" action="#{listModulesPage.redirectToViewSectionLink}" rendered="#{((section.section.contentType != listModulesPage.typeLink)&&(mdbean.visibleFlag == listModulesPage.trueFlag))}" immediate="true">
                  <f:param name="modidx" value="#{listModulesPage.modTable.rowIndex}" />
               <f:param name="secidx" value="#{listModulesPage.secTable.rowIndex}" />
               <h:outputText id="sectitleLink" 
                           value="#{section.section.title}">
               </h:outputText>
             </h:commandLink> 
          
           <h:commandLink id="viewSectionLink2"  actionListener="#{listModulesPage.viewSection}" action="#{listModulesPage.redirectToViewSectionLink}" rendered="#{((section.section.contentType != listModulesPage.typeLink)&&(mdbean.visibleFlag != listModulesPage.trueFlag))}" immediate="true">
                 <f:param name="modidx" value="#{listModulesPage.modTable.rowIndex}" />
               <f:param name="secidx" value="#{listModulesPage.secTable.rowIndex}" />
               <h:outputText id="sectitleLink2" 
                           value="#{section.section.title}" styleClass="italics">
               </h:outputText>
             </h:commandLink>                           
            
             
            </h:column>
          </h:dataTable>
           </h:column>
           <h:column>
               <h:graphicImage id="closed_gif" value="images/closed.gif" alt="#{msgs.list_modules_inst_closed}" rendered="#{mdbean.visibleFlag != listModulesPage.trueFlag}" styleClass="ExpClass"/>
           </h:column>
           <h:column>
              <h:outputText id="startDate0" 
                           value="-"    rendered="#{((mdbean.moduleShdate.startDate == listModulesPage.nullDate))}">
            </h:outputText>
                  <h:outputText id="startDate" 
                           value="#{mdbean.moduleShdate.startDate}"    rendered="#{mdbean.visibleFlag == listModulesPage.trueFlag}">
              <f:convertDateTime pattern="yyyy-MMM-d hh:mm a"/>
            </h:outputText>
            <h:outputText id="startDate2" styleClass="italics" 
                           value="#{mdbean.moduleShdate.startDate}"     rendered="#{mdbean.visibleFlag != listModulesPage.trueFlag}">      
              <f:convertDateTime pattern="yyyy-MMM-d hh:mm a"/>
            </h:outputText>            
           </h:column>
            <h:column>
               <h:outputText id="endDate0" 
                           value="-"    rendered="#{((mdbean.moduleShdate.endDate == listModulesPage.nullDate))}">
              <f:convertDateTime pattern="yyyy-MMM-d hh:mm a"/>
            </h:outputText>
              <h:outputText id="endDate"
                           value="#{mdbean.moduleShdate.endDate}"
                              rendered="#{mdbean.visibleFlag == listModulesPage.trueFlag}">
               <f:convertDateTime pattern="yyyy-MMM-d hh:mm a"/>
            </h:outputText>
            <h:outputText id="endDate2" styleClass="italics" 
                           value="#{mdbean.moduleShdate.endDate}"
                             rendered="#{mdbean.visibleFlag != listModulesPage.trueFlag}">      
               <f:convertDateTime pattern="yyyy-MMM-d hh:mm a"/>
            </h:outputText>            
   	 </h:column>   
      <h:column rendered="#{listModulesPage.printable}"> 
         <h:outputText id="emp_space5" value="  " styleClass="ExtraPaddingClass" />
	     <h:outputLink id="printModuleLink" value="list_modules_inst" onclick="OpenPrintWindow(#{listModulesPage.printModuleId},'Melete Print Window');" rendered="#{mdbean.visibleFlag}">
	    	<f:param id="printmoduleId" name="printModuleId" value="#{listModulesPage.printModuleId}" />
	  	  	<h:graphicImage id="printImgLink" value="images/printer.png" alt="#{msgs.list_auth_modules_alt_print}" title="#{msgs.list_auth_modules_alt_print}" styleClass="AuthImgClass"/>
	 	 </h:outputLink>
       </h:column>  
    </h:dataTable>   
      <h:messages showDetail="true" showSummary="false" rendered="#{listModulesPage.nomodsFlag == true}" style="text-align:left"/>      
	  </td></tr>
	  <tr>
         <td  height="20" colspan="5" class="maintabledata5">&nbsp;   </td>
        </tr>
        <tr>
        <td colspan="4">
         <h:graphicImage id="closed_gif" value="images/closed.gif" alt="" styleClass="ExpClass" rendered="#{listModulesPage.closedModulesFlag == listModulesPage.trueFlag}"/>
         <h:outputText styleClass="style5" value="#{msgs.list_modules_inst_module_not_open}" rendered="#{listModulesPage.closedModulesFlag == listModulesPage.trueFlag}"/>
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
