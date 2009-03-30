<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" >
<html>
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
			$("#loginName").focus();
			$("#inputForm").validate({
				 rules: { 
					name: { 
	        			required: true, 
	        			remote: "menu!checkName.action?orgName=${name}"
	    			}
	           		
				},
				messages: {
					name: {
						remote: "用户登录名已存在"
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
		top.mainWorkArea.location='menu.action';
	}

	function setStatusBarInfo(info)
	{
		document.getElementById('statusBarInfo').innerHTML = 'transactInfo'+info;
		document.getElementById('processMessage').style.display = 'block';
	}
	
</script>


	</head>

	<body scroll="auto" style="overflow: auto" onload="initPage()">
		<form id="inputForm" name="inputForm" action="menu!save.action"
			method="post" >
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
									<span id="Location">系统管理 > 菜单设定 > 菜单<s:if test="id == null">新增</s:if><s:else>修改</s:else></span>
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
												<pre style="margin: 0px">菜单设定</pre>
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
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;菜单<s:if test="id == null">新增</s:if><s:else>修改</s:else>：
								</TD>
							</TR>
						</TABLE>
						<TABLE id="Table2" cellSpacing="1" border="0" class="tbBlock">
						
							<TR>
								<TD class="tdRightW30H40">
									上级菜单:
								</TD>
								<TD class="tdLeftH40">
									<s:select id="parentId" name="parentId" list="allMenus" listKey="id" listValue="displayName"/>
								</TD>
							</TR>
							<TR>
								<TD class="tdRightW30H40">
									菜单名称:
								</TD>
								<TD class="tdLeftH40">
									<input type="text" name="displayName" size="40" value="${displayName}"
										class="required" />
								</TD>
							</TR>	
							<TR>
								<TD class="tdRightW30H40">
									菜单唯一标识:
								</TD>
								<TD class="tdLeftH40">
									<input type="text" name="name" size="40" value="${name}"
										class="required" />
								</TD>
							</TR>
							<TR>
								<TD class="tdRightW30H40">
									菜单路径:
								</TD>
								<TD class="tdLeftH40">
									<input type="text" name="url" size="40" value="${url}"
										class="required" />
								</TD>
							</TR>
							<TR>
								<TD class="tdRightW30H40">
									是否可见:
								</TD>
								<TD class="tdLeftH40">
									<input type="checkbox" name="disabled"/>
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

