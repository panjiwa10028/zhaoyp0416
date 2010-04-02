<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.Function"%>
<%@ page import="com.esoon.EZActor.BusinessCenter.BusinessCenterApp"%>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>
<%@ taglib prefix="fn" uri="/WEB-INF/fn.tld" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib prefix="fmt" uri="/WEB-INF/fmt.tld" %>
<%@ include file="/jsp/common/header/include_init.jsp" %>
<%
	String strProductName = Function.getMultiLangItemContent((String) request.getAttribute("strProductName"),
			request);
	String contextPath = request.getContextPath();
	String strImageMultiLang = Function.GetMultiLangName(request);
%>
<jsp:include page="/script/waiting.jsp"></jsp:include>

<html> 
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<link href="<%=strContextPath%>/css/chrome.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" href="<%=strContextPath%>/script/contactCommon/menu.css" type="text/css">
<link href="<%=strContextPath%>/softphone/css/cti.css" rel="stylesheet" type="text/css">

<style type="text/css">
.class0{
	border-width:0px;
}
.class1{
	background-image:url(<%=strContextPath%>/images/pop_tab_current.gif);
	background-position:top;
	width:29px;
}
</style>

<title><%=strProductName%></title>
<script src="<%=strContextPath%>/script/contact_cti.js" language="JavaScript" type="text/javascript"></script>
<script src="<%=strContextPath%>/script/contact_cti_ext.js" language="JavaScript" type="text/javascript"></script> 

<c:if test='${strProductId=="Contact"}'>
	<script src="<%=strContextPath%>/script/queueShow.js" language="JavaScript" type="text/javascript"></script>
	<script src="<%=strContextPath%>/softphone/script/applet.js" language="JavaScript" type="text/javascript"></script>
	<script src="<%=strContextPath%>/softphone/script/softphone-api.js" language="JavaScript" type="text/javascript"></script>
	<script src="<%=strContextPath%>/softphone/script/cti-function.js" language="JavaScript" type="text/javascript"></script>
	<script src="<%=strContextPath%>/softphone/script/cti-event.js" language="JavaScript" type="text/javascript"></script>
</c:if>

<script src="<%=strContextPath%>/script/common.js" language="JavaScript" type="text/javascript"></script>
<script src="<%=strContextPath%>/script/uiComponent.js" language="JavaScript" type="text/javascript"></script>
<script src="<%=strContextPath%>/script/shield.js" language="JavaScript" type="text/javascript"></script>
<script src="<%=strContextPath%>/script/popu.js" language="JavaScript" type="text/javascript"></script>
<script src="<%=strContextPath%>/script/url.js" language="JavaScript" type="text/javascript"></script>
<script src="<%=strContextPath%>/script/tab.js" language="JavaScript" type="text/javascript"></script>
<script src="<%=strContextPath%>/script/inject.js" language="JavaScript" type="text/javascript"></script>

<script src="<%=strContextPath%>/script/activityExecution.js" language="JavaScript" type="text/javascript"></script>
<script src="<%=strContextPath%>/script/chatManager.js" language="JavaScript" type="text/javascript"></script>
<script src="<%=strContextPath%>/script/contactCommon/dtree2.js" language="JavaScript" type="text/javascript"></script>
<script src="<%=strContextPath%>/script/contactCommon/setTime.js" language="JavaScript" type="text/javascript"></script>
<script src="<%=strContextPath%>/script/contactCommon/dtree4.js" language="JavaScript" type="text/javascript" ></script>
<script src="<%=strContextPath%>/script/contactCommon/dialog.js" language="JavaScript" type="text/javascript"></script>
<script src="<%=strContextPath%>/script/contactCommon/jsonrpc.js" language="JavaScript" type="text/javascript"></script>
<script src="<%=strContextPath%>/script/contactCommon/remindInfo.js" language="JavaScript" type="text/javascript"></script>
<script src="<%=strContextPath%>/script/ajax.js" language="JavaScript" type="text/javascript"></script>
<script	src="<%=strContextPath%>/script/contactCommon/menu.js" language="JavaScript" type="text/javascript"></script>
<script	src="<%=strContextPath%>/script/contactCommon/setContactStateCode.js" language="JavaScript" type="text/javascript"></script>
<script src="<%=strContextPath%>/script/contactCommon/setStatus.js"></script>

<script>
	moveTo(0,0);
	resizeTo(screen.availWidth,screen.availHeight);

var lPresetOutboundBusinessId="";
var d1= new Date();
var strProductId='<c:out value="${strProductId}"/>';

var d222= new Date();

var strContextPath = "<%=strContextPath%>";

var manualFlag = 0;

var emailManagerOperatorEmailOK = '<%=Function.getMultiLangItemContent("transactInfo", request)%>'+'<%=Function.getMultiLangItemContent("emailManager.send.OK", request)%>'

var strManDNId='<c:out value="${EXT}"/>';
var strSkillGroupId='<c:out value="${STRGROUPHEADERID}"/>';
var strDepartmentHeaderId='<c:out value="${STRDEPARTMENTHEADERID}"/>';

var localeManagerMonitorcallFaile = '<%=Function.getMultiLangItemContent("transactInfo", request)%><%=Function.getMultiLangItemContent("LocaleManager.AgentSee.New.monitorcall.faile", request)%>';
var localeManagerReleasecallFaile = '<%=Function.getMultiLangItemContent("transactInfo", request)%><%=Function.getMultiLangItemContent("LocaleManager.AgentSee.New.releasecall.faile", request)%>';
var localeManagerForceInterveneFaile = '<%=Function.getMultiLangItemContent("transactInfo", request)%><%=Function.getMultiLangItemContent("LocaleManager.AgentSee.New.forceIntervene.faile",
									request)%>';
var localeManagerForceremoveFaile = '<%=Function.getMultiLangItemContent("transactInfo", request)%><%=Function.getMultiLangItemContent("LocaleManager.AgentSee.New.forceremove.faile", request)%>';
var requestSuccess ='<%=Function.getMultiLangItemContent("transactInfo", request)%><%=Function.getMultiLangItemContent("agent.monitor.requestsuccess", request)%>';
var isConfirmMakeCall = '<%=Function.getMultiLangItemContent("BlockContacteeManager.page.isReadyCall", request)%>';

var tempWinObj;
var CampaignExecutionManagerName = "<%=Function.getMultiLangItemContent("Campaign.CampaignExecutionManager.Name", request)%>";
var CampaignExecutionAgentGroup = "<%=Function.getMultiLangItemContent("Campaign.CampaignExecutionManager.UI.AgentTaskFrom.AgentGroup",
							request)%>";
var CampaignExecutionAgent = "<%=Function.getMultiLangItemContent("Campaign.CampaignExecutionManager.UI.AgentTaskFrom.Agent",
							request)%>";
var tempDir="";
var queueShowTitle = "<%=Function.getMultiLangItemContent("LocaleManager.common.Queue.num", request)%>";
var queueTatalTitle = "<%=Function.getMultiLangItemContent("LocaleManager.common.Queue.total", request)%>";
var queueLongestTitle = "<%=Function.getMultiLangItemContent("LocaleManager.common.Queue.longest", request)%>";
var TITLE_EMAIL = '<%=Function.getMultiLangItemContent("common.email", request)%>';
var TITLE_CHAT = '<%=Function.getMultiLangItemContent("common.chat", request)%>';
var TITLE_FAX = '<%=Function.getMultiLangItemContent("common.fax", request)%>';
var TITLE_MAIL = '<%=Function.getMultiLangItemContent("common.mail", request)%>';
var TITLE_SMS = '<%=Function.getMultiLangItemContent("common.sms", request)%>';

var ChatTransFailMessage="<%=Function.getMultiLangItemContent("MediaManager.chat.trans.error", request)%>";
var ChatLeftMessage="<%=Function.getMultiLangItemContent("MediaManager.chat.agent.left", request)%>";
var ChatJoinMessage="<%=Function.getMultiLangItemContent("MediaManager.chat.agent.join", request)%>";

var strAgentHasOtherBusiness = '<%=Function.getMultiLangItemContent("softphone.agent.hasOtherBusiness", request)%>';
var contactArray = new ContactArray();
var contactStateArray = new ContactStateArray();
var contactUtils = new ContactUtils();

var summaryTreeList = null;
var nSummaryMode = 0;
	 
var leftUrl="about:blank";
var workUrl="about:blank";

var statusTD ='';

//0=no pin float,1=pin float
var isPinFloat = false;
//0embeded,1float,2close
var isMesFloat=1;

//0embeded,1float,2close
var isFaqFloat=2;

var strStatServerAvailableThisPage ='<c:out value="${strStatServerAvailable}"/>';

var isLogout = false;

//control marquee 0 running, 1 stop
var marqueeFlag = 0;

//权限全局标志
<c:forEach var="permission" items="${PERMISSIONLIST}">
var g_<c:out value="${fn:replace(permission, '.', '_')}"/> = true;
</c:forEach>

//角色全局标志
<c:forEach var="role" items="${ROLELIST}">
var r_<c:out value="${role}"/> = true;
</c:forEach>

//是否设置了快捷菜单
var hasSetQuickPermission = false;

//显示信息提醒,add by Susan
var expireMemoCount = 0;
var expireGeneralMsgCount = 0;
var expireBulletinCount = 0;
var expireRoleCount = 0;
var expireEventCount = 0;
//15秒钟后提示框自动消失的设置
var timerID_=null;

//campaign的树
var campaignTree = null;

//该导航栏条目是否是第一个被显示的
var firstflag=0;

function StringBuffer(){this.b=[];}
StringBuffer.prototype.append=function(a)
{
	//this.b.push(a);
	this.b[this.b.length]=a;
}
StringBuffer.prototype.toString=function(){return this.b.join("");}
StringBuffer.prototype.clear=function(){var count=this.b.length;for(var i=count;i>0;i--){this.b.pop();}}
var strBuf={
b:[],
append:function(a)
{
	//this.b.push(a);
	this.b[this.b.length]=a;
},
toString:function(){return this.b.join("");},
clear:function(){for(var i=this.b.length;i>0;i--){this.b.pop();}}
};

function trim(str){
	return str.replace(/(^[\s　]*)|([\s　]*$)/g, "");
}

//构建左侧导航栏
function getLeftTree()
{
	var LeftAreaTr =document.getElementById("menuContent");//?????tr
	
	var sHtml=new StringBuffer('');
	var i=0;
	var j=0;
	var k=0;
	var flag=0;//1上一级是二级菜单
	 
	var subfirst=0;
	var contentAreaURL = '';
	var treeBarURL = '';
	var ModuleName='';
    var ModuleName_1='';
	<!-- 进入modulebean循环 -->	
	var a=new Date();	
	<c:forEach var="moduleBean" items="${moduleList}"  varStatus="status">

	    contentAreaURL = translateUrl('<c:out value="${moduleBean.contentAreaURL}"/>');
	    	
		if (contentAreaURL.indexOf('http:') !=0 ) 
		{
			if(contentAreaURL.startsWith('/'))
				contentAreaURL = '<%=strContextPath%>'+contentAreaURL;
			else				
				contentAreaURL = '<%=strContextPath%>/'+contentAreaURL;
		}
	//alert("-->"+contentAreaURL);
			
		treeBarURL = '<c:out value="${moduleBean.treeBarURL}"/>';
		if (treeBarURL.indexOf('http:') !=0 ) {
			if(treeBarURL.startsWith('/'))
				treeBarURL = '<%=strContextPath%>'+treeBarURL;
			else				
				treeBarURL = '<%=strContextPath%>/'+treeBarURL;
		}
		
    	<c:set var="strNameTemp" value="${moduleBean.multiLangItemId}" />
    	
     	<c:set var="strImage" value="${moduleBean.imageFile}" />
		<!-- 第一层导航栏 -->
		<c:if test="${moduleBean.moduleLevel==0}">
			<c:set var="strName_1" value="${moduleBean.multiLangItemId}" />
			ModuleName='<c:out value="${moduleBean.moduleId}"/>';
	 		j=0;k=0;flag=0;
		 	if(i>0)
		 	{
				sHtml.append("</table><br></div>");
			<c:if test='${strProductId=="AdminCenter"}'>
			 	sHtml.append("<div id=\"mt");
			 	sHtml.append(i);
			 	sHtml.append("\" class=\"menuTitle\" onClick=\"clickMenu('mc");
			 	sHtml.append(i);
			 	sHtml.append("')\" onMouseOver=\"overMenu(this)\" onMouseOut=\"outMenu(this)\">");
				sHtml.append("<img src=\"<%=strContextPath%>/");
				sHtml.append('<c:out value="${moduleBean.imageFile}"/>');
				sHtml.append("\" width=\"16\" height=\"16\" border=\"0\" align=\"absmiddle\">");
				sHtml.append('<%=Function.getMultiLangItemContent((String) pageContext.getAttribute("strName_1"),
										request)%>');
				sHtml.append("</div>");
			</c:if>
				sHtml.append("<div id=mc");
				sHtml.append(i);
				sHtml.append(" class=\"menuContent\" style=\"display:none\"><table width=\"100%\"  border=\"0\" cellspacing=\"0\">");
			}
			else
			{
			<c:if test='${strProductId=="AdminCenter"}'>
				sHtml.append("<div id=\"mt");
				sHtml.append(i);
				sHtml.append("\" class=\"menuTitle\" onClick=\"clickMenu('mc");
				sHtml.append(i);
				sHtml.append("')\" onMouseOver=\"overMenu(this)\" onMouseOut=\"outMenu(this)\">");
				sHtml.append("<img src=\"<%=strContextPath%>/");
				sHtml.append('<c:out value="${moduleBean.imageFile}"/>');
				sHtml.append("\" width=\"16\" height=\"16\" border=\"0\" align=\"absmiddle\">");
				sHtml.append('<%=Function.getMultiLangItemContent((String) pageContext.getAttribute("strName_1"),
										request)%>');
				sHtml.append("</div>");
			</c:if>
				sHtml.append("<div id=mc");
				sHtml.append(i);
				sHtml.append(" class=\"menuContent\" style=\"display:none\"><table width=\"100%\"  border=\"0\" cellspacing=\"0\">");
			}
			<c:if test="${moduleBean.isFirstFlag==1}">
			firstflag=i;
     	 	subfirst=1;
     		</c:if>
			i++;
		</c:if>
		
		<!-- 第二层导航栏 -->
		<c:if test="${moduleBean.moduleLevel ==1}">
			k=0;
			ModuleName_1='<c:out value="${moduleBean.moduleId}"/>';
			<c:if test="${moduleBean.isExitSub==0}">
			if(subfirst==1)
			{
				addTab('ipcc','<%=Function.getMultiLangItemContent((String) pageContext.getAttribute("strNameTemp"),
										request)%>','<%=strContextPath%>/jsp/main/System.jsp',false,true,false,treeBarURL,contentAreaURL);
				
				subfirst=0;
				sHtml.append("<tr style=\"display:none\"><td style=\"padding-left:5px;\" id=per");
			} else {
				sHtml.append("<tr><td style=\"padding-left:5px;\" id=per");
			}
			if(flag==1)
			{
				sHtml.append("</tbody>");
				flag=0;
			}
			
			sHtml.append(i);sHtml.append(j);
			sHtml.append(">");
			sHtml.append("<span style=\"cursor:pointer;\" ");
			<c:if test="${moduleBean.reserveFlag!=-1}">
			 if(ModuleName_1=="OrderFormManager"||ModuleName_1=="CampaignExecution"||ModuleName_1=="ComplaintManager"||ModuleName_1=="MaintainManager"||ModuleName_1=="ConsultManager"||ModuleName_1=="TaskManager")
			 {
			 //alert(ModuleName_1);
			 sHtml.append("onClick=\"top.addTab('"+ModuleName_1+"',");
			 }
		     else
		     {
		     sHtml.append("onClick=\"top.addTab('"+ModuleName+"',");
		     }
				
			
				sHtml.append("'<%=Function.getMultiLangItemContent((String) pageContext.getAttribute("strNameTemp"),
										request)%>',");
				sHtml.append("'<%=strContextPath%>/jsp/main/System.jsp',");
				
				if(ModuleName_1=="OrderFormManager"||ModuleName_1=="CampaignExecution"||ModuleName_1=="ComplaintManager"||ModuleName_1=="MaintainManager"||ModuleName_1=="ConsultManager"||ModuleName_1=="TaskManager")
				 {
				 sHtml.append("true,");
				 }
				 else
				 {
				sHtml.append("false,");
				}
				sHtml.append("false,");
				sHtml.append("false,'");
				sHtml.append(treeBarURL);
				sHtml.append("','");
				sHtml.append(contentAreaURL);
				sHtml.append("');");
			</c:if>
			<c:if test="${moduleBean.reserveFlag==-1}">
				sHtml.append("onClick=\"document.location.href='");
				sHtml.append(contentAreaURL);
				sHtml.append("';");
			</c:if>
				sHtml.append("setCurrentColor('per");
				sHtml.append(i);sHtml.append(j);
				sHtml.append("')\">");
			
			//alert(sHtml);
				<c:if test="${moduleBean.imageFile==''}">
					sHtml.append("<img src=\"<%=strContextPath%>/images/item.gif\"");
				</c:if>
				<c:if test="${moduleBean.imageFile!=''}">
			    	sHtml.append("<img src=\"<%=strContextPath%>/<c:out value="${moduleBean.imageFile}"/>\"");
				</c:if>
					sHtml.append(" width=\"16\" height=\"18\" border=\"0\" align=\"absmiddle\"><%=Function.getMultiLangItemContent((String) pageContext.getAttribute("strNameTemp"),
									request)%></span></td></tr>");
				</c:if>
				<c:if test="${moduleBean.isExitSub==1}">
				if(j>0)
				{
					if(flag==1)
					sHtml.append(" </tbody>");
			    }
				flag=1;
				sHtml.append("<tr><td style=\"padding-left:5px;\" id=per");
				sHtml.append(i);sHtml.append(j);
				sHtml.append(">");
				sHtml.append("<span onClick=\"opFolder('per");
				sHtml.append(i);sHtml.append(j);
				sHtml.append("Div','per");
				sHtml.append(i);sHtml.append(j);
				sHtml.append("_folder','per");
				sHtml.append(i);sHtml.append(j);
				sHtml.append("_Sign');\" style=\"cursor:pointer;\">");
				sHtml.append(" <img src=\"<%=strContextPath%>/images/folder_plus.gif\" border=\"0\" align=\"absmiddle\" id=per");
				sHtml.append(i);sHtml.append(j);
				sHtml.append("_Sign></span>"); 
				sHtml.append("<span onClick=\"openFolder('per");
				sHtml.append(i);sHtml.append(j);
				sHtml.append("Div','per");
				sHtml.append(i);sHtml.append(j);
				sHtml.append("_folder','per");
				sHtml.append(i);sHtml.append(j);
				sHtml.append("_Sign');setCurrentColor('per");
				sHtml.append(i);sHtml.append(j);
				sHtml.append("')\" style=\"cursor:pointer;\">");
					<c:if test="${moduleBean.imageFile==''}">
						sHtml.append(" <img src=\"<%=strContextPath%>/images/folder.gif\"");
					</c:if>
					<c:if test="${moduleBean.imageFile!=''}">
						sHtml.append(" <img src=\"<%=strContextPath%>/<c:out value="${moduleBean.imageFile}"/>\"");
					</c:if>
				sHtml.append(" width=\"18\" height=\"18\" border=\"0\" align=\"absmiddle\" id=per");
				sHtml.append(i);sHtml.append(j);
				sHtml.append("_folder>");
				sHtml.append("<%=Function.formatShortToHTML(Function.getMultiLangItemContent((String) pageContext
									.getAttribute("strNameTemp"), request), 30)%></span></td></tr>");
				sHtml.append("<tbody id=per");
				sHtml.append(i);sHtml.append(j);
				sHtml.append("Div style=\"display:none\">");
			 	</c:if>
			j++;
		</c:if>
		
		<!-- 第三层导航栏 -->
		<c:if test="${moduleBean.moduleLevel ==2}">
	 	    var t=j-1;
			sHtml.append("<tr><td id=per");
			sHtml.append(i);sHtml.append(t);sHtml.append(k);
			sHtml.append(">");
			sHtml.append("<span class=\"spanX\" style=\"cursor:pointer;padding:2px 5px 2px 20px;\" ");
			sHtml.append("onClick=\"top.addTab('"+ModuleName+"',");
			//sHtml.append(i);
			//sHtml.append("',");
			sHtml.append("'<%=Function.getMultiLangItemContent((String) pageContext.getAttribute("strNameTemp"),
									request)%>',");
			sHtml.append("'<%=strContextPath%>/jsp/main/System.jsp',");
			sHtml.append("false,");
			sHtml.append("false,");
			sHtml.append("false,'");
			sHtml.append(treeBarURL);
			sHtml.append("','");
			sHtml.append(contentAreaURL);
			sHtml.append("');");
			
			sHtml.append("setCurrentColor('per");
			sHtml.append(i);sHtml.append(t);sHtml.append(k);
			sHtml.append("')\">");
			
			 <c:if test="${moduleBean.imageFile==''}">
			   sHtml.append("<img src=\"<%=strContextPath%>/images/item.gif\"");
			 </c:if>
			 <c:if test="${moduleBean.imageFile!=''}">
			   sHtml.append("<img src=\"<%=strContextPath%>/<c:out value="${moduleBean.imageFile}"/>\"");
			 </c:if>
			  
			sHtml.append("width=\"16\" height=\"18\" border=\"0\" align=\"absmiddle\">");
			sHtml.append("<%=Function.formatShortToHTML(Function.getMultiLangItemContent((String) pageContext
									.getAttribute("strNameTemp"), request), 30)%></span></td></tr>");
 					
		  	k++;
		</c:if>
	</c:forEach>

	sHtml.append("</table><br>");
    LeftAreaTr.innerHTML += sHtml.toString();
    var b=new Date();
    //alert(b.getTime()-a.getTime());
    sHtml=null;
}

function translateUrl(oldUrl) 
{
	var newUrl = '';
	var paraUrl = '';

	if (oldUrl == undefined || oldUrl == '')
	{
		return newUrl;
	}
	 
	if (oldUrl.indexOf('[') == -1 || oldUrl.indexOf(']') == -1) 
	{
		newUrl = oldUrl;
		return newUrl;
	} 
	else 
	{
		if (oldUrl.indexOf('?') != -1) 
		{
			newUrl = oldUrl.substring(0,oldUrl.indexOf('?')+1);
			if ((oldUrl.indexOf('?')+1) < oldUrl.length) 
			{
				paraUrl = oldUrl.substring(oldUrl.indexOf('?')+1,oldUrl.length);
			}
		} 
		else if (oldUrl.indexOf('&') != -1) 
		{
			newUrl = oldUrl.substring(0,oldUrl.indexOf('&')+1);
			if ((oldUrl.indexOf('&')+1) < oldUrl.length) 
			{
				paraUrl = oldUrl.substring(oldUrl.indexOf('&')+1,oldUrl.length);
			}
		} 
		else 
		{
			newUrl = oldUrl;
			return newUrl;
		}
				
		var para = paraUrl.split('&');
		var paraName='';
		var paraValue='';
		var tempValue='';
		for (var i=0;i<para.length;i++) 
		{
			if (para[i].indexOf('=[') == -1 || para[i].indexOf(']') == -1) 
			{
				newUrl = newUrl + '&' + para[i];
				continue;
			}
			
			paraName = para[i].substring(0,para[i].indexOf('=')+1);
			paraValue = para[i].substring(para[i].indexOf('[')+1,para[i].indexOf(']'));
			tempValue = '';
			if (paraName =='=' || paraValue =='') 
			{
				newUrl = newUrl + '&' + para[i];
				continue;
			}
			
			if (top.getPropertyValue != undefined) 
			{
				if (tempValue == '') 
				{
					tempValue = top.getPropertyValue(paraValue);
				}
				paraValue = tempValue;
			} 
			else if (top.win != undefined && top.win.top.getPropertyValue != undefined) 
			{
				paraValue = top.win.top.getPropertyValue(paraValue);
			} 
			else if (opener != undefined && opener.top.getPropertyValue != undefined) 
			{
				paraValue = opener.top.getPropertyValue(paraValue);
			} 
			else if (opener != undefined && opener.opener.top.getPropertyValue != undefined) 
			{
				paraValue = opener.opener.top.getPropertyValue(paraValue);
			} 
			else if (opener != undefined && opener.top.win != undefined && opener.top.win.top.getPropertyValue != undefined) 
			{
				paraValue = opener.top.win.top.getPropertyValue(paraValue);
			} 
			else 
			{
				
			}
			
			if (window.encodeURIComponent) 
			{
				paraValue = window.encodeURIComponent(paraValue);
			}
			
			if (newUrl.substring(newUrl.length-1,newUrl.length) != '?' && newUrl.substring(newUrl.length-1,newUrl.length) != '&') 
			{
				newUrl = newUrl + '&';
			}
			
			newUrl = newUrl + paraName + paraValue;
		}
		return newUrl;
	}
}

//重置Email发送的提醒信息
function resetOperatorEmailBarInfo(){
	emailManagerOperatorEmailOK = '<%=Function.getMultiLangItemContent("transactInfo", request)%>'+'<%=Function.getMultiLangItemContent("emailManager.send.OK", request)%>';
}

//得到小结树
function getSummaryTree(selectedIds){
	var summaryTree = new dTree2('summaryTree');
	summaryTree.config.useControl = true;
	summaryTree.config.useCookies = true;
	summaryTree.config.isDelayBuild = true;
	summaryTree.config.controlType = 'checkbox';
	summaryTree.config.correlateSelectType = 'node';
	if(nSummaryMode==1){
		summaryTree.config.controlType = 'radio';
	}
	selectedIds=","+selectedIds+",";
	// 添加节点
	summaryTree.add('0','-1','<%=Function.getMultiLangItemContent("summary.AllSummary", request)%>', 'true');
	//添加类型
	var type;
	var isChecked = false;
	try{
		if(summaryTreeList!=null){
			for(i=0; i<summaryTreeList.length; i++)
			{
				if(summaryTreeList[i].map.NTYPE == 1){
					type = 'true';
				}else{
					type = 'false';
				}
				if(selectedIds.indexOf(","+summaryTreeList[i].map.LID+",")>-1){
					isChecked = true;
				}else{
					isChecked = false;
				}
				
				summaryTree.add(summaryTreeList[i].map.LID,
								summaryTreeList[i].map.LPARENTID,
								summaryTreeList[i].map.STRNAME,
								type,
								isChecked,
								type,
								summaryTreeList[i].map.NSHOWINDEX);
			}
		}
	}catch(e){
	}
	return summaryTree;
}
	 
/*
function setStatusBarInfo(info)
{
	if (info != undefined && trim(info) != '') {
		if (statusTD != '') {
			clearTimeout(statusTD);
		}
		
		processMessage.style.display="block";
		statusBarInfo.style.display="block";
		statusBarInfo.innerHTML = info;
		statusTD = setTimeout('hideStatusBar();',5000);
	}
}
*/

function hideStatusBar()
{
	hideDiv('processMessage');
	statusTD = '';
}

function openSpecDialog(theURL,width,height,features)
{
	try{
		if(openedWindow!=null){
			openedWindow.close();
			openedWindow = null;
		}
	}catch(e){
		
	}
	
	var iTop = (top.window.screen.availHeight-30-630)/2;       //获得窗口的垂直位置;
    var iLeft = (top.window.screen.availWidth-10-750)/2;  
    
    if((width != "") && (width!=undefined)){
		 iLeft = (top.window.screen.availWidth-10-width)/2;
	}
	
	if((height != "") && (height!=undefined)){
		iTop = (top.window.screen.availHeight-30-height)/2;       //获得窗口的垂直位置;
	}
	
	features = features + ",top=" +iTop+",left="+iLeft;
	openedWindow = window.open(""+theURL+"",'',features);
}

function openSpec1Dialog(theName,theURL,width,height,features)
{
	try{
		if(theName!=null){
			theName.close();
			theName = null;
		}
	}catch(e){
		
	}
	
	var iTop = (top.window.screen.availHeight-30-630)/2;       //获得窗口的垂直位置;
    var iLeft = (top.window.screen.availWidth-10-750)/2;  
    
    if((width != "") && (width!=undefined)){
		 iLeft = (top.window.screen.availWidth-10-width)/2;
	}
	
	if((height != "") && (height!=undefined)){
		iTop = (top.window.screen.availHeight-30-height)/2;       //获得窗口的垂直位置;
	}
	
	features = features + ",top=" +iTop+",left="+iLeft;
	theName = window.open(""+theURL+"",'',features);
}

function openDialog(theURL,winName,features)
{

	window.open(""+theURL+"",winName,features);
}

function openShortcutDialog(theURL)
{
	
	var iTop = (top.window.screen.availHeight-30-500)/2;
    var iLeft = (top.window.screen.availWidth-10-650)/2;  
	openedWindow = window.open(""+theURL+"",'KeyboardShortcuts','width=650,height=500,left=scroll=auto,status=no,resizable=no,help=no,top='+iTop+',left='+iLeft);
}

function getUserId()
{
	return lUserId.value;
}

function getDeptId(){
	return lDeptId.value;
}

function getUserName()
{
	return strUserName.value;
}
function getIvrPath()
{
	var strIvrPath ="/jsp/media/ivr.jsp";
	return strIvrPath;
}
function getTenantId()
{
	return lTenantId.value;
}
function getIsDonntCallSetting(){
	if(strDonntCallSetting.value!='false')
		return true;
	else 
		return false;
}

function isAgent()
{
	if(nAgentFlag.value!="" && nAgentFlag.value > 0)
	{
		return true;
	}
	
	return false;
}

function isSupervisor()
{
	if(nSupervisorFlag.value!="" && nSupervisorFlag.value > 0)
	{
		return true;
	}
	
	return false;
}

function isPlanner()
{
	if(nPlannerFlag.value!="" && nPlannerFlag.value > 0)
	{
		return true;
	}
	
	return false;
}
var strExt = "${EXT}";


var strSkillGroupName="${STRSKILLGROUPNAME}";

var strPlaceName="${STRPLACENAME}";
function isLeader()
{
	if(nLeaderFlag.value!="" && nLeaderFlag.value > 0)
	{
		return true;
	}
	
	return false;
}

function getRemoteHostName()
{
	return strRemoteHostName.value;
}

function getRemotePort()
{
	return nRemotePort.value;
}

function getProudctType()
{
	return strProudctType.value;
}

function getWorkArea()
{
	if(top.mainIframe.mainCenter.contentFrame.mainIndex.workArea != undefined)
	{
		return top.mainIframe.mainCenter.contentFrame.mainIndex.workArea;
	}
	else
	{
		return top.mainIframe.mainCenter.contentFrame.mainIndex;
	}
}

function getLeftView(tabId)
{
	return top.mainIframe.mainCenter.contentFrame.mainIndex.leftView;
}

function getWorkArea_noLeft()
{
	return top.mainIframe.mainCenter.contentFrame.mainIndex;
}

function getStrUserInfo() {
	var str = '';
	str = '&lUserId=' + top.getUserId();
	str = str +'&lTenantId=' + top.getTenantId();
	//str = str +'&strUserName=' + top.getUserName();		
	return str;
}

var miniLayout = 0;
//初始化页面个部分大小
function initSize(){
	//alert(document.getElementById("topDiv").style.height);
	//document.getElementById("topDiv").style.height="95px";
	
	var bheight = document.documentElement.clientHeight-175-36;
	//alert(document.getElementById("topDiv").style.height);
	document.getElementById("mainIframe").style.height = bheight;
	//22是右侧标题的高度
	document.getElementById("floatRightDiv").style.height = bheight-22;
	document.getElementById("floatRightFrame").style.height = bheight-22;
	document.getElementById("menuTr").style.height = bheight-22;
	
	//页面宽度
	var bwidth  = document.documentElement.clientWidth;
	if(bwidth >375)
	{
		document.getElementById("marqueeMessage").style.width = bwidth-375;
	} 
	else
	{
		document.getElementById("marqueeMessage").style.width = 0;
	}
}

function toggleLayout(){ 

	if(miniLayout == 0){
		var bheight = document.documentElement.clientHeight-35-36;
			document.getElementById("topDiv").style.display = "none";
			document.getElementById("miniTopDiv").style.display = "";
			miniLayout = 1;
	}else{
		var bheight = document.documentElement.clientHeight-175-36;
			document.getElementById("topDiv").style.display = "";
			document.getElementById("miniTopDiv").style.display = "none";
			miniLayout = 0;
	}
	
	document.getElementById("mainIframe").style.height = bheight;
	document.getElementById("floatRightDiv").style.height = bheight-22;
	document.getElementById("floatRightFrame").style.height = bheight-22;
	document.getElementById("menuTr").style.height = bheight-22;
}

function setNormalLayout(){
	if (miniLayout == 1) {
		var bheight = document.documentElement.clientHeight-175-36;
		document.getElementById("topDiv").style.display = "";
		document.getElementById("miniTopDiv").style.display = "none";
		miniLayout = 0;
		document.getElementById("mainIframe").style.height = bheight;
		document.getElementById("floatRightDiv").style.height = bheight-22;
		document.getElementById("floatRightFrame").style.height = bheight-22;
		document.getElementById("menuTr").style.height = bheight-22;
	}
}

// 修改密码
function modifyPassword()
{ 
	var url = "<%=contextPath%>/jsp/PersonalFirstPage/personalinfoManager/content/modifyPassword.jsp?"+top.getStrUserInfo();
	openSpec1Dialog("modifyPass",url,500,350,'width=500px,height=200px,status:no,resizable:no,help:no');
}

function loadInfo()
{
	//拼构成能被menu.js文件里的addMenu()方法解析的快捷菜单的字符串
	initMenu('33',"",0);
	
	//初始化快捷菜单用到的
	var temp='';
	var image='';
	var flag='';
	<c:forEach var="notify" items="${notifyList}"  varStatus="status">
	temp=new StringBuffer("");
	image="<%=strContextPath%>/images/shortCut_09.gif";
	flag="<img src='' width='100%' height='1' style='background-color:#dadada'>";
    if(	"${notify.STRNAME}"==null||"${notify.STRNAME}"=="")
    {
    	//分隔符
    	//temp=flag+"_|_"+"${notify.LID}"+"_|_"+"";
    	temp.append(flag);
    	temp.append("_|_");
    	temp.append("${notify.LID}");
    	temp.append("_|_"); 
    	temp.append("");
    }
    else
    {
    	if(temp.toString().indexOf("<%=Function.getMultiLangItemContent((String) pageContext.getAttribute("notifyName"), request)%>"+"_|_"+"${notify.LID}"+"_|_"+"showUrl('${notify.STRURL}','${notify.LTYPEID}','${notify.STRWIDTH}','${notify.STRHEIGHT}','${notify.STRNAME}','${notify.LQUICKID}')")==-1){
	    	<c:set var="notifyName" value="${notify.STRNAME}" />
	    	if("${notify.STRIMAGENAME}"!=null&&"${notify.STRIMAGENAME}"!="")
	    	{
	    		image="<%=strContextPath%>/images/<c:out value='${notify.STRIMAGENAME}'/>";
	    
	    	}
		 	
		 	temp.append("<img src=");
		 	temp.append(image);
		 	temp.append(" border='0' align='absMiddle'> ");
		 	temp.append("<%=Function.getMultiLangItemContent((String) pageContext.getAttribute("notifyName"), request)%>"+"_|_"+"${notify.LID}"+"_|_"+"showUrl('${notify.STRURL}','${notify.LTYPEID}','${notify.STRWIDTH}','${notify.STRHEIGHT}','${notify.STRNAME}','${notify.LQUICKID}')");
		}
	}
	if("${notify.LTYPEID}"=="0")
    {
    	if(top.isExistedPermission("${notify.STRPERMISSION}"))
		{
			//addMenu里第二个参数是决定位置的
			addMenu(temp.toString(),"${notify.LID}");
		}
	}
	else
	{
		addMenu(temp.toString(),"${notify.LID}");
	}
	temp=null;
	image=null;
	flag=null;
	</c:forEach>
	image="<%=strContextPath%>/images/shortCut_08.gif";
    
	if (top.strProductId!='Contact')
	{
		top.hideWaitingPage();
	}
	viewTime();
	//取得queue的值
	strStatServerAvailableThisPage=1;	//IPCC-275
	if (strProductId == 'Contact') {
		if(strStatServerAvailableThisPage == '1'){
			strQueue.style.display="block";
			//initQueueShow('http://<%=request.getRemoteHost()%>:<%=request.getLocalPort()%><%=request.getContextPath()%>');
		}
	}
	else if (strProductId == 'AdminCenter') {
		if('<c:out value="${LDEPTCOUNT}"/>' == '0' &&  '<c:out value="${LEMPCOUNT}"/>' == '0' &&  '<c:out value="${LAGENTGROUPCOUNT}"/>' == '0'){
			var url = "<%=contextPath%>/jsp/ParameterManager/ReverseSynCTI/reverseSynLoginCTIDialog.jsp";
			openSpec1Dialog("syncEZActor",url,500,250,'width=500px,height=250px,status:no,resizable:no,help:no');
		}
	}
	image=null;
}

//执行loadInfo之后执行makeTree
function makeTree(){
	document.all.mainIframe.src = '<%=strContextPath%>/jsp/main/mainIframe.jsp?strProductId=<c:out value="${strProductId}"/>';
}

function showUrl(url,lTypeId,width,height,name,lQuickId)
{
	if(width==''||width==null)
		width=650;
	if(height==''||height==null)
		height=500;
	//应用功能打开Dialog
	if(lTypeId==0)
	{
		if(url=="logout")
		{
			logoutProduct();
			return;
		}
		else
		{
			url+="lTenantId=" + top.getTenantId() + "&lUserId=" + top.getUserId()+"&strUserName="+ top.getUserName();
		}
		openDialogUrl(url,width,height);
	}
	//业务功能加标签
	else if(lTypeId==1)
	{
		top.addTab(lQuickId, name,'<%=strContextPath%>/jsp/BusinessExec/BusinessPage.jsp',true,false,true);
	}
}

function openDialogUrl(theURL,width,height)
{
	var iTop = (top.window.screen.availHeight-30-height)/2;
    var iLeft = (top.window.screen.availWidth-10-width)/2;  
	openedWindow = window.open(""+theURL+"",'','width='+width+',height='+height+',left=scroll=auto,status=no,resizable=yes,help=no,top='+iTop+',left='+iLeft);
}

function confirmLogoutProduct()
{
	if(manualFlag == 0)
	{
		event.returnValue = "<%=Function.getMultiLangItemContent("logout.confirm", request)%>";
	}
}

function logoutProduct(flag)
{
	if(flag != 'sysclose')
	{
		if(!confirm('<%=Function.getMultiLangItemContentExt("logout.confirm", request)%>'))
		{
			//用户取消删除操作
			return;
		}
	}
	if(isLogout==false)
	{
		if(strProductId=="Contact")
		{
			
			try
			{
				if (!isInit()) {
					alert(strAgentHasOtherBusiness);
					return;
				}
			}catch(e){
			}
			
						
			try
			{
				if(false)
				{
					
					var strChannel = "";
					if(top.isPhoneIdle()==false)
					{
						strChannel+="<%=Function.getMultiLangItemContent("common.channel.telephone", request)%>  ";
					}
					
					if(top.isEmailIdle()==false)
					{
						strChannel+="<%=Function.getMultiLangItemContent("common.channel.email", request)%>  ";
					}
					
					if(top.isChatIdle()==false)
					{
						strChannel+="<%=Function.getMultiLangItemContent("common.channel.chat", request)%>  ";
					}
					
					alert(strChannel + "<%=Function.getMultiLangItemContent("logout.contactnotfinish", request)%>");
					
					return;
				}
			}catch(e){}
			
			try{
				//top.changeAgentStateInCache("loginout");
			}catch(e){
			
			}
		}
		isLogout = true;
		var strForward = "";
		if(strProductId=="AdminCenter")
		{
			strForward = "/jsp/blank.jsp";
		}
		else if(strProductId=="Contact")
		{
			strForward = "/jsp/blank.jsp";
			
			try
			{
				// 登出软电话

				//top.doLogout();
			}catch(e){}
		}
		else if(strProductId=="Campaign")
		{
			strForward = "/jsp/blank.jsp";
		}
		
		var buf=new StringBuffer("");
		buf.append("<%=contextPath%>/logoutAction.do?strProductId=");
		buf.append(strProductId);
		buf.append("&forward=");
		buf.append(strForward);
		buf.append("&lPlaceCTIId=");
		buf.append(lPlaceCTIId.value);
		buf.append("&lTenantId=");
		buf.append(top.getTenantId());
		buf.append("&lUserId=");
		buf.append(top.getUserId());
		buf.append("&strUserName=");
		buf.append(top.getUserName());
		buf.append("&targetUserId=");
		buf.append(top.targetUserId);
		layout_hiddenSubmitIFrame.location.href = buf.toString();
		manualFlag = 1;
		buf=null;
		window.close();
	}
}

function closeFloatRight(){
	if(isPinFloat==false){
		hideDiv('floatRightDiv');
		document.getElementById("floatRightPad").style.visibility = "hidden";
	}
	else{
		document.getElementById("sensorRight").style.width = 24;
		document.getElementById("floatRightDiv").style.marginLeft = -200;
		hideDiv('floatRightDiv');
		document.getElementById("floatRightPad").style.visibility = "hidden";
		isPinFloat = false;
	}
	try{
		document.getElementById("floatRightFrame").src = "about:blank";
	}catch(e){}
}

function canHideDiv(divId){
	if(isPinFloat==false){
		hideDiv(divId)
	}else
	{
		return false;
	}
}

//订住右侧边条
function pinFloat()
{
	if(isPinFloat == false){
		document.getElementById("sensorRight").style.width = 224;
		document.getElementById("floatRightDiv").style.marginLeft = 0;
		document.getElementById("pinPic").src = "<%=strContextPath%>/images/right/st_release.gif";
		document.getElementById("pinPic").alt = "<%=Function.getMultiLangItemContent("lable.rightBoard.floatTip", request)%>";
		if(isMesFloat == 0){document.getElementById("popTable1").style.width = mainIframe.frames[1].document.body.clientWidth;}
		isPinFloat = true;
	}
	else{
		document.getElementById("sensorRight").style.width = 24;
		document.getElementById("floatRightDiv").style.marginLeft = -200;
		document.getElementById("pinPic").src = "<%=strContextPath%>/images/right/st_pin.gif";
		document.getElementById("pinPic").alt = "<%=Function.getMultiLangItemContent("lable.rightBoard.pinTip", request)%>";
		if(isMesFloat == 0){document.getElementById("popTable1").style.width = mainIframe.frames[1].document.body.clientWidth;}
		isPinFloat = false;
	}
}

function changeSrc(target,url){
	document.getElementById(target).src = url;
}


//跑马灯
function marqueeDBclick(){
	if(marqueeFlag == 1){ 
		document.getElementById("marqueeMessage").start();
		document.getElementById("marqueeStatSign").src = "<%=contextPath%>/images/ban_bottom_light_green.gif";
		document.getElementById("marqueeStatSign").alt = "<%=Function.getMultiLangItemContent("Marquee.new.end", request)%>";
		marqueeFlag = 0;
	}
	else { 
		document.getElementById("marqueeMessage").stop(); 
		document.getElementById("marqueeStatSign").src = "<%=contextPath%>/images/ban_bottom_light.gif";
		document.getElementById("marqueeStatSign").alt = "<%=Function.getMultiLangItemContent("Marquee.new.start", request)%>";
		marqueeFlag = 1;
	}
}
function marqueeMouseOut(){
	if(marqueeFlag == 1)
	{
		return false;
	}
	else{
		document.getElementById("marqueeMessage").start();
	}
}
function marqueeMouseOver(){
	if(marqueeFlag == 1){
		return false;
	}
	else{
		document.getElementById("marqueeMessage").stop();
	}
}
 
// 判断角色是否存在
function isExistedRole(strRole)
{
	if(strRole==undefined || strRole=="" || strRole==null)
	{
		return false;
	}
	
	if(eval("top.r_" + strRole + "==true"))
	{
		return true;
	}
	
	return false;
}

// 判断是否存在改权限
var notVerifyPermissionFlag=false;
function isExistedPermission(strPermission)
{
	if (notVerifyPermissionFlag) {
		return true;
	}
	if(strPermission==undefined || strPermission=="" || strPermission==null)
	{
		return false;
	}
	
	if(eval("top.g_" + replaceAll(strPermission, ".", "_") + "==true"))
	{
		return true;
	}
	
	return false;
}

function getPropertyValueByName(strKey)
{
	var textInputs = document.getElementsByTagName("INPUT");
	for(var i=0;i<textInputs.length;i++){
		if(strKey===textInputs[i].name){
			return textInputs[i].value;
		}
	}
	try
	{
		var propValue =  eval("top."+strKey);
		if (propValue != 'undefined' && propValue != null) 
		{
			return propValue;
		}
		else
		{
			return "";
		}
	}
	catch(e)
	{
		return "";
	}
}

function getPropertyValue(strKey)
{
	var propValue = null;
	var keyElement = document.getElementById(strKey);
	if(typeof keyElement=== 'undefined' || keyElement === null)
	{
		propValue = propValue = getPropertyValueByName(strKey);
	}else
	{
		try
		{
			propValue = keyElement.value;
		}
		catch(exp)
		{
			propValue = getPropertyValueByName(strKey);
		}
	}
	return propValue;
}

//以下三个是关于布局管理器的layout icon
function shLeft(){
	if(mainIframe.mainFrame.cols == "200,*"){
		mainIframe.mainFrame.cols = "0,*";
		mainIframe.mainFrame.frameSpacing = "0";
	}
	else{
		mainIframe.mainFrame.cols = "200,*";
		mainIframe.mainFrame.frameSpacing = "3";
	}
}

function shRight(){
	showHideDiv('sensorRight');
}

function shFloat(divId){
	showHideDiv(divId);
	if(isMesFloat == 1)
	{
		//浮动时直接控制
	}
	else{
		//嵌入到frame里
		if(isMesFloat == 0){
			mainIframe.centerContentFrame.rows = "0,*,"+mainIframe.frames[3].document.body.clientHeight+"";
			isMesFloat = 2;
			return false;
		}
		if(isMesFloat == 2){
			mainIframe.centerContentFrame.rows = "150,*,"+mainIframe.frames[3].document.body.clientHeight+"";
			isMesFloat = 0;
			return false;
		}
	}
}

function openHung(url){
	document.getElementById("hungDiv").style.height = "173px";
	document.getElementById("hungDiv").style.marginTop = "-150px";
	document.getElementById("hungIframe").style.height = "150px";
	document.getElementById("hungIframe").src = url;
	for(i=1;i<4;i++){document.getElementById("testTd"+i).className = "testTd2";}
	event.srcElement.className = "testTd1";
}

function closeHung(){
	document.getElementById("hungDiv").style.height = "23px";
	document.getElementById("hungDiv").style.marginTop = "0px";
	document.getElementById("hungIframe").style.height = "0px";
}

function ocHung(){
	if(document.getElementById("hungIframe").style.height < "100px"){
		document.getElementById("hungDiv").style.height = "173px";
		document.getElementById("hungDiv").style.marginTop = "-150px";
		document.getElementById("hungIframe").style.height = "150px";
		if(document.getElementById("hungIframe").src == ""){
			document.getElementById("hungIframe").src = "common/11.htm";
		}
	}
	else{
		document.getElementById("hungDiv").style.height = "23px";
		document.getElementById("hungDiv").style.marginTop = "0px";
		document.getElementById("hungIframe").style.height = "0px";
	}
}

function addQuick(temp,lId)
{    
	addMenu(temp,lId);
}

function delQuick(lId)
{
	delMenu(lId,'');
}

function showCanShowMarquee(str){
	try{
		document.getElementById("marqueeMessage").innerHTML = unescape(str);
	}catch(e){
	}
}

function putLeftTreeContent(i,name,url,image,lefturl,workurl,refleshFlag)
{
	//是刷新
    var flag=false;
   	lefturl = '<%=strContextPath%>/' + lefturl;
	
   	if (workurl != '') {
   		workurl = '<%=strContextPath%>/' + workurl;
   	}
   	if(refleshFlag==1)
   	{
   	flag=true;
   	}
 	
 	if(strProductId=="Contact")
	{
		document.getElementById("leftTree").innerHTML +="<tr><td><span class=\"spanX\" style=\"cursor:pointer;padding:2px 5px;padding-left:25px;\" onClick=\"top.addTab('"+name+"','"+name+"','"+url+"','"+flag+"',false,false,'"+lefturl+"','"+workurl+"')\"><img src=\""+image+"\"  border=\"0\" align=\"absmiddle\"> "+ name+"</span></td></tr>";
	}
	else if(strProductId=="AdminCenter")
	{	    	    	    	
	   				
    }
	else
	{
		document.getElementById("leftTree").innerHTML +="<tr><td><span class=\"spanX\" style=\"cursor:pointer;padding:2px 5px;padding-left:25px;\" onClick=\"top.addTab('"+name+"','"+name+"','"+url+"','"+flag+"',false,false,'"+lefturl+"','"+workurl+"')\"><img src=\""+image+"\"  border=\"0\" align=\"absmiddle\"> "+ name+"</span></td></tr>";
	}  	
}

function openSMSDialog(){
	window.open('<%=strContextPath%>/jsp/SMSManager/sms/addSMS.jsp?lUserId='+top.getUserId()+'&lTenantId='+top.getTenantId()+'&strUserName='+top.getUserName(),'sms','width=540px,height=480px');//,status:no,resizable:no,help:no');
}

/**
  *以下由Alex添加
**/
//brook负责修改了首页，如果是campaign则进入欢迎页面
var bCampaignIndexShowed = false;
function loadFirstPage()
{	
	if(strProductId == 'Campaign' && bCampaignIndexShowed == false)
	{
		//默认显示运行中的项目
		addTab('CampaignFrameWorkIndexPage','welcome','<%=strContextPath%>/jsp/ProgramManager/workArea.jsp',false,false);
		bCampaignIndexShowed = true;
	}
}

//如果没有权限那么右边快捷菜单将是不可见的
function setMenuPermission()
{
	//hasSetQuickPermission = isExistedPermission("System.PersonFirstPage.SetPerference");
	//if (hasSetQuickPermission) {
		menuEntry.style.display = "";
	//}
}
//Alex添加的上面的部分结束了

function rightBoard(url,rightBoardWord,from){
	//直接显示内容而不需要通过iframe
	if(from=="quikMenu")
	{
		//权限控制
		//if (!hasSetQuickPermission)
		//	return;
			
		document.getElementById("frameTr").style.display ="none";
		document.getElementById("floatRightFrame").src = "";
			
		//未打开状态下-将其打开
		if(document.getElementById("floatRightDiv").style.display =="none"){
			document.getElementById("rightBoardWord").innerText = rightBoardWord;
			document.getElementById("floatRightDiv").style.display ="";
			document.getElementById("menuTr").style.display="";
			
			document.getElementById("floatRightPad").style.left = document.getElementById("floatRightDiv").offsetLeft;
			document.getElementById("floatRightPad").style.top = document.getElementById("floatRightDiv").offsetTop;
			document.getElementById("floatRightPad").style.width = document.getElementById("floatRightDiv").offsetWidth;
			document.getElementById("floatRightPad").style.height = document.getElementById("floatRightDiv").offsetHeight;
			document.getElementById("floatRightPad").style.visibility = "visible";
			
			
		}else{//打开状态下
				//再次点击-将其关闭
			if(document.getElementById("rightBoardWord").innerText == rightBoardWord)
			{
				document.getElementById("floatRightDiv").style.display ="none";
				document.getElementById("menuTr").style.display="none";
				document.getElementById("rightBoardWord").innerText = "";
				closeFloatRight();
			}else{
				document.getElementById("rightBoardWord").innerText = rightBoardWord;
				document.getElementById("menuTr").style.display="";
			}
		}
	}//通过iframe显示
	else 
	{
		document.getElementById("menuTr").style.display="none";
		
		//未打开的状态下——打开平台
		if(document.getElementById("floatRightDiv").style.display =="none"){
			document.getElementById("floatRightFrame").src = url;
			document.getElementById("frameTr").style.display ="";
			document.getElementById("floatRightDiv").style.display ="";
			document.getElementById("rightBoardWord").innerText = rightBoardWord;
			document.getElementById("floatRightPad").style.left = document.getElementById("floatRightDiv").offsetLeft;
			document.getElementById("floatRightPad").style.top = document.getElementById("floatRightDiv").offsetTop;
			document.getElementById("floatRightPad").style.width = document.getElementById("floatRightDiv").offsetWidth;
			document.getElementById("floatRightPad").style.height = document.getElementById("floatRightDiv").offsetHeight;
			document.getElementById("floatRightPad").style.visibility = "visible";
		}else//已打开的状态下 
		{
			//点击本身则关闭平台
			if(document.getElementById("rightBoardWord").innerText == rightBoardWord){
				document.getElementById("frameTr").style.display ="none";
				document.getElementById("floatRightDiv").style.display ="none";
				document.getElementById("floatRightFrame").src = "about:blank";
				document.getElementById("rightBoardWord").innerText = "";
				closeFloatRight();
			}else{//点击了另一个则切换平台中的内容
				document.getElementById("floatRightFrame").src = url;
				document.getElementById("frameTr").style.display ="";
				document.getElementById("rightBoardWord").innerText = rightBoardWord;
			}
		} 
	}
}

//显示备忘录到期提醒,add by Susan 20060403
//参数说明：nLogin或者为0或者非0，当为0时说明是刚刚登录时的提醒，非0说明是用户使用产品期间有新的信息提醒
//        nExpireMemoCount：信息提醒的条数  

//显示任务提醒,add by Kevin 20071009   
function showRole(nLogin,nExpireRoleCount)
{  
	expireRoleCount=nExpireRoleCount;
	allFinished('Task',nLogin,nExpireRoleCount);
}
//显示事件提醒,add by Kevin 20071009   
function showEvent(nLogin,nExpireEventCount)
{  
	expireEventCount=nExpireEventCount;
	allFinished('Event',nLogin,nExpireEventCount);
}
function showMemo(nLogin,nExpireMemoCount)
{  
	expireMemoCount=nExpireMemoCount;
	allFinished('Memo',nLogin,nExpireMemoCount);
}
//显示一般信息提醒,add by Susan 20060405   
function ShowGeneralMessage(nLogin,nExpireGeneralMsgCount)
{
	expireGeneralMsgCount=nExpireGeneralMsgCount;	
  	
	allFinished('GeneralMessage',nLogin,nExpireGeneralMsgCount);
}
//显示一般提醒
function showRemind(nLogin,strRemindInfo)
{
	allFinished('Remind',nLogin,strRemindInfo);
}

//显示公告栏提醒,add by Susan 20060405   
function showBulletin(nLogin,nExpireBulletinCount)
{   
  	expireBulletinCount=nExpireBulletinCount;
  	
  	allFinished('Bulletin',nLogin,nExpireBulletinCount);	
}
//通话超时提醒
function showOverTime(strParameter,typeId)
{   
	var strContext;
	
  	if(document.getElementById("divShowReminder").style.display=="none")
    {    	
    	iframe_showReminder.removeRow();
    }  
    if(typeId == 'talking'){
		strContext = '<%=Function.getMultiLangItemContent("GeneralManager.overTime.TalkingRemind.toAgent", request)%>' + strParameter + '<%=Function.getMultiLangItemContent("GeneralManager.overTime.Seconds", request)%>';
	}else if(typeId == 'holding'){
		strContext = '<%=Function.getMultiLangItemContent("GeneralManager.overTime.HoldRemind.toAgent", request)%>' + strParameter + '<%=Function.getMultiLangItemContent("GeneralManager.overTime.Seconds", request)%>';
	}
	iframe_showReminder.alertOverTime(strContext);	
	showPlace();   	
	//窗口显示时间限制	
	timeLimit();
}

function allFinished(infoType,nLogin,nExpireCount)
{   
    if(nLogin!=0&&document.getElementById("divShowReminder").style.display=="none")
    {    	
    	iframe_showReminder.removeRow();
    }  

	iframe_showReminder.preProcess(infoType,nLogin,nExpireCount);	
	showPlace();   	
	//窗口显示时间限制	
	timeLimit();
}

function timeLimit()
{			
	if(timerID_!=null)
	{
		clearTimeout(timerID_);
	}
		
	timerID_=setTimeout('noDisplay()',15000); 	
}
//提示框不消失 add by Alex
function closeTimeLimit()
{			
	if(timerID_!=null)
	{
		clearTimeout(timerID_);
	}
}
//test sean
function noDisplay()
{	    
	document.getElementById("divShowReminder").style.display="none";
}

function showPlace()
{
	//debugger;
	if(true){
		document.getElementById("divShowReminder").style.top  = document.documentElement.clientHeight - 125;
		document.getElementById("divShowReminder").style.left = document.documentElement.clientWidth - 302;
		document.all.divShowReminder.style.display="block";
	}
}

//处理加载顺序的事件
function getTreeDistrictNotice(){
	var a = parseInt(document.all.span_report_ele.value,10);
	var b = parseInt(document.all.span_report_tree.value,10);
	var rsb = (a===1)&&(b===1);
	if(rsb){
		getLeftTree();
		document.all.mainIframe.contentWindow.leftTreeFrame.loadinfo();
		//document.all.mainIframe.leftTreeFrame.contentWindow.loadInfo();
	}
}

//生成campaign的树
function generateCampaignTree(){
	//初始化campaign的树
	campaignTree = new dTree('campaignTree');
	campaignTree.config.useCookies = true;
	// 不使用点击节点收缩树结构
	campaignTree.config.folderLinks = true;
	// 添加campaign树节点
	campaignTree.add('0','-1','', 'true', '', '', '');
	<c:forEach  var="campaignTreeNode" items="${campaignlist}">
		var lCampaignId='<c:out value="${campaignTreeNode.LID}"/>';
		var strCampaignName='<c:out value="${campaignTreeNode.STRNAME}"/>';
		var strTag='campaign'+lCampaignId;
		var strUrl='<%=strContextPath%>/jsp/BusinessExec/BusinessPage.jsp';
		   
		campaignTree.add('<c:out value="${campaignTreeNode.LID}"/>',
						 '<c:out value="${campaignTreeNode.LPARENTID}"/>',
						 '<c:if test="${campaignTreeNode.NTYPE==1}"><c:if test="${campaignTreeNode.LID==1}"><%=Function.getMultiLangItemContent("campaign.state.designCampaign", request)%></c:if><c:if test="${campaignTreeNode.LID==2}"><%=Function.getMultiLangItemContent("campaign.state.startupCampaign", request)%></c:if><c:if test="${campaignTreeNode.LID==3}"><%=Function.getMultiLangItemContent("campaign.state.closedownCampaign", request)%></c:if></c:if><c:if test="${campaignTreeNode.NTYPE!=1}"><c:out value="${campaignTreeNode.STRNAME}"/></c:if>',
						 '<c:if test="${campaignTreeNode.NTYPE==1}">true</c:if>',
						 '',
						 '',
						 '<c:if test="${campaignTreeNode.NTYPE==1}">javascript: top.addTab(\'' + '<c:out value="${campaignTreeNode.LID}"/>&nState='+'<c:out value="${campaignTreeNode.NSTATE}"/>'+ "', " + '\'' + '<c:if test="${campaignTreeNode.NTYPE==1}"><c:if test="${campaignTreeNode.LID==1}"><%=Function.getMultiLangItemContent("campaign.state.designCampaign", request)%></c:if><c:if test="${campaignTreeNode.LID==2}"><%=Function.getMultiLangItemContent("campaign.state.startupCampaign", request)%></c:if><c:if test="${campaignTreeNode.LID==3}"><%=Function.getMultiLangItemContent("campaign.state.closedownCampaign", request)%></c:if></c:if><c:if test="${campaignTreeNode.NTYPE!=1}"><c:out value="${campaignTreeNode.STRNAME}"/></c:if>' + '\'' + ","+'\''+"<%=strContextPath%>/jsp/CampaignManage/qryCampaignList.jsp"+'\''+","+"true"+","+"false"+","+"true"+');</c:if><c:if test="${campaignTreeNode.NTYPE==0}">javascript: top.addTab(\'' + '<c:out value="${campaignTreeNode.LID}"/>'+ "', " + '\'' + '<c:out value="${campaignTreeNode.STRNAME}"/>' + '\'' + ","+'\''+"<%=strContextPath%>/jsp/CampaignManage/qryCampaign.jsp"+'\''+","+"true"+","+"false"+","+"true"+');</c:if>');
	</c:forEach>
}

function run(){
	//加载到这里立刻执行的
	initJsonrpcObject('<%=request.getContextPath()%>');
	
	//var d4= new Date();
	
	//var d5= new Date();
	//alert(d5.getTime()-d4.getTime());
	
	//根据产品的不同隐藏各自的div元素
	if(strProductId=="AdminCenter")
	{       		
		hideDiv('sensorRight');
	    hideDiv('layoutChangeIcon');
	}
	if(strProductId=="Campaign")
	{       		
		//生成campaign的树
		generateCampaignTree();
		hideDiv('sensorRight');
		hideDiv('layoutChangeIcon');
	}
	initSize();
			
	
		
	//生成导航栏
	makeTree();
		
	//按照权限来决定是否显示快捷菜单
	setMenuPermission();
	//如果是contact则显示右侧快捷菜单和底部左边的按钮
	isContactShowRightMenuAndBottomLeft();	
	//if(strProductId=="Contact")
	{       		
		initContactService();
	}	
	
	loadInfo();	
	setInterval("validateEmployee()",20000);
	setTimeout("validateTime()", 30000);
}

function initContactService(){
	//初始化提醒信息的JS文件
	initRemindInfoJs('<%=request.getContextPath()%>','<c:out value="${LTENANTID}"/>','<c:out value="${LUSERID}"/>','<c:out value="${STRUSERNAME}"/>','<%=request.getRemoteHost()%>','<%=request.getRemotePort()%>',strProductId,'<%=request.getLocale().toString()%>');
	//得到提醒信息
	getRemindInfo();
	//超时设置信息放入缓存
	jsonrpc.asm.setCallback(afterSetCallBack,true);
	//jsonrpc.asm.getOverTimeSetting(afterGetOverTimeSetting,'<c:out value="${LTENANTID}"/>','<c:out value="${LUSERID}"/>','<c:out value="${STRUSERNAME}"/>');
	//加载联络状态
	//jsonrpc.asm.getContactStatusInfoMapByType(afterGetContactStatusInfoMapByType,'<c:out value="${LTENANTID}"/>','<c:out value="${LUSERID}"/>','<c:out value="${STRUSERNAME}"/>','<%=request.getLocale().toString()%>');
}

function afterSetCallBack(){ 
    //do nothing 
} 

function afterGetOverTimeSetting(result,exception){
	//nothing to do!
}

function afterGetContactStatusInfoMapByType(result,exception){
	if(result != null){
		var allContactStatus = result.map;
		//在页面中放置全部的联络状态
		setAllCode(allContactStatus);
	}
}

function validateEmployee()
{
	var flag = jsonrpc.asm.validateEmployee(getTenantId(),getUserId(),strProductId,true);
}


function validateTime()
{
	jsonrpc.asm.setCallback(afterSetCallBack, true);
	jsonrpc.asm.validateTime(validateTimeResp, new Date().getTime());
}

function validateTimeResp(result,exception)
{
	if(result!="OK")
	{
		var myTime = new Date();
		var systemTime = new Date(result * 1);

		var msg = '<%=Function.getMultiLangItemContent("TimeCheckAlert", request)%>';
		var msg1 = '<%=Function.getMultiLangItemContent("TimeCheckAlert.yourTime", request)%>';
		var msg2 = '<%=Function.getMultiLangItemContent("TimeCheckAlert.systemTime", request)%>';
		alert(msg+"\r"+msg1+myTime+"\r"+msg2+systemTime);
	}
	setTimeout("validateTime()", 600000);	
}


function getEnterTime()
{
return EnterTime.value;
}
//document.oncontextmenu = function() {event.returnValue = false;}

var d3= new Date();

function callCallbackFunctions(funcName) {
    var mc = top.mainIframe.mainCenter;
    var frms = mc.frames;
    for(var k=1;k<frms.length;k++){
    	var iWin = frms[k].document.getElementById("mainIndex");
     	try{
    		eval("iWin.contentWindow."+funcName+"();");
    	}catch(e){
    		//alert(e.message);
    	}
    }
}

var businessDictionary = new ActiveXObject("Scripting.Dictionary");
var businessTabDictionary = new ActiveXObject("Scripting.Dictionary");
var businessTabDictionaryTemp = new ActiveXObject("Scripting.Dictionary");

function findBusinessId(attachedKeys,attachedValues)
{
	var targetBusinessId = top.lPresetOutboundBusinessId;
	if(attachedKeys !=null)
	{
		for(var i in attachedKeys)
		{
			if(attachedKeys[i] == "lBusinessId")
			{
				targetBusinessId = attachedValues[i];
				break;
			}
		}
	}
	return targetBusinessId;
}

function isScriptBusiness(lBusinessId)
{
	try
	{
		var urlType = jsonrpc.contactManager.getBusinessURLType(lBusinessId,0,0,"Admin");
		if(urlType ===4)
		{
			return true;
		}
		return false;
	}catch(e)
	{// should be consider more
		return false;
	}
	
}

var setDnReady = Inject(setDnReady,
	function(type)
	{
		if(type==0)
		{
			if(businessDictionary.Count > 0)
			{
				alert("<%=Function.getMultiLangItemContent("softphone.setdnready.after.wrapup", request)%>");
				return 'IPCC_STOP_FUNCTION';
			}
		}
	},null);


var makeNewCallForOutboundOrInternal = Inject(makeNewCallForOutboundOrInternal,
	function(phoneNumber,lineId,attachedKeys,attachedValues,isOubound)
	{
		var targetBusinessId = findBusinessId(attachedKeys,attachedValues);
		if(businessDictionary.Exists(targetBusinessId))
		{
			alert("<%=Function.getMultiLangItemContent("softphone.outbound.after.wrapup", request)%>");
			return 'IPCC_STOP_FUNCTION';
		}
		if(businessTabDictionaryTemp.Exists(targetBusinessId))
		{
			businessTabDictionaryTemp.Remove(targetBusinessId);
		}
		businessTabDictionaryTemp.Add(targetBusinessId,top.tabArray.strCurrentTabId);
	},null
	);


var addTab = Inject(addTab,
	function(tabId,text,url,isRefresh,disableClose,isBusiness)
	{
		if(isBusiness)
		{
			if(businessDictionary.Exists(tabId))
			{
				if(businessTabDictionaryTemp.Exists(tabId))
				{
					alert("<%=Function.getMultiLangItemContent("softphone.outbound.after.wrapup", request)%>");
				}
				else
				{
					focusTab(tabId);
					alert("<%=Function.getMultiLangItemContent("softphone.reopen.business.after.wrapup", request)%>");
				}
				
				return 'IPCC_STOP_FUNCTION';
			}
			
			if(isScriptBusiness(tabId) == true)
			{
				businessDictionary.Add(tabId,tabId);	
			}
			
			if(businessTabDictionaryTemp.Exists(tabId))
			{
				var lastTabId = businessTabDictionaryTemp.Item(tabId);

				businessTabDictionaryTemp.Remove(tabId);

				if(businessTabDictionary.Exists(tabId))
				{
					businessTabDictionary.Remove(tabId);
				}

				businessTabDictionary.Add(tabId,lastTabId);
			}			
		}
	},null);

var closeTab = Inject( closeTab,goBackHistory,null);

function goBackHistory()
{
   var currentTab = top.tabArray.strCurrentTabId;
   
   if(businessDictionary.Exists(currentTab))
   {
		businessDictionary.Remove(currentTab);
   		callCallbackFunctions('onAgentScriptFinishedCallback');
   		closeScript_and_focus_next(currentTab);
   }
   
   if(businessTabDictionary.Exists(currentTab)) 
   {
   		var callerTab = businessTabDictionary.Item(currentTab);
   		callCallbackFunctions('onAgentScriptFinishedCallback');
		closeScript(currentTab);
      	businessTabDictionary.remove(currentTab);
      	focusTab(callerTab);
      	return 'IPCC_STOP_FUNCTION';
    }
 }

function goBackHistoryAndReady()
{
   var currentTab = top.tabArray.strCurrentTabId;
   
   if(businessDictionary.Exists(currentTab))
   {
		businessDictionary.Remove(currentTab);
   		callCallbackFunctions('onAgentScriptFinishedCallback');
   		closeScript_and_focus_next(currentTab);
   		setDnReady(0);
   }
   
   if(businessTabDictionary.Exists(currentTab)) 
   {
   		var callerTab = businessTabDictionary.Item(currentTab);
   		callCallbackFunctions('onAgentScriptFinishedCallback');
		closeScript(currentTab);
      	businessTabDictionary.remove(currentTab);
      	focusTab(callerTab);
      	return 'IPCC_STOP_FUNCTION';
    }
 }
</script>
</head>

<body scroll="no" border="no" onbeforeunload="confirmLogoutProduct();"  onload="t_queue.style.top = t_queue.offsetTop + 5;" onunload="logoutProduct('sysclose');">
<!-- 隐藏变量 -->
<input name="lUserId" type="hidden" value="<c:out value="${LUSERID}"/>" />
<input name="strUserName" type="hidden" value="<c:out value="${STRUSERNAME}"/>" />
<input name="lTenantId" type="hidden" value="0" />
<input name="lDeptId" type="hidden" value="<c:out value="${LALEXDEPTID}"/>" />
<input name="strDonntCallSetting" type="hidden" value="<c:out value="${STRDONNTCALLSETTING}"/>" />
<input name="strRemoteHostName" type="hidden" value="<%=request.getRemoteHost()%>" />
<input name="strProudctType" type="hidden" value="<c:out value="${strProductId}"/>" />
<input name="strStafferId" type="hidden" value="<c:out value="${STRSTAFFERID}"/>" />
<input name="nAgentFlag" type="hidden" value="<c:out value="${NAGENTFLAG}"/>" />
<input name="nSupervisorFlag" type="hidden" value="<c:out value="${NSUPERVISORFLAG}"/>" />
<input name="nPlannerFlag" type="hidden" value="<c:out value="${NPLANNERFLAG}"/>" />
<input name="nLeaderFlag" type="hidden" value="<c:out value="${NLEADERFLAG}"/>" />
<input name="lPersonCTIId" type="hidden" value="<c:out value="${LPERSONCTIID}"/>" />
<input name="lPlaceCTIId" type="hidden" value="<c:out value="${LPLACECTIID}"/>" />
<input name="strPlaceName" type="hidden" value="<c:out value="${STRPLACENAME}"/>" />
<input name="nCTIUseState" type="hidden" value="<c:out value="${NCTIUSESTATE}"/>" />
<input name="strAUXKey" type="hidden" value="<c:forEach var="aux" items="${AUXLIST}" varStatus="status"><c:out value='${aux.LID}'/><c:if test='${!status.last}'>#@@#</c:if></c:forEach>" />
<input name="strAUXValue" type="hidden" value="<c:forEach var="aux" items="${AUXLIST}" varStatus="status"><c:set var='strAuxName' value='${aux.STRNAME}'/><%String sTmp = Function.formatToHTML((String) pageContext.getAttribute("strAuxName"));%><%=Function.getMultiLangItemContent(sTmp,request)%><c:if test='${!status.last}'>#@@#</c:if></c:forEach>" />
<input name="nPWNeedChangeFlag" type="hidden" value="<c:out value="${NPWNEEDCHANGEFLAG}"/>" />
<input name="nRemindExpiredDate" type="hidden" value="<c:out value="${NREMINDEXPIREDDATE}"/>" />
<input name="EnterTime" type="hidden" value="<c:out value="${nowTime}"/>" />
<input name="dtPasswordExpiredDate" type="hidden" value="<fmt:formatDate value="${DTPASSWORDEXPIREDDATE}" pattern="yyyy-MM-dd HH:mm:ss" />" />

<div id="auxImgDiv" style="display:none;">
	<c:forEach var="aux" items="${AUXLIST}" varStatus="status">
		<img id="auxImg<c:out value='${aux.LID}'/>" src="<%=strContextPath%>/FileManage/downloadFileServlet?strServiceName=AUXManager&strTransName=GetMedalAttachedFile&strFieldName=binImage&lId=<c:out value="${aux.LID}"/>&strFileName=<c:out value="${aux.LID}"/>&lUserId=<c:out value="${LUSERID}" />&lTenantId=<c:out value="${LTENANTID}" />&strUserName=<c:out value="${STRUSERNAME}" />" width="19" height="19"/>
	</c:forEach>
</div>

<!-- 左边的树形区域 -->
<div id="leftTree" style="display:none">
	<table width="100%" height="100%"  border="0" cellpadding="0" cellspacing="0">
		
		<tr>
			<td>
			<table width="100%" border="0" cellpadding="0" cellspacing="0" height="57">
					<tr>
						<td width="14" valign="top" style="background-image:url(<%=strContextPath%>/images/leftTree_1.gif);background-repeat:repeat-y;background-position:left; padding-left:6px;"></td>
						<td width="186" ><div id="menuContent"></div>
				<div id="personalFlagDiv" style="display:none;">
					<iframe frameborder="0" width="100%" src="" id="personalFlagFrm"></iframe>
				</div>	
				
				<c:if test='${strProductId=="Contact" || strProductId=="Campaign"}'>
				<!-- BAR栏 -->
				<div id="handle" onClick="handleClick()" onMouseOver="handleHover()" onMouseDown="handleDown()" onMouseOut="handleOut()" onMouseUp="handleHover()">
					<img id="handleOpenImg" src="<%=strContextPath%>/images/handle_bar_normal_tri.gif" border="0" style="display:">
					<img id="handleCloseImg" src="<%=strContextPath%>/images/handle_icon_normal_tri.gif" border="0" style="display:none">
				</div>
				</c:if>
				
				<div id="menu">
					<%
						int i = 0;
					%>
					<c:forEach var="moduleBean" items="${moduleList}"  varStatus="status">
						<c:if test="${moduleBean.moduleLevel==0}">	
							<c:if test="${moduleBean.personalFlag==0}">	
								<div name="menu_${moduleBean.moduleId}" id="mt<%=i%>" <c:choose><c:when test="${moduleBean.isFirstFlag==1}">class="menuTitleDown"</c:when><c:otherwise>class="menuTitle"</c:otherwise></c:choose> onClick="clickMenu('mc<%=i%>')" onMouseOver="overMenu(this)" onMouseOut="outMenu(this)">
									<img src="<%=strContextPath%>/<c:out value="${moduleBean.imageFile}"/>" width="16" height="16" border="0" align="absmiddle">  <span><c:set var="strName_1" value="${moduleBean.multiLangItemId}" /><%=Function.getMultiLangItemContent((String) pageContext.getAttribute("strName_1"),
										request)%></span>
								</div>
							</c:if>
							<c:if test="${moduleBean.personalFlag==1}">	
								<div name="menu_${moduleBean.moduleId}" id="mt<%=i%>" <c:choose><c:when test="${moduleBean.isFirstFlag==1}">class="menuTitleDown"</c:when><c:otherwise>class="menuTitle"</c:otherwise></c:choose> onClick="clickPerson('<c:out value="${moduleBean.treeBarURL}"/>')" onMouseOver="overMenu(this)" onMouseOut="outMenu(this)">
									<img src="<%=strContextPath%>/<c:out value="${moduleBean.imageFile}"/>" width="16" height="16" border="0" align="absmiddle">  <span><c:set var="strName_1" value="${moduleBean.multiLangItemId}" /><%=Function.getMultiLangItemContent((String) pageContext.getAttribute("strName_1"),
										request)%></span>
								</div>
							</c:if>
						<%
							i++;
						%>    
						</c:if>
					</c:forEach>
				</div></td>
						<td width="14" valign="top" style="background-image:url(<%=strContextPath%>/images/leftTree_2.gif);background-repeat:repeat-y;background-position:right; padding-left:6px;"></td>
					</tr>
				</table>
			</td>
			
		</tr>
		<tr>
			<td height="57" colspan="2">
				<table width="100%" border="0" cellpadding="0" cellspacing="0" height="57">
					<tr>
						<td width="14"><img src="<%=strContextPath%>/images/leftTree_bottom1.gif" width="14" height="57"></td>
						<td width="100%" background="<%=strContextPath%>/images/leftTree_bottom2.gif"><div id="menuBottomWord" style="font-size:14px; font-weight:bold; padding-top:5px;cursor:default"  class="nobreak"></div></td>
						<td width="14"><img src="<%=strContextPath%>/images/leftTree_bottom3.gif" width="14" height="57" border="0"></td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
</div>

<!-- 根据产品的不同打印不同的table的class -->
<!-- 这里是一个大的div，名字是topDiv，div里面包含一个table，这是div的开始 -->
<c:choose>
	<c:when test='${strProductId=="Contact"}'>
	<table width="100%"  border="0" cellspacing="0" cellpadding="0"id="miniTopDiv" style="display:none; height:35px; background-image:url(<%=strContextPath%>/images/logo35_bg.gif); background-position:bottom">
  	<tr>
    	<td  style="padding-left:45px"><img src="<%=strContextPath%>/images/logo35.gif" width="109" height="35"></td>
    	<td align="right" style="padding-right:24px">
    	<img src="<%=strContextPath%>/images/<%=strImageMultiLang%>/exit_normal.gif" id="shortcutKeyDiv" name="shortcutKeyDiv" class="pointer" border="0" onMouseOver="this.src='<%=strContextPath%>/images/<%=strImageMultiLang%>/exit_over.gif'" onMouseDown="this.src='<%=strContextPath%>/images/<%=strImageMultiLang%>/exit_down.gif'" onMouseOut="this.src='<%=strContextPath%>/images/<%=strImageMultiLang%>/exit_normal.gif'" onMouseUp="this.src='<%=strContextPath%>/images/<%=strImageMultiLang%>/exit_normal.gif'" onClick="logoutProduct();">
    	</td>
  	</tr>
	</table>
				<div id="topDiv" class="ContactTopDiv"><!-- 在chrome.css里有高度设置 -->
				<table width="100%" border=0 cellPadding=0 cellSpacing=0>
				<tr>
					<td width="210" valign="top"
								background="<%=strContextPath%>/images/Top_logobg.gif">
					<table  border="0" cellpadding="0" cellspacing="0">
									
									<tr height="117">
										<td >
										&nbsp;
									
										</td>
									</tr>
									<tr valign="bottom">
										<td >
										<table id="leftTreeTitleTab" width="210" border="0" cellpadding="0" cellspacing="0" height="57">
					<tr>
						<td width="14"><img src="<%=strContextPath%>/images/leftTree_top1.gif" width="14" height="57"></td>
						<td width="100%" background="<%=strContextPath%>/images/leftTree_top2.gif"><div id="menuSelectedWord" style="color:#cff300;font-size:14px; font-weight:bold; padding-top:5px;cursor:default"  class="nobreak"></div></td>
						<td width="14"><img src="<%=strContextPath%>/images/leftTree_top3.gif" width="14" height="57" border="0"></td>
					</tr>
				</table>
										</td>
									</tr>
								</table>
					</td>
					<td>
					<table  border=0 cellPadding=0 cellSpacing=0>
						<tr>
							<td align="right" width="70">
										<table  border="0" cellpadding="0" cellspacing="0">
					<tr>
						<td align="right"><jsp:include page="/softphone/stateIcon.jsp" flush="true" /></td>
					</tr>
				</table>
									
										</td>
							<td width="99%"  valign="top"
								background="<%=strContextPath%>/images/Top_lab1bg.gif">
								<table width="100%" cellpadding="0" cellspacing="0">
									<tr>
										<td height="3"><!-- 页面右边上边距 -->
										</td>
									</tr>
									<tr>
										<td valign="top"
											background="images/Top_lab2bg1.gif">
											
											<table width="100%" border="0" cellpadding="0"
												cellspacing="0">
												<tr>
												<td width="30">
														<!-- 设置往右的距离 -->
													</td>
													<td width="50">
														<%@ include file="/softphone/voiceIcon.jsp"%>
													</td>
													<td>
														<table border="0" cellpadding="0" cellspacing="0">
															<tr>
																<td aligh="left"><jsp:include page="/softphone/mediaIcon.jsp"
																		flush="true" /></td>
																<td><%@ include file="/jsp/media/contactIcon.jsp"%></td>
															</tr>
														</table>
													</td>
													<td width="100">
														<div>
															<img
																src="<%=strContextPath%>/images/<%=strImageMultiLang%>/exit_normal.gif"
																id="shortcutKeyDiv" name="shortcutKeyDiv"
																class="pointer" border="0"
																onMouseOver="this.src='<%=strContextPath%>/images/<%=strImageMultiLang%>/exit_over.gif'"
																onMouseDown="this.src='<%=strContextPath%>/images/<%=strImageMultiLang%>/exit_down.gif'"
																onMouseOut="this.src='<%=strContextPath%>/images/<%=strImageMultiLang%>/exit_normal.gif'"
																onMouseUp="this.src='<%=strContextPath%>/images/<%=strImageMultiLang%>/exit_normal.gif'"
																onClick="logoutProduct();">
															<div id="shortcutKeyList" style="display: none"></div>
														</div>
													</td>
												</tr>
											</table>

										</td>
									</tr>
								</table>

							</td>
						</tr>
					</table>
					</td>
				</tr>
					
				</div>
			</c:when>
	<c:otherwise>
		<div id="topDiv" class="otherTopDiv">
			<%@ include file="OtherTop.jsp" %>
		</div>
	</c:otherwise>
</c:choose>
<!-- topDiv结束 -->


<iframe id="popPad" style="visibility:hidden; position:absolute; top:30px; left:30px; width:1px; height:1px; z-index:1; background-color:#ffffff;"></iframe>


<!-- 主页工作区 -->
<table width="100%"   border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td >
			<iframe id="mainIframe" src="" allowtransparency="yes" height="100%" frameborder="0" style="background-color:#000099;"  width="100%" hspace="0" longdesc="0" marginheight="0" marginwidth="0" scrolling="no" vspace="0"></iframe>
		</td>
		<td width="24" id="sensorRight" valign="top" style="display:none;">
			<iframe id="floatRightPad" style="visibility:hidden; position:absolute; width:0px; z-index:100;"></iframe>
			
			<!-- 右侧浮动面板 -->
			<div id="floatRightDiv" style="display:none" >
				<table width="100%" height="20"  border="0" cellpadding="0" cellspacing="0" background="<%=strContextPath%>/images/floatRightDivTitleBg.gif">
					<tr>
						<td><div id="rightBoardWord" style="padding-left:5px; width:160px; overflow:hidden" class="nobreak">&nbsp;</div></td>
						<td style="cursor:pointer" width="50" align="center">
							<img src="<%=strContextPath%>/images/right/st_pin.gif" width="11" height="11" border="0" align="absmiddle" id="pinPic" onClick="pinFloat()" alt="固定在主界面中">  
							<img src="<%=strContextPath%>/images/right/st_close.gif" width="11" height="11" border="0" align="absmiddle" style="cursor:pointer" onClick="closeFloatRight();" alt="Close">
						</td>
					</tr>
				</table>
				<table width="100%" border="0" cellpadding="0" cellspacing="0">
					<tr id="menuTr" style="display:none">
						<td valign="top">
							<div id="quick_menu" style="visibility:visible;" class="clsMenu" onMouseover="highlight()" onMouseout="lowlight()" onBlur="hidemenu()"></div>
						</td>
					</tr>
					<tr id="frameTr" style="display:none">
						<td>
							<iframe id="floatRightFrame" src="about:blank" allowtransparency="yes" frameborder="0" width="100%" hspace="0" longdesc="0" marginheight="0" marginwidth="0" scrolling="auto" vspace="0"></iframe>
						</td>
					</tr>
				</table>
			</div>
			<!-- 右侧浮动面板结束 -->
			
			<table border="0" align="right" cellpadding="0" cellspacing="0">
				<tr id="menuEntry" style="display:none">
					<td height="50" align="right" style="cursor:pointer"><img src="<%=strContextPath%>/images/right_icon_shortCut_normal.gif" id="function0" alt="<%=Function.getMultiLangItemContent("lable.rightBoard.shortcut", request)%>" width="22" height="50" border="0" align="absmiddle" onClick="rightBoard('','<%=Function.getMultiLangItemContent("lable.rightBoard.shortcut", request)%>','quikMenu');" onMouseOver="this.src='<%=strContextPath%>/images/right_icon_shortCut_over.gif'" onMouseDown="this.src='<%=strContextPath%>/images/right_icon_shortCut_down.gif'" onMouseOut="this.src='<%=strContextPath%>/images/right_icon_shortCut_normal.gif'"></td>
				</tr>
				<tr>
					<td align="center" height="10"><img src="<%=strContextPath%>/images/right/right_line.gif" width="18" height="2" border="0" align="absmiddle"></td>
				</tr>
				<tr>
					<td height="50" align="right" style="cursor:pointer"><img src="<%=strContextPath%>/images/right/right_icon_normal_02.gif" id="function1" alt="<%=Function.getMultiLangItemContent("LocaleManager.AgentSee.New.showAgentState", request)%>" width="22" height="50" border="0" align="absmiddle" onClick="rightBoard('<%=strContextPath%>/jsp/agentState.jsp','<%=Function.getMultiLangItemContent("LocaleManager.AgentSee.New.showAgentState", request)%>');" onMouseOver="this.src='<%=strContextPath%>/images/right/right_icon_over_02.gif'" onMouseDown="this.src='<%=strContextPath%>/images/right/right_icon_down_02.gif'" onMouseOut="this.src='<%=strContextPath%>/images/right/right_icon_normal_02.gif'"></td>
				</tr>
				<tr>
					<td align="center" height="10"><img src="<%=strContextPath%>/images/right/right_line.gif" width="18" height="2" border="0" align="absmiddle"></td>
				</tr>
				<tr>
					<td height="50" align="right" style="cursor:pointer"><img src="<%=strContextPath%>/images/right/right_icon_normal_01.gif"  id="function2" alt="<%=Function.getMultiLangItemContent("Agent.Info", request)%>" width="22" height="50" border="0" align="absmiddle"  onClick="rightBoard('<%=strContextPath%>/jsp/PersonalFirstPage/leftView.jsp','<%=Function.getMultiLangItemContent("Agent.Info", request)%>')" onMouseOver="this.src='<%=strContextPath%>/images/right/right_icon_over_01.gif'" onMouseDown="this.src='<%=strContextPath%>/images/right/right_icon_down_01.gif'"  onMouseOut="this.src='<%=strContextPath%>/images/right/right_icon_normal_01.gif'"></td>
				</tr>
				<tr>
					<td align="center" height="10"><img src="<%=strContextPath%>/images/right/right_line.gif" width="18" height="2" border="0" align="absmiddle"></td>
				</tr>
				<tr style="display:none">
					<td height="50" align="right" style="cursor:pointer"><img src="<%=strContextPath%>/images/right/right_icon_normal_03.gif"  id="function3" alt="Function NO.3" width="22" height="50" border="0" align="absmiddle"  onClick="rightBoard('about:blank','Function NO.3')" onMouseOver="this.src='<%=strContextPath%>/images/right/right_icon_over_03.gif'" onMouseDown="this.src='<%=strContextPath%>/images/right/right_icon_down_03.gif'" onMouseOut="this.src='<%=strContextPath%>/images/right/right_icon_normal_03.gif'"></td>
				</tr>
			</table>
		</td>
	</tr>
</table>
<!-- 主工作区结束 -->

<!-- 底部按钮区 -->
<div id="bottomDiv">
	<table width="100%" height="36" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<table  border="0" cellspacing="0" cellpadding="0" width="205" >
					<tr  id="bottomLeft" style="display:none">
						<td width="100" align="center">
							<div id="layoutChangeIcon">
								<table border="0" cellpadding="0" cellspacing="0">
									<tr align="right">
										<td><img id="ban_bottom_left"   src="<%=strContextPath%>/images/ban_bottom_left01.gif"   alt="<%=Function.getMultiLangItemContent("layout.label.openLeft", request)%>" width="26" height="22" border="0" class="pointer" onClick="shLeft()" onMouseOver="this.src='<%=strContextPath%>/images/ban_bottom_left02.gif'"  onMouseOut="this.src='<%=strContextPath%>/images/ban_bottom_left01.gif'" onMouseDown="this.src='<%=strContextPath%>/images/ban_bottom_left03.gif'" onMouseUp="this.src='<%=strContextPath%>/images/ban_bottom_left02.gif'"></td>
										<td><img id="ban_bottom_middle" src="<%=strContextPath%>/images/ban_bottom_middle01.gif" alt="<%=Function.getMultiLangItemContent("layout.label.openTab", request)%>" width="27" height="22" border="0" class="pointer" onClick="toggleLayout()" onMouseOver="this.src='<%=strContextPath%>/images/ban_bottom_middle02.gif'"  onMouseOut="this.src='<%=strContextPath%>/images/ban_bottom_middle01.gif'" onMouseDown="this.src='<%=strContextPath%>/images/ban_bottom_middle03.gif'" onMouseUp="this.src='<%=strContextPath%>/images/ban_bottom_middle02.gif'"></td>
										<td><img id="ban_bottom_right"  src="<%=strContextPath%>/images/ban_bottom_right01.gif"  alt="<%=Function.getMultiLangItemContent("layout.label.openRight", request)%>" width="26" height="22" border="0" class="pointer" onClick="shRight()" onMouseOver="this.src='<%=strContextPath%>/images/ban_bottom_right02.gif'"  onMouseOut="this.src='<%=strContextPath%>/images/ban_bottom_right01.gif'" onMouseDown="this.src='<%=strContextPath%>/images/ban_bottom_right03.gif'" onMouseUp="this.src='<%=strContextPath%>/images/ban_bottom_right02.gif'"></td>
									</tr>
								</table>
							</div>
						</td>
						<td width="7"></td>

<!-- 以下部分由stella添加 -->
<c:if test='${strProductId=="Contact"}'>  <!--IPCC-275-->
						<td width="100" height="36" style="padding-top:6x">
							<div id="strQueue" style="display:none;">
								<table id ="t_queue" border="0" cellpadding='0' cellspacing='0' onmousedown="Focus(this,'queue')" id="popTable" name="popTable" style="position:absolute;width:90px; height:24px; z-index:1010; table-layout:fixed; border:1px solid #ffffff; background-color:#000000;filter:alpha(opacity=80);">
									<tr>	
										<td width="20px" align="center" onmousedown="Down(this,'queue')" onmousemove="Remove(this,'queue')" onmouseup="Up(this,'queue')">
											<font size=4><span id=spanQueueSize valign=top style="color:green"></span></font>
										</td>									
										<td onmousedown="Down(this,'queue')" onmousemove="Remove(this,'queue')" onmouseup="Up(this,'queue')" style="color:#00CC00; font-size:12px; padding-left:0px; cursor:move; white-space:nowrap; overflow:hidden; text-overflow:ellipsis;	-o-text-overflow:ellipsis;">										
											<iframe style="width:100%; height:24px;" src="<%=contextPath%>/jsp/main/phoneMarquee.jsp" frameborder="0" width="100%" scrolling=no></iframe>										
										</td>										
										<td width="3"  style="cursor:w-resize;width:3px;" onmousedown="Down(this,'queue')" onmouseup="Up(this,'queue')" onmousemove="Hresize(this)"></td>
									</tr>
								</table>
							</div>
						</td>
</c:if>
<!-- stella添加部分结束 -->

						<td width="7"></td>
					</tr>
				</table>
			</td> 
			<td>
				
					<%@ include file="/jsp/common/header/include_status2.jsp" %>
				
				<table width="100%"  border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td>
							<table width="100%"  border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="14"><img src="<%=strContextPath%>/images/marquee_left.gif" width="14" height="36" border="0"></td>
									<td width="13" background="<%=strContextPath%>/images/marquee_center_bg.gif" style="padding-top:2px"><img id="marqueeStatSign" src="<%=strContextPath%>/images/ban_bottom_light_green.gif" width="13" height="15" border="0" align="absmiddle" onClick="marqueeDBclick()" class="pointer"></td>
									<td height="36" background="<%=strContextPath%>/images/marquee_center_bg.gif">
										<marquee width="400" id="marqueeMessage" scrolldelay="150" onMouseOver="marqueeMouseOver()" onMouseOut="marqueeMouseOut()" onDblClick="marqueeDBclick()"></marquee>
									</td>
									<td width="15"><img src="<%=strContextPath%>/images/marquee_right.gif" width="15" height="36" border="0"></td>
								</tr>
							</table>
						</td>
						<td width="90" align="center"><img src="<%=strContextPath%>/images/jiangpai.gif" width="121" height="36" border="0" align="absmiddle"></td>
					</tr>
				</table>
				<!-- add by Alex -->
				<c:set var="strStatServerAvailable" value="1" />
				<c:set var="strAgentMonitorAvailable" value="1" />
				<input name="strStatServerAvailable" type="hidden" value="<c:out value="${strStatServerAvailable}"/>" />
				<input name="strAgentMonitorAvailable" type="hidden" value="<c:out value="${strAgentMonitorAvailable}"/>" />
				<!-- add by Alex end -->
			</td>
		</tr>
	</table>
</div>

<!-- add by Sean begin -->
<div id="divShowReminder" style="display:none" onmouseover="closeTimeLimit();" onMouseOut="timeLimit();">
	<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
		<tr>
			<td>
				<table width="100%" height="24" border="0" cellpadding="4" cellspacing="0" background="<%=contextPath%>/images/drop3.gif">
  					<tr>
    					<td><%=Function.getMultiLangItemContent("Common.Page.Tips", request)%></td>
    					<td align="right" style="padding-right:8px"><img src="<%=contextPath%>/images/tab_close1.gif" width="8" style="cursor:pointer" height="8" onClick="javascript:noDisplay();"></td>
  					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td colspan="2" height="100%">
				<iframe name="iframe_showReminder" id="iframe_showReminder" src="<%=contextPath%>/jsp/infoReminder.jsp"  width="100%" height="100%" marginwidth="0" marginheight="0" frameborder="0"></iframe>
			</td>
		</tr>		
	</table>
</div>
<!-- add by Sean end -->

<div style="position:absolute;left:-2px;top:-2px">
<iframe name="tempIframe_viewBusiness" id="tempIframe_viewBusiness"  src="<%=contextPath%>/jsp/viewBusiness.jsp" width="0" height="0" marginwidth="0" marginheight="0" frameborder="0" scrolling="no"></iframe>
<iframe name="layout_hiddenSubmitIFrame" id="layout_hiddenSubmitIFrame" src="" style="display:none"  width="0" height="0" marginwidth="0" marginheight="0" frameborder="0" scrolling="no"></iframe>
<%@ include file="/softphone/softphoneApplet.jsp" %>
<jsp:include page="/softphone/alertInfo.jsp" flush="true"/>
</div>


<!-- 处理事件用的两个隐藏层 -->
<span id="span_report_ele" onpropertychange="getTreeDistrictNotice()" value="0"></span>
<span id="span_report_tree" onpropertychange="getTreeDistrictNotice()" value="0"></span>
</body>
<script>
function clickMenuByModuleName(strModuleIdName){
	document.all.mainIframe.contentWindow.document.all.leftTreeFrame.contentWindow.autoClickDiv(strModuleIdName);
}

function notifyLeftViewChangeItem(strModuleIdName){
	document.all.mainIframe.contentWindow.document.all.leftTreeFrame.contentWindow.changeDivItem(strModuleIdName);
}

function isContactShowRightMenuAndBottomLeft(){
	<c:if test='${strProductId=="Contact"}'>
		document.getElementById("sensorRight").style.display = "";
		document.getElementById("bottomLeft").style.display = "";
	</c:if>
}
var d4= new Date();
run();
var d5= new Date();
function show(){
	var d21 = d222-d1;
	var d32 = d3-d222;
	var d43 = d4-d3;
	var d54 = d5-d4;
	alert("d21:"+d21+" d32:"+d32+" d43:"+d43+" d54:"+d54);
}

String.prototype.startsWith = function(str) 
{return (this.match("^"+str)==str)}
</script>
</html>