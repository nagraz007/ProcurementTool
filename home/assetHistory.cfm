<html>
<head></head>
	<body>
		
		<cfparam name="URL.product_id" default="0" type="numeric" />
		<cfparam name="URL.download" default="no" type="string" />
		
		<cfset astHst = APPLICATION.com.control.assetMan.assetHistory(URL.product_id) />
		<cfset astHistry = astHst.astHistry />
		<cfset purchId = astHst.purchaseId />

		<cfoutput>
		<cfif URL.download eq 'no'>
			<fieldset class="paddingdecom">
				<legend> &nbsp;Details of Asset &nbsp;</legend>
					<table width="500px">
						<tr>
							<td width="100%">
										<ul class="decomUL">
											<li class="boldhist" style="width:40px;">Type:</li>
									<li class="cellhistStyle" style="width:180px;">#astHistry.data.type#</li>
									<li class="boldhist" style="width:45px;">Model:</li>
									<li class="cellhistStyle" style="width:180px;word-wrap:break-word;">#astHistry.data.model#</li>
									
										</ul>
							</td>
						</tr>
						<tr>
							<td width="100%">
										<ul class="decomUL">
									<li class="boldhist" style="width:43px;">Name:</li>
									<li class="cellhistStyle" style="width:175px">#astHistry.data.pname#</li>
									<li class="boldhist" style="width:60px;">Serial##:</li>
									<li class="cellhistStyle" style="width:135px;"> #astHistry.data.serialno#</li>
										</ul>
							</td>
						</tr>
						<tr>
							<td width="100%">
								<ul class="decomUL">
									<li class="boldhist" style="width:75px;">BudgetId:</li>
									<li class="cellhistStyle" style="width:143px">&nbsp;#astHistry.data.budgetid#</li>
									<li class="boldhist" style="width:100px;">Purchase ID:</li>
									<li class="cellhistStyle" style="width:70px;">#purchId#</li>
								</ul>
							</td>
						</tr>
						<tr>
							<td width="100%">
										<ul class="decomUL">
									<li class="boldhist" style="width:120px;">Decommisioned:</li>
									<li class="cellhistStyle" style="width:20px;">#astHistry.data.decommision eq 'Y'#</li>
										</ul>
							</td>
						</tr>
					</table>	
			</fieldset>	
			<fieldset class="paddingdecom">
				<legend> &nbsp;Asset History&nbsp;</legend>			
				<table width="500px">
					<tr>
						<td width="100%" align="right"><a href="assetHistory.cfm?product_id=#URL.product_id#&download=yes">Download this report</a></td>
					</tr>
					<tr>
						<td width="100%">
									<ul class="decomUL">
										<li class="boldhist" style="width:15px;">##</li>
								<li class="boldhist" style="width:150px;"> Name</li>
								<li class="boldhist" style="width:140px;">Start Date</li>
								<li class="boldhist" style="width:140px;word-wrap:break-word;">End date</li>
								
									</ul>
						</td>
					</tr>
					<cfloop query="astHistry.data">
					<tr>
						<td width="100%">
									<ul class="decomUL">
										<li class="cellhistStyle" style="width:15px;">#currentrow#</li>
										<li class="cellhistStyle" style="width:150px;">#Name#</li>
										<li class="cellhistStyle" style="width:140px;word-wrap:break-word;">#StartDate#</li>
										<li class="cellhistStyle" style="width:140px;word-wrap:break-word;">#Enddate#</li>
									</ul>
						</td>
					</tr>
				</cfloop>
				</table>
			</fieldset>
		<cfelse>
		<cfcontent type="application/msexcel">
		<cfheader name="Content-Disposition" value="attachment;filename=""AssetHistory.xls""">
			<table width="100%" border="1">
					<tr bgcolor="##808080">
						<th>##</th>
						<th width="200px">Name</th>
						<th width="100px">Start Date</th>
						<th width="100px">End date</th>
					</tr>
					<cfloop query="astHistry.data">
					<tr>
						<td>#currentrow#</td>
						<td>#Name#</td>
						<td>#StartDate#</td>
						<td>#Enddate#</td>
					</tr>
				</cfloop>
			</table>
		</cfif>
		</cfoutput>
	</body>
</html>