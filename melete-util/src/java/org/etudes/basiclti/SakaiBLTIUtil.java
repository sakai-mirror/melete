/**********************************************************************************
 * $URL$
 * $Id$
 **********************************************************************************
 *
 * Copyright (c) 2008, 2009, 2014 Etudes, Inc.
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
 **********************************************************************************/

package org.etudes.basiclti;

import java.util.Map;
import java.util.Properties;
import java.util.UUID;

import java.net.URL;

import org.imsglobal.basiclti.BasicLTIUtil;
import org.etudes.linktool.LinkToolUtil;

// Sakai APIs
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.sakaiproject.tool.cover.ToolManager;
import org.sakaiproject.tool.api.Session;
import org.sakaiproject.tool.cover.SessionManager;
import org.sakaiproject.user.api.User;
import org.sakaiproject.user.cover.UserDirectoryService;
import org.sakaiproject.tool.cover.ToolManager;
import org.sakaiproject.tool.api.ToolSession;
import org.sakaiproject.site.api.ToolConfiguration;
import org.sakaiproject.tool.api.Placement;
import org.sakaiproject.authz.cover.SecurityService;
import org.sakaiproject.site.api.Site;
import org.sakaiproject.site.api.SitePage;
import org.sakaiproject.site.cover.SiteService;
import org.sakaiproject.exception.IdUnusedException;
import org.sakaiproject.tool.api.ActiveTool;
import org.sakaiproject.tool.cover.ActiveToolManager;
import org.sakaiproject.authz.cover.AuthzGroupService;
import org.sakaiproject.authz.api.AuthzGroup;
import org.sakaiproject.authz.api.GroupNotDefinedException;
import org.sakaiproject.entity.api.ResourceProperties;
import org.sakaiproject.component.cover.ServerConfigurationService;
import org.sakaiproject.util.ResourceLoader;

/**
 * Some Sakai Utility code for IMS Basic LTI
 * This is mostly code to support the Sakai conventions for 
 * making and launching BLTI resources within Sakai.
 */
public class SakaiBLTIUtil {

    private static Log M_log = LogFactory.getLog(SakaiBLTIUtil.class);

    public static void dPrint(String str)
    {
        // M_log.warn(str)
    }

    /**
     * Load url, key etc from placement
     * @param info
     * @param launch
     * @param placement
     * @return
     */
    public static boolean loadFromPlacement(Properties info, Properties launch, Placement placement)
    {
	Properties config = placement.getConfig();
	dPrint("Sakai properties=" + config);
        String launch_url = toNull(config.getProperty("imsti.launch", null));       
        
        if (config.containsKey("imsti.secret"))
        	setProperty(info, "secret", config.getProperty("imsti.secret", null) );
        else if (config.containsKey("secret"))
        {
        	setProperty(info, "secret", config.getProperty("secret", null) );
        	launch_url= config.getProperty("source", null);
        }
        
        if (config.containsKey("imsti.key"))
        	setProperty(info, "key", config.getProperty("imsti.key", null) );
        else if (config.containsKey("key"))
        {
        	setProperty(info, "key", config.getProperty("key", null) );
        	launch_url= config.getProperty("source", null);
        }   
        
        if ( launch_url == null ) {
            String xml = toNull(config.getProperty("imsti.xml", null));
            if ( xml == null ) return false;
	    BasicLTIUtil.parseDescriptor(info, launch, xml);
        }
        else  setProperty(info, "launch_url", launch_url);
     
    
        setProperty(info, "debug", config.getProperty("imsti.debug", null) );
        setProperty(info, "frameheight", config.getProperty("imsti.frameheight", null) );
        setProperty(info, "newwindow", config.getProperty("imsti.newwindow", null) );
        setProperty(info, "title", config.getProperty("imsti.tooltitle", null) );
        if ( info.getProperty("launch_url", null) != null || 
             info.getProperty("secure_launch_url", null) != null ) {
            return true;
        }
        return false;
    }
    
   public static boolean sakaiInfo(Properties props, Placement placement)
   {
	dPrint("placement="+ placement.getId());
	dPrint("placement title=" + placement.getTitle());
        String context = placement.getContext();
        dPrint("ContextID="+context);

        return sakaiInfo(props, context, placement.getId());
   }

   // Retrieve the Sakai information about users, etc.
   public static boolean sakaiInfo(Properties props, String context, String placementId)
   {

        Site site = null;
        try {
		site = SiteService.getSite(context);
        } catch (Exception e) {
                dPrint("No site/page associated with Launch context="+context);
                return false;
	}
                
	User user = UserDirectoryService.getCurrentUser();

	// Start setting the Basici LTI parameters
	setProperty(props,"resource_link_id",placementId);

	// TODO: Think about anonymus
	if ( user != null )
	{
		setProperty(props,"user_id",user.getId());
		setProperty(props,"launch_presentation_locale","en_US"); // TODO: Really get this
		setProperty(props,"lis_person_name_given",user.getFirstName());
		setProperty(props,"lis_person_name_family",user.getLastName());
		setProperty(props,"lis_person_name_full",user.getDisplayName());
		setProperty(props,"lis_person_contact_email_primary",user.getEmail());
		setProperty(props,"lis_person_sourcedid",user.getEid());
	}

	String theRole = "Learner";
	if ( SecurityService.isSuperUser() )
	{
		theRole = "Instructor";
	}
	else if ( SiteService.allowUpdateSite(context) ) 
	{
		theRole = "Instructor";
	}
	setProperty(props,"roles",theRole);

	if ( site != null ) {
		String context_type = site.getType();
		if ( context_type != null && context_type.toLowerCase().contains("course") ){
			setProperty(props,"context_type","CourseOffering");
		}
		setProperty(props,"context_id",site.getId());
		setProperty(props,"context_label",site.getTitle());
		setProperty(props,"context_title",site.getTitle());
		String courseRoster = getExternalRealmId(site.getId());
		if ( courseRoster != null ) 
		{
			setProperty(props,"lis_course_offering_sourced_id",courseRoster);
		}
	}

	// Get the organizational information
	setProperty(props,"tool_consumer_instance_guid", ServerConfigurationService.getString("basiclti.consumer_instance_guid",null));
	setProperty(props,"tool_consumer_instance_name", ServerConfigurationService.getString("basiclti.consumer_instance_name",null));
	setProperty(props,"tool_consumer_instance_url", ServerConfigurationService.getString("basiclti.consumer_instance_url",null));
	setProperty(props,"launch_presentation_return_url", ServerConfigurationService.getString("basiclti.consumer_return_url",null));
	return true;
    } 

   /**
    * Generic call to create lti form details
    * @param placementId 
    *  for non-melete tools required
    * @param contextId
    * @param resourceId
    * 	for melete resource or later mneme resource
    * @param info
    * @param launch
    * @param autoSubmit
    *  true when we want to submit automatically just like for Melete
    * @param props
    * 	resource properties used for connecting with Melete
    * @param rb
    * @param targetFrame
    * 	to open in window or iframe
    * @return
    */
	public static String[] postLaunchHTML(String placementId, String descriptor, String contextId, String resourceId, Properties info, Properties launch, boolean autoSubmit,
			ResourceProperties props, ResourceLoader rb, String targetFrame)
	{
		if (info == null) info = new Properties();
		if (launch == null) launch = new Properties();
		if (autoSubmit) launch.setProperty("autoSubmit", "true");

		if (resourceId != null && !sakaiInfo(launch, contextId, resourceId))
		{
			return postError("<p>" + getRB(rb, "error.info.resource", "Error, cannot load Sakai information for resource=") + resourceId + ".</p>");
		}

		if (placementId != null)
		{
			ToolConfiguration placement = SiteService.findTool(placementId);

			// Add user, course, etc to the launch parameters
			if (!sakaiInfo(launch, placement))
			{
				return postError("<p>" + getRB(rb, "error.missing", "Error, cannot load Sakai information for placement=") + placementId + ".</p>");
			}
		}

		if (descriptor != null)	BasicLTIUtil.parseDescriptor(info, launch, descriptor);
		
		if (info.getProperty("launch_url", null) == null && info.getProperty("secure_launch_url", null) == null)
		{
			return postError("<p>" + getRB(rb, "error.nolaunch", "Not Configured.") + "</p>");
		}

	     if (targetFrame != null && targetFrame.length() > 0)
	        	setProperty(launch, "launch_presentation_document_target", targetFrame);
	    
		return postLaunchHTML(info, launch, rb);
	}
   
     /**
     * Called from Web Content tool
     * @param placementId
     * @param returnUrl
     * @param rb
     * @return
     */
    public static String[] postLaunchHTML(String placementId, Properties info, ResourceLoader rb, String targetFrame)
    {
        if ( placementId == null ) return postError("<p>" + getRB(rb, "error.missing" ,"Error, missing placementId")+"</p>" );
        ToolConfiguration placement = SiteService.findTool(placementId);
        if ( placement == null ) return postError("<p>" + getRB(rb, "error.load" ,"Error, cannot load placement=")+placementId+".</p>");
    
        // Add user, course, etc to the launch parameters
        Properties launch = new Properties();
        if ( ! sakaiInfo(launch, placement) ) {
           return postError("<p>" + getRB(rb, "error.missing",
                "Error, cannot load Sakai information for placement=")+placementId+".</p>");
        }
        
        // Retrieve the launch detail
        boolean loadLTIDetails = false;
        if (info.getProperty("launch_url", null) == null &&  info.getProperty("secure_launch_url", null) == null ) {
        	loadLTIDetails = loadFromPlacement(info, launch, placement);
           }
              
       if (!loadLTIDetails)
           return postError("<p>" + getRB(rb, "error.nolaunch" ,"Not Configured.")+"</p>");
             
        if (targetFrame != null && targetFrame.length() > 0)
        	setProperty(launch, "launch_presentation_document_target", targetFrame);
         
    	return postLaunchHTML(info, launch, rb);
    }

    /**
     * 
     * @param info
     * @param launch
     * @param rb
     * @return
     */
    public static String[] postLaunchHTML(Properties info, Properties launch, ResourceLoader rb)
    {

        String launch_url = info.getProperty("secure_launch_url");
	if ( launch_url == null ) launch_url = info.getProperty("launch_url");
        if ( launch_url == null ) return postError("<p>" + getRB(rb, "error.missing" ,"Not configured")+"</p>");

        String org_guid = ServerConfigurationService.getString("basiclti.consumer_instance_guid",null);
        String org_name = ServerConfigurationService.getString("basiclti.consumer_instance_name",null);
        String org_url = ServerConfigurationService.getString("basiclti.consumer_instance_url",null);
        
        // key - secret
        // Look up the local secret and key first. changed from site-wide first to local by rashmi
        String secret = toNull(info.getProperty("secret"));
        String key = toNull(info.getProperty("key"));
      
        // Demand LMS-wide key/secret to be both or none 
        if ( key == null ) getToolConsumerInfo(launch_url,"key");
        if ( key == null ) key = org_guid;
        if ( secret == null ) secret = getToolConsumerInfo(launch_url,"secret");
 
         // Pull in all of the custom parameters
        for(Object okey : info.keySet() ) {
                String skey = (String) okey;
                if ( ! skey.startsWith("custom_") ) continue;
                String value = info.getProperty(skey);
                if ( value == null ) continue;
                setProperty(launch, skey, value);
        }

        String oauth_callback = ServerConfigurationService.getString("basiclti.oauth_callback",null);
	// Too bad there is not a better default callback url for OAuth
        // Actually since we are using signing-only, there is really not much point 
	// In OAuth 6.2.3, this is after the user is authorized
	if ( oauth_callback == null ) oauth_callback = "about:blank";
		if (!launch.containsKey("oauth_callback"))
			setProperty(launch, "oauth_callback", oauth_callback);
        setProperty(launch, BasicLTIUtil.BASICLTI_SUBMIT, getRB(rb, "launch.button", "Press to Launch External Tool"));

        // Sanity checks
        if ( secret == null ) {
            return postError("<p>" + getRB(rb, "error.nosecret", "Error - must have a secret.")+"</p>");
        }
        if (  secret != null && key == null ){
            return postError("<p>" + getRB(rb, "error.nokey", "Error - must have a secret and a key.")+"</p>");
        }

        launch = BasicLTIUtil.signProperties(launch, launch_url, "POST",
            key, secret, org_guid, org_name, org_url);

        if ( launch == null ) return postError("<p>" + getRB(rb, "error.sign", "Error signing message.")+"</p>");
        dPrint("LAUNCH III="+launch);

	boolean dodebug = toNull(info.getProperty("debug")) != null;
        String postData = BasicLTIUtil.postLaunchHTML(launch, launch_url, dodebug);        
        String [] retval = { postData, launch_url };
        return retval;
    }

    public static String[] postError(String str) {
        String [] retval = { str };
        return retval;
     }

    public static String getRB(ResourceLoader rb, String key, String def)
    {
        if ( rb == null ) return def;
        return rb.getString(key, def);
    }

    public static void setProperty(Properties props, String key, String value)
    {
        if ( value == null ) return;
        if ( value.trim().length() < 1 ) return;
        props.setProperty(key, value);
    }

    private static String getContext()
    {
        String retval = ToolManager.getCurrentPlacement().getContext();
        return retval;
    }

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

    // Look through a series of secrets from the properties based on the launchUrl
    private static String getToolConsumerInfo(String launchUrl, String data)
    {
        String default_secret = ServerConfigurationService.getString("basiclti.consumer_instance_"+data,null);
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
        String org_info = ServerConfigurationService.getString("basiclti.consumer_instance_"+data+"."+hostName,null);
        if ( org_info != null ) return org_info;
        for ( int i = 0; i < hostName.length(); i++ ) {
            if ( hostName.charAt(i) != '.' ) continue;
            if ( i > hostName.length()-2 ) continue;
            String hostPart = hostName.substring(i+1);
            String propName = "basiclti.consumer_instance_"+data+"."+hostPart;
            org_info = ServerConfigurationService.getString(propName,null);
            if ( org_info != null ) return org_info;
        }
        return default_secret;
    }

    static private String getOurServerUrl() {
        String ourUrl = ServerConfigurationService.getString("sakai.rutgers.linktool.serverUrl");
        if (ourUrl == null || ourUrl.equals(""))
            ourUrl = ServerConfigurationService.getServerUrl();
        if (ourUrl == null || ourUrl.equals(""))
            ourUrl = "http://127.0.0.1:8080";

        return ourUrl;
    }

    public static String toNull(String str)
    {
       if ( str == null ) return null;
       if ( str.trim().length() < 1 ) return null;
       return str;
    }


}
