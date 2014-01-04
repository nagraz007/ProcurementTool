<cfcomponent displayname="requests" output="false">

	<cffunction name="init" access="public" returntype="requests" description="Generates an object of itself">
		<cfreturn THIS />
	</cffunction>
	
	<cffunction name="genreq" access="public" returntype="struct" output="false"
			description="Generates a Purchase Request">
		<cfargument name="Form" type="struct" required="true" />
		 
		<cfscript>
			var util = APPLICATION.com.util ;
			var item = APPLICATION.com.model.items;
			var success = util.$struct(flag = true, message = '') ;
			var data = ARGUMENTS.form;
			var holder = util.$struct();
			var i = 1;

			var count = data.itemcount ;
			var newRequestId = APPLICATION.com.model.req.insertreq(SESSION.userdata.us_id, data.budgetid, data.onbehalfof, data.reason, data.incident ) ; 
			
			if(newRequestId.success){
				
				success.message = newRequestId.message;
				
				while(i lte count && success.flag){
					holder = item.insertitem(data['model#i#'], data['description#i#'], 'S', newRequestId.data, data['purchasetype#i#'], data['quantity#i#'], 
											 SESSION.Userdata.us_id);
					success.flag = holder.success;
					i = i + 1;	
				}
				
				if(not success.flag){
					success.message = success.message & ', but items could not be added to the request.';
				}
				
			}else{
				success.flag = false;
				success.message = newRequestId.message;		
			}
			
			return success;
		</cfscript>

	</cffunction>
	
	<cffunction name="listmodels" access="remote" returntype="string" output="false"
				description="Lists out al Models for a particular type for double-drop down in Purchase Request section ">
		<cfargument name="purchasetype_id" type="numeric" required="false" default="0"  />
			<cfscript>
				var Models = APPLICATION.com.model.models.listmodels(ARGUMENTS.purchasetype_id).data;
					
				var i = 1;
				var retString = '';
				while(i LTE Models.recordCount){
					retString = retString & Models.id[i] & ',' & Models.name[i];
					if(i LT Models.recordCount){
						retString = retString & '^';				
					}
					i = i + 1;
				}
				return retString;
			</cfscript>
			<cfsetting showdebugoutput="false" />
	</cffunction>
	
	<cffunction name="listPurchaseTypes" access="public" returntype="struct" output="false"
				description="Lists out all Purchase types for double-drop down in Purchase Request page">
		<cfargument name="purchasetype_id" type="numeric" required="false" default="0"  />
		<cfargument name="asJSArray" type="boolean" required="false" default="false"  />
		
			<cfset var lStruct = APPLICATION.com.util.$struct(data='') />
			<cfset var purchaseTypes = APPLICATION.com.model.PurchItmType.listItems(ARGUMENTS.purchasetype_id) />
			<cfset var jsArray = "[0,'--Select--']" />
			
			<cfif ARGUMENTS.asJSArray>
				<cfloop query="purchaseTypes.data">
					<cfset jsArray = jsArray & "[#purchaseTypes.data.purchasetype_id#, '#purchaseTypes.data.name#']" />
					<cfif not purchaseTypes.data.currentRow eq purchaseTypes.data.recordCount>
					<cfset jsArray = jsArray & ',' />
					</cfif>
				</cfloop>
				<cfset structInsert(lStruct,'dArray', jsArray) />
			</cfif>
			
		<cfset lStruct.data = purchaseTypes.data />	
		
		<cfreturn lStruct />
	</cffunction>
	
	<cffunction name="listreq" access="remote" output="true" returnformat="plain"
				description="lists out all requests which are stil pending to be approved">
			<cfset var itemsList = '' />
			<cfset var Requests = APPLICATION.com.model.req.listreq(0) />

			<cfsavecontent variable="itemsList">
				<table width="670px">
                   <tr>
                   	   <td width="50px" class="tableheading">S.no##</td>
                       <td width="250px" class="tableheading">Requester</td>
                       <td width="400px" class="tableheading">Time of Request</td>
                       <td width="80px" class="tableheading">Number of items</td>
                       <td width="150px" class="tableheading">&nbsp;</td>
				   </tr>
				<cfoutput query="Requests.data">
				   <tr>
                      <td width="50px" class="content">#currentrow#</td>
                      <td width="250px" class="content">#Requests.data.name#</td>
                      <td width="400px" class="content">#DateFormat(Requests.data.firstcreatedon,"FULL")# at #TimeFormat(Requests.data.firstcreatedon, "hh:mm:sstt")#</td>
                      <td width="80px" class="content">#Requests.data.Cnt#</td>
                      <td width="150px" class="content"><input type="button" name="rq_#Requests.data.request_id#" value="More Details" onclick="fillHdntxt(#Requests.data.request_id#)" /></td>
				   </tr>
				</cfoutput>
               </table>   
			</cfsavecontent>
			<cfoutput>#itemsList#</cfoutput>
	</cffunction>
	
	<cffunction name="itemsdisplay" access="public" output="false" returntype="string"
				description="Displays all Items in a Request">
		<cfargument name="ReqId" type="numeric" required="true"  >
		
		<cfset var Itemdata = APPLICATION.com.model.items.itemsdisplay(ARGUMENTS.ReqId) />
		<cfset var Reqdata = APPLICATION.com.model.req.listreqForwindow(ARGUMENTS.ReqId) />
		<cfset var budgetmgrs = APPLICATION.com.model.BudgetRoles.showbudgetmgrs() />
		<cfset var retItemsDisplay = '' />
	
		<cfsavecontent variable="retItemsDisplay">
		<cfoutput>
			<cfform name="itemList" id="itemList" action="item.cfm" method="post">
			
			<input name="reqID" type="hidden" value="#ARGUMENTS.ReqId#" />
			<input name="requesterID" type="hidden" value="#Itemdata.data.firstcreatedby#" />
			<input name="count" type="hidden" value="#Itemdata.data.recordCount#" />
			<input name="budgetid" type="hidden" value="#Reqdata.data.budgetid#" />
			<input name="itemidList" type="hidden" value="#ValueList(Itemdata.data.item_id)#" />
			
			<fieldset class="paddingAround">
				<legend> Details Of Request &nbsp;</legend>
				<ul class="ulStyle">
					<li><span class="bld">Budget ID :</span> #Reqdata.data.budgetid#</li>
					<cfif Reqdata.data.onbehalfof neq '' >
					<li><span class="bld">On Behalf of :</span> #Reqdata.data.onbehalfof#</li>
					<li><span class="bld">Reason :</span> #Reqdata.data.onbereason#</li>
					</cfif>
					<li style="height:10px;"><span class="bld">Number of Items :</span> #Itemdata.data.recordcount#</li>
					<li><span class="bld">Request Status :</span> 
						<select name="reqstatus">
							<option value="Pending">Pending</option>
							<option value="Remove">Remove</option>
						</select>
					</li>
				</ul>
			</fieldset>
				
		<cfloop query="Itemdata.data">
			<fieldset class="paddingAround">
				<legend>Item #currentRow# &nbsp; </legend>
				<table width="100%">
					<tbody>
						<tr>
							<td width="100%">
								<ul class="itemHeaderUL">
									<li class="bld" style="width:40px;">Type:</li>
									<li style="width:120px;">#type#</li>
									<li class="bld" style="width:40px;">Model:</li>
									<li style="width:150px;">#model#</li>
									<li class="bld" style="width:80px;">Quantity:</li>
									<li style="width:40px;">#quantity#</li>
								</ul>
							</td>
						</tr>
						<tr>
							<td width="100%">
								<ul class="itemHeaderUL">
									<li width="90px" class="bld">Description:</li>
									<li width="430px" style="word-wrap:break-word;">#description#</li>
								</ul>
							</td>
						</tr>
						<tr>
							<td width="100%">
								<ul class="itemHeaderUL">
									<li width="90px" class="bld">Decision:</li>
									<li width="430px">
									Approve 
									<cfinput name="approval#Itemdata.data.currentrow#" type="radio" value="A" id="approve1#Itemdata.data.currentrow#"
										onClick="showfields('cond_comment#Itemdata.data.currentrow#','cond_fields#Itemdata.data.currentrow#')" />
										&nbsp; &nbsp;
									Reject 
									<cfinput name="approval#Itemdata.data.currentrow#" type="radio" value="R" id="approve2#Itemdata.data.currentrow#"
										onClick="hidefields('cond_fields#Itemdata.data.currentrow#'); showCommentfields('cond_comment#Itemdata.data.currentrow#');" />
									
									<div id="approve#Itemdata.data.currentrow#">
								
									</div>
									</li>
								</ul>
							</td>
						</tr>
						<tr id="cond_comment#Itemdata.data.currentrow#" style="display:none;">
							<td width="100%">
								<ul class="itemHeaderUL">
									<li width="90px" class="bld">Comment:</li>
									<li width="430px">
										<textarea name="comment#Itemdata.data.currentrow#" cols="68" rows="2"></textarea>
									</li>
								</ul>
							</td>
						</tr>
						<tr id="cond_fields#Itemdata.data.currentrow#" style="display:none;">
							<td width="100%">
								<ul class="itemHeaderUL">
									<li style="width:90px" class="bld">Vendor:</li>
									<li style="width:370px">
										<cfinput name="vendor#Itemdata.data.currentrow#" class="required" id="vendor#Itemdata.data.currentrow#" type="text" autoSuggestMinLength="3" 
														autosuggest="cfc:#APPLICATION.hardroot#model/vendors.autosuggest({cfautosuggestvalue})" 
														showAutosuggestLoadingIcon="true" /> <div id="vendorDivID#Itemdata.data.currentrow#"></div>
									</li>
								</ul>
							</td>
						</tr>
					</tbody>
				</table>
			</fieldset>
		</cfloop>
			<table width="100%">
				<tbody>
					<cfif Itemdata.data.recordcount neq 0>
						<tr>
							<td width="100%">
								<ul class="itemHeaderUL">
								<li style="width:120px" class="bld">
									BudgetManager: 
								</li>
								<li style="width:400px">
									<cfinput name="budgetman" type="text" class="required" id="budgetman"autoSuggestMinLength="3"
										autosuggest="#ValueList(budgetmgrs.data.name)#" delimiter="," showAutosuggestLoadingIcon="true" />
										 <div id="budgetmanDivID"></div>
								</li>
							</td>
						</tr>
					</cfif>
					<tr>
						<td width="100%">
							<input type="hidden" name="genPO" value="" />
							<cfinput type="button" id="btnWindowSubmit" name="btnWindowSubmit" value="Submit" onclick="doValidate()" />
						</td>
					</tr>
				</tbody>
			</table>


			</cfform>
		</cfoutput>
		</cfsavecontent>
		
		<cfreturn retItemsDisplay />
	</cffunction>

 	<cffunction name="processReq" access="public" returntype="struct" output="false"
description="Processing a Request before generating a Purchase Order">
		<cfargument name="reqData" type="struct" required="true" />
		
		<cfscript>
			/* *
			 
			 	1. Update request
				2. Update items
			 	3. if approve --> gen purchaseID, insert into purchase table -->  send email to requester that it has been 'reviewed'
			 	4. if decline --> send email to requester that it has been 'declined'
			 				 	 
			 * */
			var util = APPLICATION.com.util ;
			var retStr = util.$struct();
			var requestData = ARGUMENTS.reqData;
			
			var requestModel = APPLICATION.com.model.req;
			var requestItemsModel = APPLICATION.com.model.items;
			
			var updSuccess = util.$struct(); 
			var PurchidSuccess = ''; 
			var i = 1;
			var findApprovalFlag = false;
			
			updSuccess = requestModel.updatereq(requestData.reqID, requestData.reqstatus, SESSION.Userdata.us_id);		
			
			if(updSuccess.success){
						
					if(compareNoCase(requestData.reqstatus,'Pending') eq 0){
							
							while(updSuccess.success && i LTE requestData.count ){
								
								updSuccess = requestItemsModel.updateItem(ListGetAt(requestData.itemIdList,i), 
																			requestData['approval#i#'], 
																			SESSION.userdata.us_id);
								if(not findApprovalFlag){
									findApprovalFlag = requestData['approval#i#'] eq 'A';	
								}
								
								i = i + 1;
								
							}
							
							if(updSuccess.success){
									if(findApprovalFlag){
										/*call the controller that calls the model of purchasing
										call the method that creates and returns the purchaseID	
										send params as req ID*/
									
										retStr = APPLICATION.com.control.purchasing.genpurchID(requestData);
									}
									else
									{
									structInsert(retStr, "success", '-1');
									structInsert(retStr, "message", "updSuccess.messaged");
									updSuccess = APPLICATION.com.model.req.updatereq(requestData.reqID, 'Passed', SESSION.Userdata.us_id);
									}					
												
							}
							else{
								structInsert(retStr, "success", false);
								structInsert(retStr, "message", updSuccess.message);	
							}
					}
					else{
							structInsert(retStr, "success", '0');
							structInsert(retStr, "message", updSuccess.message);
											
						}
				
			}
			else{
				structInsert(retStr, "success", false);
				structInsert(retStr, "message", updSuccess.message);
			}
			return retStr;
		</cfscript>

	</cffunction>	 
	
	<cffunction name="ListAllrequestsForGrid" access="remote" output="false"
				description="Displays all Requests for Grid">
		<cfargument name="page" required="true" />
		<cfargument name="pageSize" type="numeric" required="true" />
		<cfargument name="gridsortcolumn" type="string" required="true" />
		<cfargument name="gridstartdirection" type="string" required="true" />
		
			<cfscript>
			var getData = {};
			getData = APPLICATION.com.model.req.listreqForGrid(ARGUMENTS.gridsortcolumn,ARGUMENTS.gridstartdirection);
			return QueryConvertForGrid(getdata.data, page, pageSize); /* Error Handling*/
			</cfscript> 

	</cffunction>
	
	<cffunction name="EditAllrequestsForGrid" access="remote" output="false"
				description=" Gives Edit functionality for a particular Request in Grid">
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
								case 'request_status'    : 	EsData = APPLICATION.com.model.req.updatereq(ARGUMENTS.gridrow.request_id, value, SESSION.userdata.us_id);
													break;		
											
						}
			
						break;
					
			}
			
		</cfscript>
	</cffunction>

</cfcomponent>