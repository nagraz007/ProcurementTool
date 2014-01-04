<cfcomponent displayname="currency" output="false">
	
	<cffunction name="init" access="public" returntype="currency" description="Generates an object of itself">
		<cfargument name="datasource" required="true" type="string" />
		<cfset variables.datasource = ARGUMENTS.datasource />
		<cfreturn THIS />
	</cffunction>
	
	<cffunction name="listcurrency" returntype="struct" output="false" access="public"
				description="Accessing data base and Lists out all types of currency">
		<cfargument name="currency_id" type="numeric" required="false" default="0"  /> 
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
<!--- 		<cftry> --->
				<cfquery name="qryGetList" datasource="#variables.datasource#">
					SELECT currency_id as id, name
					FROM itgov_currency
					WHERE 1 = 1
					<cfif ARGUMENTS.currency_id neq 0>
						AND currency_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.currency_id#" />
					</cfif>
				</cfquery>
			<cfset strLocal.data = qryGetList />
<!--- 			<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Getting List of vendors failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>

</cfcomponent>