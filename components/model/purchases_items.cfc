<cfcomponent displayname="purchases_items" output="false" extends="utils">

	<cffunction name="init" access="public" returntype="purchases_items" description="Generates an object of itself">
		<cfargument name="datasource" required="true" type="string" />
		<cfset variables.datasource = ARGUMENTS.datasource />
		<cfreturn THIS />
	</cffunction>

	<cffunction name="listpurchases_itemsforBudgetman" returntype="struct" output="false" access="public"
				description="Lists out Item details to be displayed for the budget controller from database ">
		<cfargument name="purchase_id" type="numeric" required="false" default="0"  />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
<!--- 		<cftry> --->
			<cfquery name="qryGetList" datasource="#variables.datasource#">
						SELECT b.name as model, c.name as type, quantity, description, comments, d.ins_purchaseid as inspurchaseid , a.listprice, a.grandtotal, d.total
						FROM itgov_purchases_items a, itgov_purchaseitems_models b, itgov_purchase_items_type c, itgov_purchases d
						WHERE a.model_id = b.model_id
						AND a.purchasetype_id = c.purchasetype_id
							 <cfif ARGUMENTS.purchase_id neq 0 > 
						AND a.purchase_id = d.purchase_id
						AND  a.purchase_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchase_id#" /> 
						 </cfif>
						 ORDER BY a.purchases_items_id ASC
				</cfquery>
			<cfset strLocal.data = qryGetList />
		<!--- 	<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Getting List of purchases_items failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>
	
	<cffunction name="insertpurchases_items" returntype="struct" output="false" access="public"
				description="Inserts a Apptoved Purchase item into the database">
		<cfargument name="vendor_id" type="numeric" required="true" />
		<cfargument name="purchasetype_id" type="numeric" required="true"/>
		<cfargument name="purchase_id" type="numeric" required="true"/>
		<cfargument name="model_id" type="numeric" required="true"/>
		<cfargument name="description" type="string" required="true" />
		<cfargument name="quantity" type="numeric" required="true"/>
		<cfargument name="comments" type="string" required="true" />	
		<cfargument name="numeroItem" type="numeric" required="true" />	
		<cfargument name="firstcreatedby" type="numeric" required="true" />
		
		<cfset var strLocal = {success = true, message=""} />
		
		<cftry>
				<cfstoredproc procedure="ITGOV_PACK.insert_purchases_item" datasource="#VARIABLES.datasource#">
					<cfprocparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.purchase_id#" />
					<cfprocparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.vendor_id#" />
					<cfprocparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.purchasetype_id#" />
					<cfprocparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.model_id#" />
					<cfprocparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.description#" />
					<cfprocparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.quantity#" />
					<cfprocparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.comments#" />
					<cfprocparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.numeroItem#" />
					<cfprocparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.firstcreatedby#" />
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

	<cffunction name="updatepurchases_items" returntype="struct" output="false" access="public"
				description="updates the detials of item into teh database">
		<cfargument name="purchases_items_id" type="numeric" required="true" />
		<cfargument name="vendor_id" type="numeric" required="true" />
		<cfargument name="currency_id" type="numeric" required="true" />
		<cfargument name="unitprice" type="string" required="false"  />
		<cfargument name="listprice" type="string" required="false"  />
		<cfargument name="discount" type="string" required="false"  />
		<cfargument name="pad" type="string" required="false"  />
		<cfargument name="totalamt" type="string" required="false"  />
		<cfargument name="vendor_delivery_date" type="string" required="false"  />
		<cfargument name="date_reqd_by" type="string" required="false"  />
		<cfargument name="shippingcost" type="string" required="false" />
		<cfargument name="invoicedate" type="string" required="false"  />
		<cfargument name="invoicenumber" type="string" required="false" />
		<cfargument name="salescontact" type="string" required="false" />
		<cfargument name="salesphone" type="string" required="false" />
		<cfargument name="salesemail" type="string" required="false" />
		<cfargument name="vendoroffer" type="string" required="false" />
		<cfargument name="vendorref" type="string" required="false" />
		<cfargument name="expected_delivery_date" type="string" required="false"  />
		<cfargument name="tax" type="string" required="false"  />
		<cfargument name="grandtotal" type="string" required="false"  />
		<cfargument name="delivery_status" type="numeric" required="false"  />
		<cfargument name="po_description" type="string" required="false"  />
		<cfargument name="lastmodifiedby" type="string" required="false" />
		<cfset var strLocal = {success = true, message=""} />
		<!--- <cftry> --->
			<cfquery name="qryUpdatepurchase_items" datasource="#variables.datasource#">
						UPDATE itgov_purchases_items
						SET
						vendor_id =	<cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.vendor_id#" />,
						currency_id =	<cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.currency_id#" />,
						unitprice = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.unitprice#" />,
						listprice = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.listprice#" />,
						discount = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.discount#" />,
						pad = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.pad#" />,
						totalamt = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.totalamt#" />,
						tax = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.tax#" />,
						grandtotal = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.grandtotal#" />,
						vendor_delivery_date = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.vendor_delivery_date#" />,
						expected_delivery_date = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.expected_delivery_date#" />,
						date_reqd_by = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.date_reqd_by#" />,
						shippingcost = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.shippingcost#" />,
						invoicedate = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.invoicedate#" />,
						invoicenumber = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.invoicenumber#" />,
						salescontact = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.salescontact#" />,
						salesphone = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.salesphone#" />,
						vendoroffer = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.vendoroffer#" />,
						vendorref = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.vendorref#" />,
						salesemail = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.salesemail#" />,
						delivery_status = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.delivery_status#" />,
						po_description = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.po_description#" />,
						lastmodifiedby = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.lastmodifiedby#" />,
						lastmodifiedon = sysdate
					WHERE purchases_items_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchases_items_id#" />
					</cfquery>
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Updating Purchases_items info  failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="listitemsForDisplay" returntype="struct" output="false" access="public"
				description="Lists out items form database">
		<cfargument name="purchase_id" type="numeric" required="false" default="0"  />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
<!--- 		<cftry> --->
			<cfquery name="qryGetList" datasource="#variables.datasource#">
						SELECT a.*, b.vendor_name as vendorname , b.detail as vendordetails, c.name as purchasetype , d.name as modelname , 
							e.symbol as currencysymbol, e.name as currencyname  
						FROM itgov_purchases_items a, itgov_vendors b, itgov_purchase_items_type c, itgov_purchaseitems_models d, itgov_currency e
						WHERE a.vendor_id = b.vendor_id 
						  AND a.purchase_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchase_id#" /> 
						  AND a.purchasetype_id = c.purchasetype_id
						  AND a.model_id = d.model_id
						  AND a.currency_id = e.currency_id
					 ORDER BY a.purchases_items_id ASC
			</cfquery>
			<cfset strLocal.data = qryGetList />
		<!--- 	<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Getting List of purchases_items failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="listIdPurchaseItems" returntype="struct" output="false" access="public"
				description="Lists out Items' id and Items' number from database for a Purchase">
		<cfargument name="purchase_id" type="numeric" required="true">
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
		<!--- 	<cftry>  --->
				<cfquery name="qryGetList" datasource="#variables.datasource#">
								SELECT purchases_items_id as id , rownum as rowI
								FROM itgov_purchases_items 
								WHERE purchase_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchase_id#" /> 
						 	
					</cfquery>
				<cfset strLocal.data = qryGetList />
		 <!--- 	<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Getting Data failed" />
			</cfcatch>
		</cftry>  --->
		<cfreturn strLocal />
	</cffunction>
	
	<cffunction name="listIdPurchaseItemsForReg" returntype="struct" output="false" access="public"
			description="Lists Item id's  and item numbers for reg ">
		<cfargument name="purchase_id" type="numeric" required="true">
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
		<!--- 	<cftry>  --->
				<cfquery name="qryGetList" datasource="#variables.datasource#">
								SELECT purchases_items_id as id , rownum as rowI
								FROM itgov_purchases_items 
								WHERE purchase_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchase_id#" /> 
						 	UNION
							 	SELECT 0 as id , 0 as rowI
							 	FROM DUAL
							 	ORDER BY 1
					</cfquery>
				<cfset strLocal.data = qryGetList />
		 <!--- 	<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Getting Data failed" />
			</cfcatch>
		</cftry>  --->
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="listitemsForReg" returntype="struct" output="false" access="public"
				description="Listing All Items in Registration through Purchasing">
		<cfargument name="purchases_items_id" type="numeric" required="false" default="0"  />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
<!--- 		<cftry> --->
			<cfquery name="qryGetList" datasource="#variables.datasource#">
						SELECT c.ins_purchaseid, a.purchasetype_id, a.model_id,b.vendor_name as vendorname,a.vendor_id as vendorid,a.quantity,a.purchase_id as purchaseid
						FROM itgov_purchases_items a, itgov_vendors b, itgov_purchases c
						WHERE a.vendor_id = b.vendor_id 
						AND a.purchase_id = c.purchase_id
						  AND a.purchases_items_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchases_items_id#" /> 
			</cfquery>
			<cfset strLocal.data = qryGetList />
		<!--- 	<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Getting List of purchases_items failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="listforreg" returntype="struct" output="false" access="public"
				description="Listing for Registration through Purchasing">
		<cfargument name="purchase_id" type="numeric" required="false" default="0"  />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
<!--- 		<cftry> --->
			<cfquery name="qryGetList" datasource="#variables.datasource#">
						SELECT a.purchases_items_id as id, rownum as rowI ,a.purchase_id ,
						(Select b.name from itgov_purchase_items_type b where b.purchasetype_id = a.purchasetype_id) as type
						FROM itgov_purchases_items a
						WHERE a.purchase_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchase_id#" />
						AND a.delivery_status = 1 
			</cfquery>
			<cfset strLocal.data = qryGetList />
		<!--- 	<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Getting List of purchases_items failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	
	</cffunction>

	<cffunction name="ItemsForPrintOrder" returntype="struct" output="false" access="public"
				 description="List of Items for Print Order">
					 
		<cfargument name="purchase_id" type="numeric" required="false" default="0"  />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
<!--- 		<cftry> --->
			<cfquery name="qryGetList" datasource="#variables.datasource#">
						SELECT pui.vendor_id, wm_concat(' Item ' || pui.numeroitem) AS Items, ven.vendor_name
						  FROM itgov_purchases_items pui, itgov_vendors ven
						 WHERE pui.purchase_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchase_id#" />
						   AND pui.vendor_id = ven.vendor_id
					  GROUP BY pui.vendor_id, ven.vendor_name
			</cfquery>
			<cfset strLocal.data = qryGetList />
		<!--- 	<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Getting List of purchases_items failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	
	</cffunction>

	<cffunction name="DataForPrintOrder" returntype="struct" output="false" access="public"
				description="Item data req for printe order">
		<cfargument name="purchase_id" type="numeric" required="false" default="0"  />
		<cfargument name="vendor_id" type="numeric" required="false" default="0"  />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
<!--- 		<cftry> --->
			<cfquery name="qryGetList" datasource="#variables.datasource#">
						SELECT a.quantity, a.unitprice, a.listprice, a.discount, a.tax, a.vendor_delivery_date, 
						b.ins_purchaseid, c.name as type, d.vendor_name, a.po_description, a.shippingcost,a.vendorref,b.budgetid, Initcap(e.firstname)|| ' ' || upper(e.lastname) as name
						FROM itgov_purchases_items a, itgov_purchases b, itgov_purchase_items_type c, itgov_vendors d , itgov_users e
						WHERE a.purchase_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchase_id#" />
						 AND a.vendor_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.vendor_id#" />
						AND a.purchase_id = b.purchase_id AND a.purchasetype_id = c.purchasetype_id 
						AND a.vendor_id = d.vendor_id
						AND b.us_id = e.us_id
			</cfquery>
			<cfset strLocal.data = qryGetList />
		<!--- 	<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Getting List of purchases_items failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	
	</cffunction>
	
	<cffunction name="PriceDataForPrintOrder" returntype="struct" output="false" access="public"
				description="Item data req for printe order">
		<cfargument name="purchase_id" type="numeric" required="false" default="0"  />
		<cfargument name="vendor_id" type="numeric" required="false" default="0"  />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
<!--- 		<cftry> --->
			<cfquery name="qryGetList" datasource="#variables.datasource#">
						SELECT SUM(pad) as totalprice, SUM(shippingcost) as delivery, SUM(grandtotal) as grandtotal, SUM(grandtotal)-SUM(totalamt) AS taxamt,b.symbol as Symbol
						FROM itgov_purchases_items a, itgov_currency b
						WHERE a.purchase_id =	<cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchase_id#" />
						AND a.vendor_id     = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.vendor_id#" /> 
						And a.currency_id = b.currency_id GROUP BY b.symbol
			</cfquery>
			<cfset strLocal.data = qryGetList />
		<!--- 	<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Getting List of purchases_items failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	
	</cffunction>


	<!--- Functions from NandaKishore --->
	
	<cffunction name="deliveryDateAlert" returntype="query" output="false" access="public" hint="gives info about deliveries b/w today & next 6 days">
		<cfset var qryGetList = "" />
            <cfquery name="qryGetList" datasource="#variables.datasource#">
                SELECT a.ins_purchaseid,
                       TO_CHAR(b.expected_delivery_date,'dd-mm-yyyy') deliverydate
                  FROM itgov_purchases a,
                      itgov_purchases_items b
                 WHERE b.purchase_id = a.purchase_id
                   AND b.expected_delivery_date BETWEEN TRUNC(sysdate) AND TRUNC(sysdate + 6)
              ORDER BY b.purchases_items_id ASC
            </cfquery>
		<cfreturn qryGetList />
	</cffunction>
	
    <cffunction name="missedDeliveries" returntype="query" output="false" access="public" hint="Gives the information about missed delivaeries">
		<cfset var qryGetList = "" />
            <cfquery name="qryGetList" datasource="#variables.datasource#">
                SELECT p.ins_purchaseid, 
                	pi.numeroitem, to_char(pi.expected_delivery_date,'dd-MONTH-yyyy') edd
                FROM itgov_purchases p, 
                	itgov_purchases_items pi
                WHERE p.purchase_id=pi.purchase_id 
                	AND pi.expected_delivery_date < trunc(sysdate)
                	AND pi.delivery_status = 0
                    order by pi.expected_delivery_date asc
            </cfquery>
		<cfreturn qryGetList />    
    </cffunction>
</cfcomponent>