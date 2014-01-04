<cfcomponent displayname="Purchase_status" output="false">
	
	<cffunction name="init" access="public" returntype="Purchase_status" description="Generates an object of itself">
		<cfargument name="datasource" required="true" type="string" />
			<cfset variables.datasource = ARGUMENTS.datasource />
			<cfreturn THIS />
	</cffunction>
	
	<cffunction name="liststatus" returntype="struct" output="false" access="remote"
				description="Lists out All Types of Status">
		<cfargument name="status_id" type="numeric" required="false" default="0"  />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
		<!--- <cftry> --->
			<cfif not structKeyExists(variables,"datasource")>
				<cfset variables.datasource = APPLICATION.dsn_operEvents />
			</cfif>
			<cfquery name="qryGetList" datasource="#variables.datasource#">
						SELECT Initcap(name) as name,status_id 
						  FROM itgov_Purchase_status
						 WHERE 1 = 1
						 <cfif ARGUMENTS.status_id neq 0 > 
						 AND  status_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.status_id#" /> 
						 </cfif>
			</cfquery>
			<cfset strLocal.data = qryGetList />
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Getting List of Purchase Status failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>

</cfcomponent>