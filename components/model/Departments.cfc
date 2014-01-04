<cfcomponent displayname="Departments" output="false" extends="utils">

	<cffunction name="init" access="public" returntype="Departments" description="Generates an object of itself">
		<cfargument name="datasource" required="true" type="string" />
			<cfset variables.datasource = ARGUMENTS.datasource />
			<cfreturn THIS />
	</cffunction>

	<!--- Functions from Nandakishore --->

	<cffunction name="listdepartments" returntype="struct" output="false" access="public">
		<cfargument name="gridsortcolumn" type="string" required="false" default="" />
		<cfargument name="gridsortdirection" type="string" required="false" default="" />
        <cfargument name="depart_id" type="numeric" required="false" default="0"  />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
		<cftry>
			<cfquery name="qryGetList" datasource="#variables.datasource#">
							SELECT name, depart_id 
							FROM itgov_departments 
							WHERE 1 = 1 
								<cfif ARGUMENTS.depart_id neq 0 >
								AND depart_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.depart_id#" /> 
								</cfif>
								<cfif ARGUMENTS.gridsortcolumn neq '' AND ARGUMENTS.gridsortdirection neq '' >
								ORDER BY #ARGUMENTS.gridsortcolumn# #ARGUMENTS.gridsortdirection# 
								</cfif>
			</cfquery>
			<cfset strLocal.data = qryGetList />
			<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Getting List of Departments failed" />
			</cfcatch>
		</cftry>
		<cfreturn strLocal />
	</cffunction>
	
	<cffunction name="insertdepartment" returntype="struct" output="false" access="public">
		<cfargument name="deptname" type="string" required="true" />
        <cfargument name="creationDate" type="date" required="false"  />
        <cfargument name="createdBy" type="string" required="false"  />
		<cfset var strLocal = {success = true, message=""} />
		<!--- <cftry> --->
			<cfquery name="qryInsertdepart" datasource="#variables.datasource#">
						INSERT INTO itgov_departments (name, firstcreatedon, firstcreatedby)
						VALUES (
                        		<cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.deptname#" />
                              , <cfqueryparam cfsqltype="cf_sql_date"  value="#ARGUMENTS.creationDate#" />
                        	  , <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.createdBy#" />
                        	  )
				</cfquery>
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Inserting Department failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="updatedepartment" returntype="struct" output="false" access="public">
		<cfargument name="depart_id" type="numeric" required="true" />
		<cfargument name="name" type="string" required="true" />
        <cfargument name="lastmodifiedby" type="numeric" required="true" />
		<cfargument name="lastmodifiedon" type="string" required="true"  />
		<cfset var strLocal = {success = true, message=""} />
		<!--- <cftry> --->
			<cfquery name="qryUpdatedepart" datasource="#variables.datasource#">
						UPDATE itgov_departments
						SET
							name = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.name#" />,
                            lastmodifiedby = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.lastmodifiedby#" />,
					 		lastmodifiedon = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.lastmodifiedon#" />
						 WHERE depart_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.depart_id#" />
					</cfquery>
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Updating Department failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="deletedepartment" returntype="struct" output="false" access="public">
		<cfargument name="depart_id" type="numeric" required="true" />
		<cfset var strLocal = {success = true, message=""} />
		<cftry>
			<cfquery name="qryDeletedepart" datasource="#variables.datasource#" >
					DELETE FROM itgov_departments
					WHERE depart_id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.depart_id#">
				</cfquery>
			<cfcatch type="any">
				<cfset strLocal.success="false"/>
				<cfset strLocal.message="Deleting Department failed">
			</cfcatch>
		</cftry>
		<cfreturn strLocal />
	</cffunction>
    
    <cffunction name="CheckDeptName" access="remote" returnformat="json" output="false">
        <cfargument name="DeptName" required="true">
		<cfset var qryGetDeptName = "" />
        <cfquery name="qryGetDeptName" datasource="#variables.datasource#">
        	SELECT DEPART_ID 
              FROM itgov_departments
             WHERE lower(name) = lower(<cfqueryparam value="#arguments.DeptName#" cfsqltype="cf_sql_varchar" />)
        </cfquery>	
        <cfreturn yesNoFormat(qryGetDeptName.recordCount)/>
    </cffunction>

	<cffunction name="listDepartmentsForListing" returntype="struct" output="false" access="public"> <!--- Added by Naga Raju BHANOORI from Users Model  --->
    	<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
		<cftry>
			<cfquery name="qryGetList" datasource="#variables.datasource#">
                SELECT depart_id, name 
				  FROM itgov_departments  
				  ORDER BY depart_id ASC
			</cfquery>
			<cfset strLocal.data = qryGetList />
			<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Getting List of users failed" />
			</cfcatch>
		</cftry>
		<cfreturn strLocal />        
    </cffunction>
	    
    <cffunction name="getDeptID" access="remote" returntype="numeric" output="false"> <!--- Added by Naga Raju BHANOORI from Users Model  --->
        <cfargument name="deptname" required="true">
		<cfset var qryGetDeptID = "" />
        <cfquery name="qryDeptID" datasource="#variables.datasource#">
        	SELECT DEPART_ID
              FROM itgov_departments 
             WHERE name = <cfqueryparam value="#arguments.deptname#" cfsqltype="cf_sql_varchar" />
        </cfquery>	
        <cfreturn qryDeptID.DEPART_ID/>
    </cffunction>
</cfcomponent>