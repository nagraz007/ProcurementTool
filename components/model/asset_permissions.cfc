<cfcomponent displayname="asset_permissions" output="false" extends="utils">

	<cffunction name="init" access="public" returntype="asset_permissions" description="Generates an object of itself">
		<cfargument name="datasource" required="true" type="string" />
		<cfset variables.datasource = ARGUMENTS.datasource />
		<cfreturn THIS />
	</cffunction>

	<cffunction name="listpermissions" returntype="struct" output="false" access="public" 
				description=" Accesses Database and Lists Asset permissions">
		<cfargument name="assetaccess_id" type="numeric" required="false" default="0"  />
		<cfargument name="role" type="string" required="false" default=""  />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
<!--- 		<cftry> --->
			<cfquery name="qryGetList" datasource="#variables.datasource#">
						SELECT role, permission, assetaccess_id as id
						  FROM itgov_asset_permissions
						 WHERE 1=1
						 <cfif ARGUMENTS.assetaccess_id neq 0 > 
						 AND  assetaccess_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.assetaccess_id#" /> 
						 </cfif>
						 <cfif ARGUMENTS.role neq '' > 
						 AND  role = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.role#" /> 
						 </cfif>
						 ORDER BY assetaccess_id
						 
				</cfquery>
			<cfset strLocal.data = qryGetList />
		<!--- 	<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Getting List failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>

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
				description="Insert a particular Role and permission to the DataBase">
		<cfargument name="role" type="string" required="true" />
		<cfargument name="permission" type="numeric" required="true" />
		<cfargument name="firstcreatedby" type="numeric" required="true" />
		<cfset var strLocal = {success = true, message=""} />
		<!--- <cftry> --->
			<cfquery name="qryInsertrole" datasource="#variables.datasource#">
					INSERT INTO itgov_asset_permissions (role,permission,firstcreatedby,firstcreatedon)
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

	<cffunction name="deletepermission" returntype="struct" output="false" access="public"
				description="Deletes a partiucular Role from DataBase ">
		<cfargument name="assetaccess_id" type="numeric" required="true" />
		<cfset var strLocal = {success = true, message=""} />
		<cftry>
			<cfquery name="qryDeleterole" datasource="#variables.datasource#" >
					DELETE FROM itgov_asset_permissions
					WHERE assetaccess_id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.assetacces_id#">
				</cfquery>
			<cfcatch type="any">
				<cfset strLocal.success="false"/>
				<cfset strLocal.message="Deleting Role failed">
			</cfcatch>
		</cftry>
		<cfreturn strLocal />
	</cffunction>

</cfcomponent>