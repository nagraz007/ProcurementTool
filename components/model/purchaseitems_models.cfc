<cfcomponent displayname="purchaseitems_models" output="false">

	<cffunction name="init" access="public" returntype="purchaseitems_models"  description="Generates an object of itself">
		<cfargument name="datasource" required="true" type="string" />
			<cfset variables.datasource = ARGUMENTS.datasource />
			<cfreturn THIS />
	</cffunction>

	<cffunction name="listmodels" returntype="struct" output="false" access="public"
				description="Lists out All Models from database">
		<cfargument name="purchasetype_id" type="numeric" required="true"   />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
<!--- 		<cftry> --->
				<cfquery name="qryGetList" datasource="#variables.datasource#">
							<!--- SELECT 0 as model_id, '--Select one--' as name
							FROM DUAL
							UNION --->
							SELECT model_id as id, name 
							  FROM itgov_purchaseitems_models 
							 WHERE purchasetype_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchasetype_id#" />
					</cfquery>
					
			<cfset strLocal.data = qryGetList  />
<!--- 			<cfcatch type="any">
					
				<cfset strLocal.success =  false />
				<cfset strLocal.message = 'fetching results failed' />
			</cfcatch>
		</cftry >--->
		<cfreturn strLocal />
	</cffunction>
	
	<cffunction name="listmodelsforId" returntype="struct" output="false" access="public"
				description="Lists out All Model ids' from database">
		<cfargument name="name" type="string" required="true"   />
		<cfargument name="purchasetype_id" type="numeric" required="true"   />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
<!--- 		<cftry> --->
				<cfquery name="qryGetList" datasource="#variables.datasource#">
							SELECT model_id as id 
							  FROM itgov_purchaseitems_models 
							 WHERE name = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.name#" />
							 AND purchasetype_id  = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchasetype_id#" />
					</cfquery>
					
			<cfset strLocal.data = qryGetList  />
<!--- 			<cfcatch type="any">
					
				<cfset strLocal.success =  false />
				<cfset strLocal.message = 'fetching results failed' />
			</cfcatch>
		</cftry >--->
		<cfreturn strLocal />
	</cffunction>
	
	<!--- Functions from NandaKishore --->

 	<cffunction name="CheckModelName" access="remote" returnformat="json" output="false">
        <cfargument name="modelname" required="true">
		<cfset var qryModelNames = "" />
        <cfquery name="qryModelNames" datasource="#variables.datasource#">
        	SELECT MODEL_ID 
              FROM ITGOV_PURCHASEITEMS_MODELS 
             WHERE lower(NAME ) = lower(<cfqueryparam value="#arguments.modelname#" cfsqltype="cf_sql_varchar" />)
        </cfquery>	
        <cfreturn yesNoFormat(qryModelNames.recordCount)/>
    </cffunction>
    
    <cffunction name="insertModel" returntype="struct" output="false" access="public">
		<cfargument name="name" type="string" required="true" />
        <cfargument name="typeID" type="numeric" required="true" />
        <cfargument name="creationDate" type="date" required="true"  />
        <cfargument name="createdBy" type="string" required="true"  />
		<cfset var strLocal = {success = true, message = ""} />
			<cfquery name="qryInsertrole" datasource="#variables.datasource#">
				INSERT INTO ITGOV_PURCHASEITEMS_MODELS (name,purchasetype_id,firstcreatedon,firstcreatedby) 
				VALUES ( 
					<cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.name#" />
                    ,<cfqueryparam cfsqltype="cf_sql_integer"  value="#ARGUMENTS.typeID#" />
                    ,<cfqueryparam cfsqltype="cf_sql_date"  value="#ARGUMENTS.creationDate#" />
                    ,<cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.createdBy#" /> 
						) 
			</cfquery>
		<cfreturn strLocal />
	</cffunction>
	
    <cffunction name="ListModelsForGrid" returntype="struct" output="false" access="public">
		<cfargument name="gridsortcolumn" type="string" required="true" />
		<cfargument name="gridstartdirection" type="string" required="true" />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
				<cfquery name="qryGetList" datasource="#variables.datasource#">
					SELECT a.MODEL_ID, a.PURCHASETYPE_ID, 
                    	   a.NAME MODEL_NAME, b.name TYPE_NAME
                    FROM ITGOV_PURCHASEITEMS_MODELS a, ITGOV_PURCHASE_ITEMS_TYPE b
                    WHERE 
                    	a.PURCHASETYPE_ID = b.PURCHASETYPE_ID
                    <cfif ARGUMENTS.gridsortcolumn neq '' AND ARGUMENTS.gridstartdirection neq '' >
						ORDER BY #ARGUMENTS.gridsortcolumn#  #ARGUMENTS.gridstartdirection# 
					</cfif>
				</cfquery>
			<cfset strLocal.data = qryGetList />
		<cfreturn strLocal />
	</cffunction>	

    <cffunction name="updateItemModel" returntype="struct" output="false" access="public">
		<cfargument name="MODEL_ID" type="numeric" required="true" />
		<cfargument name="NAME" type="string" required="true" />
        <cfargument name="lastmodifiedby" type="string" required="true" />
		<cfargument name="lastmodifiedon" type="string" required="true"  />
		<cfset var strLocal = {success = true, message=""} />
		<!--- <cftry> --->
			<cfquery name="qryUpdatedepart" datasource="#variables.datasource#">
						UPDATE ITGOV_PURCHASEITEMS_MODELS
						SET
							NAME = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.NAME#" />,
                            lastmodifiedby = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.lastmodifiedby#" />,
					 		lastmodifiedon = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.lastmodifiedon#" />
						 WHERE MODEL_ID = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.MODEL_ID#" />
					</cfquery>
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Updating Department failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>
</cfcomponent>