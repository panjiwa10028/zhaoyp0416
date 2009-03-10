<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title>登录页</title>
		<script src="${base}/scripts/validate/jquery.validate.js" type="text/javascript"></script>
		<script src="${base}/scripts/validate/messages_cn.js" type="text/javascript"></script>
  		<script>
  			$(document).ready(function(){
    			$("#loginForm").validate();
 			 });
  		</script>
	</head>
	<body>
			<% 
				if(request.getParameter("error")!=null&&request.getParameter("error").equals("1")){
					%>
						<span style="color:red"> 登录失败，请重试！ </span>
					<%
				}else if(request.getParameter("error")!=null&&request.getParameter("error").equals("3")){
					%>
						<span style="color:red"> 系统发现您在别处登录！ </span>
					<%
				} 
			%>
			<h2>示例</h2>
			<form id="loginForm" action="${base}/j_spring_security_check" method="post">
				<table class="inputView">
					<tr>
						<td>
							用户名:
						</td>
						<td>
							<input type='text' name='j_username' class="required"/>
						</td>
					</tr>
					<tr>
						<td>
							密码:
						</td>
						<td>
							<input type='password' name='j_password' class="required" />
						</td>
					</tr>
					<tr>
						<td>
							<input type="checkbox" name="_spring_security_remember_me" class="button"/>
						</td>
						<td>
							两周内记住我
						</td>
					</tr>
					<tr>
						<td colspan='2'>
							<input value="登录" type="submit" class="button"/>
						</td>
					</tr>
				</table>
			</form>
			<p>（管理员<b>admin/admin</b> ,普通用户<b>user/user</b>）</p>
	</body>
</html>

