<cfcomponent displayname="purchase_items_type" output="false" extends="utils">
	
	<cffunction name="init" access="public" returntype="purchase_items_type"  description="Generates an object of itself">
		<cfargument name="datasource" required="true" type="string" />
		<cfset variables.datasource = ARGUMENTS.datasource />
		<cfreturn THIS />
	</cffunction>

	<cffunction name="listitems" returntype="struct" output="false" access="public" description="Liss out all Types from database">
		<cfargument name="purchasetype_id" type="numeric" required="false" default="0"  />

		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />

		<!--- <cftry> --->
			<cfquery name="qryGetList" datasource="#variables.datasource#">
				SELECT 0 as id, '--Select One--' as name
				  FROM DUAL
				 UNION
				SELECT purchasetype_id as id, name
				FROM itgov_purchase_items_type 
				WHERE 1 = 1 
					<cfif ARGUMENTS.purchasetype_id neq 0 >
					AND purchasetype_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchasetype_id#" />
					</cfif>
			</cfquery>
			
			<cfset strLocal.data = qryGetList />
			
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Getting List failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>
	
	<cffunction name="listitemsforId" returntype="struct" output="false" access="public"
				description="Lists out All type Id's' from database">
		<cfargument name="name" type="string" required="false" default=""  />

		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />

		<!--- <cftry> --->
			<cfquery name="qryGetList" datasource="#variables.datasource#">
				
				SELECT purchasetype_id as id
				FROM itgov_purchase_items_type 
				WHERE 1 = 1 
					<cfif ARGUMENTS.name neq '' >
					AND name = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.name#" />
					</cfif>
			</cfquery>
			
			<cfset strLocal.data = qryGetList />
			
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Getting List failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>

<!--- Functions from NandaKishore --->
		
    <cffunction name="ListPurchtypes" returntype="struct" output="false" access="public">
		<cfargument name="gridsortcolumn" type="string" required="true" />
		<cfargument name="gridstartdirection" type="string" required="true" />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
				<cfquery name="qryGetList" datasource="#variables.datasource#">
					SELECT purchasetype_id, name 
                    FROM itgov_purchase_items_type
                    <cfif ARGUMENTS.gridsortcolumn neq '' AND ARGUMENTS.gridstartdirection neq '' >
						ORDER BY #ARGUMENTS.gridsortcolumn#  #ARGUMENTS.gridstartdirection# 
					</cfif>
				</cfquery>
			<cfset strLocal.data = qryGetList />
		<cfreturn strLocal />
	</cffunction>	
    
    <cffunction name="CheckPurchType" access="remote" returnformat="json" output="false">
        <cfargument name="typename" required="true">
		<cfset var qryPurchType = "" />
        <cfquery name="qryPurchType" datasource="#variables.datasource#">
        	SELECT PURCHASETYPE_ID 
              FROM ITGOV_PURCHASE_ITEMS_TYPE 
             WHERE lower(NAME ) = lower(<cfqueryparam value="#arguments.typename#" cfsqltype="cf_sql_varchar" />)
        </cfquery>	
        <cfreturn yesNoFormat(qryPurchType.recordCount)/>
    </cffunction>
	
	<cffunction name="inserttype" returntype="struct" output="false" access="public">
		<cfargument name="name" type="string" required="true" />
        <cfargument name="creationDate" type="date" required="true"  />
        <cfargument name="createdBy" type="string" required="true"  />
		<cfset var strLocal = {success = true, message = ""} />
		<!--- <cftry> --->
			<cfquery name="qryInsertrole" datasource="#variables.datasource#">
				INSERT INTO itgov_purchase_items_type (name,firstcreatedon,firstcreatedby) 
				VALUES ( 
					<cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.name#" />
                    ,<cfqueryparam cfsqltype="cf_sql_date"  value="#ARGUMENTS.creationDate#" />
                    ,<cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.createdBy#" /> 
						) 
			</cfquery>
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Inserting Type failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>

    <cffunction name="updatePurchaseType" returntype="struct" output="false" access="public">
		<cfargument name="PURCHASETYPE_ID" type="numeric" required="true" />
		<cfargument name="NAME" type="string" required="true" />
        <cfargument name="lastmodifiedby" type="string" required="true" />
		<cfargument name="lastmodifiedon" type="string" required="true"  />
		<cfset var strLocal = {success = true, message=""} />
		<!--- <cftry> --->
			<cfquery name="qryUpdatedepart" datasource="#variables.datasource#">
						UPDATE itgov_purchase_items_type
						SET
							name = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.NAME#" />,
                            lastmodifiedby = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.lastmodifiedby#" />,
					 		lastmodifiedon = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.lastmodifiedon#" />
						 WHERE PURCHASETYPE_ID = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.PURCHASETYPE_ID#" />
					</cfquery>
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Updating Department failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>

</cfcomponent>