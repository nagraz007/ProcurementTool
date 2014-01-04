<cfcomponent displayname="alerts" output="false">
	<cffunction name="init" access="public" returntype="alerts">
		<cfreturn THIS />
	</cffunction>
    
    <cffunction name="missedDeliveries" access="public" output="false" returntype="query">
    	<cfreturn APPLICATION.com.model.PurchItems.missedDeliveries() />
    </cffunction>
    
    <cffunction name="assetRegistrationMismatch" access="public" output="false" returntype="query">
    	<cfreturn APPLICATION.com.model.Purchases.assetsNotRegistered() />
    </cffunction>
    
    <cffunction name="assetToPurchaseCountMismatch" access="public" output="false" returntype="query">
		<cfreturn APPLICATION.com.model.Purchases.productAssetsPurchasesItemsCountMismatch() />		    	
    </cffunction>
    
    <cffunction name="swLicenseTerm" access="public" output="false" returntype="query">
		<cfreturn APPLICATION.com.model.softwares.swLicenseTerm() />		    	
    </cffunction>
    
    <cffunction name="newRequestsAlert" access="public" output="false" returntype="struct">
		<cfreturn APPLICATION.com.model.req.newRequestsAlert() />		    	
    </cffunction>
	
	<cffunction name="delivDate" access="public" output="false" returntype="query">
	 <!--- Written by Nandakishore KULKARNI Added by NagaRaju BHANOORI moved from Reports Controller --->
		<cfreturn  APPLICATION.com.model.PurchItems.deliveryDateAlert() />
	</cffunction> 

</cfcomponent>