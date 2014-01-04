<cfcomponent displayname="purchase_permissions" output="false" extends="utils">

	<cffunction name="init" access="public" returntype="purchase_permissions"  description="Generates an object of itself">
		<cfargument name="datasource" required="true" type="string" />
		<cfset variables.datasource = ARGUMENTS.datasource />
		<cfreturn THIS />
	</cffunction>

	<cffunction name="listpermissions" returntype="struct" output="false" access="public"
			 description="Lists out Purchase Roles and Permissions from database">
		<cfargument name="purchaseaccess_id" type="numeric" required="false" default="0"  />
		<cfargument name="role" type="string" required="false" default=""  />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
<!--- 		<cftry> --->
			<cfquery name="qryGetList" datasource="#variables.datasource#">
						SELECT role, permission, purchaseaccess_id as id
						  FROM itgov_purchase_permissions
						 WHERE 1=1
						 <cfif ARGUMENTS.purchaseaccess_id neq 0 > 
						 AND  purchaseaccess_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchaseaccess_id#" /> 
						 </cfif>
						 <cfif ARGUMENTS.role neq '' > 
						 AND  role = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.role#" /> 
						 </cfif>
						 ORDER BY purchaseaccess_id
						 
				</cfquery>
			<cfset strLocal.data = qryGetList />
		<!--- 	<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Getting List failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>>

	<!--- <cffunction name="listpermissions_togrid" access="remote" output="false">
		<cfargument name="page" />
		<cfargument name="pageSize" type="numeric" />
		<cfargument name="gridsortcolumn" type="string" />
		<cfargument name="gridstartdirection" type="string" />
		<cfset var gotData = listpermissions({gridsortcolumn = ARGUMENTS.gridsortcolumn , gridstartdirection = ARGUMENTS.gridstartdirection}) />
		<cfif gotData.success>
			<cfreturn QueryConvertForGrid(gotData.data, page, pageSize) />
		<cfelse>
			<cfreturn QueryConvertForGrid(SUPER.QryObjCreator("#gotData.message# as role , '' as permission"), page, pageSize) />
		</cfif>
	</cffunction> --->

	<cffunction name="insertpermission" returntype="struct" output="false" access="public"
				description="Inserts a Purchase Permission into the database">
		<cfargument name="role" type="string" required="true" />
		<cfargument name="permission" type="numeric" required="true" />
		<cfargument name="firstcreatedby" type="numeric" required="true" />
		<cfset var strLocal = {success = true, message=""} />
		<!--- <cftry> --->
			<cfquery name="qryInsertrole" datasource="#variables.datasource#">
					INSERT INTO itgov_purchase_permissions (role,permission,firstcreatedby,firstcreatedon)
					VALUES (	<cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.role#" />
							,<cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.permission#" />
							,<cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.firstcreatedby#" />
							,sysdate
							)
				</cfquery>
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Inserting Role failed" />
			</cfcatch>
		</cftry --->>
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="updatepermission" returntype="struct" output="false" access="public"
				description="Updates a Purcahse permission">
		<cfargument name="purchaseaccess_id" type="numeric" required="true" />
		<cfargument name="role" type="string" required="true" />
		<cfargument name="permission" type="numeric" required="true" />
		<cfset var strLocal = {success = true, message=""} />
		<cftry>
			<cfquery name="qryUpdaterole" datasource="#variables.datasource#">
					UPDATE itgov_purchase_permissions
					SET
						  role = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.role#" />
						, permission = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.permission#" />
					 WHERE 
					 		purchaseaccess_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchaseaccess_id#" />
				</cfquery>
			<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Updating Role failed" />
			</cfcatch>
		</cftry>
		<cfreturn strLocal />
	</cffunction>

</cfcomponent>