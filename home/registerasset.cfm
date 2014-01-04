<cfoutput>
	<cf_checkSession assetaccess = "#SESSION.userdata.ASSETPERMLEVEL#" 
				 purchaseaccess = "#SESSION.userdata.PURCHASEPERMLEVEL#" 
				 assetdesired ="3" 
				 purchasedesired = "3"/>
</cfoutput>
<cfscript>
		 RefpurchaseID = '';
		if(isDefined("FORM") and not structisEmpty(FORM)){
			RefpurchaseID = FORM.po;
		}
	</cfscript>
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
	<script src="../js/validate/jquery.validate.js" type="text/javascript"></script>
     <!--- Fin JS --->
    <script src="../js/ui.core.js" type="text/javascript"></script> 
    <script src="../js/ui.dialog.js" type="text/javascript"></script> 
     <script src="../js/ui.datepicker.min.js" type="text/javascript"></script> 
    <script src="../js/validate/jquery.validate.js" type="text/javascript"></script>
	<script src="../js/addtofav.js" type="text/javascript"></script>
<script>
	myMenu.PathToTheRoot = "../";
	myMenu.idMenuInit = 'registerasset';
	
	var doValidate_s = function(){
		var ret = true;
		
			/*Clear all notices first*/
				$("#name_sDivID").html('');
				$("#startdateDivID").html('');
				$("#noLicensesDivID").html('');
				$("#durationDivID").html('');
				$("#softwaretypeDivID").html('');
				$("#term_noticeDivID").html('');
			
			
			if(document.getElementById('name_s').value == '')
			{
				ret = false;
				$("#name_sDivID").html('<span class="alert"> Name field should not be empty</span>');	
			}
			if(document.getElementById('startdate').value == '')
			{
				ret = false;
				$("#startdateDivID").html('<span class="alert"> Date field should not be empty</span>');	
			}
			if(isNaN(document.getElementById('noLicenses').value) || document.getElementById('noLicenses').value == '')
			{
				ret = false;
				$("#noLicensesDivID").html('<span class="alert"> No of licenses field should be a number</span>');	
			}
			if(isNaN(document.getElementById('duration').value)  || document.getElementById('duration').value == '')
			{
				ret = false;
				$("#durationDivID").html('<span class="alert"> Duration field should be a number</span>');	
			}
			if(document.getElementById('softwaretype_0').checked == false 
				&& document.getElementById('softwaretype_1').checked == false
				&& document.getElementById('softwaretype_2').checked == false)
			{
				ret = false;
				$("#softwaretypeDivID").html('<span class="alert"> Type of Software field should  be checked</span>');	
			}
			if(document.getElementById('term_yes').checked == false 
				&& document.getElementById('term_no').checked == false)
			{
				ret = false;
				$("#term_noticeDivID").html('<span class="alert"> Termination Notice should  be checked</span>');	
			}
			
		
	if (ret == true){
		ColdFusion.navigate('purchRegister.cfm','RegDisplay', mycallBack, myerrorHandler,'POST','softwareform');
		
	}
};


	var doValidate_p = function(){
		var ret = true;
		var count = document.prdfrom.quantity.value;
		
			if(document.getElementById('date_p').value == '')
			{
				ret = false;
				$("#date_pDivID").html('<span class="alert"> Date field should not be empty</span>');	
			}
			if(document.getElementById('budgetid').value == '')
			{
				ret = false;
				$("#budgetidDivID").html('<span class="alert"> BudgetID field should not be empty</span>');	
			}
			
			for(i=1 ; i<= count ;i= i+1){
				if(document.getElementById('serial' + i).value == '')
						{
							ret = false;
							$("#serialDivID" + i).html('<span class="alert"> Serial field should not be empty</span>');	
						}	
				if(document.getElementById('enduser' + i).value == '')
						{
							ret = false;
							$("#enduserDivID" + i).html('<span class="alert"> End User field should not be empty</span>');	
						}	
				if(document.getElementById('product' + i).value == '')
						{
							ret = false;
							$("#productDivID" + i).html('<span class="alert"> Product field should not be empty</span>');	
						}	
			}
			
	if (ret == true){
		ColdFusion.navigate('purchRegister.cfm','RegDisplay', mycallBack, myerrorHandler,'POST','prdfrom');
	}
};
	var mycallBack = function(){};
	var myerrorHandler = function(){};
	var showterm = function(){
	document.getElementById('term').style.display = 'block';
	};

	var hideterm = function(){
	document.getElementById('term').style.display = 'none';
	};
</script>
<style>
.tableheading {
 	color: #444444;
    font-family: Verdana,Arial,Helvetica,sans-serif;
    font-size: 11px;
    font-weight: bold;
    padding-bottom: 5px;
    padding-left: 5px;
    padding-right: 5px;
}
#itemsListing TD{
 text-align:left;
}
.paddingAround {
	border-radius:8px;
	padding-left:10px;
	margin-bottom : 5px;
}
legend {
	font-weight:bold;
	color:#006E51;
}
.ulStyle {
	list-style-type:none;
}
.ulStyle LI {
	padding:0px 0px 5px 0px;
}

.itemHeaderUL {
	list-style-type:none;
	width: 650px;
	padding-left:0px;
}

.itemHeaderUL LI {
	float:left;
	padding:0px 5px 0px 0px;
}

.bld {
	font-weight: bold;
}
.notes{
	color:#006E51;
}
.alert{
color:red;
}
</style>
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
                        <td width="82%" class="headline"><!-- InstanceBeginEditable name="page title" -->Register Asset <!-- InstanceEndEditable --></td>
                        <td width="9%" class="headline"><a href="javascript:window.print()" class="template" style="cursor:hand;"><img src="/ressources/images/template/print.gif" width="57" height="12" hspace="0" vspace="0" border="0"></a></td>
                        <td width="12%" class="headline"><a href="javascript:addToFav()" ><img src="/ressources/images/template/bookmark.gif" width="80" height="12" hspace="0" vspace="0" border="0"></a> </td>
                      </tr>

                    </table>
                 
                    <table width="750" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td width="520" height="230" align="left" valign="top" class="background_white"><!-- InstanceBeginEditable name="content" -->
						<cfajaximport tags="cfform,cfinput-autosuggest,cfwindow,cfinput-datefield">
						<cfparam name="refPurchId" type="string" default="">
						<cfparam name="refItmId" type="string" default="">
						  <cfif structKeyExists(URL,'refPurchaseID') and URL.refPurchaseID neq "">
								<cfset refPurchId = URL.refPurchaseID />
								<script>
									window.onload = function(){
										document.getElementById('regasset').submit();
									};
								</script>
						 </cfif>
						<cfif not structIsEmpty(FORM) and structKeyExists(FORM,"POSearchWord")>
								<cfset refPurchId = FORM.POSearchWord />	
							  </cfif>
						
						<cfform name="regasset" id="regasset" action="registerasset.cfm" method="post">
							<table>
								<tr>
									 <td class="content">PO#</td>
									<td class="content">
									 <cfinput type="text" name="po" autosuggest="cfc:#APPLICATION.hardRoot#control/purchasing.POAutoSuggest({cfautosuggestvalue})"
													autoSuggestMinLength="4" class="required" 
													value="#refPurchId#"> 
													&nbsp;&nbsp;<input type="submit" name="Submit"  value="Show">
									
									</td>
								</tr>
								<input name="po_item" type="hidden">
								<input name="po_id" type="hidden">
								<!--- <tr id="poitem_s" >
	                               	  <td class="content">PO_Item#</td>
	                               	  <td class="content">
										<cfselect name="po_item"  class="required" value="id" display="rowI" bind="cfc:#APPLICATION.hardRoot#control/purchasing.listitemsIdforReg({po@change})"
										bindOnLoad="false" queryposition="below"><option value="0">--Select--</option></cfselect> 
										</td>
	                           	</tr> --->
							</table>
						</cfform>
						
						<cfif not structIsEmpty(FORM) and structKeyExists(FORM,"po")>
								<cfset getPurchid = APPLICATION.com.control.purchasing.getpurchId(FORM.po, 0) />
								<cfset purchId = getPurchid.data.purchase_id />
								<cfset Itmdata = APPLICATION.com.control.purchasing.assetRegistrationMismatch(purchId) />	
							<table>
							 <tr>
                   	   <td width="20px" class="tableheading">#</td>
                       <td width="80px" class="tableheading">Items</td>
                       <td width="80px" class="tableheading">Type</td>
                       <td width="150px" class="tableheading">&nbsp;</td>
				   </tr>						
		
							<cfoutput>
								<cfloop query="Itmdata">
								   <tr>
				                      <td width="20px" class="content">#currentrow#</td>
				                      <td width="80px" class="content"> Item #Itmdata.itemid#</td>
				                      <td width="80px" class="content"><cfif Itmdata.type eq 'P'>
					                      Products
										<cfelse>
										Softwares
										</cfif>
										</td>
				                      <td width="150px" class="content"><input type="button" name="rq_#Itmdata.purchases_items_id#" value="Register" onclick="fillHdntxt(#Itmdata.purchases_items_id#, #Itmdata.purchaseid#)" /></td>
								   </tr>
								</cfloop>
								</table>
								</cfoutput>		
							</cfif>
						
						<cfwindow x="210" y="300" center="false" width="715" height="575" name="RegDisplay"
						       refreshOnShow ="true" draggable="true" modal="true" bodyStyle="font-family: verdana; background-color: ##ffffff;" 
						       headerStyle="background-color: ##006e51; color:##ffffff ; " 
						        title="Register" initshow="false"
						        source="purchRegister.cfm?purchase_id={regasset:po_id}&item_id={regasset:po_item}" 
						        />
								<cfajaximport tags="cfform,cfinput-autosuggest,cfwindow">
						
								<script>
								   var fillHdntxt = function(a,b){
									document.regasset.po_item.value = a;
									document.regasset.po_id.value = b;
									ColdFusion.Window.show('RegDisplay');
									ColdFusion.Window.onHide('RegDisplay', onWinclose);
										
								};
									var onWinclose = function(){
										//window.location.reload();
										<cfoutput>
										var sURL = unescape(window.location.pathname + '?refPurchaseID=' + '#RefpurchaseID#');</cfoutput>
										 window.location.href = sURL;
																		}
									</script>
						
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
