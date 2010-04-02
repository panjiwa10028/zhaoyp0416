<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
<%@ include file="/jsp/common/header/include_init.jsp" %>
<title>main left tree</title>
<!-- <link href="<%=strContextPath%>/css/chrome.css" rel="stylesheet" type="text/css">-->
<link href="<%=strContextPath%>/css/chrome.css" rel="stylesheet" type="text/css">
<style type="text/css">
body {
	margin: 0px;
	background-image: url(<%=strContextPath%>/images/main_skin_bg.gif);
	border: none;
	overflow:auto;
	background-color: #e4e8ef;
}
.menuTitle {
	background-image:url(<%=strContextPath%>/images/mt_bg.gif);
	background-repeat:repeat-x;
	height:25px;
	overflow:hidden;
	font-weight:bold;
	white-space:nowrap;
	padding:5px 0px 0px 24px;
	cursor:pointer;
}
.menuTitleOver {
	background-image:url(<%=strContextPath%>/images/mt_bg2.gif);
	background-repeat:repeat-x;
	height:25px;
	overflow:hidden;
	white-space:nowrap;
	padding:5px 0px 0px 24px;
	cursor:pointer;
	font-weight:bold;
}
.menuTitleDown {
	background-image:url(<%=strContextPath%>/images/mt_bg3.gif);
	background-repeat:repeat-x;
	height:25px;
	overflow:hidden;
	white-space:nowrap;
	padding:5px 0px 0px 24px;
	cursor:pointer;
	font-weight:bold;
	
}
.menuTitleOver td {
	font-weight:bold;
}
.menuTitleDown td {
	font-weight:bold;
}
.mcIcon {
	padding:5px;
	width:100%;
	cursor:pointer;
	text-align:center;
}
.mcIconOver {
	padding:4px;
	border:1px solid #d1d1d1;
	background-color:#f2f2f2;
	width:100%;
	cursor:pointer;
	text-align:center;
}
.mcBottom {
	background-image:url(<%=strContextPath%>/images/mt_bg11.gif);
	background-repeat:repeat-x;
	height:30px;
}
#menuContent {
	/*border-bottom:1px solid red;*/
	overflow:auto;
}
</style>

<script src="<%=strContextPath%>/script/common.js"></script>
<script type="text/javascript" src="<%=strContextPath%>/script/contactCommon/dtree4.js"></script>
<script language="javascript" type="text/javascript">



function cmenu(itemId){
	//document.getElementById("menu"+menuId).className = "menu2";
	if(document.getElementById(itemId).style.display == "none"){
		showDiv(itemId);
		//document.getElementById("menusrc"+menuId).src = "<%=strContextPath%>/images/menu_arrow_up.gif";
		//document.getElementById("menu"+menuId).title = "关闭子菜单";
		//document.getElementById("menu"+menuId).style.borderBottom = "1px solid #999999";
	}
	else{
		hideDiv(itemId);
		//document.getElementById("menusrc"+menuId).src = "<%=strContextPath%>/images/menu_arrow_down.gif";
		//document.getElementById("menu"+menuId).title = "打开子菜单";
		//if(menuId == "4"){
			//document.getElementById("menu"+menuId).style.borderBottom = "1px solid #999999";
		//}
		//else{
			//document.getElementById("menu"+menuId).style.borderBottom = "0px solid #999999";
		//}
	}
}


function loadinfo() {

	document.getElementById("leftTree").innerHTML=top.document.getElementById("leftTree").innerHTML;
	document.getElementById("menu").style.display= "none";
	document.getElementById('mc'+top.firstflag).style.display= "block";
	document.getElementById("menuWord").innerText = "  ";
	document.getElementById('mt'+top.firstflag).className = "menuTitleDown";
//initSize();
}
function initSize(){
	var menuNumber = document.getElementById("menu").getElementsByTagName("DIV").length; //主菜单数
	var bheight=top.document.documentElement.clientHeight-top.document.getElementById("topDiv").offsetHeight-66;

	var contentDivHeight;
	
	if(bheight > menuNumber*25+100)
	{
		contentDivHeight = bheight - menuNumber*25;
	}
	else
	{
		contentDivHeight = 100;
	}
	document.getElementById("menuContent").style.height = contentDivHeight;
	document.getElementById("personalFlagFrm").style.height = contentDivHeight;
}


function clickMenu(subMenu){
	
	document.all.menuContent.style.display = "";
	document.all.personalFlagDiv.style.display = "none";
	document.all.personalFlagFrm.src = "";
	
	var divObj = document.getElementsByTagName("div");
	var menuNumber = divObj.length;
	for(i=0;i<menuNumber;i++){
		if(divObj[i].parentNode.id == "menuContent" && divObj[i].style.display =="block" && divObj[i].id != subMenu){
			divObj[i].style.display = "none";
		}
	}
	document.getElementById(subMenu).style.display = "block";



	for(i=0;i<menuNumber;i++){	
		if(eval(document.getElementById("mt"+i)) != undefined && eval(document.getElementById("mt"+i)) != null)
			eval(document.getElementById("mt"+i)).className = "menuTitle";		
	}
	if(event.srcElement.tagName =="IMG"){event.srcElement.parentNode.className = "menuTitleDown";}
	if(event.srcElement.tagName =="DIV"){event.srcElement.className = "menuTitleDown";}
}
function clickPerson()
{
	document.all.menuContent.style.display = "none";
	document.all.personalFlagDiv.style.display = "";
	document.all.personalFlagFrm.src = "http://www.baidu.com";
	var divObj = document.getElementsByTagName("div");
	var menuNumber = divObj.length;
	for(i=0;i<menuNumber;i++){
		if(divObj[i].parentNode.id == "menu"){
			divObj[i].className = "menuTitle";
		}
	}
	if(event.srcElement.tagName =="IMG"){event.srcElement.parentNode.className = "menuTitleDown"; document.getElementById("menuWord").innerText = event.srcElement.parentNode.innerText;}
	if(event.srcElement.tagName =="DIV"){event.srcElement.className = "menuTitleDown";document.getElementById("menuWord").innerText = event.srcElement.innerText;}

}

function overMenu(string1){}
function outMenu(string1){}


function opFolder(divId,folderId,signicon){
	if(document.getElementById(divId).style.display == "none"){
		document.getElementById(divId).style.display = "block";
		document.getElementById(folderId).src= "<%=strContextPath%>/images/folder_open.gif";
		document.getElementById(signicon).src= "<%=strContextPath%>/images/folder_subtraction.gif";
	}else{
			document.getElementById(divId).style.display = "none";
			document.getElementById(folderId).src= "<%=strContextPath%>/images/folder.gif";
			document.getElementById(signicon).src= "<%=strContextPath%>/images/folder_plus.gif";
	}
}
function openFolder(divId,folderId,signicon){
		document.getElementById(divId).style.display = "block";
		document.getElementById(folderId).src= "<%=strContextPath%>/images/folder_open.gif";
		document.getElementById(signicon).src= "<%=strContextPath%>/images/folder_subtraction.gif";
}

function setCurrentColor(tdId){
var currentBgColor   = "#0071ef";
var currentFontColor = "#ffffff";

var tdCol=document.getElementsByTagName("TD");
for(i=0;i<tdCol.length;i++){
	if(tdCol[i].style.backgroundColor == currentBgColor){
		tdCol[i].style.backgroundColor = "";
		tdCol[i].style.color  = "";
	}
}
	document.getElementById(tdId).style.backgroundColor  = currentBgColor;
	document.getElementById(tdId).style.color  = currentFontColor;
}


function loadModule(prename,name,lefturl,workurl)
{
	

	if(lefturl=="<%=strContextPath%>/")
	{
		top.mainIframe.mainCenter.contentFrame.location.href=workurl;
		
		//alert(top.mainIframe.mainCenter.contentFrame.location.href);
	}
	else
	{
		t="<%=strContextPath%>/jsp/main/main_index.jsp";
		
		top.leftUrl=lefturl;
		top.workUrl=workurl;
		top.mainIframe.mainCenter.contentFrame.location.href=t;
	}
}

</script>
</head>

<body onload="beforeDone();" id="leftBody" class="leftBody" scroll="no" oncontextmenu="window.event.returnValue=false" onselectstart ="return false" onselect="document.selection.empty()">


<div id="leftTree"></div>

</body>
</html>
<script language="javascript">

function beforeDone(){
	top.span_report_tree.value = "1";
}
</script>