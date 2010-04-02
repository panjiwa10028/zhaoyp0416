<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.Function" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.BusinessCenterApp" %>
<%@ page import="EZLib.Message.EZMessage" %>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>
<%@ taglib prefix="fmt" uri="/WEB-INF/fmt.tld" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib prefix="fmt" uri="/WEB-INF/fmt.tld" %>
<%
response.setHeader("Pragma", "No-cache");
response.setDateHeader("Expires", 0);
response.setHeader("Cache-Control", "no-cache");
%>
<%@ include file="/jsp/common/header/include_init.jsp"%>
<%@ include file="/jsp/common/header/include_script.jsp"%>
<%@ include file="/jsp/common/header/include_getRequiredParameter.jsp" %>
<html>
<head>
<link href="<%=request.getContextPath()%>/css/personstyle.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
<!--
body {
	margin: 1px;
	overflow:auto;
}
-->
</style>
<script>
	
</script>
</head>
<body oncontextmenu="" >
	<!--a href="javascript:top.setOutboundBoundStat('16000')">aaac</a-->
  <c:if test='${STRNAME!=null && STRNAME!=""}' >
	<table width="100%" border="0" cellspacing="3" cellpadding="0">
		  <tr>                
                    <tr> 
                      <td width="40%"><div align="center"><img src="<%=strContextPath%>/FileManage/downloadFileServlet?strServiceName=MedalManager&strTransName=GetMedalAttachedFile&strFieldName=binImage&lId=<c:out value="${LID}"/>&lTenantId=<c:out value="${param.lTenantId}"/>&lUserId=<c:out value="${param.lUserId}"/>&strUserName=<c:out value="${param.strUserName}"/>" width="16" height="16"></div></td>
                      <td width="60%"><font color="red">&nbsp;<c:out value='${STRNAME}' /></font></td>
                    </tr>
                    <tr> 
                      <td width="40%" align="right" valign="bottom"><%=Function.getMultiLangItemContent("LocaleManager.Medal.Assign.ValidDateName",request)%></td>
                      <td width="60%" valign="bottom"><div align="left">&nbsp;<fmt:formatDate value="${DTVALIDDATE}" pattern="yyyy-MM-dd" /></div></td>
                    </tr>              
                    <tr> 
                      <td width="40%" align="right" valign="bottom"><%=Function.getMultiLangItemContent("LocaleManager.Medal.AwardDate",request)%></td>
                      <td width="60%" valign="bottom"><div align="left">&nbsp;<fmt:formatDate value="${DTAWARDDATE}" pattern="yyyy-MM-dd" /></div></td>
                    </tr>
          </tr>
	</table>
  </c:if>	
</body>
</html>