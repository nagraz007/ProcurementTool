<cf_checkSession assetdesired ="4" purchasedesired = "4"/>
<cfajaxproxy cfc="#APPLICATION.hardroot#util/util" jsclassname="adFind" />
<cfif not structIsEmpty(FORM) and structKeyExists(FORM,"Add")>
	<cfscript>
		APPLICATION.com.control.admin.userRegistration(FORM);
	</cfscript>
</cfif>
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
	<link href="../css/purchaseActions.css" rel="stylesheet" type="text/css">   
  <!--- Fin JS --->
    <script src="../js/ui.core.js" type="text/javascript"></script> 
    <script src="../js/ui.dialog.js" type="text/javascript"></script> 
     <script src="../js/ui.datepicker.min.js" type="text/javascript"></script> 
    <script src="../js/validate/jquery.validate.js" type="text/javascript"></script>
	<script src="../js/addtofav.js" type="text/javascript"></script>
	
	 <style type="text/css">
	label { width: 10em; float: left; }
	label.error { float: none; color: red; padding-left: .5em; vertical-align: top; }
	p { clear: both; }
	.submit { margin-left: 12em; }
	em { font-weight: bold; padding-right: 1em; vertical-align: top; }
	.alert {float: none; color: red; vertical-align: top;}
	.gre{ color:#006E51;
			cursor:pointer;}
	.req { color:red;
		   cursor:pointer;}
	.pur { color:purple;
			cursor:pointer;}
	</style>
<script>
	myMenu.PathToTheRoot = "../";
	myMenu.idMenuInit = 'users';
	
	Array.prototype.findIdx = function(value){
      for (var i = 0; i < this.length; i++) {
          if (this[i] == value) {
              return i;
          }
      }
    };
	var getResults = function(){
        var login = document.getElementById('username').value;
        if(login == ''){
               alert('Please enter the login. \n\n Format: DOMAIN\\login \n where DOMAIN can be FBL or SGP or AUH') ;
              
        }else{
	        var e = new adFind();
	        e.setCallbackHandler(populateAdmin);
	        e.setErrorHandler(errHandler);
	        e.$ldapFind(login);
        }
    };
	var populateAdmin = function(result){
		var cnt = result.DATA.length;
		if(cnt == 0){
			$("#mesg").show();
			document.getElementById('msg').innerHTML = 'Search has yeilded 0 results. Try again.';
			//document.getElementById('mesg').style.display = 'block';
			
		}else if(cnt > 1){
			document.getElementById('msg').innerHTML = 'Too many results. Try again.';
			document.getElementById('mesg').style.display = 'block';
			
		}else if(cnt == 1){
			document.getElementById('msg').innerHTML = '';
			document.getElementById('mesg').style.display = 'none';
			document.getElementById('firstname').value = result.DATA[i][result.COLUMNS.findIdx('GIVENNAME')];
			document.getElementById('lastname').value = result.DATA[i][result.COLUMNS.findIdx('SN')];
			document.getElementById('userEmail').value = result.DATA[i][result.COLUMNS.findIdx('MAIL')];
			
		}
	};
	var errHandler = function(errr){
		console.log(errr);
	};

		function init(){

<cfoutput>#APPLICATION.com.util.ForEditableGrid('UsersList', 'CAMPUS','campus')#</cfoutput>
<cfoutput>#APPLICATION.com.util.ForEditableGrid('UsersList', 'NAME','name')#</cfoutput>

}
	 function act_s(type, s_id){
	 			document.searchUser.userid.value = s_id;
	 			document.searchUser.type.value = type;
				ColdFusion.Window.show('DisableVendor');		
	 }
	 function showroles()
	 {
	 	
	 	$("#assetroles").toggle(); 
	 	$("#purchroles").toggle(); 
	 }
	
	$(document).ready(function() {
		/*Jquery for form Validation*/
	   $("#userForm").validate({
	   		messages: { 
					username:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>",
					firstname:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>",
					lastname:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>",
					userEmail:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>",
					department:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>"
				}
	   });
	   $("#userForm").hide();
	$("#mesg").hide();
	   $("#searchUser").hide();
	   	$("#assetroles").hide(); 
	 	$("#purchroles").hide();
	   
	   $("#NewUser").click(function(){
	   		$("#userForm").show();
			$("#searchUser").hide();
			$("#searchresults").hide();
	  	});
		$("#lstusers").click(function(){
	   		$("#userForm").hide();
			$("#searchUser").show();
	  	});		
   });

chkUsernameUnique = function(username){
    $.getJSON("/<cfoutput>#APPLICATION.Hardroot#</cfoutput>control/adminman.cfc", {
        method: 'chkUsername',
        Username: username,
        returnformat: 'json'
    }, function(isUsernameUnique){
        if (isUsernameUnique != true) {
            $("#theErrorDivID").html('<span class="alert">Username is valid</span>');
			$("#t1").show();
        }
        else {
            $("#theErrorDivID").html('<span class="alert">Please select a new username</span>');
			 $("#t1").hide();
        }
    });
};
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
                        <td width="82%" class="headline"><!-- InstanceBeginEditable name="page title" -->User Section<!-- InstanceEndEditable --></td>
                        <td width="9%" class="headline"><a href="javascript:window.print()" class="template" style="cursor:hand;"><img src="/ressources/images/template/print.gif" width="57" height="12" hspace="0" vspace="0" border="0"></a></td>
                        <td width="12%" class="headline"><a href="javascript:addToFav()" ><img src="/ressources/images/template/bookmark.gif" width="80" height="12" hspace="0" vspace="0" border="0"></a> </td>
                      </tr>

                    </table>
                 
                    <table width="750" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td width="520" height="230" align="left" valign="top" class="background_white"><!-- InstanceBeginEditable name="content" -->
                           <cfajaximport tags="cfform,cfinput-autosuggest,cfwindow,cfgrid">	
                           <table>
                            	<tr>
                                	<td width="119" class="content"><a href="#" id="lstusers">Search/Edit Users</a></td>
                                </tr>
                            </table>	
                            <table>
                            	<tr>
                                	<td width="119" class="content"><a href="#" id="NewUser">Add a new User</a></td>
                                </tr>
                            </table>
                            <hr width="700" align="left" noshade>
                            <cfset dept = APPLICATION.com.control.admin.ListDepartments().data />
                            <cfform name="userForm" id="userForm" method="post" action="users.cfm">
							<table width="500" >
                            	<tr>
                                	<td class="content">
                                    <h1><u>Add User</u></h1>
                                    </td>
                                </tr>
                            	<tr>
                            	  <td width="114" class="content">Username<span class="alert">*</span></td>
                            		<td width="126" class="content">
                                    <div id="theErrorDivID"></div>
                                    <input type="text" name="username" id="username" class="required limited"
									maxlength="50"onchange="chkUsernameUnique(this.value);"title="Please enter in this format - DOMAIN\login" >
                                    <button type="button" class="offset4" onclick="getResults()">Go</button>
									</td>
                            	</tr>
                            	
									
										<tr id="mesg">
											<td class="content" >
											&nbsp;
											</td>
											<td class="content" width="100px" style="color:red">
											 <span id="msg" >&nbsp; </span> 
											</td>
										</tr>
									
									<div id="foundDetails">
									
									</div>
									
                            	<tr>
                            	  <td class="content">Department<span class="alert">*</span></td>
                            	  <td class="content">
                                  <cfselect name="department" id="department" query="dept" display="name" value="depart_id" ></cfselect>
                                  <span id="selectcampus" class='alert'></span>
                                  </td>
                          	  </tr>
                            	<tr>
                            	  <td class="content">Firstname<span class="alert">*</span></td>
                            	  <td class="content"><input type="text" name="firstname" id="firstname" class="required limited" maxlength="50"></td>
                          	  </tr>
                              <tr>
                            	  <td class="content">Middlename</td>
                            	  <td class="content"><input type="text" name="Middlename" id="Middlename" maxlength="50"></td>
                          	  </tr>
                              <tr>
                            	  <td class="content">Lastname<span class="alert">*</span></td>
                            	  <td class="content"><input type="text" name="lastname" id="lastname" class="required limited" maxlength="50"></td>
                          	  </tr>
                              <tr>
                            	  <td class="content">Campus<span class="alert">*</span></td>
                            	  <td class="content"><select name="Campus" id="Campus">
                            	    <option value="Asia">Singapore</option>
                            	    <option value="Europe">Fontainebleau</option>
                            	    <option value="MiddleEast">Abudhabi</option>
                          	      </select>
                            	  </td>
                          	  </tr>
                            	<tr>
                            	  <td class="content">Email<span class="alert">*</span></td>
                            	  <td class="content"><input type="text" name="userEmail" id="userEmail" class="required email" maxlength="90"></td>
                          	  </tr>
                            	<tr>
                            	  <td class="content">Workphone/Extension</td>
                            	  <td class="content"><input type="text" name="extension" id="extension" maxlength="20"></td>
                          	  </tr>
                            	<tr>
                            	  <td class="content">Mobile</td>
                            	  <td class="content"><input type="text" name="mobile" id="mobile" maxlength="20"></td>
                          	  </tr>
                            	<tr>
                            	  <td class="content">Fax</td>
                            	  <td class="content"><input type="text" name="fax" id="fax" maxlength="20"></td>
                          	  </tr>
                            	<tr>
                            	  <td class="content">IsActive</td>
                            	  <td class="content"><input type="checkbox" name="isactive" value="1" ></td>
                          	  </tr>
                            	<tr>
                            	  <td class="content">Grant Access</td>
                            	  <td class="content"><input type="checkbox" name="gaccess" value="1" onclick="showroles()" ></td>
                          	  </tr>
                            	<tr id="assetroles">
                            	  <td class="content">Role For Assets</td>
                            	  <td class="content"><cfselect name="assetRole" 
    							bind="cfc:#APPLICATION.hardRoot#control/adminman.listAccessRoles(0)"
   											 bindOnLoad="true"
    											value="id"
    											display="role"
												/>							</td>
                          	  </tr>
                            	<tr id="purchroles">
                            	  <td class="content">Role For Purchasing</td>
                            	  <td class="content"><cfselect name="purchaseRole" 
    							bind="cfc:#APPLICATION.hardRoot#control/adminman.listAccessRoles(1)"
   											 bindOnLoad="true"
    											value="id"
    											display="role"
												/>							</td>
                          	  </tr>
                            	<tr>
                            	  <td class="content">&nbsp;</td>
                            	  <td class="content"><div id="t1"><input type="submit" name="Add" id="Add" value="Add"></div></td>
                          	  </tr>
                            </table>
                            </cfform>
                            <div id="searchID">
                            <cfform id="searchUser" name="searchUser" action="users.cfm" method="post">
                          			<cfinput name="userid" type="hidden" value="0">
									   <cfinput name="type" type="hidden" value="0"> 
                            <table id="viewUserTab">
                            	<tr>
                                	<td class="content">Search<hr></td>
                                </tr>
                                <tr>
                                	<td class="content"><strong>Description</strong>:<br><i>Please enter keywords to search user by username or firstname or lastname</i></td>
                                    <td class="content"><input type="text" id="SearchKey" name="SearchKey" maxlength="50" class="required"/></td>
                                    <td class="content"><strong>Campus</strong></td>
                                    <td class="content">
                                        <select name="Campus" id="Campus">
                                            <option value="0">Select Campus</option>
                                            <option value="Asia">Singapore</option>
                                            <option value="Europe">Fontainebleau</option>
                                            <option value="MiddleEast">Abudhabi</option>
                                        </select>
                                    </td>
                                    <td class="content"><strong>Department</strong></td>
                                	<td class="content">
                                    <cfselect name="department" id="department" query="dept" display="name" value="depart_id" queryposition="below" ><option value="0">--Select--</option></cfselect>
								 </td>
                                </tr>
								<tr>
                                	<td colspan="6"><hr width="700" align="left" noshade></td>
                                	<td>&nbsp;</td>
                                </tr>
                                <tr>
                                	<td class="content"><input type="submit" id="Search" name="Search" value="Search"></td>
                                </tr>
                            </table>
                            </cfform>
                            
                            <cfif not structIsEmpty(FORM) and structKeyExists(FORM,"Search")>
                                    	<cfform name="searchresults" id="searchresults">
                            <table id="listUsers"height="390">
                            	<tr>
                                	<td class="content">
                                    <!--- <cfdump var="#FORM#" > --->
                                        <cfset dept = APPLICATION.com.control.admin.ListDepartments()  /> 
									    <cfgrid name="UsersList" format="html"  height="390" width="705"
									    font="Verdana" fontsize="12" pagesize="15" selectmode="edit" 
									   	bind="cfc:#APPLICATION.hardroot#control/adminman.resultForGridforSearch({cfgridpage},
									   	{cfgridpagesize},{cfgridsortcolumn},{cfgridsortdirection},'#Form.searchKey#','#Form.Campus#','#Form.department#')"
									  	onchange ="cfc:#APPLICATION.hardroot#control/adminman.editForGrid_User({cfgridaction},{cfgridrow},{cfgridchanged})"
									  	>
									    	 <cfgridcolumn name="US_ID" header="User ID" display="no"/>
									    	 <cfgridcolumn name="USERNAME" header="Username"/>
                                             <cfgridcolumn name="FIRSTNAME" header="First Name"/>
                                             <cfgridcolumn name="MIDDLENAME" header="Middle Name"/>
                                             <cfgridcolumn name="LASTNAME" header="Last Name" />
										     <cfgridcolumn name="CAMPUS" header="Campus" />
										     <cfgridcolumn name="EMAIL" header="Email"/>
                                             <cfgridcolumn name="WORKPHONE" header="Workphone"/>
                                             <cfgridcolumn name="MOBILEPHONE" header="Mobilephone"/>
                                             <cfgridcolumn name="FAX" header="Fax"/>
                                             <cfgridcolumn name="NAME" header="Department Name" />
											 <cfgridcolumn name="button" header="Action"/>
										</cfgrid>
                                    </td>
                                </tr>
                            </table>
									</cfform>
									<cfset ajaxonload("init") />
                            </cfif>
                            </div>
						  <cfwindow x="395" y="334" center="false" width="520" height="165" name="DisableVendor"
							       refreshOnShow ="true" draggable="true" modal="true" bodyStyle="font-family: verdana; background-color: ##ffffff;" 
							       headerStyle="background-color: ##006e51; color:##ffffff ; " 
							        title="Are You Sure ?" initshow="false"
							        source="expUser.cfm?us_id={searchUser:userid}&type={searchUser:type}" 
							        />
						  
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
