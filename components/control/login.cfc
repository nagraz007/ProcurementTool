<cfcomponent displayname="login" output="false" extends="config">

	<cffunction name="init" access="public" returntype="login" description="Generates an object of itself">
		<cfset SUPER.init() />
		<cfreturn THIS />
	</cffunction>

	<cffunction name="validateUser" returntype="struct" output="false" access="public"
				description="Validates User for Loggin into teh application">
		<cfargument name="userName" required="true"  type="string" />
		<cfargument name="passWord" required="true"  type="string" />
		
		<cfscript>
			var UsID = 0;
			var result = {message = '',success = false};
	
			
			if( checkLDAP( ARGUMENTS.userName, ARGUMENTS.passWord ) ){
				UsId = checkDB(ARGUMENTS.userName);
				switch(UsId){
					case 0:
						result.message = SUPER.getMessageForCode('LG-002');
					break;
					case -1:
						result.message = SUPER.getMessageForCode('LG-003');
					break;
					default:
						APPLICATION.com.util.$starterPack(UsId);
						result.success = true;
						}
			}
			else
			{
				result.message = SUPER.getMessageForCode('LG-001');
			}
			
			return result;
		</cfscript>
		
	</cffunction>

	<cffunction name="checkDB" returntype="numeric" output="false" access="private"
				description="checks database for existence of user">
		<cfargument name="userName" required="true" type="string" />	
		<cfreturn APPLICATION.com.model.users.authenticateUserForLogin(ARGUMENTS.userName) />
	</cffunction>

	<cffunction name="checkLDAP" returntype="boolean" output="false" access="private"
				description="pings Active Directory for Authenticating Username and Password">
		<cfargument name="userName" required="true" type="string" />	
		<cfargument name="password" required="true"  type="string" />
			<cfset authenticate = APPLICATION.com.util.$ldapAuthenticate(ARGUMENTS.userName, ARGUMENTS.password) />
		<cfreturn authenticate.Authenticated eq 'YES' />
	</cffunction>

</cfcomponent>