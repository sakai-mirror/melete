<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<!--
 ***********************************************************************************
 * $URL$
 * $Id$  
 ***********************************************************************************
 *
 * Copyright (c) 2008, 2009, 2010, 2011 Etudes, Inc.
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

<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>

<f:view>
<sakai:view title="Modules: Student View" toolCssHref="/etudes-melete-tool/rtbc004.css">
<%@include file="accesscheck.jsp" %>

<script type="text/javascript" language="javascript" src="/etudes-melete-tool/js/sharedscripts.js"></script>

<h:form id="listmodulesform">
<f:subview id="top">
	<jsp:include page="topnavbar.jsp?myMode=View"/> 
</f:subview>
<br/>
<div align="right">
<h:commandLink id="lastVisitedLink" actionListener="#{bookmarkPage.viewSection}" action="#{bookmarkPage.redirectViewSection}" rendered="#{listModulesPage.bookmarkSectionId > 0}">
 <f:param name="sectionId" value="#{listModulesPage.bookmarkSectionId}" /> 
 <h:graphicImage id="lvisit_gif" value="/images/last-visited.png" alt="" styleClass="BmImgClass"/>
 <h:outputText id="lastvisit" value="#{msgs.last_visited}" />									
</h:commandLink>
<h:outputText value="|" rendered="#{listModulesPage.bookmarkSectionId > 0}"/> 
<h:commandLink id="myBookmarksLink" action="#{bookmarkPage.gotoMyBookmarks}">
<f:param name="fromPage" value="list_modules_inst" />
<h:graphicImage id="mybook_gif" value="/images/my-bookmarks.png" alt="" styleClass="BmImgClass"/>
 <h:outputText id="mybks" value="#{msgs.my_bookmarks}" />									
</h:commandLink>	
</div>
<h:messages showDetail="true" showSummary="false"/>
 <h:outputText id="nomodstext" value="#{msgs.no_modules}" rendered="#{listModulesPage.nomodsFlag == null || listModulesPage.nomodsFlag}" style="text-align:left"/>
 <h:dataTable id="StudentTable"  
                  value="#{listModulesPage.viewModuleBeans}" rendered="#{listModulesPage.nomodsFlag != null && !listModulesPage.nomodsFlag}" 
                  var="vmbean"  rowClasses="row1,row2" columnClasses="StudentListTitleClass,ListClosedClass,ListDateClass,ListDateClass,ListDateClass,ListPrintClass" headerClass="tableheader"
                  border="0" cellpadding="3" cellspacing="0" width="100%" styleClass="valignStyle9" binding="#{listModulesPage.modTable}" summary="#{msgs.list_modules_inst_summary}">
        <h:column>      
        <f:facet name="header">
        <h:panelGroup>
         <h:commandLink id="expandCollpaseAction" action="#{listModulesPage.expandCollapseAction}" immediate="true">
     	   <h:graphicImage id="exp_all_gif" alt="#{msgs.list_modules_inst_expand_all}" title="#{msgs.list_modules_inst_expand_all}" value="/images/expand-collapse.gif"   rendered="#{listModulesPage.expandAllFlag != listModulesPage.trueFlag}" styleClass="ExpClass"/>
           <h:graphicImage id="col_all_gif" alt="#{msgs.list_modules_inst_collapse_all}" title="#{msgs.list_modules_inst_collapse_all}" value="/images/collapse-expand.gif"   rendered="#{listModulesPage.expandAllFlag == listModulesPage.trueFlag}" styleClass="ExpClass"/>
         </h:commandLink>
        </h:panelGroup>
        </f:facet>    
      
      <h:commandLink id="showHideSections" action="#{listModulesPage.showHideSections}" immediate="true">
        <h:graphicImage id="exp_gif" alt="#{msgs.list_modules_inst_expand}" title="#{msgs.list_modules_inst_expand}" value="/images/expand.gif" rendered="#{((vmbean.moduleId != listModulesPage.showModuleId)&&(vmbean.vsBeans != listModulesPage.nullList)&&(listModulesPage.expandAllFlag != listModulesPage.trueFlag))}" styleClass="ExpClass"/>
        <h:graphicImage id="col_gif" alt="#{msgs.list_modules_inst_collapse}" title="#{msgs.list_modules_inst_collapse}" value="/images/collapse.gif" rendered="#{(((vmbean.moduleId == listModulesPage.showModuleId)&&(vmbean.vsBeans != listModulesPage.nullList))||((listModulesPage.expandAllFlag == listModulesPage.trueFlag)&&(vmbean.vsBeans != listModulesPage.nullList)))}" styleClass="ExpClass"/>
        </h:commandLink>   
       <h:graphicImage id="moduleFinishStatus" url="/images/status_away.png" alt="#{msgs.list_modules_alt_progress}" title="#{msgs.list_modules_alt_progress}" styleClass="AuthImgClass" rendered="#{vmbean.readDate != null && !vmbean.readComplete}" />
	   <h:graphicImage id="moduleFinishStatus1" url="/images/finish.gif" alt="#{msgs.list_modules_alt_complete}" title="#{msgs.list_modules_alt_complete}" styleClass="AuthImgClass" rendered="#{vmbean.readComplete}" /> 
       <h:outputText id="mod_seq" value="#{vmbean.seqNo}. " rendered="#{listModulesPage.autonumber}"/>
       <h:commandLink id="viewModule"  actionListener="#{listModulesPage.viewModule}" action="#{listModulesPage.redirectToViewModule}" immediate="true">
          <f:param name="modidx" value="#{listModulesPage.modTable.rowIndex}" />
              <h:outputText id="title"
                           value="#{vmbean.title}" rendered="#{vmbean.visibleFlag == true}"/>
              <h:outputText id="title2"
                           value="#{vmbean.title}" styleClass="italics" rendered="#{vmbean.visibleFlag == false}" />             
                    
       </h:commandLink>
                
           <h:dataTable id="tablesec" rendered="#{(((vmbean.moduleId == listModulesPage.showModuleId)||(listModulesPage.expandAllFlag == listModulesPage.trueFlag)))}"
                  value="#{vmbean.vsBeans}" cellpadding="1"
                  var="vsbean"  rowClasses="#{vmbean.rowClasses}" width="95%" styleClass="secrow0" binding="#{listModulesPage.secTable}" summary="#{msgs.list_modules_inst_sections_summary}">
                 <h:column>   
                   <h:graphicImage id="bul_gif" value="/images/bullet_black.gif" rendered="#{!listModulesPage.autonumber}"/>
		      	   <h:outputText id="sec_seq" value="#{vsbean.displaySequence}. " rendered="#{listModulesPage.autonumber}"/>
					<h:commandLink id="viewSectionEditor"  actionListener="#{listModulesPage.viewSection}" action="#{listModulesPage.redirectToViewSection}" rendered="#{vsbean.contentType == listModulesPage.typeLink}" immediate="true">
	                  	<f:param name="modidx" value="#{listModulesPage.modTable.rowIndex}" />
	                  	<f:param name="secidx" value="#{listModulesPage.secTable.rowIndex}" />
	                 	<h:outputText id="sectitleEditor" value="#{vsbean.title}" rendered="#{vmbean.visibleFlag == true}" />
	                 	<h:outputText id="sectitleEditor2" value="#{vsbean.title}" styleClass="italics" rendered="#{vmbean.visibleFlag == false}" />
	                   </h:commandLink>
	                  
		           <h:commandLink id="viewSectionLink"  actionListener="#{listModulesPage.viewSection}" action="#{listModulesPage.redirectToViewSectionLink}" rendered="#{vsbean.contentType != listModulesPage.typeLink}" immediate="true">
		                  <f:param name="modidx" value="#{listModulesPage.modTable.rowIndex}" />
			              <f:param name="secidx" value="#{listModulesPage.secTable.rowIndex}" />
			              <h:outputText id="sectitleLink" value="#{vsbean.title}" rendered="#{vmbean.visibleFlag == true}" />
			              <h:outputText id="sectitleLink2" value="#{vsbean.title}" styleClass="italics" rendered="#{vmbean.visibleFlag == false}"/>
		             </h:commandLink>		           	          
	            </h:column>
	          </h:dataTable>
          <h:panelGrid id="nextsteps" columns="1" width="100%" rendered="#{vmbean.whatsNext != listModulesPage.isNull && ((listModulesPage.expandAllFlag == listModulesPage.trueFlag)||(vmbean.moduleId == listModulesPage.showModuleId))}">
	          <h:column>
		          <h:outputText id="emp_space6_bul" value="  " styleClass="NextStepsPaddingClass"/>
		          <h:outputText id="next_seq" value="#{vmbean.nextStepsNumber}. " rendered="#{listModulesPage.autonumber}"/>
		          <h:graphicImage id="bul_gif1" value="/images/bullet_black.gif" rendered="#{!listModulesPage.autonumber}" style="border:0"/>
		          
		          <h:commandLink id="whatsNext" action="#{listModulesPage.goWhatsNext}" immediate="true">
				    <h:outputText  id="whatsNextMsg" value="#{msgs.list_modules_stud_next_steps}" rendered="#{vmbean.visibleFlag == listModulesPage.trueFlag}"/>
				    <h:outputText  id="whatsNextMsg2" value="#{msgs.list_modules_stud_next_steps}" styleClass="italics" rendered="#{vmbean.visibleFlag == false}"/>
				    <f:param name="modidx2" value="#{listModulesPage.modTable.rowIndex}" />
				    <f:param name="modseqno" value="#{vmbean.seqNo}" />
		          </h:commandLink>  

	          </h:column>
          </h:panelGrid> 
           </h:column>
           <h:column>   
           <f:facet name="header">
               <h:outputText value="&nbsp;" escape="false"/>
             </f:facet>        	  
               <h:panelGrid columns="1" style="z-index:0;" rendered="#{vmbean.blockedBy != null}">   
	               	<h:column>  
	               		<h:commandLink id="showHidePrereqs-icon" action="#{listModulesPage.showHidePrerequisite}" immediate="true">   	  
	               			<h:graphicImage id="pre-req" value="/images/lock.png" alt="#{msgs.list_modules_locked}" title="#{msgs.list_modules_locked}"  styleClass="ExpClass"/>
	             		</h:commandLink> 
	             	</h:column>
	             	<h:column>
	             		<h:commandLink id="showHidePrereqs" action="#{listModulesPage.showHidePrerequisite}" immediate="true">
	       					<h:outputText value="#{msgs.list_modules_prereq}" styleClass="style3"/>         
	       				</h:commandLink> 
	       				<h:panelGrid id="preReqMsg" columns="1" border="1" rules="cols" bgcolor="#FFFFCC" cellpadding="5" width="300px" styleClass="prereqInvalidAlert" rendered="#{vmbean.blockedBy != null && listModulesPage.showPrerequisiteFlag == true && listModulesPage.showPrereqModuleId == vmbean.moduleId}" >   
			               	<h:column>     	  
			               		<h:outputText value="#{msgs.prerequisite_msg}" /> <h:outputText value="#{vmbean.blockedDetails}" />
			             	</h:column>
			             	<h:column>
			             		  <h:graphicImage id="bul_gif" value="/images/bullet_black.gif" /><h:outputText value="#{vmbean.blockedBy}" />
			        	   </h:column> 	
			        	   <h:column>
			             		  <h:commandButton value="#{msgs.prerequisite_ok_msg}" action="#{listModulesPage.hidePrerequisite}" styleClass="BottomImgFinish"/>
			        	   </h:column>
	 	 	  			 </h:panelGrid>   
	        	   </h:column> 	
	 	 	   </h:panelGrid> 	 	 	 
               <h:graphicImage id="closed_gif" value="/images/view_closed.gif" alt="#{msgs.list_modules_inst_closed}" title="#{msgs.list_modules_inst_closed}" rendered="#{vmbean.closedBeforeFlag == listModulesPage.trueFlag}" styleClass="ExpClass"/>
               <h:graphicImage id="cal_gif" value="/images/cal.gif" alt="#{msgs.list_modules_inst_notyetopen}" title="#{msgs.list_modules_inst_notyetopen}" rendered="#{vmbean.openLaterFlag == listModulesPage.trueFlag}" styleClass="ExpClass"/>
               <h:outputText id="brval" value="<BR>" escape="false" rendered="#{vmbean.openLaterFlag == listModulesPage.trueFlag}"/>
               <h:outputText value="#{msgs.notyetopen_msg}" rendered="#{vmbean.openLaterFlag == listModulesPage.trueFlag}" styleClass="style3"/>
           </h:column>
           <h:column>
             <f:facet name="header">
               <h:outputText value="#{msgs.list_modules_inst_start_date}" />
             </f:facet>
			  <h:outputText id="startDate0" value="-" rendered="#{vmbean.startDate == null}" />
              
              <h:outputText id="startDate" value="#{vmbean.startDate}" rendered="#{vmbean.visibleFlag == listModulesPage.trueFlag}">
                <f:convertDateTime pattern="MMM d, yyyy" />            
	           </h:outputText>
	           <h:outputText id="startDate_1" value="</br>" escape="false" rendered="#{vmbean.visibleFlag == listModulesPage.trueFlag}"/>
	            <h:outputText id="startDate_2" value="#{vmbean.startDate}" rendered="#{vmbean.visibleFlag == listModulesPage.trueFlag}">
	                <f:convertDateTime type="time" timeStyle="short" />
	            </h:outputText>
          
             <h:outputText id="startDate2" value="#{vmbean.startDate}" rendered="#{!vmbean.visibleFlag}" styleClass="italics">
                <f:convertDateTime pattern="MMM d, yyyy" />              
	          </h:outputText>
	          <h:outputText id="startDate2_1" value="</br>" escape="false" rendered="#{!vmbean.visibleFlag}" styleClass="italics"/>
	          <h:outputText id="startDate2_2" value="#{vmbean.startDate}" rendered="#{!vmbean.visibleFlag}" styleClass="italics">
	                <f:convertDateTime type="time" timeStyle="short" />
	            </h:outputText>            
           </h:column>
            <h:column>
              <f:facet name="header">
                <h:outputText value="#{msgs.list_modules_inst_end_date}" />
              </f:facet>  
			 <h:outputText id="endDate0" value="-" rendered="#{vmbean.endDate == null}" />
              
              <h:outputText id="endDate" value="#{vmbean.endDate}" rendered="#{vmbean.visibleFlag == listModulesPage.trueFlag}">
                <f:convertDateTime pattern="MMM d, yyyy" />            
	           </h:outputText>
	           <h:outputText id="endDate_1" value="</br>" escape="false" rendered="#{vmbean.visibleFlag == listModulesPage.trueFlag}"/>
	            <h:outputText id="endDate_2" value="#{vmbean.endDate}" rendered="#{vmbean.visibleFlag == listModulesPage.trueFlag}">
	                <f:convertDateTime type="time" timeStyle="short" />
	            </h:outputText>
          
             <h:outputText id="endDate2" value="#{vmbean.endDate}" rendered="#{!vmbean.visibleFlag}" styleClass="italics">
                <f:convertDateTime pattern="MMM d, yyyy" />              
	          </h:outputText>
	          <h:outputText id="endDate2_1" value="</br>" escape="false" rendered="#{!vmbean.visibleFlag}" styleClass="italics"/>
	          <h:outputText id="endDate2_2" value="#{vmbean.endDate}" rendered="#{!vmbean.visibleFlag}" styleClass="italics">
	                <f:convertDateTime type="time" timeStyle="short" />
	            </h:outputText>           
   	 </h:column>   
   	  <h:column>
              <f:facet name="header">
                <h:outputText value="#{msgs.list_modules_inst_viewed_date}" />
              </f:facet>  
               <h:outputText id="viewDate0" value="-" rendered="#{vmbean.readDate == null}" />
              
              <h:outputText id="viewDate" value="#{vmbean.readDate}" rendered="#{vmbean.visibleFlag == listModulesPage.trueFlag}">
                <f:convertDateTime pattern="MMM d, yyyy" />            
	           </h:outputText>
	           <h:outputText id="viewDate_1" value="</br>" escape="false" rendered="#{vmbean.visibleFlag == listModulesPage.trueFlag}"/>
	            <h:outputText id="viewDate_2" value="#{vmbean.readDate}" rendered="#{vmbean.visibleFlag == listModulesPage.trueFlag}">
	                <f:convertDateTime type="time" timeStyle="short" />
	            </h:outputText>
          
             <h:outputText id="viewDate2" value="#{vmbean.readDate}" rendered="#{!vmbean.visibleFlag}" styleClass="italics">
                <f:convertDateTime pattern="MMM d, yyyy" />              
	          </h:outputText>
	          <h:outputText id="viewDate2_1" value="</br>" escape="false" rendered="#{!vmbean.visibleFlag}" styleClass="italics" />
	          <h:outputText id="viewDate2_2" value="#{vmbean.readDate}" rendered="#{!vmbean.visibleFlag}" styleClass="italics" >
	                <f:convertDateTime type="time" timeStyle="short" />
	            </h:outputText>      
   	 </h:column>   
      <h:column> 
      		<f:facet name="header">
               <h:outputText value="&nbsp;" escape="false"/>
             </f:facet>
         <h:outputLink id="printModuleLink" value="list_modules_inst" onclick="OpenPrintWindow(#{listModulesPage.printModuleId},'Melete Print Window');" rendered="#{listModulesPage.printable && vmbean.visibleFlag}">
	  	    	<h:graphicImage id="printImgLink" value="/images/printer.png" alt="#{msgs.list_auth_modules_alt_print}" title="#{msgs.list_auth_modules_alt_print}" styleClass="AuthImgClass"/>
	 	 </h:outputLink>
	    
	    </h:column>	     
      </h:dataTable> 
  
	    <div class="actionBar" align="left">&nbsp;</div> 	

<!--End Content-->
 </h:form>
</sakai:view>
</f:view>

