function onPartyDeletedEvent(lineId,callType,interactionID,attactchData){}

function onAppletReady(){}

function onAppletInitFailed(reason){}

function onServerDisconnected(){}

function onAgentEvent(status,reason,mediaType,workmode){
	if(mediaType=='1'){	//email	
		if(status==203){
			//hamdle login event
		}else if (status==202){
 			//handle logout event
 		}		
	}else if(mediaType=='2'){	//chat
		if(status==203){
			//hamdle login event
		}else if (status==202){
			//handle logout event
		}	
	}
}

function onVoiceEvent(status,lineId,callType,interactionID,ani,dnis,attachedData, extensions){}

function onChatEvent(status, callType, interactionID,customerName, attachedData, extensions){
	if(status==VOICE_STATUS_RINGING){		
		//
	}else if(status==VOICE_STATUS_TALKING){	
		//
	}else if(status==VOICE_STATUS_IDLE){
	    //
	}else if(status==10){ //transfer failed
	    //		
	}else if(status==9){//client left
		//alert("9 chat "+ interactionID );			 
	}
}

function onEmailEvent(status, callType, interactionID, fromAddress, attachedData, extensions){	
	if(status==VOICE_STATUS_RINGING){		
		//
	}else if(status==VOICE_STATUS_TALKING){	
		//
	}else if(status==VOICE_STATUS_IDLE){
	    //
	}else if(status==10){ //transfer failed
	    //		
	}
}
function onScreenPopup(mediaType,interactionID,callType,status, ani,dnis, attachedData){}

function onChatMessage(interactionID,message,messageFrom){
}

function onAgentMonitor(status,callType,monitorStatus,successagentid){}

function onCallOverTime(mediaType,interactionID){}

function onOutboundCallOverTime(status,lineId,callType,interactionID,ani,dnis,attachedData){}

function onAutoCampaignReschedule(){}

function onUpdateAutoCampaignRecord(){}

function onAutoCampaignDoNotCall(){}

function onCompleteAutoCampaignRecord(){}

function onAutoCampaignScheduledCall(key,value){}

function onAutoCampaignError(msg){}

function onHeldStart(status,lineId,callType,interactionID,ani,dnis,attachedData, extensions){}

function onHeldStop(status,lineId,callType,interactionID,ani,dnis,attachedData, extensions){}

function onPartyAddEvent(istatus,lineId,callType, interactionID, ani, dnis, extensions){}

function onAttachedDataChangedEvent(mediaType,lineId,callType,interactionID,attachedData){}

function onAbandonedEvent(status,lineId,callType,interactionID,ani,dnis,attachedData){}

function onChangeAgentChannelStateInCache(currentState){}

function onChangeAgentStateInCache(currentState){}

function onChangeAgentOffLineInCache(id){}

function onMakeCall(phoneNumber){return true;}

function getIVRList(){
	return "IVR-APP,IVR-APP0001,1601#@@#name2,context2,extension2";
}