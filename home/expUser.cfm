<html>
<head></head>
	<body>
					<cfif not structIsEmpty(FORM) and structKeyExists(FORM,"exp") >
											<cfoutput>#APPLICATION.com.control.admin.expireAction_user(FORM.userid, FORM.type)#</cfoutput>						
						<cfelse>				
							<cfoutput>#APPLICATION.com.control.admin.expire_user(URL.us_id, URL.type)#</cfoutput>
					</cfif>
	</body>
</html>