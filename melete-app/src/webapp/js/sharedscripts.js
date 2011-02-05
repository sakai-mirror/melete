// Function that opens bookmark window
function OpenBookmarkWindow(section_id, section_title, windowName)
{
	
  var _info = navigator.userAgent;
  var _ie = (_info.indexOf("MSIE") > 0 && _info.indexOf("Win") > 0 && _info.indexOf("Windows 3.1") < 0);
	var windowDefaults = "status=no, menubar=no, location=no, scrollbars=yes, resizeable=yes, width=700, height=600, left=500, top=20";
	var newWindow;
	if(!_ie) newWindow = window.open('add_bookmark.jsf?sectionId='+section_id+'&sectionTitle='+section_title,windowName,windowDefaults);
	else newWindow = window.open('add_bookmark.jsf?sectionId='+section_id+'&sectionTitle='+section_title,null,windowDefaults);
if (window.focus) { newWindow.focus(); } ; // force the window to the front if the browser supports it
return newWindow;

}

//Function that opens print window
function OpenPrintWindow(print_id, windowName)
{
	
  var _info = navigator.userAgent;
  var _ie = (_info.indexOf("MSIE") > 0 && _info.indexOf("Win") > 0 && _info.indexOf("Windows 3.1") < 0);
	var windowDefaults = "status=no, menubar=no, location=no, scrollbars=yes, resizeable=yes, width=800, height=700, left=20, top=20";
	var newWindow;
	if(!_ie) newWindow = window.open('print_module.jsf?printModuleId='+print_id,windowName,windowDefaults);
	else newWindow = window.open('print_module.jsf?printModuleId='+print_id,null,windowDefaults);
if (window.focus) { newWindow.focus(); } ; // force the window to the front if the browser supports it
return newWindow;

}

//Function that opens print window
function OpenPreReqWindow(blockStr, windowName)
{
	 var _info = navigator.userAgent;
	 var width=350;
	 var height = 120;
	  var left   = (screen.width  - width)/2;
 	var top    = (screen.height - height)/2;
	 
  var _ie = (_info.indexOf("MSIE") > 0 && _info.indexOf("Win") > 0 && _info.indexOf("Windows 3.1") < 0);
	var windowDefaults1 = "status=no, menubar=no, directories=no,location=no, scrollbars=no, resizeable=no, width=350, height=120, left="+left+", top=" + top +", modal=yes";
	var newWindow1;
	if(!_ie) newWindow1 = window.open('list_prerequisite.jsf?blockMsg='+blockStr,windowName,windowDefaults1);
	else newWindow1 = window.open('list_prerequisite.jsf?blockMsg='+blockStr,null,windowDefaults1);
if (window.focus) { newWindow1.focus(); } ; // force the window to the front if the browser supports it
return newWindow1;
}

