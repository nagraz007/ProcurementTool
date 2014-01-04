<cfcomponent displayname="util" output="false">
	
	<cffunction name="init" access="public" returntype="util" description="Generates an object of itself">
		<cfreturn THIS />
	</cffunction>

	<cffunction name="$starterPack" access="public" returntype="void" output="false"
				description="Starter pack which creates Session">
		<cfargument name="userID" type="numeric" required="true" />
	
		<cfset var lUserQry = APPLICATION.com.model.users.listusers(ARGUMENTS.userID) />
		<cfset var lUserData = $struct() />
		
		<cfset var Keys = lUserQry.data.columnList />
	
		<cfloop list="#Keys#" index="column">
			<cfset structInsert(lUserData, column, lUserQry.data[column]) />
		</cfloop>
		
		<cfset structInsert(SESSION,'userData', lUserData) />	
		<cfset structInsert(SESSION.userData,'ASSETPERMLEVEL', APPLICATION.com.model.AstPerm.listpermissions(SESSION.userdata.assetaccess_id,'').data.permission) />	
		<cfset structInsert(SESSION.userData,'PURCHASEPERMLEVEL', APPLICATION.com.model.PurchPerm.listpermissions(SESSION.userdata.purchaseaccess_id,'').data.permission) />	
	</cffunction>

	<cffunction name="$struct" access="public" returntype="struct" output="false" description="Creates empty structure">
		<cfreturn DUPLICATE(ARGUMENTS) />
	</cffunction>

	<cffunction name="$abort" access="public" returntype="void" output="false" description="It just aborts the whole application!!! ">
		<cfabort />
	</cffunction>

	<cffunction name="$dump" access="public" returntype="void" output="true" description="Dumps every thing which you give it ">
		<cfargument name="toDump" type="any" required="true" />
		<cfargument name="label" type="string" required="false" default="Script Dump" />
		<cfdump var="#ARGUMENTS.toDump#" label="#ARGUMENTS.label#" />
	</cffunction>
	
	<cffunction name="createDirectory" access="public" returntype="void" output="false" description="Creates directory of a Purchase order if it doenst exist">
		<cfargument name="name" type="string" required="false" >
		<cfdirectory action="list" directory="#APPLICATION.uploadpath#" filter="#ARGUMENTS.name#" name="res" />
		<cfif not compare(res.name, '')>
			<cfdirectory action="create" directory="#APPLICATION.uploadpath##ARGUMENTS.name#" />
		</cfif>
	</cffunction>

	<cffunction name="listfiles" access="public" returntype="struct" output="false"
				description="Lists out all files in a the directory of a particular purchase order">
		<cfargument name="subdir" required="true" type="string">
		<cfargument name="searchparam" required="true" type="string">
			<cfset var strLocal = {success = true, message = '', data=''} />
	<!--- 	<cftry> --->
		<cfdirectory action="list" directory="#APPLICATION.uploadpath##ARGUMENTS.subdir#" filter="Q_#searchparam#*|I_#searchparam#*" name="result" />
		
		<cfset strLocal.data = result  />
		<!--- <cfcatch>
			<cfset strLocal.success =  false />
				<cfset strLocal.message = CFCATCH.Message />
		
		</cfcatch>		 
		
		</cftry> --->
	<cfreturn strLocal />
	</cffunction>
	
	<cffunction name="deleteFile" access="remote" returnformat="plain" output="false" description="Delets a file in teh path specified">
		<cfargument name="DocPath" type="string" required="true">
		<cfset var ret ='false' />	
		<cfset var FullPath = APPLICATION.uploadpath & ARGUMENTS.DocPath />	
		<cfsetting showdebugoutput="false" />
		<cfif FileExists(FullPath)>
   			<cffile action="delete" file="#FullPath#">
			<cfset ret ='true' />		
		</cfif>
	
	<cfreturn ret />
	</cffunction>

	<cffunction name="$replacePlaceholders" access="public" returntype="string" output="false" description="Replaces place hoolders in mails...More details Contact Sanjeev">
    	<cfargument name="type" type="numeric" required="yes" />
        <cfargument name="mainContent" type="string" required="yes" />
        <cfargument name="toReplaceWith" type="string" required="yes" />
        
        <cfscript>
        	var placeHolders = '';
			var i = 1;
			var mainString = ARGUMENTS.mainContent;
			var replaceWith = listToArray(ARGUMENTS.toReplaceWith,"|",true);
			
			switch(ARGUMENTS.type){
				case 1:
					placeHolders = '[Firstname],[Lastname]';
					break;
        		case 2:
					placeHolders = '[Vendorname]';
					break;
				case 3:
					placeHolders = '[BudgetManager]';
					break;
			}
			placeHolders = listToArray(placeHolders,",",true);
			
			while(i LTE ArrayLen(placeHolders)){
				mainString = Replace(mainString, placeHolders[i], replaceWith[i],"all");
				i = i + 1;
			}
			return mainString;
        </cfscript>	
    </cffunction>

	<cffunction name="ForEditableGrid" access="public" returntype="string" output="false" description="Gives all drop -down options for in grids" >
		<cfargument name="gridName" type="string" required="true">
		<cfargument name="columnName" type="string" required="true">
		<cfargument name="id" type="string" required="true">
		<cfset var ret = '' />
		<cfset var arr = ''>
		<cfset var i= 0>
		<cfset var vendor = ''>
		<cfset var dept = ''>
		<cfset var AstRoles = '' />
		<cfset var PurchaseRoles = '' />
			
			<cfswitch expression = "#ARGUMENTS.columnName#">
					<cfcase value="VENDOR_NAME">
							<cfset vendor = APPLICATION.com.model.vendors.listvendors(0,'')  /> 
						<cfloop query="vendor.data">
								<cfif currentrow eq 1>
									<cfset arr =	"['#vendor_name#']" />
								<cfelse>				
									<cfset arr = arr &  ",['#vendor_name#']" />
								</cfif>
							</cfloop>
					
					</cfcase> 

					<cfcase value="USERNAME">
								<cfset user = APPLICATION.com.model.users.listusers(0)  /> 
						<cfloop query="user.data">
								<cfif currentrow eq 1>
									<cfset arr =	"['#Replace(username,'\', '\\')#']" />
								<cfelse>				
									<cfset arr = arr &  ",['#Replace(username,'\', '\\')#']" />
								</cfif>
							</cfloop>
					
					</cfcase> 
					
					<cfcase value="OWNED_LEASED">
								
							<cfset arr = "['Own'],['Lease']" />					
					</cfcase> 
					
					<cfcase value="OLD_NEW">
								
							<cfset arr = "['OLD'],['NEW']" />					
					</cfcase> 
					
					<cfcase value="TYPE_OF_SOFTWARE">
								
							<cfset arr = "['Individual'],['Organizationwide'],['Department']" />					
					</cfcase> 
					
					<cfcase value="REQUEST_STATUS">
								
							<cfset arr = "['Pending'],['Passed'],['Remove']" />					
					</cfcase> 

					<cfcase value="GLOCATION">
								
							<cfset arr = "['MiddleEast'],['Asia'],['Europe']" />					
					</cfcase> 

					<cfcase value="CAMPUS">
								
							<cfset arr = "['MiddleEast'],['Asia'],['Europe']" />					
					</cfcase> 
					
					<cfcase value="NAME">
							 <cfset dept = APPLICATION.com.control.admin.ListDepartments().data />
						<cfloop query="dept">
								<cfif currentrow eq 1>
									<cfset arr =	"['#name#']" />
								<cfelse>				
									<cfset arr = arr &  ",['#name#']" />
								</cfif>
							</cfloop>
					</cfcase>
				
					<cfcase value="ASSETROLE">
							 <cfset AstRoles = APPLICATION.com.control.admin.listofAstRoles() />
						<cfloop query="AstRoles.data">
								<cfif currentrow eq 1>
									<cfset arr =	"['#role#']" />
								<cfelse>				
									<cfset arr = arr &  ",['#role#']" />
								</cfif>
							</cfloop>
					</cfcase>
					
					<cfcase value="PURCHASEROLE">
							 <cfset PurchaseRoles = APPLICATION.com.control.admin.listofPurchRoles() />
						<cfloop query="PurchaseRoles.data">
								<cfif currentrow eq 1>
									<cfset arr =	"['#role#']" />
								<cfelse>				
									<cfset arr = arr &  ",['#role#']" />
								</cfif>
							</cfloop>
					</cfcase>
			</cfswitch>
			
		
		<cfoutput><cfsavecontent variable="ret">
				grid = ColdFusion.Grid.getGridObject("#ARGUMENTS.gridName#");
		//column model
			cm = grid.getColumnModel();
		//we need to know the column id
	stIndex = cm.findColumnIndex("#ARGUMENTS.columnName#");
	cb = new Ext.form.ComboBox({
	id:"#ARGUMENTS.id#",
	mode:"local",
	triggerAction:"all",
	displayField:"text",

	store:new Ext.data.SimpleStore({
	fields: ["text"],
	data: [ #arr#
		]
	})
	});

	cm.setEditor(stIndex,new Ext.grid.GridEditor(cb));

		
		</cfsavecontent></cfoutput>	
	<cfreturn ret />
	</cffunction>

	<cffunction name="$ldapAuthenticate" returntype="struct" output="false" access="public" 
				description="Authenticating a user from Active Directory with username and password ">
		<cfargument name="userName" required="true" type="string" />
		<cfargument name="password" required="true" type="string" />
		<cfreturn APPLICATION.AuthWS.authenticate(ARGUMENTS.userName, ARGUMENTS.password , APPLICATION.authWSUser, APPLICATION.authWSPass) />
	</cffunction>
	
	<cffunction name="$ldapFind" returnFormat="json" output="false" access="remote"
				description="Finds matching usernames from Active directory">
		<cfargument name="userName" required="true" type="string" />
		<cfscript>
			var domain = ListFirst(ARGUMENTS.userName,'\');
			var usrName = ListLast(ARGUMENTS.userName,'\');
			var doFind = APPLICATION.AuthWS.getProfileInformationByAccName(ListLast(ARGUMENTS.userName,'\'),APPLICATION.authWSUser, APPLICATION.authWSPass, domain);
			/*
			var res = $struct(found = false, data = '');
			if (doFind.recordCount neq 0){
				res.found = true;
				res.data = $queryToStruct(doFind);
			}*/
		</cfscript>
		<cfreturn $getColumnValues('GIVENNAME,SN,MAIL',doFind) />
	</cffunction>

	<cffunction name="$getColumnValues" access="public" output="false" returntype="any">
	   <cfargument name="columnName" required="true" type="string" />
	   <cfargument name="queryObjectName" required="true" type="any" />
	   <cfargument name="asList" required="false" type="boolean" default="false"/>
	   <cfargument name="conditions" required="false" type="string" />
	   <cfargument name="checks" required="false" type="string" />

       <cfset var breakGlass = '' />
       <cfset var i = 1 />

	   <cfquery name="breakGlass" dbtype="query">
          SELECT <cfif listFind(ARGUMENTS.columnName,'count') gt 0>
				    count(#ARGUMENTS.columnName#) as ColumnCount
				 <cfelse>
				    #ARGUMENTS.columnName#
				 </cfif>
            FROM <cfif isSimpleValue(ARGUMENTS.queryObjectName)>#ARGUMENTS.queryObjectName#<cfelse>ARGUMENTS.queryObjectName</cfif>
		   WHERE 1 = 1

		   <cfif StructKeyExists(ARGUMENTS,'conditions')>
			 <cfloop condition="i lte #listlen(ARGUMENTS.conditions)#">
			AND #ListGetAt(ARGUMENTS.conditions,i)# '#ListGetAt(ARGUMENTS.checks,i)#'
			 <cfset i = i + 1 />
			 </cfloop>
			</cfif>

        </cfquery>

		<cfif listFind(ARGUMENTS.columnName,'count') gt 0 and breakGlass.ColumnCount eq ''>
			<cfset QueryAddrow(breakGlass, 1) />
			<cfset QuerySetcell(breakGlass,'ColumnCount',0) />
		</cfif>
        <cfif ARGUMENTS.asList>
		    <cfreturn arrayToList(breakGlass[ARGUMENTS.columnName],",")/>
		<cfelse>
            <cfreturn breakGlass />
		</cfif>
	</cffunction>

    <cffunction name="$readCSV" access="public" output="false" returntype="array">
        <cfargument name="File" type="string" required="false" default="" hint="The optional file containing the CSV data." />
        <cfargument name="CSV" type="string" required="false" default="" hint="The CSV text data (if the file was not used)."/>
        <cfargument name="Delimiter" type="string" required="false" default="," hint="The data field delimiter."/>
        <cfargument name="Trim" type="boolean" required="false" default="true" hint="Flags whether or not to trim the END of the file for line breaks and carriage returns."/>
            <cfset var LOCAL = StructNew() />
            <cfif Len( ARGUMENTS.File )>
                <cfset LOCAL.fileName = Application.MailUploadpath & ARGUMENTS.File>
                <cffile
                    action="read"
                    file="#LOCAL.fileName#"
                    variable="ARGUMENTS.CSV"
                    />
            </cfif>
            <cfif ARGUMENTS.Trim>
                <cfset ARGUMENTS.CSV = REReplace(
                    ARGUMENTS.CSV,
                    "[\r\n]+$",
                    "",
                    "ALL"
                    ) />
                <cfset ARGUMENTS.CSV = replace(ARGUMENTS.CSV,",,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,","","ALL")/>
            </cfif>
            <cfif (Len( ARGUMENTS.Delimiter ) NEQ 1)>
                <cfset ARGUMENTS.Delimiter = "," />
            </cfif>
            <cfset LOCAL.Pattern = CreateObject(
                "java",
                "java.util.regex.Pattern"
                ).Compile(
                    JavaCast(
                        "string",

                        <!--- Delimiter. --->
                        "\G(\#ARGUMENTS.Delimiter#|\r?\n|\r|^)" &

                        <!--- Quoted field value. --->
                        "(?:""([^""]*+(?>""""[^""]*+)*)""|" &

                        <!--- Standard field value --->
                        "([^""\#ARGUMENTS.Delimiter#\r\n]*+))"
                        )
                    )
                />
            <cfset LOCAL.Matcher = LOCAL.Pattern.Matcher(
                JavaCast( "string", ARGUMENTS.CSV )
                ) />
            <cfset LOCAL.Data = ArrayNew( 1 ) />
            <!--- Start off with a new array for the new data. --->
            <cfset ArrayAppend( LOCAL.Data, ArrayNew( 1 ) ) />

            <cfloop condition="LOCAL.Matcher.Find()">

                <cfset LOCAL.Delimiter = LOCAL.Matcher.Group(
                    JavaCast( "int", 1 )
                    ) />
                <cfif (
                    Len( LOCAL.Delimiter ) AND
                    (LOCAL.Delimiter NEQ ARGUMENTS.Delimiter)
                    )>

                    <!--- Start new row data array. --->
                    <cfset ArrayAppend(
                        LOCAL.Data,
                        ArrayNew( 1 )
                        ) />

                </cfif>

                <cfset LOCAL.Value = LOCAL.Matcher.Group(
                    JavaCast( "int", 2 )
                    ) />


                <cfif StructKeyExists( LOCAL, "Value" )>
                    <cfset LOCAL.Value = Replace(
                        LOCAL.Value,
                        """""",
                        """",
                        "all"
                        ) />
                <cfelse>
                    <cfset LOCAL.Value = LOCAL.Matcher.Group(
                        JavaCast( "int", 3 )
                        ) />
                </cfif>

                <cfset ArrayAppend(
                    LOCAL.Data[ ArrayLen( LOCAL.Data ) ],
                    LOCAL.Value
                    ) />

            </cfloop>

            <!--- Remove the Header data --->
            <cfset arrayDeleteAt(local.Data, 1) />

            <cfreturn LOCAL.Data />
    </cffunction>

</cfcomponent>