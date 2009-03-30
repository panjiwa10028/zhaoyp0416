<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ page import="org.springframework.security.ui.AbstractProcessingFilter"%>
<%@ page import="org.springframework.security.ui.webapp.AuthenticationProcessingFilter"%>
<%@ page import="org.springframework.security.AuthenticationException"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><s:text name="page.title"/></title>
		<%@ include file="/common/meta.jsp"%>
		<script src="${base}/scripts/validate/jquery.validate.js" type="text/javascript"></script>
		<script src="${base}/scripts/validate/messages_cn.js" type="text/javascript"></script>
  		<script>
  			$(document).ready(function(){
  				$("#userName").focus();
    			$("#loginForm").validate();
 			 });
  		</script>
	</head>
	<body>
		<div id="content">
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
			<h2>My-Web示例</h2>
			<h3>--管理界面</h3>
			<form id="loginForm" action="${base}/j_spring_security_check" method="post">
				<table class="inputView">
					<tr>
						<td>
							用户名:
						</td>
						<td>
							<input type='text' id="userName" name='j_username'
								<s:if test="not empty param.error"> value='<%=session.getAttribute(AuthenticationProcessingFilter.SPRING_SECURITY_LAST_USERNAME_KEY)%>'</s:if> class="required"/>
						</td>
					</tr>
					<tr>
						<td>
							密码:
						</td>
						<td>
							<input type='password' id="password" name='j_password' class="required" />
						</td>
					</tr>
					<tr>
						<td>
							验证码:
						</td>
						<td>
							<input size="5" id="vcode"	onkeydown="if(event.keyCode==13)  document.getElementById('login').focus();"
			type="text"  name="vcode" autocomplete="off"> 
			<img id="vcodeimg" style="cursor: hand"	onclick="this.src='${base}/admin/verify-image.action?time=' + Math.random()"
			title="点击刷新验证码" align="absMiddle" src="" /> 
			<script	type="text/javascript">
                document.getElementById('vcodeimg').src='${base}/admin/verify-image.action?id=${olid}&time=' + Math.random();
				document.getElementById('vcode').value = "";
			</script>
						</td>
					</tr>
					<tr>
						<td>
							<input type="checkbox" name="_spring_security_remember_me" />
						</td>
						<td>
							两周内记住我
						</td>
					</tr>
					<tr>
						<td colspan='2'>
							<input value="登录" type="submit" />
						</td>
					</tr>
				</table>
			</form>
			<p>（管理员<b>admin/admin</b> ,普通用户<b>user/user</b>）</p>

		</div>
	</body>
</html>

