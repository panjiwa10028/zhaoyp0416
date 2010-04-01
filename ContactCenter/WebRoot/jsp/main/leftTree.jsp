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
	width:180px;
	overflow:hidden;
	font-weight:bold;
	white-space:nowrap;
	padding:5px 2px 2px 24px;
	cursor:pointer;
	color:#434343;
	margin-left:6px;
	margin-right:6px;
	
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
	width:180px;
	overflow:hidden;
	white-space:nowrap;
	padding:5px 0px 0px 24px;
	cursor:pointer;
	font-weight:bold;
	margin-left:6px;
	margin-right:6px;
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
#handle { 
	height:8px;	
	font-size:1px;
	text-align:center;
	cursor:pointer;
}
</style>

<script src="<%=strContextPath%>/script/common.js"></script>
<script src="<%=strContextPath%>/script/url.js" language="JavaScript" type="text/javascript"></script>
<script type="text/javascript" src="<%=strContextPath%>/script/contactCommon/dtree4.js"></script>
<script language="javascript" type="text/javascript">
//var y='ac';

function copyTree(treeTemp,tree)
{
	// 为本页面构造一棵新的数
	//tree = new dTree('tree');

	// 拷贝配置
	tree.config = treeTemp.config;
	
	// 拷贝ico路径
	tree.icon = treeTemp.icon;
	
	// 拷贝节点数据
	//tree.aNodes=treeTemp.aNodes;
	//tree.aIndent = treeTemp.aIndent;
	
	for(var i = 0; i < treeTemp.aNodes.length; i++)
	{
		tree.add(treeTemp.aNodes[i].id,
			treeTemp.aNodes[i].pid, 
			treeTemp.aNodes[i].name, 
			treeTemp.aNodes[i].isType, 
			treeTemp.aNodes[i].isChecked, 
			treeTemp.aNodes[i].isDisabled, 
			treeTemp.aNodes[i].url,
			treeTemp.aNodes[i].title, 
			treeTemp.aNodes[i].target,
			treeTemp.aNodes[i].icon, 
			treeTemp.aNodes[i].iconOpen, 
			treeTemp.aNodes[i].open);
	}
	
	for(var i=0; i < treeTemp.aIndent.length; i++)
	{
		tree.aIndent[i] = treeTemp.aIndent[i];
	}
	
	tree.selectedNode = treeTemp.selectedNode;
	tree.selectedFound = treeTemp.selectedFound;
	tree.completed = treeTemp.completed;
	return tree;
}

var cTree=new dTree('cTree');
//cTree=copyTree(top.businessExecTree,cTree);
if (top.strProductId == 'Campaign')
{
	cTree=copyTree(top.campaignTree,cTree);
}
/*alert(cTree.aNodes[1].id);
top.businessExecTree.aNodes[1].id='w3';
alert(top.businessExecTree.aNodes[1].id);
alert(cTree.aNodes[1].id);*/
//alert(cTree);

//var treeTemp=new dTree('treeTemp');
//var bbTree=new dTree('bbTree');
/*for(var p in top.businessExecTree){

try{
	bbTree[p] = businessExecTree[p];
	alert(p.toString());
	}catch(e){alert(e.descrition);break;}
}*/


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
function showFaq(url){
	if(event.srcElement){//處理文字背景顔色
			var fff = document.getElementsByTagName("span");
			for(fi=0;fi<fff.length;fi++){
				if(fff[fi].style.backgroundColor = "#7cafda"){
					fff[fi].style.backgroundColor = "";
					fff[fi].style.color = "#666666";
				}
			}
			//alert(event.srcElement.tagName);
			if(event.srcElement.tagName =="IMG"){
				event.srcElement.parentElement.style.backgroundColor = "#7cafda";
				event.srcElement.parentElement.style.color = "#ffffff";
			}
			//else if(){}
			else{
				event.srcElement.style.backgroundColor = "#7cafda";
				event.srcElement.style.color = "#ffffff";
			}
	}
	if(top.isFaqFloat == 0){//嵌入bottom情况下，直接在bottomframe打开url
		top.mainIframe.bottomNull.location.href=url;
	}
	
	if(top.isFaqFloat == 1){//浮动情况下，直接在浮动窗体打开url
		top.popFaqFrame.src=url;
	}
	
	if(top.isFaqFloat == 2){//关闭情况下，打开窗体并在浮动窗体打开url
		top.popTable2.style.display = "block";
		top.popFaqFrame.src=url;
	}	
}

function openFaq(url){
	if(event.srcElement){//處理文字背景顔色
			var fff = document.getElementsByTagName("span");
			for(fi=0;fi<fff.length;fi++){
				if(fff[fi].style.backgroundColor = "#7cafda"){
					fff[fi].style.backgroundColor = "";
					fff[fi].style.color = "#666666";
				}
			}
			//alert(event.srcElement.tagName);
			if(event.srcElement.tagName =="IMG"){
				event.srcElement.parentElement.style.backgroundColor = "#7cafda";
				event.srcElement.parentElement.style.color = "#ffffff";
			}
			//else if(){}
			else{
				event.srcElement.style.backgroundColor = "#7cafda";
				event.srcElement.style.color = "#ffffff";
			}
	}
window.open(""+url+"","faq","toolbar=no,location=no,status=yes,menubar=no,scrollbars=no,resizable=yes");
}

var activityTree = null;
var isNotNullActivityTreeList = false;
function getActivityTree(){
		var list;
		try{
			list = top.getActivityTreeList().list;
			if(list.length>0){
				isNotNullActivityTreeList = true;
			}else{
				try{
					document.getElementById("activityExecRootTree").style.display="none";
				}catch(e){
				}
			}
		}catch(e){
		}
		activityTree = new dTree('activityTree');
		activityTree.config.useCookies = true;
		// 不使用点击节点收缩树结构
		activityTree.config.folderLinks = true;
		
		// 添加节点 
		//'<%=strContextPath%>/jsp/ActivityExec/leftView.jsp?lUserId='+top.getUserId()+'&strUserName='+top.getUserName()+'&lTenantId='+top.getTenantId()
		activityTree.add('0','-1','', 'true', '', '', '');
		for(var i=0;i<list.length;i++){
			var nType = '';
			if(list[i].map.NTYPE==1){
				nType = 'true';
			}
			var url ='';
			if(list[i].map.NTYPE==0){
				url="javascript:top.viewActivity("+list[i].map.LID+");";
			}
			var img ='';
			if(list[i].map.NOUTBOUNDMODE==1){
				img="<%=strContextPath%>/images/waibo_man.gif";
			}else if(list[i].map.NOUTBOUNDMODE==3||list[i].map.NOUTBOUNDMODE==4||list[i].map.NOUTBOUNDMODE==5){
				img="<%=strContextPath%>/images/waibo_auto.gif";
			}
			activityTree.add(list[i].map.LID,
				list[i].map.LCAMPAIGNID,
				list[i].map.STRNAME,
				nType,
				'',
				'',
				url,
				'',
				'',
				img,
				''
				);
		}
	return activityTree;
}

function showActivityExecList(){
	//判断一下是不是有活动
	if(isNotNullActivityTreeList){
		top.showActivityExecList();
	}
}

var CURRENTSELECTEDITEM = "";

function loadinfo() {

	document.getElementById("leftTree").innerHTML=top.document.getElementById("leftTree").innerHTML;

//document.getElementById('mc'+top.firstflag).style.display= "block";
//document.getElementById("menuWord").innerText = document.getElementById('mt'+top.firstflag).innerText;
var firstClickDiv = document.getElementById('mt'+top.firstflag);
if (firstClickDiv != undefined) {
	var strFCName = firstClickDiv.name;
	CURRENTSELECTEDITEM = strFCName;
	autoClickDiv(strFCName);
}
initSize();
}

function autoClickDiv(str){
	var arp1 = document.getElementsByTagName("DIV");
	for(var m=0;m<arp1.length;m++){
		if(str == arp1[m].name){
			arp1[m].click();
			return;
		}
	}
}

function changeDivItem(str){
	var arp1 = document.getElementsByTagName("DIV");
	for(var m=0;m<arp1.length;m++){
		if(str == arp1[m].name){
			if(CURRENTSELECTEDITEM == str){
				arp1[m].click();
				return;
			}
		}
	}
}

var handleStat = 1;//全局变量，菜单状态,1=bar状大菜单,0=icon状小菜单

function initSize(){//页面加载初始尺寸
	var menuNumber = document.getElementById("menu").getElementsByTagName("div").length;//主菜单数
	var bheight = window.document.body.offsetHeight-8-57;
	var contentDivHeight;
	
	if(bheight > menuNumber*25){contentDivHeight = bheight - menuNumber*25;}
	else{contentDivHeight = 100;}
		document.getElementById("menuContent").style.height = contentDivHeight;
		document.getElementById("personalFlagFrm").style.height = contentDivHeight;
}

function reSizePage(){//resize重绘各部分
	var menuNumber = document.getElementById("menu").getElementsByTagName("div").length;//主菜单数
	var bheight = window.document.body.offsetHeight-38;
	var contentDivHeight;
	
	if(bheight > menuNumber*25+100){
		if(handleStat ==1){
			contentDivHeight = bheight - menuNumber*25;
		}
		else{
			contentDivHeight = bheight - 25;
		}
		
	}
	else{
		contentDivHeight = 100;
	}
	
	document.getElementById("menuContent").style.height = contentDivHeight;
	document.getElementById("personalFlagFrm").style.height = contentDivHeight;
}


/*function clickMenu(subMenu){
	
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
		if(divObj[i].parentNode.id == "menu"){
			divObj[i].className = "menuTitle";
		}
	}
	if(event.srcElement.tagName =="IMG"){event.srcElement.parentNode.className = "menuTitleDown"; document.getElementById("menuWord").innerText = event.srcElement.parentNode.innerText;}
	if(event.srcElement.tagName =="DIV"){event.srcElement.className = "menuTitleDown";document.getElementById("menuWord").innerText = event.srcElement.innerText;}
}*/

//记住当前点击的导航栏的名字
function rememberClickItemName(){
	var srcD = event.srcElement;
	if(srcD.tagName == "SPAN"){
		srcD = srcD.parentNode;
	}else if(srcD.tagName == "IMG"){
		srcD = srcD.parentNode;
	}
	if(srcD.tagName == "DIV"){
		CURRENTSELECTEDITEM = srcD.name;
	}
}

function clickPerson(url)
{
	if (getUrl != undefined) {
		url = getUrl(url);
	}
	
	document.all.menuContent.style.display = "none";
	document.all.personalFlagDiv.style.display = "";
	document.all.personalFlagFrm.src = url;
	
	rememberClickItemName();
	
	var divObj = document.getElementsByTagName("div");
	var menuNumber = divObj.length;
	
	for(i=0;i<menuNumber;i++){
		if(divObj[i].parentNode.id == "menu"){
			divObj[i].className = "menuTitle";
		}
	}
	if(event.srcElement.tagName =="IMG"){event.srcElement.parentNode.className = "menuTitleDown"; top.document.getElementById("menuSelectedWord").innerText = event.srcElement.parentNode.innerText;}
	if(event.srcElement.tagName =="SPAN"){event.srcElement.parentNode.className = "menuTitleDown"; top.document.getElementById("menuSelectedWord").innerText = event.srcElement.parentNode.innerText;}
	if(event.srcElement.tagName =="DIV"){event.srcElement.className = "menuTitleDown";top.document.getElementById("menuSelectedWord").innerText = event.srcElement.innerText;}

}

function clickMenu(subMenu){

	document.all.menuContent.style.display = "";
	document.all.personalFlagDiv.style.display = "none";
	document.all.personalFlagFrm.src = "";
	
	rememberClickItemName();
	
	var divObj = document.getElementsByTagName("div");
	var menuNumber = divObj.length;
	for(i=0;i<menuNumber;i++){
		if(divObj[i].parentNode.id == "menuContent" && divObj[i].style.display =="block" && divObj[i].id != subMenu){
			divObj[i].style.display = "none";
		}
	}
	document.getElementById(subMenu).style.display = "block";

	for(i=0;i<menuNumber;i++){
		if(divObj[i].parentNode.id == "menu"){
			divObj[i].className = "menuTitle";
		}
	}
	if(event.srcElement.tagName =="IMG"){event.srcElement.parentNode.className = "menuTitleDown"; top.document.getElementById("menuSelectedWord").innerText = event.srcElement.parentNode.innerText;}
	if(event.srcElement.tagName =="SPAN"){event.srcElement.parentNode.className = "menuTitleDown"; top.document.getElementById("menuSelectedWord").innerText = event.srcElement.parentNode.innerText;}
	if(event.srcElement.tagName =="DIV"){event.srcElement.className = "menuTitleDown";top.document.getElementById("menuSelectedWord").innerText = event.srcElement.innerText;}
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



//-------------------------for handle
function handleHover(){
	document.getElementById("handle").style.backgroundImage   = "url(<%=strContextPath%>/images/handle_hover_bg.gif)";
	document.getElementById("handleOpenImg").src  = "<%=strContextPath%>/images/handle_bar_hover_tri.gif";
	document.getElementById("handleCloseImg").src  = "<%=strContextPath%>/images/handle_icon_hover_tri.gif";
	
}

function handleDown(){
	document.getElementById("handle").style.backgroundImage   = "url(<%=strContextPath%>/images/handle_down_bg.gif)";
	document.getElementById("handleOpenImg").src  = "<%=strContextPath%>/images/handle_bar_down_tri.gif";
	document.getElementById("handleCloseImg").src  = "<%=strContextPath%>/images/handle_icon_down_tri.gif";
}

function handleOut(){
	document.getElementById("handle").style.backgroundImage   = "url(<%=strContextPath%>/images/handle_normal_bg.gif)";
	document.getElementById("handleOpenImg").src  = "<%=strContextPath%>/images/handle_bar_normal_tri.gif";
	document.getElementById("handleCloseImg").src  = "<%=strContextPath%>/images/handle_icon_normal_tri.gif";
}

function handleClick(){
var menuNumber = document.getElementById("menu").getElementsByTagName("div");//主菜单数
	if(handleStat == 1){//变成icon状
		
		document.getElementById("menuContent").style.height   = window.document.body.offsetHeight-57 - 25 -8;
		document.getElementById("personalFlagFrm").style.height   = window.document.body.offsetHeight-38-25;
		document.getElementById("menu").style.overflow   = "hidden";
		document.getElementById("menu").style.height   = "25px";
		document.getElementById("menu").style.width   = "180px";
		document.getElementById("menu").style.backgroundImage   = "url(<%=strContextPath%>/images/mt_bg.gif)";
		document.getElementById("menu").style.textAlign   = "center";
		
		
		for(i=0;i<menuNumber.length;i++){
		menuNumber[i].getElementsByTagName("SPAN")[0].style.display = "none";
		menuNumber[i].style.display = "inline";
		menuNumber[i].style.width  = "20px";
		menuNumber[i].style.height = "25px";
		//menuNumber[i].style.padding = "5px 0px 0px 0px";
		menuNumber[i].title = menuNumber[i].getElementsByTagName("SPAN")[0].innerText;
		
		document.getElementById("handleOpenImg").style.display = "none";
		document.getElementById("handleCloseImg").style.display = "";
		
		
		}
		handleStat = 0;
	}
	else{ //恢复成bar状菜单
		initSize();
		document.getElementById("menu").style.overflow   = "";
		document.getElementById("menu").style.height   = 25*menuNumber.length;
		document.getElementById("menu").style.backgroundImage   = "";
		document.getElementById("menu").style.textAlign   = "";
		document.getElementById("menu").style.width   = "180px";
		
		for(i=0;i<menuNumber.length;i++){
		menuNumber[i].getElementsByTagName("SPAN")[0].style.display = "";
		menuNumber[i].style.display = "";
		menuNumber[i].style.width  = "180px";
		menuNumber[i].style.padding = "5px 2px 2px 24px";
		menuNumber[i].title = "";
		
		
		document.getElementById("handleOpenImg").style.display = "";
		document.getElementById("handleCloseImg").style.display = "none";
		
		
		}
		handleStat = 1;
	}
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

<body onload="beforeDone();" id="leftBody" class="leftBody" scroll="no" onresize="initSize();" oncontextmenu="window.event.returnValue=false" onselectstart ="return false" onselect="document.selection.empty()">


<div id="leftTree"></div>

</body>
</html>



<script language="javascript">
function campaignLeftTreeOut(_campaignTree)
{
	cTree=new dTree('cTree');
	//cTree=copyTree(top.businessExecTree,cTree);	
	cTree=copyTree(_campaignTree,cTree);
	bTree[2].innerHTML = cTree.toString();
}
function beforeDone(){
	top.span_report_tree.value = "1";
}
</script>