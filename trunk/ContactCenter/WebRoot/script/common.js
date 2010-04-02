// JavaScript Document

function showHideDiv(divId){if(document.getElementById(divId).style.display == "none"){document.getElementById(divId).style.display = "block";	}else{document.getElementById(divId).style.display = "none";}}
function showDiv(divId){document.getElementById(divId).style.display = "block";}
function hideDiv(divId){document.getElementById(divId).style.display = "none";}
function showMenu(divId){
	document.getElementById(divId).style.display = "block";
	document.getElementById("menuIfm").style.posLeft = document.getElementById(divId).offsetLeft;
	document.getElementById("menuIfm").style.posTop  = document.getElementById(divId).offsetTop;
	document.getElementById("menuIfm").style.width   = document.getElementById(divId).offsetWidth;
	document.getElementById("menuIfm").style.height  = document.getElementById(divId).offsetHeight;
	document.getElementById("menuIfm").style.display = "block";
	//if(event.srcElement.tagName=="A")event.srcElement.parentNode.style.backgroundColor = "#b1d1ed";
	//if(event.srcElement.tagName=="TD")event.srcElement.style.backgroundColor = "#b1d1ed";
}
function hideMenu(divId){
	document.getElementById(divId).style.display = "none";
	document.getElementById("menuIfm").style.display = "none";
	//if(event.srcElement.tagName=="A")event.srcElement.parentNode.style.backgroundColor = "";
	//if(event.srcElement.tagName=="TD")event.srcElement.style.backgroundColor = "";
}


function showHideADSearchDIV(divId)
{
	var searchDIV = document.getElementById(divId);
	if(searchDIV!=null )
	{
		if(ADSearchTD.innerHTML != "")
		{
			
				if(document.getElementById("ADSearchTD").style.display == 'none')
				{
					document.getElementById("ADSearchTD").style.display = 'block';
					setshAsSrc(true);
				}
				else
				{
					document.getElementById("ADSearchTD").style.display = 'none';
					setshAsSrc(false);
				}				
				
		}
		else
		{
		
				ADSearchTD.innerHTML = searchDIV.innerHTML;
				setshAsSrc(true);
			
		}
	}	
}
function resetAdSearchDIV(divId)
{
	var searchDIV = document.getElementById(divId);
	if(searchDIV!=null )
	{
		if(ADSearchTD.innerHTML != "")
		{
			ADSearchTD.innerHTML = "";
			ADSearchTD.innerHTML = searchDIV.innerHTML;
		}		
	}
}
function resetSearchDIV()
{
	if(document.getElementById(document.getElementById("appendFilterFieldName").value + "AppendValue") != undefined)
	{
		document.getElementById(document.getElementById("appendFilterFieldName").value + "AppendValue").value = "";
	}
	if(document.getElementById(document.getElementById("appendFilterFieldName").value + "StartAppendValue") != undefined)
	{
		document.getElementById(document.getElementById("appendFilterFieldName").value + "StartAppendValue").value = "";
	}
	if(document.getElementById(document.getElementById("appendFilterFieldName").value + "EndAppendValue") != undefined)
	{
		document.getElementById(document.getElementById("appendFilterFieldName").value + "EndAppendValue").value = "";
	}
	//fieldContainerTD.innerHTML = '&nbsp;';
}

function overColor(tdId){
var currentBgColor   = "#0071ef";
var currentFontColor = "#ffffff";

	tdId.style.backgroundColor  = currentBgColor;
	tdId.style.color  = currentFontColor;
}	
function outColor(tdId){
var currentBgColor   = "#ffffff";
var currentFontColor = "#000000";

	tdId.style.backgroundColor  = currentBgColor;
	tdId.style.color  = currentFontColor;
}


//for open float dropdown menu    ---------start
function showHideFloat(divId){
if(document.getElementById(divId)){
		if(document.getElementById(divId).style.display == "none"){
			top.setHideAllFloatMenu(document.getElementById(divId));
			document.getElementById(divId).style.display = "";
		}
		else{
			document.getElementById(divId).style.display = "none";
		}
	}
	return false;
}

//for download menu
function toggleDdropMenu(obj){
	if(document.getElementById(obj).style.display == "none"){
			hideDropMenu(obj);
			document.getElementById(obj).style.display = "block";
		
		if(document.getElementById(obj).offsetLeft + document.getElementById(obj).offsetWidth > document.body.offsetWidth){//position
			document.getElementById(obj).style.marginLeft = (event.srcElement.offsetWidth- document.getElementById(obj).offsetWidth)+"px";
		}
		if(document.getElementById(obj).offsetWidth < event.srcElement.offsetWidth){//width
			document.getElementById(obj).style.width = event.srcElement.offsetWidth +"px";
		}
	}
	else{
		document.getElementById(obj).style.display = "none";
	}
}
//for open float dropdown menuu    --------- end

//for close all float div
/*document.onclick = function changeDiv(id){     
	top.hideAllFloatMenu();
}*/
//define search method switcher [begin]
function hoverView(obj){
	document.getElementById(obj).style.backgroundColor = "#cccccc";

}

function outView(obj){
	document.getElementById(obj).style.backgroundColor = ""; 
}

function clickView(){
	if(document.getElementById('eViewOptions').style.display == "none"){document.getElementById('eViewOptions').style.display = "";}
	else{document.getElementById('eViewOptions').style.display = "none";}
}

function hoverViewMenu(){
	var menuTDs = document.getElementById("eViewOptions").getElementsByTagName("td");
	for(i=0; i<menuTDs.length; i++){
		menuTDs[i].style.backgroundColor = "#ffffff"; 
		menuTDs[i].style.color = "#000000"; 
	}
	
	event.srcElement.style.backgroundColor = "#0071ef"; 
	event.srcElement.style.color = "#ffffff"; 
}

function clickViewMenu(obj){
switch (obj){
	case "eViewInput":
		document.getElementById("eViewInput").style.display = "";
		document.getElementById("eColumnInput").style.display = "none";
		document.getElementById("eAdvancedInput").style.display = "none";
		//document.getElementById("eViewManage").style.display = "none";
		break;
	case "eColumnInput":
		document.getElementById("eViewInput").style.display = "none";
		document.getElementById("eColumnInput").style.display = "";
		document.getElementById("eAdvancedInput").style.display = "none";
		document.getElementById("eViewManage").style.display = "none";
		break;
	case "eAdvancedInput":
		document.getElementById("eViewInput").style.display = "none";
		document.getElementById("eColumnInput").style.display = "none";
		document.getElementById("eAdvancedInput").style.display = "";
		document.getElementById("eViewManage").style.display = "none";
		break;
		}
		document.getElementById("eViewText").innerText = event.srcElement.innerText;
}

function hideViewMenu(menuId){
	var timer = 300;
	//test();
		setTimeout("hideDiv('eViewOptions')",timer);
		document.body.setActive();
}

//------------------------------------------------
function checkViewGroup(divId,text1,text2){
	if(document.getElementById(divId).style.display == "none"){
		document.getElementById(divId).style.display = "";
		event.srcElement.innerText = text1;
	}
	else{
		document.getElementById(divId).style.display = "none";
		event.srcElement.innerText = text2;
		
	}
}

//----------------
function modifyView(){
	hideDiv('BT1');
	showDiv('BT2');
	hideDiv('xTable1');
	showDiv('xTable2');
	document.getElementById("viewName14").disabled = false;
	document.getElementById("checkViewGroup2").style.display ="";
}
function saveView(){
	showDiv('BT1');
	hideDiv('BT2');
	showDiv('xTable1');
	hideDiv('xTable2');
	document.getElementById("viewName14").disabled = true;
	document.getElementById("checkViewGroup2").style.display ="none";
}
function saveAsNewView(){
	document.getElementById("viewName14").disabled = false;
	document.getElementById("viewName14").focus();
}

//define tooltip message [start]
function setHelpMes(helpMessageText){
var minSize = 100;

if(document.getElementById("helpMessage") == null){
	var newRadioButton = document.createElement("<div id='helpMessage' style='position:absolute;display:; z-index:5; overflow:hidden; background-color:#f7f9ff; padding:5px; border:3px solid #6694e3;'></div>");
	newRadioButton.innerHTML = helpMessageText;
	document.body.insertBefore(newRadioButton);

	var newRadioShadow = document.createElement("<iframe id='helpIframe' style='position:absolute;display:; z-index:4;' scrolling='no' frameborder='0' hspace='0' longdesc='0' marginheight='0' marginwidth='0' vspace='0'></iframe>");
	document.body.insertBefore(newRadioShadow);
}
else{
			document.getElementById("helpMessage").innerHTML = helpMessageText;
			document.getElementById("helpMessage").style.display = "";
			document.getElementById("helpIframe").style.display = "";
	}

	//calc width
	if(document.getElementById("helpMessage").offsetWidth > document.body.offsetWidth -50){
		document.getElementById("helpMessage").style.width = document.body.offsetWidth -50;
	}

	//position x
	if((document.body.offsetWidth - event.clientX) < document.getElementById("helpMessage").offsetWidth){//óò±?????D?
		if(document.getElementById("helpMessage").offsetWidth < document.body.offsetWidth - event.clientX){
			document.getElementById("helpMessage").style.left = event.clientX + 12}
		else{
				if(document.getElementById("helpMessage").offsetWidth > event.clientX -50){document.getElementById("helpMessage").style.width = event.clientX -50;}
				document.getElementById("helpMessage").style.left = event.clientX - document.getElementById("helpMessage").scrollWidth-12;}
	}
	else{document.getElementById("helpMessage").style.left = event.clientX }

	//position y
	if((document.body.offsetHeight - event.clientY) < document.getElementById("helpMessage").offsetHeight){//??±?????
		if(document.getElementById("helpMessage").offsetHeight < document.body.offsetHeight - event.clientY){
			document.getElementById("helpMessage").style.top = event.clientY +12 }
		else{
			document.getElementById("helpMessage").style.top = event.clientY - document.getElementById("helpMessage").scrollHeight-12;}
	}
	else{document.getElementById("helpMessage").style.top = event.clientY +12}

//calc & pos Shadow
	document.getElementById("helpIframe").style.height = document.getElementById("helpMessage").offsetHeight;
	document.getElementById("helpIframe").style.width = document.getElementById("helpMessage").offsetWidth;
	document.getElementById("helpIframe").style.left = document.getElementById("helpMessage").offsetLeft;
	document.getElementById("helpIframe").style.top = document.getElementById("helpMessage").offsetTop;
}


function closeHelpMes(){
	if(document.getElementById("helpMessage") != null){
	if(event.srcElement.name != "setHelpIcon" && event.srcElement.name != "helpMessage"){
		document.getElementById("helpMessage").innerHTML = "";
		document.getElementById("helpMessage").style.display = "none";
		document.getElementById("helpIframe").style.display = "none";
		}
	}
}

//define tooltip message [end]





