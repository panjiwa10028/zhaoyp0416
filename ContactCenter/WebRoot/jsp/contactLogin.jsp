<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.Function"%>
<%@ page import="com.esoon.EZActor.BusinessCenter.BusinessCenterApp"%>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-tiles.tld" prefix="tiles" %>
<%
/**
 * @author Mikey
 */
response.setHeader("Pragma", "No-cache");
response.setDateHeader("Expires", 0);
response.setHeader("Cache-Control", "no-cache");
String strContextPath = request.getContextPath();
String strMultiLangName = Function.GetMultiLangName(request);
String commonAspPath = "";//"asp/";
%>
<html>
  <head>
    <title><%=Function.getMultiLangItemContent("Contact.Title",request)%></title>
    <link rel="Shortcut Icon" href="<%=strContextPath%>/images/login/new_contact/esoon.ico"/>
	<link rel="Bookmark" href="<%=strContextPath%>/images/login/new_contact/esoon.ico"/>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
	<!-- add by Colin Kuo for IPCC-272 -->
	<script src="<%=strContextPath%>/script/PluginDetectJava.js"></script>
	<script src="<%=strContextPath%>/script/preCheckJre.js"></script>
	<script type="text/javascript">
	if(!skipCheckJRE){
		
		if(isNeedInstall(version)){
			<%
				String targetNameSuffix = "";
				java.util.Locale locale = request.getLocale();
				if("zh".equals(locale.getLanguage())){
					if("TW".equals(locale.getCountry())){
						targetNameSuffix = "_tw";
					}
					else if("CN".equals(locale.getCountry())){
						targetNameSuffix = "_cn";
					}
				}
			%>
			var fileSuffix = '<%=targetNameSuffix%>';
			window.location.href = '<%=strContextPath%>/applet/check/jvc' + fileSuffix + '.jsp';
		}
	}
	</script>
	<!-- add by Colin Kuo -->	
	
	<link href="<%=strContextPath%>/css/chrome.css"  rel="stylesheet"  type="text/css">
	<script src="<%=strContextPath%>/script/cookie.js" language="JavaScript" type="text/javascript"></script>
	<script src="<%=strContextPath%>/script/contactCommon/flash.js"></script>
	<script src="<%=strContextPath%>/script/contactCommon/jsonrpc.js" language="JavaScript" type="text/javascript"></script>
	<script src="<%=strContextPath%>/script/commonHeader.js"></script>
<script language="javascript">
	var settingWin=null;
	var loginWidth=717;
	var loginHeight=556; //IPCC-339 IE7 or IE8 登入時被遮擋  
	x=(screen.width-loginWidth)/2;
	y=(screen.height-loginHeight)/2;

	window.resizeTo(loginWidth,loginHeight+20);
	window.moveTo(x,y);
	
	var onSubmited = false;
		
	if(window.name!="contactWeb")
	{
		window.open("about:blank","contactWeb","toolbar=0,location=0,status=0,menubar=0,scrollbars=auto,resizable=no,width="+loginWidth+",height="+loginHeight+",left="+x+",top="+y);
		setTimeout('openLogin()',100);
	}

	if (top.workArea) {
		top.location.href = "<%=strContextPath%>/jsp/contactLogin.jsp";
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
		window.open("<%=strContextPath%>/jsp/contactLogin.jsp","contactWeb","toolbar=0,location=0,status=0,menubar=0,scrollbars=auto,resizable=no,width="+loginWidth+",height="+loginHeight+",left="+x+",top="+y);
		window.opener = null;
		window.open('','_self'); 
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

//function submitForm()
//{
//	if(!validateForm())
//	{
//		return;
//	}
	
//	loginForm.submit();
//}

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
		//loginForm.strLogTitle.value = loginForm.strLoginId.value + "/" + loginForm.strPassword.value;
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

function showSettingPage() {
    var applet=document.applets(0);
	var place=applet.getPlace();
	var dns=applet.getDns();
	var useCTI=applet.getCtiState();
		
	var areacode=applet.getAreaCode();
	settingWin=openNormalWindow("<%=strContextPath%>/loginSetting/login.jsp?place="+place+"&&areacode="+areacode+"&&useCTI="+useCTI+"&&dns="+dns,600,380,"setting");
}

function saveSetting(areacode,place,dns,ctiState){
	var applet=document.applets(0);
	applet.save(place,dns,areacode,ctiState);	
	if(settingWin!=null&&settingWin.closed==false){
		settingWin.close();
	}
}

function initLoginSetting(form){
	var applet=document.applets(0);
	if(applet==null){
		return false;
	}
	
	var place=applet.getPlace();
	var dns=applet.getDns();
	var useCTI=applet.getCtiState();
		
	var areacode=applet.getAreaCode();
	for (var k=0;k<form.elements.length;k++) {
	  	if (form.elements[k].name=='bean.areacode') {
			form.elements[k].value=areacode;
	   	}else if (form.elements[k].name=='bean.place') {
			form.elements[k].value=place;
	   	}else if (form.elements[k].name=='bean.useCTI') {
			form.elements[k].value=(useCTI=='1'?"true":"false");
	   	}
    }
    
    // remove existing dns    
    var dnElements=document.getElementsByName("bean.loginDns");
    if(dnElements){
    	for(var i=dnElements.length-1;i>=0;i--){
			form.removeChild(dnElements[i]);
    	}
    }
    
    // add new dns
    if(dns){
    	var dnArray=dns.split(",");
    	//alert(dnArray.length);
    	for(var i=0;i<dnArray.length;i++){    	
    		var newinput=document.createElement("<input type='hidden' name='bean.loginDns' value='"+dnArray[i]+"'/>");
    		form.appendChild(newinput);
    	}    	
    }

    return true;
}

function showAppletInitMessage(){
	var message="<%=Function.getMultiLangItemContent("applet.loading",request)%>";
	showMessage(message);
}

function appletLoaded(){
	showMessage("");
	var loginId=document.getElementById("beanLoginId");
	loginId.disabled=false;
	var password=document.getElementById("beanLoginPassword");
	password.disabled=false;
	var loginButton=document.getElementById("loginButton");
	loginButton.disabled=false;	
	var settingButton=document.getElementById("settingButton");
	settingButton.disabled=false;			
}

function getPlaceAndDNSetupFromCookie()
{
	loginForm.nCTIUseState.value = getCookie("nCTIUseState");
	if(loginForm.nCTIUseState.value=="")
	{
		loginForm.nCTIUseState.value = "<c:out value="${param.nCTIUseState}"/>";
	}

	loginForm.lPlaceCTIId.value = getCookie("lPlaceCTIId");
	if(loginForm.lPlaceCTIId.value=="")
	{
		loginForm.lPlaceCTIId.value = "<c:out value="${param.lPlaceCTIId}"/>";
	}
	
	loginForm.strPlaceName.value = getCookie("strPlaceName");
	if(loginForm.strPlaceName.value=="")
	{
		loginForm.strPlaceName.value = "<c:out value="${param.strPlaceName}"/>";
	}
	
	loginForm.strAreaCode.value = getCookie("strAreaCode");
	if(loginForm.strAreaCode.value=="")
	{
		loginForm.strAreaCode.value = "<c:out value="${param.strAreaCode}"/>";
	}
	
	//loginForm.strQueueDN.value = getCookie("strQueueDN");
	//if(loginForm.strQueueDN.value=="")
	//{
	//	loginForm.strQueueDN.value = "<c:out value="${param.strQueueDN}"/>";
	//}
	
	loginForm.lVoiceDNCTIId.value = getCookie("lVoiceDNCTIId");
	if(loginForm.lVoiceDNCTIId.value=="")
	{
		loginForm.lVoiceDNCTIId.value = "<c:out value="${param.lVoiceDNCTIId}"/>";
	}

	loginForm.lEmailDNCTIId.value = getCookie("lEmailDNCTIId");
	if(loginForm.lEmailDNCTIId.value=="")
	{
		loginForm.lEmailDNCTIId.value = "<c:out value="${param.lEmailDNCTIId}"/>";
	}

	loginForm.lChatDNCTIId.value = getCookie("lChatDNCTIId");
	if(loginForm.lChatDNCTIId.value=="")
	{
		loginForm.lChatDNCTIId.value = "<c:out value="${param.lChatDNCTIId}"/>";
	}
	loginForm.strDNId.value = getCookie("strDNId");
	if(loginForm.strDNId.value=="")
	{
		loginForm.strDNId.value = "<c:out value="${param.strDNId}"/>";
	}
	
	loginForm.lLoginTemplateId.value= getCookie("lLoginTemplateId");
	if(loginForm.lLoginTemplateId.value=="")
	{
		loginForm.lLoginTemplateId.value = "<c:out value="${param.lLoginTemplateId}"/>";
	}
	loginForm.strLoginTemplateName.value= getCookie("strLoginTemplateName");
	if(loginForm.strLoginTemplateName.value=="")
	{
		loginForm.strLoginTemplateName.value = "<c:out value="${param.strLoginTemplateName}"/>";
	}

	loginForm.strSkillGroupId.value= getCookie("strSkillGroupId");
	if(loginForm.strSkillGroupId.value=="")
	{
		loginForm.strSkillGroupId.value = "${param.strSkillGroupId}";		
	}
	
	loginForm.strExt.value= getCookie("strExt");
	if(loginForm.strExt.value=="")
	{
		loginForm.strExt.value = "${param.strExt}";		
	}
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
var jsonrpc;
function loadInfo()
{
	try{
		jsonrpc = new JSONRpcClient("<%=strContextPath%>/JSON-RPC");
	}catch(e){
		alert("create jsonrpc errpr:"+e.description);
	}
	
	loginForm.strLoginId.focus();
	
	// loginForm.strTenantId.value = getCookie("strTenantId");
	recoverySubmit('<%=Function.getMultiLangItemContent((String)request.getAttribute("STRRETURNINFO"), request)%>');
  	
	getPlaceAndDNSetupFromCookie();
	
	showSkillGroupName();	//Chiou
}


//Chiou++
function showSkillGroupName() {
	
	var ltemplateid=1;
	var nctiustate=0;
	if(getCookie("lLoginTemplateId")!="")
	{
		ltemplateid=getCookie("lLoginTemplateId");
	}
	if(getCookie("nCTIUseState")!="")
	{
		nctiustate=getCookie("nCTIUseState");		
	}
	
	if(nctiustate==1) {
			
		var _strSkillGroupName = getCookie("strLoginTemplateName");
		var _strPlaceName = getCookie("strPlaceName");

		var msg = "";
		if(_strSkillGroupName!=undefined && _strSkillGroupName!="" && _strSkillGroupName!="undefined")
			msg += ' <font color="black"><%=Function.getMultiLangItemContent("personalInfo.agent.Group",request)%>: ' + _strSkillGroupName;
		
		if(_strPlaceName!=undefined && _strPlaceName!="" && _strPlaceName!="undefined")
			msg += '/<%=Function.getMultiLangItemContent("personalInfo.agent.Place",request)%>: ' + _strPlaceName + "</font>";
			 
		msgInfo2.innerHTML = msg + "&nbsp;";
		
	}
	else
	{
		msgInfo2.innerHTML = "&nbsp;";
	}
}
//Chiou--

function openDialog(theURL,winName,features)
{
	var array = new Array();
	array[0] = theURL;
	array[1] = winName;
	array[2] = jsonrpc;
	window.showModalDialog("<%=strContextPath%>/jsp/placeIframe.jsp", array, features);
}

function globalSetCookie(cookieName, cookieValue, expires){
	setCookie(cookieName,cookieValue,expires);
}

// 显示设置 Place 和 DN 的页面。将来可能还会从cookie中读取原来的信息
function setupPlaceAndDN()
{
	var url = "<%=strContextPath%>/jsp/setupPlaceAndDN.jsp?strTenantId=" + loginForm.strTenantId.value + "&lPlaceCTIId=" + loginForm.lPlaceCTIId.value + "&strPlaceName=" + loginForm.strPlaceName.value + "&nCTIUseState=" + loginForm.nCTIUseState.value + "&lVoiceDNCTIId=" + loginForm.lVoiceDNCTIId.value + "&lEmailDNCTIId=" + loginForm.lEmailDNCTIId.value + "&lChatDNCTIId=" + loginForm.lChatDNCTIId.value + "&lLoginTemplateId=" + loginForm.lLoginTemplateId.value;
	openDialog(url,window,'dialogWidth=600px;dialogHeight=380px;status:no;resizable:no;help:no');
}
function DosetupPlaceAndDN()
{
	var url = "<%=strContextPath%>/setupPlaceAndDn.do?method=listPlace&strTenantId=" + loginForm.strTenantId.value + "&lPlaceCTIId=" + loginForm.lPlaceCTIId.value + "&strPlaceName=" + loginForm.strPlaceName.value + "&nCTIUseState=" + loginForm.nCTIUseState.value + "&lVoiceDNCTIId=" + loginForm.lVoiceDNCTIId.value + "&lEmailDNCTIId=" + loginForm.lEmailDNCTIId.value + "&lChatDNCTIId=" + loginForm.lChatDNCTIId.value + "&lLoginTemplateId=" + loginForm.lLoginTemplateId.value;
	openDialog(url,window,'dialogWidth=660px;dialogHeight=400px;status:no;resizable:no;help:no;scroll=no');
}
function setAreaCode(strAreaCode)
{
	loginForm.strAreaCode.value = strAreaCode;
}

//function setQueueDN(strQueueDN)
//{
//	loginForm.strQueueDN.value = strQueueDN;
//}
function setLoginTemplate(lLoginTemplateId)
{
	loginForm.lLoginTemplateId.value = lLoginTemplateId;
}
function setLoginTemplateName(strLoginTemplateName)
{
	loginForm.strLoginTemplateName.value = strLoginTemplateName;
}
function setCTIUseState(nCTIUseState)
{
	loginForm.nCTIUseState.value = nCTIUseState;
}

function setPlaceCTIId(lPlaceCTIId)
{
	loginForm.lPlaceCTIId.value = lPlaceCTIId;
}

function setVoiceDNCTIId(lVoiceDNCTIId)
{						
	loginForm.lVoiceDNCTIId.value = lVoiceDNCTIId;
}

function setEmailDNCTIId(lEmailDNCTIId)
{
	loginForm.lEmailDNCTIId.value = lEmailDNCTIId;
}
function setStrDNId(strDNId)
{
	loginForm.strDNId.value = strDNId;
}
function setChatDNCTIId(lChatDNCTIId)
{
	loginForm.lChatDNCTIId.value = lChatDNCTIId;
}

function setPlaceName(strPlaceName)
{
	loginForm.strPlaceName.value = strPlaceName;
	if(strPlaceName != '') {
		var dtDateTemp = new Date();
		dtDateTemp.setDate(dtDateTemp.getDate()+30);		
		globalSetCookie("strPlaceName",strPlaceName, dtDateTemp);
	}
}

function setDevice(deviceId)
{
	loginForm.lDeviceId.value = deviceId;
	if(deviceId != '') {
		var dtDateTemp = new Date();
		dtDateTemp.setDate(dtDateTemp.getDate()+30);		
		globalSetCookie("lDeviceId",deviceId, dtDateTemp);
	}
}
function setSkillGroupId(strSkillGroupId)
{
	loginForm.strSkillGroupId.value = strSkillGroupId;
	if(strSkillGroupId != '') {
		var dtDateTemp = new Date();
		dtDateTemp.setDate(dtDateTemp.getDate()+30);		
		globalSetCookie("strSkillGroupId",strSkillGroupId, dtDateTemp);
	}
	
}

function setExt(strExt) {

loginForm.strExt.value = strExt;
	if(strExt != '') {
		var dtDateTemp = new Date();
		dtDateTemp.setDate(dtDateTemp.getDate()+30);		
		globalSetCookie("strExt",strExt, dtDateTemp);
	}
}


function getSkillGroup() {
	var ltemplateid=1;
	var nctiustate=0;
	if(getCookie("lLoginTemplateId")!="")
	{
		ltemplateid=getCookie("lLoginTemplateId");
	}
	if(getCookie("nCTIUseState")!="")
	{
		nctiustate=getCookie("nCTIUseState");
	}
	var url = "<%=strContextPath%>/CCMSkillGroupAction.do?method=getAllSkillGroupList&strLoginId=" 
	+ loginForm.strLoginId.value + "&strSkillGroupCookieId=" + loginForm.strSkillGroupId.value 
	+ "&strExtCookieId=" + loginForm.strExt.value+"&nCTIUseState="+nctiustate
	+"&lLoginTemplateId="+ltemplateid+"&strPlaceName="+getCookie("strPlaceName")+"&strLogincookId="+getCookie("strLoginId")
	+"&ldeviceid="+getCookie("lDeviceId") + "&lPlaceCTIId="+getCookie("lPlaceCTIId");
	//window.open(url);
	openDialog(url,window,'dialogWidth=620px;dialogHeight=360px;status:no;resizable:no;help:no;scroll=no');
}

</script>
<style type="text/css">
body {
	background-color: #d4d0c4;
	margin:1px;
}
.messageDIV {
border:0px solid red;
position:absolute; right:auto; top:auto; left:2px; bottom:20px;
}
</style>

<!-- comment out by Colin Kuo -->
<!-- %@ include file = "/softphone/softphoneApplet.jsp" % -->

</head>
<form id="loginForm" name="loginForm" action="<%=strContextPath%>/logonAction.do" method="post">
<tr><td valign="top" colspan="2">

<input name="strProductId" type="hidden" value="Contact" />
<input name="strProductName" type="hidden" value="EZiPCC7.7.7" />
<input name="forward" type="hidden" value="/jsp/contactLogin.jsp" />

<input name="strAreaCode" type="hidden" value="" />
<input name="strPlaceName" type="hidden" value="" />
<input name="lPlaceCTIId" type="hidden" value="" />
<input name="nCTIUseState" type="hidden" value="" />
<input name="lVoiceDNCTIId" type="hidden" value="" />
<input name="lEmailDNCTIId" type="hidden" value="" />
<input name="lChatDNCTIId" type="hidden" value="" />
<input name="strLogTitle" type="hidden"/>
<input name="strDNId" type="hidden" value="" />

<input name="lLoginTemplateId" type="hidden" value="" />
<input name="strLoginTemplateName" type="hidden" value="" />
<input name="strSkillGroupId" type="hidden" value="" />
<input name="strExt" type="hidden" value="" />
<input name="lDeviceId" type="hidden" value="" />

<input name="strServiceIP" type="hidden" value="<c:out value="${pageContext.request.remoteAddr}"/>" />
<body bgcolor="#FFFFFF" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onkeydown="enterSubmit()" onload="loadInfo();" oncontextmenu="return false;">
<!-- Save for Web Slices (未标题-2) -->
<table id="__01" width="710" height="495" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/login_01.gif" width="141" height="61" alt=""></td>
		<td colspan="10">
			<img src="<%=strContextPath%>/images/login/new_contact/login_02.gif" width="494" height="61" alt=""></td>
		<td colspan="2">
			<img src="<%=strContextPath%>/images/login/new_contact/login_03.gif" width="74" height="61" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="1" height="61" alt=""></td>
	</tr>
	<tr>
		<td rowspan="15">
			<img src="<%=strContextPath%>/images/login/new_contact/login_04.gif" width="141" height="377" alt=""></td>
		<td colspan="2" rowspan="15">
			<img src="<%=strContextPath%>/images/login/new_contact/login_05.gif" width="192" height="377" alt=""></td>
		<td colspan="10">
			<img src="<%=strContextPath%>/images/login/new_contact/login_06.gif" width="376" height="53" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="1" height="53" alt=""></td>
	</tr>
	<tr>
		<td colspan="10">
			<img src="<%=strContextPath%>/images/login/new_contact/login_07.gif" width="376" height="27" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="1" height="27" alt=""></td>
	</tr>
	<tr>
		<td colspan="10">
			<img src="<%=strContextPath%>/images/login/new_contact/login_08.gif" width="376" height="72" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="1" height="72" alt=""></td>
	</tr>
	<tr>
		<td rowspan="12">
			<img src="<%=strContextPath%>/images/login/new_contact/login_09.gif" width="89" height="225" alt=""></td>
		<td colspan="9">
			<img src="<%=strContextPath%>/images/login/new_contact/login_10.gif" width="287" height="12" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="1" height="12" alt=""></td>
	</tr>
	<tr>
		<td rowspan="10">
			<img src="<%=strContextPath%>/images/login/new_contact/login_11.gif" width="40" height="126" alt=""></td>
		<td colspan="7">
			<img src="<%=strContextPath%>/images/login/new_contact/login_12.gif" width="195" height="20" alt=""></td>
		<td rowspan="11">
			<img src="<%=strContextPath%>/images/login/new_contact/login_13.gif" width="52" height="213" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="1" height="20" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="<%=strContextPath%>/images/login/new_contact/login_14.gif" width="40" height="19" alt=""></td>
		<td colspan="3">
			<input class="new_box04" name="strLoginId" size="18"/></td>
		<td colspan="2">
			<img src="<%=strContextPath%>/images/login/new_contact/login_16.gif" width="32" height="19" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="1" height="19" alt=""></td>
	</tr>
	<tr>
		<td colspan="7">
			<img src="<%=strContextPath%>/images/login/new_contact/login_17.gif" width="195" height="12" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="1" height="12" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="<%=strContextPath%>/images/login/new_contact/login_17-19.gif" width="40" height="1" alt=""></td>
		<td colspan="3" rowspan="3">
			<input class="new_box04" type="password" name="strPassword" size="18"/></td>
		<td colspan="2">
			<img src="<%=strContextPath%>/images/login/new_contact/login_17-21.gif" width="32" height="1" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="1" height="1" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="<%=strContextPath%>/images/login/new_contact/login_21.gif" width="40" height="1" alt=""></td>
		<td colspan="2">
			<img src="<%=strContextPath%>/images/login/new_contact/login_22.gif" width="32" height="1" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="1" height="1" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" rowspan="2">
			<img src="<%=strContextPath%>/images/login/new_contact/login_23.gif" width="40" height="18" alt=""></td>
		<td colspan="2" rowspan="2">
			<img src="<%=strContextPath%>/images/login/new_contact/login_24.gif" width="32" height="18" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="1" height="17" alt=""></td>
	</tr>
	<tr>
		<td colspan="3">
			<img src="<%=strContextPath%>/images/login/new_contact/login_25.gif" width="123" height="1" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="1" height="1" alt=""></td>
	</tr>
	<tr>
		<td colspan="7">
			<img src="<%=strContextPath%>/images/login/new_contact/login_26.gif" width="195" height="16" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="1" height="16" alt=""></td>
	</tr>
	<tr>
		<td colspan="2">
			<img src="<%=strContextPath%>/images/login/new_contact/login_27.gif" width="40" height="26" alt=""></td>
		<td id="displaySubmitTD" style="display:none">
			<img  src="<%=strContextPath%>/images/login/new_contact/login_28.gif" width="57" height="26" border="0" alt="" style="cursor:hand;" onClick="submitForm()"></td>
		<td id="blackSubmitTD">			
		<img src="<%=strContextPath%>/images/login/new_contact/login_28.gif" width="57" height="26" border="0" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/login_29.gif" width="10" height="26" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/login_30.gif" width="56" height="26" border="0" alt="" style="cursor:pointer" onClick="getSkillGroup()"></td>
		<td colspan="2">
			<img src="<%=strContextPath%>/images/login/new_contact/login_31.gif" width="32" height="26" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="1" height="26" alt=""></td>
	</tr>
	<tr>
		<td colspan="7">
			<img src="<%=strContextPath%>/images/login/new_contact/login_32.gif" width="195" height="13" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="1" height="13" alt=""></td>
	</tr>
	<tr>
		<td colspan="8">
			<img src="<%=strContextPath%>/images/login/new_contact/login_33.gif" width="235" height="87" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="1" height="87" alt=""></td>
	</tr>
	<tr>
		<td colspan="2" rowspan="2">
			<img src="<%=strContextPath%>/images/login/new_contact/login_34.gif" width="266" height="56" alt=""></td>
		<td colspan="4">
			<img src="<%=strContextPath%>/images/login/new_contact/login_35.gif" width="216" height="29" alt=""></td>
		<td colspan="2" rowspan="2">
			<img src="<%=strContextPath%>/images/login/new_contact/login_36.gif" width="77" height="56" alt=""></td>
		<td colspan="5" rowspan="2">
			<img src="<%=strContextPath%>/images/login/new_contact/login_37.gif" width="150" height="56" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="1" height="29" alt=""></td>
	</tr>
	<tr>
		<td colspan="4">
			<img src="<%=strContextPath%>/images/login/new_contact/login_38.gif" width="216" height="27" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="1" height="27" alt=""></td>
	</tr>
	<tr>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="141" height="1" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="125" height="1" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="67" height="1" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="89" height="1" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="40" height="1" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="20" height="1" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="20" height="1" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="57" height="1" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="10" height="1" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="56" height="1" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="10" height="1" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="22" height="1" alt=""></td>
		<td>
			<img src="<%=strContextPath%>/images/login/new_contact/separator.gif" width="52" height="1" alt=""></td>
		<td></td>
	</tr>
</table>
<div id="messageDIV" class="messageDIV">
<table id="messageTab">
<tr>
<td height="100%" style="padding-left:8px;border-top:0px solid #747474">
<input name="strTenantId" type="hidden" value="default" />
<font color="#ff0000" class="titleSmall"><%=Function.getMultiLangItemContent("login.message",request)%>: 
<span  id="msgInfo" class="titleSmall"><%=Function.getMultiLangItemContent((String)request.getAttribute("STRRETURNINFO"), request)%></span></font>
</td>
<td height="100%" style="padding-left:8px;border-top:0px solid #747474" align="right">
<span  id="msgInfo2" class="titleSmall"></span>
</td>
</tr>
</table>
</div>
<!-- End Save for Web Slices -->
</body>
</form>
</html>
<script type="text/javascript">InsertFlash("<%=request.getContextPath()%>/EZflash/pieF380.swf?filename=<%=request.getContextPath()%>/jsp/FlashXMLFile/1",0,0,"1");</script>