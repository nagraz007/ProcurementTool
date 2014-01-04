<cfcomponent displayname="Feedback" output="false">

	<cffunction name="init" access="public" returntype="Feedback" description="Generates an object of itself">
		<cfargument name="datasource" required="true" type="string" />
			<cfset variables.datasource = ARGUMENTS.datasource />
			<cfreturn THIS />
	</cffunction>
	
	<cffunction name="listResponses" returntype="struct" output="false" access="public"
				description="Accesses the data base and lists out responses of Users">  <!--- Updated by Naga Raju --->
		<cfargument name="gridsortcolumn" type="string" required="true" />
		<cfargument name="gridstartdirection" type="string" required="true" />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
<!--- 		<cftry> --->
				<cfquery name="qryGetList" datasource="#variables.datasource#">
					SELECT a.q1||' ' q1, a.q2||' ' q2, a.q3||' ' q3, 
							a.reason, 
							a.time,
							b.ins_purchaseid as purchaseid, 
							Initcap(c.firstname)||' '||upper(c.lastname) as name 
					FROM itgov_feedback a, itgov_purchases b, itgov_users c
                    WHERE a.purchase_id = b.purchase_id AND
					a.us_id = c.us_id
                    <cfif ARGUMENTS.gridsortcolumn neq '' AND ARGUMENTS.gridstartdirection neq '' >
							<cfif ARGUMENTS.gridsortcolumn eq 'purchaseid' >
							ORDER BY b.ins_purchaseid  #ARGUMENTS.gridstartdirection# 
							<cfelseif ARGUMENTS.gridsortcolumn eq 'name' >
							ORDER BY c.firstname  #ARGUMENTS.gridstartdirection# 
							<cfelse>
							ORDER BY a.#ARGUMENTS.gridsortcolumn#  #ARGUMENTS.gridstartdirection#
							</cfif>
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
	
	<cffunction name="insertfeedback" returntype="struct" output="false" access="public"
			description="Inserting Feedback into the database">
		<cfargument name="purchase_id" type="numeric" required="true">
		<cfargument name="q1" type="string" required="false">
		<cfargument name="q2" type="string" required="false">
		<cfargument name="q3" type="string" required="false">
		<cfargument name="reason" type="string" required="false">
		<cfargument name="us_id" type="numeric" required="false">
		<cfset var strLocal = {success = true, message=""} />
		<!--- <cftry>  --->
			<cfquery name="qryUpdatepurchase" datasource="#variables.datasource#">
					INSERT INTO itgov_feedback (us_id, purchase_id, q1, q2, q3, reason, time )
					VALUES (
						<cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.us_id#" />,
						<cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchase_id#" />,
						<cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.q1#" />,
						<cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.q2#" />,
						<cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.q3#" />,
						<cfqueryparam cfsqltype="cf_sql_varchar"  value="#trim(ARGUMENTS.reason)#" />,
						sysdate)
				</cfquery>
			 <!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Inserting FeedBack failed" />
			</cfcatch>
		</cftry>   --->
		<cfreturn strLocal >
	</cffunction>

</cfcomponent>