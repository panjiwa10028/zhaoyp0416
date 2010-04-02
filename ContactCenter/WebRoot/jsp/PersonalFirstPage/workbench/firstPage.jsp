<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
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
	<script src="<%=strContextPath%>/script/drag_drop_src/drag_drop.js"></script>
	<script src="<%=strContextPath%>/script/common.js"></script>
	<link href="<%=strContextPath%>/css/chrome.css" rel="stylesheet" type="text/css">
	<link href="<%=strContextPath%>/script/drag_drop_src/drag_drop.css" type=text/css rel=stylesheet>
	<style type="text/css">
	.style1 {font-size: 9px; color:#999999}
	body {
		background-color: #c7cbcf;
		margin-top: 0px;
		margin-left: 0px;
		margin-right: 0px;
	}
	</style>
	<%@ include file="/jsp/PersonalFirstPage/workbench/FPJS.jsp" %>
</head>
<body onload="loadInfo()" scroll="auto" style="overflow:auto">

<%-- 最上方的标题 --%>
<%@ include file="/jsp/PersonalFirstPage/workbench/DDTitle.jsp" %>

<div style="padding:5px">
	<script>_IG_DD_init();</script> 
	<form style="margin:0px; padding:0px;" name="tableForm" method="post" action="<%=strContextPath%>/personalInfoAction.do?method=saveDrag" target="configArea">
	<input name="strServiceName" type="hidden" />
	<input name="strTransName" type="hidden" />
	<input name="lUserId" type="hidden" />
	<input name="strUserName" type="hidden" />
	<input name="lTenantId" type="hidden" />
	<input name="forward" type="hidden" value="/jsp/PersonalFirstPage/workbench/firstPage.jsp"/>
	<input name="strDrag" type="hidden" />
	<input name="nMsgPosition" value="0" type="hidden" />
	<input name="nBulletinPosition" value="0" type="hidden" />
	<input name="nMedalPosition" value="0" type="hidden" />
	<input name="nMemoPosition" value="0" type="hidden" />
	<input name="nTaskPosition" value="0" type="hidden" />
	<input name="nBoxType" value="0" type="hidden" />
      
	<div class="yui-gb" id="t_1"> 
		
		<%-- 左边的容器 --%>
		<div class="yui-u" id="c_1"> 
		
		 <c:if test="${DRAGSETTINGS!='[]'}">
				<c:forEach var="drag" items="${DRAGSETTINGS}" varStatus="status">
			 <c:if test="${drag.STRCONTAINERNAME=='Left'}">
					 <c:if test="${drag.STRMODULENAME=='Task'}">
					<%-- 我的任务 --%>
					<%@ include file="/jsp/PersonalFirstPage/workbench/MyTask.jsp" %>
					</c:if>
					 <c:if test="${drag.STRMODULENAME=='Form'}">
					<%-- 待处理表单 --%>
					<%@ include file="/jsp/PersonalFirstPage/workbench/MyForm.jsp" %>	
					</c:if>	
					
					
					 <c:if test="${drag.STRMODULENAME=='Campaign'}">	
					<%-- 我负责的活动 --%>
					<%@ include file="/jsp/PersonalFirstPage/workbench/MyCampaign.jsp" %>	
					</c:if>
					
					 <c:if test="${drag.STRMODULENAME=='Message'}">
							<%-- 我的一般信息 --%>
					<%@ include file="/jsp/PersonalFirstPage/workbench/MyMessage.jsp" %>
					</c:if>
				
					 <c:if test="${drag.STRMODULENAME=='JoinCampaign'}">
					<%-- 我参与的活动 --%>
					<%@ include file="/jsp/PersonalFirstPage/workbench/MyJoinCampaign.jsp" %>
					</c:if>
		
			</c:if>
			</c:forEach>
			</c:if>
			<c:if test="${DRAGSETTINGS=='[]'}">
		
				<%-- 我的任务 --%>
				<%@ include file="/jsp/PersonalFirstPage/workbench/MyTask.jsp" %>
				
				<%-- 待处理表单 --%>
				<%@ include file="/jsp/PersonalFirstPage/workbench/MyForm.jsp" %>	
				
				<%-- 我负责的活动 --%>
				<%@ include file="/jsp/PersonalFirstPage/workbench/MyCampaign.jsp" %>	
					
			</c:if>
			<div class="dm"></div>
		</div> 
		
		<%-- 我是华丽的分割线 --%>
		<div class="yui-k"></div>
				
				
				
		<DIV class="yui-u" id="c_2"> 
			<c:if test="${DRAGSETTINGS!='[]'}">
				<c:forEach var="drag" items="${DRAGSETTINGS}" varStatus="status">
					<c:if test="${drag.STRCONTAINERNAME=='Right'}">
					 <c:if test="${drag.STRMODULENAME=='Task'}">
					<%-- 我的任务 --%>
					<%@ include file="/jsp/PersonalFirstPage/workbench/MyTask.jsp" %>
					</c:if>
					 <c:if test="${drag.STRMODULENAME=='Form'}">
					<%-- 待处理表单 --%>
					<%@ include file="/jsp/PersonalFirstPage/workbench/MyForm.jsp" %>	
					</c:if>	
					
					
					 <c:if test="${drag.STRMODULENAME=='Campaign'}">	
					<%-- 我负责的活动 --%>
					<%@ include file="/jsp/PersonalFirstPage/workbench/MyCampaign.jsp" %>	
					</c:if>
					
					 <c:if test="${drag.STRMODULENAME=='Message'}">
					<%-- 我的一般信息 --%>
					<%@ include file="/jsp/PersonalFirstPage/workbench/MyMessage.jsp" %>
					</c:if>
				
					 <c:if test="${drag.STRMODULENAME=='JoinCampaign'}">
					<%-- 我参与的活动 --%>
					<%@ include file="/jsp/PersonalFirstPage/workbench/MyJoinCampaign.jsp" %>
					</c:if>
		
				</c:if>
				</c:forEach>
			</c:if>
			<c:if test="${DRAGSETTINGS=='[]'}">
		
					<%@ include file="/jsp/PersonalFirstPage/workbench/MyMessage.jsp" %>
										
					<%@ include file="/jsp/PersonalFirstPage/workbench/MyJoinCampaign.jsp" %>
					
			</c:if>
				
				<DIV class="dm"></DIV>
		</DIV>
      </DIV> 
      </form>
</div>
<SCRIPT>
	_table=_gel("t_1");
	_pl=true;
	_upc();
</SCRIPT> 
<iframe width="0" height="0" frameborder="0" id="configArea" name="configArea"  scrolling="no"></iframe>
  </body>
	
 </html>
   
  
