<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.Function"%>
<%@ include file="/jsp/common/header/include_init.jsp" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<title>EZiPCC</title>
<link href="<%=strContextPath%>/css/chrome.css" rel="stylesheet" type="text/css">
<script src="<%=strContextPath%>/script/common.js"></script>
<style type="text/css">
body {
	background-image: url(<%=strContextPath%>/images/title_bg.gif); 
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
//alert('<c:out value='${param.strDepartmentHeaderId}' />');
//alert('<c:out value='${param.strSkillGroupId}' />');
//alert('<c:out value='${param.strboxuser}' />');
//alert('<c:out value='${param.lUserId}' />');
//alert('<c:out value='${param.lTenantId}' />');
//alert('<c:out value='${param.strUserName}' />');
departmentHeaderId = '<c:out value='${param.strDepartmentHeaderId}' />';
skillGroupId = '<c:out value='${param.strSkillGroupId}' />';
function initArea(){
	showType.location.href="<%=strContextPath%>/getLeaveWordFileServlet?operateType=queryLeaveWordFiles&forward=/jsp/media/voicemail.jsp&strboxuser=<c:out value='${param.strboxuser}' />&lUserId=<c:out value='${param.lUserId}' />&lTenantId=<c:out value='${param.lTenantId}' />&strUserName=&nPageSize=10&nPageIndex=1&nRecordIndex=0&strOrderByFieldName=recording&strOrderDirection=desc";
	if(departmentHeaderId==null||departmentHeaderId=='null'||departmentHeaderId==''){
		document.getElementById('a3').style.display = 'none';
	}
	if(skillGroupId==null||skillGroupId=='null'||skillGroupId==''){
		document.getElementById('a2').style.display = 'none';
	}
}

function changeArea(type){
	if(type == '1'){
		showType.location.href="<%=strContextPath%>/getLeaveWordFileServlet?operateType=queryLeaveWordFiles&forward=/jsp/media/voicemail.jsp&strboxuser=<c:out value='${param.strboxuser}' />&lUserId=<c:out value='${param.lUserId}' />&lTenantId=<c:out value='${param.lTenantId}' />&strUserName=&nPageSize=10&nPageIndex=1&nRecordIndex=0&strOrderByFieldName=recording&strOrderDirection=desc";
	}else if(type == '2'){
		showType.location.href="<%=strContextPath%>/getLeaveWordFileServlet?operateType=queryLeaveWordFiles&forward=/jsp/media/voicemail.jsp&strboxuser=<c:out value='${param.strSkillGroupId}' />&lUserId=<c:out value='${param.lUserId}' />&lTenantId=<c:out value='${param.lTenantId}' />&strUserName=&nPageSize=10&nPageIndex=1&nRecordIndex=0&strOrderByFieldName=recording&strOrderDirection=desc";
	}else if(type == '3'){
		showType.location.href="<%=strContextPath%>/getLeaveWordFileServlet?operateType=queryLeaveWordFiles&forward=/jsp/media/voicemail.jsp&strboxuser=<c:out value='${param.strDepartmentHeaderId}' />&lUserId=<c:out value='${param.lUserId}' />&lTenantId=<c:out value='${param.lTenantId}' />&strUserName=&nPageSize=10&nPageIndex=1&nRecordIndex=0&strOrderByFieldName=recording&strOrderDirection=desc";
	}
}

function showOtherType(id){
	document.getElementById('a1').className = 'cpp';
	document.getElementById('a2').className = 'cpp';
	document.getElementById('a3').className = 'cpp';
	document.getElementById('a'+id).className = 'cppCurrent';
	changeArea(id);
}
</script>
</head>

<body onload = "initArea()">
<table width="100%" height="50"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td><strong style="font-size:12px; padding-left:20px"><%=Function.getMultiLangItemContentExt("Media.ContactIcon.VoiceMail", request)%></strong></td>
  </tr>
</table>
<div style="padding:0px 20px;">
<div id="contactPipeline" style="border:1px solid #cccccc; border-bottom-style:none; height:25px; overflow:hidden ">
      <table height="24" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td class="cppLine">&nbsp;</td>
          <td id="a1" class="cppCurrent" onClick="javascript:showOtherType(1)"> <%=Function.getMultiLangItemContentExt("Media.ContactIcon.VoiceMail.Agent", request)%> </td>
          <td style="display: none;" class="cppLine">&nbsp;</td>
          <td style="display: none;" id="a2" class="cpp" onClick="javascript:showOtherType(2)"> <%=Function.getMultiLangItemContentExt("Media.ContactIcon.VoiceMail.CallGroup", request)%> </td>
		  <td style="display: none;" class="cppLine">&nbsp;</td>
          <td style="display: none;" id="a3" class="cpp" onClick="javascript:showOtherType(3)"> <%=Function.getMultiLangItemContentExt("Media.ContactIcon.VoiceMail.Dept", request)%> </td>
		  <td style="display: none;" class="cppLine">&nbsp;</td>
        </tr>
	</table>
</div>
<div id="contentArea" style="height:280px; overflow:no; margin-bottom:8px; border:1px solid #cccccc; border-top-style:none; background-color:#FFFFFF;">
<iframe id="showType" frameborder="0" src="" width="100%" height="100%" vspace="0" hspace="0" scrolling="auto"></iframe>
</div>
</div>
</body>
</html>
