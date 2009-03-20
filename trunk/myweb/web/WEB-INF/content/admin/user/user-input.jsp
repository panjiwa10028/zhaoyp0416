<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" >
<html>
	<head>
		<title></title>
		<%@ include file="/common/meta.jsp"%>
		<link href="${base}/js/validate/jquery.validate.css" type="text/css" rel="stylesheet" />
		<link href="${base}/scripts/validate/jquery.validate.css" type="text/css" rel="stylesheet" />
<script language="javascript" src="${base}/scripts/validate/jquery.validate.js" type="text/javascript"></script>
<script language="javascript" src="${base}/scripts/validate/messages_cn.js" type="text/javascript"></script>
<script language="javascript" src="${base}/scripts/date-picker/WdatePicker.js"  type="text/javascript" ></script>

		<script>
		$(document).ready(function(){
			$("#loginName").focus();
			$("#inputForm").validate({
				 rules: { 
					loginName: { 
	        			required: true, 
	        			remote: "user!checkLoginName.action?orgLoginName=${loginName}"
	    			},
	            	name: "required",
	            	password: {
	    				required: true,
	    				minlength:3
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
	}

	function subForm() {
		inputForm.submit();
	}

	function setStatusBarInfo(info)
	{
		document.getElementById('statusBarInfo').innerHTML = 'transactInfo'+info;
		document.getElementById('processMessage').style.display = 'block';
	}
	
</script>


	</head>

	<body scroll="auto" style="overflow: auto" onload="initPage()">
	<form id="inputForm" name="inputForm" action="user!save.action" method="post">
<input type="hidden" name="id" value="${id}" />
<input type="hidden" name="page.pageRequest" value="${page.pageRequest}" />
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
								登录名:
							</TD>
							<TD class="tdLeftH40">
								<input type="text" name="loginName" size="40" id="loginName" value="${loginName}" class="required"/>
							</TD>
						</TR>	
						<TR>
							<TD class="tdRightW30H40">
								用户名:
							</TD>
							<TD class="tdLeftH40">								
								<input type="text" name="name" size="40" value="${name}" class="required"/>
							</TD>
						</TR>
						<tr>
							<TD class="tdRightW30H40">
							密码:
							</td>
							<TD class="tdLeftH40">			
							<input type="password" id="password" name="password" size="40" value="${password}" class="required"/>
							</td>
						</tr>
						<tr>
							<TD class="tdRightW30H40">
							确认密码:
							</td>
							<TD class="tdLeftH40">			
							<input type="password" name="passwordConfirm" size="40" value="${password}" class="required"/>
							</td>
						</tr>						
						<tr>
							<TD class="tdRightW30H40">
							角色:
							</td>
							<td>
							<div style="word-break:break-all;width:250px; overflow:auto; ">
								<s:checkboxlist name="checkedRoleIds"  list="allRoles"  listKey="id" listValue="name" cssClass="button"/>
							</div>
							</td>
						</tr>	
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
						height="20">
						<TR>
							<TD class="tdExplain">
								<IFRAME class="ifExplain" id="ExplainPageFrame"
									name="ExplainPageFrame" src="${base}/common/help/menu-help.jsp" frameBorder="0"
									scrolling="no"></IFRAME>
							</TD>
						</TR>
					</TABLE>
				</TD>
			</TR>
			
		</TABLE>
			<div id="message" style="display:none;"><s:actionmessage theme="simple"/></div>
		</form>
		
	</body>
</html>


