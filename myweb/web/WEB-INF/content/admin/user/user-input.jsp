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
			$("#loginName").focus();
			$("#inputForm").validate({
				 rules: { 
					groupId: {
						required: true
		 			},
					loginName: { 
	        			required: true, 
	        			remote: encodeURI("user!checkLoginName.action?orgLoginName=${loginName}")
	    			},
	            	name: "required",
	            	password: {
	    				required: true,
	    				rangelength:[6,12]
	    			}, 
	    			passwordConfirm: {
	    				required: true,
	    				equalTo:"#password"
	    			}
	    			
	           		
				},
				messages: {
					loginName: {
						remote: "用户登录名已存在"
					},
					passwordConfirm: {
						equalTo: "输入与上面相同的密码"
					}
				}
			});
		});

	function initPage() {
		top.setStatusBarInfo('');
		if($("#message").text() != '') {
			top.setStatusBarInfo($("#message").text());
		}	
		if($("#id").val() == "1") {
			$("#groupTR").attr("style","display:none");
			$("#groupId").attr("disabled","disabled");
			$("#groupId").val("-1");
		}
		if($("#id").val() != "") {
			$("#passTR").attr("style","display:none");
			$("#passConfirmTR").attr("style","display:none");
			
			$("#passwordConfirm").attr("disabled","disabled");
			
			$("#password").attr("disabled","disabled");
			$("#loginName").attr("readonly","readonly");
		}
	}

	function subForm() {
		top.setStatusBarInfo('');		
		$("#inputForm").submit();
	}

	function cancel() {
		top.mainWorkArea.location='user.action';
	}

	function setStatusBarInfo(info)
	{
		document.getElementById('statusBarInfo').innerHTML = 'transactInfo'+info;
		document.getElementById('processMessage').style.display = 'block';
	}
	
</script>


	</head>

	<body scroll="auto" style="overflow: auto" onload="initPage()">
		<form id="inputForm" name="inputForm" action="user!save.action"
			method="post">
			<s:token/>
			<input type="hidden" id="id" name="id" value="${id}" />
			<input type="hidden" name="page.pageRequest"
				value="${page.pageRequest}" />
			<TABLE class="tbMain" id="Table1" cellSpacing="0" border="0">
				<TR>
					<TD class="tdCommonTop">
						<TABLE class="tbTitle" id="Table2" cellSpacing="0" border="0">
							<TR>
								<TD class="tdTitle1" colSpan="1" rowSpan="1">
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;当前功能：
									<span id="Location">用户管理 > <a href='#' onclick="cancel()">用户设定</a> > 用户<s:if test="id == null">新增</s:if><s:else>修改</s:else></span>
								</TD>
								<TD class="tdTitle2"></TD>
								<TD class="tdTitle3">
									版面号：101005
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
												<pre style="margin: 0px">用户设定</pre>
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
									&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;用户<s:if test="id == null">新增</s:if><s:else>修改</s:else>：
								</TD>
							</TR>
						</TABLE>
						<TABLE id="Table2" cellSpacing="1" border="0" class="tbBlock">
						
							<TR id="groupTR">
								<TD class="tdRightW30H40">
									用户组:
								</TD>
								<TD class="tdLeftH40">
									<s:select id="groupId" name="groupId" list="allGroups" listKey="id" listValue="name"/>
								</TD>
							</TR>
							<TR>
								<TD class="tdRightW30H40">
									登录名:
								</TD>
								<TD class="tdLeftH40">
									<input type="text" name="loginName" size="40" id="loginName"
										value="${loginName}" class="required" />
								</TD>
							</TR>
							<TR>
								<TD class="tdRightW30H40">
									用户名:
								</TD>
								<TD class="tdLeftH40">
									<input type="text" name="name" size="40" value="${name}"
										class="required" />
								</TD>
							</TR>
							<tr id="passTR">
								<TD class="tdRightW30H40">
									密码:
								</td>
								<TD class="tdLeftH40">
									<input type="password" id="password" name="password" size="40"
										value="${password}" class="required" />
								</td>
							</tr>
							<tr id="passConfirmTR">
								<TD class="tdRightW30H40">
									确认密码:
								</td>
								<TD class="tdLeftH40">
									<input type="password" id="passwordConfirm" name="passwordConfirm" size="40"
										value="${password}" class="required" />
								</td>
							</tr>
							<tr >
								<TD class="tdRightW30H40">
									角色:
								</td>
								<TD class="tdLeftH40">
									<div
										style="word-break: break-all; width: 250px; overflow: auto;">
										<s:checkboxlist name="checkedRoleIds" list="allRoles"
											listKey="id" listValue="name" cssClass="button" />
									</div>
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

				
			</TABLE>
			<div id="message" style="display: none;">
				<s:actionmessage theme="simple" />
			</div>
		</form>

	</body>
</html>


