<cf_checksession />
<cfsilent>
	
	<cfset result = structNew() />
	<cfset structInsert(result,'message','') />
	<cfset structInsert(result,'flag', false) />
	
	<cfif not structIsEmpty(FORM) and structKeyExists(FORM,"genrequest")>
		<cfset result = APPLICATION.com.control.requests.genreq(FORM) />
		<cfif result.flag>
			<cfmail from="#APPLICATION.AdminEmail#" to="#SESSION.userdata.email#" subject="REQUEST RECEIVED">	
				Your Purchase Request has been successfully generated.
				------------  This Mail is an automatically generated email. Please donot reply -------
			</cfmail>
		</cfif>
	 </cfif>
	 
</cfsilent>
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
	myMenu.idMenuInit = 'purchaserequest';
	
	 var current = 1;
	 var resultStr = '';
	  $(document).ready(
  function() {

     $("#genreq").validate({
				messages: { 
					budgetid: "<span class='alert' style='font-size:16px;'><strong>&nbsp;!</strong></span>"
 				}
	   });
  });  
	 
	 function addOption(selectbox, value, text )
	{
		var optn = document.createElement("option");
		optn.text = text;
		optn.value = value;
		selectbox.options.add(optn);
	}
	function removeAllOptions(selectbox)
	{
		var i;
		for(i=selectbox.options.length-1;i>=0;i--)
		{
			//selectbox.options.remove(i);
			selectbox.remove(i);
		}
	}

	var loadSubCat =  function (subparam, value)
	{

		var dropDown = document.genreq['model'+subparam];
		removeAllOptions(dropDown);
		addOption(document.genreq['model'+subparam], "", "-- Select --", "");
		$.getJSON("/<cfoutput>#APPLICATION.hardroot#</cfoutput>control/requests.cfc", {
	        method: 'listmodels',
	        purchasetype_id: value,
	        returnformat: 'json'
	    }, function(modelsData){
			var word = '';
			var innerVar = '';
			
			word = modelsData.split("^");
			for (var i = 0;i < word.length;i++)
			{			
				innerVar = word[i].split(",");
				addOption(dropDown,innerVar[0],innerVar[1]);
			}
	    });
	};
	var makePurchaseTypes = function(){
		<cfset purchaseTypes = APPLICATION.com.control.requests.listPurchaseTypes().data />
		var str = '<cfoutput query="purchaseTypes"><option value="#purchaseTypes.id#">#purchaseTypes.name#</option></cfoutput>'; 
		return str;
	};
  var addItem = function()
  {
  	current = current + 1;
	var strAdd = '<table class="append'+current+'"><tr><td class="content"><strong> Item'+current+'</strong></td></tr><tr><td class="content">Type</td><td class="content"><select name="purchasetype'+current+'" id="purchasetype'+current+'" onchange="loadSubCat('+current+',this.value)">'+ makePurchaseTypes() +'</select> </td></tr><tr><td height="40" class="content">Model</td><td class="content"><select name="model'+current+'" id="model'+current+'" class="required"></select></td></tr><tr><td height="103" class="content">Description</td><td class="content"><textarea name="description'+current+'" cols="20" rows="3" id="description'+current+'"></textarea></td></tr><tr><td class="content">Quantity</td><td class="content"><input type="text" name="quantity'+current+'" class="required number" id="quantity'+current+'"></td></tr></table>';
	 $('#expand').append(strAdd);
	 document.genreq.count.value = current;
  };
   var removeItem = function()
   { if(current > 1){
	      $('.append'+ current).remove();
	      current = current - 1; 
	      document.genreq.count.value = current;
   		}
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
                        <td width="82%" class="headline"><!-- InstanceBeginEditable name="page title" -->Purchase Request<!-- InstanceEndEditable --></td>
                        <td width="9%" class="headline"><a href="javascript:window.print()" class="template" style="cursor:hand;"><img src="/ressources/images/template/print.gif" width="57" height="12" hspace="0" vspace="0" border="0"></a></td>
                        <td width="12%" class="headline"><a href="javascript:addToFav()" ><img src="/ressources/images/template/bookmark.gif" width="80" height="12" hspace="0" vspace="0" border="0"></a> </td>
                      </tr>

                    </table>
                 
                    <table width="750" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td width="520" height="230" align="left" valign="top" class="background_white"><!-- InstanceBeginEditable name="content" -->
                       
                        <script>
							
						</script>
						  <cfform name="genreq" method="post" action="purchaserequest.cfm">
							 <table width="466" border="0">
								<tr>
	                            	<td width="200" style="font-weight:bold;color:#006E51"  class="content">
	                         			<cfoutput> #Result.message#</cfoutput></td>
	                            </tr>
    	                   </table>
						<table width="466" border="0" >
                        <tr>
                              <td width="91" class="content">Budget ID</td>
                              <td width="365" class="content"><input type="hidden" name="itemcount" id="count" value="1">
								<input type="text" name="budgetid" id="budgetid" class="required number"></td>
                            </tr>
                        <tr>
                              <td width="91" class="content">On Behalf of</td>
                              <td width="365" class="content">
								<input type="text" name="onbehalfof" id="onbehalfof"></td>
                            </tr>
                        <tr>
                              <td width="91" class="content">Reason(On Behalf of)</td>
                              <td width="365" class="content">
								<textarea name="reason" cols="20" rows="3" id="reason"></textarea></td>
                            </tr>
						 <tr>
                          	<td class="content"><strong> Item1</strong></td>
                          </tr>  
                          <tr>
                            <td class="content">Type</td>
                          <td class="content">
                            <select name="purchasetype1" id="purchasetype1" onChange="loadSubCat(1,this.value)">
                             <cfoutput query="purchaseTypes"><option value="#purchaseTypes.id#">#purchaseTypes.name#</option></cfoutput>
                            </select> </td></tr>
                            
                            <tr>
                              <td height="40" class="content">Model</td>
                              <td class="content"><select name="model1" id="model1" class="required"></select></td>
                            </tr>
                            <tr>
                              <td height="103" class="content">Description</td>
                              <td class="content"><textarea name="description1" cols="20" rows="3" id="description1"></textarea></td>
                            </tr>
                            
                            <tr>
                              <td class="content">Quantity</td>
                              <td class="content"><input type="text" name="quantity1" id="quantity1" class="required number"></td>
                            </tr>
                            </table>
							<table width="466" border="0" id="expand">
							</table>
							
                            <table>
                            <tr>                            
                              <td class="content"><a href="javascript:addItem();"  >AddMoreItems</a></td>
                              <td class="content"><a href="javascript:removeItem();"  >Remove an Item</a></td>
                            </tr>
                            <tr>
                              <td class="content">&nbsp;</td>
                              <td class="content"><input type="submit" name="genrequest" id="genrequest" value="Generate Request"></td>
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
