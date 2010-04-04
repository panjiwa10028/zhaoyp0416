<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.Function"%>
<%@ include file="/jsp/common/header/include_init.jsp" %>

<html>
<head>
<title><%=Function.getMultiLangItemContent("Contact.Title",request)%></title>
<link href="<%=strContextPath%>/css/chrome.css" rel="stylesheet" type="text/css">

<%@ include file="/jsp/common/header/include_script.jsp" %>
<script src="<%=strContextPath%>/script/common.js" language="JavaScript" type="text/javascript"></script>
<script src="<%=strContextPath%>/script/cookie.js" language="JavaScript" type="text/javascript"></script>
<script src="<%=strContextPath%>/script/EvanGrid.js" 
			language="JavaScript" type="text/javascript"></script>
<style type="text/css">
body {
	background-image: url(images/title_bg.gif); 
	background-position:left top;
	background-repeat:no-repeat;
	background-color:#f5f8f9;
}
td,tr,table {
	font-size:12px;
}
#selTel{
	position:absolute; 
	border:2px solid white; 
	margin:22px 0px 0px -420px; 
	background-color:#fbfdff;
	
}
.placeBorder {border:2px solid #7ba3e8}
.placeTitle {
	background-color:#d1e4fb;
	height:28px;
	border-bottom:1px solid #98bff3;
	font-size:12px;
	color:#1b58ac;
	font-weight:bold;
	padding-left:6px;
}
#placeDiv {
	height:150px;
	width:420px; 
	overflow:auto;
}
#place td{
	border-right:1px solid #d1e4fb;
	border-bottom:1px solid #d1e4fb;
	text-align:center; 
	cursor:pointer;
	padding-left:10px;
	padding-right:10px;
}
.oColor{
	background-color:#90baf2; 
	cursor:pointer;
}
.nColor{
	background-color:; 
	cursor:pointer;
}
</style>
	<SCRIPT type="text/javascript" language="javascript">
	<!--
		var obParentWindow = dialogArguments[1];
		
		function setDNSelectState()
		{
			
			if(lVoiceDNCTIId.value!="" && lVoiceDNCTIId.value > 0)
			{
				var elementTemp = document.getElementById("lCTIDNId" + lVoiceDNCTIId.value);
				if(elementTemp!=null)
				{
					elementTemp.checked = true;
				}
			}

			if(lEmailDNCTIId.value!="")
			{
				if(lEmailDNCTIId.value > 0)
				{
					var elementTemp = document.getElementById("lCTIDNId" + lEmailDNCTIId.value);
					if(elementTemp!=null)
					{
						elementTemp.checked = true;
					}
				}
				else if(lEmailDNCTIId.value==0)
				{
					var elementTemp = document.getElementById("lCTIDNIdEmail");
					if(elementTemp!=null)
					{
						elementTemp.checked = true;
					}
				}
			}
			
			if(lChatDNCTIId.value!="")
			{
				if(lChatDNCTIId.value > 0)
				{
					var elementTemp = document.getElementById("lCTIDNId" + lChatDNCTIId.value);
					if(elementTemp!=null)
					{
						elementTemp.checked = true;
					}
				}
				else if(lChatDNCTIId.value==0)
				{
					var elementTemp = document.getElementById("lCTIDNIdChat");
					if(elementTemp!=null)
					{
						elementTemp.checked = true;
					}
				}
			}			
		}
		function saveAndClose()
		{
			var dtDateTemp = new Date();
			dtDateTemp.setDate(dtDateTemp.getDate()+30);
			var nCTIUseStateTemp = 0;
			if(nCTIUseStateUsed.checked==true)
			{
				nCTIUseStateTemp = 1;
			}
			top.win.top.setCTIUseState(nCTIUseStateTemp);
			obParentWindow.globalSetCookie("nCTIUseState", nCTIUseStateTemp, dtDateTemp);
			if(nCTIUseStateTemp == 0)
			{
				top.win.top.setSkillGroupId("");
				top.win.top.setExt("");
				top.win.top.setDevice("");
				top.win.top.setPlaceCTIId(0);
				top.win.top.setPlaceName("");
				top.win.top.setLoginTemplate(0);
				top.win.top.setLoginTemplateName("");
				top.win.top.setVoiceDNCTIId(0);
				top.win.top.setEmailDNCTIId(0);			
				top.win.top.setChatDNCTIId(0);
				top.win.top.setStrDNId("");
				obParentWindow.globalSetCookie("strDNId","", dtDateTemp);
				obParentWindow.globalSetCookie("lLoginTemplateId",0,dtDateTemp);
				obParentWindow.globalSetCookie("strLoginTemplateName","",dtDateTemp);
				obParentWindow.globalSetCookie("lPlaceCTIId",0, dtDateTemp);
				obParentWindow.globalSetCookie("strPlaceName","", dtDateTemp);
				obParentWindow.globalSetCookie("lVoiceDNCTIId",0, dtDateTemp);
				obParentWindow.globalSetCookie("lEmailDNCTIId",0, dtDateTemp);
				obParentWindow.globalSetCookie("lChatDNCTIId",0, dtDateTemp);
				obParentWindow.globalSetCookie("strLoginId",0, dtDateTemp);
			}
			else
			{
				top.win.top.setSkillGroupId(lLoginTemplateId1.value);
				if(lPlaceCTIId1.value != '') {
					top.win.top.setExt(lPlaceCTIId1.value+"_"+ldeviceid.value);
					top.win.top.setDevice(ldeviceid.value);
					top.win.top.setPlaceCTIId(lPlaceCTIId.value);
					top.win.top.setPlaceName(lPlaceCTIId1.value);
				} else {
					top.win.top.setExt("");
					top.win.top.setDevice("");
					top.win.top.setPlaceCTIId(0);
					top.win.top.setPlaceName("");
				}
				
				
				if(lLoginTemplateId1.selectedIndex >= 0)
				{
					top.win.top.setLoginTemplate(lLoginTemplateId1.options[lLoginTemplateId1.selectedIndex].value);
					top.win.top.setLoginTemplateName(lLoginTemplateId1.options[lLoginTemplateId1.selectedIndex].text);
				}else{
					top.win.top.setLoginTemplate(0);
					top.win.top.setLoginTemplateName("");
				}
				setSelectedDNId();
			
				top.win.top.setVoiceDNCTIId(lVoiceDNCTIId.value);
				top.win.top.setEmailDNCTIId(lEmailDNCTIId.value);			
				top.win.top.setChatDNCTIId(lChatDNCTIId.value);
			
				
				if(document.getElementById("strDNId")!=undefined)
				{
					top.win.top.setStrDNId(strDNId.value);
					obParentWindow.globalSetCookie("strDNId",strDNId.value, dtDateTemp);
				}
				else
				{
					top.win.top.setStrDNId("");
					obParentWindow.globalSetCookie("strDNId","", dtDateTemp);
				}
				
				if(lLoginTemplateId1.selectedIndex >= 0)
				{
					obParentWindow.globalSetCookie("lLoginTemplateId",lLoginTemplateId1.options[lLoginTemplateId1.selectedIndex].value,dtDateTemp);
					obParentWindow.globalSetCookie("strLoginTemplateName",lLoginTemplateId1.options[lLoginTemplateId1.selectedIndex].text,dtDateTemp);
				}else{
					obParentWindow.globalSetCookie("lLoginTemplateId",0,dtDateTemp);
					obParentWindow.globalSetCookie("strLoginTemplateName","",dtDateTemp);
				}
				
				obParentWindow.globalSetCookie("lPlaceCTIId",lPlaceCTIId.value, dtDateTemp);
				obParentWindow.globalSetCookie("strPlaceName",lPlaceCTIId1.value, dtDateTemp);
				obParentWindow.globalSetCookie("lVoiceDNCTIId",lVoiceDNCTIId.value, dtDateTemp);
				obParentWindow.globalSetCookie("lEmailDNCTIId",lEmailDNCTIId.value, dtDateTemp);
				obParentWindow.globalSetCookie("lChatDNCTIId",lChatDNCTIId.value, dtDateTemp);
				obParentWindow.globalSetCookie("strLoginId",strLoginId.value, dtDateTemp);
				
			}
			obParentWindow.showSkillGroupName();
			processMessage.style.display="block";
		}
		function setSelectedDNId()
		{
			
			lVoiceDNCTIId.value = "";
			lEmailDNCTIId.value = "";
			lChatDNCTIId.value = "";
			
			var checkList = document.getElementsByName("lDNId");
			
			if(checkList==null)
			{
				return;
			}
			
			for(var i=0; i<checkList.length; i++)
			{
				if(checkList[i].checked==true)
				{
					if(checkList[i].nChannelId==1)
					{// telephone
						lVoiceDNCTIId.value = checkList[i].value;
						document.getElementById("lVoiceDNCTIId").value =lVoiceDNCTIId.value;
						
					}
					else if(checkList[i].nChannelId==2)
					{// email
						lEmailDNCTIId.value = checkList[i].value;
						document.getElementById("lEmailDNCTIId").value =lEmailDNCTIId.value;

					}
					else if(checkList[i].nChannelId==6)
					{// chat
						lChatDNCTIId.value = checkList[i].value;
						document.getElementById("lChatDNCTIId").value =lChatDNCTIId.value;
						
					}
				}
				else
				{
					if(checkList[i].nChannelId==1)
					{// telephone
						lVoiceDNCTIId.value = "";
						strDNId.value = "";

					}
					else if(checkList[i].nChannelId==2)
					{// email
						lEmailDNCTIId.value = "";
					}
					else if(checkList[i].nChannelId==6)
					{// chat
						lChatDNCTIId.value = "";
					}
				}
			}
		}
		function loadInfo()
		{
			
			setDNSelectState();
			setValible();
			if(${isExist!='true' && param.strPlaceName!=''}){
				alert('<%=Function.getMultiLangItemContent("setupPlaceAndDN.place.disabled", request)%>');
			}
			//alert("nAILVersion is "+ ${nAILVersion}+" strAILAvailable is "+ ${strAILAvailable});
		}
		function refresh()
		{
			var nCTIUseStateTemp = 0;
			
			if(nCTIUseStateUsed.checked==true)
			{
				nCTIUseStateTemp = 1;
			}
			
			var lLoginTemplateIdTemp = 0;
			if(lLoginTemplateId1.selectedIndex>=0)
			{
				lLoginTemplateIdTemp = lLoginTemplateId1.options[lLoginTemplateId1.selectedIndex].value
			}

			var lPlaceCTIIdTemp = 0;
			if(document.getElementById("lPlaceCTIId").value!="")
			{
				lPlaceCTIIdTemp = document.getElementById("lPlaceCTIId").value;
			}
			var strPlaceNameTemp = "";
			if(document.getElementById("lPlaceCTIId1").value!="")
			{
				strPlaceNameTemp = document.getElementById("lPlaceCTIId1").value;
			}
			var nPlaceStateTemp = 1;
			if(document.getElementById("nPlaceState").value!="")
			{
				nPlaceStateTemp = document.getElementById("nPlaceState").value;
			}
			var strPlacedbid="";
			if(document.getElementById("lPlaceCTIId").value!="")
			{
				strPlacedbid=document.getElementById("lPlaceCTIId").value;
			}
			var ldeviceid=0;
			if(document.getElementById("ldeviceid").value!="")
			{
				ldeviceid=document.getElementById("ldeviceid").value;
			}
			var strLoginId="";
			if(document.getElementById("strLoginId").value!="")
			{
				strLoginId=document.getElementById("strLoginId").value;
			}
			if(nPlaceStateTemp < 1)
			{
				location.href = "<%=strContextPath%>/setupPlaceAndDn.do?method=listPlace&lPlacedbid="+strPlacedbid+"&ldeviceid="+ldeviceid+"&strTenantId=" + strTenantId.value + "&lPlaceCTIId=" + lPlaceCTIIdTemp + "&strPlaceName=" + strPlaceNameTemp + "&nCTIUseState=" + nCTIUseStateTemp + "&lVoiceDNCTIId=" + lVoiceDNCTIId.value + "&lEmailDNCTIId=" + lEmailDNCTIId.value + "&lChatDNCTIId=" + lChatDNCTIId.value + "&lLoginTemplateId=" + lLoginTemplateIdTemp+"&strLoginId="+strLoginId;
				dnTable1.style.display="block";
			}
			else
			{
				var flag=dialogArguments[2].asm.checkPlaceCTIId(lPlaceCTIIdTemp);
				if(flag < 0){
					location.href = "<%=strContextPath%>/setupPlaceAndDn.do?method=listPlace&lPlacedbid="+strPlacedbid+"&ldeviceid="+ldeviceid+"&strTenantId=" + strTenantId.value + "&lPlaceCTIId=" + lPlaceCTIIdTemp + "&strPlaceName=" + strPlaceNameTemp + "&nCTIUseState=" + nCTIUseStateTemp + "&lVoiceDNCTIId=" + lVoiceDNCTIId.value + "&lEmailDNCTIId=" + lEmailDNCTIId.value + "&lChatDNCTIId=" + lChatDNCTIId.value + "&lLoginTemplateId=" + lLoginTemplateIdTemp+"&strLoginId="+strLoginId;
					dnTable1.style.display="block";
				}else{
					dnTable1.style.display="none";
					alert('<%=Function.getMultiLangItemContent("setupPlaceAndDN.place.using", request)%>');
				}
			}
			
		}		
		
		function selBox(boxId){
			if(document.getElementById("nCTIUseStateUsed").checked==true)
			{
				if(document.getElementById(boxId).checked == true){
					document.getElementById(boxId).checked = false;
				}
				else{alert("false");
					document.getElementById(boxId).checked = true;
				}
			}
		}
		function shDiv(divId){
			if(document.getElementById(divId).style.display == "none"){
				document.getElementById(divId).style.display = "block";
			}
			else{
				document.getElementById(divId).style.display = "none";
			}
		}
		
		//关闭模板面板
		document.onclick = function hideFloat()
		{
			document.getElementById("selTel").style.display = "none";
		}
		//按照选择的PlaceId显示DN
		function changePlaceId(id,deviceid,name,state)
		{
			
			lPlaceCTIId1.value=name;
			lPlaceCTIId.value=id;			
			ldeviceid.value=deviceid;
			//strLoginId.value=getCookie("strLoginId");
			
			ltempId.value = id;
			nPlaceState.value=state;
			refresh();
		}
		function aa(){
			document.getElementById("contentArea").style.height = (document.body.offsetHeight-100) + 'px';
		}	
		function setValible()
		{
			
			if(nCTIUseStateUsed.checked==true)
			{
				lPlaceCTIId1.disabled=false;
				lLoginTemplateId1.disabled=false;
				dnTable.disabled=false;
			}
			else
			{
				lPlaceCTIId1.disabled=true;
				lLoginTemplateId1.disabled=true;
				dnTable.disabled=true;
			}
			
		}
		
	
	//-->
	</script>
</head>
<body style="overflow:auto" onLoad="setValible();aa()">
<table width="100%" height="50"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td style="padding-left:20px;color:#cff300"><strong><%=Function.getMultiLangItemContent("setupPlaceAndDN.title", request)%></strong></td>
  </tr>
</table>
<input name="strTenantId" type="hidden" value="<c:out value="${param.strTenantId}" />" />
<input id="lVoiceDNCTIId" name="lVoiceDNCTIId" type="hidden" value="<c:out value="${param.lVoiceDNCTIId}" />" />
<input id="lEmailDNCTIId" name="lEmailDNCTIId" type="hidden" value="<c:out value="${param.lEmailDNCTIId}" />" />
<input id="lChatDNCTIId" name="lChatDNCTIId" type="hidden" value="<c:out value="${param.lChatDNCTIId}" />" />
<input name="lFaxId" type="hidden" value="<c:out value="${param.lFaxIId}" />" />
<input name="lSMSId" type="hidden" value="<c:out value="${param.lSMSId}" />" />
<input name="lPostId" type="hidden" value="<c:out value="${param.lPostId}" />" />
<input name="lPlaceCTIId" type="hidden" value="<c:out value="${param.lPlaceCTIId}" />" />
<input name="nPlaceState" type="hidden" value=1 />
<input name="lLoginTemplateId" type="hidden" value="<c:out value="${param.lLoginTemplateId}" />" />
<input name="ltempId" type="hidden" />
<input name="Flag" type="hidden" value="<c:out value="${isExist}" />" />
<input name="ldeviceid" type="hidden" value="${param.ldeviceid}"/>
<input name="strLoginId" id="strLoginId" type="hidden" value="${param.strLoginId }"/>
<div style="padding:0px 20px;">
<div id="contentArea" style="height:; overflow:auto; margin-bottom:8px; border:1px solid #cccccc; background-color:#FFFFFF;">
  <table width="100%" height="50"  border="0" cellpadding="5" cellspacing="0" style="background-color:#c7cbcf; height:50px; border-bottom:1px solid #abc4e4; margin-bottom:1px ">
    <tr>
      <td><table border="0" align="center">
          <tr>
            <td>&nbsp;</td>
            <td class="nobreak"><%=Function.getMultiLangItemContent("setupPlaceAndDN.use.CTI", request)%>
              <input type="radio" id="nCTIUseStateUsed" name="nCTIUseState" value="1" <c:if test="${param.nCTIUseState==1}">checked="checked"</c:if> onclick="setValible()"> <%=Function.getMultiLangItemContent("setupPlaceAndDN.CTI.enable", request)%> <input type="radio" id="nCTIUseStateUnused" name="nCTIUseState" value="0" <c:if test="${param.nCTIUseState==0 || param.nCTIUseState==null}">checked="checked"</c:if> onclick="setValible()"> <%=Function.getMultiLangItemContent("setupPlaceAndDN.CTI.disable", request)%>
			</td>
            <td width="24">&nbsp;</td>
            <td class="nobreak"><%=Function.getMultiLangItemContent("setupPlaceAndDN.agentgroup", request)%>
              <select name="lLoginTemplateId1" class="inputBox" style="width:100px">
                <c:forEach var="template" items="${GROUPRECORDSET}">
			    	<option value="<c:out value="${template.LID}" />" <c:if test="${param.lLoginTemplateId==template.LID}">selected="selected"</c:if>><c:out value="${template.STRNAME}" /> </option>
				</c:forEach>
              </select></td>
            <td width="24">&nbsp;</td>
            <td class="nobreak"><%=Function.getMultiLangItemContent("setupPlaceAndDN.place", request)%>
              <input id="lPlaceCTIId1" name="textfield" type="text" readonly class="inputBox" size="16" onClick="shDiv('selTel');event.cancelBubble = true;" onChange="refresh()" value="${param.strPlaceName}" />
              <div id="selTel" style="display:none" >
			    <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" class="placeBorder">
                  <tr>
                    <td class="placeTitle"><%=Function.getMultiLangItemContent("setupPlaceAndDN.place.select", request)%></td>
                    </tr>
                  <tr valign="top">
                    <td>
					<div id="placeDiv">				
                    
                    <div id="dataTable">
                    <c:if test="${empty PLACERECORDSET}">
                    <p>&nbsp;<p>&nbsp;<p align="center">NO DATA</p>
                    </c:if>
                    <c:if test="${not empty PLACERECORDSET}">
                    <table width="100%" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="8fa9d5"
						id="theObjTable" >
						<tbody id="dataArea">
						<tr bgcolor="cad9ec">
							<td width="50%">&nbsp;<%=Function.getMultiLangItemContent("user.set.place.title.place",request)%></td>
							<td width="50%">&nbsp;<%=Function.getMultiLangItemContent("user.set.place.title.device",request)%></td>
						</tr>
							<c:forEach var="place" items="${PLACERECORDSET}" varStatus="status">
								<tr bgcolor="eef5fe">	
								<c:set var="strNameTemp" value="${place.PLACENAME}" />
								<c:set var="strNameTemp1" value="${place.STRDESCRIPTION}" />
<!--															
									<td <c:if test="${place.LAGENTID != 0}"></c:if><c:if test="${place.PLACENAME == param.strPlaceName}"></c:if> onclick="changePlaceId('<c:out value="${place.DBID}" />','${place.DEVICEID }','<%=Function.formatToScript((String)pageContext.getAttribute("strNameTemp"))%>','<c:out value="${place.NPLACESTATE}" />','<%=Function.formatToScript((String)pageContext.getAttribute("strNameTemp1"))%>')">
										<c:out value="${status.index+1}"/>
									</td>
-->									
									<td <c:if test="${place.LAGENTID != 0}"></c:if><c:if test="${place.STRNAME == param.strPlaceName}"></c:if> onclick="changePlaceId('<c:out value="${place.DBID}" />','${place.DEVICEID }','<%=Function.formatToScript((String)pageContext.getAttribute("strNameTemp"))%>','<c:out value="${place.NPLACESTATE}" />','<%=Function.formatToScript((String)pageContext.getAttribute("strNameTemp1"))%>')">
										<div title="<c:out value="${place.STRNAME}"/>" <c:if test="${place.STRNAME == param.strPlaceName}">style="color:#55555"</c:if><c:if test="${place.STRNAME == param.strPlaceName}">style="color:#ffffff"</c:if>>
			                              &nbsp;<%=Function.formatShortToHTML((String)pageContext.getAttribute("strNameTemp"),20)%>
										</div>
									</td>
									
									<td onclick="changePlaceId('<c:out value="${place.DBID}" />','${place.DEVICEID }','<%=Function.formatToScript((String)pageContext.getAttribute("strNameTemp"))%>','<c:out value="${place.NPLACESTATE}" />','<%=Function.formatToScript((String)pageContext.getAttribute("strNameTemp1"))%>')">&nbsp;${place.DEVICEID}
									
									</td>									
								<!-- 	<td <c:if test="${place.LAGENTID != 0}"></c:if><c:if test="${place.STRNAME == param.strPlaceName}">bgcolor="#6296d7"</c:if> onclick="changePlaceId('<c:out value="${place.LDBID}" />','<%=Function.formatToScript((String)pageContext.getAttribute("strNameTemp"))%>','<c:out value="${place.NPLACESTATE}" />','<%=Function.formatToScript((String)pageContext.getAttribute("strNameTemp1"))%>')" >
										<div title="<c:out value="${place.STRDESCRIPTION}"/>" <c:if test="${place.STRNAME == param.strPlaceName}">style="color:#55555"</c:if><c:if test="${place.STRNAME == param.strPlaceName}">style="color:#ffffff"</c:if>>
										<%=Function.formatShortToHTML((String)pageContext.getAttribute("strNameTemp1"),20)%>
										</div>
									</td>	 -->								
								</tr>
							</c:forEach>
							
						</tbody>
					</table>
                    </c:if>
					
					<form name="commonTransForm"
			action="<%=strContextPath%>/commonTransAction.do" method="POST">
				<input id="list_order" name="strOrderByFieldName" type="hidden" value="strName" />
				<input id="list_asc" name="strOrderDirection" type="hidden" value="desc" />
				</form>
				</div>
					</div>
					</td>
                  </tr>
                </table>
			  </div> 
			  </td>
            <td>&nbsp;</td>
          </tr>
        </table> </td>
    </tr>
  </table>
  <div id="dnTable1" > 
  <table width="100%" border="0" cellpadding="5" cellspacing="0" background="<%=strContextPath%>/images/mac_bg1.gif">
    <tr>
      <td style="color:#424542; font-weight:bold"><%=Function.getMultiLangItemContent("setupPlaceAndDN.selectDN", request)%></td>
     </tr>
  </table>            
  <div style="padding:10px">
  <table id="dnTable" width="95%" border="0" align="center" cellpadding="2" cellspacing="1" bgcolor="8fa9d5">
    <tr bgcolor="#424542" >
      
      <td align="center" ><strong style="color:#cff300"><%=Function.getMultiLangItemContent("setupPlaceAndDN.DN", request)%></strong></td>
      <td width="80" align="center"><strong style="color:#cff300"><%=Function.getMultiLangItemContent("setupPlaceAndDN.state", request)%></strong></td>
    </tr>
    <c:forEach var="dn" items="${DEVICERECORDSET}" varStatus="status">
    	
    <tr bgcolor="eef5fe">
      
      <input type="hidden" id="strDNId" name="strDNId" value="<c:out value="${dn.DBID}" />">
      <td>
		<%=Function.getMultiLangItemContent("common.channel.telephone", request)%>:<c:out value="${dn.DEVICEID}" />
		</td>
      <td width="80" align="center">
      	<c:if test="${dn.IPADDR==''}"><%=Function.getMultiLangItemContent("common.DN.state.logout", request)%></c:if>
		<c:if test="${dn.IPADDR!=''}"><%=Function.getMultiLangItemContent("common.DN.state.login", request)%></c:if>
		
      </td>
    </tr>
   
    </c:forEach>
   
  </table>
  </div>
  </div>
  </div>
  </div>
  <div id="processMessage" style="display:none">
	<table width="100%"  border="0" cellspacing="0" cellpadding="0">
	  <tr>
		<td><%=Function.getMultiLangItemContent("setupPlaceAndDN.sava.result", request)%></td>
		<td width="15" align="right">
		<img src="<%=strContextPath%>/images/close1.gif" width="13" height="13" style="cursor:pointer;" title="<%=Function.getMultiLangItemContent("Common.Page.Close", request)%>" onClick="hideDiv('processMessage')">
		</td>
		<td width="20">&nbsp;</td>
	  </tr>
	</table>
</div>
<table width="100%" height="60"  border="0" align="center" cellspacing="0" background="images/mac_bg1.gif" style="border-top:1px solid #cccccc">
  <tr>
    <td align="center" height="40">
	<input name="Submit" type="button" class="button" value=" <%=Function.getMultiLangItemContent("Common.Page.Save", request)%> " onClick="javascript:saveAndClose();">
    &nbsp;&nbsp;<input name="Submit2" type="button" class="button" value=" <%=Function.getMultiLangItemContent("Common.Page.Close", request)%> " onClick="window.close();">&nbsp;&nbsp;</td>
  </tr>
   <tr>
    <td align="center"></td>
  </tr>
</table>            
</body>
</html>
<script language="javascript" type="text/javascript">
//value1 : 列名   value2 : width设置   value3 : 列名对齐设置      value4 : 为空或不填则该列不支持排序，若填写 必须为该列所对应数据库字段名 如 "dtAtTime"
//value5 : 该列若为checkbox则设 为 1，否者可不用填写

//[value1,value2,value3,value4,value5]

var fields = [
["",30,"",""],
["<%=Function.getMultiLangItemContent(
							"FormatManager.Page.Name", request)%>",,"",""]

];
//init grid,para:fieldArray,cssPath,imgPath
 <c:if test="${not empty PLACELIST}">
      initGrid(fields,"<%=strContextPath%>/css/EvanGrid.css","<%=strContextPath%>/images/evanGrid");
</c:if>

</script>
