<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.Function"%>
<%@ include file="/jsp/common/header/include_init.jsp" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title><%=Function.getMultiLangItemContent("Business.Title",request)%></title>
<link href="<%=strContextPath%>/css/chrome.css" rel="stylesheet" type="text/css">
<script src="<%=strContextPath%>/script/common.js"></script>
<script src="<%=strContextPath%>/script/EvanGrid.js"></script>
<script src="<%=strContextPath%>/script/commonQuery.js"></script>
<script src="<html:rewrite forward ='inputjs'/>"></script>
<style type="text/css">
body {
	background-position:left top;
	background-repeat:no-repeat;
	background-color:#f5f8f9;
}
.voicemailList {
	width:285px;
	white-space:nowrap;
}
</style>
<script language="javascript" type="text/javascript">
function opFolder(divId,folderId,signicon){
	if(document.getElementById(divId).style.display == "none"){
		document.getElementById(divId).style.display = "block";
		document.getElementById(folderId).src= "../images/folder_open.gif";
		document.getElementById(signicon).src= "../images/folder_sign_open.gif";
	}else{
			document.getElementById(divId).style.display = "none";
			document.getElementById(folderId).src= "../images/folder.gif";
			document.getElementById(signicon).src= "../images/folder_sign_close.gif";
	}
}
function openFolder(divId,folderId,signicon){
		document.getElementById(divId).style.display = "block";
		document.getElementById(folderId).src= "../images/folder_open.gif";
		document.getElementById(signicon).src= "../images/folder_sign_open.gif";
}

function setCurrentColor(tdId){}

function selItem(){
var eventObj = event.srcElement.parentNode.parentNode.getElementsByTagName("TD");
	for(i=0;i<eventObj.length;i++){eventObj[i].style.backgroundColor = "#ffffff";eventObj[i].style.color = "#000000";}
	event.srcElement.style.backgroundColor = "#4b81c8";
	event.srcElement.style.color = "#ffffff";
}

var contextPath = "<%=strContextPath%>";
var go2pageFirst='<%=Function.getMultiLangItemContent("page.FirstPageTitle",request)%>';//第一页   页面跳转button"s caption or title
var go2pagePre='<%=Function.getMultiLangItemContent("page.PreviousPageTitle",request)%>';
var go2pageNext='<%=Function.getMultiLangItemContent("page.NextPageTitle",request)%>';
var go2pageLast='<%=Function.getMultiLangItemContent("page.LastPageTitle",request)%>';
var go2page='<%=Function.getMultiLangItemContent("page.GoToPageTitle",request)%>';
var go2pageMsg ='<%=Function.getMultiLangItemContent("pageNumber.error",request)%>';
var strCountTitle ='<%=Function.getMultiLangItemContent("common.count",request)%>';
var strRecordTitle ='<%=Function.getMultiLangItemContent("common.record",request)%>';

var nTotalCount= 0;//总记录数
var test = '<c:out value='${NRECORDCOUNT}'/>';
if (test != '') {
	nTotalCount = parseInt(test);
}
var nPageIndex = 1;//当前页码
test = '<c:out value='${NPAGEINDEX}'/>';
if (test != '') {
	nPageIndex = parseInt(test);
}
test ='<c:out value='${NPAGESIZE}' />';
if (test != '') {
perPageNum = parseInt(test);
}

function sayTheVoiceEmail(id,index){
	//alert(id);
	var theURL="<%=strContextPath%>/getLeaveWordFileServlet?lid="+id;
	var iLeft = (top.window.screen.availWidth-10-500)/2;  
	var iTop = (top.window.screen.availHeight-30-300)/2;       //获得窗口的垂直位置;
    
	openedWindow = window.open(""+theURL+"",'','width=400,height=100,scroll=auto,status=no,resizable=no,help=no,top='+iTop+',left='+iLeft);
	document.getElementById("readImg"+index).src = "images/readed.gif";
}
</script>
</head>

<body>
<form name="tableForm" action = "<%=strContextPath%>/getLeaveWordFileServlet?operateType=queryLeaveWordFiles" method="post">
<input name="strServiceName" type="hidden" value="FileManager"/>
<input name="strTransName" type="hidden"  value="QueryLeaveWordFiles"/>
<input name="strboxuser" type="hidden" value="<c:out value='${STRBOXUSER}'/>" />
<input name="lUserId" type="hidden" value="<c:out value='${LUSERID}'/>" />
<input name="strUserName" type="hidden" value="<c:out value='${STRUSERNAME}'/>" />
<input name="lTenantId" type="hidden" value="<c:out value='${LTENANTID}'/>" />
<input name="nPageSize" type="hidden" value="<c:out value='${NPAGESIZE}'/><c:if test="${NPAGESIZE==null || NPAGESIZE <= 0}">20</c:if>" />
<input name="nPageIndex" type="hidden" value="<c:out value='${NPAGEINDEX}'/>" />	
<input name="nRecordIndex" type="hidden" value="<c:out value='${NPAGESIZE*(NPAGEINDEX-1)}'/>"/>
<input name="nPageCount" type="hidden" value="<c:out value='${NPAGECOUNT}'/>" />
<input name="strOrderByFieldName" type="hidden" value="recording" />
<input name="strOrderDirection" type="hidden" value="desc" />
<input name="forward" type="hidden" value="/jsp/media/voicemail.jsp"/>

<table width="100%" height="230" border="0" cellspacing="0" cellpadding="0">
  <tr  valign="top">
    <td style="padding-left:6px; padding-right:6px;"><table  border="0" cellspacing="0" cellpadding="4">
    <c:forEach var="vmm" items="${list}"  varStatus="status">
      <tr onclick="sayTheVoiceEmail('<c:out value="${vmm.STRRECORDING}"/>','<c:out value="${status.index}"/>');" style="CURSOR:hand">
      	<c:if test="${vmm.STRREAD==null||vmm.STRREAD==''||vmm.STRREAD!='t'}">
        <td width="24" align="center"><img id="readImg<c:out value="${status.index}"/>" src="images/unread.gif" alt="<c:out value="${vmm.STRCALLER}"/>" width="14" height="14" border="0"></td>
        </c:if>
        <c:if test="${vmm.STRREAD!=null&&vmm.STRREAD!=''&&vmm.STRREAD!='f'}">
        <td width="24" align="center"><img id="readImg<c:out value="${status.index}"/>" src="images/readed.gif" alt="<c:out value="${vmm.STRCALLER}"/>" width="14" height="14" border="0"></td>
        </c:if>
        <td nowrap><c:out value="${status.index + 1}"/></td>
        <td nowrap><c:out value="${vmm.STRCALLER}"/></td>
		<td nowrap><c:out value="${vmm.ORIGTIME}"/></td>
      </tr>
    </c:forEach> 
    </table></td>
  </tr>
</table>
<c:if test="${NRECORDCOUNT>0}">
<table width="100%" align="center" valign="bottom" border="0" cellpadding="0" cellspacing="0">
<tr>
	<td><script language="javascript">try{initGotoPageFAL();}catch(e){alert(e);}</script></td>
</tr>
</table>
</c:if>
</form>
</body>
</html>