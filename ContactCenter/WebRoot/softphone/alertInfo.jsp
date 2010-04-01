<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.esoon.ezactor.contact.Function"%>
<%	String contextPath = request.getContextPath();%>

﻿<iframe id="alertFramePad" style="position:absolute; border-width:0px; top:0px; left:0px; width:0px; height:0px;z-index:100010; background-color:#ffffff;filter:alpha(Opacity=0);opacity:0"></iframe>
<div id="alertDivPad" style="position:absolute; display:none; top:0px; left:0px; width:0px; height:0px;z-index:100020; background-color:#ffffff;filter:alpha(Opacity=70);opacity:0.7"></div>
<div id="alertDiv" style="position:absolute;  display:none; width:350px; height:150px;z-index:100030; background-color:#ffffff;border:1px solid #7191c1;table-layout:fixed; ">
<table width="100%" height="22" border="0" cellpadding="4" cellspacing="0" background="<%=contextPath%>/images/alert_image/drop3.gif" style="border-bottom:1px solid #e0edf6">
  <tr>
    <td><img src="<%=contextPath%>/images/alert_image/alertDot.gif" width="13" height="13" border="0" align="absmiddle"><%=Function.getMultiLangItemContent("softphone.alert", request)%></td>
  </tr>
</table>
<table width="330" height="94" border="0" align="center" cellpadding="5" cellspacing="0">
  <tr>
    <td align="center"><div id="msgDiv"></div></td>
    </tr>
</table>
<table width="100%" height="32" border="0" cellpadding="5" cellspacing="0" bgcolor="ecf4fa">
  <tr>
    <td align="center"><input name="Submit" type="button" class="button" value="<%=Function.getMultiLangItemContent("softphone.close", request)%>" onClick="closeMessageBox()"></td>
    </tr>
</table>	
</div>

<form name="ivrForm">
<div id="ivrDiv" style="position:absolute;  display:none; width:240px; height:180px;z-index:100030; background-color:#ffffff;border:1px solid #7191c1;table-layout:fixed;">
<table width="100%" height="22" border="0" cellpadding="4" cellspacing="0" background="<%=contextPath%>/images/alert_image/drop3.gif" style="border-bottom:1px solid #e0edf6">
  <tr>
    <td> <%=Function.getMultiLangItemContent("softphone.ivr", request)%> </td>
  </tr>
</table>

<fieldset style="margin:5px;">
  <legend> <b> <%=Function.getMultiLangItemContent("softphone.ivr", request)%> </b> </legend>
	<div style="height:100px; overflow-x:auto; overflow-y:scroll;">
		<table border="0" cellpadding="0" cellspacing="0" id='ivrList'>
			<tr>
    			<td >
    			</td>
			</tr>
		</table>
	</div>
</fieldset>
	
<table width="100%" height="32" border="0" cellpadding="5" cellspacing="0" bgcolor="ecf4fa">
  <tr>
    <td align="center">
	<input name="Submit" type="button" class="button" value="<%=Function.getMultiLangItemContent("softphone.ok", request)%>" onClick="selectIvr()">
	<input name="Submit" type="button" class="button" value="<%=Function.getMultiLangItemContent("softphone.close", request)%>" onClick="closeIvr()">
	</td>
    </tr>
</table>
</div>	
</form>
<jsp:include page="/softphone/AUXInfo.jsp" flush="true"/>