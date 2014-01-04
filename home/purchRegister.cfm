<cfparam default="#StructNew()#" name="purchaserequest" type="struct">
<cfparam default="" name="status" type="string">
<html>
<head>
</head>
	<body>
		<cfif not structIsEmpty(FORM) and structKeyExists(FORM,"submit") >
					<cfif FORM.product_0 eq 1>
					<!--- FoR Software --->
						<cfoutput>#APPLICATION.com.control.assetman.SoftwareRegForWindow(FORM)#</cfoutput>
					<cfelseif FORM.product_0 eq 2>
						
						
					
                    	<cffile action="upload" fileField="FileContents" destination="#Application.MailUploadpath#" nameConflict="MakeUnique">
						<cfset Status = APPLICATION.com.control.assetman.purchaseItemsBlkUpload('#cffile.serverfile#',FORM.item_id) />
					
					<!--- FoR Product --->
					<cfelse>
                    	<cfoutput>#APPLICATION.com.control.assetman.ProductRegForWindow(FORM)#</cfoutput>
						
					
					
					</cfif>
				
			<cfelse>
			<cfset ItmData = APPLICATION.com.control.purchasing.listitemsForReg(URL.item_id) />				
					<cfif ItmData.data.purchasetype_id neq 11>
							<cfif ItmData.data.quantity gt 2 >
								
								<!--- Bulk Registration --->	
                                <form id="bklUpload" name="bklUpload" method="post" action="purchRegister.cfm" enctype="multipart/form-data">
                                <table width="100%">
								<tr>
								<td  width="100%">
									<fieldset class="paddingAround">
										<legend> Please Upload &nbsp;</legend>
				<table width="100%">
                                    
		                     	<tr>
			                               	  <td width="100%">
													<ul class="itemHeaderUL">
														<li style="width:630px;color:#006E51" class="bld">As the quantity is more than 2 please provide a .csv file in the standard format for
														registration</li>
													</ul>
											  </td>
			                     </tr>
		                     	<tr>
			                               	  <td width="100%">
													<ul class="itemHeaderUL">
														<li style="width:135px" class="bld"><input name="FileContents" type="file" id="FileContents" class="required"></li>
													</ul>
											  </td>
			                     </tr>
		                     	<tr>
			                               	  <td width="100%">
													<ul class="itemHeaderUL">
														<li style="width:135px" class="bld"><input type="submit" value="Upload" name="submit" id="submit"/></li>
													</ul>
											  </td>
			                     </tr>
								
                                    <input type="hidden" name="item_id" id="item_id" value="#URL.item_id#">
                                    <input type="hidden" name="product_0" id="product_0" value="2">
				 </td>
			                     </tr>				
				</table>	
                                </form>
							<cfelse>
								<cfoutput>#APPLICATION.com.control.purchasing.regForProduct(URL.item_id)#</cfoutput>
							</cfif>
					<cfelse>
							<cfoutput>#APPLICATION.com.control.purchasing.regForSoftware(URL.item_id)#</cfoutput>
					</cfif>
				
		</cfif>
	</body>
</html>



















<!--- 

		<cfset checkResult =APPLICATION.com.control.purchasing.checkingForRegistry(FORM.po_item) />
			<cfif checkResult.success>
				<cfif checkResult.quantity gt 2 >
					<!--- Bulk Registration --->							
					<cfelse>
						<cfset ItmData = APPLICATION.com.control.purchasing.listitemsForReg(FORM.po_item) />
						<cfif checkResult.purchasetype_id neq 30>
								
								
								
						<cfelse>
							<table id="pform" >
                                    	<input type="hidden" name="purchasetype" value="#ItmData.data.purchasetype_id#">
                                    	<input type="hidden" name="itmtype" value="#ItmData.data.model_id#">
                                    	<input type="hidden" name="purchaseid" value="#ItmData.data.ins_purchaseid#">
                                    	<input type="hidden" name="purchaseitmid" value="#FORM.po_item#">
                                    	<input type="hidden" name="vendorname" value="#ItmData.data.vendorname#">
                                    	<input type="hidden" name="qty" value="#checkResult.quantity#">
							<cfloop from="1" to="#checkResult.quantity#" index="i" >
								<tr>
                            		<td width="135" class="content">
                                    Date Started                                   </td>
                                    <td width="323" class="content"><input type="text" name="date_p#i#"  class="required" ></td>
                               	</tr>
								<tr  >
                               	  <td class="content">Serial#</td>
                               	  <td class="content"><input type="text" name="serial#i#"></td>
                           	    </tr>
                               	<tr >
                               	  <td class="content">Product</td>
                               	  <td class="content"><input type="text" name="product#i#"></td>
                           	    </tr>
								<tr>
                               	  <td class="content">BudgetID</td>
                               	  <td class="content"><input type="text" name="budgetid#i#"></td>
                           	    </tr>
								<tr >
                               	  <td class="content">Campus</td>
                               	  <td class="content"><select name="campus#i#" id="select"  >
                               	    <option class="content" value="SGP">Singapore</option>
                               	    <option class="content" value="FBL">Fountainebleu</option>
                               	    <option class="content" value="AUH">Abudhabhi</option>
                             	    </select>                               	  </td>
                           	    </tr>
								<tr>
									<td class="content">
										End User Name
									</td>
									<td class="content">
										<cfinput type="text"  name="enduser#i#" autosuggest="cfc:#APPLICATION.hardRoot#control/assetman.autosuggestusers({cfautosuggestvalue})" autoSuggestMinLength="3"  showAutosuggestLoadingIcon="true">
									</td>
								</tr>
								</cfloop>
                               	<tr>
                               	  <td class="content">&nbsp;</td>
                               	  <td class="content"><input type="submit" name="submit" id="button" value="Save"></td>
                           	    </tr>
							</table>
						</cfif>	
						
						
					</cfif> 				
			
			
			
			</cfif>	
 --->
