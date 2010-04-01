<%@ page language="java" pageEncoding="UTF-8"%>
<%@ include file="/jsp/common/header/include_init.jsp"%>
<%@ include file="/jsp/common/header/include_script.jsp"%>
<%@ include file="/jsp/common/header/include_getRequiredParameter.jsp" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.Function"%>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>EZ Actor addressBoard</title>
<link href="<%=strContextPath%>/css/chrome.css" rel="stylesheet" type="text/css">
</head>

<body scroll="no" style="background-color:transparent ">
<div id="addressBoard" style="padding:5px 0px 0px 7px; display:">
<table width="408" height="167" border="0" cellpadding="0" cellspacing="0">
	 <tr>
	   <td> <img src="<%=strContextPath%>/images/addressBoard_01.gif" width="6" height="6" alt=""></td>
	   <td> <img src="<%=strContextPath%>/images/addressBoard_02.gif" width="396" height="6" alt=""></td>
	   <td> <img src="<%=strContextPath%>/images/addressBoard_03.gif" width="6" height="6" alt=""></td>
	 </tr>
	 <tr>
	   <td background="<%=strContextPath%>/images/addressBoard_04.gif"> <img src="<%=strContextPath%>/images/addressBoard_04.gif" width="6" height="5" alt=""></td>
	   <td width="396" height="155" valign="top" background="<%=strContextPath%>/images/addressBoard_05.gif">
	   <div style="width:396px; height:155px; overflow-y:auto; overflow-x:hidden">
	   <table width="100%" border="0" cellspacing="0" cellpadding="1">
		  <tr>
			<td><strong><%=Function.getMultiLangItemContent("CustomerItem.Name", request)%></strong></td>
		    <td><strong><%=Function.getMultiLangItemContent("CustomerItem.MobilePhone", request)%></strong></td>
		    <td><strong><%=Function.getMultiLangItemContent("CustomerItem.OfficePhone", request)%></strong></td>
		    <td><strong><%=Function.getMultiLangItemContent("CustomerItem.HomePhone", request)%></strong></td>
		  </tr>
		  <c:forEach var="address" items="${list}"  varStatus="status">
		  <tr onMouseOver="this.className='callHisItem'" onMouseOut="this.className=''">
		    <td><span title="<c:out value='${address.STRNAME}' />" alt="<c:out value='${address.STRNAME}' />"><c:set var="strNameTemp" value="${address.STRNAME}" /><%=Function.formatShortToHTML((String)pageContext.getAttribute("strNameTemp"))%></span></td>		    
		    <td onDblclick="javascript:parent.numberBox.value=top.getOutboundPrefix()+'<c:out value='${address.STRMOBILEPHONE}' />';parent.dialImage.click();"><span title="<%=Function.getMultiLangItemContent("Common.Dbl.Call", request)%><c:out value='${address.STRMOBILEPHONE}' />" alt="<%=Function.getMultiLangItemContent("Common.Dbl.Call", request)%><c:out value='${address.STRMOBILEPHONE}' />"><c:out value='${address.STRMOBILEPHONE}' /></span></td>
		    <c:if test='${address.STROFFICEPHONEEXT!=null && address.STROFFICEPHONEEXT!=""}'>
		    	<td onDblclick="javascript:parent.numberBox.value='<c:out value='${address.STROFFICEPHONE} ' /><c:out value='${address.STROFFICEPHONEEXT}' />';parent.dialImage.click();"><span title="<%=Function.getMultiLangItemContent("Common.Dbl.Call", request)%><c:out value='${address.STROFFICEPHONE}' /><c:out value='${address.STROFFICEPHONEEXT}' />" alt="<%=Function.getMultiLangItemContent("Common.Dbl.Call", request)%><c:out value='${address.STROFFICEPHONE}' /><c:out value='${address.STROFFICEPHONEEXT}' />"><c:out value='${address.STROFFICEPHONE}' /><c:out value='${address.STROFFICEPHONEEXT}' /></span></td>
		    </c:if> 
		    <c:if test='${address.STROFFICEPHONEEXT==null || address.STROFFICEPHONEEXT==""}'>
		    	<td onDblclick="javascript:parent.numberBox.value='<c:out value='${address.STROFFICEPHONE}' />';parent.dialImage.click();"><span title="<%=Function.getMultiLangItemContent("Common.Dbl.Call", request)%><c:out value='${address.STROFFICEPHONE}' />" alt="<%=Function.getMultiLangItemContent("Common.Dbl.Call", request)%><c:out value='${address.STROFFICEPHONE}' />"><c:out value='${address.STROFFICEPHONE}' /></span></td>
		    </c:if>
		    <td onDblclick="javascript:parent.numberBox.value=top.getOutboundPrefix()+'<c:out value='${address.STRHOMEPHONE}' />';parent.dialImage.click();"><span title="<c:out value='${address.STRHOMEPHONE}' />" alt="<c:out value='${address.STRHOMEPHONE}' />"><c:out value='${address.STRHOMEPHONE}' /></span></td>
		  </tr>
		  </c:forEach>
		  <!--tr onMouseOver="this.className='callHisItem'" onMouseOut="this.className=''">
            <td>Evan.bian</td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
		    </tr>
		  <tr onMouseOver="this.className='callHisItem'" onMouseOut="this.className=''">
            <td>Evan.bian</td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
		    </tr>
		  <tr onMouseOver="this.className='callHisItem'" onMouseOut="this.className=''">
            <td>Evan.bian</td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
		    </tr>
		  <tr onMouseOver="this.className='callHisItem'" onMouseOut="this.className=''">
            <td>Evan.bian</td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
		    </tr>
		  <tr onMouseOver="this.className='callHisItem'" onMouseOut="this.className=''">
            <td>Evan.bian</td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
		    </tr>
		  <tr onMouseOver="this.className='callHisItem'" onMouseOut="this.className=''">
            <td>Evan.bian</td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
		    </tr>
		  <tr onMouseOver="this.className='callHisItem'" onMouseOut="this.className=''">
            <td>Evan.bian</td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
		    </tr>
		  <tr onMouseOver="this.className='callHisItem'" onMouseOut="this.className=''">
            <td>Evan.bian</td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
		    </tr>
		  <tr onMouseOver="this.className='callHisItem'" onMouseOut="this.className=''">
            <td>Evan.bian</td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
		    </tr>
		  <tr onMouseOver="this.className='callHisItem'" onMouseOut="this.className=''">
            <td>Evan.bian</td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
		    </tr>
		  <tr onMouseOver="this.className='callHisItem'" onMouseOut="this.className=''">
            <td>Evan.bian</td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
		    </tr>
		  <tr onMouseOver="this.className='callHisItem'" onMouseOut="this.className=''">
            <td>Evan.bian</td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
		    </tr>
		  <tr onMouseOver="this.className='callHisItem'" onMouseOut="this.className=''">
            <td>Evan.bian</td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
            <td><span title="双击拨打88888888" alt="双击拨打88888888">88888888</span></td>
		    </tr-->
		</table>
	   </div>	   </td>
	   <td background="<%=strContextPath%>/images/addressBoard_06.gif"> <img src="<%=strContextPath%>/images/addressBoard_06.gif" width="6" height="5" alt=""></td>
	 </tr>
	 <tr>
	   <td> <img src="<%=strContextPath%>/images/addressBoard_07.gif" width="6" height="6" alt=""></td>
	   <td> <img src="<%=strContextPath%>/images/addressBoard_08.gif" width="396" height="6" alt=""></td>
	   <td> <img src="<%=strContextPath%>/images/addressBoard_09.gif" width="6" height="6" alt=""></td>
	 </tr>
</table>
</div>
</body>
</html>
