<html>
<head>
</head>
	<body>
	<cfif not structIsEmpty(FORM) and structKeyExists(FORM,"printvalue") >
		<cfsilent>
		<cfset result = APPLICATION.com.control.purchasing.DataForPrintOrder(FORM.purchaseid, FORM.choice) />
		<cfset pricedata = APPLICATION.com.control.purchasing.PriceDataForPrintOrder(FORM.purchaseid, FORM.choice) />
		
		<cfswitch expression="#FORM.campus#">
				<cfcase value="0">
						<cftry>
								<cfpdfform action="populate" 
									 			source="#Application.POtemplatepath#AUHForm.pdf" 
												destination="#Application.POCreatepath##result.data.ins_purchaseid#.pdf" 
												overwrite="yes" 
												overwritedata="yes">
										
										<cfpdfsubform name="POForm">
											<cfpdfsubform name="POSubForm">
												<cfpdfformparam name="PONumber" value="#result.data.ins_purchaseid#">
												<cfpdfformparam name="DateValue" value="#Dateformat(now(),'DD-MMM-YYYY')#">
												<cfpdfformparam name="SupplierName" value="#result.data.vendor_name#">
												<cfpdfformparam name="DliveryRefValue" value="#result.data.ins_purchaseid#">
												<cfpdfformparam name="EstimDtDlvValue" value="#Dateformat(result.data.vendor_delivery_date,'DD-MMM-YYYY')#">
											
								  			  <cfset query1 = result.data />
											  <cfloop query="query1">
													<cfpdfformparam name="Ref2_#currentRow#" value="#chr(13)##chr(10)##query1.type[currentRow]#">
													<cfpdfformparam name="Item2_#currentRow#" value="#chr(13)##chr(10)##query1.po_description[currentRow]#">
													<cfpdfformparam name="Qty2_#currentRow#" value="#query1.quantity[currentRow]#">
													<cfpdfformparam name="UnitP2_#currentRow#" value="#pricedata.data.symbol##query1.unitprice[currentRow]#">
													<cfpdfformparam name="ListP2_#currentRow#" value="#pricedata.data.symbol##query1.listprice[currentRow]#">
													<cfpdfformparam name="Dscnt2_#currentRow#" value="#query1.discount[currentRow]#%">
													<cfpdfformparam name="Gst2_#currentRow#" value="#query1.tax[currentRow]#%">
													<cfpdfformparam name="Deliv2_#currentRow#" value="#pricedata.data.symbol##query1.shippingcost[currentRow]#">
											  </cfloop>
										  
											<cfpdfsubform name="Priceform">
												<cfpdfformparam name="TotalPriceValue" value="#pricedata.data.symbol# #pricedata.data.totalprice#">
												<cfpdfformparam name="Totalgstvalue" value="#pricedata.data.symbol# #pricedata.data.taxamt#">
												<cfpdfformparam name="Gstvalue" value="#result.data.tax# %">
												<cfpdfformparam name="DelivValue" value="#pricedata.data.symbol#  #pricedata.data.delivery#">
												<cfpdfformparam name="GtotalValue" value="#pricedata.data.symbol# #pricedata.data.grandtotal#">
												<cfpdfformparam name="RequesterName_BdgId" value="#result.data.name# - #result.data.budgetid#">
											</cfpdfsubform>
										
										    </cfpdfsubform>
										</cfpdfsubform>
								</cfpdfform> 
				
								<cfpdf action="protect" 
										source="#Application.POCreatepath##result.data.ins_purchaseid#.pdf" 
										newOwnerPassword="apdaily" 
										destination="#Application.POCreatepath##result.data.ins_purchaseid#.pdf" 
										overwrite="true"
										permissions="AllowCopy,AllowPrinting" />
							
							<cfsavecontent variable="outMessage">
								<tr>
									<td class="content">
										The Print Order is generated. Right Click on this Image 
											<cfoutput><a href="#APPLICATION.POpath##result.data.ins_purchaseid#.pdf" target="_blank"></cfoutput>
													<img src="../images/dwnld.jpg" width="15px" />
											</a> 
										and choose 'Save As...' or 'Save Link As...' to download it.
									</td>
							    </tr>
								<tr>
									<td class="content">
										<span class="bld">Note:</span> We recommend you to use Adobe Acrobat Reader only.
									</td>
								</tr>
							</cfsavecontent>			
							
							<cfcatch type="any">
								<cfif CFCATCH.cause.message.IndexOf('used by another process') NEQ -1>
									<cfsavecontent variable="outMessage">
										<tr>
											<td class="content">
												The system usually overwrites on the existing file. But if it is opened by you now, the file operation could not be finished.
											</td>
									    </tr>
										<tr>
											<td class="content bld">
												So, please <span class="bld">close</span> the PDF reader window.
											</td>
										</tr>
									</cfsavecontent>
								<cfelse>
									<cfsavecontent variable="outMessage">
										<tr>
											<td class="content">
												<cfoutput>#CFCATCH.message#</cfoutput>
											</td>
									    </tr>
									</cfsavecontent>
								</cfif>
							</cfcatch>
							</cftry>		
				</cfcase>
				<cfcase value="1">
							<cftry>
								<cfpdfform action="populate" 
									 			source="#Application.POtemplatepath#FBLForm.pdf" 
												destination="#Application.POCreatepath##result.data.ins_purchaseid#.pdf" 
												overwrite="yes" 
												overwritedata="yes">
										
										<cfpdfsubform name="POForm">
											<cfpdfsubform name="POSubForm">
												<cfpdfformparam name="PONumber" value="#result.data.ins_purchaseid#">
												<cfpdfformparam name="DateValue" value="#Dateformat(now(),'DD-MMM-YYYY')#">
												<cfpdfformparam name="SupplierName" value="#result.data.vendor_name#">
												<cfpdfformparam name="DliveryRefValue" value="#result.data.ins_purchaseid#">
												<cfpdfformparam name="EstimDtDlvValue" value="#Dateformat(result.data.vendor_delivery_date,'DD-MMM-YYYY')#">
											
								  			  <cfset query1 = result.data />
											  <cfloop query="query1">
													<cfpdfformparam name="Ref2_#currentRow#" value="#chr(13)##chr(10)##query1.type[currentRow]#">
													<cfpdfformparam name="Item2_#currentRow#" value="#chr(13)##chr(10)##query1.po_description[currentRow]#">
													<cfpdfformparam name="Qty2_#currentRow#" value="#query1.quantity[currentRow]#">
													<cfpdfformparam name="UnitP2_#currentRow#" value="#pricedata.data.symbol##query1.unitprice[currentRow]#">
													<cfpdfformparam name="ListP2_#currentRow#" value="#pricedata.data.symbol##query1.listprice[currentRow]#">
													<cfpdfformparam name="Dscnt2_#currentRow#" value="#query1.discount[currentRow]#%">
													<cfpdfformparam name="Gst2_#currentRow#" value="#query1.tax[currentRow]#%">
													<cfpdfformparam name="Deliv2_#currentRow#" value="#pricedata.data.symbol##query1.shippingcost[currentRow]#">
											  </cfloop>
										  
											<cfpdfsubform name="Priceform">
												<cfpdfformparam name="TotalPriceValue" value="#pricedata.data.symbol# #pricedata.data.totalprice#">
												<cfpdfformparam name="Totalgstvalue" value="#pricedata.data.symbol# #pricedata.data.taxamt#">
												<cfpdfformparam name="Gstvalue" value="#result.data.tax# %">
												<cfpdfformparam name="DelivValue" value="#pricedata.data.symbol#  #pricedata.data.delivery#">
												<cfpdfformparam name="GtotalValue" value="#pricedata.data.symbol# #pricedata.data.grandtotal#">
												<cfpdfformparam name="RequesterName_BdgId" value="#result.data.name# - #result.data.budgetid#">
											</cfpdfsubform>
										
										    </cfpdfsubform>
										</cfpdfsubform>
								</cfpdfform> 
				
								<cfpdf action="protect" 
										source="#Application.POCreatepath##result.data.ins_purchaseid#.pdf" 
										newOwnerPassword="apdaily" 
										destination="#Application.POCreatepath##result.data.ins_purchaseid#.pdf" 
										overwrite="true"
										permissions="AllowCopy,AllowPrinting" />
							
							<cfsavecontent variable="outMessage">
								<tr>
									<td class="content">
										The Print Order is generated. Right Click on this Image 
											<cfoutput><a href="#APPLICATION.POpath##result.data.ins_purchaseid#.pdf" target="_blank"></cfoutput>
													<img src="../images/dwnld.jpg" width="15px" />
											</a> 
										and choose 'Save As...' or 'Save Link As...' to download it.
									</td>
							    </tr>
								<tr>
									<td class="content">
										<span class="bld">Note:</span> We recommend you to use Adobe Acrobat Reader only.
									</td>
								</tr>
							</cfsavecontent>			
							
							<cfcatch type="any">
								<cfif CFCATCH.cause.message.IndexOf('used by another process') NEQ -1>
									<cfsavecontent variable="outMessage">
										<tr>
											<td class="content">
												The system usually overwrites on the existing file. But if it is opened by you now, the file operation could not be finished.
											</td>
									    </tr>
										<tr>
											<td class="content bld">
												So, please <span class="bld">close</span> the PDF reader window.
											</td>
										</tr>
									</cfsavecontent>
								<cfelse>
									<cfsavecontent variable="outMessage">
										<tr>
											<td class="content">
												<cfoutput>#CFCATCH.message#</cfoutput>
											</td>
									    </tr>
									</cfsavecontent>
								</cfif>
							</cfcatch>
							</cftry>
								
				</cfcase>
				<cfcase value="2">
					<cftry>
						<cfpdfform action="populate" 
							 			source="#Application.POtemplatepath#SGPForm.pdf" 
										destination="#Application.POCreatepath##result.data.ins_purchaseid#.pdf" 
										overwrite="yes" 
										overwritedata="yes">
								
								<cfpdfsubform name="POForm">
									<cfpdfsubform name="POSubForm">
										<cfpdfformparam name="PONumber" value="#result.data.ins_purchaseid#">
										<cfpdfformparam name="DateValue" value="#Dateformat(now(),'DD-MMM-YYYY')#">
										<cfpdfformparam name="SupplierName" value="#result.data.vendor_name#">
										<cfpdfformparam name="DliveryRefValue" value="#result.data.ins_purchaseid#">
										<cfpdfformparam name="EstimDtDlvValue" value="#Dateformat(result.data.vendor_delivery_date,'DD-MMM-YYYY')#">
									
						  			  <cfset query1 = result.data />
									  <cfloop query="query1">
											<cfpdfformparam name="Ref2_#currentRow#" value="#chr(13)##chr(10)##query1.type[currentRow]#">
											<cfpdfformparam name="Item2_#currentRow#" value="#chr(13)##chr(10)##query1.po_description[currentRow]#">
											<cfpdfformparam name="Qty2_#currentRow#" value="#query1.quantity[currentRow]#">
											<cfpdfformparam name="UnitP2_#currentRow#" value="#pricedata.data.symbol##query1.unitprice[currentRow]#">
											<cfpdfformparam name="ListP2_#currentRow#" value="#pricedata.data.symbol##query1.listprice[currentRow]#">
											<cfpdfformparam name="Dscnt2_#currentRow#" value="#query1.discount[currentRow]#%">
											<cfpdfformparam name="Gst2_#currentRow#" value="#query1.tax[currentRow]#%">
											<cfpdfformparam name="Deliv2_#currentRow#" value="#pricedata.data.symbol##query1.shippingcost[currentRow]#">
									  </cfloop>
								  
									<cfpdfsubform name="Priceform">
										<cfpdfformparam name="TotalPriceValue" value="#pricedata.data.symbol# #pricedata.data.totalprice#">
										<cfpdfformparam name="Totalgstvalue" value="#pricedata.data.symbol# #pricedata.data.taxamt#">
										<cfpdfformparam name="Gstvalue" value="#result.data.tax# %">
										<cfpdfformparam name="DelivValue" value="#pricedata.data.symbol#  #pricedata.data.delivery#">
										<cfpdfformparam name="GtotalValue" value="#pricedata.data.symbol# #pricedata.data.grandtotal#">
										<cfpdfformparam name="RequesterName_BdgId" value="#result.data.name# - #result.data.budgetid#">
									</cfpdfsubform>
								
								    </cfpdfsubform>
								</cfpdfsubform>
						</cfpdfform> 
		
						<cfpdf action="protect" 
								source="#Application.POCreatepath##result.data.ins_purchaseid#.pdf" 
								newOwnerPassword="apdaily" 
								destination="#Application.POCreatepath##result.data.ins_purchaseid#.pdf" 
								overwrite="true"
								permissions="AllowCopy,AllowPrinting" />
					
					<cfsavecontent variable="outMessage">
						<tr>
							<td class="content">
								The Print Order is generated. Right Click on this Image 
									<cfoutput><a href="#APPLICATION.POpath##result.data.ins_purchaseid#.pdf" target="_blank"></cfoutput>
											<img src="../images/dwnld.jpg" width="15px" />
									</a> 
								and choose 'Save As...' or 'Save Link As...' to download it.
							</td>
					    </tr>
						<tr>
							<td class="content">
								<span class="bld">Note:</span> We recommend you to use Adobe Acrobat Reader only.
							</td>
						</tr>
					</cfsavecontent>			
					
					<cfcatch type="any">
						<cfif CFCATCH.cause.message.IndexOf('used by another process') NEQ -1>
							<cfsavecontent variable="outMessage">
								<tr>
									<td class="content">
										The system usually overwrites on the existing file. But if it is opened by you now, the file operation could not be finished.
									</td>
							    </tr>
								<tr>
									<td class="content bld">
										So, please <span class="bld">close</span> the PDF reader window.
									</td>
								</tr>
							</cfsavecontent>
						<cfelse>
							<cfsavecontent variable="outMessage">
								<tr>
									<td class="content">
										<cfoutput>#CFCATCH.message#</cfoutput>
									</td>
							    </tr>
							</cfsavecontent>
						</cfif>
					</cfcatch>
					</cftry>
				</cfcase>
							
			</cfswitch>
		</cfsilent>
		<cfoutput>				
			<table width="100%">
				#outMessage#
			</table>
		</cfoutput>
	<cfelse>		
			
			<cfset result = APPLICATION.com.control.purchasing.ItemsForPrintOrder(URL.purchase_id) />
				
		<form name="itemprint" action="printorder.cfm" method="post">
				<table width="100%" id="itemsListing">
					<tr>
						<td class="content" width="100%" >					
						<fieldset class="paddingdecom">
							<legend>&nbsp;Options&nbsp;</legend>
							
							<ul class="decomUL" style="clear:right;width:100%">
								<li class="celldecomStyle" style="width:120px" >
									Choose a campus :
								</li>
								<li class="celldecomStyle" style="width:120px" > 
									<select name="campus" id="po_campus">
										<option value="-1">-----------</option>
										<option value="0">AbuDhabi</option>
										<option value="1">Fontainebleau</option>
										<option value="2">Singapore</option>
									</select>
								</li>
							</ul>
							
							<ul class="decomUL" style="float:left;clear:right;">
								<li class="bolddecom" style="width:30px" >
									#
								</li>
								<li class="bolddecom" style="width:150px" >
									Items
								</li>
								<li class="bolddecom" style="width:100px;clear:right;" >
									Vendor Name
								</li>
							</ul>
							
							<cfoutput query="result.data">
							<ul class="decomUL" style="float:left;clear:right;">
								<li class="celldecomStyle" style="width:30px;padding-left:0px;" >
									#currentrow#.
								</li>
								<li class="celldecomStyle" style="width:150px;padding-left:0px;" >
									<input name="choice" type="radio" id="choice_#currentrow#" value="#vendor_id#">	 &nbsp;
									#Items#
									<!--- #replace(Items,",",", ","all")# --->
								</li>
								<li class="celldecomStyle" style="width:100px;padding-left:0px;clear:right;" >
									#vendor_name#
								</li>
							</ul>
							</cfoutput>
							</fieldset>
						</td>
					</tr>
					<tr>
					<td class="content">
						<ul class="decomUL" style="clear:right;">
							<li class="celldecomStyle" style="width:150px;" ><input name="print" type="button" value="Print" onclick="validatePO();"></li>
						</ul>			
						
					</td>
				</tr>
			</table>
			<input name="purchaseid" type="hidden" value="<cfoutput>#URL.purchase_id#</cfoutput>">
			<input name="printvalue" type="hidden" value="default">
		</form>
	</cfif>
	</body>
</html>