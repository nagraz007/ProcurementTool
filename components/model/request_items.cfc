<cfcomponent displayname="request_items" output="false" extends="utils">
	
	<cffunction name="init" access="public" returntype="request_items" description="Generates an object of itself">
		<cfargument name="datasource" required="true" type="string" />
			<cfset variables.datasource = ARGUMENTS.datasource />
			<cfreturn THIS />
	</cffunction>	

	<cffunction name="insertitem" returntype="struct" output="false" access="public"
				description="Inserts item for a particular Request">
		<cfargument name="model_id" type="numeric" required="false" />
		<cfargument name="description" type="string" required="false" />
		<cfargument name="itemstatus" type="string" required="false" />
		<cfargument name="requestid" type="numeric" required="false" />
		<cfargument name="purchasettypeid" type="numeric" required="false" />
		<cfargument name="quantity" type="numeric" required="false" />
		<cfargument name="insertedby" type="string" required="false" />
		<cfset var strLocal = {success = true, data = 0, message=""} />
		
		 <cftry>
		 <cfstoredproc procedure="ITGOV_PACK.insert_item" datasource="#VARIABLES.datasource#">
   			<cfprocparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.model_id#" />
   			<cfprocparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.description#" />
   			<cfprocparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.itemstatus#" />
   			<cfprocparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.requestid#" />
   			<cfprocparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.purchasettypeid#" />
   			<cfprocparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.quantity#" />
   			<cfprocparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.insertedby#" />
   			<cfprocparam cfsqltype="cf_sql_varchar" type="out" variable="procResult" />
  		</cfstoredproc>
		
		<cfif super.dbResultBreaker(procResult) eq 0>
			<cfthrow message="#super.dbResult(procResult).message#" type="APPLICATION" />
		</cfif>

			<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = CFCATCH.Message />
			</cfcatch>
		</cftry>
		<cfreturn strLocal />
	</cffunction> 

	<cffunction name="itemsdisplay" returntype="struct" output="false" access="public"
				description="Display of items for a request generated">
		<cfargument name="reqid" type="numeric" required="true" />
		
		<cfset var strLocal = {success = true, data = '', message=""} />
<!--- 	 	<cftry> --->
			<cfquery name="qryGetList" datasource="#variables.datasource#">
						SELECT a.quantity, a.description, b.name as type , c.name as model, a.item_id , a.firstcreatedby , b.purchasetype_id, c.model_id
						  FROM 		itgov_request_items a, 
						  			itgov_purchase_items_type b,
						  			itgov_purchaseitems_models c  
						 WHERE a.request_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.reqid#" />
							AND b.purchasetype_id = a.purchasetype_id AND a.model_id = c.model_id
			</cfquery>
					
			<cfset strLocal.data = qryGetList  />
<!--- 		<cfcatch type="any">
			<cfset strLocal.success =  false />
			<cfset strLocal.message = 'Items Display failed' />
			</cfcatch>
	 	</cftry> --->		
	<cfreturn strLocal>
	</cffunction>
	
	<cffunction name="listitems" returntype="struct" output="false" access="public"
				description="Lists items of a requesr from database for an item">
		<cfargument name="itemid" type="numeric" required="true" />
		
		<cfset var strLocal = {success = true, data = '', message=""} />
<!--- 	 	<cftry> --->
			<cfquery name="qryGetList" datasource="#variables.datasource#">
						SELECT quantity, description, purchasetype_id as typeid, model_id as modelid
						  FROM 		itgov_request_items  
						 WHERE item_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.itemid#" />
			</cfquery>
					
			<cfset strLocal.data = qryGetList  />
<!--- 		<cfcatch type="any">
			<cfset strLocal.success =  false />
			<cfset strLocal.message = 'Items Display failed' />
			</cfcatch>
	 	</cftry> --->		
	<cfreturn strLocal>
	</cffunction>
	
	<cffunction name="listitemsifApproved" returntype="struct" output="false" access="public"
				description="Lists items of a requesr from database for an item">
		<cfargument name="itemid" type="numeric" required="true" />
		
		<cfset var strLocal = {success = true, data = '', message=""} />
<!--- 	 	<cftry> --->
			<cfquery name="qryGetList" datasource="#variables.datasource#">
						SELECT quantity, description, purchasetype_id as typeid, model_id as modelid
						  FROM itgov_request_items  
						 WHERE item_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.itemid#" />
						 AND   item_status = 'A'
			</cfquery>
					
			<cfset strLocal.data = qryGetList  />
<!--- 		<cfcatch type="any">
			<cfset strLocal.success =  false />
			<cfset strLocal.message = 'Items Display failed' />
			</cfcatch>
	 	</cftry> --->		
	<cfreturn strLocal>
	</cffunction>

	<cffunction name="updateItem" returntype="struct" output="false" access="public"
				description="Updates the item status in database">
		<cfargument name="itemid" type="numeric" required="true">
		<cfargument name="itemStatus" type="string" required="true">
		<cfargument name="lastmodifiedby" type="numeric" required="true">
		<cfset var strLocal = {success = true, message=""} />
	<!---  	<cftry> ---> 	
		<cfquery name="qryGetList" datasource="#variables.datasource#">
			UPDATE itgov_request_items
			SET item_status =  <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.itemStatus#" />,
				lastmodifiedby =  <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.lastmodifiedby#" />,
				lastmodifiedon = sysdate
			WHERE item_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.itemid#" />		
		
			</cfquery>
	 			<!--- <cfcatch type="any">
				<cfset strLocal.success =  false />
				<cfset strLocal.message = 'Updating Item failed' />
			</cfcatch>
	 	</cftry>  --->
		<cfreturn strLocal>
	</cffunction>
</cfcomponent>