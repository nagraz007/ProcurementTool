<cfcomponent displayname="PrdUsrHistory" output="false" extends="utils">

	<cffunction name="init" access="public" returntype="PrdUsrHistory" description="Generates an object of itself">
		<cfargument name="datasource" required="true" type="string" />
			<cfset variables.datasource = ARGUMENTS.datasource />
			<cfreturn THIS />
	</cffunction>
	
	<cffunction name="listmap_assets" returntype="struct" output="false" access="public"
				description="Accessing the database and Lists out all mappings">
		<cfargument name="asset_id" type="numeric" required="false" default="0"  />
		<cfargument name="product_id" type="numeric" required="false" default="0"  />
		<cfargument name="us_id" type="numeric" required="false" default="0"  />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
	 <cftry>  
			<cfquery name="qryGetList" datasource="#variables.datasource#" >
					SELECT *
					  FROM itgov_PrdUsrHistory
					 WHERE 1 = 1
					 <cfif ARGUMENTS.asset_id neq 0 > 
					 AND  asset_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.asset_id#" /> 
					 </cfif>
					 <cfif ARGUMENTS.product_id neq 0 > 
					 AND  product_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.product_id#" /> 
					 </cfif>
					 <cfif ARGUMENTS.us_id neq 0 > 
					 AND  us_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.us_id#" /> 
					 </cfif>
					 
				</cfquery>
			<cfset strLocal.data = qryGetList />
 		<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Getting List of Asset Mapping with users failed" />
			</cfcatch>
		</cftry>
		<cfreturn strLocal />
	</cffunction>
	
	<cffunction name="insertprd_hist" returntype="struct" output="false" access="public"
				description="Inserts a mapping of products into teh database">
		<cfargument name="us_id" type="numeric" required="true" />
		<cfargument name="product_id" type="numeric" required="true"  />
		<cfargument name="startdate" type="string" required="true" />
		<cfargument name="enddate" type="string" required="true" default="" />
		<cfargument name="insertedby" type="string" required="true" />
		<cfset var strLocal = {success = true, message=""} />
			<cfquery name="qryInsertmap" datasource="#variables.datasource#">
						INSERT INTO itgov_PrdUsrHistory( us_id, product_id, startdate, enddate, firstcreatedon, firstcreatedby )
						VALUES (
						<cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.us_id#" />,
						<cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.product_id#" />,
						<cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.startdate#" />,
						<cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.enddate#" />,
						sysdate,
						<cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.insertedby#" />)
					</cfquery>
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="updatemapEnddate" returntype="struct" output="false" access="public"
				description="Updates the Enddate in a Mapping">
		<cfargument name="asset_id" type="numeric" required="true" />
		<cfargument name="lastmodifiedby" type="numeric" required="true" />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
	<!---   <cftry>  ---> 
			<cfquery name="qryGetList" datasource="#variables.datasource#" >
					UPDATE itgov_PrdUsrHistory
					SET enddate = sysdate,
						lastmodifiedby = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.lastmodifiedby#" />,
						lastmodifiedon = sysdate
					WHERE asset_id =   <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.asset_id#" />	 			 
				</cfquery>
			
	<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Update Failed" />
			</cfcatch>
		</cftry>  --->
		<cfreturn strLocal />
		
	</cffunction>

	<cffunction name="updateEnddateDecom" access="public" returntype="struct" output="false"
				description="Updates end date of mapping while decomissioning">
		<cfargument name="product_id" type="numeric" required="true"/>
		<cfargument name="decom" type="string" required="false" default="" />
		<cfargument name="lastmodifiedby" type="numeric" required="true" />
			<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
		<!---   <cftry>  ---> 
				<cfquery name="qryGetList" datasource="#variables.datasource#" >
					<cfif ARGUMENTS.decom eq 'Y'>
						UPDATE itgov_PrdUsrHistory
						SET 
							enddate = sysdate,
							lastmodifiedby = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.lastmodifiedby#" />,
							lastmodifiedon = sysdate
						WHERE asset_id =   (SELECT MAX(asset_id) 
											FROM itgov_PrdUsrHistory 
											WHERE product_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.product_id#" />
											)
						<cfelseif ARGUMENTS.decom eq 'N'>
							UPDATE itgov_PrdUsrHistory 
							SET enddate = null ,
							lastmodifiedby = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.lastmodifiedby#" />,
							lastmodifiedon = sysdate
							WHERE asset_id = (SELECT MAX(asset_id) 
											FROM itgov_PrdUsrHistory 
											WHERE product_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.product_id#" />
											)
						</cfif>
					</cfquery>
	<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Update failed" />
			</cfcatch>
		</cftry>  --->
		<cfreturn strLocal />
	</cffunction>
	
</cfcomponent>