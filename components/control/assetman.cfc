<cfcomponent displayname="assetman" output="false" extends="config">

	<cffunction name="init" access="public" returntype="assetman" description="Generates an object of itself">
		<cfset SUPER.init() />
		<cfreturn THIS />
	</cffunction>
	
	<cffunction name="resultForGrid" access="remote" output="false"
				description="Interacts with the corresponding Models and fetches the Search results for Product/Software">
		<cfargument name="page" required="true" />
		<cfargument name="pageSize" type="numeric" required="true" />
		<cfargument name="gridsortcolumn" type="string" required="true" />
		<cfargument name="gridstartdirection" type="string" required="true" />
		<cfargument name="searchFactor" type="string" required="true" />
		<cfargument name="searchword" type="string" required="true" />		
			
		<cfscript>
			var getdata = {};
			var EsData = {}; /*Essential data : data that is manipulated locally before sending to the View*/
			var productId = '';
			var vendornames = {};
			var purchId = {};
			var vendorid = '';
			var Usid = 0;
			var i=1;
			
			var util = APPLICATION.com.util;
			
		 switch(ARGUMENTS.searchFactor)
		 {
		 		 case 'date_started':
		 		 case 'serialno':
		 		 case 'name':
		 		 		getdata = APPLICATION.com.model.products.listall(ARGUMENTS.searchFactor, ARGUMENTS.searchword,
		 		 					 ARGUMENTS.gridsortcolumn, ARGUMENTS.gridstartdirection);
		 		 		return QueryConvertForGrid(getdata.data, page, pageSize); /* Error Handling*/
		 		 		break;
		 		 case 'vendor_id':
						EsData = APPLICATION.com.model.vendors.autovendor(ARGUMENTS.searchword);
						vendorid = ValueList(Esdata.vendor_id); 
						getdata =  APPLICATION.com.model.products.listall(ARGUMENTS.searchFactor, vendorid ,
		 		 					 ARGUMENTS.gridsortcolumn, ARGUMENTS.gridstartdirection);	 		 		
		 				return QueryConvertForGrid(getdata.data, page, pageSize); /* Error Handling*/
		 		 		break;	
		 		 case 'purchase_id':
		 		 		purchId = APPLICATION.com.model.purchases.getpurchId(ARGUMENTS.searchword, 0);
		 		 	//	Esdata = APPLICATION.com.model.mapAst.listmap_assets(0, purchid.data.purchase_id, 0, 0);
		 		 		//productId = ValueList(Esdata.data.product_id);
		 		 		getdata =  APPLICATION.com.model.products.listall('purchase_id', purchId.data.purchase_id,
		 		 					 ARGUMENTS.gridsortcolumn, ARGUMENTS.gridstartdirection);	
		 		 		return QueryConvertForGrid(getdata.data, page, pageSize); /* Error Handling*/
						break;
		 		 case 'username':
		 		 		
		 		 		Esdata = APPLICATION.com.model.users.userProductIdForSearch(ARGUMENTS.searchword);
		 		 		productId = ValueList(Esdata.data.product_id);
		 		 		getdata =  APPLICATION.com.model.products.listall('product_id', productId,
		 		 					 ARGUMENTS.gridsortcolumn, ARGUMENTS.gridstartdirection);	
		 		 		return QueryConvertForGrid(getdata.data, page, pageSize); /* Error Handling*/
				 		break;
				 case 'name_s' :
				 		getdata = APPLICATION.com.model.softwares.listSoftwares('name', ARGUMENTS.searchword,
		 		 					 ARGUMENTS.gridsortcolumn, ARGUMENTS.gridstartdirection);
		 		 		return QueryConvertForGrid(getdata.data, page, pageSize); /* Error Handling*/
				 		break;
				 case 'vendor_s' :
						EsData = APPLICATION.com.model.vendors.autovendor(ARGUMENTS.searchword);
						vendorid = ValueList(Esdata.vendor_id); 
				 		getdata = APPLICATION.com.model.softwares.listSoftwares('vendor_id',vendorid,
		 		 					 ARGUMENTS.gridsortcolumn, ARGUMENTS.gridstartdirection);
		 		 		return QueryConvertForGrid(getdata.data, page, pageSize); /* Error Handling*/
				 		break;
		  		case 'type_of_software' :
				 		getdata = APPLICATION.com.model.softwares.listSoftwares(ARGUMENTS.searchFactor, ARGUMENTS.searchword,
		 		 					 ARGUMENTS.gridsortcolumn, ARGUMENTS.gridstartdirection);
		 		 		return QueryConvertForGrid(getdata.data, page, pageSize); /* Error Handling*/
				 		break;
		  		  }
		</cfscript>
	</cffunction>

	<cffunction name="editForGrid_Product" access="remote" output="false"
		description="Interacts with the corresponding Models and provides edit functinality in grid for search results of Products">
        <cfargument name="gridaction" type="string" required="yes">
        <cfargument name="gridrow" type="struct" required="yes">
        <cfargument name="gridchanged" type="struct" required="yes">
		
		<cfscript>
		var colname = '';
        var value = '';
        var Esdata = {}; /* Essential data : data that is manipulated locally */
        var Esdata1 = {}; /* Essential data : data that is manipulated locally */
        var vendor = {}; 
        var usid = 0; 
        var usid1 = 0; 
        var i = 1; 
			switch(ARGUMENTS.gridaction)
			{
					case 'U' :
						colname = StructKeyList(ARGUMENTS.gridchanged) ;	
						value = ARGUMENTS.gridchanged[colname];
						switch(colname)
						{
							case 'serialno' 	: Esdata = APPLICATION.com.model.products.updateproduct(ARGUMENTS.gridrow.product_id,
												 0, '', '', value, 0, '', '','', SESSION.userdata.us_id);
												break;
							case 'name'			: Esdata = APPLICATION.com.model.products.updateproduct(ARGUMENTS.gridrow.product_id,
												0, value, '', '', 0, '', '','', SESSION.userdata.us_id);
												break;
							case 'budgetid'		: Esdata = APPLICATION.com.model.products.updateproduct(ARGUMENTS.gridrow.product_id,
												0, '', '', '', value, '', '','', SESSION.userdata.us_id);
												break;
						 	case 'owned_leased' : Esdata = APPLICATION.com.model.products.updateproduct(ARGUMENTS.gridrow.product_id,
												0, '', value, '', 0, '','','', SESSION.userdata.us_id);
												break;
						 	case 'old_new' 		: Esdata = APPLICATION.com.model.products.updateproduct(ARGUMENTS.gridrow.product_id,
												0, '', '', '', 0, '',value,'', SESSION.userdata.us_id);
												break;
							case 'vendor_name'  : vendor = APPLICATION.com.model.vendors.listvendors(0, value);
												  Esdata = APPLICATION.com.model.products.updateproduct(ARGUMENTS.gridrow.product_id,
												vendor.data.vendor_id, '', '', '', 0, '', '','',  SESSION.userdata.us_id);
												break;
							case 'username'     : usid = APPLICATION.com.model.users.authenticateUser(value); 	
												 usid1 = APPLICATION.com.model.users.authenticateUser(ARGUMENTS.gridrow.username); 	
												  Esdata = APPLICATION.com.model.PrdUsrHist.listmap_assets(0,  ARGUMENTS.gridrow.product_id, usid1);
												// purchId = APPLICATION.com.model.purchases.getpurchId(ARGUMENTS.gridrow.inspurchaseid, 0);
												 	for (i=1; i lte Esdata.data.recordcount ; i++)
												 	{
														 if(Esdata.data.enddate eq '')
													  	{
																					 									
														  	Esdata1 = APPLICATION.com.model.PrdUsrHist.updatemapEnddate(Esdata.data.asset_id, SESSION.userdata.us_id);
													  			
													  	Esdata1 = APPLICATION.com.model.PrdUsrHist.insertprd_hist(usid, ARGUMENTS.gridrow.product_id, 
													  			DateFormat(Now(),"dd-mmm-yyyy"), '', SESSION.userdata.us_id);										  	
													break;
													  	}
												 	}
												  break;
							/*case 'inspurchaseid' :  if (value neq '')
													{
														purchId = APPLICATION.com.model.purchases.getpurchId(value, 0);
														Esdata = APPLICATION.com.model.mapAst.updatemappurchaseid(purchid.data.purchase_id, ARGUMENTS.gridrow.product_id, SESSION.userdata.us_id);
													}
													else
													{
														Esdata = APPLICATION.com.model.mapAst.updatemappurchaseid(0 , ARGUMENTS.gridrow.product_id, SESSION.userdata.us_id);
																										
													}
													break;*/
							case 'purchaseid_old'  :  Esdata = APPLICATION.com.model.products.updateproduct(ARGUMENTS.gridrow.product_id,
												0, '', '', '', 0, '','', value, SESSION.userdata.us_id);
												break;
						}
							break;
					
					/*case 'D' :
							Esdata = APPLICATION.com.model.products.deleteproduct(ARGUMENTS.gridrow.product_id);
								break;*/
			}
			
		</cfscript>
	</cffunction>

	<cffunction name="editForGrid_Software" access="remote" output="false"
			description="Interacts with the corresponding Models and provides edit functinality in grid for search results of Softwares">
        <cfargument name="gridaction" type="string" required="yes">
        <cfargument name="gridrow" type="struct" required="yes">
        <cfargument name="gridchanged" type="struct" required="yes">
		
		<cfscript>
		var colname = '';
        var value = '';
        var Esdata = {};
			switch(ARGUMENTS.gridaction)
			{
					case 'U' :
						colname = StructKeyList(ARGUMENTS.gridchanged) ;	
						value = ARGUMENTS.gridchanged[colname];
							switch(colname)
							{
								case 'name'				 : Esdata = APPLICATION.com.model.softwares.updatesoftware(ARGUMENTS.gridrow.software_id,
													 0, value, 0, '', 0, '', '', '', '', '', '', '', SESSION.userdata.us_id);
													break;
															
								case 'Termination_notice': Esdata = APPLICATION.com.model.softwares.updatesoftware(ARGUMENTS.gridrow.software_id,
													 0, '', 0, '', 0, '', '', value, '', '', '', '',  SESSION.userdata.us_id);
													break;
															
								case 'NoticeRequirement' : Esdata = APPLICATION.com.model.softwares.updatesoftware(ARGUMENTS.gridrow.software_id,
													 0, '', 0, '', 0, '', '', '', value, '',  '', '', SESSION.userdata.us_id);
													break;
															
								case 'type_of_software'  : Esdata = APPLICATION.com.model.softwares.updatesoftware(ARGUMENTS.gridrow.software_id,
													 0, '', 0, '', 0, '', '', '', '', value, '', '',  SESSION.userdata.us_id);
													break;
								case 'vendor_name'  : vendor = APPLICATION.com.model.vendors.listvendors(0, value);
												 Esdata = APPLICATION.com.model.softwares.updatesoftware(ARGUMENTS.gridrow.software_id,
													 vendor.data.vendor_id, '', 0, '', 0, '', '', '', '', '', '', '',  SESSION.userdata.us_id);
												break;	
							/*	case 'inspurchaseid' :  if (value neq '')
													{
														purchId = APPLICATION.com.model.purchases.getpurchId(value, 0);
														Esdata = APPLICATION.com.model.softwares.updatesoftwarePurchaseId(purchid.data.purchase_id, ARGUMENTS.gridrow.software_id, SESSION.userdata.us_id);
													}
													else
													{
														Esdata = APPLICATION.com.model.softwares.updatesoftwarePurchaseId(0 , ARGUMENTS.gridrow.software_id, SESSION.userdata.us_id);
																										
													}
													break;*/
								case 'old_new' 		: Esdata = APPLICATION.com.model.softwares.updatesoftware(ARGUMENTS.gridrow.software_id,
													 0, '', 0, '', 0, '', '', '', '', '', value, '',  SESSION.userdata.us_id);
														break;						
								case 'purchaseid_old': Esdata = APPLICATION.com.model.softwares.updatesoftware(ARGUMENTS.gridrow.software_id,
													 0, '', 0, '', 0, '', '', '', '', '', '', value,  SESSION.userdata.us_id);
														break;						
							}
					break;
					
			}
			
		</cfscript>
			
	</cffunction>

	<cffunction name="resultForReport" access="public" output="false" returntype="struct"
			description="Interacts with the corresponding Models and generates resut required for report generation">
		<cfargument name="gridsortcolumn" type="string" required="true" />
		<cfargument name="gridstartdirection" type="string" required="true" />
		<cfargument name="searchFactor" type="string" required="true" />
		<cfargument name="searchword" type="string" required="true" />		
			
		<cfscript>
			var getdata = {};
			var EsData = {}; /*Essential data : data that is manipulated locally before sending to the View*/
			var productId = '';
			var vendornames = {};
			var purchId = {};
			var vendorid = '';
			var Usid = 0;
			var i=1;
			
			var util = APPLICATION.com.util;
			
		 switch(ARGUMENTS.searchFactor)
		 {
		 		 case 'date_started':
		 		 case 'serialno':
		 		 case 'name':
		 		 		getdata = APPLICATION.com.model.products.listall(ARGUMENTS.searchFactor, ARGUMENTS.searchword,
		 		 					 ARGUMENTS.gridsortcolumn, ARGUMENTS.gridstartdirection);
		 		 		return getdata; /* Error Handling*/
		 		 		break;
		 		 case 'vendor_id':
						EsData = APPLICATION.com.model.vendors.autovendor(ARGUMENTS.searchword);
						vendorid = ValueList(Esdata.vendor_id); 
						getdata =  APPLICATION.com.model.products.listall(ARGUMENTS.searchFactor, vendorid ,
		 		 					 ARGUMENTS.gridsortcolumn, ARGUMENTS.gridstartdirection);	 		 		
		 				return getdata; /* Error Handling*/
		 		 		break;	
		 		 case 'purchase_id':
		 		 		purchId = APPLICATION.com.model.purchases.getpurchId(ARGUMENTS.searchword, 0);
		 		 	//	Esdata = APPLICATION.com.model.mapAst.listmap_assets(0, purchid.data.purchase_id, 0, 0);
		 		 		//productId = ValueList(Esdata.data.product_id);
		 		 		getdata =  APPLICATION.com.model.products.listall('purchase_id', purchId.data.purchase_id,
		 		 					 ARGUMENTS.gridsortcolumn, ARGUMENTS.gridstartdirection);	
		 		 		return getdata; /* Error Handling*/
						break;
		 		 case 'username':
		 		 		
		 		 		Esdata = APPLICATION.com.model.users.userProductIdForSearch(ARGUMENTS.searchword);
		 		 		productId = ValueList(Esdata.data.product_id);
		 		 		getdata =  APPLICATION.com.model.products.listall('product_id', productId,
		 		 					 ARGUMENTS.gridsortcolumn, ARGUMENTS.gridstartdirection);	
		 		 		return getdata; /* Error Handling*/
				 		break;
				 case 'name_s' :
				 		getdata = APPLICATION.com.model.softwares.listSoftwares('name', ARGUMENTS.searchword,
		 		 					 ARGUMENTS.gridsortcolumn, ARGUMENTS.gridstartdirection);
		 		 		return getdata; /* Error Handling*/
				 		break;
				 case 'vendor_s' :
						EsData = APPLICATION.com.model.vendors.autovendor(ARGUMENTS.searchword);
						vendorid = ValueList(Esdata.vendor_id); 
				 		getdata = APPLICATION.com.model.softwares.listSoftwares('vendor_id',vendorid,
		 		 					 ARGUMENTS.gridsortcolumn, ARGUMENTS.gridstartdirection);
		 		 		return getdata; /* Error Handling*/
				 		break;
		  		case 'type_of_software' :
				 		getdata = APPLICATION.com.model.softwares.listSoftwares(ARGUMENTS.searchFactor, ARGUMENTS.searchword,
		 		 					 ARGUMENTS.gridsortcolumn, ARGUMENTS.gridstartdirection);
		 		 		return getdata; /* Error Handling*/
				 		break;
		  		  }
		</cfscript>
	</cffunction>
	
	<cffunction name="registration" access="public" returntype="string" output="false"
		description="Interacts with corresponding Models and Inserts/Registers Product/Software">
		<cfargument name="Form" type="struct" required="true" />
		
		<cfset var vendorid = {} />
		<cfset var RequestedData = ARGUMENTS.Form />
		<cfset var productStatus = {} />
		<cfset var purchaseCheck = {} />
		<cfset var userid = 0 />
		<cfset var stockid = 0 />
		<cfset var purchid = {} />
		<cfset var productMapStatus = {} />
		<cfset var softwareStatus = {} />
	
	<cfscript>
		if(RequestedData.product_0 eq 0)
			{
					 vendorid = APPLICATION.com.model.vendors.listvendors(0,ARGUMENTS.Form.vendor_p);	
					 		if(RequestedData.budgetid eq '')
							 	{
							 		RequestedData.budgetid = 0;				 	
							 	}
								 	if( compareNoCase(RequestedData.old_new,'OLD') eq 0)
								 	{
								 			RequestedData.po_item = -1;	
								 			purchId.data.purchase_id = -1;							 	
								 	}
								 	else if (not structkeyexists(RequestedData,"purchase_id"))
								 	{
								 				purchId = APPLICATION.com.model.Purchases.getpurchId(RequestedData.PO, 0);					 	
								 	}
								 	else{
								 		purchId.data.purchase_id = 	RequestedData.purchase_id;						 	
								 	}
					  productStatus = APPLICATION.com.model.products.insertproduct(vendorid.data.vendor_id, RequestedData.product
						, RequestedData.ownership, RequestedData.serial, RequestedData.budgetid, RequestedData.date_p , RequestedData.assetType,
						RequestedData.itmtype, RequestedData.old_new, purchId.data.purchase_id, RequestedData.po_item , RequestedData.po_old, RequestedData.campus, SESSION.userdata.us_id );
						if(productStatus.success)
						{
							 userid = APPLICATION.com.model.users.authenticateUser(RequestedData.enduser);
								 
								
										if( compareNoCase(RequestedData.enduser,'sgp\stock') eq 0 
											or compareNoCase(RequestedData.enduser,'fbl\stock') eq 0 
											or compareNoCase(RequestedData.enduser,'auh\stock') eq 0)
										{
												 productMapStatus = APPLICATION.com.model.PrdUsrHist.insertprd_hist(userid, 
												productStatus.data,DateFormat(Now(),"dd-mmm-yyyy"),'', SESSION.userdata.us_id)	;
																	
										}
										else
										{			
												stockid = APPLICATION.com.model.users.authenticateUser(RequestedData.campus & '\stock');
												productMapStatus = APPLICATION.com.model.PrdUsrHist.insertprd_hist(stockid, 
												productStatus.data,DateFormat(Now(),"dd-mmm-yyyy"),DateFormat(Now(),"dd-mmm-yyyy"),SESSION.userdata.us_id); 
											 productMapStatus = APPLICATION.com.model.PrdUsrHist.insertprd_hist(userid,productStatus.data,DateFormat(Now(),"dd-mmm-yyyy"),'',
											  SESSION.userdata.us_id);
										}
								
									if (productMapStatus.success)
											{
												return 'Product Registered Succesfully';									
											}
											else
											{
												return 'Product Registration Failed';												
											}							
						}
							else
							{
								return 'Product Registration Failed';					
													
							}
					
					
			}
		else
		{
			vendorid = APPLICATION.com.model.vendors.listvendors(0,RequestedData.vendor_s) ;	
				if(RequestedData.PO_s neq '')
									 {
									 	purchId = APPLICATION.com.model.Purchases.getpurchId(RequestedData.PO_s, 0);
									 }
								 else
								 	{
								 		purchId.data.purchase_id = 0;						 	
								 	}
			
			
			softwareStatus = APPLICATION.com.model.softwares.insertsoftware(#vendorid.data.vendor_id#,RequestedData.name_s
							, RequestedData.duration, RequestedData.durationtypeOptions, RequestedData.noLicenses, RequestedData.startdate, '01-JAN-2012',
							RequestedData.term_notice, RequestedData.noticeReq, RequestedData.softwaretype, RequestedData.itmtype_s, purchId.data.purchase_id,
							RequestedData.po_item_s, RequestedData.old_new, RequestedData.po_old_s,  SESSION.userdata.us_id);
				if(softwareStatus.success)
				{
							return  'Software Registered successfully';
				}
				else
				{
							return  'Software Registration Failed';
								
				}					
		}
	
	
	</cfscript>	
		
	<!--- <cfif ARGUMENTS.Form.product_0 eq 0>
			<cfset vendorid = APPLICATION.com.model.vendors.listvendors(0,ARGUMENTS.Form.vendor_p) />
			<cfset productStatus = APPLICATION.com.model.products.insertproduct(#vendorid.data.vendor_id#, ARGUMENTS.Form.product
						, ARGUMENTS.Form.ownership, ARGUMENTS.Form.serial, ARGUMENTS.Form.budgetid, ARGUMENTS.Form.date_p , 1,SESSION.userdata.username ) />
			<cfset userid = APPLICATION.com.model.users.authenticateUser(ARGUMENTS.Form.enduser) />
						<cfif ARGUMENTS.Form.enduser eq 'sgp\stock' or ARGUMENTS.Form.enduser eq 'fbl\stock' >
								<cfset productMapStatus1 = APPLICATION.com.model.mapAst.insertAP_product(#userid#, 
										productStatus.data,#DateFormat(Now(),"dd-mmm-yyyy")#,'', SESSION.userdata.username,ARGUMENTS.Form.PO) />
							<cfelse>
									<cfset productMapStatus = APPLICATION.com.model.mapAst.insertAP_product(21, 
											productStatus.data,#DateFormat(Now(),"dd-mmm-yyyy")#,#DateFormat(Now(),"dd-mmm-yyyy")#,SESSION.userdata.username,ARGUMENTS.Form.PO) />
									<cfset productMapStatus1 = APPLICATION.com.model.mapAst.insertAP_product(#userid#, 
																productStatus.data,#DateFormat(Now(),"dd-mmm-yyyy")#,'', SESSION.userdata.username, ARGUMENTS.Form.PO) />
						</cfif>
	<cfelse>
		<cfset vendorid = APPLICATION.com.model.vendors.listvendors(0,RequestedData.vendor_s) />
		<cfset softwareStatus = APPLICATION.com.model.softwares.insertsoftware(#vendorid.data.vendor_id#,RequestedData.name_s
							, RequestedData.duration, RequestedData.durationtypeOptions, RequestedData.noLicenses, RequestedData.startdate, '01-JAN-2012',
							RequestedData.term_notice, RequestedData.noticeReq, RequestedData.softwaretype, RequestedData.itmtype_s,  DateFormat(Now(),"dd-mmm-yyyy"),  SESSION.userdata.us_id) />

	</cfif> --->
	
	</cffunction>

	<cffunction name="listTypes" access="remote" output="false" returntype="query" 
				description="Interacts with corresponding Models and lists Purchase types">
	
		<cfreturn APPLICATION.com.model.PurchItmType.listitems().data />
	</cffunction>
	
	<cffunction name="listmodels" access="remote" output="false" returntype="query"
				description="Interacts with corresponding Models and lists out diffrent Models of a particular type of Asset/Purchase">
		<cfargument name="ptypeId" type="numeric" required="true">
		<cfreturn APPLICATION.com.model.models.listmodels(ARGUMENTS.ptypeId).data />
	</cffunction>
	
	<cffunction name="autosuggestvendors" access="remote" output="false" returntype="array" 
				description="Calls the corresponding Model and gives autosuggest functionality for Vendors">
		<cfargument name="search" type="any" required="false" default="">	
		
		<cfreturn APPLICATION.com.model.vendors.autosuggest(ARGUMENTS.search)/>
	</cffunction>

	<cffunction name="autosuggestusers" access="remote" output="false" returntype="array"
				description="Calls the corresponding Model and gives autosuggest functionality for Username(Domain\login format)">
		<cfargument name="search" type="any" required="false" default="">	
		
		<cfreturn APPLICATION.com.model.users.autosuggest(ARGUMENTS.search)/>
	</cffunction>

	<cffunction name="decomAction" access="public" output="false" returntype="string"
				description="Interacts with the corresponding Model and Decommisonates/Enables a particular Product ">
		<cfargument name="product_id" type="numeric" required="true">
		<cfargument name="type" type="numeric" required="true">
		<cfargument name="reason" type="string" required="true">
		
		<cfscript>
			var status = '';
			
			if(ARGUMENTS.type eq 0) {
			 status = APPLICATIOn.com.model.products.updatedecomAction(ARGUMENTS.product_id, 'Y', ARGUMENTS.reason,  SESSION.userdata.us_id);
			 status = APPLICATIOn.com.model.PrdUsrHist.updateEnddateDecom(ARGUMENTS.product_id, 'Y', SESSION.userdata.us_id);
			}
			else if (ARGUMENTS.type eq 1) {
			 status = APPLICATIOn.com.model.products.updatedecomAction(ARGUMENTS.product_id, 'N', '',  SESSION.userdata.us_id);
			 status = APPLICATIOn.com.model.PrdUsrHist.updateEnddateDecom(ARGUMENTS.product_id, 'N', SESSION.userdata.us_id);
			}
			
			if(StructKeyExists(status,'success')) {
				return 'Updated Successfully';
			}
			else {
				return 'Update Failed';
						
			}
		</cfscript>
	
	
	</cffunction>
	
	<cffunction name="expireAction" access="public" output="false" returntype="string"
					description="Interacts with the corresponding Model and Disables/Enables a particular Software">
		<cfargument name="software_id" type="numeric" required="true">
		<cfargument name="type" type="numeric" required="true">
		
		<cfscript>
			var status = '';
			if(ARGUMENTS.type eq 0)
			{
						
			 status = APPLICATIOn.com.model.softwares.updateExpireAction(ARGUMENTS.software_id, 'Y',   SESSION.userdata.us_id);
			}
			else if (ARGUMENTS.type eq 1)
			{
						
			 status = APPLICATIOn.com.model.softwares.updateExpireAction(ARGUMENTS.software_id, 'N',  SESSION.userdata.us_id);
			}
			if(StructKeyExists(status,'success'))
			{
						return 'Updated Successfully';
			}
			else
			{
						return 'Update Failed';
						
			}
		</cfscript>
	
	
	</cffunction>

	<cffunction name="decom" access="public" output="false" returntype="string"
		description="Displays  a confirmation for Disabling/Enabling the Product with reason">

		<cfargument name="productId" type="numeric" required="true"  >
		<cfargument name="type" type="numeric" required="true"  >
		
		<cfset var retDisplay = '' />
		
		<cfsavecontent variable="retDisplay">
		<cfoutput>
			<cfform name="decomForm" action="decomAsset.cfm" method="post" >
				<table width="450px">
					<tr>
						<td width="100%">
							<fieldset class="paddingdecom">
							<legend>
								&nbsp;Confirmation &nbsp; 
							</legend>
							<ul class="decomUL">
								<input name="productid" type="hidden" value="#ARGUMENTS.productId#" >
								<input name="type" type="hidden" value="#ARGUMENTS.type#" >
							<cfif ARGUMENTS.type eq 0>
								<li class="bolddecom" style="width:60px;">
									Reason : 
								</li>
								<li class="celldecomStyle" style="width:120px;">
									<textarea name="reason" cols="44" rows="4"></textarea>
								</li>
								<li class="celldecomStyle" style="color:red;width:300px" >
									<input name="Decom" type="submit" value="Submit" >
								</li>
							<cfelseif ARGUMENTS.type eq 1>
								<li class="celldecomStyle" style="color:red;width:300px" >
									<input name="Decom" type="submit" value="Enable" >
								</li>
							</cfif>
							</ul>
							</fieldset>
							<br />
							<cfif ARGUMENTS.type eq 0>
								<span class="celldecomStyle" style="color:red;width:450px;word-wrap:break-word;">
									** If you do not want to decommision this Asset, please Close this Window
								</span>
							</cfif>
						</td>
					</tr>
				</table> 
			</cfform>
		</cfoutput>
		</cfsavecontent>
		<cfreturn retDisplay />
		</cffunction>
	
	<cffunction name="expire" access="public" output="false" returntype="string"
				description="Displays a confirmation for Disabling/Enabling the Software">

		<cfargument name="softwareId" type="numeric" required="true"  >
		<cfargument name="type" type="numeric" required="true"  >
		
		<cfset var retDisplay = '' />
		<cfsavecontent variable="retDisplay">
			<cfoutput>
				<cfform name="decomForm" action="expSoftware.cfm" method="post" >
					<table width="450px">
						<tr>
							<td width="100%">
								<fieldset class="paddingdecom">
									<legend> &nbsp;Confirmation &nbsp;</legend>
								<ul class="decomUL">
									<input name="softwareid" type="hidden" value="#ARGUMENTS.softwareId#" >
									<input name="type" type="hidden" value="#ARGUMENTS.type#" >
									<li class="celldecomStyle" style="color:red;width:300px" > 
										<cfif ARGUMENTS.type eq 0>
											<input name="exp" type="submit" value="Disable" >
										<cfelseif ARGUMENTS.type eq 1>
											<input name="exp" type="submit" value="Enable" >
										</cfif>
									</li>
								</ul>
								</fieldset>
								<br />
							</td>
						</tr>
					</table> 
				</cfform>
			</cfoutput>
		</cfsavecontent>
		<cfreturn retDisplay />
		</cffunction>

	<cffunction name="assetHistory" access="public" output="false" returntype="struct"
				description="Fetches Asset History by interacting with corresponding Models">
		<cfargument name="productid" type="numeric" required="true">
		
			<cfset var retHistory = structNew() />
			<cfset retHistory.astHistry = APPLICATION.com.model.products.AstHistory(ARGUMENTS.productid) />

			<cfif retHistory.astHistry.data.purchaseid neq ''>
				<cfset retHistory.purchaseId = APPLICATION.com.model.Purchases.getpurchId('', retHistory.astHistry.data.purchaseid).data.ins_purchaseid />
			<cfelse>
				<cfset retHistory.purchaseId = '' />
			</cfif>
			
		<cfreturn retHistory />
	</cffunction>

	<cffunction name="POAutoSuggest" access="remote" returntype="array"
				description="Calls the corresponding Model and gives autosuggest functionality for Purchase Order Number">
		<cfargument name="search" type="any" required="false" default="">
	<cfreturn APPLICATION.com.model.Purchases.autosuggest(ARGUMENTS.search) />
	</cffunction>

	<cffunction name="SoftwareRegForWindow" access="public"  returntype="string" output="false"
				description="Registers Software (For Registration through cfwindow from Purcahse Management when the data is less than 2)">
		<cfargument name="Reqdata" type="struct" required="true">
		<cfset var Data = ARGUMENTS.Reqdata />
		<cfset var softwareStatus = {} />
		<cfscript>
		softwareStatus = APPLICATION.com.model.softwares.insertsoftware(Data.vendorid,Data.name_s
							, Data.duration, Data.durationtypeOptions, Data.noLicenses, Data.startdate, '01-JAN-2012',
							Data.term_notice, Data.noticeReq, Data.softwaretype, Data.itmtype_s, Data.purchaseid,
							Data.purchaseitmid, Data.old_new, Data.po_old_s,  SESSION.userdata.us_id);
				if(softwareStatus.success)
				{
							return  'Software Registered successfully';
				}
				else
				{
							return  'Software Registration Failed';
								
				}	
		
	</cfscript>
		
	</cffunction>
	
	<cffunction name="ProductRegForWindow" access="public"  returntype="string" output="false"
				description="Registers Product (For Registration through cfwindow from Purcahse Management when the data is less than 2)">
		<cfargument name="Reqdata" type="struct" required="true">
		<cfset var Data = ARGUMENTS.Reqdata />
		<cfset var count = Data.quantity />
		<cfset var productStatus = {} />
		<cfset var userid = 0 />
		<cfset var stockid = 0 />
		<cfset var ret = '' />
		<cfset var productMapStatus = {} />
		<cfscript>
			for(i=1;i lte count ; i=i+1)
			{
		productStatus = APPLICATION.com.model.products.insertproduct(vendorid, Data['product#i#']
						, Data.ownership, Data['serial#i#'], Data.budgetid, Data.date_p , Data.purchasetype,
						Data.itmtype, Data.old_new, Data.purchaseid, Data.purchaseitmid , '', Data['campus#i#'], SESSION.userdata.us_id );
						if(productStatus.success)
						{
							 userid = APPLICATION.com.model.users.authenticateUser(Data['enduser#i#']);
								 
								
										if(Data['enduser#i#'] eq 'sgp\stock' or Data['enduser#i#'] eq 'fbl\stock' or Data['enduser#i#'] eq 'auh\stock')
										{
												 productMapStatus = APPLICATION.com.model.PrdUsrHist.insertprd_hist(userid, 
												productStatus.data,DateFormat(Now(),"dd-mmm-yyyy"),'', SESSION.userdata.us_id)	;
																	
										}
										else
										{			
												stockid = APPLICATION.com.model.users.authenticateUser(Data['campus#i#'] & '\stock');
												productMapStatus = APPLICATION.com.model.PrdUsrHist.insertprd_hist(stockid, 
												productStatus.data,DateFormat(Now(),"dd-mmm-yyyy"),DateFormat(Now(),"dd-mmm-yyyy"),SESSION.userdata.us_id); 
											 productMapStatus = APPLICATION.com.model.PrdUsrHist.insertprd_hist(userid,productStatus.data,DateFormat(Now(),"dd-mmm-yyyy"),'',
											  SESSION.userdata.us_id);
										}
								
									if (productMapStatus.success)
											{
												ret = 'Product Registered Succesfully';									
											}
											else
											{
												ret =  'Product Registration Failed';
												//break;												
											}							
						}
							else
							{
								ret =  'Product Registration Failed';					
								//break;					
							}
			}
		</cfscript>
		
		<cfreturn ret />
	</cffunction>

    <!--- Functions from Nanda Kishore  --->
	
	<cffunction name="MassUpload" access="remote" returntype="struct">
    	<cfargument name="filename" type="string" required="yes">
        	<cfset data = APPLICATION.com.util.$readCSV(ARGUMENTS.filename) />
            <cfloop index="i" from="1" to="#ArrayLen(data)#">
            	<cfset status = NagasFunction(data[i]) />
            </cfloop>
    </cffunction>

	<cffunction name="purchaseItemsBlkUpload" access="public" returntype="string">
    	<cfargument name="filename" type="string" required="yes">
        <cfargument name="purchaseItemID" type="string" required="yes">
			<cfscript>
            	var data = APPLICATION.com.util.$readCSV(ARGUMENTS.filename);
            	var structData = {product_0 = 0,
								  vendor_p = "",
								  product = "", 
								  serial = "",
								  ownership = "",
								  budgetid = "",
								  date_p = "",
								  assetType = "",
								  itmtype = "",
								  old_new = "",
								  po_old = "",
								  campus = "",
								  enduser= "" ,
								  purchase_id = "",
								  po_item = ""
								 };
            	var i = 1;
				var retLst = '';
				
            	for(;i LTE ArrayLen(data); i=i+1){
					if(Trim(data[i][1]) NEQ "") {
					
						structData.vendor_p		= data[i][9];
						structData.product 		= data[i][6];
						structData.serial 		= data[i][5];
						structData.ownership 	= data[i][7];
						structData.budgetid 	= data[i][8];
						structData.date_p 		= data[i][2];
						structData.assetType 	= APPLICATION.com.model.PurchItmType.listitemsforId(data[i][3]).data.id;
						structData.itmtype 		= APPLICATION.com.model.models.listmodelsforId(data[i][4], structData.assetType).data.id;
						structData.old_new 		= data[i][1];
						
						
						if(compareNoCase(data[i][1],'NEW') eq 0){
							structData.purchase_id = data[i][10];
							structData.po_item = ARGUMENTS.purchaseItemID;
							structData.po_old = "";						
						}else{
							structData.purchase_id = -1;
							structData.po_item = -1;
							structData.po_old = data[i][10];
						}
						structData.campus = data[i][11];
						structData.enduser = data[i][12];
					
	
						/*do the registration*/
						ListAppend(retLst, i & ':' & registration(DUPLICATE(structData)), ",");
					}	
				}
            </cfscript>            
    </cffunction>
</cfcomponent>