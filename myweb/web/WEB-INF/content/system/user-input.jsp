<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>帐号管理</title>
<link href="${base}/scripts/validate/jquery.validate.css" type="text/css" rel="stylesheet" />
<script src="${base}/scripts/validate/jquery.validate.js" type="text/javascript"></script>
<script src="${base}/scripts/validate/messages_cn.js" type="text/javascript"></script>

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
    			},
    			email:"email"
           		
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
	
</script>
</head>

<body>
<h3><s:if test="user.id == null">创建</s:if><s:else>修改</s:else>用户</h3>
<form id="inputForm" action="user!save.action" method="post">
<input type="hidden" name="user.id" value="${user.id}" />
<input type="hidden" name="user.version" value="${user.version}" />
<table class="inputView">
	<tr>
		<td>登录名:</td>
		<td><input type="text" name="user.username" size="40" id="loginName" value="${user.username}" class="required"/></td>
	</tr>
	<tr>
		<td>用户名:</td>
		<td><input type="text" name="user.cnname" size="40" value="${user.cnname}" class="required"/></td>
	</tr>
	<tr>
		<td>密码:</td>
		<td><input type="password" id="password" name="user.password" size="40" value="${user.password}" class="required"/></td>
	</tr>
	<tr>
		<td>确认密码:</td>
		<td><input type="password" name="passwordConfirm" size="40" value="${user.password}" class="required"/></td>
	</tr>
	<tr>
		<td>邮箱:</td>
		<td><input type="text" name="user.email" size="40" value="${user.email}"  class="email"/></td>
	</tr>
	<tr>
		<td>角色:</td>
		<td>
		<div style="word-break:break-all;width:250px; overflow:auto; ">
			<s:checkboxlist name="ids"  list="allRoles"  listKey="id" listValue="cnname" cssClass="button"/>
		</div>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="提交" class="button"/>&nbsp; 
			<input type="button" value="取消" onclick="back();" class="button"/>
		</td>
	</tr>
</table>
</form>
</body>
</html>