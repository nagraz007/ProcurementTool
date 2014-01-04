<cfcomponent displayname="statuslog" output="false">

	<cffunction name="init" access="public" returntype="statuslog" description="Generates an object of itself">
		<cfargument name="datasource" required="true" type="string" />
		<cfset variables.datasource = ARGUMENTS.datasource />
		<cfreturn THIS />
	</cffunction>	

	<cffunction name="insertlog" returntype="struct" output="false" access="public" description="Insert a status log">
		<cfargument name="purchaseid" type="numeric" required="true" />
		<cfargument name="statusid" type="numeric" required="true"  />
		<cfargument name="insertedby" type="numeric" required="true"  />
		<cfset var strLocal = {success = true, message = ""} />
		<!--- <cftry> --->
			<cfquery name="qryInsertlog" datasource="#variables.datasource#">
				INSERT INTO itgov_statuslog (purchase_id, status_id, firstcreatedby, firstcreatedon)
				 VALUES ( 
				<cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchaseid#" />,
				<cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.statusid#" />,
				<cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.insertedby#" />,
				sysdate
						)
			</cfquery>
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Inserting Log failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>
		
</cfcomponent>