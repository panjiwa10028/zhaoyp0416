<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" >
<html>
	<HEAD>
		<title></title>
		<%@ include file="/common/meta.jsp"%>
		
		<script language="javascript" src="./js/DynaForm.js"></script>
		<script language="javascript" src="${ctx}/js/default.js"></script>
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

		function setting() {
			id = getSelectedIds();
			if(id == "") {
				alert("");
				return false;
			}
			url = "menu/menu!input.action?id=" + id;
			top.showDialog(url, null, 750, 500);
		}

		function getSelectedIds()
		{
			var checkList = document.getElementsByName("id");
				
			if(checkList==null)
			{
				return "";
			}
				
			var strSelectedIds = "";
			
			for(var i=0; i<checkList.length; i++)
			{
				
				if(checkList[i].checked==true)
				{
					if(i > 0 && strSelectedIds != "") {
						strSelectedIds += ",";
					}
					strSelectedIds += checkList[i].value;
				}
			}

			return strSelectedIds;
		}
		</script>
	</HEAD>
	<body id="body" onload="InitPage()" MS_POSITIONING="GridLayout">
	<input name="nPageSize" type="hidden" value="<c:out value='${NPAGESIZE}'/><c:if test="${NPAGESIZE==null || NPAGESIZE <= 0}">20</c:if>" />
	<input name="nPageIndex" type="hidden" value="<c:out value='${NPAGEINDEX}'/>" />	
	<input name="nRecordIndex" type="hidden" value="<c:out value='${NPAGESIZE*(NPAGEINDEX-1)}'/>"/>
	<input name="nPageCount" type="hidden" value="<c:out value='${NPAGECOUNT}'/>" />
		<form name="commonForm" method="post" action="dialog.html" id="commonForm" onsubmit="CheckValid()">

<script language="javascript" type="text/javascript">
<!--

// -->
</script>

			<TABLE class="tbMain" id="Table1" cellSpacing="0" border="0">
				<TR>
					<TD class="tdCommonTop">
						<TABLE class="tbTitle" id="Table2" cellSpacing="0" border="0">
							<TR>
								<TD class="tdTitle1" colSpan="1" rowSpan="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
									<span id="Location">系统管理 > 菜单管理</span>&nbsp;&nbsp;&nbsp; <img src="${ctx}/images/ask.gif" id="BtnAsk" style="CURSOR: hand" alt="账户管理提供账户余额查询、交易查询、修改密码、挂失等账户基本功能。" height="23" width="24" align="absMiddle" /></TD>
								<TD class="tdTitle2"><FONT face="宋体"></FONT></TD>
								<TD class="tdTitle3">版面号：101002<IMG alt="" src="${ctx}/images/title_06.gif"></TD>
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
								<TD class="tdPanelContent">
<!-- 账户管理首页标签 -->
									<table border="0" cellpadding="0" cellspacing="0" class=tbPanelContent>
										<tr>
										    <td class=tdPanelHead>&nbsp;</td>
										    <td class=tdPanelSel_left>&nbsp;</td>
										    <td class=tdPanelSel_center><pre style="margin:0px"><a href="#" class=lkPanelSel onclick="top.mainWorkArea.location='menu.action'">菜单管理</a></pre></td>
										    <td class=tdPanelSel_right>&nbsp;</td>
										</tr>
									</table>
<!-- END 账户管理首页标签 -->		</TD>
								<TD class="tdPanelTrail">
									<table border="0" cellpadding="0" cellspacing="0" class=tbPanelContent>
										<tr>											
											<td class=tdOperButton onclick="setting()"><img src="${ctx}/images/${locale}/setting.jpg"/></td>
											<td class=tdPanelSpace10>&nbsp;</td>
										<!--<td class=tdOperButton onclick="triggerFunc('../DebitCard/am_ReportLoss.aspx','FORM','ReportLoss','panel=ReportLoss')"><img src="${ctx}/images/${locale}/update.jpg"/></td>
											<td class=tdPanelSpace10>&nbsp;</td>
											<td class=tdOperButton onclick="triggerFunc('dialog.html','FORM','InvestFS','panel=InvestFS')"><img src="${ctx}/images/${locale}/del.jpg"/></td>		
										-->	<td class=tdPanelSpaceW20>&nbsp;</td>
									
										</tr>
									</table>
								</TD>
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
								<TD class="tdPrompt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</TD>
							</TR>
						</TABLE>
						<table class="dgMain" cellspacing="0" cellpadding="3" align="Center" rules="all" bordercolor="#9FD6FF" border="1" id="dgSubAccRecSet" style="border-color:#9FD6FF;border-width:1px;border-style:solid;border-collapse:collapse;">
	<tr class="dgHeader" align="Center">
		<td class="dgHeader"><input type="checkbox" class="checkbox" name="lId"/></td><td class="dgHeader">名称</td><td class="dgHeader">类型</td><td class="dgHeader">是否有效</td>
	</tr>
	<s:iterator value="page.result">
		<tr class="dgAlternatingItem">
			<td align="center">
					<input type="checkbox" class="checkbox" name="id" value="<c:out value='${id}'/>" />
			</td>
			<td align="Center">${displayName}</td>
			<td align="Center">${parentId}</td>
			<td align="Left">${disabled}</td>
		</tr>
	</s:iterator>
</table>
<%@ include file="/common/paginateTool.jsp"%>
						<!-- TABLE class="tbBlock" id="Table9" cellSpacing="1" border="0">
							<TR>
								<TD class="tdLeftH30">&nbsp; 子账户个数：
									<span id="RecCount" class="wcLabel">2</span></TD>
							</TR>
						</TABLE -->
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
