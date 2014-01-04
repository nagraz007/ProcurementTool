<cfcomponent displayname="purchasing" output="false">

	<cffunction name="init" access="public" returntype="purchasing" description="Generates an object of itself">
		<cfreturn THIS />
	</cffunction>
	 
 	 <cffunction name="genpurchID" access="public" output="false" returntype="struct" 
description="Generates Purcahse Order Number">
		<cfargument name="reqData" type="struct" required="true">
		
		<!--- //generating purchase ID --->
		<cfscript>
			var requestData = ARGUMENTS.reqData;
			var i = 1;
			var getdata = '';
			var ReqUpdate = '';
			var updSuccess = {success = true, message = '',email = ''}; 
			var budgetmgrid = APPLICATION.com.model.users.authenticateUser(requestData.budgetman);
			var vendorid = '';
			var purchid = APPLICATION.com.model.Purchases.insertpurchases(requestData.requesterid, requestData.reqid, budgetmgrid, requestData.budgetid, SESSION.userdata.us_id);
			if (purchid.success)
			{
					while(updSuccess.success && i LTE requestData.count ){
							getdata = APPLICATION.com.model.items.listitemsifApproved(ListGetAt(requestData.itemIdList,i));
							
							vendorid = APPLICATION.com.model.vendors.listvendors(0, requestData['vendor#i#']);
							if(getdata.data.typeid neq ''){
							updSuccess = APPLICATION.com.model.PurchItems.insertpurchases_items(vendorid.data.vendor_id , 
																								getdata.data.typeid, 
																								purchid.data, 
																								getdata.data.modelid, 
																								getdata.data.description, 
																								getdata.data.quantity, 
																								requestData['comment#i#'],
																								i, 
																								SESSION.userdata.us_id );
							}
							
							i = i + 1 ;
						}	 
					if (updSuccess.success)
					{
						updSuccess = APPLICATION.com.model.req.updatereq(requestData.reqID, 'Passed', SESSION.Userdata.us_id);				
							if ( not updSuccess.success){
									updSuccess.message = updSuccess.message & 'Request not updated ' ;				
							}
					}
					if (updSuccess.success){
										
							getdata = APPLICATION.com.model.Purchases.getpurchId('', purchid.data);
							updSuccess.data = '#getdata.data.ins_purchaseid#';	
							updSuccess.email = APPLICATION.com.model.users.getEmail(requestData.requesterid).data.email;	
					}
			}
			else {
					updSuccess.success = false ;
					updSuccess.message = purchid.message & ': Purchase Id not generated ' ; 	
						
			}
			return updSuccess;
			
		</cfscript>
		
	</cffunction>

	<cffunction name="POAutoSuggest" access="remote" returntype="array"
		description="Calls the corresponding Model and gives autosuggest functionality for Purchase Order Number">
		<cfargument name="search" type="any" required="false" default="">
	<cfreturn APPLICATION.com.model.Purchases.autosuggest(ARGUMENTS.search) />
	
	</cffunction>

	 <cffunction name="updatePurchase" access="public" returntype="struct" output="false"
	 	description="Calls the corresponding Model and Updates the Details of a PO">
		<cfargument name="reqData" type="struct" required="true">
		
		<!--- //generating purchase ID --->
		<cfscript>
			var i = 1;
			var updatestatus = '';
			var log = '';
			var statuslog = APPLICATION.com.model.statuslog;
			var updSuccess = {success = true, message = ''}; 
			var requestData = ARGUMENTS.reqData;
			var vendor = APPLICATION.com.model.vendors;
			var purchase = APPLICATION.com.model.Purchases;
			var purchaseItems = APPLICATION.com.model.PurchItems;

					/* update the purchase status and total amount */
					updatestatus = purchase.updatepurchases(requestData.purchaseid, requestData.Purchstatus, requestData.grandtotal, SESSION.userdata.us_id);
					
					/* creating a log for Change in Status */
					if(requestData.statuschangeflag eq 1)
					{
					log = statuslog.insertlog(requestData.purchaseid, requestData.Purchstatus,  SESSION.userdata.us_id);
					}
			while(updSuccess.success && i LTE requestData.count )
				{
					
					/* update the purchase items details */
					updSuccess = purchaseItems.updatepurchases_items( requestData['item#i#'], 
																	  vendor.listvendors(0, requestData['vendor#i#']).data.vendor_id, 
																	  requestData['currency#i#'] ,
																	  requestData['unitp#i#'],  
																	  requestData['listp#i#'],  
																	  requestData['discount#i#'],  
																	  requestData['costafterdiscount#i#'],  
																	  requestData['Total#i#'],
																	  requestData['venddelivdate#i#'],  
																	  requestData['datereqdby#i#'],  
																	  requestData['shipc#i#'],  
																	  requestData['invoicedate#i#'],  
																	  requestData['invoicenumber#i#'],
																	  requestData['salescntctname#i#'],  
																	  requestData['salesphone#i#'],  
																	  requestData['salesemail#i#'],  
																	  requestData['vendoffer#i#'],  
																	  requestData['vendref#i#'],
																	  requestData['expdeldate#i#'], 
																	  requestData['tax#i#'], 
																	  requestData['GTotal#i#'], 
																	  requestData['delivery_status#i#'], 
																	  requestData['po_desc#i#'], 
																	  SESSION.userdata.us_id  
																  );
					i = i + 1;
				}
			
				if (updSuccess.success){
						updSuccess.message = 'Successfully Updated' ;		
								
				}
		</cfscript>
		<cfloop from="1" to="#requestData.count#" index="i">
			<cfif requestData['invoice#i#'] neq ''>
				<cffile action="upload" fileField="invoice#i#" destination="#Application.uploadpath##requestData.inspurchid#" nameConflict="overwrite">
				<cffile action="rename" source="#cffile.SERVERDIRECTORY#\#cffile.serverfile#" destination="#cffile.SERVERDIRECTORY#\I_#i#_#cffile.serverfile#">
			</cfif>
			<cfif requestData['quote#i#'] neq ''>
				<cffile action="upload" fileField="quote#i#" destination="#Application.uploadpath##requestData.inspurchid#" nameConflict="overwrite"> 
				<cffile action="rename" source="#cffile.SERVERDIRECTORY#\#cffile.serverfile#" destination="#cffile.SERVERDIRECTORY#\Q_#i#_#cffile.serverfile#">
			</cfif>
		</cfloop>
	<cfreturn updSuccess />
	</cffunction> 

	<cffunction name="listPO" access="remote" output="true" returnformat="plain"
				description="Lists out All All PO's to coresponding Budget Manager">
		<cfset var POList = '' />
		<cfset var POapproval = APPLICATION.com.model.Purchases.listpurchasesForBudgetApproval(SESSION.userdata.us_id) />
			
		<cfsavecontent variable="PO">
					<table width="670px">
	                   <tr>
	                   	   <td width="50px" class="tableheading">S.no##</td>
	                       <td width="250px" class="tableheading">Requester</td>
	                       <td width="400px" class="tableheading">Time of Creation of Purchase Order </td>
	                       <td width="150px" class="tableheading">&nbsp;</td>
					   </tr>
					<cfoutput query="POapproval.data">
					   <tr>
	                      <td width="50px" class="content">#currentrow#</td>
	                      <td width="250px" class="content">#POapproval.data.name#</td>
	                      <td width="400px" class="content">#DateFormat(POapproval.data.firstcreatedon,"FULL")# at #TimeFormat(POapproval.data.firstcreatedon, "hh:mm:sstt")#</td>
	                      <td width="150px" class="content"><input type="button" name="rq_#POapproval.data.purchase_id#" value="More Details" onclick="fillHdntxt(#POapproval.data.purchase_id#)" /></td>
					   </tr>
					</cfoutput>
	               </table>   
				</cfsavecontent>
		<cfoutput>
			#PO#
		</cfoutput>
	</cffunction>
	
	<cffunction name="POdisplay" access="public" output="false" returntype="string"
				description="Interacts with corresponding Model and displays corresponding details required for Budget Manager">

		<cfargument name="purchaseId" type="numeric" required="true"  >
		
		<cfset var purchdata = APPLICATION.com.model.PurchItems.listpurchases_itemsforBudgetman(ARGUMENTS.purchaseId) />
		<cfset var Emails = APPLICATION.com.model.Purchases.GetEmailForaPO(ARGUMENTS.purchaseId) />
		<cfset var util = APPLICATION.com.util />
		<cfsavecontent variable="retItemsDisplay">
		<cfoutput>
			
			<fieldset class="paddingAround">
				<legend> Details Of Purchase Order &nbsp;</legend>
				<ul class="ulStyle">
					<li><span class="bld">Purchase ID :</span> #purchdata.data.inspurchaseid#</li>
					<li style="height:12px;"><span class="bld">Number of Items :</span> #purchdata.data.recordcount#</li>
					<li ><span class="bld">Total Purchase Amount :</span> #purchdata.data.total#</li>
					
				</ul>
			</fieldset>
				
			<cfform name="purchList" action="po.cfm" method="post">
						<input name="purchaseId" type="hidden" value="#ARGUMENTS.purchaseId#">
						<input name="budgetemail" type="hidden" value="#Emails.data.budgetemail#">
						<input name="useremail" type="hidden" value="#Emails.data.useremail#">
						<input name="decision" type="hidden" value="2">
				<cfloop query="purchdata.data">
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
									<li width="400px" style="word-wrap:break-word;">#description#</li>
								</ul>
							</td>
						</tr>
						<tr>
							<td width="100%">
								<ul class="itemHeaderUL">
									<li width="90px" class="bld">Comments:</li>
									<li width="400px" style="word-wrap:break-word;">#comments#</li>
								</ul>
							</td>
						</tr>
						<tr>
							<td width="100%">
								<ul class="itemHeaderUL">
									<li class="bld" style="width:70px;">List Price:</li>
									<li  style="width:88px;" >#listprice#</li>
									<li style="width:135px;"class="bld">Total After Tax:</li>
									<li style="width:100px;word-wrap:break-word;">#grandtotal#</li>
								</ul>
							</td>
						</tr>
						<tr>
							<td width="100%">
								<ul class="itemHeaderUL">
									<li width="90px" class="bld"><a href="javascript:toggleseefiles('showfiles#currentrow#');">Related Files</a></li>
								</ul>
							</td>
						</tr>
						<td width="100%">
							<div id="showfiles#currentrow#" style="display:none">
								<ul class="itemHeaderUL">
									<li class="bld" style="width:25px;">
										## 
									</li>
									<li class="bld" style="width:200px;">
										Name of File 
									</li>
								</ul>
								<cfset getlist = util.listfiles(purchdata.data.inspurchaseid, '#currentrow#') />
								<cfloop query="getlist.data">
									<ul class="itemHeaderUL" style="float:left;">
										<li class="cellStyle" style="width:25px;padding-bottom:5px;">
											#getlist.data.currentrow# 
										</li>
										<li class="cellStyle" style="width:300px;">
											#getlist.data.name# 
										</li>
										<li class="cellStyle" style="width:20px;">
											<a href="#APPLICATION.docpath##purchdata.data.inspurchaseid#/#getlist.data.name#" target="_blank">
												<img src="../images/dwnld.jpg" width="15px">
											</a>
										</li>
									</ul>
								</cfloop>
							</div>
							</td>
					</tr>
					</tbody>
					</table>
					</fieldset>
				</cfloop>
				<table width="100%">
					<tbody>
						<tr>
							<td>
								&nbsp;
							</td>
						</tr>
						<tr>
							<td width="100%">
							<ul class="itemHeaderUL" style="float:left;">
										<li class="cellStyle" style="width:150px;padding-bottom:5px;">
										&nbsp;
										</li>
										<li class="cellStyle" style="width:135px;padding-bottom:5px;">
						<input type="submit" name="approve" value="Approve" size="8" onClick="document.purchList.decision.value = 1;" />
										</li>
										<li class="cellStyle" style="width:150px;padding-bottom:5px;">
						<input type="submit" name="reject" value="Reject" size="8" onClick="document.purchList.decision.value = 0;" />
										</li>
									</ul>
			</cfform>
		</cfoutput>
				</cfsavecontent>	 
	<cfreturn retItemsDisplay />
	</cffunction>
			
	<cffunction name="updateBudgetManDecision" access="public" output="false" returntype="struct"
	 description="Updates the decision of Budget manager by Interacting with corresponding Model">
		<cfargument name="reqdata" type="struct" required="true">
		<cfscript>
			var requestedData = ARGUMENTS.reqdata;
			var res = '';
				res = APPLICATION.com.model.Purchases.updateBudgetmandecision(requestedData.purchaseId, requestedData.decision, SESSION.userdata.us_id);		
			return res;
		</cfscript>
	
	</cffunction> 	

	<cffunction name="listitemsId" access="remote" output="false" returntype="query"
				description="Lists Items for a particular Purchase which are delivered but not registered">
		<cfargument name="inspurchid" type="string" required="true">
		<cfset purchid = APPLICATION.com.model.Purchases.getpurchId(ARGUMENTS.inspurchid, 0) />
	
		<cfset res = APPLICATION.com.model.PurchItems.listIdPurchaseItems(purchid.data.purchase_id).data />
		
		
		<cfreturn res />
	</cffunction>
	
	<cffunction name="listitemsIdforReg" access="remote" output="false" returntype="query"
				description="Lists Items for a particular Purchase which are delivered but not registered">
		<cfargument name="inspurchid" type="string" required="true">
		<cfset purchid = APPLICATION.com.model.Purchases.getpurchId(ARGUMENTS.inspurchid, 0) />
	
		<cfset res = APPLICATION.com.model.PurchItems.listIdPurchaseItemsForReg(purchid.data.purchase_id).data />
		
		
		<cfreturn res />
	</cffunction>

	<cffunction name="SeeAllApprovalsForGrid" access="remote" output="false" 
			description="Intercats with corresponding Model and Displays the status of all Budget Approvals">
		<cfargument name="page" required="true" />
		<cfargument name="pageSize" type="numeric" required="true" />
		<cfargument name="gridsortcolumn" type="string" required="true" />
		<cfargument name="gridstartdirection" type="string" required="true" />
		
			<cfscript>
			var getData = {};
			getData = APPLICATION.com.model.purchases.SeeAllApprovalsForGrid(ARGUMENTS.gridsortcolumn,ARGUMENTS.gridstartdirection);
			return QueryConvertForGrid(getdata.data, page, pageSize); /* Error Handling*/
			</cfscript> 

	</cffunction>

	<cffunction name="checkingForRegistry" access="public" output="false" returntype="struct"
				description="Checking Registry if the Item is delivered or not">
		<cfargument name="purchItmId" type="numeric" required="true">
	
		<cfreturn APPLICATION.com.model.Purchases.checkForRegistry(purchItmId) />
	</cffunction>
		
	<cffunction name="listitemsForReg" access="public" output="false" returntype="struct"
			description="Lists Items for a particular Purchase Item which are delivered but not registered">
		<cfargument name="purchItmId" type="numeric" required="true">
	<cfreturn APPLICATION.com.model.PurchItems.listitemsForReg(purchItmId) />
	</cffunction>
	
	<cffunction name="listforreg" access="public" output="false" returntype="struct"
				description="Lists Items for a particular Purchase which are delivered but not registered">
		<cfargument name="purchId" type="numeric" required="true">
	<cfreturn APPLICATION.com.model.PurchItems.listforreg(purchId) />
	</cffunction>
	
	<cffunction name="regForProduct" access="public" output="false" returntype="string"
				description="interface for registering Product through Purchase management for quantity less than 2">
		<cfargument name="itemid" type="numeric">
		
		<cfset var ItmData = APPLICATION.com.model.PurchItems.listitemsForReg(ARGUMENTS.itemid) />				
		<cfsavecontent variable="retItemsDisplay">
			<cfoutput>
			<!--- <script>
				alert(#ARGUMENTS.itemid#);
			</script> --->
				<cfform name="prdfrom" id="prdfrom" action="purchRegister.cfm" method="post">
						<br/>
						<span style="padding-left:100px" class="bld notes">This purchase item has #ItmData.data.quantity# units.</span>
						<br/>
						<table width="100%">
							<tr>
								<td width="100%" class="content">
									<fieldset class="paddingAround">
										<legend> Generic Details &nbsp;</legend>
										<table width="100%">
											<tbody>
											<tr>
			                               	  <td width="100%">
												<ul class="itemHeaderUL">
													<li style="width:135px" class="bld">Budget ID :</li>
													<li style="width:400px">
														<input type="text" name="budgetid" id="budgetid" class="required"  />
														
														<div id="budgetidDivID"></div>
													</li>
												</ul>
											   </td>
											</tr>
											<tr>
			                               	  <td width="100%">
												<ul class="itemHeaderUL">
													<li style="width:135px" class="bld">Date Started :</li>
													<li style="width:400px">
														<cfinput type="datefield" mask="DD-MMM-YYYY" id="date_p" name="date_p" class="required" />
														<div id="date_pDivID"></div>
													</li>
												</ul>
											   </td>
											</tr>
											<tr><td>&nbsp;</td></tr>
											</tbody>
										</table>
									</fieldset>
								
									<cfloop from="1" to="#ItmData.data.quantity#" index="i" >
									<fieldset class="paddingAround">
										<legend> Unit #i# &nbsp;</legend>
										<table width="100%">
											<tbody>
											<tr>
			                               	  <td width="100%">
													<ul class="itemHeaderUL">
														<li style="width:135px" class="bld">Serial ##:</li>
														<li style="width:400px">
															<input type="text" name="serial#i#" id="serial#i#">
															<div id="serialDivID#i#"></div>
														</li>
													</ul>
											  </td>
			                           	    </tr>
											<tr>
			                               	  <td width="100%">
													<ul class="itemHeaderUL">
														<li style="width:135px" class="bld">Product :</li>
														<li style="width:400px">
															<input type="text" name="product#i#" id="product#i#">
															<div id="productDivID#i#"></div>
														</li>
													</ul>
											  </td>
			                           	    </tr>
											<tr>
			                               	  <td width="100%">
													<ul class="itemHeaderUL">
														<li style="width:135px" class="bld">Campus :</li>
														<li style="width:400px">
															<select name="campus#i#" id="select"  >
							                               	    <option class="content" value="SGP">Singapore</option>
							                               	    <option class="content" value="FBL">Fountainebleu</option>
							                               	    <option class="content" value="AUH">Abudhabhi</option>
						                             	    </select>    
														</li>
													</ul>
											  </td>
			                           	    </tr>
											<tr>
			                               	  <td width="100%">
													<ul class="itemHeaderUL">
														<li style="width:135px" class="bld">End User Name :</li>
														<li style="width:400px">
															<cfinput type="text" name="enduser#i#"  id="enduser#i#"
																autosuggest="cfc:#APPLICATION.hardRoot#control/assetman.autosuggestusers({cfautosuggestvalue})" 
																autoSuggestMinLength="3" 
																showAutosuggestLoadingIcon="true" />
																<div id="enduserDivID#i#"></div>
														</li>
													</ul>
											  </td>
			                           	    </tr>
											</tbody>
										</table>
									</fieldset>
									</cfloop>
								</td>
							</tr>
							<tr>
                              <td class="content"><input type="button" name="btnWindowSubmit_p" id="btnWindowSubmit_p" value="Save"
											onclick="doValidate_p();"			 ></td>
                        	</tr>
						</table>
							<input type="hidden" name="product_0" value="0">
							<input type="hidden" name="submit" value="">
							<input type="hidden" name="purchasetype" value="#ItmData.data.purchasetype_id#">
                            <input type="hidden" name="itmtype" value="#ItmData.data.model_id#">
                            <input type="hidden" name="purchaseid" value="#ItmData.data.purchaseid#">
                            <input type="hidden" name="purchaseitmid" value="#ARGUMENTS.itemid#">
                            <input type="hidden" name="vendorid" value="#ItmData.data.vendorid#">
                            <input type="hidden" name="quantity" value="#ItmData.data.quantity#">
                            <input type="hidden" name="ownership" value="Own">
                            <input type="hidden" name="old_new" value="NEW">
				</cfform>
			</cfoutput>	
		</cfsavecontent>
	
	<cfreturn retItemsDisplay />
	</cffunction>

	<cffunction name="regForSoftware" access="public" output="false" returntype="string"
				description="interface for registering Software through Purchase management for quantity less than 2">
		<cfargument name="itemid" type="numeric">
		<cfset var ItmData = APPLICATION.com.model.PurchItems.listitemsForReg(ARGUMENTS.itemid) />				
		<cfsavecontent variable="retItemsDisplay">
			<cfoutput>
				<cfform name="softwareform" id="softwareform" action="purchRegister.cfm" method="post">
				<table width="100%">
				<tr>
				<td width="100%">	
					<fieldset class="paddingAround">
										<legend> Generic Details &nbsp;</legend>
				<table width="100%">
                                    
		                     	<tr>
			                               	  <td width="100%">
													<ul class="itemHeaderUL">
														<li style="width:135px" class="bld">Name </li>
														<li style="width:400px">
															<input type="text" name="name_s" id="name_s" class="required">
															 <div id="name_sDivID"></div>
														</li>
													</ul>
											  </td>
			                     </tr>
		                     	<tr>
			                               	  <td width="100%">
													<ul class="itemHeaderUL">
														<li style="width:135px" class="bld">Type </li>
														<li style="width:400px">
															<input type="radio" name="softwaretype" value="Individual" id="softwaretype_0">
                            	  				      Individual &nbsp;&nbsp;&nbsp;&nbsp;
										<input type="radio" name="softwaretype" value="Organizationwide" id="softwaretype_1">
                            	        					Organizationwide  
										<input type="radio" name="softwaretype" value="Department" id="softwaretype_2">
                            	        						Department
														 <div id="softwaretypeDivID"></div>
														</li>
													</ul>
											  </td>
			                     </tr>
		                     	<tr>
			                               	  <td width="100%">
													<ul class="itemHeaderUL">
														<li style="width:135px" class="bld">No. of Licenses of #ItmData.data.quantity# </li>
														<li style="width:400px">
															<input type="text" name="noLicenses" class="required number" id="noLicenses">
															 <div id="noLicensesDivID"></div>
														</li>
													</ul>
											  </td>
			                     </tr>
		                     	<tr>
			                               	  <td width="100%">
													<ul class="itemHeaderUL">
														<li style="width:135px" class="bld">Duration of Contract </li>
														<li style="width:400px">
															<input name="duration" type="text" size="4" class="required number" id="duration"> &nbsp;
                            	    <select name="durationtypeOptions" >
                            	      <option class="content" value="day">days</option>
                            	      <option class="content" value="month">months</option>
                            	      <option class="content" value="year">years</option>
                          	        </select>    
														 <div id="durationDivID"></div> 														</li>
													</ul>
											  </td>
			                     </tr>
		                     	<tr>
			                               	  <td width="100%">
													<ul class="itemHeaderUL">
														<li style="width:135px" class="bld">Start Date</li>
														<li style="width:400px">
															<cfinput type="datefield" mask="DD-MMM-YYYY" name="startdate" id="startdate" class="required">
														<div id="startdateDivID"></div> 
														</li>
													</ul>
											  </td>
			                     </tr>
		                     	<tr>
			                               	  <td width="100%">
													<ul class="itemHeaderUL">
														<li style="width:135px" class="bld">Termination Notice</li>
														<li style="width:400px">
															<input type="radio" name="term_notice" value="yes" id="term_yes" onclick="showterm();">
                            	        Yes
                            	        <input type="radio" name="term_notice" value="no" id="term_no" onclick="hideterm();" checked >
                            	        No
											<div id="term_noticeDivID"></div> 
														</li>
													</ul>
											  </td>
			                     </tr>
		                     	<div  >
		                     	<tr>
			                               	  <td width="100%">
													<ul class="itemHeaderUL" id="term" style="display:none;">
														<li style="width:135px" class="bld">Notice Requirement</li>
														<li style="width:400px" >
															<textarea name="noticeReq" cols="63" rows="3"></textarea>
														</li>
													</ul>
											  </td>
			                     </tr>
			                     </div>
		                     	<tr>
			                               	  <td width="100%">
													<ul class="itemHeaderUL">
														<li style="width:135px" class="bld"><input type="button" name="btnWindowSubmit" id="btnWindowSubmit" value="Save"
											onclick="doValidate_s();"			 ></li>
													</ul>
											  </td>
			                     </tr>
							</table>
							</fieldset>
							</td>
							</tr>
							</table>
								<input type="hidden" name="product_0" value="1">
                                    	<input type="hidden" name="old_new" value="NEW">
                                    	<input type="hidden" name="itmtype_s" value="#ItmData.data.model_id#">
                                    	<input type="hidden" name="purchaseid" value="#ItmData.data.purchaseid#">
                                    	<input type="hidden" name="purchaseitmid" value="#ARGUMENTS.itemid#">
                                    	<input type="hidden" name="vendorid" value="#ItmData.data.vendorid#">
                                    	<input type="hidden" name="po_old_s" value="">
										<input type="hidden" name="submit" value="">
                                    	<input type="hidden" name="qty" value="#ItmData.data.quantity#">
				</cfform>
		
			</cfoutput>	
		</cfsavecontent>
	
	<cfreturn retItemsDisplay />
	
	</cffunction>

	<cffunction name="assetRegistrationMismatch" access="public" output="false" returntype="query"
				description="Returns teh list of all Assets which are not registered for a particular Purchase id">
    	<cfargument name="purchase_id" type="numeric" required="true">
		<cfreturn APPLICATION.com.model.Purchases.assetsNotRegistered(ARGUMENTS.purchase_id) />
    </cffunction>

	<cffunction name="autosuggestvendors" access="remote" output="false" returntype="array"
				description="Calls the corresponding Model and gives autosuggest functionality for Vendors">
		<cfargument name="search" type="any" required="false" default="">	
		
		<cfreturn APPLICATION.com.model.vendors.autosuggest(ARGUMENTS.search)/>
	</cffunction>

	<cffunction name="ItemsForPrintOrder" access="public" output="false" returntype="struct"
				description="Displaying Items grouped by each Vendor for Printing Purchase Order">
		<cfargument name="purchase_id" type="numeric" required="true">	
		
		<cfreturn APPLICATION.com.model.PurchItems.ItemsForPrintOrder(ARGUMENTS.purchase_id)/>
	</cffunction>
	
	<cffunction name="DataForPrintOrder" access="public" output="false" returntype="struct"
				description="Interacts with corresponidng Models and fetches data for Print Order">
		<cfargument name="purchase_id" type="numeric" required="true">	
		<cfargument name="vendor_id" type="numeric" required="true">	
		
		<cfreturn APPLICATION.com.model.PurchItems.DataForPrintOrder(ARGUMENTS.purchase_id, ARGUMENTS.vendor_id)/>
	</cffunction>
	
	<cffunction name="PriceDataForPrintOrder" access="public" output="false" returntype="struct"
				description="Interacts with corresponidng Models and fetches data for Print Order">
		<cfargument name="purchase_id" type="numeric" required="true">	
		<cfargument name="vendor_id" type="numeric" required="true">	
		
		<cfreturn APPLICATION.com.model.PurchItems.PriceDataForPrintOrder(ARGUMENTS.purchase_id, ARGUMENTS.vendor_id)/>
	</cffunction>

	<cffunction name="getpurchId" access="public" returntype="struct" output="false"
				description="Convert from insead format Purchase id to system purchase id by calling the database">
		<cfargument name="InspurchId" type="string" required="false" default="">
		<cfargument name="purchId" type="numeric" required="false" default="0">			
		<cfreturn APPLICATIOn.com.model.Purchases.getpurchId(ARGUMENTS.InspurchId,ARGUMENTS.purchId) />
	</cffunction>
	
	<cffunction name="listpurchasesforDisplay" returntype="struct" output="false" access="public"
				description="Listing All Purchases for display by calling database">
		<cfargument name="purchase_id" type="numeric" required="false" default="0"  />
		<cfreturn APPLICATION.com.model.Purchases.listpurchasesforDisplay(ARGUMENTS.purchase_id) />			
	</cffunction>
	
	<cffunction name="liststatus" returntype="struct" output="false" access="public"
				description="Lists out All Types of Status by calling database">
		<cfargument name="status_id" type="numeric" required="false" default="0"  />
		<cfreturn APPLICATION.com.model.PurchStatus.liststatus(ARGUMENTS.status_id) />
	</cffunction>	
	
	<cffunction name="listusernames" returntype="struct" output="false" access="public"
				description="Lists put names and usernames by calling database">
		<cfargument name="us_id" type="numeric" required="false" default="0"  />
			<cfreturn  APPLICATION.com.model.users.listusernames(ARGUMENTS.us_id) />
	</cffunction>
	
	<cffunction name="listcurrency" returntype="struct" output="false" access="public"
				description="Accessing data base and Lists out all types of currency">
		<cfargument name="currency_id" type="numeric" required="false" default="0"  /> 
		<cfreturn APPLICATION.com.model.currency.listcurrency(ARGUMENTS.currency_id) />		
	</cffunction>
	
	<cffunction name="listitemsForDisplay" returntype="struct" output="false" access="public"
				description="Lists out items form database">
		<cfargument name="purchase_id" type="numeric" required="false" default="0"  />
		<cfreturn APPLICATION.com.model.PurchItems.listitemsForDisplay(ARGUMENTS.purchase_id) />
	</cffunction>
</cfcomponent>