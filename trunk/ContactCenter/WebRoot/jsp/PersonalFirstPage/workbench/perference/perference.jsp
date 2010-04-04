<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>

<%@ page import="com.esoon.EZActor.BusinessCenter.Function"%>
<jsp:directive.page import="java.util.Iterator"/>
<jsp:directive.page import="java.util.HashMap"/>
<jsp:directive.page import="java.util.Date"/>
<jsp:directive.page import="java.text.DateFormat"/>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>
<%@ taglib prefix="fmt" uri="/WEB-INF/fmt.tld" %>
<%@ taglib prefix="fn" uri="/WEB-INF/fn.tld" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ include file="/jsp/common/header/include_init.jsp" %>
<%@ include file="/jsp/common/header/include_script.jsp" %>	 
<%@ include file="/jsp/common/header/include_getRequiredParameter.jsp" %>


<html>
<head>
<title><%=Function.getMultiLangItemContent("Business.Title",request)%></title>
  <link href="<%=strContextPath%>/css/personstyle.css" rel="stylesheet" type="text/css">
  <SCRIPT src="<%=strContextPath%>/script/drag_drop_src/drag_drop.js"></SCRIPT>
<script src="<%=strContextPath%>/script/common.js"></script>
<LINK href="<%=strContextPath%>/script/drag_drop_src/drag_drop.css" type=text/css rel=stylesheet>
<script src="<%=strContextPath%>/script/contactCommon/setStatus.js"></script>
<link href="<%=strContextPath%>/css/chrome.css" rel="stylesheet" type="text/css">
<style type="text/css">
body {
	background-image: url(../../../../images/title_bg.gif); 
	background-position:left top;
	background-repeat:no-repeat;
	background-color:#f5f8f9;
}
.menu {
	height:25px; 
	cursor:pointer;
	font-size:12px;
	padding-left:8px;
	background-image: url(../../../../images/preference_menu_normal.gif);
}
.menuOver {
	height:25px; 
	cursor:pointer;
	font-size:12px;
	padding-left:8px;
	background-image: url(../../../../images/preference_menu_over.gif);
}
.menuDown {
	height:25px; 
	cursor:pointer;
	font-size:12px;
	font-weight:bold;
	padding-left:8px;
	background-image: url(../../../../images/preference_menu_down.gif);
}
</style>
<script language="javascript" type="text/javascript">
function menuOver(){
	if(event.srcElement.className != "menuDown"){event.srcElement.className = "menuOver";}
}
function menuOut(){
	if(event.srcElement.className != "menuDown"){event.srcElement.className = "menu";}
}
function menuClick(module){
var url;
var menuObj=document.getElementById("menuDiv").getElementsByTagName("TD");


for(i=0;i<menuObj.length;i++){
	menuObj[i].className = "menu";
}
	event.srcElement.className = "menuDown";
	if(menuFrm.document.getElementById("pic_setting")){
	document.getElementById("titleWord").innerText = event.srcElement.innerText;
	}
	if(module=="display")
	{
	
	if(menuFrm.document.getElementById("display_setting")){menuFrm.document.getElementById("display_setting").style.display = "";}
	if(menuFrm.document.getElementById("pic_setting")){menuFrm.document.getElementById("pic_setting").style.display = "none";}
	if(menuFrm.document.getElementById("shortcut_setting")){menuFrm.document.getElementById("shortcut_setting").style.display = "none";}
	if(menuFrm.document.getElementById("password_setting")){menuFrm.document.getElementById("password_setting").style.display = "none";}
	}
		else if(module=="pic")
	{
		if(menuFrm.document.getElementById("display_setting")){menuFrm.document.getElementById("display_setting").style.display = "none";}
	if(menuFrm.document.getElementById("pic_setting")){menuFrm.document.getElementById("pic_setting").style.display = "";}
	if(menuFrm.document.getElementById("shortcut_setting")){menuFrm.document.getElementById("shortcut_setting").style.display = "none";}
	if(menuFrm.document.getElementById("password_setting")){menuFrm.document.getElementById("password_setting").style.display = "none";}
	}
		else if(module=="shortCut")
	{
		if(menuFrm.document.getElementById("display_setting")){menuFrm.document.getElementById("display_setting").style.display = "none";}
	if(menuFrm.document.getElementById("pic_setting")){menuFrm.document.getElementById("pic_setting").style.display = "none";}
	if(menuFrm.document.getElementById("shortcut_setting")){menuFrm.document.getElementById("shortcut_setting").style.display = "";}
	if(menuFrm.document.getElementById("password_setting")){menuFrm.document.getElementById("password_setting").style.display = "none";}
	}
		else if(module=="password")
	{
		if(menuFrm.document.getElementById("display_setting")){menuFrm.document.getElementById("display_setting").style.display = "none";}
	if(menuFrm.document.getElementById("pic_setting")){menuFrm.document.getElementById("pic_setting").style.display = "none";}
	if(menuFrm.document.getElementById("shortcut_setting")){menuFrm.document.getElementById("shortcut_setting").style.display = "none";}
	if(menuFrm.document.getElementById("password_setting")){menuFrm.document.getElementById("password_setting").style.display = "";}
	}
	
}
function changeFlag(flag) {
		document.commonTransForm.flag.value=flag;
	
	
		
}

function loadInfo() {
		
		document.commonTransForm.target = "menuFrm";
	document.commonTransForm.forward.value = "/jsp/PersonalFirstPage/workbench/perference/configPage.jsp";

		document.commonTransForm.submit();
	
		
}

</script>
</head>

<body onload="loadInfo();" scroll="no">
  <form name="commonTransForm" action ="<%=strContextPath%>/personalInfoAction.do?method=showPerference" method="post">
<input name="strServiceName" type="hidden" value = ""/>
	<input name="search" type="hidden" value = "0"/>
	<input name="strTransName" type="hidden" value = ""/>
 <input name="lUserId" type="hidden" value="<c:out value="${param.lUserId}"/>" />
    <input name="strUserName" type="hidden" value="<c:out value="${param.strUserName}"/>" />
    <input name="lTenantId" type="hidden" value="<c:out value="${param.lTenantId}"/>" /> 
	<input name="forward" type="hidden" value = ""/>
	<input name="flag" type="hidden" value = ""/>
	</form>
<table width="100%" height="50"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td><strong style=" color:#cff300;font-size:12px; padding-left:20px"><%=Function.getMultiLangItemContent("personalInfo.setting",request)%></strong></td>
  </tr>
</table>
<div style="padding:0px 20px;">
<div id="contentArea" style="height:425px; overflow:auto; margin-bottom:8px; background-color:#FFFFFF;">
  <table width="100%" height="425"  border="0" cellpadding="0" cellspacing="0">
  <tr valign="top">
      <td style="width:160px; border-top:1px solid #cccccc;border-bottom:1px solid #cccccc;border-left:1px solid #cccccc;">
      
	  <div id="menuDiv">
	  <table width="100%" border="0" cellspacing="0" cellpadding="3">
         <tr>
          <td class="menuDown" onMouseOver="menuOver()" onMouseOut="menuOut()" onClick="menuClick('pic')"><%=Function.getMultiLangItemContent("personalInfo.setting.picture",request)%></td>
          </tr> 
        <tr>
          <td class="menu" onMouseOver="menuOver()" onMouseOut="menuOut()" onClick="menuClick('display')"><%=Function.getMultiLangItemContent("personalInfo.setting.display",request)%></td>
          </tr>
      
        <tr>
          <td class="menu" onMouseOver="menuOver()" onMouseOut="menuOut()" onClick="menuClick('shortCut')"><%=Function.getMultiLangItemContent("personalInfo.setting.shortcut",request)%></td>
          </tr>
        <tr>
          <td class="menu" onMouseOver="menuOver()" onMouseOut="menuOut()" onClick="menuClick('password')"><%=Function.getMultiLangItemContent("personalInfo.setting.password",request)%></td>
          </tr>
      </table>
	  </div>
	  </td>
	
      <td style="border-top:1px solid #cccccc;border-bottom:1px solid #cccccc;" width="6">
        <table width="6" height="100%" border="0" cellpadding="3" cellspacing="0" background="<%=strContextPath%>/images/preference_v.gif">
          <tr>
            <td></td>
          </tr>
        </table></td>
      <td style=" border-top:1px solid #cccccc;border-bottom:1px solid #cccccc;">
	  <table width="100%" height="30" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td background="<%=strContextPath%>/images/preference_title_bg.gif">
		  <div id="titleWord" style="font-size:14px; font-weight:bold; padding-left:10px"><%=Function.getMultiLangItemContent("personalInfo.setting.picture",request)%></div>
		  </td>
        </tr>
      </table>
	  <iframe id="menuFrm" name="menuFrm" scrolling="auto" src="" frameborder="0" marginheight="0" marginwidth="0" height="388" width="100%" vspace="0" hspace="0"></iframe>
	  </td>
      <td width="5"><table width="5" height="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="5" height="31"><img src="<%=strContextPath%>/images/preference_right1.gif" width="5" height="31"></td>
        </tr>
        <tr>
          <td width="5" background="<%=strContextPath%>/images/preference_right2.gif"><img src="<%=strContextPath%>/images/preference_right2.gif" width="5" height="4"></td>
        </tr>
        <tr>
          <td width="5" height="5"><img src="<%=strContextPath%>/images/preference_right3.gif" width="5" height="5"></td>
        </tr>
      </table>        </td>
    </tr>
  </table>
  </div>
</div>
  <%@ include file="/jsp/common/header/include_status.jsp" %>
<table width="100%" height="40"  border="0" align="center" cellspacing="0" background="<%=strContextPath%>/images/mac_bg1.gif" style="border-top:1px solid #cccccc">
  <tr>
    <td align="center">
	<input name="Submit" type="button" class="button" value=" <%=Function.getMultiLangItemContent("common.OK", request)%> " onClick="menuFrm.submitForm();changeFlag(1);">
    <input name="Submit2" type="button" class="button" value=" <%=Function.getMultiLangItemContent("common.CANCEL", request)%> " onClick="window.close();">
    <input name="Submit3" type="button" class="button" value=" <%=Function.getMultiLangItemContent("common.APPLY", request)%> " onClick="menuFrm.submitForm();changeFlag(2);"></td>
  </tr>
</table>

</body>
</html>