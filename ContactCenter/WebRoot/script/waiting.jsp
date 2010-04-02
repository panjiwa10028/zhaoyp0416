<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.BusinessCenterApp" %>
<%@ include file="/jsp/common/header/include_init.jsp" %>
<%
String strMultiLangItem = request.getParameter("strMultiLangItem");
if(strMultiLangItem==null || "".equals(strMultiLangItem))
{
	strMultiLangItem = "common.waiting";
}

long lTimeOutMilliSecond = 0;
String strTimeOutSecond = request.getParameter("nTimeOutSecond");
if(strTimeOutSecond!=null && "".equals(strTimeOutSecond)==false)
{
	try
	{
		lTimeOutMilliSecond = new Integer(strTimeOutSecond).intValue() * 1000;
	}
	catch(Exception ex)
	{
	}
}
if(lTimeOutMilliSecond<=0)
{
	try
	{
		lTimeOutMilliSecond = new Integer(BusinessCenterApp.getInstance().getProperties().getProperty("RMI.WaitTimeSecond", "600")).intValue() * 1000;
	}
	catch(Exception ex)
	{
		lTimeOutMilliSecond = 600000;
	}
}
%>
<iframe id="coverIFrame" style="position:absolute; border-width:0px; top:0px; left:0px; width:0px; height:0px;z-index:10001010; background-color:#ffffff;filter:alpha(Opacity=0);opacity:0"></iframe>
<div id="coverDIV" style="background-color:#f0f0f0;position:absolute;border-width:0px;left:0px;top:0px;height:0px;width:0px;z-index:10001011;filter:alpha(opacity=70);display:none;">
<table border="0" align="center" width="100%" height="100%">
  <tr>
    <td>
	    <table border="0" align="center" width="300" height="50" bgcolor="#FFFFFF" style="border-style:groove;border-width:thin;">
	  	  <tr>
	    	<td> <img src="<%=strContextPath%>/images/waiting.gif" width="26" height="26"> <%=Function.getMultiLangItemContent(strMultiLangItem, request)%> </td>
	  	  </tr>
		</table>
    </td>
  </tr>
</table>
</div>
<script language="JavaScript" type="text/JavaScript">
<!--
	var coverDIV = document.getElementById("coverDIV");
	function timeOutWaiting()
	{
		if(coverDIV.style.display=="block")
		{
			alert("<%=Function.getMultiLangItemContent("common.timeout", request)%>");
			hideWaitingPage();
		}
	}
	
	function showWaitingPage(isTimeOut)
	{
		coverDIV.style.display = "block";
		coverDIV.style.top = "0px";
		coverDIV.style.left = "0px";
		coverDIV.style.height = document.body.clientHeight;
		coverDIV.style.width = document.body.clientWidth;
		try{
			document.getElementById("coverIFrame").style.display = "block";
			document.getElementById("coverIFrame").style.top = "0px";
			document.getElementById("coverIFrame").style.left = "0px";
			document.getElementById("coverIFrame").style.height = document.body.clientHeight;
			document.getElementById("coverIFrame").style.width = document.body.clientWidth;
		}catch(e){
			//alert(e.description);
		}
		if(isTimeOut==false){
			
		}else{
			setTimeout("timeOutWaiting()", "<%=lTimeOutMilliSecond%>");
		}
		
	}
	
	function hideWaitingPage(flag)
	{
		if(top.nRemindExpiredDate!= undefined && top.dtPasswordExpiredDate != undefined && (top.nRemindExpiredDate.value==1) && (top.dtPasswordExpiredDate.value!=""))// 判断是否提醒密码过期时间
		{
			alert("<%=Function.getMultiLangItemContent("login.remind.expired",request)%> " + dtPasswordExpiredDate.value + " <%=Function.getMultiLangItemContent("login.expired",request)%>");
		}
		
		if(flag != undefined && flag == 'sys' && top.nPWNeedChangeFlag && top.nPWNeedChangeFlag.value==1)// 判断是否需要修改密码
		{
			//top.showPasswordWaitingPage();
			alert("<%=Function.getMultiLangItemContent("login.must.change.password",request)%>");
			top.modifyPassword();
		}else
		{
			coverDIV.style.height = "0px";
			coverDIV.style.width = "0px";
			coverDIV.style.display = "none";
			try{
			document.getElementById("coverIFrame").style.display = "none";
			}catch(e){
				//alert(e.description);
			}
		}
	}
	
	function hideWaitPasswordPage()
	{
		coverDIV.style.height = "0px";
		coverDIV.style.width = "0px";
		coverDIV.style.display = "none";
		
		try{
		document.getElementById("coverIFrame").style.display = "none";
		}catch(e){
			//alert(e.description);
		}
	}
//-->
</script>