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
		
		
		function subForm() {
			top.setStatusBarInfo('');
			var paramData = "";
			
			paramData = "autoBackup="+ $("input[name='autoBackup']:checked").val();
			paramData += "&webRootPath=" + $("#webRootPath").val();
			paramData += "&backupPath=" + $("#backupPath").val();
			$.ajax({
				 type: "POST",
				 url: "system!save.action",
				 data:   paramData,				 
				 success: function(msg){
				 top.setStatusBarInfo(msg);
				 	} 
				}); 
		//	$("#inputForm").submit();
		}
		</script>
	</HEAD>
<form id="inputForm" name="inputForm" action="system!save.action"
			method="post" >
			<s:token/>
	<body scroll="auto" style="overflow: auto" id="body"
		onload="InitPage()" MS_POSITIONING="GridLayout">
		<div id="message" style="display: none;">
			<s:actionmessage theme="simple" />
		</div>
		<form id="queryForm" name="queryForm" action="group.action"
			method="post">
			<TABLE class="tbMain" id="Table1" cellSpacing="0" border="0">
				<TR>
					<TD class="tdCommonTop">
						<TABLE class="tbTitle" id="Table2" cellSpacing="0" border="0">
							<TR>
								<TD class="tdTitle1" colSpan="1" rowSpan="1">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
									<span id="Location">系统管理 > 系统设定</span>&nbsp;&nbsp;&nbsp;
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
											<td class=tdPanelSel_center><pre style="margin: 0px">系统设定</pre></td>
											<td class=tdPanelSel_right>&nbsp;</td>
										</tr>
									</table>
									<!-- END 账户管理首页标签 -->
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
						<TABLE id="Table2" cellSpacing="1" border="0" class="tbBlock">
							<TR>
								<TD class="tdRightW30H40">
									web工程目录:
								</TD>
								<TD class="tdLeftH40">
									<input type="text" id="webRootPath" name="webRootPath" size="40" value="${config.webRootPath}"/>
								</TD>
							</TR>
							<TR>
								<TD class="tdRightW30H40">
									备份数据库路径:
								</TD>
								<TD class="tdLeftH40">
									<input type="text" id="backupPath" name="backupPath" size="40" value="${config.backupPath}"/>
								</TD>
							</TR>
							<TR>
								<TD class="tdRightW30H40">
									自动备份数据库:
								</TD>
								<TD class="tdLeftH40">
									<input type="radio" id="autoBackup2" name="autoBackup" value="0" <c:if test="${config.autoBackup == 0}">checked</c:if>/>手动
									<input type="radio" id="autoBackup1" name="autoBackup" value="1" <c:if test="${config.autoBackup == 1}">checked</c:if>/>自动
									(自动执行时间：每周六晚24点。执行备份前请设置有效的备份数据库的路径)
								</TD>
							</TR>								
											
						</TABLE>						
					<TABLE class="tbCommonColor" id="Table3" cellSpacing="1"
							border="0">
							<TR>
								<TD class="tdCenterW30H40"></TD>
								<TD class="tdLeftH40">
									<input type="button" name="uc_am_ModiQueryPwd1:BtnOK"
										value="确 定" id="uc_am_ModiQueryPwd1_BtnOK" class="btn"
										onclick="subForm()" />									
								</TD>
							</TR>
						</TABLE>
					</TD>

				</TR>
				<TR>
					<TD class="tdSpaceH12"></TD>
				</TR>
				
			</TABLE>
	</body>
	</form>
</HTML>
