	var myMenu = new Menu();
	var myMenuItemTmp = new MenuItem();
	var myMenuaccess = new MenuItem();
	var myMenureq = new MenuItem();
	var myMenubudg = new MenuItem();
	var myMenuadmin = new MenuItem();
	var myMenuvend = new MenuItem();
	var myMenudept = new MenuItem();
	var myMenuresp = new MenuItem();
	var myMenupurchtype = new MenuItem();
	var myMenupurchmodel = new MenuItem();

	/* set if the menu must be expanded or collapse */
	myMenu.expandIsFix = false;

	/* menu definition*/ 
	/* new MenuItem(URL, Caption, DHTML_ID) */
	/* DHTML_ID must be define like a variable name : unique and without spaces in the name */
	
		
	myMenuItemTmp = new MenuItem("home/index.cfm", "Home", "home");
	myMenu.AddMenuItem(myMenuItemTmp);
	
	myMenuItemTmp = new MenuItem("home/searchasset.cfm", "Asset Management ", "searchasset");
	myMenuItemTmp.AddChildItem(new MenuItem("home/newasset.cfm", "New Asset", "newasset"));
	myMenuItemTmp.AddChildItem(new MenuItem("home/editasset.cfm", "Edit Asset", "editasset"));
	myMenu.AddMenuItem(myMenuItemTmp);
	
	myMenuItemTmp = new MenuItem("home/purchase_home.cfm", "Purchase Management", "purchasehome");
	myMenuItemTmp.AddChildItem(new MenuItem("home/purchaserequest.cfm", "Purchase Request", "purchaserequest"));
	myMenureq = new MenuItem("home/approverequests.cfm", "Approve Requests", "approverequests");
	myMenureq.AddChildItem(new MenuItem("home/SeeAllReq.cfm", "See All Requests", "seeallreq")); 
	myMenuItemTmp.AddChildItem(myMenureq);
	myMenuItemTmp.AddChildItem(new MenuItem("home/purchaseactions.cfm", "Purchase Actions", "purchaseactions"));
	myMenubudg = new MenuItem("home/budgetapprovals.cfm", "Budget Approvals", "budgetapprovals");
	myMenubudg.AddChildItem(new MenuItem("home/seeAllApprovals.cfm", "See All Approvals", "seeallapproval"));
	myMenuItemTmp.AddChildItem(myMenubudg);
	myMenu.AddMenuItem(myMenuItemTmp);
	
	myMenuadmin =  new MenuItem("home/admin_home.cfm", "Administrator Section", "adminhome");
	myMenuvend = new MenuItem("home/vendors.cfm", "Vendors", "vendors");
	myMenuvend.AddChildItem(new MenuItem("home/seeallvendors.cfm", "See All Vendors", "seeallvend"));
	myMenuadmin.AddChildItem(myMenuvend);
	myMenuadmin.AddChildItem(new MenuItem("home/users.cfm", "Users", "users"));
	myMenudept = new MenuItem("home/departments.cfm", "Departments", "departments");
	myMenudept.AddChildItem(new MenuItem("home/seealldepartments.cfm", "See All Departments", "seealldept"));
	myMenuadmin.AddChildItem(myMenudept);
	myMenuaccess = new MenuItem("home/accesslevels.cfm", "Access Levels", "accesslevels");
	myMenuaccess.AddChildItem(new MenuItem("home/SeeAllAccess.cfm", "See All Permissions", "seeallperm"));
	myMenuadmin.AddChildItem(myMenuaccess);
	myMenupurchtype = new MenuItem("home/purchasetype.cfm", "Type Of Purchase", "purchasetype");
	myMenupurchtype.AddChildItem(new MenuItem("home/SeeAllTypes.cfm", "See All Types", "seealltypes"));
	myMenuadmin.AddChildItem(myMenupurchtype);
	myMenupurchmodel = new MenuItem("home/itemmodel.cfm", "Type Of Item", "itemmodel");
	myMenupurchmodel.AddChildItem(new MenuItem("home/SeeAllModels.cfm", "See All Models", "seeallmodels"));
	myMenuadmin.AddChildItem(myMenupurchmodel);
	myMenu.AddMenuItem(myMenuadmin);
	myMenu.AddMenuItem(new MenuItem("home/reports.cfm", "Report Section", "reports"));
	myMenuresp = new MenuItem("home/Feedback.cfm", "FeedBack", "feedback");
	myMenuresp.AddChildItem(new MenuItem("home/seeAllResponses.cfm", "See All Responses", "seeallresponses"));
	myMenu.AddMenuItem(myMenuresp);
	//myMenu.AddMenuItem(new MenuItem("home/Report_a_problem.cfm", "Report a Problem", "report_a_problem"));
	myMenu.AddMenuItem(new MenuItem("home/logout.cfm", "Logout", "logout"));

