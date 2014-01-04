	<cf_checkSession assetdesired ="3" purchasedesired = "3"/>
<cfsilent>
	<cfscript>
		page = APPLICATION.com.util.$struct(param = '',subparam = '',searchword='');
		if(isDefined("FORM") and not structisEmpty(FORM)){
			page.param = FORM.param;
			page.subparam = FORM.subparam;
			page.searchword = FORM.searchword;
		}

	</cfscript>
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
	<script src="../js/addtofav.js" type="text/javascript"></script>
		<link href="../css/purchaseActions.css" rel="stylesheet" type="text/css">
<script>
	myMenu.PathToTheRoot = "../";
	myMenu.idMenuInit = 'reports';
	
	 $(document).ready(
  function() {
    
     $("#drop_list").validate({
			
	   });	
  });

function SelectSubCat()
	{
		// ON selection of category this function will work
		
		removeAllOptions(document.drop_list.subparam);
		addOption(document.drop_list.subparam, "", "-- Select --", "");
		
		if(document.drop_list.param.value == 'Products')
			{
		addOption(document.drop_list.subparam,"date_started", "Date");
		addOption(document.drop_list.subparam,"serialno", "Serial#");
		addOption(document.drop_list.subparam,"name", "Product");
		addOption(document.drop_list.subparam,"vendor_id", "Vendor");
		addOption(document.drop_list.subparam,"purchase_id", "PurchaseOrder#");
		addOption(document.drop_list.subparam,"username", "End User");
			}
		if(document.drop_list.param.value == 'Softwares'){
		addOption(document.drop_list.subparam,"name_s", "Name");
		addOption(document.drop_list.subparam,"vendor_s", "Vendor");
		addOption(document.drop_list.subparam,"type_of_software", "Type");
		}
	}
	function markSelected(){
		var subparam = <cfoutput>'#page.subparam#'</cfoutput>;
		var i;
		var selectbox = document.drop_list.subparam;
		for(i=selectbox.options.length-1;i>=0;i--)
		{
			if(selectbox.options[i].value == subparam){
				selectbox.options[i].selected = true;
			}
		}
		
	}
	
////////////////// 
function removeAllOptions(selectbox)
{
	var i;
	for(i=selectbox.options.length-1;i>=0;i--)
	{
		//selectbox.options.remove(i);
		selectbox.remove(i);
	}
}

function addOption(selectbox, value, text )
{
	var optn = document.createElement("option");
	optn.text = text;
	optn.value = value;

	selectbox.options.add(optn);
}
		// ---------------------->  End for double drop down  <-----------------------------------	
function dovalidate(){
	var subparam = document.drop_list.subparam;
	if( subparam.value == 'date_started')
		{
		 $("#searchword").datepicker({ dateFormat: 'dd-M-yy',changeMonth: true, changeYear: true } );
		}
}
window.onload=function(){
	SelectSubCat();
	markSelected();
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
                        <td width="82%" class="headline"><!-- InstanceBeginEditable name="page title" -->Reports<!-- InstanceEndEditable --></td>
                        <td width="9%" class="headline"><a href="javascript:window.print()" class="template" style="cursor:hand;"><img src="/ressources/images/template/print.gif" width="57" height="12" hspace="0" vspace="0" border="0"></a></td>
                        <td width="12%" class="headline"><a href="javascript:addToFav()" ><img src="/ressources/images/template/bookmark.gif" width="80" height="12" hspace="0" vspace="0" border="0"></a> </td>
                      </tr>

                    </table>
                 
                    <table width="750" border="0" cellspacing="0" cellpadding="0">
                        <tr>
                          <td width="520" height="230" align="left" valign="top" class="background_white"><!-- InstanceBeginEditable name="content" -->
                          <form name="drop_list" id="drop_list" method="post" action="reports.cfm">
                          <table width="314" border="0">
                          <table width="314" border="0">
                                  <tr>
                                  <td class="content"><strong>Search</strong></td>
                                  <td class="content">
									<select name="param" onChange="SelectSubCat();" class="required" >
										<option value="">-- Select --</option>
										<option value="Products"<cfif compare(page.param,'Products') eq 0>selected</cfif>>Products</option>
										<option value="Softwares"<cfif compare(page.param,'Softwares') eq 0>selected</cfif>>Softwares</option>
									</select>
                                  </td>
                                </tr>

                                <tr>
                                	<td width="106" class="content"><strong>Search by</strong>                              																									                   					</td>
                                 	<td width="198" class="content">
                              			<select id="subparam" name="subparam" class="required">
											<option value=""></option>
										</select>
                                       </td>
                                 </tr>
                                <tr>
                                  <td class="content"><strong>Search for</strong></td>
                                  <td class="content"><input type="text" name="searchword" id="searchword" onClick="return dovalidate();" onFocus="return dovalidate();" <cfoutput>value="#page.searchword#"</cfoutput>/></td>
                                </tr>
                                <tr>
                                  <td class="content">&nbsp;</td>
                                      <td class="content"><input type="submit" name="search"  value="Download"></td><input name="productid" type="hidden" value="0">
									   <input name="type" type="hidden" value="0"> 
                                </tr>
                        
                          </table>
						 </form>
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
<cfif not structIsEmpty(FORM) and structKeyExists(FORM,"search")>
	<cfset result= APPLICATION.com.control.assetman.resultForReport('','',FORM.subparam,FORM.searchword) />
	<cfif result.data.recordcount neq 0>
			<cfcontent type="application/msexcel">
			<cfheader name="Content-Disposition" value="attachment;filename=""Report.xls""">
			<cfoutput>
				<cfif compareNoCase(FORM.param,'Products') eq 0>
							<table width="100%" border="1">
							 <tr bgcolor="##808080">
								<th>##</th>
								<th width="200px">Type</th>
								<th width="100px">Model</th>
								<th width="100px">Vendor Name</th>
								<th width="100px">Old/New</th>
								<th width="100px">Purchase Id</th>
								<th width="100px">Old Purchase Id</th>
								<th width="100px">Name</th>
								<th width="100px">Own/Leased</th>
								<th width="100px">Budgetid</th>
								<th width="100px">Started date</th>
								<th width="100px">Serialno</th>
							</tr> 
							<cfloop query="result.data">
							<tr>
								<td>#currentrow#</td>
								<td>#type#</td>
								<td>#model#</td>
								<td>#vendor_name#</td>
								<td>#old_new#</td>
								<td>#inspurchaseid#</td>
								<td>#purchaseid_old#</td>
								<td>#name#</td>
								<td>#OWNED_LEASED#</td>
								<td>#budgetid#</td>
								<td>#date_started#</td>
								<td>#serialno#</td>
							</tr>
						</cfloop>
					</table>
				<cfelseif compareNocase(FORM.param,'Softwares') eq 0>
							<table width="100%" border="1">
							 <tr bgcolor="##808080">
								<th>##</th>
								<th width="100px">Model</th>
								<th width="100px">Vendor Name</th>
								<th width="100px">Name</th>
								<th width="100px">Type of Software</th>
								<th width="100px">Old/New</th>
								<th width="100px">Purchase Id</th>
								<th width="100px">Old Purchase Id</th>
								<th width="100px">Number of Licenses</th>
								<th width="100px">Duration</th>
								<th width="100px">Duration Type</th>
								<th width="100px">Start date</th>
								<th width="100px">End date</th>
							</tr> 
							<cfloop query="result.data">
							<tr>
								<td>#currentrow#</td>
								<td>#model#</td>
								<td>#vendor_name#</td>
								<td>#name#</td>
								<td>#type_of_software#</td>
								<td>#old_new#</td>
								<td>#inspurchaseid#</td>
								<td>#purchaseid_old#</td>
								<td>#no_of_licenses#</td>
								<td>#duration#</td>
								<td>#durationtype#</td>
								<td>#startdate#</td>
								<td>#enddate#</td>
							</tr>
						</cfloop>
					</table>
				</cfif>
			</cfoutput>
	<cfelse>
	<script>
		alert("No records found");
	</script>
	</cfif>
</cfif>
