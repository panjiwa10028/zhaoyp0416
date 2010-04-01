var MONITORSTATUS			=	"monitorStatus";
var currentAgentStatus		=	AGENT_STATE_NOTINUSE;
var STATUS_IDLE				=	2;			//idle
var STATUS_DIALING			=	54			//dialing
var STATUS_TALKING			=	55;			//talking
var STATUS_RINGING			=	56;			//ringing
var STATUS_HELD 			=	57;			//held
var STATUS_PARTY_DELETED	= 	59			//party deleted
var STATUS_TRANSFER_END		=	102;		//transfer end
var STATUS_CONFERENCE 		=	103;		//conference
var STATUS_CONFERENCE_END	=	104;		//conference end
var STATUS_PARTY_CHANGE     =   108;		//party change

var CALLTYPE_UNKNOWN  = 0;
var CALLTYPE_INTERNAL = 1;
var CALLTYPE_INBOUND  = 2;
var CALLTYPE_OUTBOUND = 3;
var CALLTYPE_CONSULT  = 4;

var lineId = 0;
var outboundPrefix;
var internalPrefix;
var currLineStatus;
var extension;

function setLineId(lineId){
	this.lineId = lineId;
}

function getLineId(){
	return this.lineId;
}

function getOutboundPrefix(){
	if(typeof(outboundPrefix)=="undefined")
		outboundPrefix = top.softPhone.getOutboundPrefix();
	return outboundPrefix;
}

function getInternalPrefix(){
	if(typeof(internalPrefix)=="undefined")
		internalPrefix = top.softPhone.getInternalPrefix();
	return internalPrefix;
}

function getCurrentLineStatus(){
	currLineStatus = top.softPhone.getCurrentLineStatus();
	return currLineStatus;
}

function getExtension(){
	if(typeof(extension)=="undefined")
		extension = top.softPhone.getAgentExtension();
	return extension;
}

var callList = new Array();

var callListLen = 20; //default record number

function addCallList(status,phone,calltype){
	if(phone!=null && phone!=""){
		if(status == "out"){
			if(calltype == 3){ //outbound
				//outboundPrefix = getOutboundPrefix();
				//var phonePrefix = phone.substring(0,outboundPrefix.length);
				//if(outboundPrefix!="" && outboundPrefix==phonePrefix)
				//	phone = phone.substring(outboundPrefix.length,phone.length+outboundPrefix.length);
			}
			if(calltype == 1){ //internal
				internalPrefix = getInternalPrefix();
				if(internalPrefix!="")
					phone = internalPrefix+phone;
			}
		}
		if(status == "in"){
			if(calltype == 1){ //internal
				internalPrefix = getInternalPrefix();
				if(internalPrefix!="")
					phone = internalPrefix+phone;
			}
		}
		var TD = new Date();
		var month = TD.getMonth()+1;
		if(month<10) month = "0"+month;
		var day = TD.getDate();
		if(day<10) day = "0"+day;
		var hour = TD.getHours();
		if(hour<10) hour = "0"+hour;
		var minute = TD.getMinutes();
		if(minute<10) minute = "0"+minute;
		var datetime = month+"/"+day+" "+hour+":"+minute;
		if(status == "out"){
			var i = callList.push(phone+"|out|"+datetime);
		}
		if(status == "in"){
			var i = callList.push(phone+"|in|"+datetime);
		}
		if(i>callListLen){
			callList.shift();
		}
		if(document.getElementById("callHistoryBoard").style.display == ""){
			createCallList();
		}
	}
}

function createCallList(){
	document.getElementById('CallHistoryLeft').innerHTML =createCallListText("left");
	document.getElementById('CallHistoryRight').innerHTML =createCallListText("right");
}

function createCallListText(position){
	var path=getWebContextPath();
	var cL = "";
	var callListTemp = new Array();
	var index = 0;
	for(clN=callList.length-1;clN>=0;clN--){
		callListTemp[index]=callList[clN];
		index++;
	}
	cL += "<table width=\"100%\"  border=\"0\" cellpadding=\"0\" cellspacing=\"0\">";
	if(position=="left"){
		for(clN=0;clN<callListTemp.length && clN<10;clN++){
			var callListSplit = callListTemp[clN].split("|");
			cL += "<tr onMouseOver=\"this.className='callHisItem'\" onMouseOut=\"this.className=''\" onClick='execShortcutKeyDial(\""+callListSplit[0]+"\")'>";
			cL += "<td width=\"20\" height=\"17\" align=\"center\">";
			cL += "<img src=\""+path+"/images/keypad_image/call_his_"+callListSplit[1]+".gif\" width=\"13\" height=\"11\" border=\"0\" align=\"absbottom\" alt=\""+callListSplit[1]+"\"></td>";
			cL += "<td>"+callListSplit[0]+"</td>";
			cL += "<td width=\"60\" class=\"data\">"+callListSplit[2]+"</td>";
			cL += "</tr>";
		}
	}
	if(position=="right"){
		for(clN=10;clN<callListTemp.length;clN++){
			var callListSplit = callListTemp[clN].split("|");
			cL += "<tr onMouseOver=\"this.className='callHisItem'\" onMouseOut=\"this.className=''\" onClick='execShortcutKeyDial(\""+callListSplit[0]+"\")'>";
			cL += "<td width=\"20\" height=\"17\" align=\"center\">";
			cL += "<img src=\""+path+"/images/keypad_image/call_his_"+callListSplit[1]+".gif\" width=\"13\" height=\"11\" border=\"0\" align=\"absbottom\" alt=\""+callListSplit[1]+"\"></td>";
			cL += "<td>"+callListSplit[0]+"</td>";
			cL += "<td width=\"60\" class=\"data\">"+callListSplit[2]+"</td>";
			cL += "</tr>";
		}
	}
	cL += "</table>";
	return cL;
}

function showHideDiv(divId){
	if(document.getElementById(divId).style.display == "none"){
		document.getElementById(divId).style.display = "block";	
	}else{
		document.getElementById(divId).style.display = "none";
	}
}

function showDiv(divId){document.getElementById(divId).style.display = "block";}

function hideDiv(divId){document.getElementById(divId).style.display = "none";}

function changeSoftKeyBoard(MenuItem){
	var path = getWebContextPath();
	if(MenuItem == "softKey"){
		document.getElementById("softKeyImg").src = path+"/images/keypad_image/SZJP_tab1_current.gif";
		document.getElementById("hisAddImg").src = path+"/images/keypad_image/SZJP_tab2_normal.gif";
		document.getElementById("AddImg").src = path+"/images/keypad_image/SZJP_tab3_normal.gif";
		document.getElementById("softKeyBoard").style.display = "";
		document.getElementById("callHistoryBoard").style.display = "none";
		document.getElementById("addressBoard").style.display = "none";
	}
	if(MenuItem == "callHis"){
		document.getElementById("softKeyImg").src = path+"/images/keypad_image/SZJP_tab1_normal.gif";
		document.getElementById("hisAddImg").src = path+"/images/keypad_image/SZJP_tab2_current.gif";
		document.getElementById("AddImg").src = path+"/images/keypad_image/SZJP_tab3_normal.gif";
		document.getElementById("softKeyBoard").style.display = "none";
		document.getElementById("callHistoryBoard").style.display = "";
		document.getElementById("addressBoard").style.display = "none";
		createCallList();
	}
	if(MenuItem == "address"){
		document.getElementById("softKeyImg").src = path+"/images/keypad_image/SZJP_tab1_normal.gif";
		document.getElementById("hisAddImg").src = path+"/images/keypad_image/SZJP_tab2_normal.gif";
		document.getElementById("AddImg").src = path+"/images/keypad_image/SZJP_tab3_current.gif";
		document.getElementById("softKeyBoard").style.display = "none";
		document.getElementById("callHistoryBoard").style.display = "none";
		document.getElementById("addressBoard").style.display = "";
	}
}

function changeLineStatus(LineName){
	if(LineName == "lineOneImage"){
		this.setLineId(0);
		document.getElementById("timerLineOne").style.display = "";
		document.getElementById("timerLineTwo").style.display = "none";
		document.getElementById("timerLineThr").style.display = "none";
		
		document.getElementById("lineStatusDiv").innerText = LineStatus[0].getLineState();
		document.getElementById("lineStateImage").src = LineStatus[0].getStateImage();
		document.getElementById("phoneNumber").value = LineStatus[0].getPhoneNumber();
	}
	if(LineName == "lineTwoImage"){
		this.setLineId(1);
		document.getElementById("timerLineOne").style.display = "none";
		document.getElementById("timerLineTwo").style.display = "";
		document.getElementById("timerLineThr").style.display = "none";
		
		document.getElementById("lineStatusDiv").innerText = LineStatus[1].getLineState();
		document.getElementById("lineStateImage").src = LineStatus[1].getStateImage();
		document.getElementById("phoneNumber").value = LineStatus[1].getPhoneNumber();
	}
	if(LineName == "lineThreeImage"){
		this.setLineId(2);
		document.getElementById("timerLineOne").style.display = "none";
		document.getElementById("timerLineTwo").style.display = "none";
		document.getElementById("timerLineThr").style.display = "";
		
		document.getElementById("lineStatusDiv").innerText = LineStatus[2].getLineState();
		document.getElementById("lineStateImage").src = LineStatus[2].getStateImage();
		document.getElementById("phoneNumber").value = LineStatus[2].getPhoneNumber();
	}
}

function getCurrentPhoneNumberObject(){
	var PhoneNumberObjectId = top.document.getElementById("phoneNumber");
	return PhoneNumberObjectId;
}

function setPhoneNumber(phoneNumber){
	var PhoneNumberObjectId = getCurrentPhoneNumberObject();
	PhoneNumberObjectId.value=phoneNumber;
	setPhoneNumberFocus();
}

function inputNumber(typeNumber){
	var PhoneNumberObjectId = getCurrentPhoneNumberObject();
	var str = top.document.selection.createRange().text;
	var t_len = PhoneNumberObjectId.value.length;
	if(typeof(str)!="undefined")
	{
		if(top.getCurrentLineStatus()==STATUS_TALKING){
			setPhoneNumberFocus();
			window.clipboardData.setData('text', typeNumber);
			top.document.execCommand('Paste');
		}
		else{
			var obj = PhoneNumberObjectId;
			if(str!="") //replace selected text
			{
				window.clipboardData.setData('text', typeNumber);
				obj.focus();
				top.document.execCommand('Paste');
			}
			else //insert text at cursor position
			{
				obj.focus();
				var r1 = top.document.selection.createRange();
				var r2 = obj.createTextRange();
				//r2.setEndPoint("endtoend", r1);
				var len = r2.text.length;
				if(len>0){
					window.clipboardData.setData('text', typeNumber);
					top.document.execCommand('Paste');
				}else{
					PhoneNumberObjectId.value=typeNumber+PhoneNumberObjectId.value;
				}
			}
		}
	}
	if(top.getCurrentLineStatus()==STATUS_TALKING){
  		var keys = new Array("digit");   
		var values = new Array(typeNumber);
		top.softPhone.executeCommand( "sendDTMFAction" , formatArrayToString(keys), formatArrayToString(values) ) ;
  	}
}

function clearInput(){
	var PhoneNumberObjectId = getCurrentPhoneNumberObject();
	PhoneNumberObjectId.value = "";
}

function backSpace(){
	var PhoneNumberObjectId = getCurrentPhoneNumberObject();
	var status = top.getCurrentLineStatus();

	var str = top.document.selection.createRange().text;
	var t_len = PhoneNumberObjectId.value.length;
	if(typeof(str)!="undefined")
	{
		var obj = PhoneNumberObjectId;
		
		if(str!="") //delete selected text
	    {
			obj.focus();
			top.document.execCommand('CUT');
		}
		else //delete text at cursor position
		{				
			obj.focus();
			var r1 = top.document.selection.createRange();
			var r2 = obj.createTextRange();
			r2.setEndPoint("endtoend", r1);
			var len = r2.text.length;
			if(len>0)
			{
				obj.value=obj.value.substr(0,len-1)+obj.value.substr(len,t_len-len); 
				var rng = obj.createTextRange();
				rng.move('character',len-1);
				rng.select();
			}
		}
	}

}

function reDial(){
	if(callList.length>0){
		var callListSplit = callList[callList.length-1].split("|");
		var PhoneNumberObjectId = getCurrentPhoneNumberObject();
		PhoneNumberObjectId.value=callListSplit[0];
		if(PhoneNumberObjectId.value!="" && LineStatus[getLineId()].getLineState()==""){
			showHideDiv("softKeyBoardDiv");
			showHideDiv("softPhonePadFrame");
			makeNewCall(phoneNumber,getLineId(),"","");
		}
	}
}

function dial(){
	var PhoneNumberObjectId = getCurrentPhoneNumberObject();
	if(event.keyCode==13 && PhoneNumberObjectId.value!="" && LineStatus[getLineId()].getLineState()==""){
		webMouseClick("dialImage");
	}
}

function dial2(){
	var PhoneNumberObjectId = getCurrentPhoneNumberObject();
	if(PhoneNumberObjectId.value!="" && LineStatus[getLineId()].getLineState()==""){
		showHideDiv("softKeyBoardDiv");
		showHideDiv("softPhonePadFrame");
		webMouseClick("dialImage");
	}
}

function execSoftKeyBoardDial(){
	var PhoneNumberObjectId = getCurrentPhoneNumberObject();	
	if(PhoneNumberObjectId.value!="" && LineStatus[getLineId()].getLineState()==""){
		showHideDiv("softKeyBoardDiv");
		showHideDiv("softPhonePadFrame");
		makeNewCall(phoneNumber,getLineId(),"","");
	}
}

function execShortcutKeyDial(phoneNumber){
	var PhoneNumberObjectId = getCurrentPhoneNumberObject();
	PhoneNumberObjectId.value = phoneNumber;
	if(PhoneNumberObjectId.value!="" && LineStatus[getLineId()].getLineState()==""){
		showHideDiv("softKeyBoardDiv");
		showHideDiv("softPhonePadFrame");
		makeNewCall(phoneNumber,getLineId(),"","");
	}
}

function execFunctionKeyDial(keyNumber,type){
	if(type==0){
		if(LineStatus[getLineId()].getLineState()==""){
			showHideDiv("softKeyBoardDiv");
			showHideDiv("softPhonePadFrame");
			makeNewCall(keyNumber,getLineId(),"","");
		}
	}
	if(type==1){
		var PhoneNumberObjectId = getCurrentPhoneNumberObject();
		if(PhoneNumberObjectId.value!="" && LineStatus[getLineId()].getLineState()==""){
			keyNumber = keyNumber+PhoneNumberObjectId.value;
			showHideDiv("softKeyBoardDiv");
			showHideDiv("softPhonePadFrame");
			makeNewCall(keyNumber,getLineId(),"","");
		}
	}	
}

function setPhoneNumberFocus(){
	var PhoneNumberObjectId = getCurrentPhoneNumberObject();
	PhoneNumberObjectId.focus();
	var r = PhoneNumberObjectId.createTextRange();   
	r.collapse(false);   
	r.select();   
}

document.onclick = function hideAllFloat(){
	top.document.getElementById("statMenu").style.display = "none";
	top.document.getElementById("statMenuPadFrame").style.display = "none";
}

function verifyNum(obj) {
	var value = obj.value;
	if (event.keyCode < 48 || event.keyCode > 57) {
		if (event.keyCode != 8 && event.keyCode != 9 && event.keyCode != 35 && event.keyCode != 42) {
			event.keyCode = 0;
	    }
	}
}

/*
 *	Move here from cti-event.js
 *	begin
 *	edit by hippo.zhang
*/

var DELIMETE = "#@@#";

function Map(){
	this.elements = new Array();
 
	this.size = function() {
		return this.elements.length;
	}
 
	this.isEmpty = function() {
		return (this.elements.length < 1);
	}

	this.clear = function() {
		this.elements = new Array();
	}

	this.put = function(_key, _value) {
		this.elements.push({key:_key, value:_value});
	}
 
	this.remove = function(_key) {
		var bln = false;
		try{   
			for (i = 0; i < this.elements.length; i++){  
				if (this.elements[i].key == _key){
					this.elements.splice(i, 1);
					return true;
				}
			}
		}catch(e){
			bln = false;    
		}
		return bln;
	}

	this.get = function(_key) {
		try{   
			for (i = 0; i < this.elements.length; i++) {
				if (this.elements[i].key == _key) {
					return this.elements[i].value;
				}
			}
		}catch(e) {
			return null;   
		}
		return null;
	}
 
	this.element = function(_key) {
		if (_key < 0 || _key >= this.elements.length){
			return null;
		}
		return this.elements[_key];
	}

	this.containsKey = function(_key) {
		var bln = false;
		try{
			for (i = 0; i < this.elements.length; i++){  
				if (this.elements[i].key == _key){
					bln = true;
				}
			}
		}catch(e) {
			bln = false;    
		}
		return bln;
	}

	this.containsValue = function(_value){
		var bln = false;
		try {
			for (i = 0; i < this.elements.length; i++) {  
				if (this.elements[i].value == _value){
					bln = true;
				}
			}
		}catch(e) {
			bln = false;    
		}
		return bln;
	}
 
	this.values = function() {
		var arr = new Array();
			for (i = 0; i < this.elements.length; i++) {  
				arr.push(this.elements[i].value);
			}
		return arr;
	}
 
	this.keys = function() {
		var arr = new Array();
		for (i = 0; i < this.elements.length; i++) {  
			arr.push(this.elements[i].key);
		}
		return arr;
	}
}

/**
  * utility function
  */
function formatArrayToString(dataArray) {
    var str = "";
    for (var index=0;index<dataArray.length;index++) {
        str += dataArray[index] + DELIMETE;
    }
    return str;
}

function formatStringToArray(dataString){
	if(!dataString){
		return null;
	}
	
	return dataString.split(DELIMETE);
}

/*
 *add by jarod 2007-01-17 PSBUG39   
 *dialogType: 0 showModalDialog ,1 showModelessDialog
*/
function showHtmlDialog(strMessage,dialogType){
  //alert("dialogType ="+dialogType+"Message = "+strMessage);
}

var LineStatus = new Array();
	LineStatus[0] = new LineState();
	LineStatus[1] = new LineState();
	LineStatus[2] = new LineState();
	
var nMainContact = -1;

var bACWFlag = false;

var nTempContact = -1;

var agentState = new AgentState();

function AgentState(){
	this.agentState = "";
	
	this.setAgentState = function(_status,_reason,_mediaType,_handleFrom){
		switch(parseInt(_status)){
			case AGENT_STATE_READY:
				this.agentState = "Ready";
				if(bACWFlag){
					nMainContact = -1;
					bACWFlag = false;
				}
				break;
			case AGENT_STATE_NOTREADY:
				if(_handleFrom==3 && _mediaType==0){
					if(!bACWFlag){
						this.agentState = "ACW";
						nMainContact = nTempContact;
						bACWFlag = true;
					}
				}else{
					var reasonKeyArray = getReasonKeyArray().split(DELIMETE);
					var reasonValueArray = getReasonValueArray().split(DELIMETE);
					for(var i = 0; i < reasonKeyArray.length; i++){
						if(reasonKeyArray[i] == _reason){
							this.agentState = reasonValueArray[i];
							break;
						}
					}
					if(bACWFlag){
						var status = top.getCurrentLineStatus();
						if(status != STATUS_TALKING && getLineId() == nMainContact){
							nMainContact = -1;
							bACWFlag = false;
							this.agentState="NotReady";
						}
					}
					else{
						this.agentState="NotReady";
					}
				}
				break;
			case AGENT_STATE_NOTINUSE:
				this.agentState="Logout";
				//nMainContact = -1;
				break;
			default:
		}
	}	
	this.getAgentState = function(){return this.agentState;}
}

function LineState(){
	this.lineState = "";
	this.partyCount = 0;
	this.stateImage = "";
	this.phoneNumber = "";
	this.monitorList = new Map();
	this.talkingList = new Array();
	this.setLineState = function(_lineId,_state,_callType,_interactionID,_ani,_dnis,_attachedData,_extensions){
		var webContext=getWebContextPath();
		var extensionsArray = formatStringToArray(_extensions);
		var otherDN = "";
		if(_extensions.indexOf("otherDN") != -1){
			for(var temp = 0; temp < extensionsArray.length; temp++){
				if(extensionsArray[temp].indexOf("otherDN") != -1){
					var otherDN = extensionsArray[temp].split("=")[1];
				}
			}
		}
		this.callType = _callType;
		switch(_state){
			case STATUS_IDLE:
				if(_extensions.indexOf("PartyChanged") == -1){
					this.talkingList = new Array();
				}
				this.partyCount = 0;
				this.lineState = "";
				this.stateImage = webContext+"/images/cti_image/ban_top_phone_leisure.gif";
				this.phoneNumber = "";
				if(nMainContact==_lineId){
					nTempContact = nMainContact;
					var state = agentState.getAgentState();
					if(state=="Ready"){
						onChangeAgentChannelStateInCache('voiceReady');
						nMainContact = -1;
					}
					else if(state=="NotReady"){
						onChangeAgentChannelStateInCache('voiceNotReady');
						nMainContact = -1;
					}
					else if(state=="Logout"){
						onChangeAgentChannelStateInCache('voiceLoginOut');
						nMainContact = -1;
					}
					else if(state=="ACW"){
						onChangeAgentChannelStateInCache('voiceACW');
					}
				}
				break;
			case STATUS_DIALING:
				this.lineState = "Dialing";
				this.stateImage = webContext+"/images/cti_image/ban_top_phone_busy.gif";
				this.phoneNumber = _dnis!=null?_dnis:"";
				if(this.phoneNumber!=null && this.phoneNumber!=""){
					if(_callType==CALLTYPE_OUTBOUND){
						//outboundPrefix = getOutboundPrefix();
						//var phonePrefix = this.phoneNumber.substring(0,outboundPrefix.length);
						//if(outboundPrefix!="" && outboundPrefix==phonePrefix)
						//	this.phoneNumber = this.phoneNumber.substring(outboundPrefix.length,this.phoneNumber.length+outboundPrefix.length);
					}
					else if(_callType==CALLTYPE_INTERNAL){
						internalPrefix = getInternalPrefix();
						if(internalPrefix!="")
							this.phoneNumber = internalPrefix+this.phoneNumber;
					}
					if(_attachedData.indexOf("monitorStatus=21") != -1){
						this.monitorList.put(_dnis, false);
					}else{
						this.monitorList.remove(_dnis);
					}
				}
				if(nMainContact==-1 && agentState.getAgentState()!="ACW"){
					onChangeAgentChannelStateInCache('voiceDialing');
					nMainContact = _lineId;
				}
				break;
			case STATUS_TALKING:
			case STATUS_CONFERENCE_END:
				if(_interactionID == "" || _interactionID == null) break;
				if(_extensions.indexOf("Hold") != -1){
					if(this.talkingList.length >= 2) {
						this.lineState = "Conference";
						if(nMainContact!=-1 && agentState.getAgentState()!="ACW" && (_callType==CALLTYPE_INBOUND || _callType==CALLTYPE_OUTBOUND || _callType==CALLTYPE_INTERNAL || _callType==CALLTYPE_CONSULT)){
							if(LineStatus[0].getLineState()!="Hold" && LineStatus[1].getLineState()!="Hold" && LineStatus[2].getLineState()!="Hold"){
								onChangeAgentChannelStateInCache('voiceConference');
								nMainContact = _lineId;
							}
						}
					}
					if(this.talkingList.length < 2) {
						this.lineState = "Talking";
						if(nMainContact!=-1 && agentState.getAgentState()!="ACW" && (_callType==CALLTYPE_INBOUND || _callType==CALLTYPE_OUTBOUND || _callType==CALLTYPE_INTERNAL || _callType==CALLTYPE_CONSULT)){
							if(LineStatus[nMainContact].getLineState()!="Hold"){
								onChangeAgentChannelStateInCache('voiceTalking',_callType);
								nMainContact = _lineId;
							}
						}
					}
					//break;
				}
				else{
					if(_extensions.indexOf("NumOfOrigDNs") != -1){
						this.lineState = "Conference";
						this.phoneNumber = "";
						//this.talkingList = new Array();
						for(var temp = 0; temp < extensionsArray.length; temp++){
							if(extensionsArray[temp].indexOf("OrigDN-") != -1){
								var tempDn = extensionsArray[temp].split("=")[1];
								if(getExtension() != tempDn){
									if(indexOf(this.talkingList, tempDn)>=0)
										this.talkingList.splice(indexOf(this.talkingList, tempDn), 1);
									this.talkingList.push(tempDn);
								}
							}
						}
						if(nMainContact!=-1 && agentState.getAgentState()!="ACW" && (_callType==CALLTYPE_INBOUND || _callType==CALLTYPE_OUTBOUND || _callType==CALLTYPE_INTERNAL || _callType==CALLTYPE_CONSULT)){
							if(LineStatus[0].getLineState()!="Hold" && LineStatus[1].getLineState()!="Hold" && LineStatus[2].getLineState()!="Hold"){
								onChangeAgentChannelStateInCache('voiceConference');
								nMainContact = _lineId;
							}
						}
					}else{
						this.talkingList = new Array();
						this.partyCount = 0; 
						this.lineState = "Talking";
						if(_callType==CALLTYPE_INBOUND){
							this.talkingList.push(_ani);
							this.phoneNumber = _ani!=null&&_ani!="Unknown"?_ani:"";
						}else if(_callType==CALLTYPE_OUTBOUND){
							this.talkingList.push(_dnis);
							this.phoneNumber = _dnis!=null&&_dnis!="Unknown"?_dnis:"";
						}else{
							if(getExtension()==_ani){
								this.talkingList.push(_dnis);
								this.phoneNumber = _dnis!=null&&_dnis!="Unknown"?_dnis:"";
							}
							else if(getExtension()==_dnis){
								this.talkingList.push(_ani);
								this.phoneNumber = _ani!=null&&_ani!="Unknown"?_ani:"";
							}
						}
						if(nMainContact!=-1 && agentState.getAgentState()!="ACW" && (_callType==CALLTYPE_INBOUND || _callType==CALLTYPE_OUTBOUND || _callType==CALLTYPE_INTERNAL || _callType==CALLTYPE_CONSULT)){
							if(LineStatus[nMainContact].getLineState()!="Hold"){
								onChangeAgentChannelStateInCache('voiceTalking',_callType);
								nMainContact = _lineId;
							}
						}
						if(_extensions.indexOf("otherRole=10") != -1){
							this.lineState = "Monitoring";
						}
					}
				}
				this.stateImage = webContext+"/images/cti_image/ban_top_phone_busy.gif";
				
				break;
			case STATUS_RINGING:
				this.lineState = "Ringing";
				this.stateImage = webContext+"/images/cti_image/ban_top_phone_busy.gif";
				if(_callType==CALLTYPE_INTERNAL || _callType==CALLTYPE_CONSULT){
					if(getExtension()==_ani)
						this.phoneNumber = _dnis!=null&&_dnis!="Unknown"?_dnis:"";
					else if(getExtension()==_dnis)
						this.phoneNumber = _ani!=null&&_ani!="Unknown"?_ani:"";

					if(this.phoneNumber!=null && this.phoneNumber!=""){
						internalPrefix = getInternalPrefix();
						if(internalPrefix!="")
							this.phoneNumber = internalPrefix+this.phoneNumber;
					}
				}
				else if(_callType==CALLTYPE_OUTBOUND){ //when monitoring
					this.phoneNumber = _dnis!=null&&_dnis!="Unknown"?_dnis:"";
				}
				else{
					this.phoneNumber = _ani!=null&&_ani!="Unknown"?_ani:"";
				}
				if(nMainContact==-1 && agentState.getAgentState()!="ACW"){
					onChangeAgentChannelStateInCache('voiceRinging');
					nMainContact = _lineId;
				}
				break;
			case STATUS_HELD:
				this.lineState = "Hold";
				this.stateImage = webContext+"/images/cti_image/ban_top_phone_busy.gif";
				if(nMainContact==_lineId && agentState.getAgentState()!="ACW"){
					onChangeAgentChannelStateInCache('voiceHolding');
				}
				break;
			case STATUS_CONFERENCE:
				if(_interactionID == "" || _interactionID == null) break;
				if(_extensions.indexOf("partyAdded") != -1){
					if(otherDN != ""){
						if(this.monitorList.get(otherDN) == false){
							this.monitorList.put(otherDN, true);
							break;
						}else{
							if(indexOf(this.talkingList, otherDN)>=0)
								this.talkingList.splice(indexOf(this.talkingList, otherDN), 1);
							this.talkingList.push(otherDN);
						}
					}
				}else{
					if(_extensions.indexOf("NumOfOrigDNs") != -1){
						for(var temp = 0; temp < extensionsArray.length; temp++){
							if(extensionsArray[temp].indexOf("OrigDN-") != -1){
								var tempDn = extensionsArray[temp].split("=")[1];
								if(indexOf(this.talkingList, tempDn)>=0)
									this.talkingList.splice(indexOf(this.talkingList, tempDn), 1);
								this.talkingList.push(tempDn);
							}
						}
					}
				}
				if(_extensions.indexOf("NumOfConsultDNs") != -1){
					for(var temp = 0; temp < extensionsArray.length; temp++){
						if(extensionsArray[temp].indexOf("ConsultDN-") != -1){
							var tempDn = extensionsArray[temp].split("=")[1];
							if(indexOf(this.talkingList, tempDn)>=0)
								this.talkingList.splice(indexOf(this.talkingList, tempDn), 1);
							this.talkingList.push(tempDn);
						}
					}
				}
					
				this.lineState = "Conference";
				this.phoneNumber = "";
				this.stateImage = webContext+"/images/cti_image/ban_top_phone_busy.gif";
				if(nMainContact==_lineId && agentState.getAgentState()!="ACW"){
					onChangeAgentChannelStateInCache('voiceConference');
				}
				break;
			case STATUS_PARTY_DELETED:
				if(otherDN != "" && this.monitorList.get(otherDN) == true){
					this.monitorList.remove(otherDN);
					break;
				}
				try{
					this.talkingList.splice(indexOf(this.talkingList, otherDN), 1);
				}catch(e){}

				if(this.talkingList.length < 2){
					if(top.getCurrentLineStatus()==STATUS_HELD)
						this.lineState = "Hold";
					else
						this.lineState = "Talking";
					if(this.talkingList.length==0)
						this.phoneNumber = "";
					else
						this.phoneNumber = this.talkingList[0]!=null&&this.talkingList[0]!="Unknown"?this.talkingList[0]:"";
					this.stateImage = webContext+"/images/cti_image/ban_top_phone_busy.gif";
					if(nMainContact==_lineId){
						if(top.getCurrentLineStatus()==STATUS_HELD)
							onChangeAgentChannelStateInCache('voiceHolding');
						else
							onChangeAgentChannelStateInCache('voiceTalking',_callType);
					}
				}
				break;
			case STATUS_PARTY_CHANGE:
				if(_extensions.indexOf("NumOfOrigDNs") != -1){
					for(var tmp = 0; tmp < this.talkingList.length; tmp++){
						this.talkingList.pop();
					}
					for(var temp = 0; temp < extensionsArray.length; temp++){
						if(extensionsArray[temp].indexOf("OrigDN-") != -1){
							var tempDn = extensionsArray[temp].split("=")[1];
							if(indexOf(this.talkingList, tempDn)>=0)
								this.talkingList.splice(indexOf(this.talkingList, tempDn), 1);
							this.talkingList.push(tempDn);
						}
					}					
				}
				else
				{
					var thirdPartyDN = "";
					if(_extensions.indexOf("thirdPartyDN") != -1){
						for(var temp = 0; temp < extensionsArray.length; temp++){
							if(extensionsArray[temp].indexOf("thirdPartyDN") != -1){
								var thirdPartyDN = extensionsArray[temp].split("=")[1];
								break;
							}
						}
					}
					
					if(indexOf(this.talkingList, thirdPartyDN)>=0)
						this.talkingList.splice(indexOf(this.talkingList, thirdPartyDN), 1);
					this.talkingList.push(otherDN);
				}
				if(this.talkingList.length < 2){
					this.lineState = "Talking";
					this.phoneNumber = this.talkingList[0];
				}
				break;
			default:
				//this.lineState = "";
		}
		if(_lineId==getLineId()){
			document.getElementById("lineStatusDiv").innerText = this.lineState;
			document.getElementById("lineStateImage").src = this.stateImage;
		}
		document.getElementById("phoneNumber").innerText = LineStatus[getLineId()].getPhoneNumber();
	}
	
	this.getLineState	= function(){return this.lineState;}
	this.getStateImage  = function(){
		if(this.stateImage == "")
			return getWebContextPath()+"/images/cti_image/ban_top_phone_leisure.gif";
		return this.stateImage;
	}
	this.getPhoneNumber = function(){return this.phoneNumber;}
	this.getPartyCount	= function(){return this.partyCount;}
	this.resetLineState = function(){
		this.lineState = "";
		this.partyCount = 0;
		this.stateImage = getWebContextPath()+"/images/cti_image/ban_top_phone_leisure.gif";
		this.phoneNumber = "";		
	}
}

function resetLineState(){
	LineStatus[0].resetLineState();
	LineStatus[1].resetLineState();
	LineStatus[2].resetLineState();
	nMainContact = -1;
	document.getElementById("lineStatusDiv").innerText = "";
	document.getElementById("lineStateImage").src = getWebContextPath()+"/images/cti_image/ban_top_phone_leisure.gif";
	document.getElementById("phoneNumber").innerText = "";
}

function resetTimer(){
	stopMMTimer("LineOne");
	document.getElementById("timerLineOne").innerText = "";
	stopMMTimer("LineTwo");
	document.getElementById("timerLineTwo").innerText = "";
	stopMMTimer("LineThr");
	document.getElementById("timerLineThr").innerText = "";
}

var webContextPath = "";

function getWebContextPath(){
	if(webContextPath==""){
		webContextPath=top.softPhone.getWebContext();
	}
	return webContextPath;
}
/**
 * show hint functions
 * edited by hippo.zhang
 * 2007.7.13
 * begin
 */
var tip_div_Id		= "toolTipLayer";
var tip_offsetX		= 10;
var tip_offsetY		= 20;
var tip_fgColor		= "#000000";
var tip_bgColor		= "#FFFFE1";
var tip_font_size	= "12px";
var tip_font_face	= "";
var tip_show_delay	= 500;
var tip_hide_delay	= 5000;

var tip_mouseX		= 0;
var tip_mouseY		= 0;
var tip_style		= null;
var tip_msg			= "";
var tip_timers 		= new Array(null, null);
var tip_show		= true;
var tips_map		= new Map();

function cleanTips(){
	clearTimeout(tip_timers[0]);
	clearTimeout(tip_timers[1]);
	tip_msg = "";
	tip_style.display='none';
	tip_style.visibility = "hidden";
}

function setTipShow(itemId){
	var item = document.getElementById(itemId);
	
	if(item != null){
		tip_mouseX = event.x + document.body.scrollLeft + tip_offsetX;
		tip_mouseY = event.y + document.body.scrollTop + tip_offsetY;
		if(tip_show){
			tip_show = false;
			var imageClass = item.className;
			if(imageClass == null || imageClass == "" || imageClass == undefined) return;
			if(imageClass.indexOf("dialImage_ringing") != -1){
				tip_msg = tips_map.get("dialImage_ringing");
			//}else if(imageClass.indexOf("dialImage_dialing") != -1){
			//	tip_msg = tips_map.get("dialImage_dialing");
			}else if(imageClass.indexOf("dialImage_enabled") != -1){
				tip_msg = tips_map.get("dialImage_enabled");
			}else if(imageClass.indexOf("disconImage_hangup") != -1){
				tip_msg = tips_map.get("disconImage_hangup");
			}else if(imageClass.indexOf("disconImage_refuse") != -1){
				tip_msg = tips_map.get("disconImage_refuse");
			}else{
				var filePrefix = imageClass.substring(0, imageClass.indexOf("_"));
				tip_msg = tips_map.get(filePrefix) == null? "" : tips_map.get(filePrefix);
			}
			if(tip_msg!=""){
				tip_timers[0] = setTimeout("showTips()", tip_show_delay);
				tip_timers[1] = setTimeout("hideTips()", tip_hide_delay);
			}
		}
	}
}

function hideTips(){
	tip_show = true;
	tip_msg = "";
	cleanTips();
}

function showTips(){
	tip_style.left = tip_mouseX;
	tip_style.top = tip_mouseY;
	tip_show = false;
	var content =	'<table border="0" cellspacing="0" cellpadding="0" bgcolor="' + tip_fgColor + '">' + 
						'<td style="padding: 1px">' +
							'<table border="0" cellspacing="0" cellpadding="0" bgcolor="' + tip_bgColor + '">' +
								'<td align="center" style="padding: 0px; color: ' + tip_fgColor +';"><font face=' + tip_font_face + ' size=' + tip_font_size + '>&nbsp;' + tip_msg + '&nbsp;</font></td>' +
							'</table>' +
						'</td>' +
					'</table>';
	if(tip_msg != null && tip_msg != "")
		document.getElementById(tip_div_Id).innerHTML = content;
	tip_style.display='block';
	tip_style.visibility = "visible";
	tip_style.zIndex = 20000;
}
/**
 * end
 */
 
function getMainContactStatus(){
 	if(typeof(nMainContact)!="undefined" && nMainContact!=-1){
 		return top.softPhone.getLineStatus(nMainContact);
 	}
 	return STATUS_IDLE;
 }
 
function indexOf(arr, obj){
	if(arr.length < 1) return -1;
	for(var temp = 0; temp < arr.length; temp++){
		if(arr[temp] == obj)
			return temp;
	}
}

function openMessageBox(msg){
	document.getElementById("alertFramePad").style.display = "block";
	document.getElementById("alertDivPad").style.display = "block";
	document.getElementById("alertDiv").style.display = "block";
	document.getElementById("msgDiv").innerHTML=msg;

	document.getElementById("alertFramePad").style.height = document.documentElement.clientHeight+100;
	document.getElementById("alertFramePad").style.width = document.documentElement.clientWidth+100;
	document.getElementById("alertDivPad").style.height = document.documentElement.clientHeight+100;
	document.getElementById("alertDivPad").style.width = document.documentElement.clientWidth+100;
	document.getElementById("alertDiv").style.left = (document.documentElement.clientWidth-350)/2;
	document.getElementById("alertDiv").style.top = (document.documentElement.clientHeight-150)/2;

	alertTimer = setTimeout("closeMessageBox()",10000);
}
function closeMessageBox(){
	document.getElementById("alertFramePad").style.display = "none";
	document.getElementById("alertDivPad").style.display = "none";
	document.getElementById("alertDiv").style.display = "none";
	document.getElementById("msgDiv").innerHTML="";
	
	clearTimeout(alertTimer);
}

function openAUXBox(msg){
	document.getElementById("q111").style.display = "block";
	document.getElementById("r44").style.display = "block";
	document.getElementById("s33").style.display = "block";
	document.getElementById("AUXDIV").style.display = "block";
	
	
	for(var i=0;i<msg.length;i++){
		var oTr = document.getElementById("reasonList").insertRow();
    		var oTd1 = oTr.insertCell();
        	oTd1.innerHTML=" <input name='content' id='content' type='radio' value='"+i+"' />"+msg[i].split(":")[1];
	}

	document.getElementById("q111").style.height = document.documentElement.clientHeight+100;
	document.getElementById("q111").style.width = document.documentElement.clientWidth+100;
	document.getElementById("r44").style.height = document.documentElement.clientHeight+100;
	document.getElementById("r44").style.width = document.documentElement.clientWidth+100;
	document.getElementById("s33").style.left = (document.documentElement.clientWidth-350)/2;
	document.getElementById("s33").style.top = (document.documentElement.clientHeight-150)/2;
}
function closeAUXBox(){
	document.getElementById("q111").style.display = "none";
	document.getElementById("r44").style.display = "none";
	document.getElementById("s33").style.display = "none";
	document.getElementById("AUXDIV").style.display = "none";

	for (i=document.getElementById("reasonList").rows.length-1;i>=1; i-- )
	{
		document.getElementById("reasonList").deleteRow(i);
	}
}

function openIvr(){
	document.getElementById("alertFramePad").style.display = "block";
	document.getElementById("alertDivPad").style.display = "block";
	document.getElementById("ivrDiv").style.display = "block";
	
	try{	
		var ivrListString = top.getIVRList();
		if(ivrListString != ""){
			var ivrListArray = formatStringToArray(ivrListString);
				for(var i=0;i<ivrListArray.length;i++){
					var oTr = document.getElementById("ivrList").insertRow();
			    	var oTd1 = oTr.insertCell();
			    	var content = " <input name='ivrInfo' id='ivrInfo' type='radio' value='";
			    	content += ivrListArray[i];
			    	content += "' /> ";
			    	content += ivrListArray[i].split(",")[0];
			        oTd1.innerHTML=content;
				}
		}
	} catch(e){}
		
	document.getElementById("alertFramePad").style.height = document.documentElement.clientHeight+100;
	document.getElementById("alertFramePad").style.width = document.documentElement.clientWidth+100;
	document.getElementById("alertDivPad").style.height = document.documentElement.clientHeight+100;
	document.getElementById("alertDivPad").style.width = document.documentElement.clientWidth+100;
	document.getElementById("ivrDiv").style.left = (document.documentElement.clientWidth-240)/2;
	document.getElementById("ivrDiv").style.top = (document.documentElement.clientHeight-180)/2;
}

function closeIvr(){
	document.getElementById("alertFramePad").style.display = "none";
	document.getElementById("alertDivPad").style.display = "none";
	document.getElementById("ivrDiv").style.display = "none";
	for (i=document.getElementById("ivrList").rows.length-1;i>=1; i-- ) {
		document.getElementById("ivrList").deleteRow(i);
	}
}
function selectIvr(){
	var strSelectedIvr = getSelectedIVR();
	if(strSelectedIvr!=""){
		initiateIVR(strSelectedIvr,getLineId());
		closeIvr();
	}
}

function getSelectedIVR(){
	var currentIVR = "";
	try{
		if(document.ivrForm.ivrInfo.length>1){
			for(var i=0;i<document.ivrForm.ivrInfo.length;i++){
				if(document.ivrForm.ivrInfo[i].checked){
					currentIVR = document.ivrForm.ivrInfo[i].value;
					break;
				}
			}
		} else {
			if(document.ivrForm.ivrInfo.checked){
				currentIVR = document.ivrForm.ivrInfo.value;
			}
		}
	} catch(e){
		currentIVR = "";
	}
	return currentIVR;
}