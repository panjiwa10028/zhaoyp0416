<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.Function"%>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ include file="/jsp/common/header/include_init.jsp" %>
<%
	String contextPath = request.getContextPath();
	
	response.setHeader("Pragma", "No-cache");
	response.setDateHeader("Expires", 0);
	response.setHeader("Cache-Control", "no-cache");
%>
<html>
<head>
<title><%=Function.getMultiLangItemContent("Business.Title",request)%></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=contextPath%>/css/style.css"  rel="stylesheet"  type="text/css">
<script src="<%=strContextPath%>/script/Timer.js" language="JavaScript" type="text/javascript"></script> 
<script>
var win;
function loadInfo()
{
	var para = window.dialogArguments;
	openDialog.location = para[0];
	win = para[1];
	try {
		viewTime();
	}catch(e){}
	try {
		showTime();
		showAUXTime();
	}catch(e){}
}
</script>
</head>
<body onLoad="loadInfo()">
<iframe name="openDialog" src="#" width="100%" height="100%" frameborder="0" scrolling="no"> </iframe>
</body>
</html>
