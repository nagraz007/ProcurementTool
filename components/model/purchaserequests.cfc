<cfcomponent  displayname="purchaserequests" output="false" extends="utils">

	<cffunction name="init" access="public" returntype="purchaserequests" description="Generates an object of itself">
		<cfargument name="datasource" required="true" type="string" />
			<cfset variables.datasource = ARGUMENTS.datasource />
			<cfreturn THIS />
	</cffunction>	

	<cffunction name="insertreq" returntype="struct" output="false" access="public"
				description="Inserts a Purchase Request into the database">
		<cfargument name="insertedby" type="numeric" required="false" />
		<cfargument name="budgetid" type="string" required="false" />
		<cfargument name="onbehalfof" type="string" required="false" />
		<cfargument name="reason" type="string" required="false" />
		<cfargument name="incident" type="string" required="false" />
		<cfset var strLocal = {success = true, data = 0, message="Request generated succesfully."} />
		
		 <cftry> 
		<cfstoredproc procedure="ITGOV_PACK.insert_request" datasource="#VARIABLES.datasource#">
   			<cfprocparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.insertedby#" />
   			<cfprocparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.budgetid#" />
   			<cfprocparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.onbehalfof#" />
   			<cfprocparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.reason#" />
   			<cfprocparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.incident#" />
   			<cfprocparam cfsqltype="cf_sql_varchar" type="out" variable="procResult" />
  		</cfstoredproc>
		
		<cfif super.dbResultBreaker(procResult) eq 0>
			<cfthrow message="#super.dbResult(procResult).message#" type="APPLICATION" />
		<cfelse>
			<cfset strLocal.data = super.dbResultBreaker(procResult) />
		</cfif>

			<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = CFCATCH.Message />
			</cfcatch>
		</cftry>

		<cfreturn strLocal />
	</cffunction> 

	<cffunction name="listreq" returntype="struct" output="false" access="public"
				description="Lists out All Requests generated">
		<cfargument name="reqid" type="numeric" required="false" default="0">
		<cfset var strLocal = {success = true, data = '', message=""} />
		<!--- <cftry> --->
		<cfquery name="qryGetList" datasource="#variables.datasource#">
						SELECT a.request_id, a.createdon as firstcreatedon,
								 Initcap(b.firstname)||' '||upper(b.lastname) as name,  
								 (SELECT count(*) FROM itgov_request_items c where c.request_id = a.request_id) as Cnt
						  FROM itgov_purchaserequests a, itgov_users b
						 WHERE a.createdby = b.us_id
						 <cfif ARGUMENTS.reqid neq 0 > 
							 AND a.request_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.reqid#" />
						 </cfif>
							 AND a.request_status = 'Pending'	
						 	 ORDER BY a.createdon 
					</cfquery>
					
			<cfset strLocal.data = qryGetList  />
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Listing Requests failed" />
			</cfcatch>
			
		</cftry> --->
		<cfreturn strLocal >
	</cffunction>
	
	<cffunction name="listreqForGrid" returntype="struct" output="false" access="public"
				description="Lists out All Requests from database required to display in the grid">
		<cfargument name="gridsortcolumn" type="string" required="false" default="" />
		<cfargument name="gridstartdirection" type="string" required="false" default="" />
	
		<cfset var strLocal = {success = true, data = '', message=""} />
		<!--- <cftry> --->
		<cfquery name="qryGetList" datasource="#variables.datasource#">
						SELECT a.request_id, a.createdon as firstcreatedon,a.onbehalfof, 
								Initcap(b.firstname)||' '||upper(b.lastname) as name, a.request_status  
						  FROM itgov_purchaserequests a, itgov_users b
						 WHERE a.createdby = b.us_id
						<cfif ARGUMENTS.gridsortcolumn neq '' AND ARGUMENTS.gridstartdirection neq '' >
							<cfif ARGUMENTS.gridsortcolumn eq 'firstcreatedon'  >		
									ORDER BY  a.createdon #ARGUMENTS.gridstartdirection# 
							<cfelseif ARGUMENTS.gridsortcolumn eq 'request_status'>
									ORDER BY a.request_status  #ARGUMENTS.gridstartdirection# 
							<cfelseif ARGUMENTS.gridsortcolumn eq 'name'>
									ORDER BY b.firstname  #ARGUMENTS.gridstartdirection# 
						</cfif> 
				</cfif> 
					</cfquery>
					
			<cfset strLocal.data = qryGetList  />
			
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Listing Requests failed" />
			</cfcatch>
			
		</cftry> --->
		<cfreturn strLocal >
	</cffunction>

	<cffunction name="updatereq" returntype="struct" output="false" access="public"
				description="Updates teh status of the Request in database">
		<cfargument name="request_id" type="numeric" required="true"/>
		<cfargument name="request_status" type="string" required="false" default="0"/>
		<cfargument name="lastmodifiedby" type="numeric" required="true" />
		<cfset var strLocal = {success = true, message=""} />
<!--- 		<cftry> --->
			<cfquery name="qryUpdatereq" datasource="#variables.datasource#">
					UPDATE itgov_purchaserequests
					SET
						request_status = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.request_status#" />,
					 	lastmodifiedby = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.lastmodifiedby#" />,
					 	lastmodifiedon = sysdate
					 WHERE request_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.request_id#" />
				</cfquery>
	<!--- 		<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Updating Product info  failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="listreqForwindow" returntype="struct" output="false" access="public"
				description="Listing out request detals for display of the request details in the Window">
		<cfargument name="reqid" type="numeric" required="false" default="0">
		<cfset var strLocal = {success = true, data = '', message=""} />
		<!--- <cftry> --->
		<cfquery name="qryGetList" datasource="#variables.datasource#">
						SELECT a.budgetid, a.onbehalfof, a.onbereason, Initcap(b.firstname)||' '||upper(b.lastname) as name  
						  FROM itgov_purchaserequests a, itgov_users b
						 WHERE a.createdby = b.us_id
						 <cfif ARGUMENTS.reqid neq 0 > 
							 AND a.request_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.reqid#" />
						 </cfif>
					</cfquery>
					
			<cfset strLocal.data = qryGetList  />
			
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Listing Requests failed" />
			</cfcatch>
			
		</cftry> --->
		<cfreturn strLocal >
	</cffunction>

<!--- Functions from Nandakishore --->

	<cffunction name="newRequestsAlert" returntype="struct" output="false" access="public">
		<cfset var strLocal = {success = true, data = '', message=""} />
		<cftry>
		<cfquery name="qryGetList" datasource="#variables.datasource#">
			SELECT a.request_id, 
                CASE 
                    WHEN a.onbehalfof IS NULL THEN requestby 
                    ELSE a.requestby || ' (on behalf of ' || a.onbehalfof || ')' 
                    END requester ,
                    decode (a.cntofItems, 1,a.cntofItems||' item', a.cntofItems||' items') cntofitems, 
                    a.items
                FROM (
                      SELECT b.request_id, 
                      		 b.onbehalfof,
                            (SELECT InitCap(firstname)|| ' ' || InitCap(lastname) 
                               FROM itgov_users u 
                              WHERE u.us_id = b.createdby) requestby,
                            (SELECT count(*) 
                               FROM itgov_request_items r 
                              WHERE r.request_id = b.request_id) cntofItems,
                              itgov_pack.concatenate_list (CURSOR (SELECT quantity || '|' ||(select m.name 
                                                                                 FROM itgov_purchaseitems_models m 
                                                                                WHERE m.model_id = ri.model_id )
                                                              		 FROM itgov_request_items ri 
                                                             		WHERE ri.request_id = b.request_id
                                                                   ) 
                                                           ) as items
                        FROM itgov_purchaserequests b 
                       WHERE b.request_status = 'Pending'
                            ) a
					</cfquery>
					
			<cfset strLocal.data = qryGetList  />
			
			 <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Listing Requests failed" />
			</cfcatch>
			
		</cftry>
		<cfreturn strLocal >
	</cffunction>
</cfcomponent>