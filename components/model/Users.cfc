<cfcomponent displayname="Users" output="false">

	<cffunction name="init" access="public" returntype="users" description="Generates an object of itself">
		<cfargument name="datasource" required="true" type="string" />
		<cfset variables.datasource = ARGUMENTS.datasource />
		<cfreturn THIS />
	</cffunction>

	<cffunction name="listusers" returntype="struct" output="false" access="public"
				description="List All users from database ">
		<cfargument name="us_id" type="numeric" required="false" default="0"  />
	<!--- 	<cfargument name="username" type="string" required="false" default=""  /> --->
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
		<cftry>
			<cfquery name="qryGetList" datasource="#variables.datasource#">
				SELECT us_id, username, middlename, campus, email, workphone, mobilephone , fax 
					   , assetaccess_id , purchaseaccess_id , depart_id, msglanguage ,
					   Initcap(firstname) as firstname, upper(lastname) as lastname,
					   Initcap(firstname)||' '||upper(lastname) as name
				  FROM itgov_users 
				  WHERE 1 = 1 
						<cfif ARGUMENTS.us_id neq 0>
				   			AND us_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.us_id#" />
						</cfif>
							AND active_status = 1 
<!--- 						<cfif ARGUMENTS.name neq ''>
							 AND username = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.username#" />
						</cfif> --->
			</cfquery>
			<cfset strLocal.data = qryGetList />
			<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Getting List of users failed" />
			</cfcatch>
		</cftry>
		<cfreturn strLocal />
	</cffunction>
	
	<cffunction name="authenticateUserForLogin" returntype="numeric" output="false" access="public"
				description="Gives system userid for a username if found else appropriate error numbers">
			<cfargument name="username" type="string" required="true"  />
			<cfset var strLocal = {success = true, data=''} />
			<cfset var qryTestUserName = "" />
		<cftry>
				<cfquery name="qryTestUserName" datasource="#variables.datasource#">
						SELECT us_id
						FROM itgov_users 
						WHERE lower(username) = lower(<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.username#" />)
						AND active_status = 1
						AND accessrights = 1
					</cfquery>
				<cfset strLocal.data = qryTestUserName />
				<cfcatch type="any">
					<cfset strLocal.success = false />
				</cfcatch>
			</cftry>
			<cfif strLocal.success>
				<cfif strLocal.data.recordcount neq 0>
					<cfreturn strLocal.data.us_id />
				<cfelse>
					<cfreturn 0 />
				</cfif>
			<cfelse>
				<cfreturn -1 />
			</cfif>
		</cffunction>
	
	<cffunction name="authenticateUser" returntype="numeric" output="false" access="public"
				description="Gives system userid for a username ">
			<cfargument name="username" type="string" required="true"  />
			<cfset var strLocal = {success = true, data=''} />
			<cfset var qryTestUserName = "" />
		<cftry>
				<cfquery name="qryTestUserName" datasource="#variables.datasource#">
						SELECT us_id
						FROM itgov_users 
						WHERE lower(username) = lower(<cfqueryparam cfsqltype="cf_sql_varchar" value="#ARGUMENTS.username#" />)
					</cfquery>
				<cfset strLocal.data = qryTestUserName />
				<cfcatch type="any">
					<cfset strLocal.success = false />
				</cfcatch>
			</cftry>
			<cfif strLocal.success>
				<cfif strLocal.data.recordcount neq 0>
					<cfreturn strLocal.data.us_id />
				<cfelse>
					<cfreturn 0 />
				</cfif>
			<cfelse>
				<cfreturn -1 />
			</cfif>
		</cffunction>

	<cffunction name="getEmail" returntype="struct" output="false" access="public"
				description="Gives Email of a user from database ">
		<cfargument name="us_id" type="numeric" required="false" default="0"  />
	<!--- 	<cfargument name="username" type="string" required="false" default=""  /> --->
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
		<!--- <cftry> --->
			<cfquery name="qryGetList" datasource="#variables.datasource#">
				SELECT email
				  FROM itgov_users 
				  WHERE us_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.us_id#" />
			</cfquery>
			<cfset strLocal.data = qryGetList />
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Getting List of users failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="autosuggest" access="remote" returntype="array" description="Auto suggests username from database" >
		<cfargument name="search" type="any" required="false" default="">
		<cfset var result=ArrayNew(1) />
		<cfif not structKeyExists(variables,"datasource")>
				<cfset variables.datasource = APPLICATION.dsn_operEvents />
		</cfif>
		<cfquery name="qryGetList" datasource="#variables.datasource#">
					SELECT  username
					FROM itgov_users
					WHERE 
					upper(username) LIKE upper('#ARGUMENTS.search#%')
					AND Active_status = 1
					ORDER BY username
				</cfquery>
		<cfloop query="qryGetList">
			<cfset ArrayAppend(result, username) />
		</cfloop>		
		<cfreturn result>
	</cffunction>

<!--- 
	<cffunction name="assignAccess" access="public" returntype="struct" 
				description="Assigns appropriate access role depending on existing role and previous role">
		<cfargument name="AstOrPurch" type="numeric" required="true">
		<cfargument name="accessid" type="numeric" required="true">
		<cfargument name="us_id" type="numeric" required="true">
		<cfargument name="lastmodifiedby" type="numeric" required="true">
		<cfset var strLocal = {success = true, message=""} />
	<!--- 	<cftry> --->
		<cfif ARGUMENTS.AstOrPurch eq 0>
			<cfquery datasource="#variables.datasource#">
							UPDATE itgov_users 
							SET assetaccess_id = (select assetaccess_id from itgov_asset_permissions where permission = (select max(s) FROM (
										select permission as s, a.assetaccess_id as id from itgov_asset_permissions a,itgov_users b
												where b.assetaccess_id = a.assetaccess_id
													and us_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.us_id#" />
																		UNION
										select permission as s, a.assetaccess_id as id from  itgov_asset_permissions a where a.assetaccess_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.accessid#" />
																	) 
													)),
								lastmodifiedby = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.lastmodifiedby#" />,
								lastmodifiedon = sysdate
							WHERE us_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.us_id#" />
						</cfquery>
		<cfelse>
			<cfquery datasource="#variables.datasource#">
							UPDATE itgov_users 
							SET purchaseaccess_id = (select purchaseaccess_id from itgov_purchase_permissions where permission = (select max(s) FROM (
										select permission as s, a.purchaseaccess_id as id from itgov_purchase_permissions a,itgov_users b
												where b.purchaseaccess_id = a.purchaseaccess_id
													and us_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.us_id#" />
																		UNION
										select permission as s, a.purchaseaccess_id as id from  itgov_purchase_permissions a where a.purchaseaccess_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.accessid#" />
																	) )),
								lastmodifiedby = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.lastmodifiedby#" />,
								lastmodifiedon = sysdate
							WHERE us_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.us_id#" />
						</cfquery>
		</cfif>
		 <!--- <cfcatch type="any">
			<cfset strLocal.success = false />
			<cfset strLocal.message = "Assigning Access failed" />
			</cfcatch>
			</cftry> --->
		<cfreturn strLocal />
	</cffunction>
 --->
	<cffunction name="assignAccess" access="public" returntype="struct" 
				description="Assigns appropriate access role depending on existing role and previous role">
		<cfargument name="AstOrPurch" type="numeric" required="true">
		<cfargument name="accessid" type="numeric" required="true">
		<cfargument name="us_id" type="numeric" required="true">
		<cfargument name="lastmodifiedby" type="numeric" required="true">
		<cfset var strLocal = {success = true, message=""} />
	<!--- 	<cftry> --->
		<cfif ARGUMENTS.AstOrPurch eq 0>
			<cfquery datasource="#variables.datasource#">
							UPDATE itgov_users 
							SET assetaccess_id =  <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.accessid#" />,
								lastmodifiedby = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.lastmodifiedby#" />,
								lastmodifiedon = sysdate
							WHERE us_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.us_id#" />
						</cfquery>
		<cfelse>
			<cfquery datasource="#variables.datasource#">
							UPDATE itgov_users 
							SET purchaseaccess_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.accessid#" />,
								lastmodifiedby = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.lastmodifiedby#" />,
								lastmodifiedon = sysdate
							WHERE us_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.us_id#" />
						</cfquery>
		</cfif>
		 <!--- <cfcatch type="any">
			<cfset strLocal.success = false />
			<cfset strLocal.message = "Assigning Access failed" />
			</cfcatch>
			</cftry> --->
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="listPermissions" access="public" returntype="struct"
		description="Lists all permissions for grid of all users frmo data base who are active">
		<cfargument name="gridsortcolumn" type="string" required="false" default="" />
		<cfargument name="gridstartdirection" type="string" required="false" default="" />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
		<!--- 		<cftry> --->
		<cfquery name="qryGetList" datasource="#variables.datasource#">
			SELECT a.username, Initcap(a.firstname)||' '||upper(a.lastname) as name, b.role as assetrole, c.role as purchaserole, a.us_id   
			FROM itgov_users a, itgov_asset_permissions b, itgov_purchase_permissions c
			WHERE a.assetaccess_id = b.assetaccess_id 
			AND a.purchaseaccess_id = c.purchaseaccess_id
			AND a.active_status = 1
				<cfif ARGUMENTS.gridsortcolumn neq '' AND ARGUMENTS.gridstartdirection neq '' >
					<cfif ARGUMENTS.gridsortcolumn eq 'username'  >		
									ORDER BY a.username  #ARGUMENTS.gridstartdirection# 
							<cfelseif ARGUMENTS.gridsortcolumn eq 'assetrole' >					
									ORDER BY b.role  #ARGUMENTS.gridstartdirection# 
							<cfelseif ARGUMENTS.gridsortcolumn eq 'purchaserole'>
									ORDER BY c.role  #ARGUMENTS.gridstartdirection# 
							<cfelseif ARGUMENTS.gridsortcolumn eq 'name'>
									ORDER BY a.firstname  #ARGUMENTS.gridstartdirection# 
						</cfif> 
				</cfif>
		</cfquery>
		<cfset strLocal.data = qryGetList  />
	<!--- <cfcatch type="any">
					
				<cfset strLocal.success =  false />
				<cfset strLocal.message = 'Fetching list of permissions failed' />
			</cfcatch>
		</cftry >--->
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="listusernames" returntype="struct" output="false" access="public"
				description="Lists put names and usernames from database">
		<cfargument name="us_id" type="numeric" required="false" default="0"  />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
		<!--- <cftry> --->
			<cfquery name="qryGetList" datasource="#variables.datasource#">
				SELECT us_id, username, Initcap(firstname)||' '||upper(lastname) as name
				  FROM itgov_users 
				  WHERE 1 = 1 
						<cfif ARGUMENTS.us_id neq 0>
				   			AND us_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.us_id#" />
						</cfif>
<!--- 						<cfif ARGUMENTS.name neq ''>
							 AND username = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.username#" />
						</cfif> --->
			</cfquery>
			<cfset strLocal.data = qryGetList />
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Getting List of users failed" />
			</cfcatch>
		</cftry --->>
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="updateLastAccessed" returntype="struct" output="false" access="public"
				description="Update last accessed detail in databse after logout">
		<cfargument name="us_id" required="true" type="numeric">
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cftry>
			<cfquery name="qryupDate" datasource="#variables.datasource#">
				UPDATE itgov_users
				set lastaccessedby = ,
				lastaccessedon = sysdate
			</cfquery>
			<cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Getting List of users failed" />
			</cfcatch>
		</cftry>
		<cfreturn strLocal />
	</cffunction>
	
	<cffunction name="userProductIdForSearch" returntype="struct" output="false" access="public"
				description="seraching products of a user from database">
		<cfargument name="search" type="string" required="false" default="">
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
		<cfquery name="qryGetList" datasource="#variables.datasource#">
					SELECT  b.product_id
					FROM itgov_users a, itgov_products b, itgov_prdusrhistory c
					WHERE 
					upper(a.username) LIKE upper('#ARGUMENTS.search#%')
					AND a.us_id = c.us_id
					AND b.product_id = c.product_id (+)
					AND Active_status = 1
					ORDER BY a.username
				</cfquery>
				<cfset strLocal.data = qryGetList  />
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="updateExpireAction" returntype="struct" output="false" access="public"
				description="Update expire/disable details of user">
		<cfargument name="us_id" type="numeric" required="true"/>
		<cfargument name="active_status" type="numeric" required="false" default="" />
		<cfargument name="lastmodifiedby" type="numeric" required="true" />
		<cfset var strLocal = {success = true, message=""} />
		<!---  <cftry> ---> 
			<cfquery name="qryUpdateproduct" datasource="#variables.datasource#">
					UPDATE itgov_users
					SET
						active_status = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.active_status#" />,
					 	lastmodifiedby = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.lastmodifiedby#" />,
					 	lastmodifiedon = sysdate
					 WHERE us_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.us_id#" />
				</cfquery>
			<!---  <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Updating Product info  failed" />
			</cfcatch>
		</cftry>  --->
		<cfreturn strLocal />
	</cffunction>

	<!--- Nandus functions --->
	        
    <cffunction name="checkUsername" access="remote" returnformat="json" output="false">
        <cfargument name="Username" required="true">
		<cfset var qryGetusername = "" />
        <cfquery name="qryGetusername" datasource="#variables.datasource#">
        	SELECT US_ID 
              FROM itgov_users 
             WHERE lower(username ) = lower(<cfqueryparam value="#arguments.Username#" cfsqltype="cf_sql_varchar" />)
        </cfquery>	
        <cfreturn yesNoFormat(qryGetusername.recordCount)/>
    </cffunction>
    
    <cffunction name="searchUsers" returntype="struct" output="false" access="public"> <!--- Modified by Naga Raju Bhanoori --->
		<cfargument name="gridsortcolumn" type="string" required="true" />
		<cfargument name="gridstartdirection" type="string" required="true" />
        <cfargument name="searchKey" type="string" required="true" />
        <cfargument name="Campus" type="string" required="false" />
        <cfargument name="department" type="numeric" required="false" />
		<cfset var strLocal = {success = true, message="", data = ''} />
		<cfset var qryGetList = "" />
<!--- 		<cftry> --->
				<cfquery name="qryGetList" datasource="#variables.datasource#">
					SELECT DISTINCT US_ID, USERNAME, FIRSTNAME, MIDDLENAME, LASTNAME, CAMPUS, EMAIL, WORKPHONE, MOBILEPHONE, FAX, ITGOV_DEPARTMENTS.NAME,
					case 
								when active_status= 0 THEN
									'<input type="button" name="theEnd"  value=" E " class="gre" onclick="act_s(1,'||us_id||')" title="Enable this  User"/>' 
								WHEN active_status= 1 THEN  
									'<input type="button" name="theEnd" value=" D "  class="req" onclick="act_s(0,'||us_id||')"  title="Disable this User"/>'
								END  AS button
					FROM ITGOV_USERS,ITGOV_DEPARTMENTS,dual
                    WHERE 
                    	ITGOV_USERS.DEPART_ID = ITGOV_DEPARTMENTS.DEPART_ID 
                    AND
                    (
                    	UPPER(USERNAME) LIKE <cfqueryparam value="%#UCase(ARGUMENTS.searchKey)#%" cfsqltype="cf_sql_varchar" />
                    OR
                    	UPPER(FIRSTNAME) LIKE <cfqueryparam value="%#UCase(ARGUMENTS.searchKey)#%" cfsqltype="cf_sql_varchar" />
                    OR
                    	UPPER(LASTNAME) LIKE <cfqueryparam value="%#UCase(ARGUMENTS.searchKey)#%" cfsqltype="cf_sql_varchar" />
                     )   
                    <cfif ARGUMENTS.Campus NEQ 0 >
					AND
                    	CAMPUS = <cfqueryparam value="#ARGUMENTS.Campus#" cfsqltype="cf_sql_varchar" />
					</cfif>
                    <cfif ARGUMENTS.department NEQ 0>
					AND
                	    ITGOV_USERS.DEPART_ID = <cfqueryparam value="#ARGUMENTS.department#" cfsqltype="cf_sql_integer" />
					</cfif>
                    <cfif ARGUMENTS.gridsortcolumn neq '' AND ARGUMENTS.gridstartdirection neq '' >
						ORDER BY #ARGUMENTS.gridsortcolumn#  #ARGUMENTS.gridstartdirection# 
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

	<cffunction name="insertuser" returntype="struct" output="false" access="public">
		<cfargument name="username" type="string" required="true" />
        <cfargument name="department" type="numeric" required="false"  />
		<cfargument name="firstname" type="string" required="false"/>
		<cfargument name="middlename" type="string" required="false"/>
		<cfargument name="lastname" type="string" required="false"/>
		<cfargument name="campus" type="string" required="false"/>
		<cfargument name="email" type="string" required="false"/>
		<cfargument name="workphone" type="string" required="false" />
		<cfargument name="mobilephone" type="string" required="true" />
		<cfargument name="fax" type="string" required="false"/>
		<cfargument name="assetaccess_id" type="string" required="false"/>
		<cfargument name="purchaseaccess_id" type="string" required="false"/>
		<cfargument name="active_status" type="string" required="false"/>
		<cfargument name="access" type="string" required="false"/>
        <cfargument name="createdBy" type="string" required="false"  />
		<cfset var strLocal = {success = true, message=""} />
		<!--- <cftry> --->
           <!--- <cfscript>
			application.com.util.$dump(deptID);
			application.com.util.$dump(ARGUMENTS.creationDate);
			application.com.util.$dump(ARGUMENTS.createdBy);
			application.com.util.$abort();
			</cfscript> --->
			<cfquery name="qryInsertuser" datasource="#variables.datasource#">
				INSERT INTO itgov_users ( username, firstname, middlename, lastname, campus, email, workphone, mobilephone, fax,
									 	  depart_id, assetaccess_id, purchaseaccess_id, active_status, accessrights, firstcreatedon, firstcreatedby) 
				VALUES ( <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.username#" />
						, <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.firstname#" />
						, <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.middlename#" />
						, <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.lastname#" />
						, <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.campus#" />
						, <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.email#" />
						, <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.workphone#" />
						, <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.mobilephone#" />
						, <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.fax#" />
                        , <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.department#" />
                        , <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.assetaccess_id#" />
                        , <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.purchaseaccess_id#" />
                        , <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.active_status#" />
                        , <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.access#" />
						, sysdate
                        , <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.createdBy#" />
					) 
			</cfquery>
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Inserting user failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="updateuser" returntype="struct" output="false" access="public">
		<cfargument name="us_id" type="numeric" required="true" />
		<cfargument name="firstname" type="string" required="false" default="" />
		<cfargument name="middlename" type="string" required="false" default="" />
		<cfargument name="lastname" type="string" required="false" default=""/>
        <cfargument name="campus" type="string" required="false" default=""/>
		<cfargument name="email" type="string" required="false" default=""/>
		<cfargument name="workphone" type="string" required="false" default=""/>
		<cfargument name="mobilephone" type="string" required="false" default=""/>
		<cfargument name="fax" type="string" required="false"  default=""/>
        <cfargument name="depart_id" type="numeric" required="false"  default=""/>
        <cfargument name="lastmodifiedby" type="string" required="true" />
		<cfargument name="lastmodifiedon" type="string" required="true"  />
		<cfset var strLocal = {success = true, message=""} />
		<!--- <cftry> --->
			<cfquery name="qryupdateuser" datasource="#variables.datasource#">
					UPDATE itgov_users 
					   SET 	 
                       		<cfif ARGUMENTS.firstname neq '' >
                       		 	firstname = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.firstname#" />,
                             </cfif>
                             <cfif ARGUMENTS.middlename neq '' >
								middlename = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.middlename#" />,
                             </cfif>
                             <cfif ARGUMENTS.lastname neq '' >
							 	lastname =  <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.lastname#" />,
                             </cfif>
                             <cfif ARGUMENTS.campus neq '' >
							 	campus =  <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.campus#" />,
                             </cfif>
                             <cfif ARGUMENTS.email neq '' >   
							 	email =  <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.email#" />,
                              </cfif>
                              <cfif ARGUMENTS.workphone neq '' >  
							  	workphone =  <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.workphone#" />,
                               </cfif>
                               <cfif ARGUMENTS.mobilephone neq '' >
							   	mobilephone =  <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.mobilephone#" />,
                               </cfif>
                               <cfif ARGUMENTS.fax neq '' >
									fax =  <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.fax#" />,
                                </cfif>
                                <cfif ARGUMENTS.depart_id neq 0 >
									depart_id =  <cfqueryparam cfsqltype="cf_sql_integer"  value="#ARGUMENTS.depart_id#" />,
                                </cfif>
                                lastmodifiedby = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.lastmodifiedby#" />,
					 			lastmodifiedon = <cfqueryparam cfsqltype="cf_sql_varchar"  value="#ARGUMENTS.lastmodifiedon#" />    
					WHERE 
							us_id = <cfqueryparam cfsqltype="cf_sql_numeric"  value="#ARGUMENTS.us_id#" />
				</cfquery>
			<!--- <cfcatch type="any">
				<cfset strLocal.success = false />
				<cfset strLocal.message = "Updating vendor info  failed" />
			</cfcatch>
		</cftry> --->
		<cfreturn strLocal />
	</cffunction>

	<cffunction name="removeuser" returntype="struct" output="false" access="public">
		<cfargument name="us_id" type="numeric" required="true" />
		<cfset var strLocal = {success = true, message=""} />
		<cftry>
			<cfquery name="qryDeleteuser" datasource="#variables.datasource#" >
				UPDATE itgov_users 
                SET ACTIVE_STATUS = 0 
				 WHERE us_id= <cfqueryparam cfsqltype="cf_sql_numeric" value="#ARGUMENTS.us_id#" />
			</cfquery>
			<cfcatch type="any">
				<cfset strLocal.success="false" />
				<cfset strLocal.message="Deleting user failed" />
			</cfcatch>
		</cftry>
		<cfreturn strLocal />

	</cffunction>
	
<!--- 	<cffunction name="listBudgetApprovers" returntype="query" output="false" access="public">
		<cfset var qryGetList = "" />
		<cfquery name="qryGetList" datasource="#variables.datasource#">
			SELECT Initcap(u.firstname)||' '||upper(u.lastname) as name,
					email ||'|'||Initcap(u.firstname)||' '||upper(u.lastname) combined
			  FROM itgov_users u, itgov_purchase_permissions p
			  WHERE u.purchaseaccess_id = p.purchaseaccess_id
			    AND p.permission in (4,6)
		</cfquery>
		<cfreturn qryGetList />
	</cffunction>
	 --->
</cfcomponent>
