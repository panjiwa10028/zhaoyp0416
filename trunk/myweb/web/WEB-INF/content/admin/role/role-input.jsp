<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title></title>
		<%@ include file="/common/meta.jsp"%>
		<link href="${base}/js/validate/jquery.validate.css" type="text/css"
			rel="stylesheet" />
		<link href="${base}/scripts/validate/jquery.validate.css"
			type="text/css" rel="stylesheet" />
		<script language="javascript"
			src="${base}/scripts/validate/jquery.validate.js"
			type="text/javascript"></script>
		<script language="javascript"
			src="${base}/scripts/validate/messages_cn.js" type="text/javascript"></script>
		<script language="javascript"
			src="${base}/scripts/date-picker/WdatePicker.js"
			type="text/javascript"></script>

		<script>
		$(document).ready(function(){
			$("#name").focus();
			$("#inputForm").validate({
				 rules: { 
					name: { 
	        			required: true, 
	        			remote: encodeURI("role!checkRoleName.action?orgName=${name}")
	    			}
	           		
				},
				messages: {
					name: {
						remote: "角色名称已存在"
					}
				}
			});
		});

	function initPage() {
		top.setStatusBarInfo('');
		if($("#message").text() != '') {
			top.setStatusBarInfo($("#message").text());
		}	
	}

	function subForm() {
		top.setStatusBarInfo('');
		$("#inputForm").submit();
	}

	function cancel() {
		top.mainWorkArea.location='role.action';
	}

	function setStatusBarInfo(info)
	{
		document.getElementById('statusBarInfo').innerHTML = 'transactInfo'+info;
		document.getElementById('processMessage').style.display = 'block';
	}
	
</script>


	</head>

	<body scroll="auto" style="overflow: auto" onload="initPage()">
		<form id="inputForm" name="inputForm" action="role!save.action"
			method="post" onsubmit="">
			<s:token/>
			<input type="hidden" name="id" value="${id}" />
			<input type="hidden" name="page.pageRequest"
				value="${page.pageRequest}" />
			<TABLE class="tbMain" id="Table1" cellSpacing="0" border="0">
				<TR>
					<TD class="tdCommonTop">
						<TABLE class="tbTitle" id="Table2" cellSpacing="0" border="0">
							<TR>
								<TD class="tdTitle1" colSpan="1" rowSpan="1">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
									<span id="Location">用户管理 > <a href='#' onclick="cancel()">角色设定</a> > 角色<s:if test="id == null">新增</s:if><s:else>修改</s:else></span>
								</TD>
								<TD class="tdTitle2"></TD>
								<TD class="tdTitle3">									
									<IMG alt="" src="${base}/images/title_06.gif">
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
									<table border="0" cellpadding="0" cellspacing="0"
										class=tbPanelContent>
										<tr>
											<td class=tdPanelHead>
												&nbsp;
											</td>
											<td class=tdPanelSel_left>
												&nbsp;
											</td>
											<td class=tdPanelSel_center>
												<pre style="margin: 0px">角色设定</pre>
											</td>
											<td class=tdPanelSel_right>
												&nbsp;
											</td>
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
						<TABLE class="tbCommonColor" id="Table5" cellSpacing="0"
							border="0">
							<TR>
								<TD class="tdSpaceH12Color"></TD>
							</TR>
						</TABLE>

						<TABLE class="tbBlock" id="Table1" cellSpacing="1" border="0">
							<TR>
								<TD class="tdPrompt">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;角色<s:if test="id == null">新增</s:if><s:else>修改</s:else>：
								</TD>
							</TR>
						</TABLE>
						<TABLE id="Table2" cellSpacing="1" border="0" class="tbBlock">
						
							
							<TR>
								<TD class="tdRightW30H40">
									角色名:
								</TD>
								<TD class="tdLeftH40">
									<input type="text" id="name" name="name" size="40" value="${name}"
										class="required" />
								</TD>
							</TR>							
							<tr>
								<TD class="tdRightW30H40">
									权限:
								</td>
								<TD class="tdLeftH40">
									<div
										style="word-break: break-all; width: 400px; overflow: auto;">
										<s:checkboxlist id="checkedIds" name="checkedIds" list="allPermissions"
											listKey="id" listValue="displayName" cssClass="button" />
									</div>
								</td>
							</tr>	
							<tr>
								<TD class="tdRightW30H40">
									菜单:
								</td>
								<TD class="tdLeftH40">
									<div
										style="word-break: break-all; width: 400px; overflow: auto;">
										<s:checkboxlist id="checkedMenuIds" name="checkedMenuIds" list="allMenus"
											listKey="id" listValue="displayName" cssClass="button" />
									</div>
								</td>
							</tr>							
							<tr>
								<TD class="tdRightW30H40">
									描述:
								</td>
								<TD class="tdLeftH40">
									<textarea id="description" name="description" rows="5" cols="30">${description}</textarea>
								</td>
							</tr>
						</TABLE>
						<TABLE class="tbCommonColor" id="Table3" cellSpacing="1"
							border="0">
							<TR>
								<TD class="tdCenterW30H40"></TD>
								<TD class="tdLeftH40">
									<input type="button" name="uc_am_ModiQueryPwd1:BtnOK"
										value="确 定" id="uc_am_ModiQueryPwd1_BtnOK" class="btn"
										onclick="subForm()" />
									<input type="button" name="cancelButton"
										value="取消" id="cancelButton" class="btn"
										onclick="cancel()" />
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
							height="20">
							<TR>
								<TD class="tdExplain">
									<IFRAME class="ifExplain" id="ExplainPageFrame"
										name="ExplainPageFrame"
										src="${base}/common/help/menu-help.jsp" frameBorder="0"
										scrolling="no"></IFRAME>
								</TD>
							</TR>
						</TABLE>
					</TD>
				</TR>

			</TABLE>
			<div id="message" style="display: none;">
				<s:actionmessage theme="simple" />
			</div>
		</form>

	</body>
</html>


