<cfcomponent displayname="Purchases" output="false" extends="utils">

	<cffunction name="init" access="public" returntype="Purchases" description="Generates an object of itself">
		<cfargument name="datasource" required="true" type="string" />
		<cfset variables.datasource = ARGUMENTS.datasource />
		<cfreturn THIS />
	</cffunction>

	<cffunction name="listpurchases" returntype="struct" output="false" access="public"
				description="Lists out All purchases frm DataBase">
		<cfargument name="purchase_id" type="numeric" required="false" default="0"  />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
		<!--- <cftry> --->
			<cfquery name="qryGetList" datasource="#variables.datasource#">
						SELECT a.purchase_id, a.firstcreatedon,
								 Initcap(b.firstname)||' '||upper(b.lastname) as name
						  FROM itgov_purchases a, itgov_users b
						 WHERE a.us_id = b.us_id
						 AND a.budgetapproval = 0
						 <cfif ARGUMENTS.purchase_id neq 0 > 
							 AND a.purchase_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchase_id#" />
						 </cfif>
						 	 ORDER BY a.firstcreatedon  
						 
					</cfquery>
			<cfset strLocal.data = qryGetList />
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = CFCATCH.message />
			</cfcatch>
		</cftry --->>
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="insertpurchases" returntype="struct" output="false" access="public"
				description="Inserting new purchase in database">
		<cfargument name="us_id" type="numeric" required="true" />
		<cfargument name="requestid" type="numeric" required="false" />
		<cfargument name="budgetmgrid" type="numeric" required="false" />
		<cfargument name="budgetid" type="string" required="false" />
		<cfargument name="firstcreatedby" type="numeric" required="false" />
		<cfset var strLocal = {success = true, message=""} />
			<cftry>
				<cfstoredproc procedure="ITGOV_PACK.insert_purchase" datasource="#VARIABLES.datasource#">
					<cfprocparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.us_id#" />
					<cfprocparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.budgetmgrid#" />
					<cfprocparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.budgetid#" />
					<cfprocparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.firstcreatedby#" />
					<cfprocparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.requestid#" />
					<cfprocparam cfsqltype="cf_sql_varchar" type="out" variable="procResult" />
				</cfstoredproc>
				<cfif super.dbResultBreaker(procResult) eq 0>
					<cfthrow message="#super.dbResult(procResult).message#" type="APPLICATION" />
				<cfelse>
					<cfset strLocal.data = super.dbResultBreaker(procResult) />
				</cfif>
				<cfcatch type="any">
					<cfset strLocal.success = false />
					<cfset strLocal.message = CFCATCH.Message />
				</cfcatch>
		</cftry>
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="updatepurchases" returntype="struct" output="false" access="public"
				description="Updating Purchase status in database">
		<cfargument name="purchase_id" type="numeric" required="true" />
		<cfargument name="status_id" type="numeric" required="true" />
		<cfargument name="total" type="numeric" required="true" />
		<cfargument name="lastmodifiedby" type="numeric" required="true" />
		<cfset var strLocal = {success = true, message=""} />
		<!--- <cftry> --->
			<cfquery name="qryUpdatepurchase" datasource="#variables.datasource#">
					UPDATE itgov_purchases
					SET
					status_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.status_id#" />,
					total = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.total#" />,
					lastmodifiedby = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.lastmodifiedby#" />,
					lastmodifiedon = sysdate
					 WHERE purchase_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchase_id#" />
				</cfquery>
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Updating Purchases info  failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="getpurchId" access="public" returntype="struct" output="false"
				description="Convert from insead format Purchase id to system purchase id">
		<cfargument name="InspurchId" type="string" required="false" default="">
		<cfargument name="purchId" type="numeric" required="false" default="0">
		<cfset var strLocal = {success = true, message=""} />
	
		<cfset var qryGetList = "" />
		<cftry>
			<cfquery name="qryGetList" datasource="#variables.datasource#">
						SELECT ins_purchaseid, purchase_id
						  FROM itgov_purchases 
						 WHERE 1 = 1
						 <cfif ARGUMENTS.InspurchId neq '' > 
							 AND upper(ins_purchaseid) = upper( <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.InspurchId#" /> )
						 </cfif>
						 <cfif ARGUMENTS.purchId neq 0 > 
							 AND purchase_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchId#" />
						 </cfif>
						 
					</cfquery>
			<cfset strLocal.data = qryGetList />
			<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = CFCATCH.message />
			</cfcatch>
		</cftry>
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="listpurchasesforDisplay" returntype="struct" output="false" access="public"
				description="Listing All Purchases for display from database">
		<cfargument name="purchase_id" type="numeric" required="false" default="0"  />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
		<!--- <cftry> --->
			<cfquery name="qryGetList" datasource="#variables.datasource#">
						SELECT a.purchase_id, a.opendate, a.status_id, a.budgetid, a.budgetmgr_id, a.budgetapproval, a.budgetmgrcomments, a.total,
							b.onbehalfof , b.onbereason, Initcap(c.firstname)||' '||upper(c.lastname) as name
						  FROM itgov_purchases a, itgov_purchaserequests b, itgov_users c
						 WHERE a.purchase_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchase_id#" />
						 AND a.request_id = b.request_id
						 AND a.us_id = c.us_id
						 
					</cfquery>
			<cfset strLocal.data = qryGetList />
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = CFCATCH.message />
			</cfcatch>
		</cftry >--->
		<cfreturn strLocal />
	</cffunction>
	
	<cffunction name="autosuggest" access="public" returntype="array"
			description="For Auto suggesting a Purchase Order Number">
		<cfargument name="search" type="any" required="false" default="">
		<cfset var result=ArrayNew(1)>
		<cfif not structKeyExists(variables,"datasource")>
				<cfset variables.datasource = APPLICATION.dsn_operEvents />
		</cfif>
		<cfquery name="qryGetList" datasource="#variables.datasource#">
					SELECT  ins_purchaseid
					FROM itgov_purchases
					WHERE 
					upper(ins_purchaseid) LIKE upper('#ARGUMENTS.search#%')
					ORDER BY ins_purchaseid DESC
				</cfquery>
		<cfloop query="qryGetList">
			<cfset ArrayAppend(result, ins_purchaseid)/>
		</cfloop>		
		<cfreturn result />
	</cffunction>

	<cffunction name="listpurchasesForBudgetApproval" returntype="struct" output="false" access="public"
				description="Listing All Purchases for Budget Approval">
		<cfargument name="budgetid" type="numeric" required="false" default="0"  />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
		<!--- <cftry> --->
			<cfquery name="qryGetList" datasource="#variables.datasource#">
						SELECT a.purchase_id, a.firstcreatedon,
								 Initcap(b.firstname)||' '||upper(b.lastname) as name
						  FROM itgov_purchases a, itgov_users b
						 WHERE a.us_id = b.us_id
						 AND a.budgetapproval = 2
						 <cfif ARGUMENTS.budgetid neq 0 > 
							 AND a.budgetmgr_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.budgetid#" />
						 </cfif>
						 	 ORDER BY a.firstcreatedon  
						 
					</cfquery>
			<cfset strLocal.data = qryGetList />
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = CFCATCH.message />
			</cfcatch>
		</cftry >--->
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="updateBudgetmandecision" returntype="struct" output="false" access="public"
				description="Updating Budget Managers decision">
		<cfargument name="purchid" type="numeric" required="true">
		<cfargument name="decision" type="numeric" required="true">
		<cfargument name="lastmodifiedby" type="numeric" required="true">
		<cfset var strLocal = {success = true, message=""} />
		<!--- <cftry> --->
			<cfquery name="qryUpdatepurchase" datasource="#variables.datasource#">
					UPDATE itgov_purchases
					SET
					budgetapproval = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.decision#" />,
					lastmodifiedby = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.lastmodifiedby#" />,
					lastmodifiedon = sysdate
					 WHERE purchase_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchid#" />
				</cfquery>
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Updating Purchases info  failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="GetEmailForaPO" returntype="struct" output="false" access="public"
				description="Gets email of Requester and Budget Manager">
		<cfargument name="purchid" type="numeric" required="true">
		<cfset var strLocal = {success = true, message=""} />
		<!--- <cftry> --->
			<cfquery name="qryGetList" datasource="#variables.datasource#">
					SELECT b.email as budgetemail, c.email as useremail
					FROM itgov_purchases a, itgov_users b, itgov_users c
					WHERE a.purchase_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchid#" />
					AND a.us_id = c.us_id
					AND a.budgetmgr_id = b.us_id
				</cfquery>
				<cfset strLocal.data = qryGetList />
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Updating Purchases info  failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="SeeAllApprovalsForGrid" returntype="struct" output="false" access="public"
				description="List of All Purchases with Budget Approvals for display in grid">
		<cfargument name="gridsortcolumn" type="string" required="false" default="" />
		<cfargument name="gridstartdirection" type="string" required="false" default="" />
	
		<cfset var strLocal = {success = true, data = '', message=""} />
		<!--- <cftry> --->
		<cfquery name="qryGetList" datasource="#variables.datasource#">
						SELECT a.budgetid, Initcap(c.firstname)||' '||upper(c.lastname) as budgetman, a.budgetmgrcomments, 
								Initcap(b.firstname)||' '||upper(b.lastname) as name,a.ins_purchaseid,
								case 
								when a.budgetapproval = 2 THEN
									'Pending'
								when a.budgetapproval = 1 THEN
									'Approved'
								WHEN a.budgetapproval = 0 THEN  
									'Rejected'
								END AS button
								 
						  FROM itgov_purchases a, itgov_users b , itgov_users c
						 WHERE a.us_id = b.us_id
						 AND a.budgetmgr_id = c.us_id
						<cfif ARGUMENTS.gridsortcolumn neq '' AND ARGUMENTS.gridstartdirection neq '' >
							<cfif ARGUMENTS.gridsortcolumn eq 'name'  >		
									ORDER BY  b.firstname #ARGUMENTS.gridstartdirection# 
							<cfelseif ARGUMENTS.gridsortcolumn eq 'budgetman'>
									ORDER BY c.firstname  #ARGUMENTS.gridstartdirection# 
							<cfelseif ARGUMENTS.gridsortcolumn eq 'button'>
									ORDER BY a.budgetid  #ARGUMENTS.gridstartdirection# 
							<cfelse>
									ORDER BY a.#ARGUMENTS.gridsortcolumn#  #ARGUMENTS.gridstartdirection# 
						</cfif> 
							</cfif> 
					</cfquery>
					
			<cfset strLocal.data = qryGetList  />
			
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Listing Requests failed" />
			</cfcatch>
			
		</cftry> --->
		<cfreturn strLocal >
	</cffunction>

	<cffunction name="checkForRegistry" returntype="struct" output="false" access="public"
				description=" don''t rem  :( ">
		<cfargument name="purchItmId" type="numeric">
		<cfset strLocal='' />
		<cfset qrychk='' />
		<cfset data='' />
			<cfquery name="qrychk" datasource="#variables.datasource#">
				select count(*) as counter from (select  q.* from itgov_purchases p,(
                    select a.purchase_id as purchaseID, a.purchases_items_id
                      from itgov_purchases_items a
                     where a.delivery_status = 1
                       and not exists (select 1 from itgov_products b where a.purchases_items_id = b.purchases_items_id)
                    union
                    select c.purchase_id as purchaseID, c.purchases_items_id
                      from itgov_purchases_items c
                     where c.delivery_status = 1
                       and  not exists (select 1 from itgov_softwares d where c.purchases_items_id = d.purchases_items_id)
                    )q 
                    where p.purchase_id = q.purchaseID
                    order by q.purchaseID asc )h  where h.purchases_items_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchItmId#" />   
			</cfquery>
			
			<cfquery name="data" datasource="#variables.datasource#">
				select quantity,purchasetype_id from itgov_purchases_items where purchases_items_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchItmId#" /> 
			</cfquery>
			
			<cfif data.quantity neq qrychk.counter >
					<cfset strLocal.success = true />
				<cfelse>
					<cfset strLocal.success = false />
			</cfif>			
		<cfset strLocal.quantity = data  />
	<cfreturn strLocal />
	</cffunction>

<!--- Functions  from Nandakishore --->
	<cffunction name="assetsNotRegistered" returntype="query" output="false" access="public">
			<cfargument name="purchase_ID" required="false" type="numeric"/>
            <cfquery name="qryGetList" datasource="#variables.datasource#">
                   SELECT p.INS_PURCHASEID, q.* 
                   FROM itgov_purchases p,(
                    SELECT c.purchase_id as purchaseID, c.purchases_items_id, c.numeroitem as ItemId, 'S' as TYPE
                      FROM itgov_purchases_items c
                     WHERE c.delivery_status = 1 AND c.purchasetype_id = 11
                     <cfif structKeyExists(ARGUMENTS, 'purchase_ID')>
                     AND c.purchase_id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.purchase_ID#"/>
                     </cfif>
                       AND NOT EXISTS 
                       		(SELECT 1 
                            	FROM itgov_softwares d 
                                WHERE c.purchases_items_id = d.purchases_items_id)
                    UNION           
                    SELECT a.purchase_id as purchaseID, a.purchases_items_id, a.numeroitem as ItemId,  'P' as TYPE
                      FROM itgov_purchases_items a
                     WHERE a.delivery_status = 1 AND a.purchasetype_id != 11
                     <cfif structKeyExists(ARGUMENTS, 'purchase_ID')>
                     AND a.purchase_id = <cfqueryparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.purchase_ID#"/>
                     </cfif>
                       AND NOT EXISTS
                       		(SELECT 1 
                            	FROM itgov_products b 
                                WHERE a.purchases_items_id = b.purchases_items_id)            
                    )q 
                    WHERE p.purchase_id = q.purchaseID
                    ORDER BY q.purchaseID asc		              
			</cfquery>
		<cfreturn qryGetList />
	</cffunction>
    
    <cffunction name="productAssetsPurchasesItemsCountMismatch" returntype="query" output="false" access="public">
			<cfquery name="qryGetList" datasource="#variables.datasource#">
                   SELECT p.INS_PURCHASEID, q.* 
                    FROM itgov_purchases p,
                      (SELECT a.purchase_id as purchaseID , a.purchases_items_id, a.numeroitem
                        FROM itgov_purchases_items a 
                        WHERE a.quantity != 0 AND a.delivery_status = 1
                        AND a.quantity != 
                          (SELECT COUNT(b.purchases_items_id) 
                            FROM itgov_products b 
                            WHERE b.purchases_items_id = a.purchases_items_id 
                            GROUP BY b.purchases_items_id
                          )
                        ) q
                    WHERE  p.purchase_id = q.purchaseID
			</cfquery>
		<cfreturn qryGetList />
	</cffunction>

</cfcomponent>