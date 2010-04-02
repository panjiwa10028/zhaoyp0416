<%@ page language="java" pageEncoding="UTF-8"%>
<div id="m_Task" > 
	<div "id=m_Task_b">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr id="m_Task_h" >
				<td width="8" height="30"><img src="<%=strContextPath%>/images/d_corner_01.gif" width="8" height="30" alt=""></td>
				<td height="30" background="<%=strContextPath%>/images/d_corner_02.gif">
					<table width="100%" border="0" cellspacing="0" cellpadding="3">
						<tr>
							<td width="150" nowrap class="dropTitle"><p><%=Function.getMultiLangItemContent("personalInfo.agent.task",request)%></p></td>
							<td valign="bottom"  style="cursor:default" class="dropTitle">(<%=Function.getMultiLangItemContent("personalInfo.agent.undoNum",request)%>: <c:out value='${NTASKNUM}'/>)</td>
							<td width="40" align="right" style="cursor: hand">
							<c:if test="${taskList!='[]'}">
								<a onclick="javascript:taskMore();">
									<img src="<%=strContextPath%>/images/more.gif" border=0 alt="<%=Function.getMultiLangItemContent("PersonalInfoManager.More",request)%>">
									
								</a>
							</c:if>
							</td> 
						</tr>
					</table>
				</td>
				<td width="8" height="30"><img src="<%=strContextPath%>/images/d_corner_03.gif" alt="" width="8" height="30" border="0"></td>
			</tr>
			<tr>
				<td width="8" background="<%=strContextPath%>/images/d_corner_04.gif"> <img src="<%=strContextPath%>/images/d_corner_04.gif" width="8" height="2" alt=""></td>
				<td valign="top" height="50" background="<%=strContextPath%>/images/d_corner_05.gif">
					<table width="100%" border="0" cellspacing="2" cellpadding="0" class="displayTable">
						<c:forEach var="task" items="${taskList}"  varStatus="status" >
						<tr>
							<td width="15">
									<c:if test="${task.NPRILEVAL==1}"><img align="absMiddle" id="importanceImg" src="<%=strContextPath%>/images/dtree/null.gif"></c:if>
								<c:if test="${task.NPRILEVAL==2}"><img align="absMiddle" id="importanceImg" src="<%=strContextPath%>/images/dtree/importance.gif"></c:if>
							</td>
							<td width="70" nowrap>
								<span id="tt<c:out value='${status.index}'/>"></span>
								<script language="javascript">		
									tmpTime='<fmt:formatDate value="${task.DTPLANDEALTIME}" pattern="yyyy-MM-dd HH:mm" />';
									tmpTime=Date.parse(tmpTime.substring(5,7)+"/"+tmpTime.substring(8,10)+"/"+tmpTime.substring(0,4)+" "+tmpTime.substring(11,16));
									if(nowTime>tmpTime){
										eval('tt'+<c:out value='${status.index}'/>).innerHTML='<font color="red"><fmt:formatDate value="${task.DTLASTDEALTIME}" pattern="MM-dd HH:mm" /></font>';
									}else{
										eval('tt'+<c:out value='${status.index}'/>).innerHTML='<fmt:formatDate value="${task.DTLASTDEALTIME}" pattern="MM-dd HH:mm" />';
									}
								</script>
							</td>
							<td width="40" nowrap>
								<c:if test="${task.NTYPE==1}"><%=Function.getMultiLangItemContent("personalInfo.agent.callback",request)%></c:if>
								<c:if test="${task.NTYPE==2}"><%=Function.getMultiLangItemContent("personalInfo.agent.date",request)%></c:if><c:if test="${task.NTYPE==3}"><%=Function.getMultiLangItemContent("personalInfo.agent.normal",request)%></c:if>
							</td>
							<td>
								<span  class="displayText">
									<a style="CURSOR:hand" title="<c:out value='${task.STRNAME}'/>" onclick="showTask(<c:out value='${task.LID}'/>)"><c:out value="${task.STRNAME}"/></a>
								</span>
							</td>
						</tr>
						</c:forEach>
					</table>
				</td>
				<td width="8" background="<%=strContextPath%>/images/d_corner_06.gif"> <img src="<%=strContextPath%>/images/d_corner_06.gif" width="8" height="2" alt=""></td>
			</tr>
			<tr>
				<td width="8" height="8"><img src="<%=strContextPath%>/images/d_corner_07.gif" width="8" height="8" alt=""></td>
				<td height="8" background="<%=strContextPath%>/images/d_corner_08.gif"> <img src="<%=strContextPath%>/images/d_corner_08.gif" width="1" height="8" alt=""></td>
				<td width="8" height="8"><img src="<%=strContextPath%>/images/d_corner_09.gif" width="8" height="8" alt=""></td>
			</tr>
		</table>
		<br/>
	</div> 
</div>
