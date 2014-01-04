<cfparam default="#StructNew()#" name="purchaserequest" type="struct">
<html>
<head>
</head>
	<body>
		<table width="670px" id="itemsListing">
			<tr>
				<td class="content">
					<cfif not structIsEmpty(FORM) and structKeyExists(FORM,"genPO") >
						<cfset purchaserequest = APPLICATION.com.control.requests.processReq(FORM) />
							<cfif purchaserequest.success eq '-1' >
								All Items were rejected, so Purchase order Number will not be generated
							<cfelseif purchaserequest.success>
								<cfoutput>
									Purchase Id #purchaserequest.data# has been generated and a mail has been automatically sent to the requester
										<cfmail from="#APPLICATION.AdminEmail#" to="#purchaserequest.email#" cc="#SESSION.userdata.email#" subject="Purchase Order Created ">	
											Your Purchase has been approved by Purchasing Department and Purchase Order Number #purchaserequest.data# has been  generated 
											All future corresponding will be in accordance with this reference Number 
											------------  This Mail is an automatically generated email. Please donot reply -------
										</cfmail>
								</cfoutput>
							<cfelseif purchaserequest.success eq '0' >
								Request Has been removed
							</cfif>
					<cfelse>				
						<cfoutput>#APPLICATION.com.control.requests.itemsdisplay(URL.request_id)#</cfoutput>
					</cfif>
				</td>
			</tr>
		</table>
	</body>
</html>