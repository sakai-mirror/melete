/**********************************************************************************
 *
 * Copyright (c) 2008 Etudes, Inc.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Licensed under the Apache License, Version 2.0 (the "License"); you
 * may not use this file except in compliance with the License. You may
 * obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0 
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
 * implied. See the License for the specific language governing
 * permissions and limitations under the License. 
 *
 **********************************************************************************/

package org.sakaiproject.simpleti;

import java.util.Map;
import java.util.List;
import java.util.Properties;

import java.net.URL;
import java.net.URLEncoder;

import org.imsglobal.simplelti.XMLMap;
import org.imsglobal.simplelti.SimpleLTIUtil;
import org.sakaiproject.user.api.User;
import org.sakaiproject.user.cover.UserDirectoryService;
import org.sakaiproject.component.cover.ServerConfigurationService;
import org.sakaiproject.authz.cover.AuthzGroupService;
import org.sakaiproject.authz.api.AuthzGroup;
import org.sakaiproject.authz.cover.SecurityService;
import org.sakaiproject.site.api.Site;
import org.sakaiproject.site.cover.SiteService;
import org.sakaiproject.authz.api.GroupNotDefinedException;
import org.sakaiproject.entity.api.Reference;

/**
 * Some Utility code for Sakai Simple LTI
 */
public class SakaiSimpleLTI {

    public static final boolean verbosePrint = true;

    public static void dPrint(String str)
    {
        if ( verbosePrint ) System.out.println(str);
    }

    public static Properties doLaunch(String descriptor, String siteId, String resourceId)
    {
        Properties newMap = new Properties();
        newMap.setProperty("action", "launchresolve");
        // Map<String, String> tm = XMLMap.getMap(descriptor);
        Map<String,Object> tm = XMLMap.getFullMap(descriptor);

	dPrint("tm="+tm);
        if ( tm == null ) 
	{
		// TODO: Need to send back an error code
		return null;
	}

	// We demand an endpoint
        String lti2EndPoint = XMLMap.getString(tm,"/toolInstance/launchurl");
	if ( lti2EndPoint == null ) 
	{
		// TODO: Need to send back an error code
		return null;
	}

        String lti2ToolId = XMLMap.getString(tm,"/toolInstance/tool_id");
        String lti2LaunchTypes = XMLMap.getString(tm,"/toolInstance/accept_targets");

        String lti2Password = null;
        String lti2Resource = null;
        String lti2Widget = null;
        String lti2Height = null;
        String lti2Width = null;
        String lti2FrameHeight = null;

	// Loop throught the tool settings
	/*  <setting key="secret">secret</setting> */
        List<Map<String,Object>> theList = XMLMap.getList(tm, "/toolInstance/tool-settings/setting");
        for ( Map<String,Object> setting : theList) {
		// dPrint("Setting="+setting);
		String key = XMLMap.getString(setting,"/!key"); // Get the key atribute
		String value = XMLMap.getString(setting,"/"); // Get the value
		// dPrint("key="+key+" val="+value);
		if ( "secret".equals(key) ) lti2Password = value;
		if ( "resource".equals(key) ) lti2Resource = value;
		if ( "height".equals(key) ) lti2Height = value;
		if ( "width".equals(key) ) lti2Width = value;
		/*  <setting key="widget">on</setting> */
		if ( "widget".equals(key) ) lti2Widget = value;
		if ( "frameheight".equals(key) ) lti2FrameHeight = value;
	}

	// When in doubt be very secretive...
	if ( lti2Password == null ) lti2Password = "secret";

	User user = UserDirectoryService.getCurrentUser();
	dPrint("User="+user);
	if ( user == null ) return null;
	dPrint("UserId="+user.getId());
        // Get our org_id and org_secret
        String org_id = ServerConfigurationService.getString("simplelti.org_id", null);
        String org_secret = null;

        if ( org_id != null ) {
                org_secret = getOrgSecret(lti2EndPoint);
                dPrint("org_id="+org_id+" org_secret="+org_secret);
        }

        // Add Nonce
        SimpleLTIUtil.addNonce(newMap,lti2Password,org_id,org_secret);

        // Resource/launch level details
        newMap.setProperty("launch_resource_id",resourceId);

        // Only do this if there is not one specified
        if ( lti2ToolId != null ) {
                newMap.setProperty("launch_tool_id", lti2ToolId);
        }

        // Request a widget
        if ( "on".equals(lti2Widget) ) {
                newMap.setProperty("launch_targets","widget,iframe,post");
	} else if ( lti2LaunchTypes != null ) {
                newMap.setProperty("launch_targets",lti2LaunchTypes);
        } else {
                newMap.setProperty("launch_targets","iframe,post,widget");
        }

        if ( lti2Width != null ) {
                newMap.setProperty("launch_width",lti2Width);
        }
        if ( lti2Height != null ) {
                newMap.setProperty("launch_height",lti2Height);
        }

        // TODO: Think about anonymus
        if ( user != null )
        {
                newMap.setProperty("user_id",user.getId());
                newMap.setProperty("user_firstname",user.getFirstName());
                newMap.setProperty("user_lastname",user.getLastName());
                newMap.setProperty("user_fullname",user.getDisplayName());
                newMap.setProperty("user_displayid",user.getDisplayId());
                newMap.setProperty("user_email",user.getEmail());
                newMap.setProperty("user_locale","en_US"); // TODO: Really get this
        }


        String theRole = "Student";
        if ( SecurityService.isSuperUser() )
        {
                theRole = "Administrator";
        }
        else if ( SiteService.allowUpdateSite(siteId) )
        {
                theRole = "Instructor";
        }
        newMap.setProperty("user_role",theRole);

        Site site = null;
        try {
                site = SiteService.getSite(siteId);
        } catch (Exception e) {
                dPrint("Could retrieve siteId="+siteId);
        }

	dPrint("site="+site);

        if ( site != null ) {
                newMap.setProperty("course_id",site.getId());
		String title = site.getTitle();
                if ( title != null ) 
		{
			newMap.setProperty("course_title",title);
		}
                String desc = site.getShortDescription();
		if ( desc != null ) 
		{
                	newMap.setProperty("course_name",desc);
		}
                String courseRoster = getExternalRealmId(site.getId());
                if ( courseRoster != null )
                {
                        newMap.setProperty("course_code",courseRoster);
                }
                // Hack for now - someday we will look deeper to find the precise user roster
                if ( courseRoster != null ) newMap.setProperty("user_roster",courseRoster);
        }

        if( lti2Resource != null && lti2Resource.length() > 0 ) {
                newMap.setProperty("launch_resource_url",lti2Resource);
        }
/*
        newMap.put("org_title", ServerConfigurationService.getString("simplelti.org_title",null));
        newMap.put("org_name", ServerConfigurationService.getString("simplelti.org_name",null));
        newMap.put("org_url", ServerConfigurationService.getString("simplelti.org_url",null));
*/
	dPrint(" Calling doLaunch newMap = "+newMap);
	// Do the non-Sakai bits of Launch
	Properties pro = SimpleLTIUtil.doLaunch(lti2EndPoint, newMap);

System.out.println("pro="+pro);
	// launchurl=http://www.youtube.com/v/f90ysF9BenI, status=success, type=iFrame

	String status = pro.getProperty("status");
	String launchurl = pro.getProperty("launchurl");
	if ( ! "success".equalsIgnoreCase(status) )
	{
		return pro;
	}
	String theType = pro.getProperty("type");
System.out.println("theType="+theType);
	// Check to see if we got a POST
 	String htmltext = null;
	if ( "iframe".equalsIgnoreCase(theType) ) 
	{
		// Not good
		if ( launchurl == null ) return pro;
		StringBuffer text = new StringBuffer();
		text.append("<iframe ");
		text.append("title=\"Site Info\" ");
		if ( lti2FrameHeight == null ) lti2FrameHeight = "1200";
		text.append("height=\""+lti2FrameHeight+"\" \n");
		text.append("width=\"100%\" frameborder=\"0\" marginwidth=\"0\"\n");
		text.append("marginheight=\"0\" scrolling=\"auto\"\n");
		text.append("src=\""+launchurl+"\">\n");
		text.append("Your browser does not support iframes. <br>");
		text.append("<a href=\""+launchurl+"\" target=\"_new\">Press here for content</a>\n");
		text.append("</iframe>");
		htmltext = text.toString();
		pro.setProperty("htmltext",htmltext);
        }
	else if ( "widget".equalsIgnoreCase(theType) ) 
	{
		htmltext = pro.getProperty("launchwidget");
System.out.println("widget htext="+htmltext);
		pro.setProperty("htmltext",htmltext);
	}
	else  // Post or otherwise
	{
		// Not good
		if ( launchurl == null ) return pro;
		StringBuffer text = new StringBuffer();
		text.append(postText1);
		text.append("<form action=\""+launchurl+"\" name=\"ltiLaunchForm\" method=\"post\">\n" );
        	for(Object okey : newMap.keySet() ) 
		{
                	if ( ! (okey instanceof String) ) continue;
                	String key = (String) okey;
                	if ( key == null ) continue;
                	String value = newMap.getProperty(key);
                	if ( value == null ) continue;
			if ( "action".equalsIgnoreCase(key) ) continue;
                	if ( value.equals("") ) continue;
                	// Should this be UTF-8 ???
                	// value = URLEncoder.encode(value);
                	// key = URLEncoder.encode(key);
			text.append("<input type=\"hidden\" size=\"40\" name=\"");
			text.append(key);
			text.append("\" value=\"");
			text.append(value);
			text.append("\"/>\n");
		}
		text.append(postText2);
		htmltext = text.toString();
		pro.setProperty("htmltext",htmltext);
	}
	return pro;
    }

    private final static String postText1 = 
"<head>\n" +
"  <script language=\"javascript\"> \n" +
"    function go() { \n" +
"        /* document.ltiLaunchForm.submit(); */ \n" +
"    } \n" +
" </script> \n" +
"</head>\n" +
"<body onLoad=\"go()\">\n";

    private final static String postText2 = 
" <input type=\"hidden\" size=\"40\" name=\"action\" value=\"direct\"/>\n" +
" <input type=\"submit\" value=\"Continue\">  If you are not redirected in 15 seconds press Continue.\n" +
"</form>\n";





    private static String getExternalRealmId(String siteId) {
	String realmId = SiteService.siteReference(siteId);
	String rv = null;
	try {
		AuthzGroup realm = AuthzGroupService.getAuthzGroup(realmId);
		rv = realm.getProviderGroupId();
	} catch (GroupNotDefinedException e) {
		dPrint("SiteParticipantHelper.getExternalRealmId: site realm not found"+e.getMessage());
	}
	return rv;
    } // getExternalRealmId

        // String org_secret = ServerConfigurationService.getString("simplelti.org_secret");
        private static String getOrgSecret(String launchUrl)
        {
                String default_secret = ServerConfigurationService.getString("simplelti.org_secret",null);
                dPrint("launchUrl = "+launchUrl);
                URL url = null;
                try {
                        url = new URL(launchUrl);
                }
                catch (Exception e) {
                        url = null;
                }

                if ( url == null ) return default_secret;

                String hostName = url.getHost();
                dPrint("host = "+hostName);
                if ( hostName == null || hostName.length() < 1 ) return default_secret;

                // Look for the property starting with the full name
                String org_secret = ServerConfigurationService.getString("simplelti.org_secret."+hostName,null);
                if ( org_secret != null ) return org_secret;
                for ( int i = 0; i < hostName.length(); i++ ) {
                        if ( hostName.charAt(i) != '.' ) continue;
                        if ( i > hostName.length()-2 ) continue;
                        String hostPart = hostName.substring(i+1);
                        String propName = "simplelti.org_secret."+hostPart;
                        org_secret = ServerConfigurationService.getString(propName,null);
                        if ( org_secret != null ) return org_secret;
                }
                return default_secret;
        }

   
}
