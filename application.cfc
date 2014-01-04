<!--- 
	Application Name: AssetProcurementDaily
	
	Department: IT Procurement
	Head : Jae CHAE
	
	Developed by : Nagaraju BHANOORI
	Technical Assistance : Sanjeev Krishna MANDALAPU

	First Coded on Date: 23-Sep-2011
 --->

<cfcomponent displayname="Application.cfc" output="false">
	<cfscript>
		THIS.name = "AssetPurchaseTool_Upd";
		THIS.clientManagement = true;
		THIS.sessionManagement = true;
		THIS.sessionTimeout = createTimeSpan(0,0,50,0);
		THIS.setClientCookies = true;

		function onApplicationStart (){

			   var com = {control={},model={},util={}};
			   
			   switch(LCase(CGI.Server_Name)){

					case "localhost":
			        case "127.0.0.1":

			             APPLICATION.path_server             = "http://#LCase(CGI.Server_Name)#" ;
			             APPLICATION.path_application        = "APDaily_Upd\" ;
			             APPLICATION.directory_server        = "#ExpandPath('\')#" ;
			             APPLICATION.directory_application   = "" ;
			             APPLICATION.dsn_operEvents          = "web_apdaily" ;
			             APPLICATION.AdminEmail         	 = "NagaRaju.BHANOORI@insead.edu" ;
			             Application.rootdir 				 = GetDirectoryFromPath(GetCurrentTemplatePath());
    					 Application.uploadpath				 = "#Application.rootdir#documents\";
    					 Application.MailUploadpath 		 = "#Application.rootdir#mail_attachments\";
    					 Application.docpath				 = "#Application.path_server#/APDaily_Upd/documents/";
    					 Application.POpath					 = "#Application.path_server#/APDaily_Upd/PO/";
    					 Application.POtemplatepath			 ="#Application.rootdir#POTemplates\";
    					 Application.POCreatepath			 = "#Application.rootdir#PO\";
    					 Application.MailSettings 			 = true;
    					 APPLICATION.AuthWS = CreateObject("webservice","http://www.dev.insead.edu/authenticateWS/gateway.cfc?wsdl");
			        break;

			        case "www.dev.insead.edu":
			             APPLICATION.path_server             = "http://#LCase(CGI.Server_Name)#" ;
			             APPLICATION.path_application        = "apdaily_upd\" ;
			             APPLICATION.directory_server        = "#replaceNoCase(ExpandPath('\'),'\NewWeb\','')#" ;
			             APPLICATION.directory_application   = "\NewWeb\" ;
			             APPLICATION.dsn_operEvents          = "admin_web_apdaily" ;
			             APPLICATION.AdminEmail         	 = "NagaRaju.BHANOORI@insead.edu" ;
			             Application.rootdir 				 = GetDirectoryFromPath(GetCurrentTemplatePath());
    					 Application.uploadpath				 = "#Application.rootdir#documents\";
    					 Application.MailUploadpath 		 = "#Application.rootdir#mail_attachments\";
    					 Application.docpath				 = "#Application.path_server#/APDaily_Upd/documents/";
    					 Application.POpath					 = "#Application.path_server#/APDaily_Upd/PO/";
    					 Application.POtemplatepath			 ="#Application.rootdir#POTemplates\";
    					 Application.POCreatepath			 = "#Application.rootdir#PO\";
    					 Application.MailSettings 			 = true;
    					 APPLICATION.AuthWS = CreateObject("webservice","http://www.dev.insead.edu/authenticateWS/gateway.cfc?wsdl");
			        break;
			        case "www.insead.edu":
			        case "insead.edu":

			             APPLICATION.path_server             = "http://#LCase(CGI.Server_Name)#" ;
			             APPLICATION.path_application        = "" ;
			             APPLICATION.directory_server        = "#replace(ExpandPath('\'),'\NewWeb\','')#" ;
			             APPLICATION.directory_application   = "\NewWeb" ;
			             APPLICATION.dsn_alumni              = "oper_events" ;
			             APPLICATION.AdminEmail         	 = "NagaRaju.BHANOORI@insead.edu" ;
			             Application.rootdir 				 = GetDirectoryFromPath(GetCurrentTemplatePath());
    					 Application.uploadpath				 = "#Application.rootdir#documents\";
    					 Application.MailUploadpath 		 = "#Application.rootdir#mail_attachments\";
    					 Application.docpath				 = "#Application.path_server#/APDaily/documents/";
   						 Application.POpath					 = "#Application.path_server#/APDaily/PO/";
    					 Application.POtemplatepath			 ="#Application.rootdir#POTemplates\";
    					 Application.POCreatepath			 = "#Application.rootdir#PO\";
    					 Application.MailSettings 			 = true;
    					 APPLICATION.AuthWS = CreateObject("webservice","http://www.insead.edu/authenticateWS/gateway.cfc?wsdl");
			        break;

               }

		     APPLICATION.url_link   = "#Application.path_server##Application.path_application#" ;
		     APPLICATION.url_ressources = "#Application.url_link#/ressources" ;
		     APPLICATION.url_include    = "#Application.path_application#" ;
		     APPLICATION.url_www    = "#APPLICATION.url_link#/APDaily_Upd" ;
		     APPLICATION.hardRoot    = "APDaily_Upd/components/" ;
		     
		     /* Active Directory web service authentication credentials */
			APPLICATION.authWSUser = 'au10u5er';
			APPLICATION.authWSPass = 'au10pa55w0rd';
		     
		     structinsert(APPLICATION,'com',com,true);
		     com.model.utils= createObject("component","components.model.utils").init(APPLICATION.dsn_operEvents);
		     com.model.AstPerm = createObject("component","components.model.asset_permissions").init(APPLICATION.dsn_operEvents);
		     com.model.BudgetRoles = createObject("component","components.model.budget_roles").init(APPLICATION.dsn_operEvents);
		     com.model.Dept = createObject("component","components.model.departments").init(APPLICATION.dsn_operEvents);
		     com.model.feedback =	 createObject("component","components.model.feedback").init(APPLICATION.dsn_operEvents);
		     com.model.PrdUsrHist = createObject("component","components.model.PrdUsrHistory").init(APPLICATION.dsn_operEvents);
		     com.model.products = createObject("component","components.model.products").init(APPLICATION.dsn_operEvents);
		     com.model.PurchItmType = createObject("component","components.model.purchase_Items_type").init(APPLICATION.dsn_operEvents);
		     com.model.PurchPerm = createObject("component","components.model.purchase_permissions").init(APPLICATION.dsn_operEvents);
		     com.model.PurchStatus = createObject("component","components.model.Purchase_Status").init(APPLICATION.dsn_operEvents);
		     com.model.PurchItems = createObject("component","components.model.Purchases_items").init(APPLICATION.dsn_operEvents);
		     com.model.Purchases = createObject("component","components.model.Purchases").init(APPLICATION.dsn_operEvents);
		     com.model.RptPblm = createObject("component","components.model.Report_a_problem").init(APPLICATION.dsn_operEvents);
		     com.model.softwares = createObject("component","components.model.softwares").init(APPLICATION.dsn_operEvents);
		     com.model.users = createObject("component","components.model.users").init(APPLICATION.dsn_operEvents);
		     com.model.vendors = createObject("component","components.model.vendors").init(APPLICATION.dsn_operEvents);
		     com.model.req = createObject("component","components.model.purchaserequests").init(APPLICATION.dsn_operEvents);
		     com.model.items = createObject("component","components.model.request_items").init(APPLICATION.dsn_operEvents);
		     com.model.models = createObject("component","components.model.purchaseitems_models").init(APPLICATION.dsn_operEvents);
		     com.model.currency = createObject("component","components.model.currency").init(APPLICATION.dsn_operEvents);
		     com.model.statuslog = createObject("component","components.model.statuslog").init(APPLICATION.dsn_operEvents);
		     com.control.config = createObject("component","components.control.config").init();
			 com.util = createObject("component","components.util.util").init();
			 com.control.login = createObject("component","components.control.login").init();	
			 com.control.assetman = createObject("component","components.control.assetman").init();	
			 com.control.requests = createObject("component","components.control.requests").init();	
			 com.control.purchasing = createObject("component","components.control.purchasing").init();	
			 com.control.admin = createObject("component","components.control.adminman").init();	
			 com.control.reports = createObject("component","components.control.reports").init();
			 com.control.alerts = createObject("component","components.control.alerts").init();	

		}

        function onApplicationEnd (){
            structClear(Application);
        }

        function onRequestStart (){
		    if (structKeyExists(URL,'refresh')) {
		        onApplicationEnd();
		        onApplicationStart();
		    }
		    if(structKeyExists(URL,'deepRefresh')){
		         clearSession();
		         onSessionStart();
		    }
		
        }
        function onRequestEnd(){
            structClear(REQUEST);
        }

        function onSessionStart (){
                
        }

        function onSessionEnd (){
            getPageContext().forward("logout.cfm");
        }

        function clearSession(){
            structClear(session);
        }
	</cfscript>
	<cfsetting showdebugoutput="false" />
</cfcomponent>