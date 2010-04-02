<%@ page language="java" pageEncoding="UTF-8"%>
<style type="text/css">

.agentLabel10 {
	color:#4d4d4e;
	font-weight:bold;
	width:60px;
	white-space:nowrap;
	overflow:hidden;
	text-align:right;
	display:block;
	font-size:12px;
	height:13px;
	line-height:14px;
}
.agentInfo {
	color:#4d4d4e;
	font-weight:bold;
	font-size:12px;
	white-space:nowrap;
	height:13px;
	line-height:14px;
}
</style>
<table width="100%" border="0" cellspacing="1" cellpadding="2" class="personalTable">
	<tr>
		<td valign="top">
			<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<table width="100%" border="0" cellpadding="2" cellspacing="1">
							<tr>
								<td nowrap>
									<div class="agentInfo">
										<c:out value="${STRNAME}" /><c:if test="${not (STRNAME eq STRSTAFFERID)}">&nbsp;<font size="2">(<c:out value="${STRSTAFFERID}" />)</font></c:if>										
									</div>
								</td>
							
								<td valign="bottom" align="right">
									<span class="agentLabel10"><%=Function.getMultiLangItemContent("personalInfo.agent.Group",request)%><%=Function.getMultiLangItemContent("personalInfo.colon",request)%></span>
								</td>
								
								<td valign="bottom">
									<span class="agentInfo">
									<script language="javascript">
if(top.strSkillGroupName==""||top.strSkillGroupName=="undefined")
{
	document.write("<%=Function.getMultiLangItemContent("personalInfo.agent.NoSelected",request)%>");
}
else
{
	document.write(top.strSkillGroupName);
}
</script>
									</span>
								</td>
								<td valign="bottom" align="right">
									<span class="agentLabel10"><%=Function.getMultiLangItemContent("personalInfo.agent.Place",request)%><%=Function.getMultiLangItemContent("personalInfo.colon",request)%></span>
								</td>
								<td valign="bottom">
									<span class="agentInfo">
									<script language="javascript">
if(top.strPlaceName==""||top.strPlaceName=="undefined")
{
	document.write("<%=Function.getMultiLangItemContent("personalInfo.agent.NoSelected",request)%>");
}
else
{
	document.write(top.strPlaceName);
}
</script>
									</span>
 									
								</td>
								
								<td valign="bottom" align="right">								
									<span class="agentLabel10"><%=Function.getMultiLangItemContent("PersonalCustomer.Title.OfficePhoneExt", request)%><%=Function.getMultiLangItemContent("personalInfo.colon",request)%></span>
								</td>
								<td valign="bottom">
									<span class="agentInfo"><script language="javascript">
if(top.strExt==""||top.strExt=="undefined")
{
	document.write(<c:out value="${STROFFICEPHONEEXT}" />);
}
else
{
	document.write(top.strExt);
}
</script>
									</span>
								</td>
								<td valign="bottom" align="right">
									<span class="agentLabel10"><%=Function.getMultiLangItemContent("personalInfo.agent.EnterTime", request)%><%=Function.getMultiLangItemContent("personalInfo.colon",request)%></span>
								</td>
								<td valign="bottom">
									<span class="agentInfo" id="showEnterTime"></span>&nbsp;
								</td>
							</tr>
						</table>
					</td>
					<td align="right" valign="bottom">
						<input name="button3" type="button" class="button" value="<%=Function.getMultiLangItemContent("personalInfo.setting",request)%>" style="width: 70px" onClick="openPerfer();">
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>