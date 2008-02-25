<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
<%@ page import="org.sakaiproject.tool.melete.MeleteSiteAndUserInfo,org.sakaiproject.tool.melete.AuthorPreferencePage"%>
<%
final javax.faces.context.FacesContext facesContext = javax.faces.context.FacesContext.getCurrentInstance();

final MeleteSiteAndUserInfo meleteSiteAndUserInfo = (MeleteSiteAndUserInfo)facesContext.getApplication().getVariableResolver().resolveVariable(facesContext, "meleteSiteAndUserInfo");

final AuthorPreferencePage authorPreferencePage = (AuthorPreferencePage)facesContext.getApplication().getVariableResolver().resolveVariable(facesContext, "authorPreferences");

String browseloca = meleteSiteAndUserInfo.getRemoteBrowseLocation() ;
String browselinkloca = meleteSiteAndUserInfo.getRemoteLinkBrowseLocation() ;
String docloca =  meleteSiteAndUserInfo.getMeleteDocsLocation() ;
String saveloca =  meleteSiteAndUserInfo.getMeleteDocsSaveLocation() ;
String editorloca =  meleteSiteAndUserInfo.getEditorArchiveLocation() ;
String absloca = meleteSiteAndUserInfo.getAbsoluteTranslationLocation();
String translationfile = meleteSiteAndUserInfo.getTranslationFile();
boolean renderSferyx = authorPreferencePage.isShouldRenderSferyx();
boolean dispSferyx = authorPreferencePage.isDisplaySferyx();
boolean showSferyx = renderSferyx && dispSferyx;
%>

<SCRIPT type="text/javascript" LANGUAGE="JavaScript">
<!--
    var _info = navigator.userAgent;
    var _ie = (_info.indexOf("MSIE") > 0 && _info.indexOf("Win") > 0 && _info.indexOf("Windows 3.1") < 0);
if(<%=showSferyx %>){
     if(!_ie)
		{
				document.writeln('<applet code="sferyx.administration.editors.HTMLEditor" archive="<%=editorloca%>"  id="editor" WIDTH = "740" HEIGHT = "600" name="htmleditor">');
if(_info.indexOf("Firefox") > 0) {
document.writeln('<PARAM name="useCookie"  value="' + document.cookie+ '">');
}
}
else
{
document.writeln('<OBJECT classid="clsid:8AD9C840-044E-11D1-B3E9-00805F499D93" id="editor" WIDTH = "740" HEIGHT = "600" NAME = "htmleditor" style="visibility:visible" codebase="http://java.sun.com/products/plugin/autodl/jinstall-1_4-win.cab#Version=1,4,0,0">');
document.writeln('<PARAM NAME = "CODE" VALUE = "sferyx.administration.editors.HTMLEditor">');
document.writeln('<PARAM NAME = "ARCHIVE" VALUE = "HTMLEditorAppletEnterprise.jar">');
document.writeln('<PARAM NAME="type" VALUE="application/x-java-applet;version=1.4">');
document.writeln('<PARAM NAME="scriptable" VALUE="true">');
}
				document.writeln('<PARAM NAME = "image" VALUE = "false">');
				document.writeln('<PARAM NAME = "boxmessage" VALUE ="Please wait while HTMLEditor is loading">');
				document.writeln('<PARAM NAME = "progressbar" VALUE = "true">');
              	document.writeln('<PARAM NAME = "boxbgcolor" VALUE = "#FFFFFF">');
		            document.writeln('<PARAM NAME="scriptable" VALUE="true">');
				document.writeln('<PARAM NAME = "variableName" VALUE="html_content">');
				document.writeln('<PARAM name="saveURL" VALUE="<%=saveloca%>">');
				document.writeln('<PARAM NAME = "uploadContentAsMultipartFormData" VALUE="true">');
				document.writeln('<PARAM NAME="saveEntireFile" VALUE="false">');
				document.writeln('<PARAM NAME="useSaveAsSaveRemote" VALUE="true">');
				document.writeln('<PARAM NAME ="supressRemoteFileDialog" VALUE="false">');
				document.writeln('<PARAM NAME ="supressLocalFileDialog" VALUE="false">');
				document.writeln('<PARAM NAME ="remoteBrowseLocation" VALUE="<%=browseloca%>">');
				document.writeln('<PARAM NAME ="remoteLinksBrowseLocation" VALUE="<%=browselinkloca%>">');
				document.writeln('<PARAM NAME ="absoluteDocumentTranslationURL" VALUE="<%=absloca%>">');
				document.writeln('<PARAM NAME ="uploadedObjectsTranslationPath" VALUE="<%=docloca%>">');
				document.writeln('<PARAM NAME ="variableName" VALUE="html_content">');
				document.writeln('<PARAM NAME ="menusToRemove" VALUE="menuFile,menuForm">');
				document.writeln('<PARAM NAME ="statusbarVisible" VALUE="false">');
				document.writeln('<PARAM NAME ="menuItemsToRemove" VALUE="insertFormFieldTextBoxMenuItem, insertFormFieldTextAreaMenuItem, insertFormFieldCheckBoxMenuItem, insertFormFieldRadioButtonMenuItem,insertFormFieldDropDownMenuItem, insertFormFieldPushButtonMenuItem,insertFormFieldImageButtonMenuItem,pagePropertiesMainMenuItem">');
				document.writeln('<PARAM NAME ="toolbarItemsToRemove" VALUE="saveFileButton,openFileButton,newFileButton">');
				document.writeln('<PARAM NAME="loadInterfaceLanguageFile" VALUE="<%=translationfile%>">');
if(!_ie)
{	
	document.writeln('</applet>');
	}
else
{
		document.writeln('<COMMENT>');
		document.writeln('</COMMENT>');
		document.writeln('</OBJECT>');
}
}
//--></SCRIPT>
