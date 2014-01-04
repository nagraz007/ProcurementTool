<cfcomponent displayname="Softwares" output="false" extends="utils">
	
	<cffunction name="init" access="public" returntype="Softwares" description="Generates an object of itself">
		<cfargument name="datasource" required="true" type="string" />
			<cfset variables.datasource = ARGUMENTS.datasource />
			<cfreturn THIS />
	</cffunction>

	<cffunction name="listSoftwares" returntype="struct" output="false" access="public"
				description="Lists Softwares for different search criterions for Search results from database">
		<cfargument name="searchFactor" type="string" required="false"   />
		<cfargument name="searchword" type="string" required="false" default=""  />
		<cfargument name="gridsortcolumn" type="string" required="false" default="" />
		<cfargument name="gridstartdirection" type="string" required="false" default="" />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
		<!--- <cftry> --->
			<cfquery name="qryGetList" datasource="#variables.datasource#">
					SELECT b.vendor_name,a.software_id, a.name as name,a.type_of_software, a.duration, a.no_of_licenses, a.durationtype,c.ins_purchaseid as inspurchaseid, 
					a.termination_notice, a.type as old_new, a.purchaseid_old,  a.noticerequirement, d.name as model, to_char(a.startdate,'DD-MON-YYYY') as startdate, to_char(a.enddate,'DD-MON-YYYY') as enddate,
					case 
								when a.isexpired = 'Y' THEN
									'<input type="button" name="theEnd"  value=" E " class="gre" onclick="act_s(1,'||a.software_id||')" title="Enable this  Software"/>' 
								WHEN a.isexpired = 'N' THEN  
									'<input type="button" name="theEnd" value=" D "  class="req" onclick="act_s(0,'||a.software_id||')"  title="Disable this Software"/>'
								END  AS button
					  FROM itgov_Softwares a,itgov_vendors b,itgov_purchases c, itgov_purchaseitems_models d, dual 
					 WHERE  a.vendor_id = b.vendor_id
					<cfif ARGUMENTS.searchword neq '' > 
						<cfif ARGUMENTS.searchword eq 'vendor_id' >
						AND upper(a.#ARGUMENTS.searchFactor#)	IN (#ARGUMENTS.searchword#)
						<cfelse>
						AND upper(a.#ARGUMENTS.searchFactor#) LIKE upper(('%#ARGUMENTS.searchword#%')) 
						</cfif>
					 </cfif>
					 	AND d.model_id = a.model_id
					 	AND a.purchase_id = c.purchase_id (+)
					<cfif ARGUMENTS.gridsortcolumn neq '' AND ARGUMENTS.gridstartdirection neq '' >
						<cfif ARGUMENTS.gridsortcolumn eq 'vendor_name'  >
									ORDER BY b.#ARGUMENTS.gridsortcolumn#  #ARGUMENTS.gridstartdirection# 
						<cfelseif  ARGUMENTS.gridsortcolumn eq 'model'>
									ORDER BY d.name  #ARGUMENTS.gridstartdirection# 
						<cfelseif  ARGUMENTS.gridsortcolumn eq 'inspurchaseid'>
									ORDER BY c.ins_purchaseid  #ARGUMENTS.gridstartdirection# 
						<cfelse>
						ORDER BY	 a.#ARGUMENTS.gridsortcolumn# #ARGUMENTS.gridstartdirection# 
						</cfif>		
					</cfif>
					 
				</cfquery>
			<cfset strLocal.data = qryGetList />
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Getting List of Softwares failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="insertsoftware" returntype="struct" output="false" access="public"
			description="Inserts a Softwrae into database">
		<cfargument name="vendor_id" type="numeric" required="true" />
		<cfargument name="name" type="string" required="true" />
		<cfargument name="duration" type="numeric" required="false" />
		<cfargument name="durationtype" type="string" required="false" />
		<cfargument name="no_of_licenses" type="numeric" required="false"  />
		<cfargument name="start_date" type="string" required="false"  />
		<cfargument name="end_date" type="string" required="false"  />
		<cfargument name="termination_notice" type="string" required="false"  />
		<cfargument name="noticerequirement" type="string" required="false" />
		<cfargument name="type_of_software" type="string" required="false" />
		<cfargument name="model_id" type="numeric" required="false" />
		<cfargument name="purchase_id" type="numeric" required="false" default="0" />
		<cfargument name="purchases_items_id" type="numeric" required="false" default="0" />
		<cfargument name="old_new" type="string" required="false" default="0" />
		<cfargument name="purchaseid_old" type="string" required="false" default="" />
		<cfargument name="createdby" type="string" required="false" />
		<cfset var strLocal = {success = true, message=""} />
	<!--- 	 <cftry>  --->
			<cfquery name="qryInsertsoftware" datasource="#variables.datasource#">
						INSERT INTO itgov_softwares ( vendor_id, name, duration, durationtype, no_of_licenses, startdate,
										 enddate, termination_notice, noticerequirement, type_of_software, model_id, purchase_id,type, purchases_items_id,
										 purchaseid_old, firstcreatedon, firstcreatedby )
						VALUES (
						<cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.vendor_id#" />,
						<cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.name#" />,
						<cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.duration#" />,
						<cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.durationtype#" />,
						<cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.no_of_licenses#" />,
						<cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.start_date#" />,
							<cfif ARGUMENTS.durationtype eq 'day'>
								to_date('#ARGUMENTS.start_date#') + #ARGUMENTS.duration#
							<cfelseif ARGUMENTS.durationtype eq 'month' >
								 add_months(TO_DATE('#ARGUMENTS.start_date#'), #ARGUMENTS.duration# ) 
							<cfelseif ARGUMENTS.durationtype eq 'year' >
								add_months(TO_DATE('#ARGUMENTS.start_date#'), #ARGUMENTS.duration#*12)-1 
							</cfif>
						,
						<cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.termination_notice#" />,
						<cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.noticerequirement#" />,
						<cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.type_of_software#" />,
						<cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.model_id#" />,
						<cfif ARGUMENTS.purchase_id neq 0 >
								<cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchase_id#" />,
							<cfelse>
								null,
							</cfif>
						<cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.old_new#" />,
							<cfif ARGUMENTS.purchases_items_id neq 0 >
								<cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchases_items_id#" />,
							<cfelse>
								null,
							</cfif>
						<cfif ARGUMENTS.purchaseid_old neq '' >
							<cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.purchaseid_old#" />,
						<cfelse>
							null,
						</cfif>
						sysdate,
						<cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.createdby#" />)
					</cfquery>
	<!--- 							<cfstoredproc procedure="ITGOV_PACK.insert_software" datasource="#VARIABLES.datasource#">
   				<cfprocparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.vendor_id#" />
   				<cfprocparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.name#" />
				<cfprocparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.duration#" />
				<cfprocparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.no_of_licenses#" />
				<cfprocparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.termination_notice#" />
				<cfprocparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.noticerequirement#" />
				<cfprocparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.start_date#" />
				<cfprocparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.end_date#" />
				<cfprocparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.type_of_software#" />
   				<cfprocparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.insertedby#" />
   				<cfprocparam cfsqltype="cf_sql_varchar" type="out" variable="procResult" />
  			</cfstoredproc> --->
			<!---  <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Inserting Type failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="updatesoftware" returntype="struct" output="false" access="public"
				description="Updates Software details into the database">
		<cfargument name="software_id" type="numeric" required="true" />
		<cfargument name="vendor_id" type="numeric" required="false" default="0" />
		<cfargument name="name" type="string" required="false" default="" />
		<cfargument name="duration" type="numeric" required="false"  default="0"/>
		<cfargument name="durationtype" type="string" required="false" default="" />
		<cfargument name="no_of_licenses" type="numeric" required="false" default="0" />
		<cfargument name="start_date" type="string" required="false" default="" />
		<cfargument name="end_date" type="string" required="false" default="" />
		<cfargument name="termination_notice" type="string" required="false" default="" />
		<cfargument name="noticerequirement" type="string" required="false" default="" />
		<cfargument name="type_of_software" type="string" required="false" default="" />
		<cfargument name="type" type="string" required="false" default="" />
		<cfargument name="purchaseid_old" type="string" required="false" default="" />
		<cfargument name="lastmodifiedby" type="numeric" required="true" />
		<cfset var strLocal = {success = true, message=""} />
		<cftry>
			<cfquery name="qryUpdatetype" datasource="#variables.datasource#">
							UPDATE itgov_softwares
							SET
								<cfif ARGUMENTS.vendor_id neq 0>
								vendor_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.vendor_id#"/>,
								</cfif>
								<cfif ARGUMENTS.name neq ''>
								name = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.name#" />,
								</cfif>
								<cfif ARGUMENTS.duration neq 0>
								duration = <cfqueryparam cfsqltype="cf_sql_time"  value="#ARGUMENTS.duration#" />,
								</cfif>
								<cfif ARGUMENTS.durationtype neq ''>
								durationtype = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.durationtype#" />,
								</cfif>
								<cfif ARGUMENTS.no_of_licenses neq 0>
								no_of_licenses = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.no_of_licenses#" />,
								</cfif>
								<cfif ARGUMENTS.start_date neq ''>
								start_date = <cfqueryparam cfsqltype="cf_sql_date"  value="#ARGUMENTS.start_date#" />,
								</cfif>
								<cfif ARGUMENTS.end_date neq ''>
								end_date = <cfqueryparam cfsqltype="cf_sql_date"  value="#ARGUMENTS.end_date#" />,
								</cfif>
								<cfif ARGUMENTS.termination_notice neq ''>
								termination_notice = <cfqueryparam cfsqltype="cf_sql_bit"  value="#ARGUMENTS.termination_notice#" />,
								</cfif>
								<cfif ARGUMENTS.noticerequirement neq ''>
								noticerequirement = <cfqueryparam cfsqltype="cf_sql_longvarchar"  value="#ARGUMENTS.noticerequirement#" />,
								</cfif>
								<cfif ARGUMENTS.type_of_software neq ''>
								type_of_software=<cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.type_of_software#" />,
								</cfif>
								<cfif ARGUMENTS.type neq ''>
								type = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.type#" />,
								</cfif>
								<cfif ARGUMENTS.purchaseid_old neq ''>
								purchaseid_old = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.purchaseid_old#" />,
								</cfif>
								lastmodifiedby = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.lastmodifiedby#" />,
					 			lastmodifiedon = sysdate
							WHERE software_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.software_id#" />
						</cfquery>
			<cfset strLocal.data = qryUpdatetype />
			<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Updating software info  failed" />
			</cfcatch>
		</cftry>
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="updateExpireAction" returntype="struct" output="false" access="public"
				description="Update expire/enable details to database">
		<cfargument name="software_id" type="numeric" required="true"/>
		<cfargument name="isexpired" type="string" required="false" default="" />
		<cfargument name="lastmodifiedby" type="numeric" required="true" />
		<cfset var strLocal = {success = true, message=""} />
		<!---  <cftry> ---> 
			<cfquery name="qryUpdateproduct" datasource="#variables.datasource#">
					<cfif ARGUMENTS.isexpired eq 'Y'>
					UPDATE itgov_softwares
					SET
						isexpired = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.isexpired#" />,
					 	lastmodifiedby = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.lastmodifiedby#" />,
					 	lastmodifiedon = sysdate,
					 	expired_date = sysdate
					 WHERE software_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.software_id#" />
					<cfelse>
					UPDATE itgov_softwares
					SET
						isexpired = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.isexpired#" />,
					 	lastmodifiedby = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.lastmodifiedby#" />,
					 	lastmodifiedon = sysdate,
					 	expired_date = null
					 WHERE software_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.software_id#" />
					</cfif>
				</cfquery>
			<!---  <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Updating Product info  failed" />
			</cfcatch>
		</cftry>  --->
		<cfreturn strLocal />
	</cffunction>
	
	<cffunction name="updatesoftwarePurchaseId" returntype="struct" output="false" access="public"
				description="Upadting purchase id for Sofwtare">
		<cfargument name="purchase_id" type="numeric" required="false" default="0" />
		<cfargument name="software_id" type="numeric" required="true" />
		<cfargument name="lastmodifiedby" type="numeric" required="true" />
		<cfset var strLocal = {success = true, message=""} />
		<cftry>
			<cfif purchase_id eq 0>
			<cfquery name="qryUpdatetype" datasource="#variables.datasource#">
							UPDATE itgov_softwares
							SET
								purchase_id = null,
								lastmodifiedby = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.lastmodifiedby#" />,
					 			lastmodifiedon = sysdate
							WHERE software_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.software_id#" />
						</cfquery>
			<cfelse>
				<cfquery name="qryUpdatetype" datasource="#variables.datasource#">
								UPDATE itgov_softwares
								SET
									purchase_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchase_id#" />,
									lastmodifiedby = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.lastmodifiedby#" />,
						 			lastmodifiedon = sysdate
								WHERE software_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.software_id#" />
							</cfquery>
			</cfif>
			<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Update failed" />
			</cfcatch>
		</cftry>
		<cfreturn strLocal />
	</cffunction>


	<!--- Functions from NandaKishore --->

    <cffunction name="swLicenseTerm" returntype="query" output="false" access="public" hint="get the software ids whose licenses will be terminated in one months from now">
				<cfquery name="qryGetList" datasource="#variables.datasource#">
					SELECT software_id, initcap(name) sname, to_char(enddate,'dd-MON-yyyy') enddate
                      FROM itgov_softwares 
                    WHERE 
                      enddate-SYSDATE <= 31  and enddate-SYSDATE >= 0
				</cfquery>
		<cfreturn qryGetList />
	</cffunction>

</cfcomponent>