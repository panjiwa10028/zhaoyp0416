<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>mainIframe</title>
</head>
<%
String strProductId = "" + (String) request.getParameter("strProductId");
if(strProductId == null) strProductId="";
%>
<frameset cols="210,*" frameborder="yes" border="0" framespacing="2" id="mainFrame"  bordercolor="b7b5b5">
<%
if("AdminCenter".equals(strProductId))
{
%>
	<frame src="aLeftTree.jsp" name="leftTreeFrame" id="leftTreeFrame" scrolling="NO"  bordercolor="b7b5b5" >
<%
}else
{
%>
	<frame src="leftTree.jsp" name="leftTreeFrame" id="leftTreeFrame" scrolling="NO"  bordercolor="b7b5b5" noresize>
<%
}
%>
	<frameset rows="0,*" frameborder="yes" border="0" framespacing="0"  name="centerContentFrame" id="centerContentFrame">
		<frame src="topBlank.jsp" name="topNull" id="topNull">
		<frame src="mainCenter.jsp" name="mainCenter" id="mainCenter">
  </frameset>
</frameset>
<noframes><body>
</body></noframes>
</html>
