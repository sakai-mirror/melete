<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>
<%@ page import="org.sakaiproject.tool.melete.ManageModulesPage"%>

<html><head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="description" content="ETUDES-NG Course Management System, Powered by Sakai">
<meta name="keywords" content="ETUDES-NG course management system, e-learning">

<link rel="stylesheet" type="text/css" href="rtbc004.css">
<title>Melete - Sort Sections</title>
<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
<script language="javascript">
function resetModuleSelection() {
      	var element = document.getElementById("SortSectionForm:currmodule");
		if ((document.referrer.substring(document.referrer.length-13,document.referrer.length) == "author_manage")||(document.referrer.substring(document.referrer.length-12,document.referrer.length) == "modules_sort"))
  
    	{
    		element.options[0].selected = true;
    	}
    	else
    	{
    	   return;
    	}  
}
</script>
</head>
<f:view>
<body marginwidth="0" marginheight="0" topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" onload="setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');resetModuleSelection();" >
<h:form id="SortSectionForm">
  <h:inputHidden id="formName" value="SortSectionForm"/>  
<!-- This Begins the Main Text Area -->

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
						<div class="meletePortletToolBarMessage"><img src="images/document_exchange.gif" alt="" width="16" height="16" align="absmiddle"><h:outputText value="#{msgs.sort_sections_top_message}" /></div>
					</td>
				</tr>
				<tr>
					<td class="maintabledata3" valign="top">
						<!-- main page contents -->
			 			<h:messages id="sorterror" layout="table" style="color : red" />
						<table width="100%"  border="1" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA" style="border-collapse: collapse">
			   				    <tr>
                    			<td colspan="3">
									<table width="40%"  border="0" cellspacing="0" cellpadding="0">
                				      <tr>
				                        <td class="style2"><h:outputText value="#{msgs.sort_modules_sort}" /> </td>
										<td><div>
										 <!-- Begin code to display images horizontally. -->
										   <h:commandLink id="sortmod"  action="#{manageModulesPage.goToSortModules}" immediate="true" >	
										 	<h:graphicImage id="sortModulesImg" value="images/Sort_Modules.gif" width="85" height="20" styleClass="BottomImgSpace" 
													onmouseover="this.src = 'images/Sort_Modules-over.gif'" 
													onmouseout="this.src = 'images/Sort_Modules.gif'" 
													onmousedown="this.src = 'images/Sort_Modules-down.gif'" 
													onmouseup="this.src = 'images/Sort_Modules-over.gif'"/>
											</h:commandLink>				
											<h:graphicImage id="Sort_Sections-horz" 
								   							alt="#{msgs.sort_sections_sort_sections}"
								   							url="images/Sort_Sections-down2.gif"
								     						 width="85" height="20" styleClass="BottomImgSpace"/>
								     						 
									
										<!-- End code to display images horizontally. -->
										</div></td>
									  </tr>
									</table>
								</td>
							  </tr>
							    <tr>
										<td colspan="3" height="30"><h:outputText value="#{msgs.sort_sections_choose_module}"/> 
							          <h:selectOneMenu id="currmodule" value="#{manageModulesPage.currModule}"  valueChangeListener="#{manageModulesPage.nextModuleSections}" onchange="this.form.submit();" style="width:420px">
															 <f:selectItems value="#{manageModulesPage.allModulesList}" />							
												 </h:selectOneMenu>													
										</td>
									  </tr>
							   <tr>
								<th class="tableheader style4 " height="20"><h:outputText value="#{msgs.sort_modules_curr_seq}" /> </th>
								<th class="tableheader">&nbsp;</th>
								<th class="tableheader style4" height="20"><h:outputText value="#{msgs.sort_modules_new_seq}" /></th>
							  </tr>
							  <tr>
								<td width="45%" valign="top" class="maintabledata3">
									<table align="center" width="80%"  border="1" cellpadding="3" cellspacing="0"  bordercolor="#EAEAEA" style="border-collapse: collapse" id="current">
									  <tr>
										<td width="100%" >
										<table width="100%" border="0" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" style="border-collapse: collapse">
											<tr>
											 <td align="left" >
												 <h:selectOneListbox id="sectioncurrList" disabled="true" size="#{manageModulesPage.showSize}" style="width:300px">
															 <f:selectItems value="#{manageModulesPage.currSecList}" />							
												 </h:selectOneListbox>
											   </td>
											</tr>
										</table></td> 
									</tr>
            		    		   </table>                      
		                    	  </td>
        			            <td width="6%" class="maintabledata3" ></td>
                    			<td width="49%" valign="top" class="maintabledata3">
									<table align="center" width="80%"  border="1" cellpadding="1" cellspacing="0" bordercolor="#CCCCCC" bgcolor="#EEEEEE" style="border-collapse: collapse" id="new">
									  <tr>
										 <td width="100%">
											<table width="100%" border="0" cellpadding="0" cellspacing="0" bordercolor="#FFFFFF" style="border-collapse: collapse">
											<tr>
                       						 <td align="left">
                       						 	 <h:selectOneListbox id="sectionnewList" value="#{manageModulesPage.newSelectedSection}" size="#{manageModulesPage.showSize}" style="width:300px">
															 <f:selectItems value="#{manageModulesPage.newSecList}" />							
													 </h:selectOneListbox>
											  </td>                        
											 </tr>
											</table></td> 
				                        <td width="15" align="center">
				                        <h:commandLink id="up_end"  action="#{manageModulesPage.MoveSectionItemAllUpAction}">	
										 <h:graphicImage id="upImg1" value="images/up_end.gif" alt="Move Up" width="20" height="20" styleClass="BottomImgSpace" />
								   </h:commandLink>	
				                    <h:commandLink id="up_one"  action="#{manageModulesPage.MoveSectionItemUpAction}">	
										 <h:graphicImage id="upImg" value="images/up.gif" alt="Move Up" width="20" height="20" styleClass="BottomImgSpace" />
								   </h:commandLink>		 
 									<h:commandLink id="down_one"  action="#{manageModulesPage.MoveSectionItemDownAction}">		 
										 <h:graphicImage id="downImg" value="images/down.gif" alt="Move Down" width="20" height="20" styleClass="BottomImgSpace" />
 									   </h:commandLink>	  
 									   <h:commandLink id="down_end"  action="#{manageModulesPage.MoveSectionItemAllDownAction}">		 
										 <h:graphicImage id="downImg_end" value="images/down_end.gif" alt="Move Down" width="20" height="20" styleClass="BottomImgSpace" />
 									   </h:commandLink>	 										 
									  </td>
				                      </tr>
                				    </table></td>
				                  </tr>                	
								 <tr><td colspan="3" class="maintabledata5">&nbsp;</td>
				 				</tr>
							</table>
							</td>
						</tr>
						</table> 
		  	<p>&nbsp;</p>

		</td>
  	</tr>
</table>
</h:form>
<!-- This Ends the Main Text Area -->

</body>
</f:view>
</html>	  