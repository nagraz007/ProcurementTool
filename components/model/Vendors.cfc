<cfcomponent displayname="Vendors" output="false">


	<cffunction name="init" access="public" returntype="Vendors" description="Generates an object of itself">
		<cfargument name="datasource" required="true" type="string" />
		<cfset variables.datasource = ARGUMENTS.datasource />
		<cfreturn THIS />
	</cffunction>

	<cffunction name="listvendors" returntype="struct" output="false" access="public"
				description="Lists out vendors and ids' with having either of them from database">
		<cfargument name="vendor_id" type="numeric" required="false" default="0"  /> 
		<cfargument name="name" type="string" required="false" default=""  />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
<!--- 		<cftry> --->
				<cfquery name="qryGetList" datasource="#variables.datasource#">
					SELECT *
					FROM itgov_vendors
					WHERE 1 = 1
					<cfif ARGUMENTS.vendor_id neq 0>
						AND vendor_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.vendor_id#" />
					</cfif>
					<cfif ARGUMENTS.name neq ''>
						 AND vendor_name = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.name#" />
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

	<cffunction name="autosuggest" access="remote" returntype="array" description="Autosuggests vendor name from database">
		<cfargument name="search" type="any" required="false" default="">
		<cfset var result=ArrayNew(1)>
		<cfif not structKeyExists(variables,"datasource")>
				<cfset variables.datasource = APPLICATION.dsn_operEvents />
		</cfif>
		<cfquery name="qryGetList" datasource="#variables.datasource#">
					SELECT  vendor_name
					FROM itgov_vendors
					WHERE 
					upper(vendor_name) LIKE upper('#ARGUMENTS.search#%')
					ORDER BY vendor_name
				</cfquery>
		<cfloop query="qryGetList">
			<cfset ArrayAppend(result, vendor_name)>
		</cfloop>		
		<cfreturn result>
	</cffunction>
	
	<cffunction name="autovendor" access="remote" returntype="query"  description="Autosuggests vendor id from database">
		<cfargument name="search" type="any" required="false" default="">
		<cfif not structKeyExists(variables,"datasource")>
				<cfset variables.datasource = APPLICATION.dsn_operEvents />
		</cfif>
		<cfquery name="qryGetList" datasource="#variables.datasource#">
					SELECT  vendor_id
					FROM itgov_vendors
					WHERE 
					upper(vendor_name) LIKE upper('#ARGUMENTS.search#%')
					ORDER BY vendor_id
				</cfquery>
		<cfreturn qryGetList>
	</cffunction>
	
	<cffunction name="updateExpireAction" returntype="struct" output="false" access="public"
				description="Updates Disable/Enable status of Vendors in database">
		<cfargument name="vendor_id" type="numeric" required="true"/>
		<cfargument name="active_status" type="numeric" required="false" default="" />
		<cfargument name="lastmodifiedby" type="numeric" required="true" />
		<cfset var strLocal = {success = true, message=""} />
		<!---  <cftry> ---> 
			<cfquery name="qryUpdateproduct" datasource="#variables.datasource#">
					UPDATE itgov_vendors
					SET
						active_status = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.active_status#" />,
					 	lastmodifiedby = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.lastmodifiedby#" />,
					 	lastmodifiedon = sysdate
					 WHERE vendor_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.vendor_id#" />
				</cfquery>
			<!---  <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Updating Product info  failed" />
			</cfcatch>
		</cftry>  --->
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="chkVendName" access="remote" returnformat="json" output="false">
        <cfargument name="VendName" required="true">
		<cfset var qryGetVendName = "" />
        <cfquery name="qryGetVendName" datasource="#variables.datasource#">
        	SELECT vendor_id
              FROM itgov_vendors
             WHERE lower(vendor_name) = lower(<cfqueryparam value="#ARGUMENTS.VendName#" cfsqltype="cf_sql_varchar" />)
        </cfquery>	
        <cfreturn yesNoFormat(qryGetVendName.recordCount)/>
    </cffunction>
<!---  Functions From Nandakishore --->	
	
	  <cffunction name="listvendorsForGrid" returntype="struct" output="false" access="public">  <!--- Updated by Naga Raju --->
		<cfargument name="gridsortcolumn" type="string" required="true" />
		<cfargument name="gridstartdirection" type="string" required="true" />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
<!--- 		<cftry> --->
				<cfquery name="qryGetList" datasource="#variables.datasource#">
					SELECT vendor_id, vendor_name, detail, address, glocation, email, phone1, phone2, fax, firstcreatedon, firstcreatedby,
					case 
								when active_status= 0 THEN
									'<input type="button" name="theEnd"  value=" E " class="gre" onclick="act_s(1,'||vendor_id||')" title="Enable this  Vendor"/>' 
								WHEN active_status= 1 THEN  
									'<input type="button" name="theEnd" value=" D "  class="req" onclick="act_s(0,'||vendor_id||')"  title="Disable this Vendor"/>'
								END  AS button
					FROM itgov_vendors, dual
                    WHERE 1=1
                    <cfif ARGUMENTS.gridsortcolumn neq '' AND ARGUMENTS.gridstartdirection neq '' >
							ORDER BY itgov_vendors.#ARGUMENTS.gridsortcolumn#  #ARGUMENTS.gridstartdirection# 
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
	
	<cffunction name="insertvendor" returntype="struct" output="false" access="public">
		<cfargument name="name" type="string" required="true" />
		<cfargument name="description" type="string" required="false"  />        
		<cfargument name="address" type="string" required="false" />
        <cfargument name="glocation" type="string" required="false"  />
		<cfargument name="email" type="string" required="false" />
		<cfargument name="phone1" type="string" required="false" />
		<cfargument name="phone2" type="string" required="false" />
		<cfargument name="fax" type="string" required="false"  />
        <cfargument name="creationDate" type="date" required="false"  />
        <cfargument name="createdBy" type="string" required="false"  />
		<cfset var strLocal = {success = true, message=""} />
	<!---	<cftry>--->
			<cfquery name="qryInsertvendor" datasource="#variables.datasource#">
					INSERT INTO itgov_vendors (vendor_name, detail, address, glocation, email, phone1, phone2, fax, firstcreatedon, firstcreatedby) 
					VALUES ( <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.name#" />
							, <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.description#" />
							, <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.address#" />
                            , <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.glocation#" />
							, <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.email#" />
							, <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.phone1#" />
							, <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.phone2#" />
							, <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.fax#" />
                            , <cfqueryparam cfsqltype="cf_sql_date"  value="#ARGUMENTS.creationDate#" />
                            , <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.createdBy#" />
							) 
				</cfquery>
		<!---	<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Inserting vendor failed" />
			</cfcatch>
		</cftry>--->
		<cfreturn strLocal />
	</cffunction>


	<cffunction name="updatevendors" returntype="struct" output="false" access="public">
		<cfargument name="vendor_id" type="numeric" required="true" />
		<cfargument name="vendor_name" type="string" required="false" default="" />
		<cfargument name="detail" type="string" required="false" default="" />
		<cfargument name="address" type="string" required="false" default=""/>
        <cfargument name="glocation" type="string" required="false" default=""/>
		<cfargument name="email" type="string" required="false" default=""/>
		<cfargument name="phone1" type="string" required="false" default=""/>
		<cfargument name="phone2" type="string" required="false" default=""/>
		<cfargument name="fax" type="string" required="false"  default=""/>
        <cfargument name="lastmodifiedby" type="string" required="true" />
		<cfargument name="lastmodifiedon" type="string" required="true"  />
		<cfset var strLocal = {success = true, message=""} />
		<!--- <cftry> --->
			<cfquery name="qryUpdatevendor" datasource="#variables.datasource#">
					UPDATE itgov_vendors 
					   SET 	 
                       		<cfif ARGUMENTS.vendor_name neq '' >
                       		 	vendor_name = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.vendor_name#" />,
                             </cfif>
                             <cfif ARGUMENTS.detail neq '' >
								detail = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.detail#" />,
                             </cfif>
                             <cfif ARGUMENTS.address neq '' >
							 	address =  <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.address#" />,
                             </cfif>
                             <cfif ARGUMENTS.glocation neq '' >
							 	glocation =  <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.glocation#" />,
                             </cfif>
                             <cfif ARGUMENTS.email neq '' >   
							 	email =  <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.email#" />,
                              </cfif>
                              <cfif ARGUMENTS.phone1 neq '' >  
							  	phone1 =  <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.phone1#" />,
                               </cfif>
                               <cfif ARGUMENTS.phone2 neq '' >
							   	phone2 =  <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.phone2#" />,
                               </cfif>
                               <cfif ARGUMENTS.fax neq '' >
									fax =  <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.fax#" />,
                                </cfif>
                                lastmodifiedby = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.lastmodifiedby#" />,
					 			lastmodifiedon = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.lastmodifiedon#" />    
					WHERE 
							vendor_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.vendor_id#" />
				</cfquery>
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Updating vendor info  failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>

	
</cfcomponent>