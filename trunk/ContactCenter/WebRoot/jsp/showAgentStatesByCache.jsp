<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.BusinessCenterApp"%>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>

<%@ include file="/jsp/common/header/include_init.jsp" %>
<%@ include file="/jsp/common/header/include_link.jsp" %>
<%@ include file="/jsp/common/header/include_script.jsp" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib prefix="fmt" uri="/WEB-INF/fmt.tld" %>
<%
	BusinessCenterApp app = BusinessCenterApp.getInstance();
	String insideNumberFront = app.GetParameter("agent.insideNumberFront","");
%>
<html>
  <head>
    <title><%=Function.getMultiLangItemContent("Business.Title",request)%></title>
    
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="expires" content="0">
    <meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
    <meta http-equiv="description" content="This is my page">
 <style type="text/css">
<!--
body,td,th {
	font-size: 12px;
	color: #333333;
	line-height:120%;
	font-family:Arial, Helvetica, sans-serif;
}
body {
	margin: 0px;
	background-color: #afbdce;
	border: none;
	overflow-x:none;
	overflow-y:auto;
	SCROLLBAR-FACE-COLOR: #f0f0f0;
	SCROLLBAR-HIGHLIGHT-COLOR: #f8f8f8;
	SCROLLBAR-SHADOW-COLOR: #bfbfbf;
	SCROLLBAR-3DLIGHT-COLOR: #bfbfbf;
	SCROLLBAR-ARROW-COLOR: #9ab9c2;
	SCROLLBAR-TRACK-COLOR: #f8f8f8;
	SCROLLBAR-DARKSHADOW-COLOR: #f8f8f8;
}
a {
	color: #636C87;
	text-decoration: none;
}
a:hover {
	color: #FF3300;
}
-->
</style>
<script type="text/javascript" src="<%=strContextPath%>/script/jsonrpc.js"></script>
<script type="text/javascript" src="<%=strContextPath%>/script/format.js"></script>
 <script>
 
var auxId = new Array();
var auxName = new Array();
var readySign = "4";
var notReadySign = "5";
var i = 0;

 function showAgentId(str,phoneBusy){
 	if(phoneBusy == 0){
 		top.document.all.numberBox.value='<%=insideNumberFront%>'+str;
 	}
 }
 
 function changeFilter(){
    if(document.all.filterName.value!=""){
    var fid= document.all.filterName.value;
    var fdiv= document.getElementById("sf_"+fid);
    var fc=document.getElementById("fieldContainer");
    fc.innerHTML=fdiv.innerHTML;
    }else{
    var fc=document.getElementById("fieldContainer");
    fc.innerHTML='&nbsp;';
    }
}

function seachAgentState(){
	
	try{
		
		removerow();
		var agents = top.win.top.jsonrpc.asm.searchAgents(document.all.filterName.value,document.getElementById(document.all.filterName.value).value).map;
		for(i = 0; i < agents[0].list.length; i++)    {
	    	if(agents[0].list[i] != null && agents[0].list[i].strAgentName != undefined && (agents[0].list[i].NState == readySign || agents[0].list[i].NState == notReadySign))   	{
	    		if(top.win.top.getUserId()!=undefined&&top.win.top.getUserId()!=agents[0].list[i].LAgentId){
	    			addrow(agents[0].list[i].strAgentName,agents[0].list[i].strDnId,agents[0].list[i].NVoiceState,agents[0].list[i].NEmailState,agents[0].list[i].NChatState,i);
	    		}
	    	}
	    }
		
		
	 }catch(e){
		alert(e.description);
	}
}

var nTotalCount = 0;
function init(){
	removerow();
	try{
		nTotalCount = top.win.top.jsonrpc.asm.getCount();
		var agents = top.win.top.jsonrpc.asm.getAgents().map;
		
		for(i = 0; i < agents[0].list.length; i++)    {
	    	if(agents[0].list[i] != null && agents[0].list[i].strAgentName != undefined && (agents[0].list[i].NState == readySign || agents[0].list[i].NState == notReadySign))   	{
	    		if(top.win.top.getUserId()!=undefined&&top.win.top.getUserId()!=agents[0].list[i].LAgentId){
	    			addrow(agents[0].list[i].strAgentName,agents[0].list[i].strDnId,agents[0].list[i].NVoiceState,agents[0].list[i].NEmailState,agents[0].list[i].NChatState,i);
	    		}
	    	}
	    }
    }catch(e){
     	alert(e.description);
    }
}

function qwer(para){
	try{
		for(i=1;i<document.getElementById("zxList").getElementsByTagName("tr").length;i++){
			document.getElementById("zxList").getElementsByTagName("tr")[i].style.backgroundColor = "#ffffff";
		}
	}catch(e){
		alert(e);
	}
}

var allOne = "";
function addOneObject(str){
	allOne += "|"+str+"|";
}

function checkIsHave(str){
	if(allOne.indexOf("|"+str+"|")!=-1){
		return false;
	}else{
		return true;
	}
}

var voiceStatePause = '<%=Function.getMultiLangItemContent("LocaleManager.service.new.pause",request)%>';
var voiceStateReady = '<%=Function.getMultiLangItemContent("LocaleManager.service.new.ready",request)%>';
var voiceStateTalking = '<%=Function.getMultiLangItemContent("LocaleManager.service.new.talking",request)%>';
var voiceStateDialing = '<%=Function.getMultiLangItemContent("LocaleManager.service.new.dialing",request)%>';
var voiceStateRinging = '<%=Function.getMultiLangItemContent("LocaleManager.service.new.ringing",request)%>';
var voiceStateConference = '<%=Function.getMultiLangItemContent("LocaleManager.service.new.conference",request)%>';
var voiceStateHolding = '<%=Function.getMultiLangItemContent("LocaleManager.service.new.holding",request)%>';
var voiceStateAcw = '<%=Function.getMultiLangItemContent("LocaleManager.service.new.acw",request)%>';
var emailStatePause = '<%=Function.getMultiLangItemContent("LocaleManager.service.new.pause",request)%>';
var emailStateReady = '<%=Function.getMultiLangItemContent("LocaleManager.service.new.ready",request)%>';
var emailStateBusy = '<%=Function.getMultiLangItemContent("LocaleManager.service.new.busy",request)%>';
var chatStatePause = '<%=Function.getMultiLangItemContent("LocaleManager.service.new.pause",request)%>';
var chatStateReady = '<%=Function.getMultiLangItemContent("LocaleManager.service.new.ready",request)%>';
var chatStateBusy = '<%=Function.getMultiLangItemContent("LocaleManager.service.new.busy",request)%>';

var lineObj = new Array();
var j = 0;
function addrow(value1,value2,value3,value4,value5,k){
	var newline= standlist.firstChild.cloneNode(true);
	newline.style.display="block";
	var isAllLogin = 0;
	var isAllReady = 0;
	var isAllNotLogin = 0;
	var phoneNum = value2;
	var phoneBusy = 0;
	if(value3!='0'){
		switch (parseInt(value3)) {
			case 1:value3="<%=Function.getMultiLangItemContent("LocaleManager.common.Voice",request)%>")+':'+voiceStatePause;phoneBusy = 1;isAllLogin++;isAllReady++;break;
			case 4:value3="<%=Function.getMultiLangItemContent("LocaleManager.common.Voice",request)%>")+':'+voiceStateReady;phoneBusy = 0;isAllLogin++;break;
			case 5:value3="<%=Function.getMultiLangItemContent("LocaleManager.common.Voice",request)%>")+':'+voiceStateTalking;phoneBusy = 1;isAllLogin++;isAllReady++;break;
			case 6:value3="<%=Function.getMultiLangItemContent("LocaleManager.common.Voice",request)%>")+':'+voiceStateDialing;phoneBusy = 1;isAllLogin++;isAllReady++;break;
			case 7:value3="<%=Function.getMultiLangItemContent("LocaleManager.common.Voice",request)%>")+':'+voiceStateRinging;phoneBusy = 1;isAllLogin++;isAllReady++;break;
			case 8:value3="<%=Function.getMultiLangItemContent("LocaleManager.common.Voice",request)%>")+':'+voiceStateConference;phoneBusy = 1;isAllLogin++;isAllReady++;break;
			case 9:value3="<%=Function.getMultiLangItemContent("LocaleManager.common.Voice",request)%>")+':'+voiceStateHolding;phoneBusy = 1;isAllLogin++;isAllReady++;break;
			case 10:value3="<%=Function.getMultiLangItemContent("LocaleManager.common.Voice",request)%>")+':'+voiceStateAcw;phoneBusy = 1;isAllLogin++;isAllReady++;break;
		}
	}
	
	if(value4!='0'){
		switch (parseInt(value4)) {
			case 1:value4="<%=Function.getMultiLangItemContent("LocaleManager.common.E-mail",request)%>")+':'+emailStatePause;isAllLogin++;break;
			case 4:value4="<%=Function.getMultiLangItemContent("LocaleManager.common.E-mail",request)%>")+':'+emailStateReady;isAllLogin++;break;
			case 5:value4="<%=Function.getMultiLangItemContent("LocaleManager.common.E-mail",request)%>")+':'+emailStateBusy;isAllLogin++;isAllReady++;break;
		}
	}
	
	if(value5!='0'){
		switch (parseInt(value5)) {
			case 1:value5="<%=Function.getMultiLangItemContent("LocaleManager.common.Chat",request)%>")+':'+chatStatePause;isAllLogin++;break;
			case 4:value5="<%=Function.getMultiLangItemContent("LocaleManager.common.Chat",request)%>")+':'+chatStateReady;isAllLogin++;break;
			case 5:value5="<%=Function.getMultiLangItemContent("LocaleManager.common.Chat",request)%>")+':'+chatStateBusy;isAllLogin++;isAllReady++;break;
		}
	}
	
	
	value1 = text2HtmlView(value1);
	value2 = text2HtmlView(value2);

	newline.children(0).firstChild.innerHTML='<div align="left">'+value1+'</div>';
	newline.children(1).firstChild.innerHTML='<div align="left">'+value2+'</div>';
	newline.children(2).firstChild.innerHTML='<div align="left">'+value3+' '+value4+' '+value5+'</div>';
	
	newline.onclick= function (){
		qwer(parseInt(k) +1);
		showAgentId(phoneNum,phoneBusy);
		this.style.backgroundColor = '#769cc4';
	};

    //lineObj[j]=newline;
    //j++;

	//standlist.insertBefore(newline,inputline);	
	standlist.children(1).insertAdjacentElement('afterEnd',newline);

}

function removerow(){
    var iii = 0;
    
	while (standlist.rows.length > 2) {
		standlist.deleteRow(2);
	}
}

 </script>
  </head>
  
  <body onload="changeFilter();init();">
  <form name="commonTransForm" action = "<%=request.getContextPath()%>/commonTransAction.do" method="post">
            	 <table width="100%"  border="0" cellspacing="2" cellpadding="0">
  <tr>
    <td bgcolor="#FFFFFF">
</div>
<div id="bottom" style=" height:30px;">
<table width="100%"  border="0" cellpadding="2" cellspacing="0" bgcolor="f1f5fa">
  <tr>
    <td style="font-size: 14px; font-weight:bold; border-bottom:1px solid #afbdce"><%=Function.getMultiLangItemContent("common.title.online.agent",request)%></td>
  </tr>
</table>
<table cellpadding="0" cellspacing="15" border="0" align="left">
  <tr>
    <td>
    <select name="strFilterName" id="filterName" onchange="javascript:changeFilter()" style="width:100px">
		<option value="strAgentName" <c:if test="${STRFILTERNAME == 'strAgentName'}">selected</c:if>><%=Function.getMultiLangItemContent("LocaleManager.AgentSee.New.agentName",request)%></option>
		<option value="strDnId" <c:if test="${STRFILTERNAME == null || STRFILTERNAME == '' ||STRFILTERNAME == 'strDnId'}">selected</c:if>><%=Function.getMultiLangItemContent("Tel.Ext",request)%></option>
		<option value="nLoginState" <c:if test="${STRFILTERNAME == 'nLoginState'}">selected</c:if>><%=Function.getMultiLangItemContent("LocaleManager.Agent.See.state",request)%></option>
      </select>
    </td>
    <td id="fieldContainer"></td>
    <td><input type="button" name="Submit" value="<%=Function.getMultiLangItemContent("qry.title",request)%>" onclick="seachAgentState();" style="font-size:12px"></td>
  </tr>
</table>
</div>
<div id="outer" style=" height:400px; overflow:auto">
<table width="100%"  border="0" align="left" cellpadding="0" cellspacing="0">
  <tr>
    <td>
	<table id="zxList" width="370"  border="0" align="center" cellpadding="3" cellspacing="1" bgcolor="#CCCCCC">
	<tr>
        <td><%=Function.getMultiLangItemContent("LocaleManager.AgentSee.New.agentName",request)%></td>
        <td width="80"><%=Function.getMultiLangItemContent("Tel.Ext",request)%></td>
        <td width="100"><%=Function.getMultiLangItemContent("LocaleManager.Agent.See.state",request)%></td>
    </tr>
 
      <TBODY id="standlist" >
                      <tr style="display:none"  class="lab3" onMouseOver="this.className='lab4'" onMouseOut="this.className='lab3'">
                        <td height="9" ><div align="center">xxxxx</div></td>
                        <td nowrap ><div align="center">xxxxx</div></td>
                        <td nowrap  ><div align="center">xxxxx</div></td>
                     </tr>
                     
                     <tr id="inputline" style="display:none" class="lab3" onMouseOver="this.className='lab4'" onMouseOut="this.className='lab3'">
                        <td nowrap  height="20" ><div align="center">
                            
                        </div></td>
                        <td nowrap ><div align="center">
                            
                        </div></td>
                        <td nowrap ><div align="center">
                            
                        </div></td>
                      </tr>
    </TBODY>
      
    </table>
</td>
  </tr>
</table>
</div>
	</td>
  </tr>
</table>

	<input name="strServiceName" type="hidden" value="AgentManager"/>
	<input name="strTransName" type="hidden" value="getAllOnlineAgentInfo"/>
	<input name="lUserId" type="hidden" value="<c:out value="${LUSERID}"/>"/>
	<input name="strUserName" type="hidden"  value="<c:out value="${STRUSERNAME}"/>"/>
	<input name="lTenantId" type="hidden"  value="<c:out value="${LTENANTID}"/>"/>
	<input name="forward" type="hidden" value="/jsp/showAgentStates.jsp"/>
	
</form>
            	 
<div style="display:none"  id="sf_strAgentName">
<input name="strAgentName" type="text" class="box01" size="16" maxlength="16" style="font-size:12px" value="">
</div>
<div style="display:none"  id="sf_nLoginState">
<select name="nLoginState" id="nLoginState" style="width:70px">
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
<input name="strDnId" type="text" class="box01" size="16" maxlength="256" style="font-size:12px" value="">
</div>

  </body>
</html>
