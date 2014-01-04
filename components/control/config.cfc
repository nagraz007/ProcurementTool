<cfcomponent displayname="config" output="false">

	<cffunction name="init" access="public" returntype="config" output="false">
		<cfset var xmlDocPath = #APPLICATION.directory_server# 
								& #APPLICATION.directory_application# 
								& #APPLICATION.path_application# 
								& 'components\' />
								
		<cffile action="read" file="#xmlDocPath#userMessages.xml" variable="userMessages" />
		<cfset VARIABLES.userMessages = XMLParse(userMessages) />

		<cfreturn THIS/>
	</cffunction>
	
	<cffunction name="getMessageForCode" returntype="string" output="false" access="public"> 
		<cfargument name="code" required="true" type="string" />
			<cfset var lang = 'EN' />
			<cfset var sMessage = '' />
			
			<cfif isDefined("SESSION.userData.MsgLanguage")>
				<cfset lang = SESSION.userData.MsgLanguage />
			</cfif>
			
			<cfset sMessage = xmlSearch(VARIABLES.userMessages, "//message[@id='#code#'][@lan='#lang#']") />
		<cfreturn sMessage[1].XMLAttributes.text />
	</cffunction>
	
	
</cfcomponent>