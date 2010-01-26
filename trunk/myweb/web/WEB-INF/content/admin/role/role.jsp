<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<HEAD>
		<title></title>
		<%@ include file="/common/meta.jsp"%>
		<script src="<c:url value="/scripts/default.js"/>"
			type="text/javascript"></script>
		<script language="JavaScript" type="text/JavaScript">
		
		function InitPage()
		{
			top.setStatusBarInfo('');
			if($("#message").text() != '') {
				top.setStatusBarInfo($("#message").text());
			}
			
			body.style.cursor = "";
		}		
		
		function add() {			
			var url = "role!input.action";
			top.mainWorkArea.location = url;
		}

		function update() {		
			var ids = getSelectedCheckBoxIds('selectIds');
			var url = "role!input.action?id="+ids+"&page.pageRequest=${page.pageRequest}";
			top.mainWorkArea.location = url;
		}
		
		function del() {		
			var ids = getSelectedCheckBoxIds('selectIds');

			var url = "role!delete.action?selectedIds="+ids+"&page.pageRequest=${page.pageRequest}";
			top.mainWorkArea.location = url;
		}


		function query() {
			submitForm();
		}

		function submitForm() {
			queryForm.submit();
		}
		</script>
	</HEAD>

	<body scroll="auto" style="overflow: auto" id="body"
		onload="InitPage()" MS_POSITIONING="GridLayout">
		<div id="message" style="display: none;">
			<s:actionmessage theme="simple" />
		</div>
		<form id="queryForm" name="queryForm" action="user.action"
			method="post">
			<TABLE class="tbMain" id="Table1" cellSpacing="0" border="0">
				<TR>
					<TD class="tdCommonTop">
						<TABLE class="tbTitle" id="Table2" cellSpacing="0" border="0">
							<TR>
								<TD class="tdTitle1" colSpan="1" rowSpan="1">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
									<span id="Location">用户管理 > 角色设定</span>&nbsp;&nbsp;&nbsp;
									<img src="${base}/images/ask.gif" id="BtnAsk"
										style="CURSOR: hand" alt="..."
										height="23" width="24" align="absMiddle" />
								</TD>
								<TD class="tdTitle2">
									<FONT face="宋体"></FONT>
								</TD>
								<TD class="tdTitle3">

									<IMG alt="" src="${base}/images/title_06.gif">
								</TD>
							</TR>
						</TABLE>

					</TD>
				</TR>
				<TR>
					<TD class="tdSpaceH12">
						<FONT face="宋体"></FONT><FONT face="宋体"></FONT>
					</TD>
				</TR>
				<TR>
					<TD id="tdPanel" class="tdCommonTop">
						<TABLE class="tbPanel" id="Table4" cellSpacing="0" cellPadding="0"
							border="0">
							<TR>
								<TD class="tdPanelContent">
									<!-- 账户管理首页标签 -->
									<table border="0" cellpadding="0" cellspacing="0"
										class=tbPanelContent>
										<tr>
											<td class=tdPanelHead>&nbsp;</td>
											<td class=tdPanelSel_left>&nbsp;</td>
											<td class=tdPanelSel_center><pre style="margin: 0px">角色设定</pre></td>
											<td class=tdPanelSel_right>&nbsp;</td>
										</tr>
									</table>
									<!-- END 账户管理首页标签 -->
								</TD>
								<TD class="tdPanelTrail">
									<table border="0" cellpadding="0" cellspacing="0"
										class=tbPanelContent>
										<tr>
											<td class=tdOperButton onclick="add()"><img src="${base}/images/${locale}/new.jpg" /></td>
											<td class=tdPanelSpace10>&nbsp;</td>
											<td class=tdOperButton onclick="update()"><img src="${base}/images/${locale}/update.jpg" /></td>
											<td class=tdPanelSpace10>&nbsp;</td>
											<td class=tdOperButton onclick="del()"><img src="${base}/images/${locale}/del.jpg" /></td>
											<td class=tdPanelSpaceW20>&nbsp;</td>

										</tr>
									</table>
								</TD>
							</TR>
						</TABLE>
					</TD>

				</TR>				
				<TR>
					<TD class="tdSpaceH12"></TD>
				</TR>
				<TR>
					<TD id="tdQueryResult1" class="tdCommonTop">
						<TABLE class="tbBlock" id="Table8" cellSpacing="1" border="0">
							<TR>
								<TD class="tdPrompt">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								</TD>
							</TR>
						</TABLE>
						<table class="dgMain" cellspacing="0" cellpadding="3"
							align="Center" rules="all" bordercolor="#9FD6FF" border="1"
							id="dgSubAccRecSet"
							style="border-color: #9FD6FF; border-width: 1px; border-style: solid; border-collapse: collapse;">
							<tr class="dgHeader" align="Center">
								<td class="dgHeader">
									<input type="checkbox" class="checkbox" name="ids" onclick="selectAllCheckBox(this,'selectIds')"/>
								</td>
								</td>
								<td class="dgHeader">
									<a href="javascript:orderBy('name')"><b>姓名</b>
									</a>
								</td>
							</tr>
							<s:iterator value="page.result">
								<tr class="dgAlternatingItem">
									<td align="center">
										<input type="checkbox" class="checkbox" name="selectIds"
											value="${id}" />
									</td>
									<td align="Left">
										${name}
									</td>
								</tr>
							</s:iterator>
						</table>
						<s:if test="page.result != null">
							<%@ include file="/common/paginateTool.jsp"%>
						</s:if>
					</TD>

				</TR>
				<TR>
					<TD class="tdSpaceH12"></TD>
				</TR>
				
			</TABLE>
	</body>
	</form>
</HTML>
