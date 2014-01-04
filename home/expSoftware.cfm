<html>
<head></head>
	<body>
					<cfif not structIsEmpty(FORM) and structKeyExists(FORM,"exp") >
											<cfoutput>#APPLICATION.com.control.assetman.expireAction(FORM.softwareid, FORM.type)#</cfoutput>						
						<cfelse>				
							<cfoutput>#APPLICATION.com.control.assetman.expire(URL.software_id, URL.type)#</cfoutput>
					</cfif>
	</body>
</html>