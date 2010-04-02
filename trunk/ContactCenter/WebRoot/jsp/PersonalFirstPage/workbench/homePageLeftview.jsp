<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.Function" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.BusinessCenterApp" %>
<%@ page import="EZLib.Message.EZMessage" %>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib prefix="fmt" uri="/WEB-INF/fmt.tld" %>
<%
response.setHeader("Pragma", "No-cache");
response.setDateHeader("Expires", 0);
response.setHeader("Cache-Control", "no-cache");
%>
<%@ include file="/jsp/common/header/include_script.jsp"%>
<%@ include file="/jsp/common/header/include_getRequiredParameter.jsp" %>
<%@ include file="/jsp/common/header/include_init.jsp" %>
<%

/*	Long lUserId = (session.getAttribute("lUserId") != null && ((Long)session.getAttribute("lUserId")).longValue() > 0)?(Long)session.getAttribute("lUserId"):new Long(1);

	String strUserName = (session.getAttribute("strUserName") == null || ((String)session.getAttribute("strUserName")).equals(""))?"admin":(String)session.getAttribute("strUserName");
	//(Long)session.getAttribute("lTenantId")
	
	//Long lTenantId =  new Long(0);
	Long lTenantId = (session.getAttribute("lTenantId") != null && ((Long)session.getAttribute("lTenantId")).longValue() > 0)?(Long)session.getAttribute("lTenantId"):new Long((request.getParameter("lTenantId") != null && !"".equals((request.getParameter("lTenantId")))?request.getParameter("lTenantId"):"-1"));
	*/
		
	
	
	/*EZMessage requestMessage = new EZMessage();
	requestMessage.setString("strServiceName", "MemoManager");
	requestMessage.setString("strTransName", "GetNoHandleMemo");
	requestMessage.setLong("lUserId", lUserId);
	requestMessage.setString("strUserName", strUserName);
	requestMessage.setLong("lTenantId", lTenantId);
	requestMessage.setLong("lReceiverId", lUserId);
	//requestMessage.setLong("lGroupId", (Long)request.getAttribute("LID"));
	
	EZMessage responseMessage = new EZMessage();
	
	BusinessCenterApp.getInstance().handleTrans(requestMessage,responseMessage);
	
	Function.MessageToRequest(responseMessage, request);
	
	String noHandleMemos = "" + String.valueOf(request.getAttribute("NRECORDCOUNT"));
	if(noHandleMemos == null || noHandleMemos.equals(""))
		noHandleMemos = "0";
	
	requestMessage.setString("strServiceName", "MSGManager");
	requestMessage.setString("strTransName", "GetNoReadMSGs");
	requestMessage.setLong("lUserId", lUserId);
	requestMessage.setString("strUserName", strUserName);
	requestMessage.setLong("lTenantId", lTenantId);
	requestMessage.setLong("lReceiverId", lUserId);
	
	responseMessage = new EZMessage();
	
	BusinessCenterApp.getInstance().handleTrans(requestMessage,responseMessage);
	
	Function.MessageToRequest(responseMessage, request);
	
	String noReadMessages = "" + String.valueOf(request.getAttribute("NRECORDCOUNT"));
	if(noReadMessages == null || noReadMessages.equals(""))
		noReadMessages = "0";
		
	requestMessage.setString("strServiceName", "BulletinManager");
	requestMessage.setString("strTransName", "GetNoReadBulletin");
	requestMessage.setLong("lUserId", lUserId);
	requestMessage.setString("strUserName", strUserName);
	requestMessage.setLong("lTenantId", lTenantId);
	requestMessage.setLong("lReceiverId", lUserId);
	
	responseMessage = new EZMessage();
	
	BusinessCenterApp.getInstance().handleTrans(requestMessage,responseMessage);
	
	Function.MessageToRequest(responseMessage, request);
	
	String noReadBulletin = "" + String.valueOf(request.getAttribute("NRECORDCOUNT"));
	if(noReadBulletin == null || noReadBulletin.equals(""))
		noReadBulletin = "0";
			
	
	//campaign
	requestMessage.setString("strServiceName", "ResultManager");
	requestMessage.setString("strTransName", "QueryOneAgentJoinActiveInfo");
	requestMessage.setLong("lAgentId", lUserId);
	requestMessage.setLong("lUserId", lUserId);
	requestMessage.setString("strUserName", strUserName);
	requestMessage.setLong("lTenantId", lTenantId);
	
	responseMessage = new EZMessage();
	
	BusinessCenterApp.getInstance().handleTrans(requestMessage,responseMessage);
	
	Function.MessageToRequest(responseMessage, request);
	
	
	//nJoinActivityCount//参加活动数 
   //nNotEndCaseCount//未结案的名单数 
   //nNotExecuteCount//未执行的名单数 
   //nWaitPursueCount//待追踪的名单数 
   
   String JoinActivityCount = "" + String.valueOf(request.getAttribute("NJOINACTIVITYCOUNT"));
   String NotEndCaseCount = "" + String.valueOf(request.getAttribute("NNOTENDCASECOUNT"));
   String NotExecuteCount = "" + String.valueOf(request.getAttribute("NNOTEXECUTECOUNT"));
   String WaitPursueCount = "" + String.valueOf(request.getAttribute("NWAITPURSUECOUNT"));
*/	
%>

<html>
<head>
<link href="<%=request.getContextPath()%>/css/personstyle.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style type="text/css">
<!--
body {
	margin: 1px;
	overflow:auto;
}
-->
</style>
</head>
<body oncontextmenu="" >

<table width="100%" border="0" cellspacing="3" cellpadding="0">



           	 <!--
           	  <tr> 
                <td width="65%" noWrap><div align="left">
                &nbsp;<%=Function.getMultiLangItemContent("lable.personalInfo", request)%>
                </div>
                </td>
                <td width="35%"></td>
              </tr>
              -->
                            
<script language="JavaScript" type="text/JavaScript">
		//var tempPermission = false;
		//var tempMoudle = "";
<%
		//for(int i = 0 ; workbench != null && i < workbench.getWorkBenchItemCount() ; i++)
	    //{  	    
%>    
      

<%
		//}
%>
</script>
		
		
              <tr>
                <td class="font05b"> <table width="100%" border="0" cellspacing="0" cellpadding="1">
                    
                    <tr> 
                      <td><div align="left"><%=Function.getMultiLangItemContent("lable.bulletin", request)%>: </div></td>
                      <td>&nbsp;<c:out value="${NBULLETINRECORDCOUNT}" />&nbsp;(<%=Function.getMultiLangItemContent("homepage.common.page.notread.name", request)%>)</td>
                    </tr>
                    <tr> 
                      <td><div align="left"><%=Function.getMultiLangItemContent("lable.msgManager", request)%>: </div></td>
                      <td>&nbsp;<c:out value="${NMSGRECORDCOUNT}" />&nbsp;(<%=Function.getMultiLangItemContent("homepage.common.page.notread.name", request)%>)</td>
                    </tr>
                  </table></td>
              </tr>
              <tr>
              	<td width="100%" height="5" background="<%=request.getContextPath()%>/images/person/tree_images/images_treeline_bg.gif"></td>
              </tr>
              <!-- tr> 
                <td> <table width="100%" border="0" cellspacing="0" cellpadding="1">
                    <tr> 
                      <td width="63%"><div align="left">正在进行的考试：</div></td>
                    </tr>
                    <tr> 
                      <td>xxxxxx</td>
                    </tr>
                  </table></td>
              </tr>
              <tr> 
                <td height="5" background="<%//=request.getContextPath()%>/images/person/tree_images/images_treeline_bg.gif"></td>
              </tr-->
             
  
          </table>
</body>
</html>