<html>

	<body>
	
		<table>
			<tr>
				<td class="content">
					<cfif not structIsEmpty(FORM) and (structKeyExists(FORM,"approve") or structKeyExists(FORM,"reject"))  >
								<cfset Res = APPLICATION.com.control.purchasing.updateBudgetManDecision(FORM) />
								<cfif Res.success>
									<cfoutput><cfif FORM.decision eq 1>
										Purchase has been Approved 
										<cfmail from="#APPLICATION.AdminEmail#" to="#FORM.useremail#" cc="#FORM.budgetemail#"
										subject="Regarding Budget Managers Decision for Purchase #FORM.purchaseId#">
											Congratulations!!!
											Your Purchase Request with Purchase Order Number #FORM.purchaseId# has been Approved by your Budget Controller
										
											<----Mailed by the Tool ----->
										</cfmail>
										<cfelseif FORM.decision eq 0 >
										<cfmail from="#APPLICATION.AdminEmail#" to="#FORM.useremail#" cc="#FORM.budgetemail#"
										subject="Regarding Budget Managers Decision for Purchase #FORM.purchaseId#">
											
											Your Purchase Request with Purchase Order Number #FORM.purchaseId# has been Rejected by your Budget Controller
										
											<----Mailed by the Tool ----->
										</cfmail>
										Purchase has been Rejected
									</cfif></cfoutput>
									<cfelse>
								</cfif>		<!--- Mail to Requester  --->
					<cfelse>								
					 <cfoutput> #APPLICATION.com.control.purchasing.POdisplay(URL.purchase_id)# </cfoutput>
					</cfif>
				</td>
			</tr>
		</table>
	</body>
</html>