<cfcomponent displayname="Report_a_problem" output="false">

	<cffunction name="init" access="public" returntype="Report_a_problem">
		<cfargument name="datasource" required="true" type="string" />
			<cfset variables.datasource = ARGUMENTS.datasource />
			<cfreturn THIS />
	</cffunction>

	<cffunction name="listproblems" returntype="struct" output="false" access="public">
		<cfargument name="report_id" type="numeric" required="false" default="0"  />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
		<cftry>
			<cfquery name="qryGetList" datasource="#variables.datasource#">
					SELECT report_id, us_id, subject, message, time
					  FROM Report_a_problem
					 WHERE 1 = 1
					 <cfif ARGUMENTS.us_id neq 0 > 
					 AND  report_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.report_id#" /> 
					 </cfif>
					 
				</cfquery>
			<cfset strLocal.data = qryGetList />
			<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Getting List of Report_Problems failed" />
			</cfcatch>
		</cftry>
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="insertproblems" returntype="struct" output="false" access="public">
		<cfargument name="us_id" type="numeric" required="true" />
		<cfargument name="subject" type="string" required="true" />
		<cfargument name="message" type="string" required="false" default="" />
		<cfargument name="time" type="date" required="true" /> 
		<cfset var strLocal = {success = true, message=""} />
		<cftry>
			<cfquery name="qryInsertproblem" datasource="#variables.datasource#">
					INSERT INTO Report_a_problem (us_id, subject, message, time)
					VALUES (<cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.us_id#" />,
					<cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.subject#" />,
					<cfqueryparam cfsqltype="cf_sql_longvarchar"  value="#ARGUMENTS.message#" />,
					<cfqueryparam cfsqltype="cf_sql_timestamp"  value="#ARGUMENTS.time#" />)
				
				</cfquery>
			<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Inserting Reported problem failed" />
			</cfcatch>
		</cftry>
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="deleteproblems" returntype="struct" output="false" access="public">
	<cfargument name="report_id" type="numeric" required="true" />
	<cfset var strLocal = {success = true, message=""} />
	<cftry>
		<cfquery name="qryDeleteproblem" datasource="#variables.datasource#" >
					DELETE FROM Report_a_problem
					WHERE report_id =  <cfqueryparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.report_id#">
				</cfquery>
		<cfcatch type="any">
			<cfset strLocal.success="false"/>
			<cfset strLocal.message="Deleting Reported Problem failed">
		</cfcatch>
	</cftry>
	<cfreturn strLocal />
	</cffunction>
</cfcomponent>