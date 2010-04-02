<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.Function"%>

<%@ include file="/jsp/common/header/include_init.jsp" %>

<html>
<head>
<title><%=Function.getMultiLangItemContent("Business.Title",request)%></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
<!--
body,td,th {
	color: #666666;
	font-family:Tahoma,Verdana,Segoe,sans-serif;
}
-->
</style></head>
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<p>&nbsp;</p>
<table width="70%" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td width="19"> <img src="<%=strContextPath%>/images/error/error_01.gif" width="19" height="19" alt=""></td>
    <td width="171" background="<%=strContextPath%>/images/error/error_02.gif"> <img src="<%=strContextPath%>/images/error/error_02.gif" width="5" height="19" alt=""></td>
    <td background="<%=strContextPath%>/images/error/error_03.gif"> <img src="<%=strContextPath%>/images/error/error_03.gif" width="5" height="19" alt=""></td>
    <td width="19"> <img src="<%=strContextPath%>/images/error/error_04.gif" width="19" height="19" alt=""></td>
  </tr>
  <tr>
    <td width="19" background="<%=strContextPath%>/images/error/error_05.gif"> <img src="<%=strContextPath%>/images/error/error_05.gif" width="19" height="5" alt=""></td>
    <td width="171" height="260" align="center" bgcolor="fbfbfb" style="border-right:1px solid #f4f4f4"> <img src="<%=strContextPath%>/images/error/error_06.jpg" width="114" height="102" border="0" align="absmiddle"> </td>
    <td bgcolor="#FFFFFF">
      <blockquote>
        <div style="font-size:16px; font-family:Arial, Helvetica, sans-serif; font-weight:bold; color: #FF6600;"><%=Function.getMultiLangItemContent("System.Error.Page.Notice1",request) %></div>
        <hr size="1">
        <div style="font-size:12px;"><%=Function.getMultiLangItemContent("System.Error.Page.Notice2",request) %></div>
    </blockquote></td>
    <td width="19" background="<%=strContextPath%>/images/error/error_08.gif"> <img src="<%=strContextPath%>/images/error/error_08.gif" width="19" height="5" alt=""></td>
  </tr>
  <tr>
    <td width="19"> <img src="<%=strContextPath%>/images/error/error_09.gif" width="19" height="19" alt=""></td>
    <td width="171" background="<%=strContextPath%>/images/error/error_10.gif"> <img src="<%=strContextPath%>/images/error/error_10.gif" width="5" height="19" alt=""></td>
    <td background="<%=strContextPath%>/images/error/error_11.gif"> <img src="<%=strContextPath%>/images/error/error_11.gif" width="5" height="19" alt=""></td>
    <td width="19"> <img src="<%=strContextPath%>/images/error/error_12.gif" width="19" height="19" alt=""></td>
  </tr>
</table>
</body>
</html>