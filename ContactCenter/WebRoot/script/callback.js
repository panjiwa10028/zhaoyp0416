
function onCallOverTime(mediaType,interactionID){
}

function onChatMessage(interactionID,message,messageFrom){
	var strMessage;
	if (messageFrom == '1') {
		strMessage = '<span style="background-color:silver">'+message+'</span>';
	} else {
		strMessage = message;
	}
	
	try {
		followAddStrContent2ContactArray(interactionID,strMessage+'<br>');
	}catch(e){}
	
	
	if (chatDialog != undefined && chatDialog != '') {//chat already start
		try {
			chatDialog.divMsg.innerHTML = chatDialog.divMsg.innerHTML + '<br>'+strMessage;
		}catch(e){}
		
		try {
			chatDialog.divMsg.doScroll("pageDown");
		}catch(e){}
	}

	strMessage = null;
}

function onScreenPopup(mediaType,interactionID,callType,status, ani,dnis, attachedData){
}

function onChatEvent(status, callType, interactionID,customerName, attachedData, extensions){
}

function onEmailEvent(status, callType, interactionID, fromAddress, attachedData, extensions){
}

function onCallmebackEvent(status, callType, interactionID, fromAddress,attachedData, extensions){
}

function onAgentEvent(status,reason,mediaType,workmode){
}

function onVoiceEvent(status,lineId,callType,interactionID,ani,dnis,attachedData, extensions){
}

function onPartyAddEvent(istatus,lineId,callType, interactionID, ani, dnis, extensions){
}

function onAttachedDataChangedEvent(mediaType,lineId,callType,interactionID,attachedData){
}

function onOutboundCallOverTime(status,lineId,callType,interactionID,ani,dnis,attachedData){}
function onHeldStart(status,lineId,callType,interactionID,ani,dnis,attachedData){}
function onHeldStop(status,lineId,callType,interactionID,ani,dnis,attachedData){}
function onPartyDeletedEvent(lineId,callType,interactionID,attactchData){}

function onAutoCampaignReschedule(){}
function onUpdateAutoCampaignRecord(){}
function onAutoCampaignDoNotCall(){}
function onCompleteAutoCampaignRecord(){}
function onAutoCampaignError(msg){}
function onAutoCampaignScheduledCall(key,value){}