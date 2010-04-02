//object class *************begin***************
function ContactStateModel(nBoundType,nChannelId,nStateId,dtStartTime,dtEndTime,strInteractionId){
	this.LId              = '';
	this.NBoundType       = nBoundType;
	this.NChannelId       = nChannelId;
	this.NStateId         = nStateId;
	this.dtStartTime      = dtStartTime;
	this.dtEndTime        = dtEndTime;
	this.dtCreateTime     = '';
	this.LAgentId         = top.getUserId();
	this.LDeptId          = top.getDeptId();
	this.strInteractionId = strInteractionId;
};

ContactStateModel.prototype.getLId              = function(){return this.LId             ;};
ContactStateModel.prototype.getNBoundType       = function(){return this.NBoundType      ;};
ContactStateModel.prototype.getNChannelId       = function(){return this.NChannelId      ;};
ContactStateModel.prototype.getNStateId		    = function(){return this.NStateId        ;};
ContactStateModel.prototype.getDtStartTime      = function(){return this.dtStartTime     ;};
ContactStateModel.prototype.getDtEndTime        = function(){return this.dtEndTime       ;};
ContactStateModel.prototype.getDtCreateTime     = function(){return this.dtCreateTime    ;};
ContactStateModel.prototype.getLAgentId     	= function(){return this.LAgentId     	 ;};
ContactStateModel.prototype.getLDeptId     		= function(){return this.LDeptId     	 ;};
ContactStateModel.prototype.getStrInteractionId = function(){return this.strInteractionId;};

ContactStateModel.prototype.setLId              = function(lId             ){this.LId             =lId              ;};
ContactStateModel.prototype.setNBoundType       = function(nBoundType      ){this.NBoundType      =nBoundType       ;};
ContactStateModel.prototype.setNChannelId       = function(nChannelId      ){this.NChannelId      =nChannelId       ;};
ContactStateModel.prototype.setNStateId 	    = function(nStateId        ){this.NStateId	      =nStateId         ;};
ContactStateModel.prototype.setDtStartTime      = function(dtStartTime     ){this.dtStartTime     =dtStartTime      ;};
ContactStateModel.prototype.setDtEndTime        = function(dtEndTime       ){this.dtEndTime       =dtEndTime        ;};
ContactStateModel.prototype.setDtCreateTime     = function(dtCreateTime    ){this.dtCreateTime    =dtCreateTime     ;};
ContactStateModel.prototype.setLAgentId         = function(lAgentId        ){this.LAgentId        =lAgentId         ;};
ContactStateModel.prototype.setLDeptId      	= function(lDeptId    	   ){this.LDeptId         =lDeptId          ;};
ContactStateModel.prototype.setStrInteractionId = function(strInteractionId){this.strInteractionId=strInteractionId ;};

ContactStateModel.prototype.toString = function(){
	var rnt ="";
	rnt+='{[LId             :'+	this.LId               + ']\n';
	rnt+='[NBoundType       :'+	this.NBoundType        + ']\n';
	rnt+='[NChannelId       :'+	this.NChannelId        + ']\n';
	rnt+='[NStateId         :'+	this.NStateId          + ']\n';
	rnt+='[dtStartTime      :'+	this.dtStartTime       + ']\n';
	rnt+='[dtEndTime        :'+	this.dtEndTime         + ']\n';
	rnt+='[dtCreateTime     :'+	this.dtCreateTime      + ']\n';
	rnt+='[LAgentId         :'+	this.LAgentId          + ']\n';
	rnt+='[LDeptId          :'+	this.LDeptId           + ']\n';
	rnt+='[strInteractionId :'+	this.strInteractionId  + ']\n';
	return rnt;
}

//var ContactStateArray = new ContactStateArray();
function ContactStateArray(){
	
	this.contacts = {};//所有联络事件
	this._keySeparator="_";
	this._contactsInteractionIDKey = {};//同一个interactionID下的所有事件KEY
	this._contactsInteractionIDHold = {};//同一个interactionID下的所有Hold事件计数
}

/*
添加联络事件
*/
ContactStateArray.prototype.addContactState = function (nBoundType,
						nChannelId,
						nStateId,
						dtStartTime,
						dtEndTime,
						strInteractionId){
	try{
		var key = strInteractionId+this._keySeparator+nStateId;
		this.contacts[key] = new ContactStateModel(nBoundType,
												nChannelId,
												nStateId,
												dtStartTime,
												dtEndTime,
												strInteractionId);
		
		this._saveContactsInteractionIDKey(strInteractionId,key);
		//this._initContactsInteractionIDHold(strInteractionId);
	}catch(e){
		//alert('addContact.error:'+e.description);
	}
};

ContactStateArray.prototype.addContactHoldState = function (nBoundType,
						nChannelId,
						nStateId,
						dtStartTime,
						dtEndTime,
						strInteractionId){
	try{
		var key = strInteractionId+this._keySeparator+nStateId+this._keySeparator+this._getContactsInteractionIDHold(strInteractionId);
		this.contacts[key] = new ContactStateModel(nBoundType,
												nChannelId,
												nStateId,
												dtStartTime,
												dtEndTime,
												strInteractionId);
		
		this._saveContactsInteractionIDKey(strInteractionId,key);
	}catch(e){
		//alert('addContact.error:'+e.description);
	}
};


//private 
ContactStateArray.prototype._saveContactsInteractionIDKey = function(interactionID,key){
	if(isNull(this._contactsInteractionIDKey[interactionID])){
		this._contactsInteractionIDKey[interactionID] = {};	
	}
	this._contactsInteractionIDKey[interactionID][key] = key;
}

ContactStateArray.prototype._saveContactsInteractionIDHold = function(interactionID){
	if(isNull(this._contactsInteractionIDHold[interactionID])){
		this._contactsInteractionIDHold[interactionID] = 0;	
	}
	this._contactsInteractionIDHold[interactionID] += 1;
}

ContactStateArray.prototype._initContactsInteractionIDHold = function(interactionID){
	if(isNull(this._contactsInteractionIDHold[interactionID])){
		this._contactsInteractionIDHold[interactionID] = 0;	
	}
	this._contactsInteractionIDHold[interactionID] = 0;
}

ContactStateArray.prototype._getContactsInteractionIDHold = function(interactionID){
	if(isNull(this._contactsInteractionIDHold[interactionID])){
		this._contactsInteractionIDHold[interactionID] = 0;	
	}
	return this._contactsInteractionIDHold[interactionID];
}

/*
取interactionID所有联络事件数组
*/
ContactStateArray.prototype.getContactsByInteractionID = function(interactionID){
	rnt = new Array();
	try{
		var keys = this._contactsInteractionIDKey[interactionID];
		for(key in keys){
			if(!isNull(this.contacts[key])){
				rnt[rnt.length]=this.contacts[key];
			}
		}
		return rnt;
	}catch(e){
		//alert("getContactByInteractionID.error:"+e);
	}
	return null;
};

/*
删除所有interactionID对应的数据
*/
ContactStateArray.prototype.removeContactByInteractionID = function(interactionID){
	try{
		var keys = this._contactsInteractionIDKey[interactionID];
		for(key in keys){
		   this.contacts[key] = null;
		}
		
		this._contactsInteractionIDKey[interactionID] = null;
		
		
	}catch(e){
		//alert('removeContactByInteractionID.error:'+e);
	}
};

/*
有STATUS_RINGING或DIALING,STATUS_IDLE事件 ，以及STATUS_TALKING事件
*/
ContactStateArray.prototype.checkContactByInteractionID= function(interactionID){
	var rnt = false;
	try{
		var ringKey = interactionID+this._keySeparator+STATUS_RINGING;
		var talkingKey = interactionID+this._keySeparator+STATUS_TALKING;
		var idleKey = interactionID+this._keySeparator+STATUS_IDLE;
		var dialingKey = interactionID+this._keySeparator+STATUS_DIALING
		
		if((!isNull(this.contacts[ringKey])||!isNull(this.contacts[dialingKey]))&&!isNull(this.contacts[talkingKey])&&!isNull(this.contacts[idleKey])){
			rnt = true;
		}
	}catch(e){
		//alert("checkContactByInteractionID.error:"+e.description);
	}
	return rnt;
}

/*
取指定状态的事件信息
*/
ContactStateArray.prototype.getContactObjectByInteractionIDStatus = function(interactionID,status){
	var rnt = null;
	try{
		var key = interactionID+this._keySeparator+status;
		var contactStateModel = this.contacts[key];
		if(!isNull(contactStateModel)){
			rnt = contactStateModel;
		}
	}catch(e){
		//alert('getContactObjectByInteractionIDStatus.error:'+e.description);
	}
	return rnt;
}

/*
取指定状态的事件数量
*/
ContactStateArray.prototype.getContactObjectByInteractionIDStatus = function(interactionID,status){
	var rnt = 0;
	try{
		var key = interactionID+this._keySeparator+status;
		var contactStateModel = this.contacts[key];
		if(!isNull(contactStateModel)){
			rnt = contactStateModel;
		}
	}catch(e){
		//alert('getContactObjectByInteractionIDStatus.error:'+e.description);
	}
	return rnt;
}

//public method
function addVoiceConatctState(status,callType,interactionID,ani,dnis,attachedData, extensions){
	//alert('addConatctState:'+'status:'+status+"lineId:"+lineId+"callType:"+callType+"interactionID:"+interactionID+"ani:"+ani+"dnis:"+dnis+"attachedData:"+attachedData+"extensions:"+extensions);
	//alert(status);
	//alert(callType);
	var nChannelId = CHANNELID_PHONE;
	if(status==STATUS_DIALING){
		//如果是内线
		if(callType==CALLTYPE_INTERNAL){
			callType = '21';
			contactStateArray.addContactState(callType,nChannelId,status,contactUtils.getDateByExtensions(extensions),"",interactionID)
		}else if(callType==CALLTYPE_CONSULT){
		//如果是CONSULT
			
		}else{
			callType = '1';
			contactStateArray.addContactState(callType,nChannelId,status,contactUtils.getDateByExtensions(extensions),"",interactionID)
		}
	}else if(status==STATUS_RINGING){
		//如果是内线
		if(callType==CALLTYPE_INTERNAL){
			callType = '20';
			contactStateArray.addContactState(callType,nChannelId,status,contactUtils.getDateByExtensions(extensions),"",interactionID)
		}else if(callType==CALLTYPE_CONSULT){
		//如果是CONSULT
			
		}else{
			callType = '0';
			contactStateArray.addContactState(callType,nChannelId,status,contactUtils.getDateByExtensions(extensions),"",interactionID);
		}
	}else if(status==STATUS_TALKING){
		//如果是内线
		if(callType==CALLTYPE_INTERNAL){
			var objs = contactStateArray.getContactsByInteractionID(interactionID);
			if(objs!=null&&objs.length>0){
				callType = objs[0].getNBoundType();
				if(callType=='20'){
					var ringingObj = contactStateArray.getContactObjectByInteractionIDStatus(interactionID,STATUS_RINGING);
					if(!isNull(ringingObj)){
						ringingObj.setDtEndTime(contactUtils.getDateByExtensions(extensions));
					}
				}else if(callType=='21'){
					var dialingObj = contactStateArray.getContactObjectByInteractionIDStatus(interactionID,STATUS_DIALING);
					if(!isNull(dialingObj)){
						dialingObj.setDtEndTime(contactUtils.getDateByExtensions(extensions));
					}
				}
				
				contactStateArray.addContactState(callType,nChannelId,status,contactUtils.getDateByExtensions(extensions),"",interactionID);
			}
		}else if(callType==CALLTYPE_CONSULT){
		//如果是CONSULT
			
		}else{
			if(callType==CALLTYPE_INBOUND){
				callType = '0';
				var ringingObj = contactStateArray.getContactObjectByInteractionIDStatus(interactionID,STATUS_RINGING);
				if(!isNull(ringingObj)){
					ringingObj.setDtEndTime(contactUtils.getDateByExtensions(extensions));
				}
			}else if(callType==CALLTYPE_OUTBOUND){
				callType = '1';
				var dialingObj = contactStateArray.getContactObjectByInteractionIDStatus(interactionID,STATUS_DIALING);
				if(!isNull(dialingObj)){
					dialingObj.setDtEndTime(contactUtils.getDateByExtensions(extensions));
				}
			}
			contactStateArray.addContactState(callType,nChannelId,status,contactUtils.getDateByExtensions(extensions),"",interactionID);
		}
	}else if(status==STATUS_IDLE){
		//如果是内线
		if(callType==CALLTYPE_INTERNAL){
			var talkingObj = contactStateArray.getContactObjectByInteractionIDStatus(interactionID,STATUS_TALKING);
			if(!isNull(talkingObj)){
				talkingObj.setDtEndTime(contactUtils.getDateByExtensions(extensions));
				submitOneContactStateModel(interactionID);
			}
		}else if(callType==CALLTYPE_CONSULT){
		//如果是CONSULT
			
		}else{
			try{
				var talkingObj = contactStateArray.getContactObjectByInteractionIDStatus(interactionID,STATUS_TALKING);
				if(!isNull(talkingObj)){
					talkingObj.setDtEndTime(contactUtils.getDateByExtensions(extensions));
					submitOneContactStateModel(interactionID);
				}
			}catch(e){
			
			}
		}
	}
}

function addVoiceHoldState(status,callType,interactionID,ani,dnis,attachedData, extensions,stratOrEnd){
	try{
		var nChannelId = CHANNELID_PHONE;
		//如果是Hold操作开始
		if(stratOrEnd == '0'){
			//如果是内线
			if(callType==CALLTYPE_INTERNAL){
				var objs = contactStateArray.getContactsByInteractionID(interactionID);
				if(objs!=null&&objs.length>0){
					callType = objs[0].getNBoundType();
				}
				contactStateArray.addContactHoldState(callType,nChannelId,status,contactUtils.getDateByExtensions(extensions),"",interactionID)
			}else if(callType==CALLTYPE_CONSULT){
			//如果是CONSULT
				
			}else{
				if(callType==CALLTYPE_INBOUND){
					callType = '0';
				}else if(callType==CALLTYPE_OUTBOUND){
					callType = '1';
				}
				contactStateArray.addContactHoldState(callType,nChannelId,status,contactUtils.getDateByExtensions(extensions),"",interactionID)
			}
		}else{
			//如果是Hold操作结束
			//如果是内线
			if(callType==CALLTYPE_INTERNAL){
				var holdObj = contactStateArray.getContactObjectByInteractionIDStatus(interactionID,STATUS_HELD+contactStateArray._keySeparator+contactStateArray._getContactsInteractionIDHold(interactionID));
				//var holdObj = contactStateArray.getContactObjectByInteractionIDStatus(interactionID,STATUS_HELD);
				if(!isNull(holdObj)){
					holdObj.setDtEndTime(contactUtils.getDateByExtensions(extensions));
					contactStateArray._saveContactsInteractionIDHold(interactionID);
				}
			}else if(callType==CALLTYPE_CONSULT){
			//如果是CONSULT
				
			}else{
				var holdObj = contactStateArray.getContactObjectByInteractionIDStatus(interactionID,STATUS_HELD+contactStateArray._keySeparator+contactStateArray._getContactsInteractionIDHold(interactionID));
				//var holdObj = contactStateArray.getContactObjectByInteractionIDStatus(interactionID,STATUS_HELD);
				if(!isNull(holdObj)){
					holdObj.setDtEndTime(contactUtils.getDateByExtensions(extensions));
					contactStateArray._saveContactsInteractionIDHold(interactionID);
				}
			}
		}
	}catch(e){
		//alert("addVoiceHoldState error:"+e.description);
	}
}


function submitOneContactStateModel(interactionID){
	var objs = contactStateArray.getContactsByInteractionID(interactionID);
	top.jsonrpc.asm.setCallback(afterSetCallBack,true);
	top.jsonrpc.asm.saveAgentContactState(afterSubmitOneContactStateModel,top.getTenantId(),objs);
}

function afterSetCallBack(){ 
    //do nothing 
} 

function afterSubmitOneContactStateModel(result,exception){
	
}
