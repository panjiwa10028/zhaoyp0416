/*
author : kevin.yan 2007-06-29
*/
//temp contact
var contactArrayChat = new Array(0);//contact array Chat
var tempInteractionId;
var tempCustomerName;

//object class *************begin***************
function ContactChat(interactionID,customerName) {
	this.interactionID = interactionID;//interactionID
	this.customerName = customerName;
	//this.callType = callType;// callType
	//this.status = status;//status:54 dialing  55 talking  56 ringing  57 held 2 idle
	this.dtStartTime = '';
	//this.attachedData = attachedData;//AttachedData
	this.strContent = '';//Content text
	this.documentObj = null;
	//this.extensions = extensions;
};
//public method
ContactChat.prototype.getInteractionID =function () {return this.interactionID;};
ContactChat.prototype.setInteractionID =function (interactionID) {this.interactionID = interactionID;};

ContactChat.prototype.customerName =function () {return this.customerName;};
ContactChat.prototype.setCustomerName =function (customerName) {this.customerName = customerName;};

//ContactChat.prototype.getCallType =function () {return this.callType;};
//ContactChat.prototype.setCallType =function (callType) {this.callType = callType;};

//ContactChat.prototype.getStatus =function () {return this.status;};
//ContactChat.prototype.setStatus =function (status) {this.status = status;};

ContactChat.prototype.getDtStartTime =function () {return this.dtStartTime;};
ContactChat.prototype.setDtStartTime =function (dtStartTime) {this.dtStartTime = dtStartTime;};

//ContactChat.prototype.getAttachedData =function () {return this.attachedData;};
//ContactChat.prototype.setAttachedData =function (attachedData) {this.attachedData = attachedData;};

ContactChat.prototype.getStrContent =function () {return this.strContent;};
ContactChat.prototype.setStrContent =function (strContent) {this.strContent = strContent;};

ContactChat.prototype.getDocumentObj =function () {return this.documentObj;};
ContactChat.prototype.setDocumentObj =function (documentObj) {this.documentObj = documentObj;};

//ContactChat.prototype.extensions =function () {return this.extensions;};
//ContactChat.prototype.extensions =function (extensions) {this.extensions = extensions;};

function setStartTimeWhileNull(startTime) {
	for (var i=0;i<contactArrayChat.length;i++) {
		if (contactArrayChat[i].getStartTime() == '') {
			contactArrayChat[i].setStartTime(startTime);
		}
	}
}

function setStrContent2ContactArrayChat(interactionID,strContent) {
	for (var i=0;i<contactArrayChat.length;i++) {
		if (contactArrayChat[i].getInteractionID() == interactionID) {
			contactArrayChat[i].setStrContent(strContent);
			break;
		}
	}
}

function followAddStrContent2contactArrayChat(interactionID,strContent) {
	var flag =0;
	var i =5;
	for (var i=0;i<contactArrayChat.length;i++) {
		if (contactArrayChat[i].getInteractionID() == interactionID) {
			contactArrayChat[i].setStrContent(contactArrayChat[i].getStrContent()+strContent);
			flag =1;
			break;
		}
	}
	
	if (flag == 0){
		addContactChat(interactionID,"");
		for (var i=0;i<contactArrayChat.length;i++) {
			if (contactArrayChat[i].getInteractionID() == interactionID) {
				contactArrayChat[i].setStrContent(contactArrayChat[i].getStrContent()+strContent);
				flag =1;
				break;
			}
		}	
	}
}
function setChatDocument(interactionID,docmentObj){
	var flag =0;
	var i =5;
	
	for (var i=0;i<contactArrayChat.length;i++) {
		if (contactArrayChat[i].getInteractionID() == interactionID) {
			contactArrayChat[i].setDocumentObj(docmentObj);
			flag =1;
			break;
		}
	}
	
	if (flag == 0){
		addContactChat(interactionID,"");
		for (var i=0;i<contactArrayChat.length;i++) {
			if (contactArrayChat[i].getInteractionID() == interactionID) {
				contactArrayChat[i].setDocumentObj(docmentObj);
				flag =1;
				break;
			}
		}	
	}
}
function addChatStatusMsg(interactionID,strMessage){
try{
	for (var i=0;i<contactArrayChat.length;i++) {
		if (contactArrayChat[i].getInteractionID() == interactionID) {
			var chatObj = contactArrayChat[i].getDocumentObj();
			if (chatObj != null && chatObj != ''){
				try{
					chatObj.all.divMsg.innerHTML = chatObj.all.divMsg.innerHTML +'<FONT COLOR=RED>'+strMessage+'</FONT><br>';
					chatObj.all.divMsg.doScroll("pageDown");
				}catch(e){}
			}
			followAddStrContent2contactArrayChat(interactionID,strMessage+'<br>');
			break;
		}
	}
}catch(e){}
}

function addChatFailMsg(interactionID){
try{
	for (var i=0;i<contactArrayChat.length;i++) {
		if (contactArrayChat[i].getInteractionID() == interactionID) {
			var chatObj = contactArrayChat[i].getDocumentObj();
			if (chatObj != null && chatObj != ''){
				try{
					chatObj.all.divMsg.innerHTML = chatObj.all.divMsg.innerHTML +'<FONT COLOR=RED>'+strMessage+'</FONT><br>';
					chatObj.all.divMsg.doScroll("pageDown");
				}catch(e){}
			}
			followAddStrContent2contactArrayChat(interactionID,strMessage+'<br>');
			break;
		}
	}
}catch(e){}
}


function addChatMsg(interactionID,strMessage){
try{
	for (var i=0;i<contactArrayChat.length;i++) {
		if (contactArrayChat[i].getInteractionID() == interactionID) {
			var chatObj = contactArrayChat[i].getDocumentObj();
			if (chatObj != null && chatObj != ''){
				try{
					chatObj.all.divMsg.innerHTML = chatObj.all.divMsg.innerHTML +strMessage+'<br>';
					chatObj.all.divMsg.doScroll("pageDown");
				}catch(e){}
			}
			followAddStrContent2contactArrayChat(interactionID,strMessage+'<br>');
			break;
		}
	}
}catch(e){}
}

function changeButtonStatus(interactionID){
try{
	for (var i=0;i<contactArrayChat.length;i++) {
		if (contactArrayChat[i].getInteractionID() == interactionID) {
			var chatObj = contactArrayChat[i].getDocumentObj();
			
			if (chatObj != null && chatObj != ''){
				chatObj.all.transferTD.style.display = "block";
				chatObj.all.transferDisabledTD.style.display = "none";
				chatObj.all.transferQueueTD.style.display = "block";
				chatObj.all.transferQueueDisabledTD.style.display = "none";
				chatObj.all.conferTD.style.display = "block";
				chatObj.all.conferDisabledTD.style.display = "none";
				chatObj.all.closeTD.style.display = "block";
				chatObj.all.closeDisabledTD.style.display = "none";
				chatObj.all.sendMessageTD.style.display = "block";
				chatObj.all.sendMessageDisabledTD.style.display = "none";
				chatObj.all.strMessageTD.style.display = "block";
				chatObj.all.strMessageDisabledTD.style.display = "none";
			}
			
			break;
		}
	}
}catch(e){}
}

function addContactChat(interactionID,customerName) {
	if (findContactChatByInteractionID(interactionID)){
		if (customerName !=""){
			for (var i=0;i<contactArrayChat.length;i++) {
				if (contactArrayChat[i].getInteractionID() == interactionID) {
					contactArrayChat[i].setCustomerName(customerName);
					break;
				}
			}
		}
		return;
	}
	
	var flag=0;
	try {
		for (var i=0;i<contactArrayChat.length;i++) {
			if (contactArrayChat[i].getInteractionID() == '-1') {
				contactArrayChat[i] = null;
				contactArrayChat[i] = new ContactChat(interactionID,customerName);
				flag =1;
				break;
			}
		}
	}catch(e){}
	
	if (flag == 0) {
		contactArrayChat[contactArrayChat.length] = new ContactChat(interactionID,customerName);
	}
}

function removeContactChat(interactionID) {
	try {
		for (var i=0;i<contactArrayChat.length;i++) {
			if (contactArrayChat[i].getInteractionID() == interactionID) {
				contactArrayChat[i].setInteractionID('-1');
				contactArrayChat[i].setStrContent('');
				contactArrayChat[i].setDocumentObj(null);
				//break; contact array's length is short.if contactObject is repeat,then remove all.
			}
		}
	}catch(e){}
}

function getStrContentChat(interactionID){
	var msg = '';
	try {
		for (var i=0;i<contactArrayChat.length;i++) {
			if (contactArrayChat[i].getInteractionID() == interactionID) {
				msg= contactArrayChat[i].getStrContent();
				break;
			}
		}
	}catch(e){}
	return msg;
}

function clearContactArrayChat() {
	contactArrayChat = new Array(0);
}
/*
function resetAll() {
	dtMainCommTime = '';
	monitorFlag ='0';
	lCustomerId ='0';//customer id
	strCustomerName = '';//customer name
	lBusinessExecuteId = '';//business id
	strBusinessExecuteName = '';//business name
	contactId = '0';//contact id
	mainCommId = '0';//main contactComm id
	clearcontactArrayChat();
	dtMainCommStartTime = '';//main contactComm start time
	strMainCommChannelValue = '';//main contactComm channel value
	strMainAttchData = '';//main contactComm attachData
	strMainContactDirect = '3';//main contact direction 0-inbound 1-outbound 2-consult 3-other
	nOptype = 1;
	strCustomerContactNumber = '';//customer contact number
	lBusinessId = '';
	lContacteeId = '-1';
	lActivityId = '-1';
}

//state is online and not business
function isNotBusy() {
	if (currentState == 'online,') {//if state isn't online,then don't validate
		return isInit();
	} else {
		return false;
	}
}

function isInit() {
	if (currentState != 'online,') {//if state isn't online,then don't validate
		return true;
	}

	if (monitorFlag == '0' && contactId == '0' && mainCommId == '0' && contactArrayChat.length == 0) {
		return true;
	} else {
		return false;
	}
}
*/
function findContactChatByInteractionID(interactionID) {
	if (contactArrayChat.length == 0) {
		return false;
	} else {
		var flag = false;
		for (var i=0;i<contactArrayChat.length;i++) {
			if (contactArrayChat[i].getInteractionID() == interactionID) {
				flag = true;
				break;
			}
		}
		return flag;
	}
}
//object class ****************end****************
function setChatObjectNull() {
	chatObject = null;
}

//add Chat
function disposalChat(interactionID,strCustomerName,strContextPath){
	tempInteractionId = interactionID;
	tempCustomerName = strCustomerName;
	//addContactChat(interactionID,strCustomerName);
	addTab(interactionID,top.TITLE_CHAT,strContextPath+'/jsp/media/qryChat.jsp',true,true);
}
/*
////CTI/////
function onChatMessage1(interactionID,message,messageFrom){
	var strMessage;
	if (messageFrom == '1') {
		strMessage = '<span style="background-color:silver">'+message+'</span>';
	} else {
		strMessage = message;
	}
	
	addChatMsg(interactionID,strMessage);
	//try {
		//followAddStrContent2contactArrayChat(interactionID,strMessage+'<br>');
	//}catch(e){}
	//var contactFrameChat = mainIframe.mainCenter.document.getElementById("contentsFrame_"+interactionID);
	//var contactFrameChat = mainIframe.mainCenter.frames[2];
	//var msgss = contactFrameChat.document.getElementById("divMsg");
	//alert(contactFrameChat.document.getElementById("chatArea").document.body.innerHTML);
	//alert(contactFrameChat.document.getElementById("contentsFrame_interactionID2").document.body.innerHTML);
	//contactFrameChat.document.all.addDivMsg('<br>'+strMessage);
	//alert(mainIframe.mainCenter.document.all("contentsFrame_"+interactionID));

	strMessage = null;
}*/