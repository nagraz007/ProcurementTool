	<cf_checkSession  assetdesired ="2"  purchasedesired = "-1"/>
	<cfparam name="res" default="" type="string"> 
	<cfif isDefined("FORM.submit")>
		<cfset res = APPLICATION.com.control.assetman.registration(FORM) /> 
	    <script>
		window.onload = function (){
			document.getElementById("mesg").innerHTML = '<cfoutput>#res#</cfoutput>' ;
			document.getElementById("message").style.display = 'block';	
		};
		</script>
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
	<script src="../js/ui.datepicker.min.js"></script>
    <!--- Fin JS --->
    <script src="../js/ui.core.js" type="text/javascript"></script> 
    <script src="../js/ui.dialog.js" type="text/javascript"></script> 
     <script src="../js/ui.datepicker.min.js" type="text/javascript"></script> 
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
	myMenu.idMenuInit = 'newasset';	
	
	var dovalidate = function(){
		var po = document.fproducts.PO;
		var budgetid = document.fproducts.budgetid;
		var po_old = document.fproducts.PO_old;
		var po_item = document.fproducts.po_item;
		var ret = true;
		if(document.getElementById('old_new_1').checked){
			if(po.value == '' ){
						$("#poDivID").html('<span class="alert">PO should not be empty</span>');
			ret = false;	
			}
			else if (po_item.value == ''){
			$("#poitemDivID").html('<span class="alert">PO Item# should not be empty</span>');
			ret = false;
			}
		}
		else if (document.getElementById('old_new_0').checked) {
					if(po_old.value == '' ){
					$("#oldpoDivID").html('<span class="alert">Old PO should not be empty</span>');
					ret = false;	
					}
						}
		if (document.getElementById('ownership_0').checked) {
					if(budgetid.value == '' ){
					$("#budgetidDivID").html('<span class="alert">Budget Id should not be empty</span>');
					ret = false;	
					}
		}
		
		
		return ret;
	};
	
		var dovalidate_s = function(){
		var po_s = document.softwares.po_s;
		var po_s_old = document.softwares.po_old_s;
		var po_s_item = document.softwares.po_item_s;
		var ret = true;

		if(document.getElementById('old_new_4').checked){
			if(po_s.value == '' ){
			$("#po_sDivID").html('<span class="alert">PO should not be empty</span>');
			ret = false;	
			}
			else if (po_s_item.value == ''){
			$("#poitem_sDivID").html('<span class="alert">PO Item# should not be empty</span>');
			ret = false;
			}
		}
		else if (document.getElementById('old_new_3').checked) {
					if(po_s_old.value == '' ){
					$("#po_old_sDivID").html('<span class="alert">Old PO should not be empty</span>');
					ret = false;	
					}
						}
		
		return ret;
	};
	
	
	 $(document).ready(
  function() {
    
     $("#productsForm").validate({
				messages: { 
					date_p:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>",
					serial:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>",
					PO:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>",
					po_item:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>",
					assetType:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>",
					itmtype:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>",
					product:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>",
					vendor_p:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>",
					enduser:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>"
 				}
	   });
	   
$("#softwaresForm").validate({
				messages: { 
					date_s:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>",
					vendor_s:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>",
					po_s:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>",
					po_item_s:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>",
					name_s:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>",
					itmtype_s:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>",
					noLicenses:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>",
					startdate:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>",
					duration:"<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>"
 				}
	   });
    
   $("#pform").hide();
   $("#sform").hide();
   $("#budgetid").hide();
   $("#notice").hide();
    $("#po_old").hide();
    $("#po_old_s").hide();
   $("#product_or_software_0").click(function(){
  $("#pform").show();
  $("#sform").hide();
  });
  $("#product_or_software_1").click(function(){
  $("#pform").hide();
  $("#sform").show();
  });
   $("#owner").click(function(){
  $("#budgetid").show();
  
  });
     $("#lease").click(function(){
  $("#budgetid").hide();
    });
	 $("#term_yes").click(function(){
  $("#notice").show();
    });
	$("#term_no").click(function(){
  $("#notice").hide();
    });
   
   });
   
chkitemValid = function(itemno, inspurchid){
    $.getJSON("/<cfoutput>#APPLICATION.Hardroot#</cfoutput>control/purchasing.cfc", {
        method: 'chkitemValid',
        itemnumber: itemno,
        inspurchid: inspurchid,
        returnformat: 'json'
    }, function(isitemvalidUnique){
        if (isitemvalidUnique == true) {
            $("#theErrorDivID").html('<span class="alert">Itemnumber is valid</span>');
            $("#theErrorDivID_s").html('<span class="alert">Itemnumber is valid</span>');
        }
        else {
            $("#theErrorDivID").html('<span class="alert">Itemnumber is invalid</span>');
            $("#theErrorDivID_s").html('<span class="alert">Itemnumber is invalid</span>');
        }
    });
};
var showold = function()
	{
	 $("#po_old").show();
	 $("#po").hide();
	 $("#poitem").hide();
	};

var shownew = function()
	{
	 $("#po_old").hide();
	 $("#po").show();
	 $("#poitem").show();
		
	};
var showold_s = function()
	{
	 $("#po_old_s").show();
	 $("#ponumber_s").hide();
	 $("#poitem_s").hide();
	};

var shownew_s = function()
	{
		 $("#po_old_s").hide();
	 $("#ponumber_s").show();
	 $("#poitem_s").show();
	};
	
var showbudgetid = function()
	{
	 $("#budgetid").show();
	};
	
var hidebudgetid = function()
	{
	 $("#budgetid").hide();
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
                        <td width="82%" class="headline"><!-- InstanceBeginEditable name="page title" -->New Asset Registration<!-- InstanceEndEditable --></td>
                        <td width="9%" class="headline"><a href="javascript:window.print()" class="template" style="cursor:hand;"><img src="/ressources/images/template/print.gif" width="57" height="12" hspace="0" vspace="0" border="0"></a></td>
                        <td width="12%" class="headline"><a href="javascript:addToFav()" ><img src="/ressources/images/template/bookmark.gif" width="80" height="12" hspace="0" vspace="0" border="0"></a> </td>
                      </tr>

                    </table>
                 
                    <table width="750" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td width="520" height="230" align="left" valign="top" class="background_white"><!-- InstanceBeginEditable name="content" -->

        				  <table>
		                            <cfajaximport tags="cfinput-datefield">                         
                          	<tr>
                            	<td width="104" class="content">
                                <input  type="radio" name="productOrSoftware" value="0" id="product_or_software_0" >
                                Product                                </td>
                                <td width="104" class="content">
                                <input type="radio" name="productOrSoftware"  value="1"id="product_or_software_1">
                                Software                                </td>
                            </tr>
							 </table>
                        	<div id="message" style="display:none">
								 <table>
									<tr>
		                            	<td width="200" style="color:red"  class="content">
		                         			 <span id="mesg" >&nbsp; </span> </td>
		                            </tr>
	    	                   </table>
							</div>  
							
								<cfform name="fproducts" id="productsForm" method="post" action="newasset.cfm" onSubmit="return dovalidate();">
                            	<table id="pform" >
                            		  	<!--- <form name="products" method="post" action="newasset.cfm"> --->
								<tr>
                                	<td class="content">
                                    	<input type="hidden" name="product_0" value="0">
                                    </td>
                                </tr>			
                               	<tr>
                            		<td width="135" class="content">
                                    Type<span class="alert">*</span></td>
                                    <td class="content">Old<input type="radio" name="old_new" value="OLD" id="old_new_0" onclick="showold();" >
                               	       &nbsp;&nbsp; New                               	 
                               	        <input type="radio" name="old_new" value="NEW" id="old_new_1" checked onclick="shownew();"> </td>
                               	</tr>
                               	<tr id="date1">
                            		<td width="135" class="content">
                                    Date Started<span class="alert">*</span></td>
                                    <td width="323" class="content"><cfinput type="datefield" mask="DD-MMM-YYYY" name="date_p" id="date_p" class="required" ></td>
                               	</tr>
                               	<tr >
                               	  <td class="content">Asset Type<span class="alert">*</span></td>
                               	  <td class="content"><cfselect name="assetType" class="required" bind="cfc:#APPLICATION.hardRoot#control/assetman.listTypes()" bindOnLoad="true" value="id" display="name"></cfselect></td>
                           	    </tr>
                               	<tr >
                               	  <td class="content">Item Type<span class="alert">*</span></td>
                               	  <td class="content"><cfselect name="itmtype"  class="required" value="id" display="name" bind="cfc:#APPLICATION.hardRoot#control/assetman.listModels({assetType@change})" bindOnLoad="false"><option name="0">--Select One--</option></cfselect></td>
                           	    </tr>
								<tr id="serial" >
                               	  <td class="content">Serial#<span class="alert">*</span></td>
                               	  <td class="content"><input type="text" name="serial" class="required" ></td>
                           	    </tr>
                               	<tr id="product">
                               	  <td class="content">Product<span class="alert">*</span></td>
                               	  <td class="content"><input type="text" name="product" class="required" ></td>
                           	    </tr>
                               	<tr >
                               	  <td class="content">Ownership<span class="alert">*</span></td>
                               	  <td class="content">
                               	        Own 
                               	        <input type="radio" name="ownership" value="Own" id="ownership_0"  onclick="showbudgetid();" > &nbsp;&nbsp;
                               	        <input type="radio" name="ownership" value="Leased" id="ownership_1" checked  onclick="hidebudgetid();" >
                               	        Leased                         	  </td>
                           	    </tr>
                               	<tr id="vendor">
                               	  <td class="content">Vendor<span class="alert">*</span></td>
                               	  <td class="content"><cfinput type="text" class="required" name="vendor_p" autosuggest="cfc:#APPLICATION.hardRoot#control/assetman.autosuggestvendors({cfautosuggestvalue})" showAutosuggestLoadingIcon="true" autoSuggestMinLength="2" ></td>
                           	    </tr>
                               	<tr id="budgetid">
                               	  <td class="content">BudgetID</td>
                               	  <td class="content"><input type="text" name="budgetid" > <div id="budgetidDivID"></div></td>
                           	    </tr>
                               	<tr id="po" >
                               	  <td class="content">PO#<span class="alert">*</span></td>
                               	  <td class="content"><cfinput type="text" name="PO" autosuggest="cfc:#APPLICATION.hardRoot#control/assetman.POAutoSuggest({cfautosuggestvalue})"
												autoSuggestMinLength="4" class=""  >  <div id="poDivID"></div></td>
                           	    </tr>
                               	<tr id="poitem" >
                               	  <td class="content">PO_Item#<span class="alert">*</span></td>
                               	  <td class="content">
									<cfselect name="po_item"  class="" value="id" display="rowI" bind="cfc:#APPLICATION.hardRoot#control/purchasing.listitemsId({PO@change})"
									bindOnLoad="false"><option value="0">--Select--</option></cfselect>
									<div id="poitemDivID"></div></td>
                           	    </tr>
								
								<tr id="po_old">
                               	  <td class="content">Old PO#<span class="alert">*</span></td>
                               	  <td class="content"><input type="text" name="PO_old"  ><div id="oldpoDivID"></div></td>
                           	    </tr>
                               	<tr id="campus">
                               	  <td class="content">Campus<span class="alert">*</span></td>
                               	  <td class="content"><select name="campus" id="select" class="required" >
                               	    <option class="content" value="SGP">Singapore</option>
                               	    <option class="content" value="FBL">Fontainebleau</option>
                               	    <option class="content" value="AUH">Abudhabi</option>
                             	    </select>                               	  </td>
                           	    </tr>
								<tr>
									<td class="content">
										End User Name<span class="alert">*</span>
									</td>
									<td class="content">
										<cfinput type="text" class="required" name="enduser" autosuggest="cfc:#APPLICATION.hardRoot#control/assetman.autosuggestusers({cfautosuggestvalue})" autoSuggestMinLength="3"  showAutosuggestLoadingIcon="true">
									</td>
								</tr>
                               	<tr id="submit">
                               	  <td class="content">&nbsp;</td>
                               	  <td class="content"><input type="submit" name="submit" id="button" value="Save"></td>
                           	    </tr>
								<!--- </form> --->
                            </table>
								</cfform>
								<cfform name="softwares" id="softwaresForm" method="post" action="newasset.cfm"  onSubmit="return dovalidate_s();" >
                            <table id="sform">
								<tr>
                                	<td class="content" >
                                    	<input type="hidden" name="product_0" value="1">
                                    </td>
                                </tr>
								<tr>
                            		<td width="135" class="content">
                                    Type<span class="alert">*</span></td>
                                    <td class="content">Old<input type="radio" name="old_new" value="OLD" id="old_new_3" onclick="showold_s();" >
                               	       &nbsp;&nbsp; New                               	 
                               	        <input type="radio" name="old_new" value="NEW" id="old_new_4" checked onclick="shownew_s();" > </td>
                               	</tr>
                            	<!--- <tr>
                                	<td width="127" class="content">
                                    	Date                                    
									</td>
                                  	<td width="331" class="content">
                               		  <input type="text" name="date_s" id="date_s" class="required "> 
									</td>
		                     	</tr> --->
                            	<tr>
                            	  <td class="content">Vendor<span class="alert">*</span></td>
                            	  <td class="content" width="331"><cfinput type="text" name="vendor_s" class="required"
							autosuggest="cfc:#APPLICATION.hardRoot#control/assetman.autosuggestvendors({cfautosuggestvalue})" autoSuggestMinLength="2" showAutosuggestLoadingIcon="true" ></td>
                          	  	</tr>
                            	<tr>
                            	  <td height="40" class="content"> License Type<span class="alert">*</span></td>
                            	  <td class="content">
									<cfselect name="itmtype_s" class="required" value="id" display="name" bind="cfc:#APPLICATION.hardRoot#control/assetman.listModels(11)" bindOnLoad="true"></cfselect>
									</td>
                          	  	</tr>
                            	<tr>
                            	  <td height="40" class="content">Name<span class="alert">*</span></td>
                            	  <td class="content"><input type="text" name="name_s" class="required"></td>
                          	  	</tr>
                            	<tr>
                            	  <td class="content">Software Type<span class="alert">*</span></td>
                            	  <td class="content">
										<!--- <table width="178">
       	    		      <tr>
                            	      			<td width="170"> --->
                            	       				 <input type="radio" name="softwaretype" value="Individual" id="softwaretype_0">
                            	  				      Individual &nbsp;&nbsp;&nbsp;&nbsp;
										<input type="radio" name="softwaretype" value="Organizationwide" id="softwaretype_1">
                            	        					Organizationwide  
										<input type="radio" name="softwaretype" value="Department" id="softwaretype_2">
                            	        						Department
												<!--- </td>
                       	      			  </tr>
                            	    		<tr>
                            	      				<td>
                            	        					<input type="radio" name="softwaretype" value="Organizationwide" id="softwaretype_1">
                            	        					Organizationwide                            	      																	</td>
                          	      			</tr>
                            	    		<tr>
                            	      				<td>
                            	        					<input type="radio" name="softwaretype" value="Department" id="softwaretype_2">
                            	        						Department
													</td>
                          	      			</tr>
                          	    		</table>      --->                       	  </td>
                          	  </tr>
                            	<tr>
                            	  <td class="content">No. of Licenses<span class="alert">*</span></td>
                            	  <td class="content"><input type="text" name="noLicenses" class="required number" ></td>
                          	  </tr>

                            	<tr>
                            	  <td class="content">Duration of<span class="alert">*</span> <br>
                            	    Contract</td>
                            	  <td class="content"><input name="duration" type="text" size="4" class="required number"> &nbsp;
                            	    <select name="durationtypeOptions" id="select2">
                            	      <option class="content" value="day">days</option>
                            	      <option class="content" value="month">months</option>
                            	      <option class="content" value="year">years</option>
                          	        </select>                           	      </td>
                          	  </tr>
                            	<tr>
                            	  <td class="content">Start Date<span class="alert">*</span></td>
                            	  <td class="content"><cfinput type="datefield" mask="DD-MMM-YYYY" name="startdate" id="startdate" class="required"></td>
                          	  </tr>
									<tr id="ponumber_s">
	                               	  <td class="content">PO#<span class="alert">*</span></td>
	                               	  <td class="content">
		                               	  <cfinput type="text" name="po_s" autosuggest="cfc:#APPLICATION.hardRoot#control/assetman.POAutoSuggest({cfautosuggestvalue})"
													autoSuggestMinLength="4" class=""  > 
													<div id="po_sDivID"></div></td>
	                           	    </tr>
	                           	<tr id="poitem_s" >
	                               	  <td class="content">PO_Item#<span class="alert">*</span></td>
	                               	  <td class="content">
										<cfselect name="po_item_s"  class="required" value="id" display="rowI" bind="cfc:#APPLICATION.hardRoot#control/purchasing.listitemsId({po_s@change})"
										bindOnLoad="false"><option value="0">--Select--</option></cfselect> <div id="poitem_sDivID"></div>
										</td>
	                           	    </tr>
								<tr id="po_old_s" >
	                               	  <td class="content">Old PO#<span class="alert">*</span></td>
	                               	  <td class="content"><input type="text" name="po_old_s"  class=""  > <div id="po_old_sDivID"></div></td>
	                           	    </tr>
								<tr>
                            	  <td class="content">Termination Notice<br> 
                           	      Required</td>
                            	  <td class="content">      <input type="radio" name="term_notice" value="yes" id="term_yes">
                            	        Yes
                            	        <input type="radio" name="term_notice" value="no" id="term_no"  checked>
                            	        No
                            	  </td>
                          	  </tr>
                            	<tr id="notice">
                            	  <td class="content">Notice Requirement</td>
                            	  <td class="content"><textarea name="noticeReq"  cols="20" rows="2"></textarea></td>
                          	  </tr>
                            	<tr>
                            	  <td class="content">&nbsp;</td>
                            	  <td class="content"><input type="submit" name="submit"  value="Save"></td>
                          	  </tr>
                            </table>
								</cfform>
                            
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
