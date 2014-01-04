<cfcomponent displayname="utils" output="false">
	
	<cffunction name="init" access="public" returntype="utils" description="Generates an object of itself">
		<cfargument name="datasource" required="true" type="string" />
		<cfset variables.datasource = ARGUMENTS.datasource />
		<cfreturn THIS />
	</cffunction>

	<cffunction name="QryObjCreator" returntype="query" access="private">
		<cfargument name="reqColumns" type="string" required="true" />
		<cfset var getDummyQryObj = '' />
		<cfquery name="getDummyQryObj" datasource="#variables.datasource#">
			SELECT #ARGUMENTS.reqcolumns# FROM DUAL 
		</cfquery>
		<cfreturn getDummyQryObj />
	</cffunction>

	<cffunction name="dbResult" access="public" output="false" returntype="struct"
				description="Fetching the result and error message from returning string from database package">
         <cfargument name="toRead" required="true" type="string" />
		<cfset var retstr= {} />
         <cfset  retStr.success = ListFirst(ARGUMENTS.toRead,"**") neq 0 />
			<cfset  retStr.message	 = ListLast(ARGUMENTS.toRead,"**")  />
         <cfreturn retStr />
      </cffunction>

    <cffunction name="dbResultBreaker" access="public" output="false" returntype="numeric"
	description="Fetching the result from returning string from a database package">
         <cfargument name="toRead" required="true" type="string" />
         <cfreturn ListFirst(ARGUMENTS.toRead,"**") />
      </cffunction>
	
</cfcomponent>