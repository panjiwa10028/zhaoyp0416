<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="java.util.Enumeration"%>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<title>SS3Ex框架演示-<decorator:title></decorator:title> </title>
	<meta http-equiv="Content-Type" content="text/html;charset=utf-8" />
	<meta http-equiv="Cache-Control" content="no-store"/>
	<meta http-equiv="Pragma" content="no-cache"/>
	<meta http-equiv="Expires" content="0"/>
	<script src="${base}/scripts/jquery.js" type="text/javascript"></script>
	<link href="${base}/style/default.css" type="text/css" rel="stylesheet">
	<link href="${base}/style/style.css" rel="stylesheet" type="text/css" />
	<decorator:head></decorator:head>
	<%
		Enumeration d=request.getHeaders("referer");
		String back="";
        while(d.hasMoreElements()){
            Object o=d.nextElement();
            back=o.toString();
        }
	%>
	<script type="text/javascript">
		function back(){
			window.navigate('<%=back%>');
		}
	</script>
</head>

<body>
<div id="container">

	<div id="header">
		<form><div style="font-size: 20px;font-style: italic;color:white;"><security:authorize ifNotGranted="ROLE_ANONYMOUS">欢迎:<security:authentication property="name"/>登录系统</security:authorize></div></form>
		<h1>SS3Ex框架演示</h1>
	</div>
	
	<div id="menu_container">
		<div id="menu">
			<ul>
				<li><a title="首页" href="/">首页</a></li>
				<li><a title="演示1" href="${base}/demo/news.action">演示1</a></li>
				<li><a title="演示2" href="${base}/demo/news!search.action">演示2</a></li>
				<li><a title="用户管理" href="${base}/system/user.action">用户管理</a></li>
				<li><a title="角色管理" href="${base}/system/role.action">角色管理</a></li>
				<li><a title="资源管理" href="${base}/system/resource.action">资源管理</a></li>
				<li><a title="退出系统" href="${base}/j_spring_security_logout">退出系统</a></li>
			</ul>
		</div>
	</div>
	
	<div id="content">
		<div class="sidebar_content_content" style="width: 300px; height: 20px;">
				提示:<s:actionmessage/>
		</div> <br/>
		<div id="posts">
			<decorator:body></decorator:body>
		</div>
	
	</div>
	<div id="footer">
		<p>&copy; SS3Ex | <a href="#">RSS FEED</a> <img class="icon" src="${base}/images/feed.gif" alt="RSS Feed" width="16" height="16" /> | DESIGN BY <a href="#">CaoYangX</a> | <a href="#">XHTML</a> 1.0 TRANSITIONAL</p>
	</div>
</div>

</body>
</html>