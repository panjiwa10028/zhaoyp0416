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
    <link rel="Shortcut Icon" href="<%=strContextPath%>/images/esoon.ico"/>
	<link rel="Bookmark" href="<%=strContextPath%>/images/esoon.ico"/>
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
	var loginWidth=718;
	var loginHeight=560; //IPCC-339 IE7 or IE8 登入時被遮擋  
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
	margin:5px;
}
</style>

<!-- comment out by Colin Kuo -->
<!-- %@ include file = "/softphone/softphoneApplet.jsp" % -->

</head>
<body onkeydown="enterSubmit()" onload="loadInfo();" oncontextmenu="return false;">
<table border="0" height="100%" align="center" cellpadding="0" cellspacing="0" style="border:1px solid #747474;background-color:#d8d8d8">
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

<table border="0" align="center" cellpadding="0" cellspacing="0">
	<tr>
		<td>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
  			<tr>
    			<td>
    			<table width="100%" border="0" cellpadding="0"  cellspacing="0">
        			<tr>
          				<td><table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="0">
              				<tr>
                				<td width="350" height="64"><img src="<%=strContextPath%>/images/login/contact/A_01.jpg" width="350" height="64" alt=""></td>
                				<td colspan="3"><img src="<%=strContextPath%>/images/login/contact/A_02.jpg" width="350" height="64" alt=""></td>
              				</tr>
              				<tr>
                				<td height="141"><img src="<%=strContextPath%>/images/login/contact/A_03.jpg" width="350" height="141" alt=""></td>
                				<td colspan="3"><img src="<%=strContextPath%>/images/login/contact/A_04_Enterprise.jpg" width="350" height="141" alt=""></td>
              				</tr>
              				<tr>
                				<td height="148" rowspan="5" valign="top"><img src="<%=strContextPath%>/images/login/contact/A_05.jpg" width="350" height="148" alt=""></td>
                				<td height="21" colspan="3"><img src="<%=strContextPath%>/images/login/contact/A_06.jpg" width="350" height="21" alt=""></td>
              				</tr>
              				<tr>
                				<td width="114" rowspan="2" background="<%=strContextPath%>/images/login/contact/<%=strMultiLangName%>/A_07_Enterprise.jpg" width="114" height="72">
                				</td>
                				<td height="34" colspan="2" background="<%=strContextPath%>/images/login/contact/A_08.jpg"><table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
                  					<tr>
                    					<td><input class="box04" name="strLoginId" size="18"/></td>
                  					</tr>
                				</table></td>
              				</tr>
              				<tr>
                				<td height="38" colspan="2" background="<%=strContextPath%>/images/login/contact/A_09.jpg"><table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
                  					<tr>
                    					<td><input class=box04 type="password" name="strPassword" size="18"/></td>
                  					</tr>
                				</table></td>
              				</tr>
              				<tr>
                				<td><img src="<%=strContextPath%>/images/login/contact/A_10.jpg" width="114" height="32" alt=""></td>
                				<td width="131" background="<%=strContextPath%>/images/login/contact/A_11.jpg"><table width="105%"  border="0" cellspacing="2" cellpadding="1">
                  					<tr>
			                            <!-- 
			                            <td>
			                            <a href="#" onClick="submitForm()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image15','','<%=strContextPath%>/images/login/contact/<%=strMultiLangName%>/an1_2.gif',1)"><img src="<%=strContextPath%>/images/login/contact/<%=strMultiLangName%>/an1.gif" name="Image15" width="54" height="24" border="0"></a>
			                            </td>
			                            -->
			                            
			                            <td id="displaySubmitTD" style="display:none">
                    						<a style="cursor:hand;" id="submitButton" onClick="submitForm()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image15','','<%=request.getContextPath()%>/images/login/contact/<%=strMultiLangName%>/an1_2.gif',1)"><img src="<%=request.getContextPath()%>/images/login/contact/<%=strMultiLangName%>/an1.gif" name="Image15" width="54" height="24" border="0"></a>
					                    </td>
                    					<td id="blackSubmitTD">
					                    	<img src="<%=request.getContextPath()%>/images/login/contact/<%=strMultiLangName%>/an1_2.gif" name="Image14" width="54" height="24" border="0">
                    					</td>
                    					
			                            <td><img src="<%=strContextPath%>/images/login/contact/<%=strMultiLangName%>/an2.gif" style="cursor:pointer" onClick="getSkillGroup()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image16','','<%=strContextPath%>/images/login/contact/<%=strMultiLangName%>/an2_2.gif',1)" name="Image16" width="54" height="24" border="0"></td>
			                             
                  					</tr>
                				</table></td>
                				<td width="105"><img src="<%=strContextPath%>/images/login/contact/A_12.jpg" width="105" height="32" alt=""></td>
              				</tr>
              				<tr>
                				<td height="23" colspan="3" valign="top"><img src="<%=strContextPath%>/images/login/contact/A_13.jpg" width="350" height="23" alt=""></td>
              				</tr>
              				<tr>
                				<td><img src="<%=strContextPath%>/images/login/contact/A_14.jpg" width="350" height="127" alt=""></td>
                				<td colspan="3"><img src="<%=strContextPath%>/images/login/contact/A_15.jpg" width="350" height="127" alt=""></td>
              				</tr>
          				</table></td>
        			</tr>
    			</table></td>
  			</tr>
		</table>
	</td></tr>
</table></td>
</tr>
<tr>
<td height="100%" style="padding-left:8px;border-top:1px solid #747474">
<input name="strTenantId" type="hidden" value="default" />
<font color="#ff0000" class="titleSmall"><%=Function.getMultiLangItemContent("login.message",request)%>: 
<span  id="msgInfo" class="titleSmall"><%=Function.getMultiLangItemContent((String)request.getAttribute("STRRETURNINFO"), request)%></span></font>
</td>
<td height="100%" style="padding-left:8px;border-top:1px solid #747474" align="right">
<span  id="msgInfo2" class="titleSmall"></span>
</td>
</tr>
</form>
</table>
</body>
</html>
<script type="text/javascript">InsertFlash("<%=request.getContextPath()%>/EZflash/pieF380.swf?filename=<%=request.getContextPath()%>/jsp/FlashXMLFile/1",0,0,"1");</script>