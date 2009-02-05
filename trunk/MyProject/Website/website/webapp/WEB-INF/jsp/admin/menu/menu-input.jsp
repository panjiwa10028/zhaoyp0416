<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" >
<html>
	<head>
		<title></title>
		<%@ include file="/common/meta.jsp"%>

		<link href="${ctx}/js/validate/jquery.validate.css" type="text/css"
			rel="stylesheet" />
		<script src="${ctx}/js/validate/jquery.validate.js"
			type="text/javascript"></script>
		<script src="${ctx}/js/validate/messages_cn.js" type="text/javascript"></script>

		<script>
	$(document).ready(function(){
		$("#displayName").focus();
		$("#inputForm").validate({
			 rules: { 
			displayName: { 
        			required: true, 
        			remote: encodeURI("menu!checkDisplayName.action?oldDisplayName=${displayName}")
    			}
            	
			},
			messages: {
				displayName: {
					remote: "名称已存在"
				}
			}
		});
	});

	function initPage() {
	}

	function subForm() {
		//inputForm.target = "mainWorkArea";
		inputForm.target = "dialog_Info_hiddenSubmitIFrame";
		inputForm.submit();
	}

	function setStatusBarInfo(info)
	{
		document.getElementById('statusBarInfo').innerHTML = 'transactInfo'+info;
		document.getElementById('processMessage').style.display = 'block';
	}
	
</script>


	</head>

	<body onload="initPage()">
	<form id="inputForm" action="menu!save.action" method="post">
	<input type="hidden" name="id" value="${id}" />
		<TABLE class="tbMain" id="Table1" cellSpacing="0" border="0">
			<TR>
				<TD class="tdCommonTop">
					<TABLE class="tbTitle" id="Table2" cellSpacing="0" border="0">
						<TR>
							<TD class="tdTitle1" colSpan="1" rowSpan="1">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
								<span id="Location">系统管理 > 菜单设定 > 菜单修改</span>
							</TD>
							<TD class="tdTitle2"></TD>
							<TD class="tdTitle3">
								版面号：101005
								<IMG alt="" src="${ctx}/images/title_06.gif">
							</TD>
						</TR>
					</TABLE>
					
				</TD>
			</TR>
			<TR>
				<TD class="tdSpaceH12"></TD>
			</TR>
			<TR>
				<TD class="tdCommonTop">
					<TABLE class="tbPanel" id="Table4" cellSpacing="0" cellPadding="0"
						border="0">
						<TR>
							<TD class="tdPanelContent" colSpan="1" rowSpan="1">
								<!-- 修改密码标签 -->
								<table border="0" cellpadding="0" cellspacing="0" class=tbPanelContent>
									<tr>
										<td class=tdPanelHead>&nbsp;</td>
										<td class=tdPanelSel_left>&nbsp;</td>
										<td class=tdPanelSel_center><pre style="margin:0px">菜单设定</pre></td>
										<td class=tdPanelSel_right>&nbsp;</td>
									</tr>
								</table>
								<!-- END 修改密码标签 -->
							</TD>
							<TD class="tdPanelTrail"></TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
			<TR>
				<TD class="tdCommonTop">
					<TABLE class="tbCommonColor" id="Table5" cellSpacing="0" border="0">
						<TR>
							<TD class="tdSpaceH12Color"></TD>
						</TR>
					</TABLE>

					<TABLE class="tbBlock" id="Table1" cellSpacing="1" border="0">
						<TR>
							<TD class="tdPrompt">
								&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;菜单修改：
							</TD>
						</TR>
					</TABLE>
					<TABLE id="Table2" cellSpacing="1" border="0" class="tbBlock">
						<TR>
							<TD class="tdRightW30H40">
								显示名称：
							</TD>
							<TD class="tdLeftH40">
								<input id="displayName" name="displayName" value="${displayName}"/>
							</TD>
						</TR>	
						<TR>
							<TD class="tdRightW30H40">
								不可用：
							</TD>
							<TD class="tdLeftH40">								
								<input type="checkbox" id="disabled" name="disabled" value="1" <c:if test="${disabled == 1}">checked</c:if>/>
							</TD>
						</TR>					
					</TABLE>
					<TABLE class="tbCommonColor" id="Table3" cellSpacing="1" border="0">
						<TR>
							<TD class="tdCenterW30H40"></TD>
							<TD class="tdLeftH40">
								<input type="button" name="uc_am_ModiQueryPwd1:BtnOK"
									value="确 定" id="uc_am_ModiQueryPwd1_BtnOK" class="btn" onclick="subForm()"/>
							</TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
			<TR>
				<TD class="tdSpaceH12"></TD>
			</TR>
	
			<TR>
				<TD class="tdCommonTop">
					<TABLE class="tbExplain" id="Table6" cellSpacing="1" border="0"
						height="270">
						<TR>
							<TD class="tdExplain">
								<IFRAME class="ifExplain" id="ExplainPageFrame"
									name="ExplainPageFrame" src="${ctx}/common/help/menu-help.jsp" frameBorder="0"
									scrolling="no"></IFRAME>
							</TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
			
		</TABLE>
		<div id="message"><s:actionmessage theme="mytheme"/></div>
<iframe id="dialog_Info_hiddenSubmitIFrame" width="0" height="0" frameborder="0" name="dialog_Info_hiddenSubmitIFrame" scrolling="no"></iframe>

		</form>
	</body>
</html>