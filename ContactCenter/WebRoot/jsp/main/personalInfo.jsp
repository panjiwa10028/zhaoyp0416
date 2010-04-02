<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.Function"%>
<%@ page import="java.util.Date"%>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>

<%@ include file="/jsp/common/header/include_init.jsp" %>

<html>
<head>
	<link href="<%=strContextPath%>/css/chrome.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="<%=strContextPath%>/script/common.js"></script>
	<script src="<%=strContextPath%>/script/commonHeader.js'/>"></script>
	<script src="<%=strContextPath%>/script/DateTime.js" language="JavaScript" type="text/javascript"></script>
	
	<script language="JavaScript" type="text/javascript">
	<!--
	
		var SkillGroup = new Array();
		
		<logic:present name="GROUPSET">
  			<logic:iterate id="group" name="GROUPSET" indexId="i">
  				SkillGroup[SkillGroup.length] = {'lid':'<c:out value="${group.LID}"></c:out>', 'id':'<c:out value="${group.STRGROUPID}"></c:out>', 'name':'<c:out value="${group.STRNAME}"></c:out>'};
 			</logic:iterate>
		</logic:present>
		
		function init() {    
			document.commonTransForm.lUserId.value = top.getUserId();
			document.commonTransForm.lPlaceCTIId.value = top.document.all.lPlaceCTIId.value;
			document.commonTransForm.strUserName.value = top.getUserName();
			document.commonTransForm.lTenantId.value = top.getTenantId();			
		}
		

		function loadInfo() {  
			if(SkillGroup.length==0) {
				setTimeout("init();document.commonTransForm.submit();", 1000);	
			} else {  
				parent.startGetPhoneQueue(SkillGroup);
				//for(var i=0; i<SkillGroup.length; i++) {
				//	alert(SkillGroup[i].id + ":" + SkillGroup[i].name);
				//}
			}			   				
		}
	//-->
	</script>
</head>
<body onLoad="loadInfo()">
<form name="commonTransForm" action = "<%=strContextPath%>/commonTransAction.do" method="post">

	<input name="strServiceName" type="hidden" value="PersonalInfoManager"/>
	<input name="strTransName" type="hidden" value="PersonalInfoGet"/>   
    <input name="lUserId" type="hidden" />
    <input name="strUserName" type="hidden" />
    <input name="lTenantId" type="hidden" /> 
    
    <input name="lPlaceCTIId" type="hidden" value="" />
	<input name="forward" type="hidden" value="/jsp/main/personalInfo.jsp"/>

</form>

</body>
</html>
