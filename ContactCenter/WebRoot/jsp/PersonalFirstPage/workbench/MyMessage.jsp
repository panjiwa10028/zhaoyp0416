<%@ page language="java" pageEncoding="UTF-8"%>
    <DIV  id="m_Message" > 
					
                      <table width="100%" border="0" cellpadding="0" cellspacing="0">
                        <tr id="m_Message_h" >
                          <td width="8" height="30"> <img src="<%=strContextPath%>/images/d_corner_01.gif" width="8" height="30" alt=""></td>
                          <td height="30" background="<%=strContextPath%>/images/d_corner_02.gif">
                            <table width="100%" border="0" cellspacing="0" cellpadding="3">
                              <tr>
                               <!--  <td width="24"><img src="<%=strContextPath%>/images/drag_icon2.gif" width="25" height="24"></td>--> 
                               <td class="dropTitle"><%=Function.getMultiLangItemContent("personalInfo.agent.Message",request)%></td>
                                <td width="40" valign="bottom"  style="cursor: hand">
                               
                                 <c:if test="${msgList!='[]'}">
                                	<a onclick="javascript:messageMore();">
                                	<img src="<%=strContextPath%>/images/more.gif" border=0 alt="<%=Function.getMultiLangItemContent("PersonalInfoManager.More",request)%>">
                                	</a>
                                	</c:if>
                                </td> 
                              </tr>
                          </table></td>
                          <td width="8" height="30"> <img src="<%=strContextPath%>/images/d_corner_03.gif" alt="" width="8" height="30" border="0"></td>
                        </tr>
                        <tr>
                          <td width="8" background="<%=strContextPath%>/images/d_corner_04.gif"> <img src="<%=strContextPath%>/images/d_corner_04.gif" width="8" height="2" alt=""></td>
                          <td valign="top" height="50" background="<%=strContextPath%>/images/d_corner_05.gif">
						<table width="100%" border="0" cellspacing="2" cellpadding="0" class="displayTable">
						<c:forEach var="msg" items="${msgList}"  varStatus="status" >
		                      <tr>
                            <td width="15">
                            <c:if test="${msg.NIMPORTANCE==null || msg.NIMPORTANCE==0}"><img align="absMiddle" src="<%=strContextPath%>/images/dtree/null.gif"></c:if>
        				<c:if test="${msg.NIMPORTANCE==1}"><img align="absMiddle" src="<%=strContextPath%>/images/dtree/importance.gif"></c:if>
							</td>
                            <td width="20">
                            <c:if test="${msg.NSTATE==1}"><img align="absMiddle" id="img_<c:out value='${msg.LID}'/>" src="<%=strContextPath%>/images/dtree/read.gif" border="0"></c:if>
						<c:if test="${msg.NSTATE==0}"><img align="absMiddle" id="img_<c:out value='${msg.LID}'/>" src="<%=strContextPath%>/images/dtree/notread.gif" border="0"></c:if>
                       
                            </td>
                            <td><span  class="displayText"><a style="CURSOR:hand" title="<c:out value='${msg.STRNAME}'/>" onclick="showMessage(<c:out value='${msg.LID}'/>)"><c:out value="${msg.STRNAME}"/></a></span></td>
                            <td width="60"><c:out value="${msg.STRSENDER}"/></td>
                            <td width="70"><fmt:formatDate value="${msg.DTATTIME}" pattern="MM-dd HH:mm" /></td>
                          </tr>
					       </c:forEach>
					       
                          </table></td>
                          <td width="8" background="<%=strContextPath%>/images/d_corner_06.gif"> <img src="<%=strContextPath%>/images/d_corner_06.gif" width="8" height="2" alt=""></td>
                        </tr>
                        <tr>
                          <td width="8" height="8"> <img src="<%=strContextPath%>/images/d_corner_07.gif" width="8" height="8" alt=""></td>
                          <td height="8" background="<%=strContextPath%>/images/d_corner_08.gif"> <img src="<%=strContextPath%>/images/d_corner_08.gif" width="1" height="8" alt=""></td>
                          <td width="8" height="8"> <img src="<%=strContextPath%>/images/d_corner_09.gif" width="8" height="8" alt=""></td>
                        </tr>
                      </table>
                      <br>
				  </DIV> 
				