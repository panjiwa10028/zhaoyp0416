<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.Function"%>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>
<%@ taglib prefix="fmt" uri="/WEB-INF/fmt.tld" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>

<HTML>
<HEAD>
<TITLE>top menu</TITLE>
<%@ include file="/jsp/common/header/include_init.jsp" %>
<link href="<%=strContextPath%>/css/chrome.css"  rel="stylesheet"  type="text/css">
<script src="<%=strContextPath%>/script/common.js"></script>
<%
String i=request.getParameter("id");
%>
<script language="javascript" type="text/javascript">
function loadModule(name,diretory,lefturl,workurl)
{
	document.getElementById("diretory").style.display="block";
	document.getElementById("message").innerHTML =diretory;

	if(lefturl=="<%=strContextPath%>/")
	{
		mainIndex.location.href=workurl;
	}
	else
	{
		t="<%=strContextPath%>/jsp/main/main_index.jsp";
		
		top.leftUrl=lefturl;
		top.workUrl=workurl;
		mainIndex.location.href=t;
	}
}

function setDiretory(diretory)
{
	document.getElementById("diretory").style.display="block";
	document.getElementById("message").innerHTML =diretory;
}
function loadinfo() {
//setTimeout("addTab('个人首页','/BusinessCenter/jsp/workArea.jsp')",100);
	if('<c:out value="${param.id}" />'=='epm'){
	
		t="<%=strContextPath%>/jsp/main/main_index.jsp";
		top.leftUrl="<%=strContextPath%>/jsp/CustomerCenterManager/CustomerEnterpriseManager/leftView.jsp";
		top.workUrl="<%=strContextPath%>/jsp/CustomerCenterManager/CustomerEnterpriseManager/workArea.jsp";
		mainIndex.location.href=t;
		
	}else if('<c:out value="${param.id}" />'=='ppm'){
		t="<%=strContextPath%>/jsp/main/main_index.jsp";
		top.leftUrl="<%=strContextPath%>/jsp/CustomerCenterManager/CustomerPersonalManager/leftView.jsp";
		top.workUrl="<%=strContextPath%>/jsp/CustomerCenterManager/CustomerPersonalManager/workArea.jsp";
		mainIndex.location.href=t;
	}else{
		if(top.leftUrl=="<%=strContextPath%>/")
		{
			mainIndex.location.href=top.workUrl;
		}
		else
		{
			t="<%=strContextPath%>/jsp/main/main_index.jsp";
			mainIndex.location.href=t;
		}
	}
	/*
	if(top.tempDir) 
	{			
		document.getElementById("workMenu").style.display="none";
		document.getElementById("diretory").style.display= "block";
		document.getElementById("message").innerHTML = top.tempDir;		
	}
	*/
}
</script>
<link href="<%=strContextPath%>/css/chrome.css" rel="stylesheet" type="text/css">
</HEAD>
<BODY onLoad="loadinfo();" scroll="no">
<iframe id="menuIfm" frameborder=0 marginheight=0 marginwidth=0 hspace=0 vspace=0 scrolling=no style='position:absolute;display:none;z-index:0;'></iframe>
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
<tr valign="top">
    <td id=""mainIndex"" width="100%" height="100%">
    	<iframe id="mainIndex"  allowtransparency="yes" frameborder="0" height="100%" width="100%" hspace="0" longdesc="0" marginheight="0" marginwidth="0" scrolling="no" vspace="0"></iframe>
    </td>
  </tr>
  </table>
</BODY>
</HTML>
