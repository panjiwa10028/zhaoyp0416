function initSize(){
var tbHeight = top.document.documentElement.clientHeight - top.document.getElementById("topDiv").offsetHeight-32; //??index??
	
	document.getElementById("topArea").style.height = tbHeight-75;//topArea????????125????????125=25*5
}

function addTab(text,workurl,lefturl){
	if(parent.mainCenter.tabFrame.document.getElementById(text)){//?????????????????????????????????ok?
	
	} 
	
	//????????????????
	else{
	parent.mainCenter.tabFrame.document.getElementById("TabAreaTr").insertCell().innerHTML +="<td><table  border='0' cellspacing='0' cellpadding='0' id='"+text+"' title='"+text+"'><tr style='cursor:pointer' onclick='parent.contentFrame.workArea.location.href=\""+workurl+"\",parent.contentFrame.leftView.location.href=\""+lefturl+"\"'><td width='4'><img src='/BusinessCenter/images/tab_cu_l1.gif' width='4' height='27' border='0'></td><td background='/BusinessCenter/images/tab_cu_l2.gif'  align='center' style='padding-top:3px;white-space:nowrap;color:black;'>"+text+"</td><td width='10' align='center' background='/BusinessCenter/images/tab_cu_l2.gif'><img src='/BusinessCenter/images/tab_close1.gif' width='8' height='8' border='0' alt='Close this tab' onclick='document.getElementById(\"TabAreaTr\").deleteCell(window.event.srcElement.parentElement.parentElement.parentElement.parentElement.parentElement.cellIndex);return false;'></td><td width='4'><img src='/BusinessCenter/images/tab_cu_l3.gif' width='4' height='27' border='0'></td></tr></table></td>";
		//alert(parent.mainCenter.tabFrame.document.all("TabAreaTable").innerHTML);
	}
	//alert(workurl);
	parent.mainCenter.contentFrame.workArea.location.href=workurl;
	parent.mainCenter.contentFrame.leftView.location.href=lefturl;
	
}

function cmenu(menuId,itemId){
	for(i=1;i<4;i++){document.getElementById("menu"+i).className = "menu1";}
	document.getElementById("menu"+menuId).className = "menu2";
	if(itemId != null)
	{for(i=1;i<4;i++)
	{
	document.getElementById("menuItem"+i).style.display = "none";
	 document.getElementById(itemId).style.display = "block";}
	 }
}

function showHideDiv(divId){if(document.getElementById(divId).style.display == "none"){document.getElementById(divId).style.display = "block";	}else{document.getElementById(divId).style.display = "none";}}
function showDiv(divId){document.getElementById(divId).style.display = "block";}
function hideDiv(divId){document.getElementById(divId).style.display = "none";}