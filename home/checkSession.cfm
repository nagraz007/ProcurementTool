<cfparam name="ATTRIBUTES.assetdesired" type="numeric" default="-1" />
<cfparam name="ATTRIBUTES.purchasedesired" type="numeric" default="-1" /> 
<cfif not (StructKeyExists(SESSION, "userdata") and StructKeyExists(SESSION.userdata, "assetpermlevel")) >
		<cflocation url="login.cfm?errcode=SN-001" addToken="false" />
	<cfelseif not (SESSION.userdata.assetpermlevel gte ATTRIBUTES.assetdesired and 
					SESSION.userdata.purchasepermlevel gte ATTRIBUTES.purchasedesired)>
		<cflocation url="insuffPriv.cfm?errcode=GN-003" addToken="false" />
</cfif> 

<!--- <cfif not (ATTRIBUTE.assetaccess gte ATTRIBUTE.assetdesired and ATTRIBUTE.purchaseaccess gte ATTRIBUTE.purchasedesired)>
	<cflocation url="login.cfm?errcode=GN-002" addToken="false" />
<cfelse>
</cfif> --->