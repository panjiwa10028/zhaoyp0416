<%@ page contentType="text/html; charset=UTF-8" language="java"%>
<%@ page import="com.esoon.EZActor.BusinessCenter.Function"%>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld"%>
<%@ taglib prefix="fmt" uri="/WEB-INF/fmt.tld"%>
<%@ taglib prefix="fn" uri="/WEB-INF/fn.tld"%>

<%@ include file="/jsp/common/header/include_init.jsp"%>
<%@ include file="/jsp/common/header/include_link.jsp"%>
<%@ include file="/jsp/common/header/include_script.jsp"%>

<c:set var="ctx"  value="${pageContext.request.contextPath}" />
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title><%=Function.getMultiLangItemContent("Business.Title",request)%></title>
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
	margin:22px 0px 0px -520px; 
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
	height:220px;
	width:520px; 
	overflow:auto;
}
#place td{
	border-right:1px solid #d1e4fb;
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
<script src="${ctx}/script/EvanGrid.js" language="JavaScript"
			type="text/javascript"></script>
		<script src="${ctx}/script/common.js" language="JavaScript"
			type="text/javascript"></script>
		<script src="${ctx}/script/prototype.js" language="JavaScript"
			type="text/javascript"></script>
		<script src="${ctx}/script/input.js"
			language="JavaScript" type="text/javascript"></script>
<script language="javascript" type="text/javascript">

function submitForm() {				
				$("nRecordIndex").value = $("nPageSize").value * ($("nPageIndex").value - 1);
				commonTransForm.submit();			
			}
			
						
			function save(lId) {
				var strSelectedIds = "";
				if(lId!='' && lId!=undefined){
					strSelectedIds = lId;
				}else{
					strSelectedIds = getSelectedIds();
				}
					//alert(strSelectedIds);
				
				if(strSelectedIds.indexOf(",")>=0)
				{
					alert("<%=Function.getMultiLangItemContent("limit.one", request)%>");
					return;
				}

				top.win.top.setSkillGroupId(strSelectedIds);
				setStatusBarInfo('<%=Function.getMultiLangItemContent("CCM.Login.Page.SkillGroupSave.OK",request)%>');
			}
			function setStatusBarInfo(info){
			 	if(info != ''){
			 		$("statusBarInfo").innerHTML = '<%=Function.getMultiLangItemContent("transactInfo",
											request)%>'+info;
					$("processMessage").style.display = 'block';
			 	}else{
			 		$("processMessage").style.display = 'none';
			 	}
				
			}
			

			function getSelectedIds(){
				var checkList = document.getElementsByName("lId");
					
				if(checkList==null)
				{
					return "";
				}
					
				var strSelectedIds = "";
				
				for(var i=0; i<checkList.length; i++)
				{
					if(checkList[i].checked==true)
					{
						strSelectedIds += checkList[i].value + ",";
					}
				}
		
				if(strSelectedIds.substring(strSelectedIds.length-1, strSelectedIds.length)==",")
				{
					return strSelectedIds.substring(0, strSelectedIds.length - 1);
				}
				else
				{
					return strSelectedIds;
				}
			}

			function loadInfo() {
				document.getElementById("contentArea").style.height = (document.body.offsetHeight - 100) +"px";
				document.getElementById("contentArea").style.width = (document.body.offsetWidth - 40) +"px";
				var cookieId = '${param.strExtCookieId}';
					var ids = cookieId.split(',');
					for(var i=0; i<ids.length; i++) {
						var id = ids[i];
							if($(id) != undefined) {
								$(id).checked = true;
							}
					}
			}
</script><div id="contentArea" style="height:0px;display:none">
</div>
</head>


	<form name="commonTransForm"
		action="${ctx}/CCMSkillGroupAction.do?method=getAllSkillGroupList";"
		method="POST">

		<input id="list_order" name="strOrderByFieldName" type="hidden"
			value="<c:out value='${STRORDERBYFIELDNAME}'/><c:if test="${empty STRORDERBYFIELDNAME}">t_a.strName</c:if>" />
		<input id="list_asc" name="strOrderDirection" type="hidden"
			value="<c:out value='${STRORDERDIRECTION}'/><c:if test="${empty STRORDERDIRECTION}">desc</c:if>" />
		<input name="nPageSize" type="hidden"
			value="<c:out value='${NPAGESIZE}'/><c:if test="${NPAGESIZE==null || NPAGESIZE <= 0}">5</c:if>" />
		<input name="nPageIndex" type="hidden"
			value="<c:out value='${NPAGEINDEX}'/>" />
		<input name="nRecordIndex" type="hidden"
			value="<c:out value='${NPAGESIZE*(NPAGEINDEX-1)}'/>" />
		<input name="nPageCount" type="hidden"
			value="<c:out value='${NPAGECOUNT}'/>" />
		<input name="nSelectedSearchConditionId" type="hidden"
			value="<c:out value='${NSELECTEDSEARCHCONDITIONID}'/>" />
			
		<input name="STRSKILLGROUPCOOKIEID" type="hidden"
			value="${STRSKILLGROUPCOOKIEID}" />
		<input name="strLoginId" type="hidden"
			value="${STRLOGINID}" />

	</form>
	<body style="overflow:auto" onload="loadInfo()">
		<table width="100%" height="20"  border="0" cellpadding="0" cellspacing="0">
  <tr>
    <td style="padding-left:20px"><strong><%=Function.getMultiLangItemContent("CCM.Login.Page.SetPlace",request)%></strong><span id="testX"><span></td>
  </tr>
</table>

<div style="padding:0px 0px;">
<div style="height:70px;width:180px; overflow:auto; margin-bottom:8px; border:1px solid #cccccc; background-color:#FFFFFF;">
  
 
<div id="dataTable">
			<table width="100%" border="0" cellpadding="0" cellspacing="0"
				id="theObjTable" style="table-layout: fixed;">
				<tbody id="dataArea">
					<tr>
						<td align="center">
								<input class="checkbox" type="radio" id="0" name="lId"
											value=""/>
						</td>
						<td align="center">
							1
						</td>
						<td>
							<%=Function.getMultiLangItemContent("CCM.Login.Page.DoNotChooseThePlace",
									request)%>
						</td>											
					</tr>
					<c:forEach var="element" items="${PLACERECORDSET}"  varStatus="status">
					<tr>
						<td align="center">
								<input class="checkbox" type="radio" id="${element.PLACENAME}_${element.DEVICEID}" name="lId"
											value="${element.PLACENAME}_${element.DEVICEID}"											
								<c:if test="${STREXTCOOKIEID == element.DEVICEID }">checked</c:if>/>
								
						</td>
						<td align="center">
							<c:out value='${status.index + 2}' />
						</td>
						<td>
							<c:out value="${element.PLACENAME}"/>
						</td>											
					</tr>
					</c:forEach>
					
				</tbody>
			</table>
		</div>
</div>
</div>

</body>
	<script language="javascript" type="text/javascript">
//value1 : 列名   value2 : width设置   value3 : 列名对齐设置      value4 : 为空或不填则该列不支持排序，若填写 必须为该列所对应数据库字段名 如 "dtAtTime"
//value5 : 该列若为checkbox则设 为 1，否者可不用填写

//[value1,value2,value3,value4,value5]

var fields = [
["",25,,,],
["",20,,,],
["<%=Function.getMultiLangItemContent("CCM.Login.Page.PlaceName", request)%>",,"",""]
];
//init grid,para:fieldArray,cssPath,imgPath
initGrid(fields,"${ctx}/css/EvanGrid.css","${ctx}/images/evanGrid");
</script>
</html>