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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<script src="common.js"></script>
<link href="<%=strContextPath%>/css/chrome.css" rel="stylesheet" type="text/css">
<style type="text/css">
body {
	background-color: #ffffff;
	margin-top: 0px;
	margin-left: 0px;
	margin-right: 0px;
	border: none;
	overflow:auto;
}
.uline {
	border-bottom:1px solid #eeeeee;
}
.currentTr{
	background-color:#c4daed;
	cursor:pointer;
}
.telSign { font-size:13px; font-family:Wingdings 2; line-height:12px; color:#777777}
.emailSign {font-size:13px; font-family:Wingdings; line-height:12px; color:#777777}
.chatSign {font-size:13px; font-family:Webdings; line-height:12px; color:#777777}
</style>
<script type="text/javascript" src="<%=strContextPath%>/script/format.js"></script>
<script language="javascript" type="text/javascript">
var auxId = new Array();
var auxName = new Array();
var readySign = "4";
var notReadySign = "5";
var notAllReadySign = "6";
var i = 0;

 function showAgentId(str,phoneBusy){
 	//if(phoneBusy == 0){
 		top.document.all.numberBox.value='<%=insideNumberFront%>'+str;
 	//}
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

function seachAgentState(index,show){
	try{
		removerow();
		var agents = top.jsonrpc.asm.searchAgents(top.getTenantId(),top.getUserId(),index,show).map;

		for(i = 0; i < agents[0].list.length; i++)    {
	    	if(agents[0].list[i] != null && agents[0].list[i].strAgentName != undefined )   	{
	    		if(top.getUserId()!=undefined&&top.getUserId()!=agents[0].list[i].LAgentId){
	    			addrow(agents[0].list[i].strPlaceName,agents[0].list[i].strDnId,agents[0].list[i].NVoiceState,agents[0].list[i].NEmailState,agents[0].list[i].NChatState,i,agents[0].list[i].NState);
	    		}
	    	}
	    }
	 }catch(e){
		//alert(e.description);
	}
}

var nTotalCount = 0;
function init(){
	removerow();
	try{
		//nTotalCount = top.jsonrpc.asm.getCount();
		var agents = top.jsonrpc.asm.getAgentsForAgent(top.getTenantId(),top.getUserId()).map;

		for(i = 0; i < agents[0].list.length; i++)    {
	    	//if(agents[0].list[i] != null && agents[0].list[i].strAgentName != undefined && (agents[0].list[i].NState == readySign || agents[0].list[i].NState == notReadySign || agents[0].list[i].NState == notAllReadySign))   	{
	    		//alert(parseInt(top.getUserId())!=parseInt(agents[0].list[i].LAgentId));
	    		if(top.getUserId()!=undefined&&parseInt(top.getUserId())!=parseInt(agents[0].list[i].LAgentId)){
	    			addrow(agents[0].list[i].strPlaceName,agents[0].list[i].strDnId,agents[0].list[i].NVoiceState,agents[0].list[i].NEmailState,agents[0].list[i].NChatState,i,agents[0].list[i].NState);
	    		}
	    	//}
	    }
    }catch(e){
     	//alert(e.description);
    }
}

function qwer(para){
	try{
		for(i=1;i<document.getElementById("zxList").getElementsByTagName("tr").length;i++){
			document.getElementById("zxList").getElementsByTagName("tr")[i].style.backgroundColor = "#ffffff";
		}
	}catch(e){
		//alert(e);
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
function addrow(name,DN,nVoiceState,nEmailState,nChatState,k,isReady){
	var newline= standlist.firstChild.cloneNode(true);
	newline.style.display="block";
	var phoneNum = DN;
	var phoneBusy = 0;
	var statStyle = '';
	var statPic = '';
	var statWord = '';
	var voiceState = '';
	var emailState = '';
	var chatState = '';
	var hasDN = 0;
	
	if(isReady == 4){
		statPic = 'agentStat_AllReady_24.gif';
		phoneBusy = 0;
	}else if(isReady == 5){
		statPic = 'agentStat_busy_24.gif';
		//phoneBusy = 1;
	}else if(isReady == 6){
		statPic = 'agentStat_partReady_24.gif';
		//phoneBusy = 1;
	}else{
		statPic = 'agentStat_offline_24.gif';
		//phoneBusy = 1;
	}

	if(nVoiceState!='0'){
		if(nVoiceState == '1'){
			voiceState = voiceStatePause;
			phoneBusy = 0;
		}else if(nVoiceState == '4'){
			voiceState = voiceStateReady;
			phoneBusy = 0;
		}else if(nVoiceState == '5'){
			voiceState = voiceStateTalking;
			phoneBusy = 1;
		}else if(nVoiceState == '6'){
			voiceState = voiceStateDialing;
			phoneBusy = 0;
		}else if(nVoiceState == '7'){
			voiceState = voiceStateRinging;
			phoneBusy = 0;
		}else if(nVoiceState == '8'){
			voiceState = voiceStateConference;
			phoneBusy = 1;
		}else if(nVoiceState == '9'){
			voiceState = voiceStateHolding;
			phoneBusy = 1;
		}else if(nVoiceState == '10'){
			voiceState = voiceStateAcw;
			phoneBusy = 1;
		}else{
			voiceState = '<%=Function.getMultiLangItemContent("LocaleManager.service.new.busy",request)%>';
			phoneBusy = 1;
		}
		hasDN++;
	}else{
		voiceState = '<%=Function.getMultiLangItemContent("common.DN.state.logout",request)%>';
		phoneBusy = 1;
		hasDN++;
	}
	
	if(nEmailState!='0'){
		if(nEmailState == '1'){
			emailState = '<%=Function.getMultiLangItemContent("LocaleManager.service.new.pause",request)%>';
		}else if(nEmailState == '4'){
			emailState = '<%=Function.getMultiLangItemContent("LocaleManager.service.new.ready",request)%>';
		}else{
			emailState = '<%=Function.getMultiLangItemContent("LocaleManager.service.new.busy",request)%>';
		}
		hasDN++;
	}else{
		emailState = '<%=Function.getMultiLangItemContent("common.DN.state.logout",request)%>';
		hasDN++;
	}
	
	if(nChatState!='0'){
		if(nChatState == '1'){
			chatState = '<%=Function.getMultiLangItemContent("LocaleManager.service.new.pause",request)%>';
		}else if(nChatState == '4'){
			chatState = '<%=Function.getMultiLangItemContent("LocaleManager.service.new.ready",request)%>';
		}else{
			chatState = '<%=Function.getMultiLangItemContent("LocaleManager.service.new.busy",request)%>';
		}
		hasDN++;
	}else{
		chatState = '<%=Function.getMultiLangItemContent("common.DN.state.logout",request)%>';
		hasDN++;
	}
	
	var DNTemp = "";
	var nameTemp = "";
	
	if(DN.length>6)
		DNTemp = DN.substring(0,6)+'...';
	else
		DNTemp = DN;
	if(name.length>10)
		nameTemp = name.substring(0,10)+'...';
	else
		nameTemp = name;
		
	newline.document.getElementById("td1").innerHTML='<img src="<%=strContextPath%>/images/agentSee/'+statPic+'" width="12" height="14">';
	var str = '<table width="100%"  border="0" cellspacing="0" cellpadding="3"><tr><td title="'+name+'">'+nameTemp+' </td><td align="right" title="'+DN+'">'+DNTemp+'</td></tr><tr><td colspan="2">';
	if(hasDN>0){
		//if(nVoiceState!='0'){
			str += '<span class="emailSign">(</span>'+voiceState;
		//}
		if(false){
			str += ' <span class="emailSign">*</span>'+emailState;	
		}
		if(false){
			str += ' <span class="chatSign">)</span>'+chatState;	
		}
		str+=' </td></tr></table>';
	}else{
		str+='&nbsp;</td></tr></table>';
	}
	newline.document.getElementById("td2").innerHTML=str;
	newline.onclick= function (){
		//qwer(parseInt(k) +1);
		showAgentId(phoneNum,phoneBusy);
		//this.style.backgroundColor = '#769cc4';
		//this.document.getElementById("stable").backgroundColor = '#769cc4';
	};
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

<body onload="init();">
	<table width="100%" id="zxList" border="0" cellspacing="0" cellpadding="3">
	<TBODY id="standlist" >
	<tr style="display:none" onMouseOver="this.className='currentTr'" onMouseOut="this.className=''">
        <td width="12" id="td1" align="center" class="uline"><img src="<%=strContextPath%>/images/agentSee/agentStat_AllReady_24.gif" width="12" height="14"></td>
        <td class="uline" id="td2"><table width="100%" id="stable" border="0" cellspacing="0" cellpadding="3">
              <tr>
                <td>Frank </td>
                <td align="right">7001</td>
              </tr>
              <tr>
                <td colspan="2"><span class="emailSign">(</span>就绪 <span class="emailSign">*</span>就绪 <span class="chatSign">)</span>就绪 </td>
              </tr>
            </table></td>
    </tr>
    <tr id="inputline" style="display:none" onMouseOver="this.className='currentTr'" onMouseOut="this.className=''">
        <td width="12" align="center" class="uline"><img src="<%=strContextPath%>/images/agentSee/agentStat_AllReady_24.gif" width="12" height="14"></td>
        <td class="uline"><table width="100%"  border="0" cellspacing="0" cellpadding="3">
              <tr>
                <td>Frank </td>
                <td align="right">7001</td>
              </tr>
              <tr>
                <td colspan="2"><span class="emailSign">(</span>就绪 <span class="emailSign">*</span>就绪 <span class="chatSign">)</span>就绪 </td>
              </tr>
            </table></td>
    </tr>
    </TBODY>
    <!-- 
	  <tr onMouseOver="this.className='currentTr'" onMouseOut="this.className=''">
        <td width="12" align="center" class="uline"><img src="<%=strContextPath%>/images/agentSee/agentStat_AllReady_24.gif" width="12" height="14"></td>
        <td class="uline"><table width="100%"  border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td>Frank </td>
            <td align="right">7001</td>
          </tr>
          <tr>
            <td colspan="2"><span class="emailSign">(</span>就绪 <span class="emailSign">*</span>就绪 <span class="chatSign">)</span>就绪 </td>
          </tr>
        </table></td>
      </tr> 
	  <tr onMouseOver="this.className='currentTr'" onMouseOut="this.className=''">
        <td width="12" align="center" class="uline"><img src="<%=strContextPath%>/images/agentSee/agentStat_AllReady_24.gif" width="12" height="14"></td>
        <td class="uline"><table width="100%"  border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td>Frank </td>
            <td align="right">7001</td>
          </tr>
          <tr>
            <td colspan="2"><span class="emailSign">(</span>就绪 <span class="emailSign">*</span>就绪 <span class="chatSign">)</span>就绪 </td>
          </tr>
        </table></td>
      </tr> 
	  <tr onMouseOver="this.className='currentTr'" onMouseOut="this.className=''">
        <td width="12" align="center" class="uline"><img src="<%=strContextPath%>/images/agentSee/agentStat_AllReady_24.gif" width="12" height="14"></td>
        <td class="uline"><table width="100%"  border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td>Frank </td>
            <td align="right">7001</td>
          </tr>
          <tr>
            <td colspan="2"><span class="emailSign">(</span>就绪 <span class="emailSign">*</span>就绪 <span class="chatSign">)</span>就绪 </td>
          </tr>
        </table></td>
      </tr>
	  <tr onMouseOver="this.className='currentTr'" onMouseOut="this.className=''">
        <td width="12" align="center" class="uline"><img src="<%=strContextPath%>/images/agentSee/agentStat_AllReady_24.gif" width="12" height="14"></td>
        <td class="uline"><table width="100%"  border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td>Frank </td>
            <td align="right">7001</td>
          </tr>
          <tr>
            <td colspan="2"><span class="emailSign">(</span>就绪 <span class="emailSign">*</span>就绪 <span class="chatSign">)</span>就绪 </td>
          </tr>
        </table></td>
      </tr> 
	  <tr onMouseOver="this.className='currentTr'" onMouseOut="this.className=''">
        <td width="12" align="center" class="uline"><img src="<%=strContextPath%>/images/agentSee/agentStat_busy_24.gif" width="12" height="14"></td>
        <td class="uline"><table width="100%"  border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td>Frank </td>
            <td align="right">7001</td>
          </tr>
          <tr>
            <td colspan="2"><span class="emailSign">(</span>暂停 <span class="emailSign">*</span>就绪 <span class="chatSign">)</span>就绪 </td>
          </tr>
        </table></td>
      </tr> 
	  <tr onMouseOver="this.className='currentTr'" onMouseOut="this.className=''">
        <td width="12" align="center" class="uline"><img src="<%=strContextPath%>/images/agentSee/agentStat_busy_24.gif" width="12" height="14"></td>
        <td class="uline"><table width="100%"  border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td>Frank </td>
            <td align="right">7001</td>
          </tr>
          <tr>
            <td colspan="2"><span class="emailSign">(</span>暂停 <span class="emailSign">*</span>就绪 <span class="chatSign">)</span>就绪 </td>
          </tr>
        </table></td>
      </tr> 
	  <tr onMouseOver="this.className='currentTr'" onMouseOut="this.className=''">
        <td width="12" align="center" class="uline"><img src="<%=strContextPath%>/images/agentSee/agentStat_partReady_24.gif" width="12" height="14"></td>
        <td class="uline"><table width="100%"  border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td>Frank </td>
            <td align="right">7001</td>
          </tr>
          <tr>
            <td colspan="2"><span class="emailSign">(</span>暂停 <span class="emailSign">*</span>就绪 <span class="chatSign">)</span>就绪 </td>
          </tr>
        </table></td>
      </tr> 
	  <tr onMouseOver="this.className='currentTr'" onMouseOut="this.className=''">
        <td width="12" align="center" class="uline"><img src="<%=strContextPath%>/images/agentSee/agentStat_partReady_24.gif" width="12" height="14"></td>
        <td class="uline"><table width="100%"  border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td>Frank </td>
            <td align="right">7001</td>
          </tr>
          <tr>
            <td colspan="2"><span class="emailSign">(</span>暂停 <span class="emailSign">*</span>就绪 <span class="chatSign">)</span>就绪 </td>
          </tr>
        </table></td>
      </tr> 
	  <tr onMouseOver="this.className='currentTr'" onMouseOut="this.className=''">
        <td width="12" align="center" class="uline"><img src="<%=strContextPath%>/images/agentSee/agentStat_partReady_24.gif" width="12" height="14"></td>
        <td class="uline"><table width="100%"  border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td>Frank </td>
            <td align="right">7001</td>
          </tr>
          <tr>
            <td colspan="2"><span class="emailSign">(</span>暂停 <span class="emailSign">*</span>就绪 <span class="chatSign">)</span>就绪 </td>
          </tr>
        </table></td>
      </tr>
      <tr onMouseOver="this.className='currentTr'" onMouseOut="this.className=''">
        <td width="12" align="center" class="uline"><img src="<%=strContextPath%>/images/agentSee/agentStat_offline_24.gif" width="12" height="14"></td>
        <td class="uline"><table width="100%"  border="0" cellspacing="0" cellpadding="3">
            <tr>
              <td>Frank </td>
              <td align="right">7001</td>
            </tr>
            <tr>
              <td colspan="2"><span class="emailSign">(</span>暂停 <span class="emailSign">*</span>就绪 <span class="chatSign">)</span>就绪 </td>
            </tr>
        </table></td>
      </tr>
      <tr onMouseOver="this.className='currentTr'" onMouseOut="this.className=''">
        <td width="12" align="center" class="uline"><img src="<%=strContextPath%>/images/agentSee/agentStat_offline_24.gif" width="12" height="14"></td>
        <td class="uline"><table width="100%"  border="0" cellspacing="0" cellpadding="3">
            <tr>
              <td>Frank </td>
              <td align="right">7001</td>
            </tr>
            <tr>
              <td colspan="2"><span class="emailSign">(</span>暂停 <span class="emailSign">*</span>就绪 <span class="chatSign">)</span>就绪 </td>
            </tr>
        </table></td>
      </tr>
     <tr onMouseOver="this.className='currentTr'" onMouseOut="this.className=''">
        <td width="12" align="center" class="uline"><img src="<%=strContextPath%>/images/agentSee/agentStat_offline_24.gif" width="12" height="14"></td>
        <td class="uline"><table width="100%"  border="0" cellspacing="0" cellpadding="3">
            <tr>
              <td>Frank </td>
              <td align="right">7001</td>
            </tr>
            <tr>
              <td colspan="2"><span class="emailSign">(</span>暂停 <span class="emailSign">*</span>就绪 <span class="chatSign">)</span>就绪 </td>
            </tr>
        </table></td>
      </tr>
      <tr onMouseOver="this.className='currentTr'" onMouseOut="this.className=''">
        <td width="12" align="center" class="uline"><img src="<%=strContextPath%>/images/agentSee/agentStat_AllReady_24.gif" width="12" height="14"></td>
        <td class="uline"><table width="100%"  border="0" cellspacing="0" cellpadding="3">
            <tr>
              <td>Frank </td>
              <td align="right">7001</td>
            </tr>
            <tr>
              <td colspan="2"><span class="emailSign">(</span>暂停 <span class="emailSign">*</span>就绪 <span class="chatSign">)</span>就绪 </td>
            </tr>
        </table></td>
      </tr>
      <tr onMouseOver="this.className='currentTr'" onMouseOut="this.className=''">
        <td width="12" align="center" class="uline"><img src="<%=strContextPath%>/images/agentSee/agentStat_AllReady_24.gif" width="12" height="14"></td>
        <td class="uline"><table width="100%"  border="0" cellspacing="0" cellpadding="3">
            <tr>
              <td>Frank </td>
              <td align="right">7001</td>
            </tr>
            <tr>
              <td colspan="2"><span class="emailSign">(</span>暂停 <span class="emailSign">*</span>就绪 <span class="chatSign">)</span>就绪 </td>
            </tr>
        </table></td>
      </tr>
      <tr onMouseOver="this.className='currentTr'" onMouseOut="this.className=''">
        <td width="12" align="center" class="uline"><img src="<%=strContextPath%>/images/agentSee/agentStat_AllReady_24.gif" width="12" height="14"></td>
        <td class="uline"><table width="100%"  border="0" cellspacing="0" cellpadding="3">
            <tr>
              <td>Frank </td>
              <td align="right">7001</td>
            </tr>
            <tr>
              <td colspan="2"><span class="emailSign">(</span>暂停 <span class="emailSign">*</span>就绪 <span class="chatSign">)</span>就绪 </td>
            </tr>
        </table></td>
      </tr>
      <tr onMouseOver="this.className='currentTr'" onMouseOut="this.className=''">
        <td width="12" align="center" class="uline"><img src="<%=strContextPath%>/images/agentSee/agentStat_AllReady_24.gif" width="12" height="14"></td>
        <td class="uline"><table width="100%"  border="0" cellspacing="0" cellpadding="3">
            <tr>
              <td>Frank </td>
              <td align="right">7001</td>
            </tr>
            <tr>
              <td colspan="2"><span class="emailSign">(</span>暂停 <span class="emailSign">*</span>就绪 <span class="chatSign">)</span>就绪 </td>
            </tr>
        </table></td>
      </tr>
      <tr onMouseOver="this.className='currentTr'" onMouseOut="this.className=''">
        <td width="12" align="center" class="uline"><img src="<%=strContextPath%>/images/agentSee/agentStat_AllReady_24.gif" width="12" height="14"></td>
        <td class="uline"><table width="100%"  border="0" cellspacing="0" cellpadding="3">
            <tr>
              <td>Frank </td>
              <td align="right">7001</td>
            </tr>
            <tr>
              <td colspan="2"><span class="emailSign">(</span>暂停 <span class="emailSign">*</span>就绪 <span class="chatSign">)</span>就绪 </td>
            </tr>
        </table></td>
      </tr>
      <tr onMouseOver="this.className='currentTr'" onMouseOut="this.className=''">
        <td width="12" align="center" class="uline"><img src="<%=strContextPath%>/images/agentSee/agentStat_AllReady_24.gif" width="12" height="14"></td>
        <td class="uline"><table width="100%"  border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td>Frank </td>
            <td align="right">7001</td>
          </tr>
          <tr>
            <td colspan="2"><span class="emailSign">(</span>暂停 <span class="emailSign">*</span>就绪 <span class="chatSign">)</span>就绪 </td>
          </tr>
        </table></td>
      </tr>
      <tr onMouseOver="this.className='currentTr'" onMouseOut="this.className=''">
        <td width="12" align="center" class="uline"><img src="<%=strContextPath%>/images/agentSee/agentStat_AllReady_24.gif" width="12" height="14"></td>
        <td class="uline"><table width="100%"  border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td>Frank </td>
            <td align="right">7001</td>
          </tr>
          <tr>
            <td colspan="2"><span class="emailSign">(</span>暂停 <span class="emailSign">*</span>就绪 <span class="chatSign">)</span>就绪 </td>
          </tr>
        </table></td>
      </tr>
      -->
</table>
</body>
</html>