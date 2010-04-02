<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.Function"%>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib prefix="fmt" uri="/WEB-INF/fmt.tld" %>
<%@ include file="/jsp/common/header/include_init.jsp" %>
<%@ include file="/jsp/common/header/include_link.jsp" %>
<%@ include file="/jsp/common/header/include_script.jsp" %>
<html>
<%
/**
 * @author Mikey
 */
response.setHeader("Pragma", "No-cache");
response.setDateHeader("Expires", 0);
response.setHeader("Cache-Control", "no-cache");
%>
<head>
<title><%=Function.getMultiLangItemContent("Business.Title",request)%></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=strContextPath%>/css/style.css"  rel="stylesheet"  type="text/css">
<script type="text/javascript" src="<%=strContextPath%>/script/format.js"></script>
<script language="JavaScript" type="text/JavaScript">
var hasMessageManagerPermission = true;
var hasBulletinBoardPermission = true;
var hasMemoManagerPermission = true;
var hasTaskManagerPermission = true;
var hasEventManagerPermission = true;
var hasRemindManagerPermission = true;
<!--  
function loadInfo()
{
  	
}
//新增一行
function addrow(Content,addOrder){    
	var newline= newlist.firstChild.cloneNode(true);	
	newline.style.display="block";		
	newline.children(0).firstChild.innerHTML=Content;		
	newlist.insertBefore(newline,inputline);
	document.body.scrollTop=900000;	
}
function removeRow()
{//删除所有的行		
	var nlength = newlist.rows.length;   
	while(nlength>2)
	{		
		newlist.deleteRow(1);		
		nlength = newlist.rows.length;		
	}
}
function alertOverTime(strParameter)
{
	var strPrompt = '<%=Function.getMultiLangItemContent("Reminder.OverTime.overTimeReminder",request)%>';
	var currTime = getCurrentRemindTime();
	var strContent = currTime+':'+strPrompt+'[<span class="style1">'+ strParameter + '</span>]';		
	addrow(strContent);
}
function preProcess(infoType,nLogin,strParameter)
{
		var  strPostfix ="";  
		var  strPrefix = "";
		var  currTime = "";
		var  strContent = "";
		var  strDuringLogin ="";
		var strTitle="";		
		
		
		if(infoType=='Memo')	
		{
			if(hasMemoManagerPermission){
				strPostfix='<%=Function.getMultiLangItemContent("Reminder.MemoManage.MemoReminder.Postfix",request)%>';
				strDuringLogin='<%=Function.getMultiLangItemContent("Reminder.MemoManage.memoReminder",request)%>';
			}
		}
		else if(infoType=='GeneralMessage')	
		{
			if(hasMessageManagerPermission){
				strPostfix='<%=Function.getMultiLangItemContent("Reminder.MSGManager.GeneralMessageReminder.Postfix",request)%>';
				strDuringLogin='<%=Function.getMultiLangItemContent("Reminder.MSGManager.generalMessageReminder",request)%>';
			}
		}
		else if(infoType=='Bulletin')	
		{
			if(hasBulletinBoardPermission){
				strPostfix='<%=Function.getMultiLangItemContent("Reminder.Bulletin.BulletinReminder.Postfix",request)%>';
				strDuringLogin='<%=Function.getMultiLangItemContent("Reminder.Bulletin.bulletinReminder",request)%>';
			}
		}		
		else if(infoType=='Task')	
		{
			if(hasTaskManagerPermission){
				strPostfix='<%=Function.getMultiLangItemContent("Reminder.Role.roleReminder.Postfix",request)%>';
				strDuringLogin='<%=Function.getMultiLangItemContent("Reminder.Role.roleReminder",request)%>';
			}
		}		
		else if(infoType=='Event')	
		{
			if(hasEventManagerPermission){
				strPostfix='<%=Function.getMultiLangItemContent("Reminder.Event.eventReminder.Postfix",request)%>';
				strDuringLogin='<%=Function.getMultiLangItemContent("Reminder.Event.eventReminder",request)%>';
			}
		}
		else if(infoType=='Remind')	
		{
			if(hasRemindManagerPermission){
				strPostfix='Remind';
				strDuringLogin='Remind';
			}
		}		
		if(nLogin==0)
		{//刚刚登录
			
			if(strDuringLogin!='' && strParameter!=undefined && strParameter!=''){
			var list = (strParameter.split('|'))[0];
			if(list>0){
				strPrefix = '<%=Function.getMultiLangItemContent("Reminder.CommReminder.Prefix",request)%>'
				currTime = getCurrentRemindTime();
				strParameter = text2Html(strParameter);
				
				if(infoType=='Bulletin')
					strContent = currTime+':<a href="javascript:void(0);" onclick =\'javascript:showList("'+strParameter+'","Bulletin");parent.closeTimeLimit();\'><span class=\"style1\">' +strPrefix+ '&nbsp;' + list + '&nbsp;'+ strPostfix + '</a></span>';
				else if(infoType=='GeneralMessage')	
					strContent = currTime+':<a href="javascript:void(0);" onclick =\'javascript:showList("'+strParameter+'","GeneralMessage");parent.closeTimeLimit();\'><span class=\"style1\">' +strPrefix+ '&nbsp;' + list+ '&nbsp;' + strPostfix + '</a></span>';
				else if(infoType=='Memo')
					strContent = currTime+':<a href="javascript:void(0);" onclick =\'javascript:showList("'+strParameter+'","Memo");parent.closeTimeLimit();\'><span class=\"style1\">' +strPrefix+ '&nbsp;' + list+ '&nbsp;' + strPostfix + '</a></span>';
				else if(infoType=='Task')
					strContent = currTime+':<a href="javascript:void(0);" onclick =\'javascript:showList("'+strParameter+'","Task");parent.closeTimeLimit();\'><span class=\"style1\">' +strPrefix+ '&nbsp;' + list+ '&nbsp;' + strPostfix + '</a></span>';
				else if(infoType=='Event')
					strContent = currTime+':<a href="javascript:void(0);" onclick =\'javascript:showList("'+strParameter+'","Event");parent.closeTimeLimit();\'><span class=\"style1\">' +strPrefix+ '&nbsp;' + list+ '&nbsp;' + strPostfix + '</a></span>';
				
				addrow(strContent);
			}
			}
		}
		else
		{//此时nExpireCount不是提醒的数目，而是以‘_|_’分隔的字符串	
			if(strDuringLogin!=''){	
				if(strParameter!=undefined&&strParameter!='')
				{
					var list = (strParameter.split('|')[2].split('#,#'));
					var listID = (strParameter.split('|')[1].split('#,#'));
					for(tmp in list){
						currTime = getCurrentRemindTime();
						if(infoType=='Bulletin')
							strContent = currTime+':'+strDuringLogin+'[<a href="javascript:void(0);" onclick =\'javascript:showOneBulletin(' + listID[tmp] + ');parent.closeTimeLimit();\'><span class="style1">'+list[tmp]+'</span></a>]';	
						else if(infoType=='GeneralMessage')	
							strContent = currTime+':'+strDuringLogin+'[<a href="javascript:void(0);" onclick =\'javascript:openmMessageWin(' + listID[tmp] + ');parent.closeTimeLimit();\'><span class="style1">'+list[tmp]+'</span></a>]';
						else if(infoType=='Memo'){
							strContent = currTime+':'+strDuringLogin+'[<a href="javascript:void(0);" onclick =\'javascript:showMemo(' + listID[tmp] + ');parent.closeTimeLimit();\'><span class="style1">'+list[tmp]+'</span></a>]';
						}
						else if(infoType=='Task'){
							strContent = currTime+':'+strDuringLogin+'[<a href="javascript:void(0);" onclick =\'javascript:showTask(' + listID[tmp] + ');parent.closeTimeLimit();\'><span class="style1">'+list[tmp]+'</span></a>]';
						}
						else if(infoType=='Event'){
							strContent = currTime+':'+strDuringLogin+'[<a href="javascript:void(0);" onclick =\'javascript:showEvent(' + listID[tmp] + ');parent.closeTimeLimit();\'><span class="style1">'+list[tmp]+'</span></a>]';
						}else if(infoType=='Remind'){	
							//listID[tmp]
							var nFromType = listID[tmp];
							//提醒来源类型 1-活动联络目标,2-任务,3-投诉,4-咨询,5-订单,6-维修单
							if(nFromType=='1'){
								strPostfix = "<%=Function.getMultiLangItemContent("Reminder.FromType.1.Postfix",request)%>";
							}else if(nFromType=='2'){
								strPostfix = "<%=Function.getMultiLangItemContent("Reminder.FromType.2.Postfix",request)%>";
							}else if(nFromType=='3'){
								strPostfix = "<%=Function.getMultiLangItemContent("Reminder.FromType.3.Postfix",request)%>";
							}else if(nFromType=='4'){
								strPostfix = "<%=Function.getMultiLangItemContent("Reminder.FromType.4.Postfix",request)%>";
							}else if(nFromType=='5'){
								strPostfix = "<%=Function.getMultiLangItemContent("Reminder.FromType.5.Postfix",request)%>";
							}else if(nFromType=='6'){
								strPostfix = "<%=Function.getMultiLangItemContent("Reminder.FromType.6.Postfix",request)%>";
							}
							
							strContent = currTime+':'+strPostfix+'[<span class="style1">'+list[tmp]+'</span>]';
						}
						addrow(strContent);	
					}
		 		}	
	 		}
		}
}

//
function openDialog(theURL,winName,features)
{
	try{
		if(openedWindow!=null){
			openedWindow.close();
			openedWindow = null;
		}
	}catch(e){
		
	}
	openedWindow = window.open(""+theURL+"",winName,features);
}

//----------------------
// Memo,Message,Bulletin
function showList(strParameter,infoType) { 
	//var tmp =unicode(strParameter);
	var s_Message = document.getElementById("itemList");
	var s_infoType = document.getElementById("infoType");
	s_infoType.value=infoType;
	s_Message.value=strParameter;
	submitF.submit();
<%--
	var tmp =unicode(strParameter);
	strMessage = strParameter;
	url = '<%=strContextPath%>/jsp/PopupManager/showRemindList.jsp?infoType='+infoType+'&itemList='+tmp;
	var iTop = (top.window.screen.availHeight-30-600)/2;
    var iLeft = (top.window.screen.availWidth-10-807)/2; 
	openDialog(url,'','width=807px,height=600px,scrollbars=yes,status=no,resizable=no,help=no,top='+iTop+',left='+iLeft);
--%>
	
}
// unicode encode
function unicode(s){ 
   var len=s.length; 
   var rs=""; 
   for(var i=0;i<len;i++){ 
      	var k=s.substring(i,i+1); 
      	rs+= (i==0?"":",")+s.charCodeAt(i); 
   } 
   return rs; 
} 
// unicode decode
function runicode(s){ 
   var k=s.split(","); 
   var rs=""; 
   for(i=0;i<k.length;i++){ 
      rs+=String.fromCharCode(k[i]); 
   } 
   return rs; 
} 
//CallBack
function classCallBack(result,exception){
}
// Task
function showTask(id) {
 //top.jsonrpc.asm.setCallback(true);
 //top.jsonrpc.asm.updateTaskRemindTag(classCallBack,top.getTenantId(),top.getUserId(),top.getUserName(),id);
 url = '<%=strContextPath%>/taskAction.do?method=view&urlForward=/jsp/TaskManage/fistPageViewTask.jsp&lId='+id+top.getStrUserInfo();
 var iTop = (top.window.screen.availHeight-30-500)/2;
 var iLeft = (top.window.screen.availWidth-10-530)/2;  
 openDialog(url,'','width=550,height=560,left=scroll=auto,status=no,resizable=no,help=no,top='+iTop+',left='+iLeft);
}
// Event
function showEvent(id) {
 //top.jsonrpc.asm.setCallback(true);
 //top.jsonrpc.asm.updateEventRemindTag(classCallBack,top.getTenantId(),top.getUserId(),top.getUserName(),id);
 url = '<%=strContextPath%>/eventAction.do?method=show&lId='+id+top.getStrUserInfo()+"&nView=1";
 var iTop = (top.window.screen.availHeight-30-500)/2;
 var iLeft = (top.window.screen.availWidth-10-650)/2; 
 openDialog(url,'','width=650px,height=500px,left=scroll=auto,status=no,resizable=no,help=no,top='+iTop+',left='+iLeft);
}

// Memo
function showMemo(id) {
	url = '<%=strContextPath%>/memoAction.do?method=viewPublic&isPopup=1&lId='+id+top.getStrUserInfo();
	var iTop = (top.window.screen.availHeight-30-600)/2;
    var iLeft = (top.window.screen.availWidth-10-807)/2; 
	openDialog(url,'','width=807px,height=600px,left=scroll=auto,status=no,resizable=no,help=no,top='+iTop+',left='+iLeft);
}
// Bulletin
function showOneBulletin(lId)
{
		var url = "<%=strContextPath%>/jsp/PersonalFirstPage/Bulletin/showBulletinDialogForOpen.jsp?lId=" + lId + "&method=show";
 		var iTop = (top.window.screen.availHeight-30-690)/2;
    	var iLeft = (top.window.screen.availWidth-10-670)/2; 
 		window.open(url,'','width=670,height=690,left=scroll=auto,status=no,resizable=no,help=no,top='+iTop+',left='+iLeft);
}
// Message
function openmMessageWin(lId){
  top.tempWinObj = null;
  lId = lId+1;
  //var url = "<%=strContextPath%>/jsp/MessageManager/msg/viewMSGForOpen.jsp?lId=" +lId;
	var url = "<%=strContextPath%>/jsp/PersonalFirstPage/message/modifyMessageDialog.jsp?lId=" +lId;
    var iTop = (top.window.screen.availHeight-30-690)/2;
    var iLeft = (top.window.screen.availWidth-10-670)/2; 
   window.open(url,'','width=670,height=690,left=scroll=auto,status=no,resizable=no,help=no,top='+iTop+',left='+iLeft);
 }

//提醒
function openRemindWin(nFromType,strFromId){
	//TODO 这里要怎么打开再说了。
}
//-----------------

function commonRemind(strParameter)
{
    var  strContent = "";
    var  currTime = "";
    
    currTime = getCurrentRemindTime();
    strContent = currTime+':'+'<span class="style1">'+strParameter+'</span>';
	addrow(strContent,'desc');
}
//得到当前时间
function getCurrentRemindTime()
{	
    var currTime = new Date();
    var currHours = currTime.getHours(); 
    var currMinutes= currTime.getMinutes(); 
    var currSeconds = currTime.getSeconds();
   
    if(currHours<10)
    {
    	currHours="0"+currHours;
    }
    if(currMinutes<10)
    {
    	currMinutes="0"+currMinutes;    	
    }
    if(currSeconds<10)
    {
    	currSeconds="0"+currSeconds;
    }
    var full = currHours+":"+currMinutes+":"+currSeconds;    
    return full;
}
//-->
</script>
<style type="text/css">
<!--
.style1 {
	color: #FF0000;
	font-weight: bold;
}
-->
</style>
</head> 
  <body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"  onLoad="loadInfo();">
    <table width="100%" cellpadding="0" cellspacing="0" border="0" id="tbReminder" background="images/drop3.gif">
       <TBODY id="newlist" >
        <tr style="display:none" nowrap>
           <td  nowrap><div align="left">xxxxx</div></td>
        </tr>
        <tr id="inputline" >
         <td  nowrap></td>
        </tr>
        </TBODY>
    </table>
  </body>
  <form id="submitF" method="post" action="PopupManager/receiveMsg.jsp" target="asubfrm">
  	<input type="hidden" name="itemList" id="itemList"/>
  	<input type="hidden" name="infoType" id="infoType"/>
  </form>
  <iframe  style="display:none" src="" id="asubfrm" name="asubfrm"></iframe>
</html>
