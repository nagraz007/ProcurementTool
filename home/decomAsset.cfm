<html>
<head></head>
	<body>
		<cfif not structIsEmpty(FORM) and structKeyExists(FORM,"Decom") >
			<cfif FORM.type eq 0>
					<cfoutput>#APPLICATION.com.control.assetman.decomAction(FORM.productid, FORM.type, FORM.reason)#</cfoutput>						
				<cfelse>
					<cfoutput>#APPLICATION.com.control.assetman.decomAction(FORM.productid, FORM.type, '')#</cfoutput>						
			</cfif>
		<cfelse>				
				<cfoutput>#APPLICATION.com.control.assetman.decom(URL.product_id, URL.type)#</cfoutput>
		</cfif>
	</body>
</html>