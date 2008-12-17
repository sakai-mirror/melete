<!--
 ***********************************************************************************
 *
 * Copyright (c) 2008 Etudes, Inc.
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
 **********************************************************************************
-->
<%@ taglib uri="http://java.sun.com/jsf/html" prefix="h" %>
<%@ taglib uri="http://java.sun.com/jsf/core" prefix="f" %>
					<f:verbatim>
					<tr><td height="20" colspan="2"> 
					</f:verbatim>
						<h:outputText id="addLTIBasic1" value="#{msgs.addmodulesections_lti_url}" />
                                                <f:verbatim>
                                                        <span class="required">*</span>
                                                </f:verbatim>
						<h:outputText id="addLTIBasic2" value=" " styleClass="ExtraPaddingClass"/>						
						<h:inputText id="LTIUrl" value="#{addSectionPage.LTIUrl}" size="40" /> 	
					<f:verbatim>
					</td></tr>
					<tr><td height="20" colspan="2"> 
					</f:verbatim>
						<h:outputText id="addLTITitle" value="#{msgs.addmodulesections_lti_title}" />
                                                <f:verbatim>
                                                        <span class="required">*</span>
                                                </f:verbatim>
						<h:outputText id="addLTItitle2" value=" " styleClass="ExtraPaddingClass"/>
						<h:outputText id="addLTItitle3" value=" " styleClass="ExtraPaddingClass"/>
						<h:inputText id="LTI_title" value="#{addSectionPage.newURLTitle}" size="40" /> 
					<f:verbatim>
					</td></tr>
					<tr><td height="20" colspan="2"> 
					</f:verbatim>
						<h:selectBooleanCheckbox id="windowopen" title="openWindow" value="#{addSectionPage.section.openWindow}" />												
						<h:outputText id="editLTIText_8" value="#{msgs.editcontentlinkserverview_openwindow}" />
					<f:verbatim>
					</td></tr>	
					<tr><td height="20" colspan="2"> 
					</f:verbatim>
						<h:outputText id="addLTIBasic3" value="#{msgs.addmodulesections_lti_pasword}" />
						<h:outputText id="addLTIBasic4" value=" " styleClass="ExtraPaddingClass"/>
						<h:outputText id="addLTIBasic5" value=" " styleClass="ExtraPaddingClass"/>
						<h:outputText id="addLTIBasic6" value=" " styleClass="ExtraPaddingClass"/>
						<h:inputText id="LTIPassword" value="#{addSectionPage.LTIPassword}" size="40" /> 	
					<f:verbatim>
					</td></tr>	
					</f:verbatim>
