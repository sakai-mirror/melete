<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<script language="javascript1.2">
function fillupload()
{
	var k =document.getElementById("file1").value;		
	document.getElementById("AddSectionForm:ContentUploadView:filename").value=k;
}
</script>
	
	
<table>
	<tr>
		<td colspan="2">
			<p>
			Choose a file
			<INPUT TYPE="FILE" id="file1" NAME="file1" style="visibility:visible" onChange="javascript:fillupload()"/>
				</br>
			Choose a file
			<INPUT TYPE="FILE" id="file2" NAME="file2" style="visibility:visible" onChange="javascript:fillupload()"/>
			
			</p>
	</td></tr>
	<tr>
	<td>&nbsp;</td>
	<td>	<h:outputText id="note" value="Note: You cannot upload files that are larger than #{manageContentPage.maxUploadSize}MB."  styleClass="comment red"/></td></tr>
</table>