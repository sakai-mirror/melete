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
  alert('In clearItem '+id);
  var str=document.getElementById("LinkUploadForm:number").selectedIndex;
  alert('str is '+str);
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
</script>
</head>

<f:view>
<body marginwidth="0" marginheight="0" topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" onload="loadInputs();setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');" >
 <h:form id="LinkUploadForm">
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
                	
						  <h:selectOneMenu id="number" value="#{addResourcesPage.numberItems}" onchange="showInputs();" >
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
	
			<table>
			<tr id="urlrow1">
			  <td width="15%" align="left">
			  <img src="images/url.gif"/>
			  <b><span class="required">*</span></b> URL 
			  </td>
			  <td width="40%">
			    <input type="text" id="link1" size="40">
			  </td>
			  <td width="35%">
			  <img src="images/remove_item.png"/>
			  <span id="remove1">
			  <a  href="#" onClick="javascript:clearItem(1)">Remove item</a>
			  </span>
			  </td>
		      <td width="10%">
		      &nbsp;
		      </td>
			</tr>
            <tr id="titlerow1">
			  <td width="15%" align="left">
			  <b><span class="required">*</span></b> Title 
			  </td>
			  <td width="40%">
			    <input type="text" id="title1" size="40">
			  </td>
			  <td width="45%">
		      &nbsp;
		      </td>
			</tr>		
			<tr id="urlrow2" style="display:none">
			  <td width="15%" align="left">
			  <img src="images/url.gif"/>
			  <b><span class="required">*</span></b> URL 
			  </td>
			  <td width="40%">
			    <input type="text" id="link2" size="40">
			  </td>
			  <td width="35%">
			  <img src="images/remove_item.png"/>
			  <span id="remove2">
			  <a href="#" onClick="javascript:clearItem(2)">Remove item</a>
			  </span>
			  </td>
		      <td width="10%">
		      &nbsp;
		      </td>
			</tr>
            <tr id="titlerow2" style="display:none">
			  <td width="15%" align="left">
			  <b><span class="required">*</span></b> Title 
			  </td>
			  <td width="40%">
			    <input type="text" id="title2" size="40">
			  </td>
			  <td width="45%">
		      &nbsp;
		      </td>
			</tr>			
            <tr id="urlrow3" style="display:none">
			  <td width="15%" align="left">
			  <img src="images/url.gif"/>
			  <b><span class="required">*</span></b> URL 
			  </td>
			  <td width="40%">
			    <input type="text" id="link3" size="40">
			  </td>
			  <td width="35%">
			  <img src="images/remove_item.png"/>
			  <span id="remove3">
			  <a href="#" onClick="javascript:clearItem(3)">Remove item</a>
			  </span>
			  </td>
		      <td width="10%">
		      &nbsp;
		      </td>
			</tr>
            <tr id="titlerow3" style="display:none">
			  <td width="15%" align="left">
			  <b><span class="required">*</span></b> Title 
			  </td>
			  <td width="40%">
			    <input type="text" id="title3" size="40">
			  </td>
			  <td width="45%">
		      &nbsp;
		      </td>
			</tr>
            <tr id="urlrow4" style="display:none">
			  <td width="15%" align="left">
			  <img src="images/url.gif"/>
			  <b><span class="required">*</span></b> URL 
			  </td>
			  <td width="40%">
			    <input type="text" id="link4" size="40">
			  </td>
			  <td width="35%">
			  <img src="images/remove_item.png"/>
			  <span id="remove4">
			  <a href="#" onClick="javascript:clearItem(4)">Remove item</a>
			  </span>
			  </td>
		      <td width="10%">
		      &nbsp;
		      </td>
			</tr>
            <tr id="titlerow4" style="display:none">
			  <td width="15%" align="left">
			  <b><span class="required">*</span></b> Title 
			  </td>
			  <td width="40%">
			    <input type="text" id="title4" size="40">
			  </td>
			  <td width="45%">
		      &nbsp;
		      </td>
			</tr>
            <tr id="urlrow5" style="display:none">
			  <td width="15%" align="left">
			  <img src="images/url.gif"/>
			  <b><span class="required">*</span></b> URL 
			  </td>
			  <td width="40%">
			    <input type="text" id="link5" size="40">
			  </td>
			  <td width="35%">
			  <img src="images/remove_item.png"/>
			  <span id="remove5">
			  <a href="#" onClick="javascript:clearItem(5)">Remove item</a>
			  </span>
			  </td>
		      <td width="10%">
		      &nbsp;
		      </td>
			</tr>
            <tr id="titlerow5" style="display:none">
			  <td width="15%" align="left">
			  <b><span class="required">*</span></b> Title 
			  </td>
			  <td width="40%">
			    <input type="text" id="title5" size="40">
			  </td>
			  <td width="45%">
		      &nbsp;
		      </td>
			</tr>
            <tr id="urlrow6" style="display:none">
			  <td width="15%" align="left">
			  <img src="images/url.gif"/>
			  <b><span class="required">*</span></b> URL 
			  </td>
			  <td width="40%">
			    <input type="text" id="link6" size="40">
			  </td>
			  <td width="35%">
			  <img src="images/remove_item.png"/>
			  <span id="remove6">
			  <a href="#" onClick="javascript:clearItem(6)">Remove item</a>
			  </span>
			  </td>
		      <td width="10%">
		      &nbsp;
		      </td>
			</tr>
            <tr id="titlerow6" style="display:none">
			  <td width="15%" align="left">
			  <b><span class="required">*</span></b> Title 
			  </td>
			  <td width="40%">
			    <input type="text" id="title6" size="40">
			  </td>
			  <td width="45%">
		      &nbsp;
		      </td>
			</tr>
            <tr id="urlrow7" style="display:none">
			  <td width="15%" align="left">
			  <img src="images/url.gif"/>
			  <b><span class="required">*</span></b> URL 
			  </td>
			  <td width="40%">
			    <input type="text" id="link7" size="40">
			  </td>
			  <td width="35%">
			  <img src="images/remove_item.png"/>
			  <span id="remove7">
			  <a href="#" onClick="javascript:clearItem(7)">Remove item</a>
			  </span>
			  </td>
		      <td width="10%">
		      &nbsp;
		      </td>
			</tr>
            <tr id="titlerow7" style="display:none">
			  <td width="15%" align="left">
			  <b><span class="required">*</span></b> Title 
			  </td>
			  <td width="40%">
			    <input type="text" id="title7" size="40">
			  </td>
			  <td width="45%">
		      &nbsp;
		      </td>
			</tr>
            <tr id="urlrow8" style="display:none">
			  <td width="15%" align="left">
			  <img src="images/url.gif"/>
			  <b><span class="required">*</span></b> URL 
			  </td>
			  <td width="40%">
			    <input type="text" id="link8" size="40">
			  </td>
			  <td width="35%">
			  <img src="images/remove_item.png"/>
			  <span id="remove8">
			  <a href="#" onClick="javascript:clearItem(8)">Remove item</a>
			  </span>
			  </td>
		      <td width="10%">
		      &nbsp;
		      </td>
			</tr>
            <tr id="titlerow8" style="display:none">
			  <td width="15%" align="left">
			  <b><span class="required">*</span></b> Title 
			  </td>
			  <td width="40%">
			    <input type="text" id="title8" size="40">
			  </td>
			  <td width="45%">
		      &nbsp;
		      </td>
			</tr>
            <tr id="urlrow9" style="display:none">
			  <td width="15%" align="left">
			  <img src="images/url.gif"/>
			  <b><span class="required">*</span></b> URL 
			  </td>
			  <td width="40%">
			    <input type="text" id="link9" size="40">
			  </td>
			  <td width="35%">
			  <img src="images/remove_item.png"/>
			  <span id="remove9">
			  <a href="#" onClick="javascript:clearItem(9)">Remove item</a>
			  </span>
			  </td>
		      <td width="10%">
		      &nbsp;
		      </td>
			</tr>
            <tr id="titlerow9" style="display:none">
			  <td width="15%" align="left">
			  <b><span class="required">*</span></b> Title 
			  </td>
			  <td width="40%">
			    <input type="text" id="title9" size="40">
			  </td>
			  <td width="45%">
		      &nbsp;
		      </td>
			</tr>
            <tr id="urlrow10" style="display:none">
			  <td width="15%" align="left">
			  <img src="images/url.gif"/>
			  <b><span class="required">*</span></b> URL 
			  </td>
			  <td width="40%">
			    <input type="text" id="link10" size="40">
			  </td>
			  <td width="35%">
			  <img src="images/remove_item.png"/>
			  <span id="remove10">
			  <a href="#" onClick="javascript:clearItem(10)">Remove item</a>
			  </span>
			  </td>
		      <td width="10%">
		      &nbsp;
		      </td>
			</tr>
            <tr id="titlerow10" style="display:none">
			  <td width="15%" align="left">
			  <b><span class="required">*</span></b> Title 
			  </td>
			  <td width="40%">
			    <input type="text" id="title10" size="40">
			  </td>
			  <td width="45%">
		      &nbsp;
		      </td>
			</tr>																											
			</table>
	        </td>
	     </tr>	
	     <tr>
	       <td colspan="2">
	       <div align="center">
	       <h:commandLink id="continueButton"  action="#{addResourcesPage.addItems}"  immediate="true" tabindex="9">
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



