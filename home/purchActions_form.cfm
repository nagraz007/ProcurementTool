<cfsilent>		
		
		<cfset insPurchid = FORM.POSearchWord />
		<cfset getPurchid = APPLICATION.com.control.Purchasing.getpurchId(insPurchid, 0) />
		<cfset purchId = getPurchid.data.purchase_id />
		
		<cfset getPurchData = APPLICATION.com.control.Purchasing.ListpurchasesforDisplay(purchId) />
		<cfset getStatus = APPLICATION.com.control.purchasing.liststatus(getPurchData.data.status_id) />
		<cfset getStatusForSelect = APPLICATION.com.control.purchasing.liststatus(0) />
		<cfset getbudgetmgr = APPLICATION.com.control.purchasing.listusernames(getPurchData.data.budgetmgr_id) />
		<cfset getcurr = APPLICATION.com.control.purchasing.listcurrency(0) />
		
		<cfset getitemdata = APPLICATION.com.control.purchasing.listitemsForDisplay(purchId) />
		
		<cfset util = APPLICATION.com.util />
		
		<cfsavecontent variable="retPurchDisplay">
			<cfoutput>
		         <cfform name="list" action="purchaseactions.cfm" method="post" enctype="multipart/form-data" onsubmit="return dovalidate();">
                       	<fieldset class="paddingAround">
                       		<legend>
                       			Details Of PO &nbsp; 
                       		</legend>
                       		<table width="670px">
                       			<tbody>
                       				<tr>
										<td width="100%">
                       						<ul class="itemHeaderUL">
                       							<li class="bld" style="width:25px;">
                       								PO : 
                       							</li>
                       							<li class="cellStyle" style="width:65px;">
                       								#insPurchid#
                       							</li>
                       							<li class="bld" style="width:75px;">
                       								Open Date :
                       							</li>
                       							<li class="cellStyle" style="width:140px;">
                       								#dateformat(getPurchData.data.opendate,'dd-mmm-yyyy')#
                       							</li>
                       							 <li class="bld" style="width:110px;">
                       								Current Status : 
                       							</li>
                       							<li class="cellStyle" style="width:200px;word-wrap:break-word;">
                       								#getStatus.data.name#
                       							</li> 
												<input name="inspurchid" type="hidden" value="#insPurchid#">
                       						</ul>
										</td>
									</tr>
                       				<tr>
										<td width="100%">
                       						<ul class="itemHeaderUL">
                       							<li class="bld" style="width:100px;">
                       								Requester:
                       							</li>
                       							<li class="cellStyle" style="width:220px;">
                       								#getPurchData.data.name#
                       							</li>
											
                       						</ul>
										</td>
									</tr>
                       				<tr>
										<td width="100%">
                       						<ul class="itemHeaderUL">
                       						
											<cfif getPurchData.data.onbehalfof neq ''>
                       							<li class="bld" style="width:100px;">
                       								On behalf of :
                       							</li>
                       							<li class="cellStyle" style="width:220px;">
                       								#getPurchData.data.onbehalfof#
                       							</li>
                       							<li class="bld" style="width:60px;">
                       								Reason :
                       							</li>
                       							<li class="cellStyle" style="width:250px;word-wrap:break-word;">
                       								#getPurchData.data.onbereason#
                       							</li>
											</cfif>
                       						</ul>
										</td>
									</tr>
                       				<tr>
										<td width="100%">&nbsp;</td>	
									</tr>
									<tr>
										<td width="100%">
                       						<fieldset  class="paddingAround">
												<legend>Budget &nbsp;</legend>
												
											<ul class="itemHeaderUL">
                       							 <li class="bld" style="width:90px;padding-bottom:5px;">
                       								Id : 
                       							</li>
                       							<li class="cellStyle" style="width:500px;padding-bottom:5px;">
                       								#getPurchData.data.budgetid# &nbsp;
                       							</li> 
                       							 <li class="bld" style="width:90px;padding-bottom:5px;">
                       								Manager : 
                       							</li>
                       							<li class="cellStyle" style="width:500px;padding-bottom:5px;">
                       								#getbudgetmgr.data.name#
                       							</li> 
                       							<li class="bld" style="width:90px;padding-bottom:5px;">
	                       							Decision : 
	                       						</li>
                      								<cfif getPurchData.data.budgetapproval eq 1>
												 <li class="bld" style="width:500px;color:##006e51;padding-bottom:5px;">
														Approved
												</li>
													<cfelseif getPurchData.data.budgetapproval eq 0>	
												 <li class="bld" style="width:500px;color:red;padding-bottom:5px;">
														Declined
                       							</li>
													<cfelseif getPurchData.data.budgetapproval eq 2>	
												 <li class="bld" style="width:500px;color:red;padding-bottom:5px;">
														Pending
                       							</li>
													</cfif>
	                       						<li class="bld" style="width:90px;padding-bottom:5px;">
	                       								Comments : 
	                       						</li>
	                       						<li class="cellStyle" style="width:150px;word-wrap:break-word;">
	                       							#getPurchData.data.budgetmgrcomments#
	                       						</li> 
                       						</ul>
												</fieldset>
										</td>
									</tr>
                       				<tr>
										<td width="100%">
                       						<ul class="itemHeaderUL">
												 <li class="bld" style="width:140px;">
                       								 Change Status To : 
                       							</li>
                       							<li class="cellStyle" style="width:180px;">
                       														<input name="statuschangeflag" type="hidden" value="0">		
											<cfselect name="Purchstatus" query="getStatusForSelect.data" value="status_id" display="name" onchange="document.list.statuschangeflag.value=1;"></cfselect>
                       							
								</li>
												
												</ul>
										</td>
									</tr>
                       				<tr>
										<td width="100%">
                       						<ul class="itemHeaderUL">
												 <li class="bld" style="width:180px;">
                       								 Total Purchase Amount : 
                       							</li>
                       							<li class="cellStyle" style="width:180px;">
                       								<span id="grandtotal">#getPurchData.data.total#</span>
												<input name="grandtotal" type="hidden" value="#getPurchData.data.total#">
												<input name="purchaseid" type="hidden" value="#getPurchData.data.purchase_id#">

                       							</li>
												<li class="bld" style="width:180px;">
                       								<div id="currencyAlert"></div>
                       							</li>
												</ul>
										</td>
									</tr>
                       				<tr>
										<td width="100%">
                       						<ul class="itemHeaderUL">
												 <li class="bld" style="width:180px;">
                       								 <a href="#Application.path_server#/#replacenocase(APPLICATION.path_application,'\','/')#home/registerasset.cfm?refPurchaseID=#insPurchid#" target="_blank">
											Register as Assets
											</a>
                       							</li>
												 <li class="bld" style="width:180px;">
                       								&nbsp;
                       							</li>
												 <li class="bld" style="width:180px;">
                       								<input name="printOrdr" type="button" onclick="PrintOrder();" value="Print Order">
                       							</li>
												</ul>
										</td>
									</tr>
									<tr>
										<td width="100%">&nbsp;</td>	
									</tr>															
                       			</tbody>
                       		</table>
							 <div id="Accordion1" class="AquaAccordion">
							 <input id="totalItems" name="count" type="hidden" value="#getitemdata.data.recordcount#" >
			<cfloop query="getitemdata.data">
		<div class="AccordionPanel">
			<div class="Tab">Item #currentRow# &nbsp;</div>
			<div class="AccordionPanelContent">
			 <table width="670px">
					<tbody>
							<tr>
							<td>
							<ul class="itemHeaderUL">
								<li class="bld" style="width:10px;"><hr /></li>
								<li class="bldheader" style="width:70px;">Item Info </li>
								<li class="bld" style="width:550px;"><hr /></li>
							 <input name="item#currentrow#" type="hidden" value="#getitemdata.data.purchases_items_id#" >
								
							</ul>
						</td>
						</tr>
						<tr>
							<td width="100%">
								<ul class="itemHeaderUL">
									<li class="bld" style="width:40px;">Type:</li>
									<li class="cellStyle" style="width:100px;">#purchasetype#</li>
									<li class="bld" style="width:40px;">Model:</li>
									<li class="cellStyle" style="width:180px;word-wrap:break-word;">#modelname#</li>
									<li class="bld" style="width:65px;">Quantity:</li>
									<li class="cellStyle" style="width:15px;">#quantity# <input name="quantity#currentrow#" type="hidden" value="#quantity#"></li>
								</ul>
							</td>
						</tr>
						<tr>
							<td width="100%">
								<ul class="itemHeaderUL">
									<li class="bld" style="width:70px;">Comments:</li>
									<li class="cellStyle" style="width:430px;word-wrap:break-word;">#comments#</li>
								</ul>
							</td>
						</tr>
						<tr>
							<td width="100%">
								<ul class="itemHeaderUL">
									<li width="90px" class="bld">Description:</li>
									<li width="430px" class="cellStyle" style="word-wrap:break-word;">#description#</li>
								</ul>
							</td>
						</tr>
						<tr>
							<td width="100%">
								<ul class="itemHeaderUL">
									<li width="90px" class="bld">Description For PO:</li>
									<li width="430px" class="cellStyle" style="word-wrap:break-word;">
										<textarea name="po_desc#currentrow#"  cols="60" rows="3">#po_description#</textarea>
										</li>
								</ul>
							</td>
						</tr>
						<tr>
							<td>
							<ul class="itemHeaderUL">
								<li class="bld" style="width:10px;"><hr /></li>
								<li class="bldheader" style="width:80px;">Vendor Info </li>
								<li class="bld" style="width:540px;"><hr /></li>
							</ul>
						</td>
						</tr>
						<tr>
							<td width="100%">
								<ul class="itemHeaderUL">
									<li class="bld" style="width:60px;">Vendor :</li>
									<li class="cellStyle" style="width:220px;"><cfinput name="vendor#currentrow#" type="text" value="#vendorname#" 
													autosuggest="cfc:#APPLICATION.hardroot#control/purchasing.autosuggestvendors({cfautosuggestvalue})" autoSuggestMinLength="4" showAutosuggestLoadingIcon="true">	</li>
									<li class="bld" style="width:60px;">Details:</li>
									<li class="cellStyle"style="word-wrap:break-word;width:200px;">#vendordetails#</li>
								</ul>
							</td>
						</tr>
						<tr>
							<td width="100%">
								<ul class="itemHeaderUL">
									<li class="bld" style="width:100px;">Delivery Date :</li>
									<li class="cellStyle" style="width:180px;"><cfinput name="vendDelivDate#currentrow#" type="datefield" mask="DD-MMM-YYYY" 
									id="vendDelivDate#currentrow#" value="#DateFormat(vendor_delivery_date,'mm/dd/yyyy')#" >
									</li>
									<li class="bld" style="width:70px;"> Offer ## :</li>
									<li class="cellStyle" style="width:140px;"><input name="vendOffer#currentrow#" type="text" value="#vendoroffer#" ></li>
								</ul>
							</td>
						</tr>
						<tr>
							<td width="100%">
								<ul class="itemHeaderUL">
									<li class="bld" style="width:100px;">Date Reqd. by :</li>
									<li class="cellStyle" style="width:180px;"><cfinput name="dateReqdBy#currentrow#" type="datefield" mask="DD-MMM-YYYY" id="dateReqdBy#currentrow#" value="#DateFormat(date_reqd_by,'mm/dd/yyyy')#"  ></li>
									<li class="bld" style="width:160px;">Expected Delivery date :</li>
									<li class="cellStyle" style="width:160px;"><cfinput name="ExpDelDate#currentrow#" type="datefield" mask="DD-MMM-YYYY" id="ExpDelDate#currentrow#" value="#DateFormat(expected_delivery_date,'mm/dd/yyyy')#"></li>
									
								</ul>
							</td>
						</tr>
						<tr>
							<td width="100%">
								<ul class="itemHeaderUL">
								<li class="bld" style="width:100px;"> Ref ## :</li>
								<li class="cellStyle" style="width:180px;"><input name="vendRef#currentrow#" type="text" value="#vendorref#" ></li>
								<li class="bld" style="width:120px;"> Delivery Status  :</li>
								<li class="cellStyle" style="width:100px;">
									   Yes<input  type="radio" name="delivery_status#currentrow#" value="1" id="delivery_status_0_#currentrow#" onclick="deliverymade(#currentrow#)" >No               
                                <input type="radio" name="delivery_status#currentrow#"  value="0" id="delivery_status_1_#currentrow#">
									 <cfif #delivery_status# eq 1>
									<script>
										document.getElementById('delivery_status_0_#currentrow#').checked = true;
									</script>
								<cfelse>
									<script>
										document.getElementById('delivery_status_1_#currentrow#').checked = true;
									</script>
									
								</cfif>
                             
                                    </li>
								</ul>
							</td>
						</tr>
						
						<tr>
							<td>
							<ul class="itemHeaderUL">
								<li class="bld" style="width:10px;"><hr /></li>
								<li class="bldheader" style="width:80px;">Pricing Info </li>
								<li class="bld" style="width:540px;"><hr /></li>
							</ul>
						</td>
						</tr>
						
						<tr>
							<td width="100%">
								<ul class="itemHeaderUL">
									<li class="bld" style="width:70px;">Unit Price:</li>
									<li class="cellStyle" style="width:90px;"><input name="unitP#currentrow#" type="text" size="10" value="#unitprice#" onblur="calculateListPrice(this.value, #currentrow#, #getitemdata.data.recordcount#)"></li>
									<li class="bld" style="width:65px;">List Price:</li>
									<li class="cellStyle" style="width:195px;"><span id="listP#currentrow#">#listprice#</span>
										<input name="listP#currentrow#" type="hidden" size="8" value="#listprice#"></li>
									<li class="bld" style="width:75px;">Currency :</li>
									<li class="cellStyle" style="width:85px;"><cfselect name="currency#currentrow#" 
									query="getcurr.data" value="id" display="name" selected="#currency_id#"></cfselect></li>
									
									
									
								</ul>
							</td>
						</tr>
						<tr>
							<td width="100%">
								<ul class="itemHeaderUL">
									<li class="bld" style="width:70px;">Discount :</li>
									<li class="cellStyle" style="width:90px;"><input name="discount#currentrow#" type="text" size="8"
								onblur="calculateCostAfterDiscount(this.value, #currentrow#)" value="#discount#"></li>
									<li class="bld" style="width:135px;">Cost After Discount :</li>
									<li class="cellStyle" style="width:125px;"><span id="CostAfterDiscount#currentrow#">&nbsp;#pad#</span>
										<input name="CostAfterDiscount#currentrow#"  type="hidden" size="8"></li>
									<li class="bld" style="width:100px;">Shipping Cost :</li>
									<li class="cellStyle" style="width:70px;"><input name="shipC#currentrow#" type="text" size="6" onblur="calculateCostAfterShipping(this.value, #currentrow#)" value="#shippingcost#"></li>
									
									
								</ul>
							</td>
						</tr>
						<tr>
							<td width="100%">
								<ul class="itemHeaderUL">
									<li class="bld" style="width:50px;">Total : </li>
									<li class="cellStyle" style="width:109px;"><span id="Total#currentrow#">#totalamt#</span>
										<input name="Total#currentrow#"  type="hidden" size="6" value="#totalamt#"></li>
									<li class="bld" style="width:35px;">Tax :</li>
									<li class="cellStyle" style="width:90px;"><input name="tax#currentrow#" type="text" size="8"
								onblur="calculateCostAfterTax(this.value, #currentrow#)" value="#tax#"></li>
									<li class="bld" style="width:90px;"> Grand Total :</li>
									<li class="cellStyle" style="width:150px;"><span id="GTotal#currentrow#" style="color:red;">#grandtotal#</span>
										<input name="GTotal#currentrow#"  type="hidden" size="6" value="#grandtotal#"></li>
									
								</ul>
							</td>
						</tr>
						<tr>
							<td>
							<ul class="itemHeaderUL">
								<li class="bld" style="width:10px;"><hr /></li>
								<li class="bldheader" style="width:75px;">Sales Info </li>
								<li class="bld" style="width:545px;"><hr /></li>
							</ul>
						</td>
						</tr>
						
						<tr>
							<td width="100%">
								<ul class="itemHeaderUL">
									<li class="bld" style="width:100px;">Contact Name :</li>
									<li class="cellStyle" style="width:100px;"><input name="salesCntctName#currentrow#" type="text" size="12" value="#salescontact#" ></li>
									<li class="bld" style="width:60px;">Phone :</li>
									<li class="cellStyle" style="width:100px;"><input name="salesPhone#currentrow#" type="text"  size="12" value="#salesphone#"></li>
									<li class="bld" style="width:60px;">Email :</li>
									<li class="cellStyle" style="width:100px;"><input name="salesEmail#currentrow#" type="text"  size="12" value="#salesemail#" ></li>
									
								</ul>
							</td>
						</tr>
						<tr>
							<td>
							<ul class="itemHeaderUL">
								<li class="bld" style="width:10px;"><hr /></li>
								<li class="bldheader" style="width:85px;">Finance Info</li>
								<li class="bld" style="width:535px;"><hr /></li>
							</ul>
						</td>
						</tr>
						
						<tr>
							<td width="100%">
								<ul class="itemHeaderUL">
									<li class="bld" style="width:100px;">Invoice Date :</li>
									<li class="cellStyle" style="width:120px;"><cfinput name="invoicedate#currentrow#" type="datefield" mask="DD-MMM-YYYY" size="12" value="#DateFormat(invoicedate,'mm/dd/yyyy')#" ></li>
									<li class="bld" style="width:120px;">Invoice Number :</li>
									<li class="cellStyle" style="width:100px;"><input name="invoicenumber#currentrow#" type="text"  size="12" value="#invoicenumber#"></li>
								</ul>
							</td>
						</tr>
						
						
						<tr>
							<td>
								<ul class="itemHeaderUL">
									<li class="bld" style="width:10px;"><hr /></li>
									<li class="bldheader" style="width:85px;">File Section </li>
									<li class="bld" style="width:535px;"><hr /></li>
								</ul>
							</td>
						</tr>
						<tr>
							<td>
								<ul class="itemHeaderUL">
									<li class="bld" style="width:130px;">Upload a Quote :</li>
									<li class="cellStyle" style="width:100px;"><input name="quote#currentrow#" type="file"></li>
								</ul>
								</td>
						</tr>
						<tr>
							<td>
								<ul class="itemHeaderUL">
									<li class="bld" style="width:130px;">Upload an Invoice :</li>
									<li class="cellStyle" style="width:100px;"><input name="invoice#currentrow#" type="file"></li>
								</ul>
								</td>
						</tr>
						<tr>
							<td>
								<ul class="itemHeaderUL">
									<li class="bld" style="width:130px;"><a href="javascript:toggleseefiles('showfiles#currentrow#');">See All Files Uploaded</a></li>
									
								</ul>
								</td>
						</tr>
						<tr>
							<td>
								<div id="showfiles#currentrow#" style="display:none">
									<ul class="itemHeaderUL">
										<li class="bld" style="width:25px;">
										##
										</li>
										<li class="bld" style="width:200px;">
										Name of File
										</li>
									</ul>
										<cfset util.createDirectory(insPurchid) />
										<cfset getlist = util.listfiles(insPurchid, '#currentrow#') />
										<cfloop query="getlist.data">
									<ul class="itemHeaderUL" style="float:left;" id="file_#getitemdata.data.purchases_items_id[getitemdata.data.currentrow]#_#getlist.data.currentrow#">
										<li class="cellStyle" style="width:25px;padding-bottom:5px;">
											#getlist.data.currentrow# 
										</li>
										<li class="cellStyle" style="width:300px;word-wrap:break-word;">
											#getlist.data.name# 
										</li>
										<li class="cellStyle" style="width:20px;">
											<a href="#APPLICATION.docpath##insPurchid#/#getlist.data.name#" target="_blank">
											<img src="../images/dwnld.jpg" width="15px">
											</a>
										</li>
										 <!--- <cfset APPLICATION.com.model.utils.deleteFile(APPLICATION.uploadpath & inspurchid & '\#name#') /> --->
										<li class="cellStyle" style="width:20px;">
											<img src="../images/delete.png" 
												onclick="deletef('file_#getitemdata.data.purchases_items_id[getitemdata.data.currentrow]#_#getlist.data.currentrow#','#insPurchid#\\#getlist.data.name#')"
												style="cursor:pointer;">
										</li>
									</ul>
										</cfloop>
								</div>
								</td>
						</tr>

						<tr>
						<td>
						&nbsp;</td>
						</tr>
					</tbody>
				</table> 
				
			</div>
		</div>
			</cfloop>
	</div>
						<table>
				<tbody>
				<tr>
							<td>
								<ul class="itemHeaderUL">
									<li class="bld" style="width:250px;">&nbsp;</li>
									<li class="bld" style="width:120px;"><input name="updateinfo" type="submit" value="Update" size="12"></li>
								</ul>														
							</td>
						</tr>
						</tbody>
				</table> 		
			
				</fieldset>
				</cfform>
				<script type="text/javascript">
					var Accordion1 = new Spry.Widget.Accordion("Accordion1", { useFixedPanelHeights: false, defaultPanel: -1 });
				</script>
			</cfoutput>
		</cfsavecontent>
</cfsilent>

<cfoutput>#retPurchDisplay#</cfoutput>
