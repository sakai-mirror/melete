<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>
<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="description" content="ETUDES-NG Course Management System, Powered by Sakai">
<meta name="keywords" content="ETUDES-NG course management system, e-learning">


<title>Melete - Link Upload</title>

<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
<script language="javascript1.2">
function fillupload()
{
	//var k =document.getElementById("file1").value;		
	//document.getElementById("AddSectionForm:ContentUploadView:filename").value=k;
}
function loadInputs()
{
  var str=document.getElementById("LinkUploadForm:numitems").value;
  document.getElementById("LinkUploadForm:number").selectedIndex=str-1;
  for (i=2; i<=str; i++)
  {
   document.getElementById("urlrow"+i).style.display='block';
   document.getElementById("titlerow"+i).style.display='block';
  }   
}
function showInputs()
{
  var str=document.getElementById("LinkUploadForm:number").value;
  
  for (i=2; i<=str; i++)
  {
   document.getElementById("urlrow"+i).style.display='block';
   document.getElementById("titlerow"+i).style.display='block';
  }
  
  for (i=parseInt(str)+1; i<=10; i++)
  {
   document.getElementById("link"+i).value='';
   document.getElementById("title"+i).value='';
    document.getElementById("remove"+i).innerHTML="<a  href=\"#\" onClick=\"javascript:clearItem("+i+")\">Remove item</a>";
   document.getElementById("urlrow"+i).style.display='none';
   document.getElementById("titlerow"+i).style.display='none';
  }

}
function clearItem(id)
{
  var str=document.getElementById("LinkUploadForm:number").selectedIndex;
  document.getElementById("link"+id).value='';
  document.getElementById("title"+id).value='';
  document.getElementById("remove"+id).innerHTML="<a  href=\"#\" onClick=\"javascript:clearItem("+id+")\">Remove item</a>";  
  if (str >= 1)
  {
    document.getElementById("urlrow"+id).style.display='none';
    document.getElementById("titlerow"+id).style.display='none';
    document.getElementById("LinkUploadForm:number").selectedIndex=str-1;
  }  
  else
  { 
    document.getElementById("LinkUploadForm:number").selectedIndex=0;
  }  
}
function submitaction()
{
  
  document.forms[0].submit();
}
</script>
</head>

<f:view>
<body marginwidth="0" marginheight="0" topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" onload="setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');" >
 <h:form id="LinkUploadForm" enctype="multipart/form-data" >
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
		  <div class="meletePortletToolBarMessage"><img src="images/manage_content.png" width="16" height="16" align="absbottom" border="0"><h:outputText value="#{msgs.link_upload_title}" /></div>				
		</td>
        </tr>
        <tr>
        <td class="maintabledata3">
          <h:messages showDetail="true" showSummary="false" infoClass="BlueClass" errorClass="RedClass"/>
		  <table border="0" cellpadding="0" cellspacing="0" style="border-collapse: collapse" bordercolor="#EAEAEA" width="100%" id="AutoNumber1">
		  	<tr>
		  		<td height="20" class="maintabledata5"><h:outputText id="t1_1" value="#{msgs.manage_content_new_item}" styleClass="tableheader2"/> 
		  		</td>
		  	</tr>
            <tr>
            	<td colspan="2">
            	<h:inputHidden id="numitems" value="#{addResourcesPage.numberItems}" />
              		<h:outputText id="t2" value="#{msgs.manage_content_number_links}"/>
                	
						  <h:selectOneMenu id="number" value="#{addResourcesPage.numberItems}" onchange="submitaction();" valueChangeListener="#{addResourcesPage.updateNumber}"  >
						    <f:selectItem itemValue="1" itemLabel="#{msgs.manage_content_one}"/>	
							<f:selectItem itemValue="2" itemLabel="#{msgs.manage_content_two}"/>	
							<f:selectItem itemValue="3" itemLabel="#{msgs.manage_content_three}"/>	
							<f:selectItem itemValue="4" itemLabel="#{msgs.manage_content_four}"/>
							<f:selectItem itemValue="5" itemLabel="#{msgs.manage_content_five}"/>	
							<f:selectItem itemValue="6" itemLabel="#{msgs.manage_content_six}"/>
							<f:selectItem itemValue="7" itemLabel="#{msgs.manage_content_seven}"/>	
							<f:selectItem itemValue="8" itemLabel="#{msgs.manage_content_eight}"/>
							<f:selectItem itemValue="9" itemLabel="#{msgs.manage_content_nine}"/>	
							<f:selectItem itemValue="10" itemLabel="#{msgs.manage_content_ten}"/>
						 </h:selectOneMenu>
				</td>	
			</tr>
			<tr>
			  <td>
			  <br>
			  </td>
			</tr>	
			<tr>
		  		<td height="20" class="maintabledata5">&nbsp; 
		  		</td>
		  	</tr>
		  	<tr>
			  <td>
			  <br>
			  </td>
			</tr>	
          <tr>
		    <td colspan="2">
	
			<h:dataTable id="utTable"  value="#{addResourcesPage.utList}" var="ut" border="0" styleClass="maintabledata1"   width="80%" binding="#{addResourcesPage.table}">
			 
			   <h:column>
			   <h:graphicImage id="contenttype_gif" alt="#{msgs.link_upload_view_content}" value="images/url.gif" styleClass="ExpClass"/>
			    <h:outputText escape="false" value="&nbsp;*&nbsp;" styleClass="required"/>
		       <h:outputText id="urltext" escape="false" value="#{msgs.link_upload_view_url}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" />
                
                <h:inputText id="url" size="40" value="#{ut.url}" required="true"/>
                <h:outputText id="spc" escape="false" value="&nbsp;" />
                 <h:commandLink id="removeLink"  actionListener="#{addResourcesPage.removeLink}" action="#{addResourcesPage.redirectToLinkUpload}">  
                   <h:graphicImage id="remove_gif" alt="#{msgs.link_upload_remove_item}" value="images/remove_item.png" styleClass="ExpClass"/>
                    <h:outputText 	id="remove_text" value="#{msgs.link_upload_remove_item}"/>		
                  </h:commandLink>
                <h:outputText id="brval" escape="false" value="<BR>" />
                 <h:outputText escape="false" value="&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*&nbsp;" styleClass="required"/>
                <h:outputText id="titletext" escape="false" value="#{msgs.link_upload_view_title}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;"/>
               
                <h:inputText id="title" size="40" value="#{ut.title}"  required="true"/>
              </h:column>  
             
	        </h:dataTable>
	        </td>
	     </tr>	
         <tr>
	       <td colspan="2">
	       <b><span class="required">* Required</span></b>
	       <br>
	       <br>
	       </td>
	     </tr>	     
	     <tr>
	       <td colspan="2">
	       <div align="center">
	       <h:commandLink id="continueButton"  action="#{addResourcesPage.addItems}"  tabindex="9">
					<h:graphicImage id="continueImg" value="#{msgs.im_continue}" styleClass="BottomImgSpace" onclick="clearmessage()"
						onmouseover="this.src = '#{msgs.im_continue_over}'" 
						onmouseout="this.src = '#{msgs.im_continue}'" 
						onmousedown="this.src = '#{msgs.im_continue_down}'" 
						onmouseup="this.src = '#{msgs.im_continue_over}'"/>
                </h:commandLink>				
				<h:commandLink id="cancelButton"  action="#{addResourcesPage.cancel}"  immediate="true" tabindex="9">
					<h:graphicImage id="cancelImg" value="#{msgs.im_cancel}" styleClass="BottomImgSpace" onclick="clearmessage()"
						onmouseover="this.src = '#{msgs.im_cancel_over}'" 
						onmouseout="this.src = '#{msgs.im_cancel}'" 
						onmousedown="this.src = '#{msgs.im_cancel_down}'" 
						onmouseup="this.src = '#{msgs.im_cancel_over}'"/>
                </h:commandLink>
            </div>    	
	       </td>
	     </tr>
	    </table>
	   </td>
	  </tr>						
	</table>
	</td>
	</tr>									
   							
  </table>
</h:form>
<!-- This Ends the Main Text Area -->
</body>
</f:view>
</html>



