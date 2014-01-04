<cfcomponent displayname="budget_roles" output="false">
	
	<cffunction name="init" access="public" returntype="budget_roles" description="Generates an object of itself">
		<cfargument name="datasource" required="true" type="string" />
		<cfset variables.datasource = ARGUMENTS.datasource />
		<cfreturn THIS />
	</cffunction>
	
	<cffunction name="showbudgetmgrs" returntype="struct" output="false" access="public"
				description="Accessess database and lists out Budget Managers">
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetusid = "" />
		<!--- <cftry> --->
			<cfquery name="qryGetusid" datasource="#variables.datasource#">
				SELECT  username as name , Initcap(a.firstname)||' '||upper(a.lastname) as Fname,
					email ||'|'||Initcap(a.firstname)||' '||upper(a.lastname) combined
				FROM itgov_users a, itgov_purchase_permissions b
				 WHERE a.purchaseaccess_id = b.purchaseaccess_id
				 AND b.permission > 1
			</cfquery>
			<cfset strLocal.data = qryGetusid />
		<!--- 	<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Getting user id's who are budget managers failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>

</cfcomponent>