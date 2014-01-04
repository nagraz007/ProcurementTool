<cfcomponent displayname="adminman" output="false">

	<cffunction name="init" access="public" returntype="adminman" description="Generates an object of itself">
		<cfreturn THIS />
	</cffunction>
	
	<cffunction name="listAccessRoles" access="remote" output="false" returntype="query"
		description="Lists Permissions for either Assets or Purchasing by calling respective Models">
		<cfargument name="purchOrAst" required="true" type="numeric">
			<cfset var resQry = '' />
			<cfif ARGUMENTS.purchOrAst eq 0>
				<cfset resQry = APPLICATION.com.model.AstPerm.listpermissions() />
			<cfelse>
	
				<cfset resQry = APPLICATION.com.model.PurchPerm.listpermissions() />
				</cfif>
			
		<cfreturn resQry.data />
	</cffunction>

<!--- 	<cffunction name="addAccessRole" access="public" output="false" returntype="struct">
		<cfargument name="reqdata" required="true" type="struct">
			
			<cfset var accesslevel = 0 />
			<cfset var res = '' />
			
			<cfif ARGUMENTS.reqdata.assets2 eq 0>
					<cfscript>
						if(	structKeyExists(ARGUMENTS.reqdata,"view"))
							accesslevel = accesslevel + 1;
						if(	structKeyExists(ARGUMENTS.reqdata,"add"))
							accesslevel = accesslevel + 2;
						if(	structKeyExists(ARGUMENTS.reqdata,"edit"))
							accesslevel = accesslevel + 4;
							
							res = APPLICATION.com.model.AstPerm.insertpermission(ARGUMENTS.reqdata.name, accesslevel, SESSION.userdata.us_id);
							return res ;
					</cfscript>
				<cfelse>
						<cfscript>
						if(	structKeyExists(ARGUMENTS.reqdata,"approvereq"))
							accesslevel = accesslevel + 1;
						if(	structKeyExists(ARGUMENTS.reqdata,"purchActions"))
							accesslevel = accesslevel + 2;
						if(	structKeyExists(ARGUMENTS.reqdata,"budgetApproval"))
							accesslevel = accesslevel + 4;
							
							res = APPLICATION.com.model.PurchPerm.insertpermission(ARGUMENTS.reqdata.name, accesslevel, SESSION.userdata.us_id);
							return res ;
						</cfscript>
									
			</cfif>
			
			
		</cffunction> --->

	<cffunction name="assignAccess" access="public" output="false" returntype="struct"
		description="Assigns Access to a user from maximum of existing and assigning Role by calling corresponding Model.">
		<cfargument name="reqdata" required="true" type="struct">
		
					<cfscript>
						var res = '';
						var userid = '';
						userid = APPLICATION.com.model.users.authenticateUser(ARGUMENTS.reqdata.user);
						res = APPLICATION.com.model.users.assignAccess(ARGUMENTS.reqdata.assets, ARGUMENTS.reqdata.roleId, userid, SESSION.userdata.us_id);
							return res ;
					</cfscript>
		
	</cffunction>
	
	<cffunction name="SeeAllPermissionsForGrid" access="remote" output="false"
				description="Calls the corresponding model and gets data to be populated for tye grid diaplying all Permissions" >
		<cfargument name="page" required="true" />
		<cfargument name="pageSize" type="numeric" required="true" />
		<cfargument name="gridsortcolumn" type="string" required="true" />
		<cfargument name="gridstartdirection" type="string" required="true" />
		
		<cfscript>
			var getData = {};
			getData = APPLICATION.com.model.users.listPermissions(ARGUMENTS.gridsortcolumn,ARGUMENTS.gridstartdirection);
			return QueryConvertForGrid(getdata.data, page, pageSize); /* Error Handling*/
		</cfscript>	
	
	</cffunction>
	
	<cffunction name="EditPermissionsForGrid" access="remote" output="false"
			description="Calls corresponding model and gives Edit functionality to teh grid through which All Permissions can be seen">
        <cfargument name="gridaction" type="string" required="yes">
        <cfargument name="gridrow" type="struct" required="yes">
        <cfargument name="gridchanged" type="struct" required="yes">
		
		<cfscript>
		var colname = '';
        var value = '';
        var EsData = '';
        var GetId = '';
        var i = 1; 
			switch(ARGUMENTS.gridaction)
			{
					case 'U' :
						colname = StructKeyList(ARGUMENTS.gridchanged) ;	
						value = ARGUMENTS.gridchanged[colname];
					switch(colname)
						{
								case 'assetrole'    : 	GetId = APPLICATION.com.model.AstPerm.listpermissions(0,value);
													EsData = APPLICATION.com.model.users.assignAccess(0,GetId.data.id, ARGUMENTS.gridrow.us_id, SESSION.userdata.us_id);
													break;		
								case 'purchaserole' :   GetId = APPLICATION.com.model.PurchPerm.listpermissions(0,value);
													EsData = APPLICATION.com.model.users.assignAccess(1,GetId.data.id, ARGUMENTS.gridrow.us_id, SESSION.userdata.us_id);
													break;			
											
						}
			
						break;
					
			}
			
		</cfscript>
	</cffunction>
	
	<cffunction name="listofAstRoles" access="public" output="false" returntype="struct"
				description="Calls corresponding Model and Lists All Roles of Asset Management" >
		
		<cfscript>
			var res = '';
			res = APPLICATION.com.model.AstPerm.listpermissions(0, '');
			return res;
		
		</cfscript>
	
	</cffunction>
	
	<cffunction name="listofPurchRoles" access="public" output="false" returntype="struct"
				description="Calls corresponding Model and Lists All Roles of Purchase Management" >
		
		<cfscript>
			var res = '';
			res = APPLICATION.com.model.PurchPerm.listpermissions(0, '');
			return res;
		
		</cfscript>
	
	</cffunction>

	<cffunction name="POAutoSuggest" access="remote" returntype="array"
				description="Calls the corresponding Model and gives autosuggest functionality for Purchase Order Number">
		<cfargument name="search" type="any" required="false" default="">
	<cfreturn APPLICATION.com.model.Purchases.autosuggest(ARGUMENTS.search) />
	</cffunction>
	
	<cffunction name="feedback" access="public" returntype="string" output="false"
				description="Accesses corrsponding Model and fills the Feedback provided by user">
		<cfargument name="Reqdata" type="struct" required="false">
		<cfset var result= {} />
		<cfset var data= ARGUMENTS.Reqdata />
		<cfset var purchid= {} />
		
		<cfset purchid = APPLICATION.com.model.purchases.getpurchId(data.PO, 0) />		
		<cfset result = APPLICATION.com.model.feedback.insertfeedback(purchid.data.purchase_id, data.req_cls, data.req_ful, data.req_sat, data.reason, SESSION.userdata.us_id) />		
		
		<cfif result.success>
			<cfreturn 'FeedBack Entered Successfully' />
		<cfelse>
			<cfreturn 'FeedBack Entry Failed' />
		</cfif>
	</cffunction>
	
	<cffunction name="expire_vendor" access="public" output="false" returntype="string"
				description="Displays in the cfwindow a confirmation for Disabling/Enabling the Vendor">

		<cfargument name="vendorId" type="numeric" required="true"  >
		<cfargument name="type" type="numeric" required="true"  >
		
		<cfset var retDisplay = '' />
		<cfsavecontent variable="retDisplay">
			<cfoutput>
				<cfform name="decomForm" action="expVendor.cfm" method="post" >
					<table width="450px">
						<tr>
							<td width="100%">
								<fieldset class="paddingdecom">
									<legend> &nbsp;Confirmation &nbsp;</legend>
								<ul class="decomUL">
									<input name="vendorId" type="hidden" value="#ARGUMENTS.vendorId#" >
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

	<cffunction name="expireAction_vendor" access="public" output="false" returntype="string"
				description="Interacts with the corresponding Model and Enables/Disables Vendor">
		<cfargument name="vendor_id" type="numeric" required="true">
		<cfargument name="type" type="numeric" required="true">
		
		<cfscript>
			var status = '';
			if(ARGUMENTS.type eq 0)
			{
						
			 status = APPLICATION.com.model.vendors.updateExpireAction(ARGUMENTS.vendor_id, 0,   SESSION.userdata.us_id);
			}
			else if (ARGUMENTS.type eq 1)
			{
						
			 status = APPLICATION.com.model.vendors.updateExpireAction(ARGUMENTS.vendor_id, 1,  SESSION.userdata.us_id);
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

	<cffunction name="expire_user" access="public" output="false" returntype="string"
				description="Displays in the cfwindow a confirmation for Disabling/Enabling the User">

		<cfargument name="userId" type="numeric" required="true"  >
		<cfargument name="type" type="numeric" required="true"  >
		
		<cfset var retDisplay = '' />
		<cfsavecontent variable="retDisplay">
			<cfoutput>
				<cfform name="decomForm" action="expUser.cfm" method="post" >
					<table width="450px">
						<tr>
							<td width="100%">
								<fieldset class="paddingdecom">
									<legend> &nbsp;Confirmation &nbsp;</legend>
								<ul class="decomUL">
									<input name="userId" type="hidden" value="#ARGUMENTS.userId#" >
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

	<cffunction name="expireAction_user" access="public" output="false" returntype="string"
					description="Interacts with the corresponding Model and Enables/Disables User">
		<cfargument name="us_id" type="numeric" required="true">
		<cfargument name="type" type="numeric" required="true">
		
		<cfscript>
			var status = '';
			if(ARGUMENTS.type eq 0)
			{
						
			 status = APPLICATION.com.model.users.updateExpireAction(ARGUMENTS.us_id, 0,   SESSION.userdata.us_id);
			}
			else if (ARGUMENTS.type eq 1)
			{
						
			 status = APPLICATION.com.model.users.updateExpireAction(ARGUMENTS.us_id, 1,  SESSION.userdata.us_id);
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

	<cffunction name="FeedbackResults" access="remote" output="false"
				description="Interacts with the corresponding Model and Fetches all respones from all Users">
		<cfargument name="page" required="true" />
		<cfargument name="pageSize" type="numeric" required="true" />
		<cfargument name="gridsortcolumn" type="string" required="true" />
		<cfargument name="gridstartdirection" type="string" required="true" />		
			
		<cfscript>
			var getdata = {};

	 		getdata = APPLICATION.com.model.feedback.listResponses(ARGUMENTS.gridsortcolumn, ARGUMENTS.gridstartdirection);
	 		 		return QueryConvertForGrid(getdata.data, page, pageSize); /* Error Handling*/
		</cfscript>
	</cffunction>

	<cffunction name="autosuggestusers" access="remote" output="false" returntype="array"
				description="Calls the corresponding Model and gives autosuggest functionality for Username(Domain\login format)">
		<cfargument name="search" type="any" required="false" default="">	
		
		<cfreturn APPLICATION.com.model.users.autosuggest(ARGUMENTS.search)/>
	</cffunction>

    <cffunction name="chkVendName" access="remote" returnformat="json" output="false">
        <cfargument name="VendName" required="true">
       		<cfsetting showdebugoutput="false">
		 <cfreturn yesNoFormat(APPLICATION.com.model.vendors.chkVendName(ARGUMENTS.VendName)) />
    </cffunction>

	<!---  Functions  From Nanda Kishore Kulkarni--->
	
	<cffunction name="vendorRegistration" access="public" returntype="void" output="false">
    	<cfargument name="Form" type="struct" required="true"/>	
                		<cfset VendorRegistrationStatus = APPLICATION.com.model.vendors.insertvendor(ARGUMENTS.Form.VendorName, ARGUMENTS.Form.VendorDetails, ARGUMENTS.Form.VendorAddress, 
					ARGUMENTS.Form.glocation, ARGUMENTS.Form.VendorEmail, ARGUMENTS.Form.phone1, ARGUMENTS.Form.phone2, ARGUMENTS.Form.fax,  #DateFormat(Now(),"dd-mmm-yyyy")#,  SESSION.userdata.us_id )>               
    </cffunction>
    
    <cffunction name="resultForGrid_Vendors" access="remote" output="false">
		<cfargument name="page" required="true" />
		<cfargument name="pageSize" type="numeric" required="true" />
		<cfargument name="gridsortcolumn" type="string" required="true" />
		<cfargument name="gridstartdirection" type="string" required="true" />		
			
		<cfscript>
			var getdata = {};
			var EsData = {}; /*Essential data : data that is manipulated locally before sending to the View*/
			var productId = '';
			var vendornames = {};
			var Usid = 0;
			var i=1;
			
			var util = APPLICATION.com.util;

	 		getdata = APPLICATION.com.model.vendors.listvendorsForGrid(ARGUMENTS.gridsortcolumn, ARGUMENTS.gridstartdirection);
	 		 		return QueryConvertForGrid(getdata.data, page, pageSize); /* Error Handling*/
		</cfscript>
	</cffunction>
    
    <cffunction name="editForGrid_Vendors" access="remote" output="false">
        <cfargument name="gridaction" type="string" required="yes">
        <cfargument name="gridrow" type="struct" required="yes">
        <cfargument name="gridchanged" type="struct" required="yes">
		
		<cfscript>
		var colname = '';
        var value = '';
        var Esdata = {}; /* Essential data : data that is manipulated locally */
		
			switch(ARGUMENTS.gridaction)
			{
					case 'U' :
						colname = StructKeyList(ARGUMENTS.gridchanged) ;	
						value = ARGUMENTS.gridchanged[colname];
						switch(colname)
						{
							case 'vendor_name' 	: Esdata = APPLICATION.com.model.Vendors.updatevendors(ARGUMENTS.gridrow.vendor_id,
												 value,'','','','','','','',SESSION.userdata.us_id, #DateFormat(Now(),"dd-mmm-yyyy")#);
												break;
							case 'detail'		: Esdata = APPLICATION.com.model.Vendors.updatevendors(ARGUMENTS.gridrow.vendor_id,
												'',value,'','','','','','',SESSION.userdata.us_id, #DateFormat(Now(),"dd-mmm-yyyy")#);
												break;
							case 'address'		: Esdata = APPLICATION.com.model.Vendors.updatevendors(ARGUMENTS.gridrow.vendor_id,
												'','',value,'','','','','',SESSION.userdata.us_id, #DateFormat(Now(),"dd-mmm-yyyy")#);
												break;
						 	case 'glocation'    : Esdata = APPLICATION.com.model.Vendors.updatevendors(ARGUMENTS.gridrow.vendor_id,
												'','','',value,'','','','',SESSION.userdata.us_id, #DateFormat(Now(),"dd-mmm-yyyy")#);
												break;
							case 'email'  	    : Esdata = APPLICATION.com.model.Vendors.updatevendors(ARGUMENTS.gridrow.vendor_id,
												'','','','',value,'','','',SESSION.userdata.us_id, #DateFormat(Now(),"dd-mmm-yyyy")#);
												break;
							case 'phone1'  	    : Esdata = APPLICATION.com.model.Vendors.updatevendors(ARGUMENTS.gridrow.vendor_id,
												'','','','','',value,'','',SESSION.userdata.us_id, #DateFormat(Now(),"dd-mmm-yyyy")#);
												break;
							case 'phone2'  	    : Esdata = APPLICATION.com.model.Vendors.updatevendors(ARGUMENTS.gridrow.vendor_id,
												'','','','','','',value,'',SESSION.userdata.us_id, #DateFormat(Now(),"dd-mmm-yyyy")#);
												break;												
							case 'fax'  	    : Esdata = APPLICATION.com.model.Vendors.updatevendors(ARGUMENTS.gridrow.vendor_id,
												'','','','','','','',value,SESSION.userdata.us_id, #DateFormat(Now(),"dd-mmm-yyyy")#);
												break;												
						}
							break;
					
					case 'D' :
							Esdata = APPLICATION.com.model.Vendors.deletevendor(ARGUMENTS.gridrow.vendor_id);
								break;
			}
			
		</cfscript>
	</cffunction>
    
    <cffunction name="ListDepartments" access="public" returntype="struct" output="false">
		<cfreturn APPLICATION.com.model.Dept.listDepartmentsForListing() />
    </cffunction>
    
    <cffunction name="ListUsers" access="public" returntype="struct" output="false">
    	<cfargument name="userId" required="false" type="numeric" default="0" />
		<cfreturn APPLICATION.com.model.Users.listusers(ARGUMENTS.userId) />
    </cffunction>
    
     <cffunction name="ListVendors" access="public" returntype="struct" output="false">
		<cfreturn APPLICATION.com.model.Vendors.listvendors(0,'') />
    </cffunction>
    
	<cffunction name="ListBudgetApprovers" access="public" returntype="query" output="false"> <!--- Modified by NagaRaju BHANOORI --->
		<cfreturn APPLICATION.com.model.budgetroles.showbudgetmgrs().data />
    </cffunction>
	
	
    <cffunction name="chkUsername" access="remote" returnformat="json" output="false">
        <cfargument name="Username" required="true">
			<cfsetting showdebugoutput="false">
        <cfreturn yesNoFormat(APPLICATION.com.model.Users.checkUsername(ARGUMENTS.Username)) />
    </cffunction>
    
    <cffunction name="chkDeptName" access="remote" returnformat="json" output="false">
        <cfargument name="DeptName" required="true">
       		<cfsetting showdebugoutput="false">
		 <cfreturn yesNoFormat(APPLICATION.com.model.Dept.CheckDeptName(ARGUMENTS.DeptName)) />
    </cffunction>
    
    <cffunction name="userRegistration" access="public" returntype="void" output="false">   <!--- Modified by Naga Raju --->
    	<cfargument name="Form" type="struct" required="true"/>	
			<cfset var access = 0 />
			<cfset var iactive = 0 />
				<cfif structkeyexists(ARGUMENTS.Form,"gaccess")>
					<cfset access = 1 />
				</cfif>
				<cfif structkeyexists(ARGUMENTS.Form,"isactive")>
					<cfset iactive = 1 />
				</cfif>
                		<cfset UserRegistrationStatus = APPLICATION.com.model.Users.insertUser(ARGUMENTS.Form.username, ARGUMENTS.Form.department, ARGUMENTS.Form.firstname, 
					ARGUMENTS.Form.Middlename, ARGUMENTS.Form.lastname, ARGUMENTS.Form.Campus, ARGUMENTS.Form.userEmail, ARGUMENTS.Form.extension, ARGUMENTS.Form.mobile,
					ARGUMENTS.Form.fax, ARGUMENTS.Form.assetRole, ARGUMENTS.Form.purchaseRole, iactive, access ,  SESSION.userdata.us_id )>               
    </cffunction>
    
    <cffunction name="AddDepartment" access="public" returntype="void" output="false">
    	<cfargument name="Form" type="struct" required="true"/>	
                		<cfset UserRegistrationStatus = APPLICATION.com.model.Dept.insertdepartment(ARGUMENTS.Form.DeptName, #DateFormat(Now(),"dd-mmm-yyyy")#,  SESSION.userdata.us_id )>               
    </cffunction>
    
    <cffunction name="resultForGridforSearch" access="remote" output="false">
        <cfargument name="page" required="true" />
        <cfargument name="pageSize" type="numeric" required="true" />
        <cfargument name="gridsortcolumn" type="string" required="true" />
        <cfargument name="gridstartdirection" type="string" required="true" />
        <cfargument name="searchKey" type="string" required="true"/>
        <cfargument name="Campus" type="string" required="false"/>	
        <cfargument name="department" type="string" required="false"/>
        <cfscript>
			var getdata = {};
			
	 		getdata = APPLICATION.com.model.Users.searchUsers(ARGUMENTS.gridsortcolumn, ARGUMENTS.gridstartdirection, ARGUMENTS.searchKey, ARGUMENTS.Campus, ARGUMENTS.department);
	 		 		return QueryConvertForGrid(getdata.data, page, pageSize); 
		</cfscript>
	</cffunction>
    
    <cffunction name="ListDepartmentsforGrid" access="remote" output="false">
        <cfargument name="page" required="true" />
        <cfargument name="pageSize" type="numeric" required="true" />
        <cfargument name="gridsortcolumn" type="string" required="true" />
        <cfargument name="gridstartdirection" type="string" required="true" />
        <cfscript>
			var getdata = {};
			
	 		getdata = APPLICATION.com.model.Dept.listdepartments(ARGUMENTS.gridsortcolumn, ARGUMENTS.gridstartdirection,0);
	 		 		return QueryConvertForGrid(getdata.data, page, pageSize); 
		</cfscript>
	</cffunction>

	<cffunction name="editForGrid_User" access="remote" output="false">
        <cfargument name="gridaction" type="string" required="yes">
        <cfargument name="gridrow" type="struct" required="yes">
        <cfargument name="gridchanged" type="struct" required="yes">
		
		<cfscript>
		var colname = '';
        var value = '';
        var Esdata = {}; /* Essential data : data that is manipulated locally */
        var Esdata1 = {}; /* Essential data : data that is manipulated locally */
        var deptid = {}; 
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
							case 'firstname' 	: Esdata = APPLICATION.com.model.users.updateuser(ARGUMENTS.gridrow.us_id,
												value,'','','','','','','',0,SESSION.userdata.us_id, #DateFormat(Now(),"dd-mmm-yyyy")#);
												break;
							case 'middlename'	: Esdata = APPLICATION.com.model.users.updateuser(ARGUMENTS.gridrow.us_id,
												'',value,'','','','','','',0,SESSION.userdata.us_id, #DateFormat(Now(),"dd-mmm-yyyy")#);
												break;
							case 'lastname'		: Esdata = APPLICATION.com.model.users.updateuser(ARGUMENTS.gridrow.us_id,
												'','',value,'','','','','',0,SESSION.userdata.us_id, #DateFormat(Now(),"dd-mmm-yyyy")#);
												break;
						 	case 'campus'      : Esdata = APPLICATION.com.model.users.updateuser(ARGUMENTS.gridrow.us_id,
												'','','',value,'','','','',0,SESSION.userdata.us_id, #DateFormat(Now(),"dd-mmm-yyyy")#);
												break;
							case 'email'       : Esdata = APPLICATION.com.model.users.updateuser(ARGUMENTS.gridrow.us_id,
												'','','','',value,'','','',0,SESSION.userdata.us_id, #DateFormat(Now(),"dd-mmm-yyyy")#);
												break;
							case 'workphone'   : Esdata = APPLICATION.com.model.users.updateuser(ARGUMENTS.gridrow.us_id,
												'','','','','',value,'','',0,SESSION.userdata.us_id, #DateFormat(Now(),"dd-mmm-yyyy")#);
												break;
							case 'mobilephone' : Esdata = APPLICATION.com.model.users.updateuser(ARGUMENTS.gridrow.us_id,
												'','','','','','',value,'',0,SESSION.userdata.us_id, #DateFormat(Now(),"dd-mmm-yyyy")#);
												break;
							case 'fax' 		   : Esdata = APPLICATION.com.model.users.updateuser(ARGUMENTS.gridrow.us_id,
												'','','','','','','',value,0,SESSION.userdata.us_id, #DateFormat(Now(),"dd-mmm-yyyy")#);
												break;
							case 'name'   	   :deptid = APPLICATION.com.model.Dept.getDeptID(value);
												Esdata = APPLICATION.com.model.users.updateuser(ARGUMENTS.gridrow.us_id,
												'','','','','','','','',deptid,SESSION.userdata.us_id, #DateFormat(Now(),"dd-mmm-yyyy")#);
												break;												
						}
							break;
					
					case 'D' :
							Esdata = APPLICATION.com.model.Users.removeuser(ARGUMENTS.gridrow.us_id);
								break;
			}
			
		</cfscript>
	</cffunction>	

	<cffunction name="typesAdd" access="public" returntype="void" output="false">
    	<cfargument name="Form" type="struct" required="true"/>	
			<cfset typesAddStatus = APPLICATION.com.model.PurchItmType.inserttype(ARGUMENTS.Form.typename,  
            #DateFormat(Now(),"dd-mmm-yyyy")#,  SESSION.userdata.us_id )>               
    </cffunction>
    
    <cffunction name="addModel" access="public" returntype="void" output="false">
    	<cfargument name="Form" type="struct" required="true"/>	
			<cfset typesAddStatus = APPLICATION.com.model.models.insertModel(ARGUMENTS.Form.modelname, ARGUMENTS.Form.itemType, 
            #DateFormat(Now(),"dd-mmm-yyyy")#,  SESSION.userdata.us_id )>               
    </cffunction>
	
	<cffunction name="viewPurchItemTypesForGrid" access="remote" output="false">
        <cfargument name="page" required="true" />
        <cfargument name="pageSize" type="numeric" required="true" />
        <cfargument name="gridsortcolumn" type="string" required="true" />
        <cfargument name="gridstartdirection" type="string" required="true" />
        <cfscript>
			var getdata = {};
	 		getdata = APPLICATION.com.model.PurchItmType.ListPurchtypes(ARGUMENTS.gridsortcolumn, ARGUMENTS.gridstartdirection);
	 		 		return QueryConvertForGrid(getdata.data, page, pageSize); 
		</cfscript>
	</cffunction>
    
    <cffunction name="viewModelsForGrid" access="remote" output="false">
        <cfargument name="page" required="true" />
        <cfargument name="pageSize" type="numeric" required="true" />
        <cfargument name="gridsortcolumn" type="string" required="true" />
        <cfargument name="gridstartdirection" type="string" required="true" />
        <cfscript>
			var getdata = {};
	 		getdata = APPLICATION.com.model.models.ListModelsForGrid(ARGUMENTS.gridsortcolumn, ARGUMENTS.gridstartdirection);
	 		 		return QueryConvertForGrid(getdata.data, page, pageSize); 
		</cfscript>
	</cffunction>

    <cffunction name="chkPurchaseType" access="remote" returnformat="json" output="false">
        <cfargument name="typename" required="true">
       		<cfsetting showdebugoutput="false">
		 <cfreturn yesNoFormat(APPLICATION.com.model.PurchItmType.CheckPurchType(ARGUMENTS.typename)) />
    </cffunction>
    
    <cffunction name="chkItemModelName" access="remote" returnformat="json" output="false">
        <cfargument name="modelname" required="true">
       		<cfsetting showdebugoutput="false">
		 <cfreturn yesNoFormat(APPLICATION.com.model.models.CheckModelName(ARGUMENTS.modelname)) />
    </cffunction>

 	<cffunction name="ListPurchaseItemTypes" access="public" returntype="struct" output="false">
		<cfreturn APPLICATION.com.model.PurchItmType.listitems(0) />
    </cffunction>
	
	<cffunction name="editForGrid_Department" access="remote" output="false">
        <cfargument name="gridaction" type="string" required="yes">
        <cfargument name="gridrow" type="struct" required="yes">
        <cfargument name="gridchanged" type="struct" required="yes">
		
		<cfscript>
		var colname = '';
        var value = '';
        var Esdata = {}; /* Essential data : data that is manipulated locally */
			switch(ARGUMENTS.gridaction)
			{
					case 'U' :  
								colname = StructKeyList(ARGUMENTS.gridchanged) ;	
								value = ARGUMENTS.gridchanged[colname];
								switch(colname)
								{
								case 'name'    : 	
														Esdata = APPLICATION.com.model.Dept.updatedepartment(ARGUMENTS.gridrow.depart_id,
														value,SESSION.userdata.us_id, #DateFormat(Now(),"dd-mmm-yyyy")#);
														break;	
								}
					case 'D' :
								
								break;
			}
			
		</cfscript>
	</cffunction>
    
    <cffunction name="editForGridPurchaseTypes" access="remote" output="false">
        <cfargument name="gridaction" type="string" required="yes">
        <cfargument name="gridrow" type="struct" required="yes">
        <cfargument name="gridchanged" type="struct" required="yes">
		
		<cfscript>
		var colname = '';
        var value = '';
        var Esdata = {}; /* Essential data : data that is manipulated locally */
			switch(ARGUMENTS.gridaction)
			{
					case 'U' :  
								colname = StructKeyList(ARGUMENTS.gridchanged) ;	
								value = ARGUMENTS.gridchanged[colname];
								switch(colname)
								{
								case 'NAME'    : 	
														Esdata = APPLICATION.com.model.PurchItmType.updatePurchaseType(ARGUMENTS.gridrow.PURCHASETYPE_ID,
														value,SESSION.userdata.us_id, #DateFormat(Now(),"dd-mmm-yyyy")#);
														break;	
								}
					case 'D' :
								
								break;
			}
			
		</cfscript>
	</cffunction>
    
    <cffunction name="editModelsForGrid" access="remote" output="false">
        <cfargument name="gridaction" type="string" required="yes">
        <cfargument name="gridrow" type="struct" required="yes">
        <cfargument name="gridchanged" type="struct" required="yes">
		
		<cfscript>
		var colname = '';
        var value = '';
        var Esdata = {}; /* Essential data : data that is manipulated locally */
			switch(ARGUMENTS.gridaction)
			{
					case 'U' :  
								colname = StructKeyList(ARGUMENTS.gridchanged) ;	
								value = ARGUMENTS.gridchanged[colname];
								switch(colname)
								{
								case 'MODEL_NAME'    : 	
														Esdata = APPLICATION.com.model.models.updateItemModel(ARGUMENTS.gridrow.MODEL_ID,
														value,SESSION.userdata.us_id, #DateFormat(Now(),"dd-mmm-yyyy")#);
														break;	
								}
					case 'D' :
								
								break;
			}
			
		</cfscript>
	</cffunction>


</cfcomponent>