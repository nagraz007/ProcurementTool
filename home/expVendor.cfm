<html>
<head></head>
	<body>
					<cfif not structIsEmpty(FORM) and structKeyExists(FORM,"exp") >
											<cfoutput>#APPLICATION.com.control.admin.expireAction_vendor(FORM.vendorid, FORM.type)#</cfoutput>						
						<cfelse>				
							<cfoutput>#APPLICATION.com.control.admin.expire_vendor(URL.vendor_id, URL.type)#</cfoutput>
					</cfif>
	</body>
</html>