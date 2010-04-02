
function showHideDiv(divId){if(document.getElementById(divId).style.display == "none"){document.getElementById(divId).style.display = "block";	}else{document.getElementById(divId).style.display = "none";}}
function showDiv(divId){document.getElementById(divId).style.display = "block";}
function hideDiv(divId){document.getElementById(divId).style.display = "none";}


function float1(){
	top.showDiv("popTable");
	parent.centerContentFrame.rows = "0,*,0";
	parent.centerContentFrame.frameSpacing = "0";
	parent.bottomNull.location.href = "pop.htm"
}

function resizePopTable(){
	parent.popTable.style.width = "800px";
	parent.popTable.style.height = "200px";
	document.getElementById("arrow2").style.display = "none";
	document.getElementById("rightTd").style.display = "block";
	//document.getElementById("rightTd").style.width = "70%";
}
function revertPopTable(){
	parent.popTable.style.width = "320px";
	document.getElementById("arrow2").style.display = "block";
	document.getElementById("rightTd").style.display = "none";
	document.getElementById("rightTd").style.width = "70%";
}
function changeTab(pNumber,tabId,currId){
	for(i=1;i<pNumber;i++){document.getElementById(tabId+i).style.backgroundColor="#ffffff"; }
	document.getElementById(tabId+currId).style.backgroundColor="#cccccc"; 
}

//from v8_12_0621contact

function openpopPad() {
	document.getElementById("popPad").style.left = document.getElementById("popTable1").offsetLeft;
	document.getElementById("popPad").style.top = document.getElementById("popTable1").offsetTop;
	document.getElementById("popPad").style.width = document.getElementById("popTable1").offsetWidth;
	document.getElementById("popPad").style.height = document.getElementById("popTable1").offsetHeight;
	document.getElementById("popPad").style.visibility = "visible";
}

function goTop(){
	mainIframe.centerContentFrame.rows = "150,*";  //????????
	document.getElementById("popTable1").style.top ="95px";   //??float?y??
	//document.getElementById("popTable1").style.left ="202px";   //??float?x??
	//document.getElementById("popTable1").style.width =mainIframe.frames[1].document.body.clientWidth;    //??float???
	document.getElementById("popTable1").style.height =150-26;    //??float???
	document.getElementById("popTableTitle").style.display ="none";	    //??float?????
	document.getElementById("inHandle").style.display ="block";	    //??float????
	document.getElementById("floatHandle").style.display ="none";	    //??float????
	document.getElementById("onTop").style.display ="block";	    //????????
	document.getElementById("popTable1").style.zIndex ="0";	    //??float?????
	document.getElementById("popTable1").style.borderWidth ="0px";    //??float???
	document.getElementById("popTable1").style.borderTop    ="1px solid #6D6D6D";    //??float????
	offsetSize = 26;    //??????
	isMesFloat = 0;    //??float???????
	document.getElementById("popPad").style.visibility = "hidden";
}
	
function goFloat(){
	mainIframe.centerContentFrame.rows = "0,*";  //????????
	document.getElementById("popTable1").style.top ="320px";   //??float?x??
	document.getElementById("popTable1").style.left ="400px";   //??float?y??
	document.getElementById("popTable1").style.width ="620px";    //??float???
	document.getElementById("popTable1").style.height ="130px";    //??float???
	document.getElementById("popTableTitle").style.display ="block";	    //??float?????
	document.getElementById("inHandle").style.display ="none";	    //??float????
	document.getElementById("floatHandle").style.display ="block";	    //??float????
	document.getElementById("onTop").style.display ="none";	    //????????
	document.getElementById("popTable1").style.zIndex ="10010";	    //??float?????
	document.getElementById("popTable1").style.borderWidth ="1px";    //??float???
	document.getElementById("popTable1").style.borderTop    ="1px solid #7191C1";    //??float????
	document.getElementById("popTable1").style.borderRight  ="1px solid #7191C1";    //??float????
	offsetSize = 50;    //??????
	isMesFloat = 1;    //??float???????
	openpopPad();
}

function closeFloat(){
	mainIframe.centerContentFrame.rows = "0,*";  //
	document.getElementById("popTable1").style.display ="none";   
	document.getElementById("popPad").style.visibility ="hidden";
	

	if(document.getElementById("mesIconTable").getElementsByTagName("td").length >1 ){
		document.getElementById("ban_bottom_middle").src = "images/ban_bottom_middle_twinkling.gif";
	}
	else{
		document.getElementById("ban_bottom_middle").src='images/ban_bottom_middle01.gif';
	}
	
}

function openFloat(isSH){
	if(isMesFloat == 0){
		if(mainIframe.centerContentFrame.rows == "0,*"){
			mainIframe.centerContentFrame.rows = "150,*";
			document.getElementById("popTable1").style.height =150-29;
			document.getElementById("popTable1").style.zIndex ="0";
			document.getElementById("popTable1").style.display ="block";
			document.getElementById("ban_bottom_middle").src = "images/ban_bottom_middle01.gif";
		}
		else{
			if(isSH){
				closeFloat();
			}
		}
	}
	if(isMesFloat == 1){
		if(document.getElementById("popTable1").style.display != "none"){ 
		if(isSH){
				document.getElementById("popTable1").style.display = "none";
				closeFloat();
				}
		}
		else{ 
			document.getElementById("popTable1").style.display = "block";
			openpopPad();
			document.getElementById("ban_bottom_middle").src = "images/ban_bottom_middle01.gif";
		}
	}
}

function banMiddleOutSrc(){
	if(document.getElementById("mesIconTable").getElementsByTagName("td").length >1 && document.getElementById("popTable1").style.display =="none"){
		document.getElementById("ban_bottom_middle").src='images/ban_bottom_middle_twinkling.gif';
	}
	else{
		document.getElementById("ban_bottom_middle").src='images/ban_bottom_middle01.gif';
	}
}
/*
??popTable1
*/
function showPopTable(){
	document.getElementById("popTable1").style.display = "block";
	if(isMesFloat == 2){
					mainIframe.centerContentFrame.rows = "150,*,"+mainIframe.frames[3].document.body.clientHeight+"";
					isMesFloat = 0;
	}
}

function ywTab(interactionID){ //??????
	//?4????????????????
	/*
	var mesIconNumber = document.getElementById("mesIconTable").getElementsByTagName("td").length-1;   //????	
	for(i=0;i<=mesIconNumber;i++){document.getElementById("mesIconTable").getElementsByTagName("td")[i].className = "class0";}
	if(event.srcElement.tagName == "IMG"){event.srcElement.parentNode.className = "class1";}
	if(event.srcElement.tagName == "TD") {event.srcElement.className = "class1";}
	*/
	var iconTds = document.getElementById("mesIconTable").getElementsByTagName("td");
	for(i =0;i<iconTds.length;i++){
		if(iconTds[i].id=="pop_ico_td_"+interactionID){
			iconTds[i].className = "class1";
		}else{
			iconTds[i].className = "class0";
		}
	}
	
	if(isMesFloat==0 || document.getElementById("popTable1").style.height=="0px"){
		mainIframe.centerContentFrame.rows = "150,*"
		document.getElementById("popTable1").style.height ="121px";
	}
		//document.getElementById("popIframe").src=url;
	var popRows = document.getElementById("popIframeTable").rows;

	for(i=0;i<popRows.length;i++){
		if(popRows[i].id=='pop_iframe_tr_'+interactionID){
			popRows[i].style.display = 'block';
			try{
			document.getElementById('pop_iframe_'+interactionID).focus();
			}catch(e){
				//alert(e.description);
			}
		}else{
			popRows[i].style.display = 'none';
		}
	}
}
function dbClickBar(){
	if(isMesFloat == 0){
			if(document.getElementById("popTable1").style.height == "0px"){
					mainIframe.centerContentFrame.rows = "150,*";
					document.getElementById("popTable1").style.height ="124px";
					//document.getElementById("popIframeTable").style.display="block";
				}
			else{
					mainIframe.centerContentFrame.rows = "27,*";
					document.getElementById("popTable1").style.height ="0px";
					//document.getElementById("popIframeTable").style.display="none";
				}
	}
}


function addCell(inType,tdId){
		   switch (inType){
		   case "tel":  func="common/pop_tel.htm";   funi="images/tel_icon1.gif";  funurl="common/tel.htm";  break;
		   case "mail": func="common/pop_mail.htm"; funi="images/mail_icon1.gif"; funurl="common/sendmail.htm"; break;
		   case "chat": func="common/pop_chat.htm";  funi="images/chat_icon1.gif"; funurl="common/chat.htm"; break;
			}

			var xx =document.getElementById("mesIconTable").getElementsByTagName("tr")[0].insertCell();
				xx.id = tdId;
				xx.style.cssText="width:29px; text-align:center;cursor:pointer;";
				xx.onclick=function (){ywTab(func)}
				
				var newCellString = "";
				newCellString += "<img src='"+funi+"' width='15' height='14' border='0' align='absmiddle' onClick='addTab(\"chat\",\"chat\",\""+funurl+"\")'>";
				xx.innerHTML = newCellString;
}

/*
????
*/
function clickPopIco(interactionID){
	var objIcoTd = document.getElementById("pop_ico_td_"+interactionID);
	if(!isNull(objIcoTd)){
		objIcoTd.click();
	}
}
function addPopCell(mediaType,interactionID,url,detailUrl){	
//var MEDIATYPE_VOICE = 0;
//var MEDIATYPE_EMAIL = 1;
//var MEDIATYPE_CHAT = 2;
//var MEDIATYPE_SMS = 3;
//var MEDIATYPE_FAX = 4;
//var MEDIATYPE_MAIL = 5;
		if(mediaType==0){
			funi="images/tel_icon1.gif";
		}else if(mediaType==1){
			funi="images/mail_icon1.gif";
		}else if(mediaType==2){
			funi="images/chat_icon1.gif";
		}else if(mediaType==3){
			funi="images/sms_icon.gif";
		}else if(mediaType==4){
			funi="images/fax_icon.gif";
		}else if(mediaType==5){
			funi="images/ymail_icon.gif";
		}else{
			funi="images/chat_icon1.gif";
		}
		
		//showPopTable();
		openFloat();
		//??
		var objIcoTd = document.getElementById("pop_ico_td_"+interactionID);
		if(isNull(objIcoTd)){
			//objIcoTd =document.getElementById("mesIconTable").getElementsByTagName("tr")[0].insertCell();
			objIcoTd = document.createElement("TD");
			document.getElementById("mesIconTable").getElementsByTagName("tr")[0].appendChild(objIcoTd);
			objIcoTd.id = "pop_ico_td_"+interactionID;
			objIcoTd.style.cssText="width:29px; text-align:center;cursor:pointer;";
			
			var newCellString = "";
			newCellString += "<img src='"+funi+"' width='15' height='14' border='0' align='absmiddle' ";
				if(detailUrl!=null&&detailUrl!=undefined&&detailUrl!=''){
					newCellString +="onClick='addTab(\"chat\",\"chat\",\""+funurl+"\")'";
				}
			newCellString += ">";
			objIcoTd.innerHTML = newCellString;
		}
		
		//iframe
		var objIframeTr = document.getElementById("pop_iframe_tr_"+interactionID);
			if(isNull(objIframeTr)){
				objIframeTr = document.getElementById("popIframeTable").insertRow();
				objIframeTr.id="pop_iframe_tr_"+interactionID;
				objIframeTr.style.display="none";
				var objTd = objIframeTr.insertCell();
				objTd.style.height='100%';
				var html ="";
				html+="<iframe id='pop_iframe_"+interactionID+"' src='"+url+"'"; 
				html+=" frameborder='0'                            ";
				html+=" allowtransparency='yes'                    ";
				html+=" hspace='0'                                 ";
				html+=" marginheight='0'                           ";
				html+=" marginwidth='0'                            ";
				html+=" width='100%'                               ";
				html+=" height='100%'>";
				html+=" </iframe>";
				objTd.innerHTML = html;
			}
		
		objIcoTd.onclick=function (){ywTab(interactionID)};
		objIcoTd.click();
}

function delPopCell(interactionID){
	try{
		var objIcoTd = document.getElementById("pop_ico_td_"+interactionID);
		var objIframeTr = document.getElementById("pop_iframe_tr_"+interactionID);

			var iconTds = document.getElementById("mesIconTable").getElementsByTagName("td");
			var objNext = null;
			if(iconTds.length<2){
			
			}else if(objIcoTd.cellIndex==iconTds.length-1){
				objNext = iconTds[1];
			}else{
				objNext = objIcoTd.nextSibling;
			}
			
			if(!isNull(objIcoTd)){
				objIcoTd.removeNode(true);
			}
			
			if(!isNull(objIframeTr)){
				try {
					document.getElementById('pop_iframe_'+interactionID).contentWindow.getElementById('popIframeInfo').contentWindow.location.href ='about:blank';
					document.getElementById('pop_iframe_'+interactionID).contentWindow.getElementById('popIframeSummary').contentWindow.location.href ='about:blank';
					document.getElementById('pop_iframe_'+interactionID).contentWindow.getElementById('popIframeCustomerInfo').contentWindow.location.href ='about:blank';
					document.getElementById('pop_iframe_'+interactionID).contentWindow.getElementById('popIframeHistory').contentWindow.location.href ='about:blank';
				}catch(e){}
				document.getElementById('pop_iframe_'+interactionID).contentWindow.location.href ='about:blank';
				objIframeTr.removeNode(true);
			}
			
			if(!isNull(objNext)){
				objNext.click();
			}
		
		
	}catch(e){
		//alert(e.description);
	}
	
	try{
		var iconTds = document.getElementById("mesIconTable").getElementsByTagName("td");
		if(iconTds.length==1){
			closeFloat();
		}
	}catch(e){
		
	}
	try{
		top.resetValues();
	}catch(e){
		
	}
	try{
		top.setPhoneNumberFocus();
	}catch(e){
		//alert(e.description);
	}
	
	
}

function getPopIframeByInteractionID(interactionID){
	var rnt = null;
	try{
		rnt = document.frames("pop_iframe_"+interactionID);
	}catch(e){
		//alert(e.description);
	}
	return rnt;
	//return document.getElementById("pop_iframe_"+interactionID);
}
function delCell(tdId){
	if(document.getElementById(tdId)){
		ccc = document.getElementById(tdId).cellIndex;
		document.getElementById("mesIconTable").getElementsByTagName("tr")[0].deleteCell(ccc);
	}
}
