<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>

<%@ include file="/jsp/common/header/include_init.jsp" %>
<%@ include file="/jsp/common/header/include_link.jsp" %>
<%@ include file="/jsp/common/header/include_script.jsp" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib prefix="fmt" uri="/WEB-INF/fmt.tld" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script src="common.js"></script>
<link href="<%=strContextPath%>/css/chrome.css" rel="stylesheet" type="text/css">
<link href="<%=strContextPath%>/css/style.css"  rel="stylesheet"  type="text/css">
<style type="text/css">

body {
	background-color: #ffffff;
	margin-top: 0px;
	margin-left: 0px;
	margin-right: 0px;
	border: none;
	overflow:hidden;
}

</style>
<script>
function seachAgentState(){
	parent.mainFrame.seachAgentState(document.all.filterName.value,document.getElementById(document.all.filterName.value).value);
}

function changeFilter(){
    if(document.all.filterName.value!=""){
    var fid= document.all.filterName.value;
    var fdiv= document.getElementById("sf_"+fid);
    var fc=document.getElementById("fieldContainer");
    fc.innerHTML=fdiv.innerHTML;
    }
    else{
    var fc=document.getElementById("fieldContainer");
    fc.innerHTML='&nbsp;';
    }
}
</script>
</head>

<body scroll="no" onload="changeFilter();">
<table width="100%"  border="0" cellpadding="0" cellspacing="0">
    <tr>
    <td align="left">
      <select name="strFilterName" id="filterName" onchange="javascript:changeFilter()" class="box01">
		<option value="strAgentName"><%=Function.getMultiLangItemContent("LocaleManager.AgentSee.New.agentName",request)%></option>
		<option value="strDnId" ><%=Function.getMultiLangItemContent("Tel.Ext",request)%></option>
		<option value="nLoginState" ><%=Function.getMultiLangItemContent("LocaleManager.Agent.See.state",request)%></option>
      </select>
    </td>
    <td id="fieldContainer" align="left"></td>
    <td align="left">
    <!-- <input type="button" name="Submit" class="button" value="<%=Function.getMultiLangItemContent("qry.title",request)%>" onclick="seachAgentState();"> -->
    <img src="<%=strContextPath%>/images/search_normal.gif" alt="<%=Function.getMultiLangItemContent("qry.title",request)%>" border="0" align="absmiddle" style="cursor:pointer" onclick="seachAgentState()" onMouseDown="this.src='<%=strContextPath%>/images/search_down.gif'"  onMouseUp="this.src='<%=strContextPath%>/images/search_over.gif'" onMouseOver="this.src='<%=strContextPath%>/images/search_over.gif'"  onMouseOut="this.src='<%=strContextPath%>/images/search_normal.gif'">
    </td>
  </tr>
</table>
<div style="display:none"  id="sf_strAgentName">
<input name="strAgentName" type="text" class="box01" size="10" maxlength="16" value="">
</div>
<div style="display:none"  id="sf_nLoginState">
<select name="nLoginState" id="nLoginState">
	<option value="1" ><%=Function.getMultiLangItemContent("LocaleManager.service.new.pause",request)%></option>
	<option value="4" ><%=Function.getMultiLangItemContent("LocaleManager.service.new.ready",request)%></option>
	<option value="5" ><%=Function.getMultiLangItemContent("LocaleManager.service.new.talking",request)%></option>
	<option value="6" ><%=Function.getMultiLangItemContent("LocaleManager.service.new.dialing",request)%></option>
	<option value="7" ><%=Function.getMultiLangItemContent("LocaleManager.service.new.ringing",request)%></option>
	<option value="8" ><%=Function.getMultiLangItemContent("LocaleManager.service.new.conference",request)%></option>
	<option value="9" ><%=Function.getMultiLangItemContent("LocaleManager.service.new.holding",request)%></option>
	<option value="10" ><%=Function.getMultiLangItemContent("LocaleManager.service.new.acw",request)%></option>
</select>
</div>
<div style="display:none"  id="sf_strDnId">
<input name="strDnId" type="text" class="box01" size="10" maxlength="256" value="">
</div>
</body>
</html>

