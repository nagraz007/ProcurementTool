	<cf_checkSession assetdesired ="3" purchasedesired = "3"/>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html><!-- InstanceBegin template="/Templates/templateMain.dwt" codeOutsideHTMLIsLocked="false" --><head>
<!-- InstanceBeginEditable name="doctitle" -->
<title>INSEAD - Assets and Sales</title>
<!-- InstanceEndEditable -->
<!--- INSEAD icon --->
<LINK rev=made rel="SHORTCUT ICON" HREF="http://www.insead.edu/favicon.ico">
<!--- Fin icon --->
<cfoutput>
    <!--- JS for the template --->
    <script src="/ressources/js/print_page.js"></script>
    <script src="/ressources/js/menu_header.js"></script>
    <script src="/ressources/js/menu_collapse.js"></script> 
    <script src="/ressources/js/quicklinks.js"></script>
  	<script src="/ressources/js/jquery-1.3.1.min.js"></script>
   	<script src="../js/addtofav.js" type="text/javascript"></script>
    <!--- Fin JS --->
    
    <!--- Script for the template --->
    <link href="/ressources/css/left_nav.css" rel="stylesheet" type="text/css">
    <link href="/ressources/css/template_insead.css" rel="stylesheet" type="text/css">
    <link href="/ressources/css/menu_header.css" rel="stylesheet" type="text/css">
    <link href="/ressources/css/right_nav.css" rel="stylesheet" type="text/css">
    <link href="/ressources/css/quicklinks.css" rel="stylesheet" type="text/css">
    <link href="../css/themes/base/ui.all.css" rel="stylesheet" type="text/css"> 
    <link href="../css/themes/base/jquery.ui.datepicker.css" rel="stylesheet" type="text/css">   
    
<!---    <link href="../admin/css/registration.css" rel="stylesheet" type="text/css">
--->    <!--- Fin script --->
</cfoutput> 
<!-- InstanceBeginEditable name="MenuId" -->
    <!--- JS for the content of the left navigation --->
    <script src="../js/menu_collapse_define.js"></script>
    <!--- Fin JS --->
<script src="../js/validate/jquery.validate.js" type="text/javascript"></script>
    <style type="text/css">
	
	label { width: 10em; float: left; }
	label.error { float: none; color: red; padding-left: .5em; vertical-align: top; }
	p { clear: both; }
	.submit { margin-left: 12em; }
	em { font-weight: bold; padding-right: 1em; vertical-align: top; }
	.alert {float: none; color: red; vertical-align: top;}
	</style>
<script>
	myMenu.PathToTheRoot = "../";
	myMenu.idMenuInit = 'purchasehome';	

var current = 1;
	  var addItem = function()
	  {
		current = current + 1; 
		var strAdd = '<table class="append'+current+'"><tr><td class="content">Please upload the attachment :</td><td class="content"><input name="FileContents'+current+'" type="file" id="FileContents'+current+'"></td></tr></table>';
		 $('#expand').append(strAdd);
		 if(document.SendQuotationForm){
		 	document.SendQuotationForm.UploadCount.value = current;
		 }
		 if(document.OrdertoVendorForm){
		 	document.OrdertoVendorForm.UploadCount.value = current;
		 }		 
	  };
	     var removeItem = function()
   {	
   		 if(current > 1){
	     	 $('.append'+ current).remove();
	    	  current = current - 1; 
		      if(document.SendQuotationForm){
			 	document.SendQuotationForm.UploadCount.value = current;
			 }
			 if(document.OrdertoVendorForm){
			 	document.OrdertoVendorForm.UploadCount.value = current;
			 }	
   		}
   };
</script>
<script>
$(document).ready(function() {
		/*Jquery for form Validation*/
	   $("#SendQuotationForm").validate({
	   	messages: { 
					userlist:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>",
					FileContents1:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>"
				}
	   });
	   $("#ReqQuotationForm").validate({
	   	messages: { 
					Vendorlist:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>"					
				}
	   });
	   $("#BCAForm").validate({
	   	messages: { 
					BudgetManager:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>"					
				}
	   });
	   $("#OrdertoVendorForm").validate({
	   	messages: { 
					Vendorlist:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>",
					FileContents1:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>"
				}
	   });
	   
   });
</script>
<!-- InstanceEndEditable -->
</head>
<body>
<table border="0" cellpadding="0" cellspacing="0" width="100%">
	<tr>
		<td>&nbsp;</td>
		<td width="1"><table border="0" cellpadding="0" cellspacing="0" bgcolor="#FFFFFF">
	<tr>
	  <td background="/ressources/images/template/background_left.jpg"><img src="/ressources/images/template/background_left.jpg" width="8" height="8"></td>
	  <td>
		<table border="0" cellpadding="0" cellspacing="0">
		    <tr>
              <td colspan="2" id="DHTML_Header">
                <table width="950" border="0" cellpadding="0" cellspacing="0" background="/ressources/images/template/header_background.jpg">
                  <tr>
                    <td width="147" height="134" align="left" valign="top"><a href="/home/"><img src="/ressources/images/template/logo.jpg" width="189" height="134" border="0" /></a></td>
                    <td width="803" align="left" valign="top">
                        <table width="100%" height="122" border="0" cellpadding="0" cellspacing="0">
                            <tr>
                                <td height="25" colspan="3" background="/ressources/images/template/drop_down_menu_background.gif">
                                    <ul id="menu">
        <li><a class="tab2 home" href="http://www.insead.edu/home/contact_us.cfm">Contact us</a></li>

        
        <li><a class="tab myplace" href="http://www.insead.edu/aroundtheworld/">Locations</a>
          <ul id="myPlace">
                <li><a href="http://www.insead.edu/europe_campus/getting/">Europe Campus</a></li>
                <li><a href="http://www.insead.edu/singapore_campus/getting/">Asia Campus</a></li>
                <li><a href="http://www.insead.edu/abu_dhabi_campus/">Abu Dhabi Campus</a></li>
                <li><a href="http://www.insead.edu/israelresearchcentre/">Israel Research Centre</a></li>

                <li><a href="http://www.insead.edu/americasoffice/">North America Offices</a></li>
          </ul>
      </li>     
      
       <li><a class="tab lifeoncampus" href="http://www.insead.edu/events/">News</a>
          <ul id="lifeoncampus">
                <li><a href="http://www.insead.edu/events/">Global Events</a></li>
                <li><a href="http://www.insead.edu/media_relations/">Media Relations</a></li>

          </ul>
      </li>
      
        <li><a class="tab community" href="http://www.insead.edu/Alumni/alumni_network/">Alumni</a>
            <ul id="contact">
            	<li><a href="http://iaa.insead.edu/IAA/alumninews/Pages/Homepage.aspx" target="_blank">Alumni Networking Platform</a></li>
                <li><a href="http://www.insead.edu/Alumni/alumni_network/associations.cfm">Alumni Associations</a></li>
                <li><a href="http://www.insead.edu/Alumni/alumni_network/fund.cfm">Alumni Fund</a></li>

                <li><a href="http://www.insead.edu/Alumni/alumni_network/reunions.cfm">Alumni Reunion Weekends</a></li>
                <li><a href="http://iaa.insead.edu/IAA/inseadalumniclubs/Pages/Default.aspx" target="_blank">Alumni Interest Groups</a></li>
            </ul>
        </li>
        
      	<li><a class="tab contact" href="http://www.insead.edu/corporate_recruiters/">Corporate Recruiters</a></li>
        
        <li><a class="tab lifeoncampus" href="http://www.insead.edu/facultyresearch/faculty/">Faculty &amp; Research</a>

          <ul id="lifeoncampus">
                <li><a href="http://www.insead.edu/facultyresearch/faculty/">Faculty</a></li>
                <li><a href="http://www.insead.edu/facultyresearch/research/">Research</a></li>
                <li><a href="http://www.insead.edu/facultyresearch/research/research_centers.cfm">Centres of Excellence</a></li>
                <li><a href="http://www.insead.edu/library/">INSEAD Libraries</a></li>
                <li><a href="http://knowledge.insead.edu/home.cfm">INSEAD Knowledge</a></li>

          </ul>
        </li>
           
        <li><a class="tab contact" href="http://www.insead.edu/home/">Programmes</a> 
            <ul id="menuheader_programmes">
                <li><a href="http://executive.education.insead.edu/">Executive Education</a></li>
                <li><a href="http://global.emba.insead.edu">Executive MBA</a></li>
                <li><a href="http://mba.insead.edu">MBA</a></li>

                <li><a href="http://phd.insead.edu">PhD</a></li>
            </ul>
        </li>
        
        
        <li><a class="tab contact" href="http://about.insead.edu/who_we_are/index.cfm">About INSEAD</a>
            <ul id="contact">
                <li><a href="http://about.insead.edu/who_we_are/index.cfm">Who we are</a></li>
                <li><a href="http://about.insead.edu/who_we_are/history.cfm">Our history</a></li>

                <li><a href="http://about.insead.edu/who_we_are/mission_visions.cfm">Our mission & vision</a></li>
                <li><a href="http://about.insead.edu/constituencies/dean.cfm">Our constituencies</a></li>
                <li><a href="http://about.insead.edu/publications/index.cfm">Publications</a></li>
                <li><a href="http://about.insead.edu/social_media/index.cfm">Social Media</a></li>
                <li><a href="http://about.insead.edu/partnerships/index.cfm">Alliance & Partnership</a></li>

 		    	<li><a href="http://about.insead.edu/environment_policy/index.cfm">Environment Policy</a></li>
                <li><a href="http://about.insead.edu/jobs/index.cfm">Our job opportunities</a></li>
                <li><a href="http://www.insead.edu/giving_to_insead/">Giving to INSEAD</a></li>
            </ul>
        </li>
    </ul>



                                    
                                </td>
                            </tr>
                            <tr>
                                <td height="19" colspan="3"><img src="/ressources/images/template/spacer.gif" width="10" height="19"></td>
                            </tr>
                            <tr>
                                <td width="66%" height="44"><!-- InstanceBeginEditable name="header title" --><img src="../images/Header_Title.gif"><!-- InstanceEndEditable --></td>
                                <td width="2%"><img src="/ressources/images/template/spacer.gif" width="10" height="44"></td>
                                <td width="32%"><form id="searchbox_013124306904282299895:ryclcu7k7ny" name="search" action="/search/" style="margin:0px;">
            <input type="hidden" name="cx" value="013124306904282299895:ryclcu7k7ny" />
            <input type="hidden" name="cof" value="FORID:9" />
            <table cellpadding="0" cellspacing="0">
              <tr>
                <td colspan="2"><input name="q" type="text" size="30" /></td>
                <td><a href="javascript:document.search.submit();"><img src="/ressources/images/template/search_button.jpg" width="29" height="17" border="0"/></a></td>
              </tr>
            </table>
        </form></td>
                            </tr>
                            <tr>
                                <td colspan="3">
                                   <div id="quicklinks_button" style="float:right;">
                                        <img src="/ressources/images/template/quick-links.jpg" border="0" onClick="homepage_setting()" style="padding:0px;  border-spacing:0px; margin-top:23px; margin-right:20px; cursor:pointer; vertical-align:bottom"/>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                 </tr>
            </table>
            <table width="100%" border="0" bordercolor="#000000" cellpadding="0" cellspacing="0">
                <tr>
                    <td bgcolor="#F1F2ED" style="background-color:#F1F2ED;">
                      <cfinclude template="/ressources/templates/quicklinks.cfm">
                    </td>
                </tr>
            </table>
		  </td>
       </tr>
	   <tr>
		<td colspan="2">
            <table width="100%" border="0" cellpadding="0" cellspacing="0">
              <tr>
                <td class="background_white"></td>
                <td height="10" class="background_white"><img src="/ressources/images/template/spacer.gif" width="10" height="10"></td>
                <td class="background_white"></td>
                <td height="10" class="background_white"><img src="/ressources/images/template/spacer.gif" width="10" height="10"></td>
                </tr>
              <tr>
                <td id="DHTML_Menu" width="180" align="left" valign="top" class="td_body_sidemenu">
                <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <script>myMenu.DisplayMenu();</script>	
                </table>
                </td>
                <td width="10" class="background_white">&nbsp;</td>
                <td align="left" valign="top">
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr>
                        <td width="82%" class="headline"><!-- InstanceBeginEditable name="page title" -->Purchase Management Home<!-- InstanceEndEditable --></td>
                        <td width="9%" class="headline"><a href="javascript:window.print()" class="template" style="cursor:hand;"><img src="/ressources/images/template/print.gif" width="57" height="12" hspace="0" vspace="0" border="0"></a></td>
                        <td width="12%" class="headline"><a href="javascript:addToFav()" ><img src="/ressources/images/template/bookmark.gif" width="80" height="12" hspace="0" vspace="0" border="0"></a> </td>
                      </tr>

                    </table>
                 
                    <table width="750" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td width="520" height="230" align="left" valign="top" class="background_white"><!-- InstanceBeginEditable name="content" -->
						  <cfif not structIsEmpty(FORM) and structKeyExists(FORM,"btn_sendmail1")>
							  <cfset Attachments = ArrayNew(1) />
                                <cfloop index="i" from="1" to="#Form.UploadCount#">
                                    <cftry>
                                        <cfif FORM["FileContents#i#"] NEQ "">
                                            <cffile action="upload" fileField="FileContents#i#" destination="#Application.MailUploadpath#" nameConflict="MakeUnique">
                                            <cfset ArrayAppend(Attachments,'#Application.MailUploadpath##cffile.serverfile#') />
                                        </cfif>       
                                        <cfcatch type="any"></cfcatch><!--- Do Nothing --->
                                    </cftry>
                                </cfloop>
                                <!--- The Attachments array consists of the list of link of the files to be attached --->
                                <cfscript>
                                    ObjUserData = APPLICATION.com.control.admin.ListUsers(Form.userlist).data;
                                    placeHolderData = '#ObjUserData.firstname#|#ObjUserData.lastname#';
                                    MailContent = APPLICATION.com.util.$replacePlaceholders(1, FORM.mailcontent, placeHolderData);
                                </cfscript>				
                               <!--- Mailcontent is the final mail to be sent --->
                             <cfif APPLICATION.MailSettings>
								 <cfmail to="#ObjUserData.email#" from="#APPLICATION.AdminEmail#" cc="#FORM.CC#" subject="send quotation" type="html">
	                                <cfloop index="i" from="1" to="#ArrayLen(Attachments)#">
	                                    <cfmailparam file="#Attachments[i]#" contentid="Quotation#i#">
	                                </cfloop>
	                                <cfoutput>
	                                    <html>
	                                        <body>
	                                            #MailContent#
	                                        </body>
	                                    </html>
	                                </cfoutput>
	                               </cfmail>
							  </cfif>
						  </cfif>
                          
                          <cfif not structIsEmpty(FORM) and structKeyExists(FORM,"btn_sendmail2")>
								<cfscript>
                                    ObjUserData = APPLICATION.com.control.admin.ListVendors(Form.Vendorlist).data;
                                    placeHolderData = '#ObjUserData.VENDOR_NAME#';
                                    MailContent = APPLICATION.com.util.$replacePlaceholders(2, FORM.mailcontent, placeHolderData);
                                </cfscript>	
                                <!--- Mailcontent is the final mail to be sent --->
                             <cfif APPLICATION.MailSettings>
								  <cfmail to="#ObjUserData.email#" from="#APPLICATION.AdminEmail#" cc="#FORM.CC#" subject="Request Quotation" type="html">
	                                <cfoutput>
	                                    <html>
	                                        <body>
	                                            #MailContent#
	                                        </body>
	                                    </html>
	                                </cfoutput>
	                               </cfmail>
							</cfif> 
						  </cfif>
                          
                          <cfif not structIsEmpty(FORM) and structKeyExists(FORM,"btn_sendmail3")>
                            <cfscript>
								ManagerEmailId = listFirst(FORM.BudgetManager,'|');
								ManagerName = listLast(FORM.BudgetManager,'|');
								MailContent = APPLICATION.com.util.$replacePlaceholders(3, FORM.mailcontent, ManagerName);
                            </cfscript>	
							<!--- Mailcontent is the final mail to be sent --->
			                    <cfif APPLICATION.MailSettings>
			                           <cfmail to="#ManagerEmailId#" from="#APPLICATION.AdminEmail#" cc="#FORM.CC#" subject="For Approval" type="html">
			                            <cfoutput>
											<html>
			                                	<body>
			                                    	#MailContent#
			                                    </body>
			                                </html>
										</cfoutput>
			                           </cfmail>						
								</cfif>
						  </cfif>
                          
                          <cfif not structIsEmpty(FORM) and structKeyExists(FORM,"btn_sendmail4")>
						  <cfset Attachments = ArrayNew(1) />
                          	<cfloop index="i" from="1" to="#Form.UploadCount#">
						  		<cftry>
									<cfif FORM["FileContents#i#"] NEQ "">
                                        <cffile action="upload" fileField="FileContents#i#" destination="#Application.MailUploadpath#" nameConflict="MakeUnique">
                                        <cfset ArrayAppend(Attachments,'#Application.MailUploadpath##cffile.serverfile#') /> 
                                    </cfif>
                                    <cfcatch type="any"></cfcatch><!--- Do Nothing --->
								</cftry>
                            </cfloop>
                            <!--- The Attachments array consists of the list of link of the files to be attached --->
                            <cfscript>
                            	ObjUserData = APPLICATION.com.control.admin.ListVendors(Form.Vendorlist).data;
								placeHolderData = '#ObjUserData.VENDOR_NAME#';
								MailContent = APPLICATION.com.util.$replacePlaceholders(2, FORM.mailcontent, placeHolderData);
                            </cfscript>
                           <!--- Mailcontent is the final mail to be sent --->
			                        <cfif APPLICATION.MailSettings>
										 <cfmail to="#ObjUserData.email#" from="#APPLICATION.AdminEmail#" cc="#FORM.CC#" subject="send quotation" type="html">
			                           	<cfloop index="i" from="1" to="#ArrayLen(Attachments)#">
			                            	<cfmailparam file="#Attachments[i]#" contentid="Quotation#i#">
			                            </cfloop>
			                            <cfoutput>
											<html>
			                                	<body>
			                                    	#MailContent#
			                                    </body>
			                                </html>
										</cfoutput>
			                           </cfmail> 
								  </cfif>
						  </cfif>
							<form name="NotificationSelectForm" id="NotificationSelectForm" method="post" action="purchase_home.cfm">
                            <table>
                            	<tr>
                                	<td class="content">Select Mail Type</td>
                                    <td class="content">
                                    	<select name="NotificationType" id="NotificationType">
                                        <option value="">Please Select one</option>
                                        <option value="SendQuotation">Quote to User</option>
                                        <option value="ReqQuotation">Request for quote</option>
                                        <option value="BCA">Request for Budget Controler Approval</option>
                                        <option value="OTV">Place the order </option>
                          	      		</select>
                                    </td>
                                </tr>
                                <tr>
                                	<td>&nbsp;</td>
                                    <td class="content"><input type="submit" name="brn_submit"  id="brn_submit" value="Submit"></td>
                                </tr>
                            </table>
                            <hr width="700" align="left" noshade>
                            </form>
                            <cfif not structIsEmpty(FORM) and structKeyExists(FORM,"brn_submit")>						  
                            	<cfif FORM.NotificationType EQ 'SendQuotation'>
                                    <table>
                                        <tr>
                                            <td class="content">
                                            	<cfset users = APPLICATION.com.control.admin.ListUsers().data />
                                                <cfform id="SendQuotationForm" name="SendQuotationForm" method="post" action="purchase_home.cfm" enctype="multipart/form-data">
                                                	<table>
                                                    	<thead>
                                                        	<th><u>Send quotation</u></th>
                                                        </thead>
                                                    	<tr>
                                                        	<td class="content">Please select the user<span class="alert">*</span></td>
                                                            <td class="content">
                                                            	<cfselect name="userlist" id="userlist" query="users" display="Username" value="US_ID" queryPosition="below" class="required"><option value="">--User--</option></cfselect>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                        	<td class="content">CC</td>
                                                        	<td class="content"><input name="CC" type="text"  size="60px" title="In case more than one recipient, add email addressess sepearted by comma (,) "></td>
                                                        </tr>
                                                        <tr>
                                                        	<td class="content">Please upload the attachment :</td>
                                                            <td>
                                                            	<input name="FileContents1" type="file" id="FileContents1" class="required">
                                                            	<input type="hidden" id="UploadCount" name="UploadCount" value="1">
                                                            </td>
                                                        </tr>
                                                     </table>
													<table id="expand">
													</table>
                                                     <table>
                                                     	<tr>                            
                                                              <td class="content" width="130px"><a href="javascript:addItem();">Upload More Files</a></td>
                                                              <td class="content"><a href="javascript:removeItem();"  >Remove a File</a></td>
                                                  		</tr>
                                                        <tr>
                                                        	<td class="content" colspan="4">
                                                            	<cftextarea id="mailcontent" name="mailcontent" richtext="yes" toolbar="Basic" width="690" height="275">
                                                                <cfinclude template="sendquotation.html">
                                                                </cftextarea>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                        	<td class="content" colspan="4" align="left">
                                                            	<input type="submit" name="btn_sendmail1" id="btn_sendmail1" value="Send Mail">
                                                            </td>
                                                        </tr>
                                                    </table>	
                                                </cfform>
                                            </td>
                                        </tr>
                                    </table>
                                <cfelseif FORM.NotificationType EQ 'ReqQuotation'>
                                	<table>
                                        <tr>
                                            <td class="content">
                                               <cfset vendors = APPLICATION.com.control.admin.ListVendors().data />
                                               <cfform id="ReqQuotationForm" name="ReqQuotationForm" method="post" action="purchase_home.cfm" enctype="multipart/form-data">
                                                	<table>
                                                    	<thead>
                                                        	<th><u>Request quotation</u></th>
                                                        </thead>
                                                    	<tr>
                                                        	<td class="content">Please select the Vendor<span class="alert">*</span></td>
                                                            <td class="content">
                                                            	<cfselect name="Vendorlist" id="Vendorlist" query="vendors" display="vendor_name" value="vendor_id" queryPosition="below" class="required"><option value="">--Vendor--</option></cfselect>
                                                            </td>
														</tr>
														<tr>
                                                        	<td class="content">CC</td>
                                                        	<td class="content"><input name="CC" type="text" size="60px"></td>
                                                        </tr>	
                                                        <tr>
                                                        	<td class="content" colspan="4">
                                                            	<cftextarea id="mailcontent" name="mailcontent" richtext="yes" toolbar="Basic" width="690" height="275">
                                                                <cfinclude template="requestquotation.html">
                                                                </cftextarea>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                        	<td class="content" colspan="4" align="left">
                                                            	<input type="submit" name="btn_sendmail2" id="btn_sendmail2" value="Send Mail">
                                                            </td>
                                                        </tr>
                                                    </table>	
                                                </cfform>
                                            </td>
                                        </tr>
                                    </table>
                                <cfelseif FORM.NotificationType EQ 'BCA'>
                                	<table>
                                        <tr>
                                            <td class="content">
											<cfset budgetApprovers = APPLICATION.com.control.admin.listBudgetApprovers() />
                                               <cfform id="BCAForm" name="BCAForm" method="post" action="purchase_home.cfm" enctype="multipart/form-data">
                                                	<table>
                                                    	<thead>
                                                        	<th><u>Budget Controller Approval</u></th>
                                                        </thead>
                                                    	<tr>
                                                        	<td class="content">Please select the Budget Manager<span class="alert">*</span></td>
                                                            <td class="content">
																 <cfselect name="BudgetManager" id="BudgetManager" query="budgetApprovers" display="Fname" value="combined" queryPosition="below" class="required">
																	 <option value="">--Budget Approver--</option>
																 </cfselect>
                                                            </td>
															</tr>
														<tr>
                                                        	<td class="content">CC</td>
                                                        	<td class="content"><input name="CC" type="text"  size="60px"></td>
                                                        </tr>
                                                        <tr>
                                                        	<td class="content" colspan="4">
                                                            	<cftextarea id="mailcontent" name="mailcontent" richtext="yes" toolbar="Basic" width="690" height="275">
                                                                <cfinclude template="budgetapproval.html">
                                                                </cftextarea>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                        	<td class="content" colspan="4" align="left">
                                                            	<input type="submit" name="btn_sendmail3" id="btn_sendmail3" value="Send Mail">
                                                            </td>
                                                        </tr>
                                                    </table>	
                                                </cfform> 
                                            </td>
                                        </tr>
                                    </table>
                                <cfelseif FORM.NotificationType EQ 'OTV'>
                                	<table>
                                        <tr>
                                            <td class="content">
                                            <cfset vendors = APPLICATION.com.control.admin.ListVendors().data />
                                                <cfform id="OrdertoVendorForm" name="OrdertoVendorForm" method="post" action="purchase_home.cfm" enctype="multipart/form-data">
                                                	<table>
                                                    	<thead>
                                                        	<th><u>Order to Vendor</u></th>
                                                        </thead>
                                                    	<tr>
                                                        	<td class="content">Please select the Vendor<span class="alert">*</span></td>
                                                            <td class="content">
																<cfselect name="Vendorlist" id="Vendorlist" query="vendors" display="vendor_name" value="vendor_id" queryPosition="below" class="required"><option value="">--Vendor--</option></cfselect>                                                            	
                                                           </td>
                                                        </tr> 
                                                         <tr>
                                                        	<td class="content">CC</td>
                                                        	<td class="content"><input name="CC" type="text"  size="60px"></td>
                                                        </tr>
                                                        <tr>
                                                        	<td class="content">Please upload the attachment :</td>
                                                            <td>
                                                            	<input name="FileContents1" type="file" id="FileContents1" class="required">
                                                                <input type="hidden" id="UploadCount" name="UploadCount" value="1">
                                                            </td>
                                                        </tr>
                                                        </table>
														<table id="expand">
															
														</table>
                                                        <table>
                                                        <tr>                            
                                                             <td class="content" width="130px"><a href="javascript:addItem();">Upload More Files</a></td>
                                                             <td class="content" ><a href="javascript:removeItem();">Remove a File</a></td>
                                                  		</tr>
                                                        <tr>
                                                        	<td class="content" colspan="4">
                                                            	<cftextarea id="mailcontent" name="mailcontent" richtext="yes" toolbar="Basic" width="690" height="275">
                                                                <cfinclude template="ordertovendor.html">
                                                                </cftextarea>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                        	<td class="content" colspan="4" align="left">
                                                            	<input type="submit" name="btn_sendmail4" id="btn_sendmail4" value="Send Mail">
                                                            </td>
                                                        </tr>
                                                    </table>	
                                                </cfform>
                                            </td>
                                        </tr>
                                    </table>    
                                 <cfelse>
                                   <table>
                                        <tr>
                                            <td class="content">
                                                <span class="alert">Please select an option</span>
                                            </td>
                                        </tr>
                                    </table>  
                                </cfif>    
							</cfif>	  
						  <!-- InstanceEndEditable --></td>
                          <td width="20" align="left" valign="top" class="background_white"><img src="/ressources/images/template/spacer.gif" width="20" height="10"></td>
                          <td id="DHTML_Right_Menu"width="210" align="left" valign="top" class="background_white">
                            
                            <!--- <cfinclude template="/ressources/templates/social_networks.cfm">  
                            
                            <cfinclude template="../rightnav/index.cfm">  --->
                          </td>
                        </tr>
                     </table>
                  </td>
                  <td width="10" align="left" class="background_white">&nbsp;</td>
              </tr>
            </table>
        </td>
	</tr>
	<tr id="DHTML_Footer">
	  <td height="20" colspan="2" align="center" valign="middle" background="/ressources/images/template/footer_background.jpg"><table width="950" border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td width="244" align="left"><img src="/ressources/images/template/insead2007.gif" width="107" height="10"></td>
          <td width="226" align="center"><a href="/home/accreditations.cfm" class="link_footer">Accreditations</a></td>
          <td width="176" align="center"><a href="/home/terms.cfm" class="link_footer">Terms&nbsp;&amp;&nbsp;Conditions</a></td>
          <td width="207" align="center"><a href="/home/privacy.cfm" class="link_footer">Privacy&nbsp;Policy</a></td>
          <td width="97" align="right"><a href="/home/copyright.cfm" class="link_footer">Copyright</a></td>
        </tr>
      </table></td>
	</tr>
</table>
</td>
<td background="/ressources/images/template/background_right.jpg"><img src="/ressources/images/template/background_right.jpg" width="8" height="8"></td>
</tr>
</table></td>

		<td>&nbsp;</td>
	</tr>
</table>
</body>
<!-- InstanceEnd --></html>
