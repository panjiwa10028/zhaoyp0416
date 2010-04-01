<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.Function"%>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ include file="/jsp/common/header/include_init.jsp" %>
<%
	String strImage = Function.GetMultiLangName(request);	
%>
<html>
<head>
<title><%=Function.getMultiLangItemContent("Business.Title",request)%></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=strContextPath%>/css/style.css"  rel="stylesheet"  type="text/css">
<link href="<%=strContextPath%>/css/chrome.css" rel="stylesheet" type="text/css">
<script src="<html:rewrite forward='commonHeader'/>"></script>
<script src="<html:rewrite forward ='commonQuery'/>"></script>
<script type="text/javascript" src="<%=strContextPath%>/script/contactCommon/dtree.js"></script>
<script src="<%=strContextPath%>/script/DateTime.js" language="JavaScript" type="text/javascript"></script><script language="javascript"><%@include file="/script/DateTimeVariable.js"%></script>
<SCRIPT type="text/javascript" language="javascript">
   var DepartmentTree = new dTree('DepartmentTree');
	DepartmentTree.config.useControl = true;			
	DepartmentTree.config.useCookies = true;			
	DepartmentTree.config.controlType = 'radio';
	//DepartmentTree.config.isCorrelateSelect = true;	
	DepartmentTree.config.correlateSelectType = 'type';				
	DepartmentTree.config.typeIdArrayName = 'selectedTypeId';			
	DepartmentTree.add('0','-1','<%=Function.getMultiLangItemContent("business.all.department", request)%>', 'true', 'false', 'true');	        
	<c:forEach var="departmentNode" items="${list}" >				
		DepartmentTree.add('<c:out value="${departmentNode.LID}"/>',
			'<c:out value="${departmentNode.LPARENTID}"/>',
			<c:set var="strNameTemp" value="${departmentNode.STRNAME}" />
		    <%String sTmp=Function.formatToScript((String)pageContext.getAttribute("strNameTemp"));%>
			'<%=Function.getMultiLangItemContent(sTmp,request)%>',
			'<c:if test="${departmentNode.NTYPE==1}">true</c:if>',
			'<c:if test="${departmentNode.LID==LDEPARTMENTID || departmentNode.LID==param.lDepartmentId}">true</c:if>');
	</c:forEach>
	try
	{
	//parent.DepartmentTree=DepartmentTree;		
	//parent.departTree.innerHTML=DepartmentTree.toString();
	document.write(DepartmentTree.toString());
	}catch(e){alert(e.description);}

</SCRIPT>
</head>

<body marginwidth="0" marginheight="0" topmargin="0" style=" background-color:#eaf0f3; border:0px solid #606972; ">

</body>
</html>
