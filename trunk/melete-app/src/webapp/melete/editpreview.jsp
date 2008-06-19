<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>


<script type="text/javascript" language="JavaScript" src="js/headscripts.js"></script>
<title>Melete - Preview Section</title>
<script language="javascript1.2">
function showIframe()
{
 
	var str=document.getElementById("previewForm:contentType").value;	 
	if(str.match("typeEditor"))
	{
		document.getElementById("iframe1").style.visibility="hidden";
		document.getElementById("iframe1").style.display="none";
	}

}	

</script>
<f:view>
<body onLoad="showIframe(),setMainFrameHeight('<h:outputText value="#{meleteSiteAndUserInfo.winEncodeName}"/>');">
 	<h:form id="previewForm" > 	
     <table width="100%" border="1" align="center" cellpadding="3" cellspacing="0" bordercolor="#EAEAEA"  style="border-collapse: collapse">
          <tr>
            <td width="100%" height="20" >
				<!-- top nav bar -->		
				<f:subview id="top">
						<jsp:include page="topnavbar.jsp"/> 
				</f:subview>		
				<div class="meletePortletToolBarMessage"><img src="images/note_view.gif" alt="" width="24" height="24" align="absmiddle"><h:outputText value="#{msgs.edit_preview_previewing_section}" /></div>
		    </td>
		  </tr>
		  <tr>
		    <td colspan="2" height="20" class="maintabledata5">&nbsp;
		    </td>
		  </tr>	
		  <tr>
		    <td>
			<h:outputText value="#{msgs.edit_preview_previewing}" styleClass="bold" /> <h:outputText value="#{editSectionPage.module.title}" styleClass="bold"/>
			</td>
		  </tr>					
		
			  <tr><td>
						<h:outputText value="#{msgs.edit_preview_section}" />  <h:outputText value=" : " /> 	<h:outputText id="sec1" value="#{editSectionPage.section.title}"></h:outputText>
			  </td></tr>					
			  <tr><td>
						<h:outputText id="sec3" value="#{msgs.edit_preview_instruction}" rendered="#{editSectionPage.renderInstr}" styleClass="bold"></h:outputText> 
			  </td></tr>
			  <tr><td>
						<h:outputText id="sec2" value="#{editSectionPage.section.instr}" rendered="#{editSectionPage.renderInstr}"></h:outputText>
			  </td></tr>
			  <tr><td>
		      <h:inputHidden id="contentType" value="#{editSectionPage.section.contentType}"/>
			  <h:outputText id="typeEditorContents" value="#{editSectionPage.previewContentData}" escape="false"  rendered="#{editSectionPage.shouldRenderEditor}"></h:outputText>		
		        <br> 
		        <h:outputText id="secinstLink" 
                           value="#{msgs.edit_preview_clicking}" rendered="#{editSectionPage.shouldRenderLink}">
                </h:outputText> 
                <br>
                <br>
	            <h:outputLink id="viewSectionLink"  value="#{editSectionPage.previewContentData}" target="_blank" rendered="#{(editSectionPage.shouldRenderLink || editSectionPage.shouldRenderUpload) && editSectionPage.section.openWindow == true}">
                <h:outputText id="sectitleLink" 
                           value="#{editSectionPage.secResourceName}">
                </h:outputText>
                </h:outputLink>	
                <iframe  id="iframe1" src="<h:outputText value="#{editSectionPage.previewContentData}"  rendered="#{(editSectionPage.shouldRenderUpload || editSectionPage.shouldRenderLink) && editSectionPage.section.openWindow == false}"/>" style="visibility:visible" scrolling="auto" width="100%"  height="700" border="0" frameborder="0"></iframe>	
               				
		      </td></tr>
	       
			<tr><td><div align="center">
			
					<h:commandLink id="submitsave"  action="#{editSectionPage.save}">
					<h:graphicImage id="saveImg" value="#{msgs.im_save}" styleClass="BottomImgSpace" onclick="transferEditordata()"
						onmouseover="this.src = '#{msgs.im_save_over}'" 
						onmouseout="this.src = '#{msgs.im_save}'" 
						onmousedown="this.src = '#{msgs.im_save_down}'" 
						onmouseup="this.src = '#{msgs.im_save_over}'"/>
                </h:commandLink>			
		   				
			<h:commandLink id="cancelButton"  action="#{editSectionPage.cancelFromPreview}"  immediate="true">
					<h:graphicImage id="cancelImg" value="#{msgs.im_cancel}" styleClass="BottomImgSpace" 
						onmouseover="this.src = '#{msgs.im_cancel_over}'" 
						onmouseout="this.src = '#{msgs.im_cancel}'" 
						onmousedown="this.src = '#{msgs.im_cancel_down}'" 
						onmouseup="this.src = '#{msgs.im_cancel_over}'"/>
                </h:commandLink>
                 </div></td>
              </tr>
              <tr>
                <td height="20" bgcolor="#FFFFFF">&nbsp;
				</td>
              </tr>
              <tr>
                <td height="21" bgcolor="#FFFFFF"><div align="center"></div>
                    <div align="center">   				
   					<h:commandLink id="saveAddAnotherbutton"  action="#{editSectionPage.saveAndAddAnotherSection}">
						<h:graphicImage id="saveAddAnotherImg" value="#{msgs.im_add_another_section}" height="19" styleClass="BottomImgSpace" 
							onmouseover="this.src = '#{msgs.im_add_another_section_over}'" 
							onmouseout="this.src = '#{msgs.im_add_another_section}'" 
							onmousedown="this.src = '#{msgs.im_add_another_section_down}'" 
							onmouseup="this.src = '#{msgs.im_add_another_section_over}'"/>
	                </h:commandLink>				
					
				<h:commandLink id="FinishButton"  action="#{editSectionPage.Finish}">
						<h:graphicImage id="finishImg" value="#{msgs.im_finish}" height="19" styleClass="BottomImgSpace"
							onmouseover="this.src = '#{msgs.im_finish_over}'" 
							onmouseout="this.src = '#{msgs.im_finish}'" 
							onmousedown="this.src = '#{msgs.im_finish_down}'" 
							onmouseup="this.src = '#{msgs.im_finish_over}'" />
	                </h:commandLink>				
			</td></tr>			
         	 <tr><td>
         		 <table width="100%" height="20" border="0" cellpadding="3" cellspacing="0" >
   	         <tr>
	         <td align="center" class="meleteLicenseMsg center"><B>
             <!--License code Copyright-->
   <h:outputText id="lic1_val1" value="#{msgs.edit_preview_copyright}" 

rendered="#{editSectionPage.m_license.licenseCodes == 1}"/> 

      <h:outputText id="lic1_val2" value="#{editSectionPage.m_license.copyright_owner} " 

rendered="#{editSectionPage.m_license.licenseCodes == 1}"/> 
   <h:outputText id="lic1_val4" value=",#{editSectionPage.m_license.copyright_year}" rendered="#{((editSectionPage.m_license.licenseCodes == 1)&&(editSectionPage.m_license.copyright_year != editSectionPage.nullString))}"/> 

      <!--End license code Copyright-->
 <!--License code Public domain-->
   <h:outputText id="lic2_val1" value="#{msgs.edit_preview_dedicated_to}" 

rendered="#{editSectionPage.m_license.licenseCodes == 2}"/> 
   
   <h:outputText id="lic2_val2" value="#{msgs.edit_preview_public_domain}" 

rendered="#{editSectionPage.m_license.licenseCodes == 2}"/> 
   
   <h:outputText id="lic2_val3" value=",#{editSectionPage.m_license.copyright_owner} "  

rendered="#{((editSectionPage.m_license.licenseCodes == 2)&&(editSectionPage.m_license.copyright_owner != editSectionPage.nullString))}"/> 
  <h:outputText id="lic2_val5" value=",#{editSectionPage.m_license.copyright_year}" rendered="#{((editSectionPage.m_license.licenseCodes == 2)&&(editSectionPage.m_license.copyright_year != editSectionPage.nullString))}"/> 

 
      <!--End license code Public domain-->   
      <!--License code CC license-->
   <h:outputText id="lic3_val1" value="#{msgs.edit_preview_licensed_under}" 

rendered="#{editSectionPage.m_license.licenseCodes == 3}"/> 
   
   <h:outputText id="lic3_val2" value="#{msgs.edit_preview_creative_commons}" 

rendered="#{editSectionPage.m_license.licenseCodes == 3}"/>
    
   <h:outputText id="lic3_val3" value=",#{editSectionPage.m_license.copyright_owner} "  

rendered="#{((editSectionPage.m_license.licenseCodes == 3)&&(editSectionPage.m_license.copyright_owner != editSectionPage.nullString))}"/> 

   <h:outputText id="lic3_val5" value=",#{editSectionPage.m_license.copyright_year}" rendered="#{((editSectionPage.m_license.licenseCodes == 3)&&(editSectionPage.m_license.copyright_year != editSectionPage.nullString))}"/> 

      <!--End license code CC license-->     	
	 
        <!--License code fairuse license-->
      <h:outputText id="lic4_val2" value="#{msgs.edit_preview_fairuse}"  rendered="#{editSectionPage.m_license.licenseCodes == 4}"/>
       <h:outputText id="lic4_val3" value=",#{editSectionPage.m_license.copyright_owner} "  

rendered="#{((editSectionPage.m_license.licenseCodes == 4)&&(editSectionPage.m_license.copyright_owner != editSectionPage.nullString))}"/> 

   <h:outputText id="lic4_val5" value=",#{editSectionPage.m_license.copyright_year}" rendered="#{((editSectionPage.m_license.licenseCodes == 4)&&(editSectionPage.m_license.copyright_year != editSectionPage.nullString))}"/> 

         <!--End license code fairuse license-->             
              </B></TD></TR>
	         </TABLE>
         	 
         	 
         	 </td></tr>
			</table>

</h:form>

</body>
</f:view>
