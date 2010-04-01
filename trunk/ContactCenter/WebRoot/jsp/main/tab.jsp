<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<%@ include file="/jsp/common/header/include_init.jsp" %>
<title>tab</title>
<link href="<%=strContextPath%>/css/tab.css" rel="stylesheet" type="text/css">
<script src="<%=strContextPath%>/script/tab.js" language="JavaScript" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
var buttonWidth = 40;
function getAreaLeftPos(){
		return 0;
}
function getAreaRightPos(){
		return document.documentElement.clientWidth-buttonWidth;
}


//
function getTabsLeftPos(){  
		return top.mainIframe.mainCenter.tabFrame.document.getElementById("TabArea").style.posLeft;
	}
	
//
function getTabsRightPos(){  
		return top.mainIframe.mainCenter.tabFrame.document.getElementById("TabArea").style.posLeft 
		       + top.mainIframe.mainCenter.tabFrame.document.getElementById("TabArea").offsetWidth;
	}
function checkShowButton(){
	if(document.getElementById("TabArea").offsetWidth<(document.documentElement.clientWidth-buttonWidth)){
		moveButton.style.display = "none";
	}else{
		moveButton.style.display = "";
	}
}
	
function moveLR(distance,isLeft){
//alert(getAreaRightPos()+"_"+getTabsRightPos()+"_"+getTabsLeftPos()+"_"+getAreaLeftPos());
	var pos = 0;
	if(isLeft){
		var pos = getAreaRightPos()-getTabsRightPos();
		if(pos>=0){
			distance = 0;
		}else{
			if(pos*-1<distance){
				distance = pos*-1;
			}else{
				
			}
		}
	}else{
		var pos = getTabsLeftPos()-getAreaLeftPos();
		if(pos>=0){
			distance = 0;
		}else{
			if(pos*-1<distance){
				distance = pos*-1;
			}else{
				
			}
		}
	}
	//alert(distance);
	if(isLeft){
		document.getElementById("TabArea").style.posLeft -= distance;
	}else{
		document.getElementById("TabArea").style.posLeft += distance;
	}
}


</script>
</head>

<body onload="init();" oncontextmenu="window.event.returnValue=false"  onselectstart ="return false" onselect="document.selection.empty()">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td>
			<div  style="float:left; width:7px; height:38px; background-color:#CCCCCC; background-image:url(<%=strContextPath%>/images/tab_corner.gif)"></div>
			
			<div id="TabArea">
				<table border="0" cellspacing="0" cellpadding="1" id="TabAreaTable"><tbody><tr id="TabAreaTr"></tr></tbody></table>
			</div>
	</td>
    <td width="35" valign="top">
		<div id="moveButton" style="display:none">
			<table width="29" border="0" cellspacing="0" cellpadding="0">
			  <tr>
				<td><div id="moveToLeftButton"  class="moveToLeft_normal"   style="display:" onclick="moveLR(50,true)" onMouseOver="this.className='moveToLeft_hover'"  onMouseDown="this.className='moveToLeft_down'"  onMouseOut="this.className='moveToLeft_normal'"  onMouseUp="this.className='moveToLeft_hover'" ></div></td>
				<td><div id="moveToRightButton" class="moveToRight_normal"  style="display:" onclick="moveLR(50,false)"  onMouseOver="this.className='moveToRight_hover'" onMouseDown="this.className='moveToRight_down'" onMouseOut="this.className='moveToRight_normal'" onMouseUp="this.className='moveToRight_hover'"></div></td>
			  </tr>
			</table>
			</div>
	</td>
  </tr>
</table>

</body>
<script>
function init(){
	
	//alert(top.document.all.span_report_ele.value);
	top.document.all.span_report_ele.value = "1";
	//window.parent.parent.document.getElementById("leftTreeFrame").contentWindow.loadinfo();
	//window.parent.parent.loadinfo();
}
</script>
</html>