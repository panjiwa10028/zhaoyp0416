<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" >
<html>
	<HEAD>
		<title></title>
		<meta content="True" name="vs_snapToGrid">
		<meta content="True" name="vs_showGrid">
		<meta content="Microsoft Visual Studio .NET 7.1" name="GENERATOR">
		<meta content="C#" name="CODE_LANGUAGE">
		<meta content="JavaScript" name="vs_defaultClientScript">
		<meta content="http://schemas.microsoft.com/intellisense/ie5" name="vs_targetSchema">

		<LINK title="default" href="./css/Styles.css" rel="stylesheet">
		
		<script language="javascript" src="./js/DynaForm.js"></script>
		<script language="javascript" src="./js/default.js"></script>
		<script language="javascript" src="./js/FuncTrigger.js"></script>
		<script language="JavaScript" type="text/JavaScript">
		
		function InitPage()
		{
			body.style.cursor = "";
		}		
		
		function CheckValid()
		{
			body.style.cursor = "wait";			
		}
		
		</script>
	</HEAD>
	<body id="body" onload="InitPage()" MS_POSITIONING="GridLayout">
		<form name="am_QuerySubAccount" method="post" action="dialog.html" id="am_QuerySubAccount" onsubmit="CheckValid()">
<input name="ClientNo" id="ClientNo" type="hidden" value="BABD419B0FD0EF3DAE51C3F4C4081818562295577333605200028687" />

<script language="javascript" type="text/javascript">
<!--
	function __doPostBack(eventTarget, eventArgument) {
		var theform;
		if (window.navigator.appName.toLowerCase().indexOf("microsoft") > -1) {
			theform = document.am_QuerySubAccount;
		}
		else {
			theform = document.forms["am_QuerySubAccount"];
		}
		theform.__EVENTTARGET.value = eventTarget.split("$").join(":");
		theform.__EVENTARGUMENT.value = eventArgument;
		theform.submit();
	}
// -->
</script>

			<TABLE class="tbMain" id="Table1" cellSpacing="0" border="0">
				<TR>
					<TD class="tdCommonTop">
						<TABLE class="tbTitle" id="Table2" cellSpacing="0" border="0">
							<TR>
								<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
									<span id="Location">账户管理 > 首页</span>&nbsp;&nbsp;&nbsp; <img src="./Images/ask.gif" id="BtnAsk" style="CURSOR: hand" alt="账户管理提供账户余额查询、交易查询、修改密码、挂失等账户基本功能。" height="23" width="24" align="absMiddle" /></TD>
								<TD class="tdTitle2"><FONT face="宋体"></FONT></TD>
								<TD class="tdTitle3">版面号：101002<IMG alt="" src=".\Images\title_06.gif"></TD>
							</TR>
						</TABLE>
						<TABLE class="tbBlock" id="Table3" cellSpacing="1" border="0">
							<TR>
								<TD class="tdCenterW20H40" colSpan="1" rowSpan="1">一卡通卡号：</TD>
								<TD class="tdLeftH40"><select name="ddlDebitCardList" onchange="__doPostBack('ddlDebitCardList','')" language="javascript" id="ddlDebitCardList">
	<option selected="selected" value="A00106225880104985594">6225880104985594</option>

</select></TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
				<TR>
					<TD class="tdSpaceH12"><FONT face="宋体"></FONT><FONT face="宋体"></FONT></TD>
				</TR>
				<TR>
					<TD id="tdPanel" class="tdCommonTop">
						<TABLE class="tbPanel" id="Table4" cellSpacing="0" cellPadding="0" border="0">
							<TR>
								<TD class="tdPanelContent" colSpan="1" rowSpan="1">
<!-- 账户管理首页标签 -->
<table width="712px" border="0" cellpadding="0" cellspacing="0" class=tbPanelContent>
	<tr>
	    <td class=tdPanelHead> </td>
	    <td class=tdPanelSel> <a href="#" class=lkPanelSel onclick="triggerFunc('am_QuerySubAccount.aspx','FORM','_self','panelcontrol=HomeAccountManager')">账户查询</a></td>
	    <td class=tdPanelNoSel> <a href="#" class=lkPanelNoSel onclick="triggerFunc('am_QueryTodayTrans.aspx','FORM','_self','panelcontrol=HomeAccountManager')">当天交易查询</a></td>
		<td class=tdPanelNoSel> <a href="#" class=lkPanelNoSel onclick="triggerFunc('am_QueryHistoryTrans.aspx','FORM','_self','panelcontrol=HomeAccountManager')">历史交易查询</a></td>
		<td class=tdPanelSpace> </td>
		<td class=tdRelFuncPwdManager onclick="triggerFunc('dialog.html','FORM','PwdManager','panel=ModiQueryPwd')"> </td>
		<td class=tdPanelSpaceW20> </td>
		<td class=tdRelFuncReportLoss onclick="triggerFunc('../DebitCard/am_ReportLoss.aspx','FORM','ReportLoss','panel=ReportLoss')"> </td>
		<td class=tdPanelSpaceW20> </td>
		<td class=tdRelFuncInvestFS onclick="triggerFunc('dialog.html','FORM','InvestFS','panel=InvestFS')"> </td>		


	</tr>
</table>
<!-- END 账户管理首页标签 --></TD>
								<TD class="tdPanelTrail"><FONT face="宋体"></FONT></TD>
							</TR>
						</TABLE>
					</TD>

				</TR>
				<TR>
					<TD id="tdQueryResult1" class="tdCommonTop"><TABLE class="tbCommonColor" id="Table5" cellSpacing="0" border="0">
							<TR>
								<TD id="tdSpace" class=""></TD>

							</TR>
						</TABLE>
						<TABLE class="tbCommonColor" id="Table6" cellSpacing="1" border="0">
							<TR>
								<TD class="tdLeftH30">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;类型：<select name="ddlTypeList" id="ddlTypeList" style="width:100px;">
	<option selected="selected" value="-">[ 全部 ]</option>
	<option value="10001">活期结算户</option>
	<option value="10002">活期投资户</option>

</select>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;币种：<select name="ddlCurrencyList" id="ddlCurrencyList" style="width:100px;">
	<option selected="selected" value="-">[ 全部 ]</option>
	<option value="100">人民币</option>

</select>
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="submit" name="BtnOK" value="查 询" id="BtnOK" class="btn" />
								</TD>
							</TR>
						</TABLE>
					</TD>

				</TR>
				<TR>
					<TD class="tdSpaceH12"></TD>
				</TR>
				<TR>
					<TD id="tdQueryResult2" class="tdCommonTop"><TABLE class="tbBlock" id="Table8" cellSpacing="1" border="0">
							<TR>
								<TD class="tdPrompt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;以下是一卡通
									<span id="AccountNo" class="wcLabel">6225880104985594</span>&nbsp;的子账户：</TD>
							</TR>
						</TABLE>
						<table class="dgMain" cellspacing="0" cellpadding="3" align="Center" rules="all" bordercolor="#9FD6FF" border="1" id="dgSubAccRecSet" style="border-color:#9FD6FF;border-width:1px;border-style:solid;border-collapse:collapse;">
	<tr class="dgHeader" align="Center">
		<td class="dgHeader">操作</td><td class="dgHeader">子账户</td><td class="dgHeader">类型</td><td class="dgHeader">币种</td><td class="dgHeader">余额</td><td class="dgHeader">利率</td><td class="dgHeader">状态</td><td class="dgHeader">起息日</td><td class="dgHeader">存期</td><td class="dgHeader">到期日</td>
	</tr><tr>
		<td align="Center"><a href="#" onclick="triggerFunc('../DebitCard/am_QueryTodayTrans.aspx','FORM','110056674000001','SubAccountNo=110056674000001');"> 交易查询 </a></td><td align="Center">00000</td><td align="Left">活期结算户</td><td align="Left">人民币</td><td align="Right" style="color:#585858;">378.98</td><td align="Right">0.3600</td><td align="Left">活动</td><td align="Center">&nbsp;</td><td align="Left">&nbsp;</td><td align="Center">&nbsp;</td>
	</tr><tr class="dgAlternatingItem">
		<td align="Center"><a href="#" onclick="triggerFunc('../DebitCard/am_QueryTodayTrans.aspx','FORM','110056674000003','SubAccountNo=110056674000003');"> 交易查询 </a></td><td align="Center">00000</td><td align="Left">活期投资户</td><td align="Left">人民币</td><td align="Right" style="color:#585858;">0.00</td><td align="Right">0.3600</td><td align="Left">活动</td><td align="Center">&nbsp;</td><td align="Left">&nbsp;</td><td align="Center">&nbsp;</td>
	</tr>
</table>
						<TABLE class="tbBlock" id="Table9" cellSpacing="1" border="0">
							<TR>
								<TD class="tdLeftH30">&nbsp; 子账户个数：
									<span id="RecCount" class="wcLabel">2</span></TD>
							</TR>
						</TABLE>
					</TD>

				</TR>
				<TR>
					<TD class="tdSpaceH12"></TD>
				</TR>
				<TR>
					<TD class="tdCommonTop">
						<TABLE class="tbExplain" id="Table10" height="80" cellSpacing="1" border="0">
							<TR>
								<TD class="tdExplain"><IFRAME class="ifExplain" id="ExplainPageFrame" name="ExplainPageFrame" src="101002.htm"
										frameBorder="0" scrolling="no"></IFRAME>
								</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>
			</TABLE>
		</form>
	</body>
</HTML>
