<cfcomponent displayname="asset_items_type" extends="utils" output="false"  >


	<cffunction name="init" access="public" returntype="asset_items_type">
		<cfargument name="datasource" required="true" type="string" />
		<cfset variables.datasource = ARGUMENTS.datasource />
		<cfreturn THIS />
	</cffunction>

	<cffunction name="listitems" returntype="struct" output="false" access="public">
		<cfargument name="assettype_id" type="numeric" required="false" default="0"  />
		<cfargument name="gridsortcolumn" type="string" required="false" default="" />
		<cfargument name="gridstartdirection" type="string" required="false" default="" />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
		<cftry>
			<cfquery name="qryGetList" datasource="#variables.datasource#">
				SELECT name , description FROM itgov_asset_items_type WHERE 1 = 1 
				<cfif ARGUMENTS.assettype_id neq 0 >
					AND assettype_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.assettype_id#" />
				</cfif>
				<cfif ARGUMENTS.gridsortcolumn neq '' AND ARGUMENTS.gridstartdirection neq '' >
					ORDER BY #ARGUMENTS.gridsortcolumn# #ARGUMENTS.gridsortdirection# 
				</cfif>
			</cfquery>
			<cfset strLocal.data = qryGetList />
			<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Getting List failed" />
			</cfcatch>
		</cftry>
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="listitems_togrid" access="remote" output="false">
		<cfargument name="page" />
		<cfargument name="pageSize" type="numeric" />
		<cfargument name="gridsortcolumn" type="string" />
		<cfargument name="gridstartdirection" type="string" />
		<cfset var gotData = listitems({gridsortcolumn = ARGUMENTS.gridsortcolumn , gridstartdirection = ARGUMENTS.gridstartdirection}) />
			<cfif gotData.success>
			<cfreturn QueryConvertForGrid(gotData.data, page, pageSize) />
		<cfelse>
			<cfreturn QueryConvertForGrid(SUPER.QryObjCreator("#gotData.message# as name , '' as description"), page, pageSize) />
		</cfif>
	</cffunction>

	<cffunction name="inserttype" returntype="struct" output="false" access="public">
		<cfargument name="name" type="string" required="true" />
		<cfargument name="description" type="string" required="false"  />
		<cfset var strLocal = {success = true, message = ""} />
		<cftry>
			<cfquery name="qryInsertrole" datasource="#variables.datasource#">
				INSERT INTO itgov_asset_items_type (name, description) VALUES ( 
				<cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.role#" />
				, #preserveSingleQuotes(ARGUMENTS.description)# ) 
			</cfquery>
			<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Inserting Type failed" />
			</cfcatch>
		</cftry>
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="updatetype" returntype="struct" output="false" access="public">
		<cfargument name="assettype_id" type="numeric" required="true" />
		<cfargument name="name" type="string" required="true" />
		<cfargument name="description" type="string" required="false" />
		<cfset var strLocal = {success = true, message = ""} />
		<cftry>
			<cfquery name="qryUpdatetype" datasource="#variables.datasource#">
				UPDATE itgov_asset_items_type SET
				 name =	<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.name#" />
				,description = <cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.description#" />
				WHERE 
				assettype_id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.assettype_id#" />
			</cfquery>
			<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Updating Type failed" />
			</cfcatch>
		</cftry>
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="deletetype" returntype="struct" output="false" access="public">
		<cfargument name="assettype_id" type="numeric" required="true" />
		<cfset var strLocal = {success = true, message = ""} />
		<cftry>
			<cfquery name="qryDeletetype" datasource="#variables.datasource#" >
				DELETE FROM itgov_asset_items_type WHERE
				assettype_id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.assettype_id#">
			</cfquery>
			<cfcatch type="any">
				<cfset strLocal.success="false" />
				<cfset strLocal.message="Deleting Type failed" />
			</cfcatch>
		</cftry>
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="doNothing" returntype="void" output="false" access="public">
	</cffunction>
</cfcomponent>
