<%@ page language="java" pageEncoding="UTF-8"%>
<div id="m_Form" >
	<div "id=m_Form_b">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr id="m_Form_h" >
				<td width="8" height="30"><img src="<%=strContextPath%>/images/d_corner_01.gif" width="8" height="30" alt=""></td>
				<td height="30" background="<%=strContextPath%>/images/d_corner_02.gif">
					<table width="100%" border="0" cellspacing="0" cellpadding="3">
						<tr>
							<td width="150" nowrap class="dropTitle"><%=Function.getMultiLangItemContent("personalInfo.agent.form",request)%></td>
							<td valign="bottom" style="cursor: default" class="dropTitle">
								(<%=Function.getMultiLangItemContent("personalInfo.agent.undoNum",request)%>: <c:out value='${NRECORDCOUNT}' />)
							</td>
										
						</tr>
						
					</table>
				</td>
				<td width="8" height="30"><img src="<%=strContextPath%>/images/d_corner_03.gif" alt="" width="8" height="30" border="0"></td>
			</tr>
			<tr>
				<td width="8" background="<%=strContextPath%>/images/d_corner_04.gif"><img src="<%=strContextPath%>/images/d_corner_04.gif" width="8" height="2" alt="">
				</td>
				<td valign="top" height="50" background="<%=strContextPath%>/images/d_corner_05.gif">
					<table width="100%" border="0" cellspacing="2" cellpadding="0" class="displayTable">
						<c:forEach var="msg" items="${formList}" varStatus="status">
							<tr>
								<td width="15">
									<c:if test="${msg.NPRILEVAL==1}"><img align="absMiddle" id="importanceImg" src="<%=strContextPath%>/images/dtree/null.gif"></c:if>
									<c:if test="${msg.NPRILEVAL==2}"><img align="absMiddle" id="importanceImg" src="<%=strContextPath%>/images/dtree/importance.gif"></c:if>
								</td>
								<td width="70" nowrap>
									<c:if test="${msg.NEXPIRED==1}">
										<span class="red" title="<%=Function.getMultiLangItemContent("personalInfo.agent.overTime",request)%>"><fmt:formatDate value="${msg.DTLASTASSINEDTIME}" pattern="MM-dd HH:mm" />
										</span>
									</c:if>
									<c:if test="${msg.NEXPIRED==0}">
										<fmt:formatDate value="${msg.DTLASTASSINEDTIME}" pattern="MM-dd HH:mm" />
									</c:if>

								</td>
								<td width="70" nowrap>
									<c:if test="${msg.STRTYPE=='COMPLAINT'}">
										<%=Function.getMultiLangItemContent("personalInfo.agent.complaint",request)%></c:if>
									<c:if test="${msg.STRTYPE=='SERVICING'}"><%=Function.getMultiLangItemContent("personalInfo.agent.maintain",request)%></c:if>
									<c:if test="${msg.STRTYPE=='CONSULT'}"><%=Function.getMultiLangItemContent("personalInfo.agent.consult",request)%></c:if>
									<c:if test="${msg.STRTYPE=='ORDER'}"><%=Function.getMultiLangItemContent("personalInfo.agent.orderForm",request)%></c:if>
								</td>
								<td>
									<span class="displayText"><a CURSOR:hand title="<c:out value='${msg.STRID}'/> (<c:out value='${msg.STRCUSTOMERNAME}' />)" onclick="showForm('<c:out value='${msg.STRTYPE}'/>','<c:out value='${msg.STRID}'/>')"><c:out value='${msg.STRID}' /> (<c:out value="${msg.STRCUSTOMERNAME}" />)</a>
									</span>
								</td>
							</tr>
						</c:forEach>
					</table>
				</td>
				<td width="8" background="<%=strContextPath%>/images/d_corner_06.gif"><img src="<%=strContextPath%>/images/d_corner_06.gif" width="8" height="2" alt=""></td>
			</tr>
			<tr>
				<td width="8" height="8"><img src="<%=strContextPath%>/images/d_corner_07.gif" width="8" height="8" alt=""></td>
				<td height="8" background="<%=strContextPath%>/images/d_corner_08.gif"><img src="<%=strContextPath%>/images/d_corner_08.gif" width="1" height="8" alt=""></td>
				<td width="8" height="8"><img src="<%=strContextPath%>/images/d_corner_09.gif" width="8" height="8" alt=""></td>
			</tr>
		</table>
		<br>
	</div>
</div>
