<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<%@ page import="org.springframework.security.ui.AbstractProcessingFilter"%>
<%@ page import="org.springframework.security.ui.webapp.AuthenticationProcessingFilter"%>
<%@ page import="org.springframework.security.AuthenticationException"%>
<%
response.setHeader("Pragma", "No-cache");
response.setHeader("Cache-Control", "no-cache");
response.setDateHeader("Expires", 0);
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
	<head>
		<title><s:text name="page.title"/></title>
		<%@ include file="/common/meta.jsp"%>
		<link href="${base}/scripts/validate/jquery.validate.css"
			type="text/css" rel="stylesheet" />
		<script language="javascript"
			src="${base}/scripts/validate/jquery.validate.js"
			type="text/javascript"></script>
		<script language="javascript"
			src="${base}/scripts/validate/messages_cn.js" type="text/javascript"></script>
  		<script language="JavaScript" type="text/JavaScript">
  			$().ready(function(){
  				$("#userName").focus();
    			$("#loginForm").validate({
   				 rules: { 
    				j_username: "required" ,
    				j_password: "required" ,
    				j_captcha: "required" 
   				}
   			});
 			 });
  		</script>
	</head>
	<body>


		<div id="content">
			<% 
				if(request.getParameter("error")!=null&&request.getParameter("error").equals("2")){
					%>
					<span style="color:red"> 用户名、密码错误！ </span>
				<%
			}else if(request.getParameter("error")!=null&&request.getParameter("error").equals("3")){
					%>
						<span style="color:red"> 系统发现您在别处登录！ </span>
					<%
				} else if(request.getParameter("error")!=null&&request.getParameter("error").equals("4")){
					%>
					<span style="color:red"> 验证码输入不正确！ </span>
				<%
			}  else if(request.getParameter("error")!=null&&request.getParameter("error").equals("5")){
				%>
				<span style="color:red"> 帐号失效！ </span>
			<%
		}  else if(request.getParameter("error")!=null&&request.getParameter("error").equals("6")){
			%>
			<span style="color:red"> 账号不可用！ </span>
		<%
	}  else if(request.getParameter("error")!=null&&request.getParameter("error").equals("7")){
		%>
		<span style="color:red"> 帐号锁定！ </span>
	<%
} 
%>
			<h2><s:text name="page.title"/></h2>
			<h3>--管理界面</h3>
			<form id="loginForm" name="loginForm" action="${base}/j_spring_security_check" method="post">
				<table class="inputView">
					<tr>
						<td>
							用户名:
						</td>
						<td>
							<input type='text' id="userName" name='j_username'
								<s:if test="not empty param.error"> value='<%=session.getAttribute(AuthenticationProcessingFilter.SPRING_SECURITY_LAST_USERNAME_KEY)%>'</s:if>/>
						</td>
					</tr>
					<tr>
						<td>
							密码:
						</td>
						<td>
							<input type='password' id="password" name='j_password'/>
						</td>
					</tr>
					<tr>
						<td>验证码:</td>
						<td><input type='text' name='j_captcha'/></td>
						<td valign="bottom"><img src="${base}/security/jcaptcha.jpg" onclick="this.src='${base}/security/jcaptcha.jpg?'+Math.random()" style="cursor:pointer;"/></td>
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
							<input value="登录" type="submit"/>
						</td>
					</tr>
				</table>
			</form>
			<p>（管理员<b>admin/admin</b> ,普通用户<b>user/user</b>）</p>

		</div>
	</body>
</html>

