<html>
<head>
<link rel="stylesheet" href="rtbc004.css" type="text/css">
<title>Melete - Modules: Student View</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>

<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
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
<td>
<f:subview id="top">
<jsp:include page="topnavbar.jsp"/> 
</f:subview>
<div class="meletePortletToolBarMessage"><img src="images/preview.png" alt="" width="16" height="16" align="absbottom"><h:outputText value="#{msgs.list_modules_inst_viewing_student}" /> </div>
</td>
</tr>
<tr>
<td class="maintabledata3">
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
          <th  height="20"  width="27%"  class="leftheader"><h:outputText value="#{msgs.list_modules_inst_start_date}" /></th>
          <th  height="20"   width="28%"  class="leftheader"><h:outputText value="#{msgs.list_modules_inst_end_date}" /></th>          
        </tr>
	<tr> <td colspan="4" valign="top">
 <h:dataTable id="table"  
                  value="#{listModulesPage.moduleDateBeans}" 
                  var="mdbean"  rowClasses="row1,row2" columnClasses="titleWid,ModCheckClass,dateWid1,dateWid2"
                  border="0" width="100%" >
        <h:column> 
            <h:commandLink id="viewSections" action="#{listModulesPage.showSections}"  rendered="#{(mdbean.moduleShdate.hideFlag == false)}">
        <h:graphicImage id="exp_gif" value="images/expand.gif" rendered="#{((mdbean.moduleId != listModulesPage.showModuleId)&&(mdbean.sectionBeans != listModulesPage.nullList)&&(listModulesPage.expandAllFlag != listModulesPage.trueFlag))}" styleClass="ExpClass"/>
         <h:inputHidden id="moduleShowId" value="#{mdbean.moduleId}"/>
      </h:commandLink>
 <h:commandLink id="hideSections" action="#{listModulesPage.hideSections}"  rendered="#{(mdbean.moduleShdate.hideFlag == false)}">
        <h:graphicImage id="col_gif" value="images/collapse.gif" rendered="#{(((mdbean.moduleId == listModulesPage.showModuleId)&&(mdbean.sectionBeans != listModulesPage.nullList))||((listModulesPage.expandAllFlag == listModulesPage.trueFlag)&&(mdbean.sectionBeans != listModulesPage.nullList)))}" styleClass="ExpClass"/>
         <h:inputHidden id="moduleHideId" value="#{mdbean.moduleId}"/>
      </h:commandLink>   
      <h:outputText id="emp_spacemod" value=" "/>
       <h:commandLink id="viewModule"  actionListener="#{listModulesPage.viewModule}" action="#{listModulesPage.redirectToViewModule}"  
          rendered="#{(((mdbean.moduleShdate.hideFlag == false)&&(((mdbean.moduleShdate.startDate == listModulesPage.nullDate)||(mdbean.moduleShdate.startDate <= listModulesPage.currentTimestamp))&&((mdbean.moduleShdate.endDate == listModulesPage.nullDate)||(mdbean.moduleShdate.endDate >= listModulesPage.currentTimestamp)))))}">
              <h:outputText id="title"
                           value="#{mdbean.truncTitle}">
         </h:outputText>             
       </h:commandLink>
      <h:commandLink id="viewModule2"  actionListener="#{listModulesPage.viewModule}" action="#{listModulesPage.redirectToViewModule}"  
         rendered="#{((mdbean.moduleShdate.hideFlag == false)&&((mdbean.moduleShdate.startDate > listModulesPage.currentTimestamp)||(mdbean.moduleShdate.endDate < listModulesPage.currentTimestamp)))}">      
         <h:outputText id="title2"
                           value="#{mdbean.truncTitle}" styleClass="italics">
         </h:outputText>                 
       </h:commandLink>    
                
          
           <h:dataTable id="tablesec" rendered="#{(((mdbean.moduleId == listModulesPage.showModuleId)||(listModulesPage.expandAllFlag == listModulesPage.trueFlag))&&(mdbean.moduleShdate.hideFlag == false))}"
                  value="#{mdbean.sectionBeans}"
                  var="section" columnClasses="SectionClass" rowClasses="#{mdbean.rowClasses}"  width="75%">
                   <h:column>
                   <h:outputText value="   " styleClass="ExtraPaddingClass"/>
 <h:outputText id="emp_space" value="   "/>
              <h:graphicImage id="bul_gif" value="images/bullet_black.gif"/>
              <h:outputText id="emp_space2" value="   "/>
           <h:commandLink id="viewSectionEditor"  actionListener="#{listModulesPage.viewSection}" action="#{listModulesPage.redirectToViewSection}" rendered="#{((section.section.contentType == listModulesPage.typeLink)&&((mdbean.moduleShdate.startDate == listModulesPage.nullDate)||(mdbean.moduleShdate.startDate <= listModulesPage.currentTimestamp))&&((mdbean.moduleShdate.endDate == listModulesPage.nullDate)||(mdbean.moduleShdate.endDate >= listModulesPage.currentTimestamp)))}">
               <h:outputText id="sectitleEditor" 
                           value="#{section.truncTitle}">
               </h:outputText>
             </h:commandLink>
            <h:commandLink id="viewSectionEditor2"  actionListener="#{listModulesPage.viewSection}" action="#{listModulesPage.redirectToViewSection}" rendered="#{((section.section.contentType == listModulesPage.typeLink)&&((mdbean.moduleShdate.startDate > listModulesPage.currentTimestamp)||(mdbean.moduleShdate.endDate < listModulesPage.currentTimestamp)))}">
               <h:outputText id="sectitleEditor2" 
                           value="#{section.truncTitle}" styleClass="italics">
               </h:outputText>
             </h:commandLink>             
           <h:commandLink id="viewSectionLink"  actionListener="#{listModulesPage.viewSection}" action="#{listModulesPage.redirectToViewSectionLink}" rendered="#{((section.section.contentType != listModulesPage.typeLink)&&((mdbean.moduleShdate.startDate == listModulesPage.nullDate)||(mdbean.moduleShdate.startDate <= listModulesPage.currentTimestamp))&&((mdbean.moduleShdate.endDate == listModulesPage.nullDate)||(mdbean.moduleShdate.endDate >= listModulesPage.currentTimestamp)))}">
               <h:outputText id="sectitleLink" 
                           value="#{section.truncTitle}">
               </h:outputText>
             </h:commandLink> 
          
           <h:commandLink id="viewSectionLink2"  actionListener="#{listModulesPage.viewSection}" action="#{listModulesPage.redirectToViewSectionLink}" rendered="#{((section.section.contentType != listModulesPage.typeLink)&&((mdbean.moduleShdate.startDate > listModulesPage.currentTimestamp)||(mdbean.moduleShdate.endDate < listModulesPage.currentTimestamp)))}">
               <h:outputText id="sectitleLink2" 
                           value="#{section.truncTitle}" styleClass="italics">
               </h:outputText>
             </h:commandLink>                           
            
             
            </h:column>
          </h:dataTable>
           </h:column>
           <h:column>
               <h:graphicImage id="closed_gif" value="images/closed.gif" alt="#{msgs.list_modules_inst_closed}" rendered="#{((mdbean.moduleShdate.hideFlag == false)&&((mdbean.moduleShdate.startDate > listModulesPage.currentTimestamp)||(mdbean.moduleShdate.endDate < listModulesPage.currentTimestamp)))}" styleClass="ExpClass"/>
           </h:column>
           <h:column>
              <h:outputText id="startDate0" 
                           value="-"    rendered="#{((mdbean.moduleShdate.hideFlag == false)&&(mdbean.moduleShdate.startDate == listModulesPage.nullDate))}">
            </h:outputText>
                  <h:outputText id="startDate" 
                           value="#{mdbean.moduleShdate.startDate}"    rendered="#{((mdbean.moduleShdate.hideFlag == false)&&((mdbean.moduleShdate.startDate != listModulesPage.nullDate)&&(mdbean.moduleShdate.startDate <= listModulesPage.currentTimestamp))&&((mdbean.moduleShdate.endDate == listModulesPage.nullDate)||(mdbean.moduleShdate.endDate >= listModulesPage.currentTimestamp)))}">
              <f:convertDateTime pattern="yyyy-MMM-d hh:mm a"/>
            </h:outputText>
            <h:outputText id="startDate2" styleClass="italics" 
                           value="#{mdbean.moduleShdate.startDate}"     rendered="#{((mdbean.moduleShdate.hideFlag == false)&&((mdbean.moduleShdate.startDate > listModulesPage.currentTimestamp)||(mdbean.moduleShdate.endDate < listModulesPage.currentTimestamp)))}">      
              <f:convertDateTime pattern="yyyy-MMM-d hh:mm a"/>
            </h:outputText>            
           </h:column>
            <h:column>
               <h:outputText id="endDate0" 
                           value="-"    rendered="#{((mdbean.moduleShdate.hideFlag == false)&&(mdbean.moduleShdate.endDate == listModulesPage.nullDate)}">
              <f:convertDateTime pattern="yyyy-MMM-d hh:mm a"/>
            </h:outputText>
              <h:outputText id="endDate"
                           value="#{mdbean.moduleShdate.endDate}"
                              rendered="#{((mdbean.moduleShdate.hideFlag == false)&&((mdbean.moduleShdate.startDate == listModulesPage.nullDate)||(mdbean.moduleShdate.startDate <= listModulesPage.currentTimestamp))&&((mdbean.moduleShdate.endDate != listModulesPage.nullDate)&&(mdbean.moduleShdate.endDate >= listModulesPage.currentTimestamp)))}">
               <f:convertDateTime pattern="yyyy-MMM-d hh:mm a"/>
            </h:outputText>
            <h:outputText id="endDate2" styleClass="italics" 
                           value="#{mdbean.moduleShdate.endDate}"
                             rendered="#{((mdbean.moduleShdate.hideFlag == false)&&((mdbean.moduleShdate.startDate > listModulesPage.currentTimestamp)||(mdbean.moduleShdate.endDate < listModulesPage.currentTimestamp)))}">      
               <f:convertDateTime pattern="yyyy-MMM-d hh:mm a"/>
            </h:outputText>            
        </h:column>   
          
    </h:dataTable>   
      <h:messages showDetail="true" showSummary="false" rendered="#{listModulesPage.nomodsFlag == true}" style="text-align:left"/>      
	  </td></tr>
	  <tr>
         <td  height="20" colspan="4" class="maintabledata5">&nbsp;   </td>
        </tr>
        <tr>
        <td colspan="4">
         <h:graphicImage id="closed_gif" value="images/closed.gif" alt="" styleClass="ExpClass"/>
         <h:outputText styleClass="style5" value="#{msgs.list_modules_inst_module_not_open}" />
        </table>

 </td>
 </tr>
</table>	

<!--End Content-->
<p> <h:outputLink styleClass="style3" value="#top" rendered="#{listModulesPage.nomodsFlag == false}">  <f:verbatim><h:outputText value="#{msgs.list_modules_inst_back_to_top}" /></f:verbatim> </h:outputLink>
</p>
</td>
</tr>
</table>

 </h:form>

</body>
</f:view>
</html>
