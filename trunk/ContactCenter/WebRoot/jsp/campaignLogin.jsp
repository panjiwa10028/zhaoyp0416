<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.Function"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%
/**
 * @author Mikey
 */
response.setHeader("Pragma", "No-cache");
response.setDateHeader("Expires", 0);
response.setHeader("Cache-Control", "no-cache");
%>
<%@ include file="/jsp/common/header/include_init.jsp" %>

<html>
<head>
<title><%=Function.getMultiLangItemContent("Campaign.Common.Title.PageTitle",request) %></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="Shortcut Icon" href="<%=strContextPath%>/images/esoon.ico"/>
<link rel="Bookmark" href="<%=strContextPath%>/images/esoon.ico"/>
<link href="<%=strContextPath%>/css/chrome.css"  rel="stylesheet"  type="text/css">
<script src="<%=strContextPath%>/script/cookie.js" language="JavaScript" type="text/javascript"></script>
<script src="<html:rewrite forward='commonHeader'/>"></script>
<script language="javascript">
	var loginWidth=718;
	var loginHeight=540;
	x=(screen.width-loginWidth)/2;
	y=(screen.height-loginHeight)/2;

	window.resizeTo(loginWidth,loginHeight+20);
	window.moveTo(x,y);
	
	var onSubmited = false;
	
	if(window.name!="campaingWeb")
	{
		window.open("about:blank","campaingWeb","toolbar=0,location=0,status=0,menubar=0,scrollbars=auto,resizable=no,width="+loginWidth+"',height="+loginHeight+",left="+x+",top="+y);
		setTimeout('openLogin()',100);
	}

	if (top.workArea) {
		top.location.href = "<%=strContextPath%>/jsp/campaignLogin.jsp";
	}

	document.ondblclick=new Function("dblclick()"); 
	function dblclick(){ 
		if(onSubmited )	
		{
			document.body.style.cursor='wait';
			recoverySubmit('');
			alert('<%=Function.getMultiLangItemContent("login.entry.message",request)%>');
		}		
		return; 
	}
	
function openLogin() {
	window.open("<%=strContextPath%>/jsp/campaignLogin.jsp","campaingWeb","toolbar=0,location=0,status=0,menubar=0,scrollbars=auto,resizable=no,width="+loginWidth+"',height="+loginHeight+",left="+x+",top="+y);
	window.opener=null;
	window.close();
}
function validateForm()
{
	if(loginForm.strTenantId.value=="")
	{
		alert('<%=Function.getMultiLangItemContent("login.strTenantId.null",request)%>');
		loginForm.strTenantId.focus();		
		return false;
	}

	if(loginForm.strLoginId.value=="")
	{
		alert('<%=Function.getMultiLangItemContent("login.username.null",request)%>');
		loginForm.strLoginId.focus();		
		return false;
	}
	
	if(loginForm.strPassword.value=="")
	{
		alert('<%=Function.getMultiLangItemContent("login.password.null",request)%>');
		loginForm.strPassword.focus();		
		return false;
	}
	
	return true;
}

/*
function submitForm()
{
	if(!validateForm())
	{
		return;
	}
	
	loginForm.submit();
}
*/
function submitForm()
{		
	if(!onSubmited)
	{			
		if(!validateForm())
		{
			return;
		}
		onSubmited = true;	
		onsubmit();
		loginForm.submit();
	}else
	{		
		return;
	}
}

function enterSubmit(){
	if (event.keyCode == 13) {
        event.returnValue=false;
        	submitForm();
    }
}

// 显示主页
function showIndex()
{
	window.open("<%=strContextPath%>/jsp/businessLayout.jsp","campaing","toolbar=0,location=0,status=0,menubar=0,scrollbars=auto,resizable=no,width="+screen.width+"',height="+screen.height+",left=0,top=0");
	window.opener=null;
	window.close();
}

//提交状态(鼠标为漏斗状)
function onsubmit(){

  msgInfo.innerHTML = " <%=Function.getMultiLangItemContent("Login.wait",request)%> ";
  document.body.style.cursor='wait';
  displaySubmitTD.style.display = "none";
  blackSubmitTD.style.display 	= "block";
  
}

//恢复状态
function recoverySubmit(msg)
{ 
  if(!(msg))
  	msg = '';
  msgInfo.innerHTML = msg;
  document.body.style.cursor='default';
  displaySubmitTD.style.display = "block";
  blackSubmitTD.style.display 	= "none";
  onSubmited = false;
}

function loadInfo()
{
	loginForm.strLoginId.focus();
	
	recoverySubmit('<%=Function.getMultiLangItemContent((String)request.getAttribute("STRRETURNINFO"), request)%>');	
	// loginForm.strTenantId.value = getCookie("strTenantId");
}

function validateChangeForm()
{
<!--	
	if(changeForm.password.value=='')
	{
		alert('<%=Function.getMultiLangItemContent("login.newPassword.notNull",request)%>');
		
		changeForm.password.focus();
	
		return false;
	}
	
	if(changeForm.repeatPassword.value=='')
	{
		alert('<%=Function.getMultiLangItemContent("login.repeatPassword.notNull",request)%>');
		
		changeForm.repeatPassword.focus();
		
		return false;
	}
	
	if(changeForm.password.value!=changeForm.repeatPassword.value)
	{
		alert('<%=Function.getMultiLangItemContent("login.newPassword.repeatPassword.must.same",request)%>');
		
		changeForm.password.focus();
		
		return false;
	}
	
	return true;
	-->
}

// 修改密码
function submitChangeForm()
{
	if(!validateChangeForm())
	{
		return;
	}
	
	changeForm.action = '<%=strContextPath%>/changePasswordAction.do';
	changeForm.target = "submitFrame";
	
	
	changeForm.submit();
}
</script>
<style type="text/css">
body {
	background-color: #d4d0c4;
	margin:5px;
}
</style>
</head>
<body oncontextmenu="return false;" onkeydown="enterSubmit()" onload="loadInfo();">
<table border="0" height="100%" align="center" cellpadding="0" cellspacing="0" style="border:1px solid #747474;background-color:#d8d8d8">
<form id="loginForm" name="loginForm" action="<%=strContextPath%>/logonAction.do" method="post">
<tr><td valign="top">
<input name="strProductId" type="hidden" value="Campaign" />
<input name="strProductName" type="hidden" value="EZ-Campaign" />
<input name="forward" type="hidden" value="/jsp/campaignLogin.jsp" />
<input name="strServiceIP" type="hidden" value="<c:out value="${pageContext.request.remoteAddr}"/>" />
<table border="0" align="center" cellpadding="0" cellspacing="0" bgcolor="#000000">
  <tr>
    <td><table width="100%" border="0" cellpadding="0" cellspacing="0" bgcolor="#CCCCCC">
        <tr>
          <td><table width="700" height="480" border="0" align="center" cellpadding="0" cellspacing="0">
              <tr>
                <td width="350" height="64"><img src="<%=strContextPath%>/images/login/campaign/A_01.jpg" width="350" height="64" alt=""></td>
                <td colspan="3"><img src="<%=strContextPath%>/images/login/campaign/A_02.jpg" width="350" height="64" alt=""></td>
              </tr>
              <tr>
                <td height="141"><img src="<%=strContextPath%>/images/login/campaign/A_03.jpg" width="350" height="141" alt=""></td>
                <td colspan="3"><img src="<%=strContextPath%>/images/login/campaign/A_04_Enterprise.jpg" width="350" height="141" alt=""></td>
              </tr>
              <tr>
                <td height="148" rowspan="5" valign="top"><img src="<%=strContextPath%>/images/login/campaign/A_05.jpg" width="350" height="148" alt=""></td>
                <td height="21" colspan="3"><img src="<%=strContextPath%>/images/login/campaign/A_06.jpg" width="350" height="21" alt=""></td>
              </tr>
              <tr>
                <td width="114" rowspan="2"><img src="<%=strContextPath%>/images/login/campaign/<%=Function.GetMultiLangName(request)%>/A_07_Enterprise.jpg" width="114" height="72" alt=""></td>
                <td height="34" colspan="2" background="<%=strContextPath%>/images/login/campaign/A_08.jpg"><table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td><INPUT class="box04" name="strLoginId" size="18"></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td height="38" colspan="2" background="<%=strContextPath%>/images/login/campaign/A_09.jpg"><table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
                  <tr>
                    <td><INPUT class="box04" name="strPassword" type="password" size="18"></td>
                  </tr>
                </table></td>
              </tr>
              <tr>
                <td><img src="<%=strContextPath%>/images/login/campaign/A_10.jpg" width="114" height="32" alt=""></td>
                <td width="131" background="<%=strContextPath%>/images/login/campaign/A_11.jpg"><table width="105%"  border="0" cellspacing="0" cellpadding="1">
                  <tr>
                    <td width="55%"></td>
                    <!-- 
                    <td width="45%">
                    <a style="cursor:hand;" onClick="submitForm()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','<%=strContextPath%>/images/login/campaign/<%=Function.GetMultiLangName(request)%>/an1_2.gif',1)"><img src="<%=strContextPath%>/images/login/campaign/<%=Function.GetMultiLangName(request)%>/an1.gif" name="Image14" width="54" height="24" border="0"></a>
                    </td>
                    -->
                    <td width="45%" id="displaySubmitTD" style="display:none">
                    <a style="cursor:hand;" id="submitButton" onClick="submitForm()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','<%=request.getContextPath()%>/images/login/campaign/<%=Function.GetMultiLangName(request)%>/an1_2.gif',1)"><img src="<%=request.getContextPath()%>/images/login/campaign/<%=Function.GetMultiLangName(request)%>/an1.gif" name="Image14" width="54" height="24" border="0"></a>
                    </td>
                    <td width="45%" id="blackSubmitTD">
                    	<img src="<%=request.getContextPath()%>/images/login/campaign/<%=Function.GetMultiLangName(request)%>/an1_2.gif" name="Image16" width="54" height="24" border="0">
                    </td>
                  </tr>
                </table></td>
                <td width="105"><img src="<%=strContextPath%>/images/login/campaign/A_12.jpg" width="105" height="32" alt=""></td>
              </tr>
              <tr>
                <td height="23" colspan="3" valign="top"><img src="<%=strContextPath%>/images/login/campaign/A_13.jpg" width="350" height="23" alt=""></td>
              </tr>
              <tr>
                <td><img src="<%=strContextPath%>/images/login/campaign/A_14.jpg" width="350" height="127" alt=""></td>
                <td colspan="3"><img src="<%=strContextPath%>/images/login/campaign/A_15.jpg" width="350" height="127" alt=""></td>
              </tr>
          </table></td>
        </tr>
    </table></td>
  </tr>
</table></td></tr>
<tr><td height="100%" style="padding-left:8px;border-top:1px solid #747474">
<input name="strTenantId" type="hidden" value="default" />
<font color="#FF0000" class="titleSmall"><%=Function.getMultiLangItemContent("login.message",request)%>: <span  id="msgInfo" class="titleSmall"><%=Function.getMultiLangItemContent((String)request.getAttribute("STRRETURNINFO"), request)%></span></font>
</td></tr>
</form>
</table>
</body>
</html>