<%@ page language="java" pageEncoding="UTF-8"%>
<DIV id="m_JoinCampaign" > 
					<table width="100%" border="0" cellpadding="0" cellspacing="0">
                      <tr id="m_JoinCampaign_h" >
                        <td width="8" height="30"> <img src="<%=strContextPath%>/images/d_corner_01.gif" width="8" height="30" alt=""></td>
                        <td height="30" background="<%=strContextPath%>/images/d_corner_02.gif">
                          <table width="100%" border="0" cellspacing="0" cellpadding="3">
                            <tr>
                              <td class="dropTitle"><%=Function.getMultiLangItemContent("personalInfo.agent.Campaign",request)%></td>
                              <td width="40" valign="bottom"  style="cursor: hand">
                               <c:if test="${campaignList!='[]'}">
                              	<a onclick="javascript:campaignMore();">
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
						<table width="100%" border="0" cellpadding="0" cellspacing="0"  class="displayTable">					
                         <c:forEach var="msg" items="${campaignList}"  varStatus="status" >
                      <tr>
			          		<td width="15" >&nbsp;</td>
			          		<td><span  class="displayText"><a style="CURSOR:hand" title="<c:out value='${msg.STRNAME}'/>" onclick="showCampaign(<c:out value='${msg.LID}'/>)"><c:out value="${msg.STRNAME}"/></a></span></td>
                            <td width="270" nowrap>
                            
                            <c:set var="msgItem" value="${msg}" scope="request" />
                            <%
                           		java.util.Map msg = (java.util.Map)request.getAttribute("msgItem");
                            
                                String realStartTime = (String)msg.get("STRREALSTARTTIME");
                                String endTime = (String)msg.get("STRENDTIME");
                                String startTime = (String)msg.get("STRSTARTTIME");

                                java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm");
                                java.text.SimpleDateFormat formatter2 = new java.text.SimpleDateFormat("MM-dd HH:mm");
                                java.text.SimpleDateFormat formatter3 = new java.text.SimpleDateFormat("yyyy");
                                
                                String currentTimeYear = formatter3.format(new java.util.Date());
                                
                                if(realStartTime!=null && !"".equals(realStartTime))
                                {
                                	java.util.Date realTime = formatter.parse(realStartTime);
                                	String realTimeYear = formatter3.format(realTime);
                                	if(realTimeYear.equals(currentTimeYear))
                                	{
                                		realStartTime = formatter2.format(realTime);
                                	}
                                }
                                
                                if(endTime!=null && !"".equals(endTime))
                                {
                                	java.util.Date endTimeTime = formatter.parse(endTime);
                                	String endTimeYear = formatter3.format(endTimeTime);
                                	if(endTimeYear.equals(currentTimeYear))
                                	{
                                		endTime = formatter2.format(endTimeTime);
                                	}
                                }    
                                
                                if(startTime!=null&& !"".equals(startTime))
                                {
                                	java.util.Date startTimeTime = formatter.parse(startTime);
                                	String startTimeYear = formatter3.format(startTimeTime);
                                	if(startTimeYear.equals(currentTimeYear))
                                	{
                                		startTime = formatter2.format(startTimeTime);
                                	}
                                }      
                                
                                if(realStartTime!=null)
	                            {
	                            	if(endTime!=null)
	                            	{
	                            		Object [] obj = {realStartTime, endTime}; 
	                        %>
	                        <%=Function.getMultiLangItemContent("personalInfo.agent.Campaign.time5",request, obj)%>
	                        <%
	                            		
	                            	}
	                            	else
	                            	{
	                            		Object [] obj = {realStartTime}; 
	                        %>
	                        <%=Function.getMultiLangItemContent("personalInfo.agent.Campaign.time6",request, obj)%>
	                        <%
	                            	}
	                            }
                                else
                                {
                                	if(startTime!=null && endTime!=null)
                                	{
                                		Object [] obj = {startTime, endTime}; 
                                		
                                        %>
                                        <%=Function.getMultiLangItemContent("personalInfo.agent.Campaign.time1",request, obj)%>
                                        <%	
                                	}
                                	else if(startTime==null && endTime!=null)
                                	{
                                		Object [] obj = {endTime}; 
                                		
                                        %>
                                        <%=Function.getMultiLangItemContent("personalInfo.agent.Campaign.time3",request, obj)%>
                                        <%	
                                	}
                                	else if(startTime!=null && endTime==null)
                                	{
                                		Object [] obj = {startTime}; 

                                        %>
                                        <%=Function.getMultiLangItemContent("personalInfo.agent.Campaign.time2",request, obj)%>
                                        <%
                                	}
                                	else
                                	{
                                        %>
                                        <%=Function.getMultiLangItemContent("personalInfo.agent.Campaign.time4",request)%>
                                        <%
                                	}
                                }
                                
                            %>
                            </td>
                           
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
