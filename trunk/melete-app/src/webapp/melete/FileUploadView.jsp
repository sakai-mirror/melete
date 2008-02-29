<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ taglib uri="http://sakaiproject.org/jsf/sakai" prefix="sakai" %>
<html>
<head>
<meta http-equiv="Content-Language" content="en-us">
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta name="description" content="ETUDES-NG Course Management System, Powered by Sakai">
<meta name="keywords" content="ETUDES-NG course management system, e-learning">


<title>Melete - File Upload</title>
<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
<script language="javascript1.2">
function fillupload()
{
	//var k =document.getElementById("file1").value;		
	//document.getElementById("AddSectionForm:ContentUploadView:filename").value=k;
}
function loadInputs()
{
  var str=document.getElementById("FileUploadForm:numitems").value;
  document.getElementById("FileUploadForm:number").selectedIndex=str-1;
  for (i=2; i<=str; i++)
  {
   document.getElementById("choose"+i).style.display='block';
  }   
}
function showInputs()
{
  var str=document.getElementById("FileUploadForm:number").value;
  
  for (i=2; i<=str; i++)
  {
     document.getElementById("choose"+i).style.display='block';
  }
  
  for (i=parseInt(str)+1; i<=10; i++)
  {
    document.getElementById("upload"+i).innerHTML="<INPUT TYPE=\"FILE\" id=\"file"+i+"\" NAME=\"file"+i+"\" /> <img src=\"images/remove_item.png\"/> <a id=\"remove"+i+"\" href=\"#\" onClick=\"javascript:clearItem("+i+")\">Remove item</a>";
    document.getElementById("choose"+i).style.display='none';
  }

}
function clearItem(id)
{
  alert('In clearItem '+id);
  document.getElementById("upload"+id).innerHTML="<INPUT TYPE=\"FILE\" id=\"file"+id+"\" NAME=\"file"+id+"\" /> <img src=\"images/remove_item.png\"/> <a id=\"remove"+id+"\" href=\"#\" onClick=\"javascript:clearItem("+id+")\">Remove item</a>";
  document.getElementById("choose"+id).style.display='none';
  var str=document.getElementById("FileUploadForm:number").selectedIndex;
  alert('str is '+str);
  if (str > 1) document.getElementById("FileUploadForm:number").selectedIndex=str-1;
  else document.getElementById("FileUploadForm:number").selectedIndex=0;
}
</script>
</head>

<f:view>
<body marginwidth="0" marginheight="0" topmargin="0" leftmargin="0" bottommargin="0" rightmargin="0" onload="loadInputs();setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');" >
 <h:form id="FileUploadForm">
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
		  <div class="meletePortletToolBarMessage"><img src="images/manage_content.png" width="16" height="16" align="absbottom" border="0"><h:outputText value="#{msgs.file_upload_title}" /></div>				
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
              		<h:outputText id="t2" value="#{msgs.manage_content_number}"/>
                	
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
		    <td colspan="2">
			<p>
			<div id="choose1" style="display:block">
			Choose a file
			<span id="upload1"><INPUT TYPE="FILE" id="file1" NAME="file1" />
			<img src="images/remove_item.png"/>
			<a id="remove1" href="#" onClick="javascript:clearItem(1)">Remove item</a>
			</span>
			</div>
		
			<div id="choose2" style="display:none">Choose a file
			<span id="upload2"><INPUT TYPE="FILE" id="file2" NAME="file2" />
			<img src="images/remove_item.png"/>
			<a id="remove2" href="#" onClick="javascript:clearItem(2)">Remove item</a>
			</span>
			</div>
		
			<div id="choose3" style="display:none">Choose a file
			<span id="upload3"><INPUT TYPE="FILE" id="file3" NAME="file3" />
			<img src="images/remove_item.png"/>
			<a id="remove3" href="#" onClick="javascript:clearItem(3)">Remove item</a>
			</span>
			</div>
		
			<div id="choose4" style="display:none">Choose a file
			<span id="upload4"><INPUT TYPE="FILE" id="file4" NAME="file4" />
			<img src="images/remove_item.png"/>
			<a id="remove4" href="#" onClick="javascript:clearItem(4)">Remove item</a>
			</span>
			</div>

            <div id="choose5" style="display:block">
			Choose a file
			<span id="upload5"><INPUT TYPE="FILE" id="file5" NAME="file5" />
			<img src="images/remove_item.png"/>
			<a id="remove5" href="#" onClick="javascript:clearItem(5)">Remove item</a>
			</span>
			</div>
		
			<div id="choose6" style="display:none">Choose a file
			<span id="upload6"><INPUT TYPE="FILE" id="file6" NAME="file6" />
			<img src="images/remove_item.png"/>
			<a id="remove6" href="#" onClick="javascript:clearItem(6)">Remove item</a>
			</span>
			</div>
		
			<div id="choose7" style="display:none">Choose a file
			<span id="upload7"><INPUT TYPE="FILE" id="file7" NAME="file7" />
			<img src="images/remove_item.png"/>
			<a id="remove7" href="#" onClick="javascript:clearItem(7)">Remove item</a>
			</span>
			</div>
		
			<div id="choose8" style="display:none">Choose a file
			<span id="upload8"><INPUT TYPE="FILE" id="file8" NAME="file8" />
			<img src="images/remove_item.png"/>
			<a id="remove8" href="#" onClick="javascript:clearItem(8)">Remove item</a>
			</span>
			</div>			
			
            <div id="choose9" style="display:none">Choose a file
			<span id="upload9"><INPUT TYPE="FILE" id="file9" NAME="file9" />
			<img src="images/remove_item.png"/>
			<a id="remove9" href="#" onClick="javascript:clearItem(9)">Remove item</a>
			</span>
			</div>	
			
			<div id="choose10" style="display:none">Choose a file
			<span id="upload10"><INPUT TYPE="FILE" id="file10" NAME="file10" />
			<img src="images/remove_item.png"/>
			<a id="remove10" href="#" onClick="javascript:clearItem(10)">Remove item</a>
			</span>
			</div>	
			</p>
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



