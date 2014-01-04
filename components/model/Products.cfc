<cfcomponent displayname="Products" output="false" extends="utils">
	
	<cffunction name="init" access="public" returntype="Products" description="Generates an object of itself">
		<cfargument name="datasource" required="true" type="string" />
			<cfset variables.datasource = ARGUMENTS.datasource />
			<cfreturn THIS />
	</cffunction>

	<cffunction name="listproducts" returntype="struct" output="false" access="public"
				description="Accessing the database and listing out all product information">
		<cfargument name="product_id" type="numeric" required="false" default="0"  />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
<!--- 		<cftry> --->
			<cfif not structKeyExists(variables,"datasource")>
				<cfset variables.datasource = APPLICATION.dsn_operEvents />
			</cfif>
			<cfquery name="qryGetList" datasource="#variables.datasource#">
						SELECT *
						  FROM itgov_Products 
						 WHERE 1=1
						 <cfif ARGUMENTS.product_id neq 0 > 
							 AND product_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.product_id#" />
						 </cfif>
					</cfquery>
					
			<cfset strLocal.data = qryGetList  />
<!--- 			<cfcatch type="any">
					
				<cfset strLocal.success =  false />
				<cfset strLocal.message = 'fetching results failed' />
			</cfcatch>
		</cftry >--->
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="listall" returntype="struct" output="false" access="public"
		description="Lists out Products for different search criterions on Products table for Grid">
		<cfargument name="searchFactor" type="string" required="false" />
		<cfargument name="searchword" type="string" required="false" />
		<cfargument name="gridsortcolumn" type="string" required="false" default="" />
		<cfargument name="gridstartdirection" type="string" required="false" default="" />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
<!--- 		<cftry> --->
			<cfif not structKeyExists(variables,"datasource")>
				<cfset variables.datasource = APPLICATION.dsn_operEvents />
			</cfif>
			<cfquery name="qryGetList" datasource="#variables.datasource#">
						SELECT itgov_products.product_id, itgov_products.name, itgov_products.owned_leased, itgov_products.serialno,
								itgov_products.budgetid, to_char(itgov_products.date_started,'DD-MON-YYYY') as date_started , itgov_vendors.vendor_name, itgov_purchases.ins_purchaseid as inspurchaseid,
								itgov_products.purchaseid_old, itgov_products.type as old_new, 
								to_char(itgov_prdusrhistory.startdate,'DD-MON-YYYY') as startdate,to_char(itgov_prdusrhistory.enddate,'DD-MON-YYYY') as enddate, itgov_users.username, itgov_purchase_items_type.name as type, itgov_purchaseitems_models.name as model,  
								case 
								when itgov_products.decommision = 'Y' THEN
									'<input type="button" name="theEnd"  value=" E " class="gre" onclick="act(1,'||itgov_products.product_id||')" title="Activate this asset"/>' || ' ' ||
										'<input type="button" name="theEnd" value=" H " class="pur" onclick="act(2,'||itgov_products.product_id||')" title="Show Asset History"/>'
								WHEN itgov_products.decommision = 'N' THEN  
									'<input type="button" name="theEnd" value=" D "  class="req" onclick="act(0,'||itgov_products.product_id||')"  title="Decommision this asset"/>' || ' ' ||
										'<input type="button" name="theEnd" value=" H " class="pur" onclick="act(2,'||itgov_products.product_id||')" title="Show Asset History"/>'
								END AS button
									
						  FROM itgov_Products,itgov_prdusrhistory, itgov_vendors, itgov_users, itgov_purchases , itgov_purchase_items_type, itgov_purchaseitems_models, dual
						 WHERE 1 = 1
						 <cfif ARGUMENTS.searchword neq '' > 
							 AND 
											<cfif ARGUMENTS.searchFactor eq 'product_id'  >
								 				itgov_products.#ARGUMENTS.searchFactor#	IN (#ARGUMENTS.searchword#)
											<cfelseif ARGUMENTS.searchFactor eq 'purchase_id'  >
								 				itgov_products.#ARGUMENTS.searchFactor#		IN (#ARGUMENTS.searchword#)
							 					<cfelseif ARGUMENTS.searchFactor eq 'vendor_id'  >
								 				upper( itgov_products.#ARGUMENTS.searchFactor#)	IN (#ARGUMENTS.searchword#)
							 					<cfelseif ARGUMENTS.searchFactor eq 'name'  >
								 			upper( itgov_products.#ARGUMENTS.searchFactor#)	 LIKE upper('%#ARGUMENTS.searchword#%')
							 					<cfelseif ARGUMENTS.searchFactor eq 'serialno'  >
								 			upper( itgov_products.#ARGUMENTS.searchFactor#)	 LIKE upper('%#ARGUMENTS.searchword#%')
								 				<cfelseif ARGUMENTS.searchFactor eq 'date_started' >	
								 			 itgov_products.#ARGUMENTS.searchFactor#	IN  '#ARGUMENTS.searchword#'
								 					<cfelse>
										 	upper( itgov_products.#ARGUMENTS.searchFactor#) IN upper ('%#ARGUMENTS.searchword#%')
											 </cfif>
						<cfelseif ARGUMENTS.searchFactor neq 'date_started' >
						 AND 1 = 0 
						</cfif>
						 		AND itgov_products.product_id  = itgov_prdusrhistory.product_id 
						 	AND  itgov_products.vendor_id = itgov_vendors.vendor_id 
						 	AND itgov_products.purchasetype_id = itgov_purchase_items_type.purchasetype_id
						 	AND itgov_products.model_id = itgov_purchaseitems_models.model_id
						 	AND  itgov_prdusrhistory.us_id = itgov_users.us_id
						 	AND itgov_products.purchase_id = itgov_purchases.purchase_id (+)
							AND ((itgov_prdusrhistory.enddate is not null	AND itgov_products.decommision = 'Y')
							OR(itgov_prdusrhistory.enddate is null AND itgov_products.decommision = 'N'))
						<cfif ARGUMENTS.gridsortcolumn neq '' AND ARGUMENTS.gridstartdirection neq '' >
								<cfif ARGUMENTS.gridsortcolumn eq 'vendor_name'  >		
									ORDER BY itgov_vendors.#ARGUMENTS.gridsortcolumn#  #ARGUMENTS.gridstartdirection# 
								<cfelseif ARGUMENTS.gridsortcolumn eq 'startdate' or ARGUMENTS.gridsortcolumn eq 'enddate'>					
									ORDER BY itgov_prdusrhistory.#ARGUMENTS.gridsortcolumn#  #ARGUMENTS.gridstartdirection# 
								<cfelseif ARGUMENTS.gridsortcolumn eq 'username'>
									ORDER BY itgov_users.#ARGUMENTS.gridsortcolumn#  #ARGUMENTS.gridstartdirection# 
								<cfelseif ARGUMENTS.gridsortcolumn eq 'type'>
									ORDER BY itgov_purchase_items_type.name  #ARGUMENTS.gridstartdirection# 
								<cfelseif ARGUMENTS.gridsortcolumn eq 'inspurchaseid'>
									ORDER BY itgov_purchases.ins_purchaseid  #ARGUMENTS.gridstartdirection# 
								<cfelseif ARGUMENTS.gridsortcolumn eq 'old_new'>
									ORDER BY itgov_products.type  #ARGUMENTS.gridstartdirection# 
								<cfelseif ARGUMENTS.gridsortcolumn eq 'model' or ARGUMENTS.gridsortcolumn eq 'button' >
									ORDER BY itgov_purchaseitems_models.name  #ARGUMENTS.gridstartdirection# 
								<cfelse>
									ORDER BY itgov_products.#ARGUMENTS.gridsortcolumn#  #ARGUMENTS.gridstartdirection# 
								</cfif>
						</cfif>
																	 
					</cfquery>
					
			<cfset strLocal.data = qryGetList  />
<!--- 			<cfcatch type="any">
					
				<cfset strLocal.success =  false />
				<cfset strLocal.message = 'fetching results failed' />
			</cfcatch>
		</cftry >--->
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="insertproduct" returntype="struct" output="false" access="public"
				description="Inserts a new product into the database">
		<cfargument name="vendor_id" type="numeric" required="true" />
		<cfargument name="name" type="string" required="false"  />
		<cfargument name="owned_leased" type="string" required="false" />
		<cfargument name="serialno" type="string" required="false" />
		<cfargument name="budgetid" type="string" required="false" />
		<cfargument name="date_started" type="string" required="false"/>
		<cfargument name="purchasetype_id" type="numeric" required="false"/>
		<cfargument name="model_id" type="numeric" required="false"/>
		<cfargument name="old_new" type="string" required="false"/>
		<cfargument name="purchase_id" type="numeric" required="false"/>
		<cfargument name="purchases_items_id" type="numeric" required="false"/>
		<cfargument name="purchaseid_old" type="string" required="false"/>
		<cfargument name="campus" type="string" required="false"/>
		<cfargument name="insertedby" type="string" required="false" />
		<cfset var strLocal = {success = true, data = 0, message=""} />
	 	

	 <cftry>  
		
		<cfstoredproc procedure="ITGOV_PACK.insert_product" datasource="#VARIABLES.datasource#">
   			<cfprocparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.vendor_id#" />
   			<cfprocparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.name#" />
   			<cfprocparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.owned_leased#" />
   			<cfprocparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.serialno#" />
   			<cfprocparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.budgetid#" />
   			<cfprocparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.date_started#" />
   			<cfprocparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.purchasetype_id#" />
   			<cfprocparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.model_id#" />
   			<cfprocparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.old_new#" />
   			<cfprocparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.purchase_id#" />
   			<cfprocparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.purchases_items_id#" />
   			<cfprocparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.purchaseid_old#" />
   			<cfprocparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.campus#" />
   			<cfprocparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.insertedby#" />
   			<cfprocparam cfsqltype="cf_sql_varchar" type="out" variable="procResult" />
  		</cfstoredproc>
		
		<cfset strLocal.data = super.dbResultBreaker(procResult) />
		<cfset strLocal.message = super.dbResult(procResult).message />

			  <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = CFCATCH.message />
			</cfcatch>
		</cftry> 
		<cfreturn strLocal />
	</cffunction> 

	<cffunction name="updateproduct" returntype="struct" output="false" access="public"
				description="Updates a product detail into the database">
		<cfargument name="product_id" type="numeric" required="true"/>
		<cfargument name="vendor_id" type="numeric" required="false" default="0"/>
		<cfargument name="name" type="string" required="false" default="" />
		<cfargument name="owned_leased" type="string" required="false" default="" />
		<cfargument name="serialno" type="string" required="false" default=""  />
		<cfargument name="budgetid" type="numeric" required="false" default="-1" />
		<cfargument name="date_started" type="string" required="false" default="" />
		<cfargument name="type" type="string" required="false" default="" />
		<cfargument name="purchaseid_old" type="string" required="false" default=" " />
		<cfargument name="lastmodifiedby" type="numeric" required="true" />
		<cfset var strLocal = {success = true, message=""} />
<!--- 		<cftry> --->
			<cfquery name="qryUpdateproduct" datasource="#variables.datasource#">
					UPDATE itgov_Products
					SET
						<cfif ARGUMENTS.vendor_id neq 0 >
						vendor_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.vendor_id#"/>,
						</cfif>
						<cfif ARGUMENTS.name neq '' >
						name = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.name#" />,
						</cfif>
						<cfif ARGUMENTS.owned_leased neq '' >
						owned_leased = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.owned_leased#" />,
						</cfif>
						<cfif ARGUMENTS.serialno neq '' >
						serialno = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.serialno#" />,
						</cfif>
						<cfif ARGUMENTS.budgetid neq -1 >
						budgetid = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.budgetid#" />,
						</cfif>
						<cfif ARGUMENTS.date_started neq '' >
						date_started = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.date_started#" />,
						</cfif>
						<cfif ARGUMENTS.type neq '' >
						type = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.type#" />,
						</cfif>
						<cfif ARGUMENTS.purchaseid_old neq ' ' >
						purchaseid_old = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.purchaseid_old#" />,
						</cfif>
					 	lastmodifiedby = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.lastmodifiedby#" />,
					 	lastmodifiedon = sysdate
					 WHERE product_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.product_id#" />
				</cfquery>
	<!--- 		<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Updating Product info  failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="updatedecomAction" returntype="struct" output="false" access="public"
				description="Updates the decommision Action in the database">
		<cfargument name="product_id" type="numeric" required="true"/>
		<cfargument name="decom" type="string" required="false" default="" />
		<cfargument name="reason" type="string" required="false" default="" />
		<cfargument name="lastmodifiedby" type="numeric" required="true" />
		<cfset var strLocal = {success = true, message=""} />
	<!--- 	<cftry>  --->
			<cfquery name="qryUpdateproduct" datasource="#variables.datasource#">
					UPDATE itgov_Products
					SET
						decommision = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.decom#" />,
						<cfif ARGUMENTS.reason neq ''>
						reason = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.reason#" />,
						</cfif>
					 	lastmodifiedby = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.lastmodifiedby#" />,
					 	lastmodifiedon = sysdate,
					 	<cfif ARGUMENTS.decom eq 'Y'>
						 	decom_date = sysdate
						 	<cfelseif ARGUMENTS.decom eq 'N'>
						 	decom_date = null
						</cfif>
					 WHERE product_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.product_id#" /> 
					 
				</cfquery>
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Updating Product info  failed" />
			</cfcatch>
		</cftry>  --->
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="AstHistory" access="public" returntype="struct" output="false"
				description="Gives the Asset History of a Product from database">
		<cfargument name="productid" type="numeric" required="true">
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
		<cfquery name="qryGetList" datasource="#variables.datasource#">
						SELECT b.name as type, c.name as model, a.serialno,a.name as pname, a.budgetid, a.decommision, to_char(e.startdate,'DD-MON-YYYY') startdate, to_char(e.enddate,'DD-MON-YYYY') enddate,
						  Initcap(d.firstname)||' '||upper(d.lastname) as name ,a.purchase_id as purchaseid
						  FROM itgov_Products a, itgov_purchase_items_type b, itgov_purchaseitems_models c, itgov_users d, itgov_PrdUsrHistory e
						 WHERE a.purchasetype_id = b.purchasetype_id 
						 	AND a.model_id = c.model_id
						 	AND e.product_id = a.product_id
						 	AND e.us_id = d.us_id
							AND a.product_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.productid#" />
						 ORDER BY e.enddate DESC 
					</cfquery>
					
			<cfset strLocal.data = qryGetList  />
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="getpurchaseId" returntype="struct" output="false" access="public"
				description="Gives the Purchaseid of a product from database">
		<cfargument name="product_id" required="true" type="numeric">
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
	<!---  <cftry> --->  
			<cfquery name="qryGetList" datasource="#variables.datasource#" >
					SELECT purchase_id
					  FROM itgov_products
					WHERE  product_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.product_id#" /> 
				</cfquery>
			<cfset strLocal.data = qryGetList />
 		<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Getting List of Asset Mapping with users failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>

</cfcomponent>