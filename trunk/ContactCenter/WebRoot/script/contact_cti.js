//voice interaction call type
var CALLTYPE_UNKNOWN  = 0;
var CALLTYPE_INTERNAL = 1;
var CALLTYPE_INBOUND  = 2;
var CALLTYPE_OUTBOUND = 3;
var CALLTYPE_CONSULT  = 4;


var AGENT_STATE_ONLINE=10;
var AGENT_STATE_SP=30;
var AGENT_STATE_ACW=20;
var AGENT_STATE_READY=200;
var AGENT_STATE_NOTREADY=201;
//var AGENT_STATE_SEMI_READY=205;
var AGENT_STATE_NOTINUSE=202;

var STATUS_DIALING = 54;//dialing
var STATUS_TALKING = 55;//talking
var STATUS_RINGING = 56;//ringing
var STATUS_HELD = 57;//held
var STATUS_IDLE= 2;//idle
var DELIMETE = "#@@#";

//mediaType: 0 -voice 1 -email 2 -chat 3-sms fax mail
var MEDIATYPE_VOICE = 0;
var MEDIATYPE_EMAIL = 1;
var MEDIATYPE_CHAT = 2;
var MEDIATYPE_SMS = 3;
var MEDIATYPE_FAX = 4;
var MEDIATYPE_MAIL = 5;

//soft phone
var PHONE_READY = -1;//-1: not ready 0: ready



//contact constant
var STATUS_CANCEL = 1000
//channelId 1-telphone,2-email,3-fax,4-sms,5-mail,6-Chat,7-Cobrowser,8-VOIP,9-callback
var CHANNELID_PHONE = 1;
var CHANNELID_EMAIL = 2;
var CHANNELID_FAX = 3;
var CHANNELID_SMS = 4;
var CHANNELID_MAIL = 5;
var CHANNELID_CHAT = 6;
var CHANNELID_COBROWSER = 7;
var CHANNELID_VOIP = 8;
var CHANNELID_CALLBACK = 9;

//(0:inbound,1:outbound,2:consult,3:transfer,4:conference)
var CONTACT_CALLTYPE_INBOUND  = 0;
var CONTACT_CALLTYPE_OUTBOUND = 1;
var CONTACT_CALLTYPE_CONSULT  = 2;
var CONTACT_CALLTYPE_TRANSFER  = 3;
var CONTACT_CALLTYPE_CONFERENCE  = 4;

//0---inbound;1----outbound;2---other
var strMainContactDirect="2";

//ipcc
var strContactNumber ="";//phone number
var lContactId=0;//contact table id
var strInteractionId='';
var strAttacheData ='';
var arrVoiceObject = new Array();
function VoiceObject(interactionID,time) {
	this.strInteractionID=interactionID;
	this.beginTime=time;
}
VoiceObject.prototype.getStrInteractionID	= function(){return this.strInteractionID;};
VoiceObject.prototype.getBeginTime			= function(){return this.beginTime;};
VoiceObject.prototype.setBeginTime			= function(time){this.beginTime = time;};

function addVoiceContact(nChannelId,nBoundType,strChannelValue,interactionId,dtStartTime,attachedData){
	try
	{
	top.jsonrpc.contactManager.setCallback(false);
	lContactId = top.jsonrpc.contactManager.addVoiceContact(top.getUserId(),top.getUserName(),top.getTenantId(),nChannelId,nBoundType,strChannelValue,interactionId,dtStartTime);
	strMainContactDirect = nBoundType;
	strContactNumber = strChannelValue;
	strInteractionId = interactionId;
	strAttacheData = attachedData;
	
	//update customer
	var lContacteeId = ContactUtils.prototype.getValueByKey(attachedData,"lContacteeId");
	var nCustomerType = ContactUtils.prototype.getValueByKey(attachedData,"nCustomerType");
	if (lContacteeId != '' && nCustomerType != '' && lContacteeId != 0 && nCustomerType != 0) {
		top.jsonrpc.contactManager.setCallback(afterSetCallBack,true);
		top.jsonrpc.contactManager.addCustomerToContact(afterAddCustomerToContact,top.getUserId(),top.getUserName(),top.getTenantId(),lContactId,nCustomerType,lContacteeId,strChannelValue);
	}
	}
	catch(e){}
	return lContactId;
}

function afterAddCustomerToContact(result,exception){}

function addEndTimeToContact(interactionId,dtEndTime,recordId) {
try
{
	top.jsonrpc.contactManager.setCallback(afterSetCallBack,true);
	top.jsonrpc.contactManager.addEndTimeToContact(afterAddEndTimeToContact,top.getUserId(),top.getUserName(),top.getTenantId(),interactionId,dtEndTime,recordId);
}
catch(e){}
}

function afterAddEndTimeToContact(result,exception){}

var lBusinessId =-1;
var strCustomerPhone="";
var lCustomerTime = 0;


// activityExecution.js
var lActivityId = -1;
var lContacteeId = 0;
var strActivityName="";

var strCustomerContacteeId ='' ;
var strCustomerContacteeName = '';
var strCustomerContactNumber='';

/*
 * 
 */
function resetValues(){
		top.lActivityId = -1;
		top.lContacteeId = 0;
		top.strActivityName="";
		
		//top.currentActivity = null;
		//top.nOCSActivityFlag = 0;
		
		top.strCustomerContacteeId ='' ;
		top.strCustomerContacteeName = '';
		top.strCustomerContactNumber='';
		
		//top.nFrom = '0';
		//top.isStartAutoContactee = '0';
		
		top.strMainContactDirect="2";
		top.lBusinessId =-1;
		top.strCustomerPhone="";
		top.lCustomerTime = 0;
}

//resetValues() in activityExection.js

//object class *************begin***************
function MemoModel(){
	this.strChannelValue     ='';
    this.strContent          ='';
    this.strHandleRemark     ='';
    this.strName             ='';
    this.strUserName         ='';
    this.strAgentName        ='';
    this.strContacteeName    ='';
    this.strMEMOBusinessName ='';
    this.LUserId             ='';
    this.LOwnerId            ='';
    this.NChannelId          ='';
    this.NHandleState        ='';
    this.LTenantId           ='';
    this.NPublicFlag         ='';
    this.NodeIdArray         ='';
    this.NAheadMin           ='';
    this.LBusinessId         ='';
    this.dtStartTime         ='';
    this.sRemind             ='';
    this.NUrgencyLevel       ='';
    this.dtHandleTime        ='';
    this.dtEndTime           ='';
    this.dtRemindTime        ='';
}

MemoModel.prototype.toString = function(){
	var rnt ="";
	rnt += '[strChannelValue     :'+this.strChannelValue     +']\n';
	rnt += '[strContent          :'+this.strContent          +']\n';
	rnt += '[strHandleRemark     :'+this.strHandleRemark     +']\n';
	rnt += '[strName             :'+this.strName             +']\n';
	rnt += '[strUserName         :'+this.strUserName         +']\n';
	rnt += '[strAgentName        :'+this.strAgentName        +']\n';
	rnt += '[strContacteeName    :'+this.strContacteeName    +']\n';
	rnt += '[strMEMOBusinessName :'+this.strMEMOBusinessName +']\n';
	rnt += '[LUserId             :'+this.LUserId             +']\n';
	rnt += '[LOwnerId            :'+this.LOwnerId            +']\n';
	rnt += '[NChannelId          :'+this.NChannelId          +']\n';
	rnt += '[NHandleState        :'+this.NHandleState        +']\n';
	rnt += '[LTenantId           :'+this.LTenantId           +']\n';
	rnt += '[NPublicFlag         :'+this.NPublicFlag         +']\n';
	rnt += '[NodeIdArray         :'+this.NodeIdArray         +']\n';
	rnt += '[NAheadMin           :'+this.NAheadMin           +']\n';
	rnt += '[LBusinessId         :'+this.LBusinessId         +']\n';
	rnt += '[dtStartTime         :'+this.dtStartTime         +']\n';
	rnt += '[sRemind             :'+this.sRemind             +']\n';
	rnt += '[NUrgencyLevel       :'+this.NUrgencyLevel       +']\n';
	rnt += '[dtHandleTime        :'+this.dtHandleTime        +']\n';
	rnt += '[dtEndTime           :'+this.dtEndTime           +']\n';
	rnt += '[dtRemindTime        :'+this.dtRemindTime        +']\n';
	return rnt;
}
/*
function ContactModel(
		lId                   
		,nBoundType           
		,nResult         
		,lMainCommId          
		,strSummaryName
		,lActivityId          
		,strCustomerName      
		,dtStartTime          
		,dtEndTime            
		,strCustomerId          
		,strRemark       
		,dtCreateTime         
		,lCreatorId           
		,strCreatorName       
		,dtModifyTime         
		,lModifierId          
		,strModifierName      
	        ){               
	this.lId              = lId            ;
	this.nBoundType       = nBoundType     ;
	this.nResult          = nResult        ;
	this.lMainCommId      = lMainCommId    ;
	this.strSummaryName   = strSummaryName ;
	this.lActivityId      = lActivityId    ;
	this.strCustomerName  = strCustomerName;
	this.dtStartTime      = dtStartTime    ;
	this.dtEndTime        = dtEndTime      ;
	this.strCustomerId    = strCustomerId  ;
	this.strRemark        = strRemark      ;
	this.dtCreateTime     = dtCreateTime   ;
	this.lCreatorId       = lCreatorId     ;
	this.strCreatorName   = strCreatorName ;
	this.dtModifyTime     = dtModifyTime   ;
	this.lModifierId      = lModifierId    ;
	this.strModifierName  = strModifierName;
};
*/
function ContactModel(){
	this.LId              = '';
	this.NBoundType       = '';
	this.NResult          = '';
	this.NSendErrorState  = '0';
	this.LMainCommId      = '';
	this.strSummaryName   = '';
	this.strSummaryIds    = '';
	this.LActivityId      = '';
	this.LContacteeId     = '';
	
	this.dtTraceTime      = '';
	this.strTracePhone    = '';
	this.strTraceMemo     = '';
	
	this.strCustomerName  = '';
	this.dtStartTime      = '';
	this.dtEndTime        = '';
	this.strCustomerId    = '';
	this.strRemark        = '';
	this.dtCreateTime     = '';
	this.LCreatorId       = '';
	this.strCreatorName   = '';
	this.dtModifyTime     = '';
	this.LModifierId      = '';
	this.strModifierName  = '';
	this.strContactSequenceCode = '';
	this.strAppendSequenceCode    = '';
	this.strOperationSequenceCode = '';
};

ContactModel.prototype.getLId             = function(){return this.LId            ;};
ContactModel.prototype.getNBoundType      = function(){return this.NBoundType     ;};
ContactModel.prototype.getNResult         = function(){return this.NResult        ;};
ContactModel.prototype.getNSendErrorState = function(){return this.NSendErrorState;};
ContactModel.prototype.getLMainCommId     = function(){return this.LMainCommId    ;};
ContactModel.prototype.getLActivityId     = function(){return this.LActivityId    ;};
ContactModel.prototype.getLContacteeId    = function(){return this.LContacteeId   ;};
ContactModel.prototype.getStrSummaryName  = function(){return this.strSummaryName ;};
ContactModel.prototype.getStrSummaryIds   = function(){return this.strSummaryIds  ;};
ContactModel.prototype.getStrCustomerId   = function(){return this.strCustomerId  ;};
ContactModel.prototype.getStrCustomerName = function(){return this.strCustomerName;};
ContactModel.prototype.getDtStartTime     = function(){return this.dtStartTime    ;};
ContactModel.prototype.getDtEndTime       = function(){return this.dtEndTime      ;};
ContactModel.prototype.getStrRemark       = function(){return this.strRemark      ;};
ContactModel.prototype.getDtCreateTime    = function(){return this.dtCreateTime   ;};
ContactModel.prototype.getLCreatorId      = function(){return this.LCreatorId     ;};
ContactModel.prototype.getStrCreatorName  = function(){return this.strCreatorName ;};
ContactModel.prototype.getDtModifyTime    = function(){return this.dtModifyTime   ;};
ContactModel.prototype.getLModifierId     = function(){return this.LModifierId    ;};
ContactModel.prototype.getStrModifierName = function(){return this.strModifierName;};

ContactModel.prototype.getStrContactSequenceCode = function(){return this.strContactSequenceCode;};
ContactModel.prototype.getStrAppendSequenceCode    = function(){return this.strAppendSequenceCode;   };
ContactModel.prototype.getStrOperationSequenceCode = function(){return this.strOperationSequenceCode;};

ContactModel.prototype.getDtTraceTime         = function(){ return this.dtTraceTime   ;};
ContactModel.prototype.getStrTracePhone       = function(){ return this.strTracePhone ;};
ContactModel.prototype.getStrTraceMemo        = function(){ return this.strTraceMemo  ;};


ContactModel.prototype.setLId             = function(lId            ){this.LId            =lId            ;};
ContactModel.prototype.setNBoundType      = function(nBoundType     ){this.NBoundType     =nBoundType     ;};
ContactModel.prototype.setNResult         = function(nResult        ){this.NResult        =nResult        ;};
ContactModel.prototype.setNSendErrorState = function(nSendErrorState){this.NSendErrorState=nSendErrorState;};
ContactModel.prototype.setLMainCommId     = function(lMainCommId    ){this.LMainCommId    =lMainCommId    ;};
ContactModel.prototype.setLActivityId     = function(lActivityId    ){this.LActivityId    =lActivityId    ;};
ContactModel.prototype.setLContacteeId    = function(lContacteeId   ){this.LContacteeId   =lContacteeId   ;};
ContactModel.prototype.setStrSummaryName  = function(strSummaryName ){this.strSummaryName =strSummaryName ;};
ContactModel.prototype.setStrSummaryIds   = function(strSummaryIds  ){this.strSummaryIds  =strSummaryIds  ;};
ContactModel.prototype.setStrCustomerId   = function(strCustomerId  ){this.strCustomerId  =strCustomerId  ;};
ContactModel.prototype.setStrCustomerName = function(strCustomerName){this.strCustomerName=strCustomerName;};
ContactModel.prototype.setDtStartTime     = function(dtStartTime    ){this.dtStartTime    =dtStartTime    ;};
ContactModel.prototype.setDtEndTime       = function(dtEndTime      ){this.dtEndTime      =dtEndTime      ;};
ContactModel.prototype.setStrRemark       = function(strRemark      ){this.strRemark      =strRemark      ;};
ContactModel.prototype.setDtCreateTime    = function(dtCreateTime   ){this.dtCreateTime   =dtCreateTime   ;};
ContactModel.prototype.setLCreatorId      = function(lCreatorId     ){this.LCreatorId     =lCreatorId     ;};
ContactModel.prototype.setStrCreatorName  = function(strCreatorName ){this.strCreatorName =strCreatorName ;};
ContactModel.prototype.setDtModifyTime    = function(dtModifyTime   ){this.dtModifyTime   =dtModifyTime   ;};
ContactModel.prototype.setLModifierId     = function(lModifierId    ){this.LModifierId    =lModifierId    ;};
ContactModel.prototype.setStrModifierName = function(strModifierName){this.strModifierName=strModifierName;};

ContactModel.prototype.setStrContactSequenceCode = function(strContactSequenceCode){this.strContactSequenceCode = strContactSequenceCode;};
ContactModel.prototype.setStrAppendSequenceCode    = function(strAppendSequenceCode   ){this.strAppendSequenceCode    = strAppendSequenceCode;   };
ContactModel.prototype.setStrOperationSequenceCode = function(strOperationSequenceCode){this.strOperationSequenceCode = strOperationSequenceCode;};

ContactModel.prototype.setDtTraceTime         = function(dtTraceTime  ){this.dtTraceTime   = dtTraceTime  ;};                   
ContactModel.prototype.setStrTracePhone       = function(strTracePhone){this.strTracePhone = strTracePhone;};                   
ContactModel.prototype.setStrTraceMemo        = function(strTraceMemo ){this.strTraceMemo  = strTraceMemo ;}; 


ContactModel.prototype.toString = function(){
	var rnt ="";
	rnt+='{[LId            :'+	this.LId              + ']\n';
	rnt+='[NBoundType     :'+	this.NBoundType       + ']\n';
	rnt+='[NResult        :'+	this.NResult          + ']\n';
	rnt+='[LMainCommId    :'+	this.LMainCommId      + ']\n';
	rnt+='[strSummaryName :'+	this.strSummaryName   + ']\n';
	rnt+='[strSummaryIds  :'+	this.strSummaryIds    + ']\n';
	rnt+='[LActivityId    :'+	this.LActivityId      + ']\n';
	rnt+='[strCustomerName:'+	this.strCustomerName  + ']\n';
	rnt+='[dtStartTime    :'+	this.dtStartTime      + ']\n';
	rnt+='[dtEndTime      :'+	this.dtEndTime        + ']\n';
	rnt+='[strCustomerId  :'+	this.strCustomerId    + ']\n';
	rnt+='[strRemark      :'+	this.strRemark        + ']\n';
	rnt+='[dtCreateTime   :'+	this.dtCreateTime     + ']\n';
	rnt+='[LCreatorId     :'+	this.LCreatorId       + ']\n';
	rnt+='[strCreatorName :'+	this.strCreatorName   + ']\n';
	rnt+='[dtModifyTime   :'+	this.dtModifyTime     + ']\n';
	rnt+='[LModifierId    :'+	this.LModifierId      + ']\n';
	rnt+='[strModifierName:'+	this.strModifierName  + ']}\n';
	return rnt;
}

/*
function ContactDetail(
	lId
	,lContactId
	,nBoundType
	,nChannelId
	,strChannelValue
	,strInteractionId
	,strContent
	,strAttachedDataXML
	,lAgentCTIId
	,dtStartTime
	,dtEndTime
	){
	this.lId                 = lId                 ;
	this.lContactId          = lContactId          ;
	this.nBoundType          = nBoundType          ;
	this.nChannelId          = nChannelId          ;
	this.strChannelValue     = strChannelValue     ;
	this.strInteractionId    = strInteractionId    ;
	this.strContent          = strContent          ;
	this.strAttachedDataXML  = strAttachedDataXML  ;
	this.lAgentCTIId         = lAgentCTIId         ;
	this.dtStartTime         = dtStartTime         ;
	this.dtEndTime           = dtEndTime           ;
};
*/


function ContactDetail(){
	this.LId                 = '';
	this.LContactId          = '';
	this.NBoundType          = '';
	this.NChannelId          = '';
	this.strChannelValue     = '';
	this.strInteractionId    = '';
	this.strContent          = '';
	this.strAttachedDataXML  = '';
	this.LAgentCTIId         = '';
	this.dtStartTime         = '';
	this.dtEndTime           = '';
};

ContactDetail.prototype.getLId               = function(){return this.LId                ;};
ContactDetail.prototype.getLContactId        = function(){return this.LContactId         ;};
ContactDetail.prototype.getNBoundType        = function(){return this.NBoundType         ;};
ContactDetail.prototype.getNChannelId        = function(){return this.NChannelId         ;};
ContactDetail.prototype.getStrChannelValue   = function(){return this.strChannelValue    ;};
ContactDetail.prototype.getStrInteractionId  = function(){return this.strInteractionId   ;};
ContactDetail.prototype.getStrContent        = function(){return this.strContent         ;};
ContactDetail.prototype.getStrAttachedDataXML= function(){return this.strAttachedDataXML ;};
ContactDetail.prototype.getLAgentCTIId       = function(){return this.LAgentCTIId        ;};
ContactDetail.prototype.getDtStartTime       = function(){return this.dtStartTime        ;};
ContactDetail.prototype.getDtEndTime         = function(){return this.dtEndTime          ;};


ContactDetail.prototype.setLId               = function(lId               ){this.LId               = lId                ;};
ContactDetail.prototype.setLContactId        = function(lContactId        ){this.LContactId        = lContactId         ;};
ContactDetail.prototype.setNBoundType        = function(nBoundType        ){this.NBoundType        = nBoundType         ;};
ContactDetail.prototype.setNChannelId        = function(nChannelId        ){this.NChannelId        = nChannelId         ;};
ContactDetail.prototype.setStrChannelValue   = function(strChannelValue   ){this.strChannelValue   = strChannelValue    ;};
ContactDetail.prototype.setStrInteractionId  = function(strInteractionId  ){this.strInteractionId  = strInteractionId   ;};
ContactDetail.prototype.setStrContent        = function(strContent        ){this.strContent        = strContent         ;};
ContactDetail.prototype.setStrAttachedDataXML= function(strAttachedDataXML){this.strAttachedDataXML= strAttachedDataXML ;};
ContactDetail.prototype.setLAgentCTIId       = function(lAgentCTIId       ){this.LAgentCTIId       = lAgentCTIId        ;};
ContactDetail.prototype.setDtStartTime       = function(dtStartTime       ){this.dtStartTime       = dtStartTime        ;};
ContactDetail.prototype.setDtEndTime         = function(dtEndTime         ){this.dtEndTime         = dtEndTime          ;};

ContactDetail.prototype.toString = function(){
	var rnt = "{";
	rnt +="[lId               :"+this.LId               +"]\n";
	rnt +="[lContactId        :"+this.LContactId        +"]\n";
	rnt +="[nBoundType        :"+this.NBoundType        +"]\n";
	rnt +="[nChannelId        :"+this.NChannelId        +"]\n";
	rnt +="[strChannelValue   :"+this.strChannelValue   +"]\n";
	rnt +="[strInteractionId  :"+this.strInteractionId  +"]\n";
	rnt +="[strContent        :"+this.strContent        +"]\n";
	rnt +="[strAttachedDataXML:"+this.strAttachedDataXML+"]\n";
	rnt +="[lAgentCTIId       :"+this.LAgentCTIId       +"]\n";
	rnt +="[dtStartTime       :"+this.dtStartTime       +"]\n";
        rnt +="[dtEndTime         :"+this.dtEndTime         +"]}\n";
        return rnt;
}



function ContactObject(interactionID,callType,status,lineId,completeFlag,nChannelId,attachedData,strChannelValue,dtStatTime,strContent) {
	this.interactionID = interactionID;//interactionID
	this.callType = callType;// callType
	this.status = status;//status:54 dialing  55 talking  56 ringing  57 held 2 idle
	this.lineId = lineId;//lineId
	this.dtStartTime = dtStatTime;
	this.completeFlag = completeFlag;//0--not complete 1--completed
	this.nChannelId = nChannelId;//contact ChannelId
	this.strChannelValue = strChannelValue;//strChannelValue:PhoneNumber/EmailAddress/FaxNumber/MobilePhoneAddress/...
	this.attachedData = attachedData;//AttachedData
	this.strContent = strContent;//Content text
	
};
//public method
ContactObject.prototype.getInteractionID =function () {return this.interactionID;};
ContactObject.prototype.setInteractionID =function (interactionID) {this.interactionID = interactionID;};

ContactObject.prototype.getCallType =function () {return this.callType;};
ContactObject.prototype.setCallType =function (callType) {this.callType = callType;};

ContactObject.prototype.getStatus =function () {return this.status;};
ContactObject.prototype.setStatus =function (status) {this.status = status;};

ContactObject.prototype.getLineId =function () {return this.lineId;};
ContactObject.prototype.setLineId =function (lineId) {this.lineId = lineId;};

ContactObject.prototype.getDtStartTime =function () {return this.dtStartTime;};
ContactObject.prototype.setDtStartTime =function (dtStartTime) {this.dtStartTime = dtStartTime;};

ContactObject.prototype.getCompleteFlag =function () {return this.completeFlag;};
ContactObject.prototype.setCompleteFlag =function (completeFlag) {this.completeFlag =completeFlag;};

ContactObject.prototype.getNChannelId =function () {return this.nChannelId;};
ContactObject.prototype.setNChannelId =function (nChannelId) {this.nChannelId = nChannelId;};

ContactObject.prototype.getStrChannelValue =function () {return this.strChannelValue;};
ContactObject.prototype.setStrChannelValue =function (strChannelValue) {this.strChannelValue = strChannelValue;};

ContactObject.prototype.getAttachedData =function () {return this.attachedData;};
ContactObject.prototype.setAttachedData =function (attachedData) {this.attachedData = attachedData;};

ContactObject.prototype.getStrContent =function () {return this.strContent;};
ContactObject.prototype.setStrContent =function (strContent) {this.strContent = strContent;};

ContactObject.prototype.toString = function(){
	var rnt = "{[interactionID:"+this.interactionID+"],\n";
	rnt +="[callType:"+this.callType+"],\n";
	rnt +="[status:"+this.status+"],\n";
	rnt +="[dtStartTime:"+this.dtStartTime+"],\n";
	rnt +="[lineId:"+this.lineId+"],\n";
	rnt +="[completeFlag:"+this.completeFlag+"],\n";
	rnt +="[nChannelId:"+this.nChannelId+"],\n";
	rnt +="[strChannelValue:"+this.strChannelValue+"],\n";
	rnt +="[attachedData:"+this.attachedData+"]}\n";
	rnt +="[strContent:"+this.strContent+"]}\n";
	return rnt;	
}


//var contactArray = new ContactArray();
function ContactArray(){
	
	this.contacts = {};//
	
	this._keySeparator="_";
	this._contactsInteractionIDKey = {};//interactionIDKEY
	
	
	this.currentPhoneMainComm = null; //interactionID
	this.currentPhoneMainCommAboutInteractionIDKey = {}; //KEY
	
	this.noSummaryInteractionID = {};
}
//private 
ContactArray.prototype._saveContactsInteractionIDKey = function(interactionID,key){
	if(isNull(this._contactsInteractionIDKey[interactionID])){
		this._contactsInteractionIDKey[interactionID] = {};	
	}
	this._contactsInteractionIDKey[interactionID][key] = key;
}
/*

phone,phone
*/
ContactArray.prototype._saveMainCommInteractionID = function(nChannelId,interactionID,key){
	try{
		if(nChannelId==CHANNELID_PHONE){
			if(isNull(this.currentPhoneMainComm)){
				//this.currentPhoneMainComm = interactionID;//interactionID
			}
			if(this.currentPhoneMainComm!=interactionID){
				this.currentPhoneMainCommAboutInteractionIDKey[key] = key;
			}
			
		}
	}catch(e){
		//alert(e);
	}
	
};

ContactArray.prototype._removeMainCommInteractionID = function(interactionID){
	try{
		for(key in this.currentPhoneMainCommAboutInteractionIDKey){
			if(!isNull(this.contacts[key])){
				this._contactsInteractionIDKey[this.contacts[key].interactionID] = null;
			}
			this.contacts[key] = null;
		}
		this.currentPhoneMainComm = null;
		this.currentPhoneMainCommAboutInteractionIDKey = {};
	}catch(e){
		
	}
};

//public

ContactArray.prototype.addNoSummaryInteractionID = function(interactionID){
	this.noSummaryInteractionID[interactionID] = interactionID;
}

ContactArray.prototype.checkNoSummaryInteractionID = function(interactionID){
	var rnt = false;
	if(!isNull(this.noSummaryInteractionID[interactionID])){
		rnt = true;
	}
	return rnt;
}


ContactArray.prototype.removeNoSummaryInteractionID = function(interactionID){
	this.noSummaryInteractionID[interactionID] =  null;
}


/*
interactionID 
*/
ContactArray.prototype.isMainCommInteractionID = function(interactionID){
	if(!isNull(this.currentPhoneMainComm)&&interactionID == this.currentPhoneMainComm){
		return true;
	}else{
		return false;
	}
}

/*

*/
ContactArray.prototype.addContact = function (interactionID,
						callType,
						status,
						lineId,
						completeFlag,
						nChannelId,
						attachedData,
						strChannelValue,
						dtStatTime,
						strContent){
	try{
		var key = interactionID+this._keySeparator+status;
		this.contacts[key] = new ContactObject(interactionID,
		                                       callType,
		                                       status,
		                                       lineId,
		                                       completeFlag,
		                                       nChannelId,
		                                       attachedData,
		                                       strChannelValue,
		                                       dtStatTime,
		                                       strContent);
		
		this._saveContactsInteractionIDKey(interactionID,key);
		
		this._saveMainCommInteractionID(nChannelId,interactionID,key);
	}catch(e){
		//alert('addContact.error:'+e);
	}
};
/*
ContactObject
*/
ContactArray.prototype.addContactObject = function(contactObject){
	try{
		if(!isNull(contactObject)&&contactObject instanceof ContactObject){
			var key = contactObject.interactionID+this._keySeparator+contactObject.status;
			this.contacts[key] = contactObject;
			this._saveContactsInteractionIDKey(contactObject.interactionID,key);
			this._saveMainCommInteractionID(contactObject.nChannelId,contactObject.interactionID,key);
		}
	}catch(e){
		//alert('addContactObject.error:'+e);
	}
};

/*

*/
ContactArray.prototype.getAllContacts = function(){
	rnt = new Array();
	try{
		for(c in this.contacts){
			if(!isNull(this.contacts[c])){
				rnt[rnt.length]=this.contacts[c];
			}
		}
		return rnt;
	}catch(e){
		//alert("getContacts.error:"+e);
	}
	return null;	
};

/*
interactionID
*/
ContactArray.prototype.getContactsByInteractionID = function(interactionID){
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
interactionID,interactionID
*/
ContactArray.prototype.getAboutContactsByInteractionID = function(interactionID){
	rnt = new Array();
	try{
		if(this.isMainCommInteractionID(interactionID)){
			for(key in this.currentPhoneMainCommAboutInteractionIDKey){
				if(!isNull(this.contacts[key])){
					rnt[rnt.length]=this.contacts[key];
				}
			}
		}
		return rnt;
	}catch(e){
		//alert("getContactByInteractionID.error:"+e);
	}
	return null;
};
/*
  tbXXXXXXContactCommContactDetail 0 
*/
ContactArray.prototype.getContactsDetailByInteractionID = function(interactionID){
	rnt = new Array();
	try{
		var contacts = this.getContactsByInteractionID(interactionID);
		if(!isNull(contacts)&&contacts.length>0){
			var details = contactUtils.contactObjects2contactDetails(contacts);
			if(!isNull(details)&&details.length==1){
				
				//rnt[0] = details[0];

				var aboutContacts = this.getAboutContactsByInteractionID(interactionID);
				if(!isNull(aboutContacts)&&aboutContacts.length>0){
					var abountDetails = contactUtils.contactObjects2contactDetails(aboutContacts);
					if(!isNull(abountDetails)&&abountDetails.length>0){
						for(var i = 0;i<abountDetails.length;i++){
							if (!isNull(abountDetails[i].getNBoundType())) {
								details[details.length] = abountDetails[i];
							}
						}
					}
				}
				return details;
			}
		}
	}catch(e){
		//alert("getContactByInteractionID.error:"+e.description);
	}
	return null;
}
/*

*/
ContactArray.prototype.getContactObjectByInteractionIDStatus = function(interactionID,status){
	var rnt = null;
	try{
		var key = interactionID+this._keySeparator+status;
		var contactObject = this.contacts[key];
		if(!isNull(contactObject)){
			rnt = contactObject;
		}
	}catch(e){
		
	}
	return rnt;
}

/*

*/
ContactArray.prototype.getBeginTimeByInteractionIDStatus = function(interactionID,status){
	var rnt = null;
	try{
		var key = interactionID+this._keySeparator+status;
		var contactObject = this.contacts[key];
		if(!isNull(contactObject)){
			var dtStartTime = contactObject.getDtStartTime();
			if(!isNull(dtStartTime)){
				return parseDate(dtStartTime);
			}
		}
	}catch(e){
		
	}
	return rnt;
}
/*
STATUS_RINGING ,STATUS_IDLE STATUS_TALKING
*/
ContactArray.prototype.checkContactByInteractionID= function(interactionID){
	var rnt = false;
	try{
		var ringKey = interactionID+this._keySeparator+STATUS_RINGING;
		var talkingKey = interactionID+this._keySeparator+STATUS_TALKING;
		var idleKey = interactionID+this._keySeparator+STATUS_IDLE;
		
		if(isNull(this.contacts[talkingKey])&&!isNull(this.contacts[idleKey])){
			rnt = true;
		}
	}catch(e){
		//alert("checkContactByInteractionID.error:"+e.description);
	}
	return rnt;
}

/*
interactionID
*/
ContactArray.prototype.removeContactByInteractionID = function(interactionID){
	try{
		
		if(this.isMainCommInteractionID(interactionID)){
			this._removeMainCommInteractionID(interactionID);
		}
		
		var keys = this._contactsInteractionIDKey[interactionID];
		for(key in keys){
		   if(this.isMainCommInteractionID(interactionID)==false
		     &&!isNull(this.currentPhoneMainCommAboutInteractionIDKey[key])
		   ){
		   	this.currentPhoneMainCommAboutInteractionIDKey[key] = null;
		   }
		   this.contacts[key] = null;
		}
		
		this._contactsInteractionIDKey[interactionID] = null;
		
		
	}catch(e){
		//alert('removeContactByInteractionID.error:'+e);
	}
};
/*
	
*/
ContactArray.prototype.canShowSummaryByInteractionID = function(interactionID){
	rnt = 0;
	try{
		var contacts = this.getContactsByInteractionID(interactionID);
		if(!isNull(contacts)&&contacts.length>0){
			for(var i=0;i<contacts.length;i++){
				if(contacts[i].getStatus()==STATUS_TALKING || contacts[i].getStatus()==STATUS_IDLE){
					rnt = 1;
					break;
				}
			}
		}
	}catch(e){
		//alert("canShowSummaryByInteractionID.error:"+e);
	}
	return rnt;
};

ContactArray.prototype.canSubmitSummaryByInteractionID = function(interactionID){
	rnt = 0;
	try{
		var contacts = this.getContactsByInteractionID(interactionID);
		if(!isNull(contacts)&&contacts.length>0){
			for(var i=0;i<contacts.length;i++){
				if(contacts[i].getStatus()==STATUS_IDLE){
					rnt = 1;
					break;
				}
			}
		}
	}catch(e){
		//alert("canShowSummaryByInteractionID.error:"+e);
	}
	return rnt;
};

ContactArray.prototype.toString = function(){
	var rnt ="";
	//
	rnt +="all Contacts:\n";
	for(c in this.contacts){
		if(!isNull(c)&&!isNull(this.contacts[c])){
			rnt+="key:"+c+"\n";
			rnt+=this.contacts[c].toString();
			rnt+="\n";
		}
	}
	
	//interactionIDKEY
	rnt+="All_contactsInteractionIDKey:\n";
	
	for(_id in this._contactsInteractionIDKey){
		if(!isNull(_id)&&!isNull(this._contactsInteractionIDKey[_id])){
			rnt+="InteractionID:"+_id+"\n";
			for(key in this._contactsInteractionIDKey[_id]){
				if(!isNull(this._contactsInteractionIDKey[_id][key])){
					rnt +=key;
					rnt +=":";
				}
			}
			rnt +="\n";
		}
		
	}
	
	rnt+="currentPhoneMainComm:"+this.currentPhoneMainComm+"\n";
	
	//KEY
	rnt+="currentPhoneMainCommAboutInteractionIDKey:\n";
	for(aboutKey in this.currentPhoneMainCommAboutInteractionIDKey){
		if(!isNull(this.currentPhoneMainCommAboutInteractionIDKey[aboutKey])){
			rnt +=aboutKey;
			rnt +=":";
		}
	}
	return rnt;
}

/*

*/
//var contactUtils = new ContactUtils();
function ContactUtils(){
	initInteractionID =0 ;
};

ContactUtils.prototype.ctiCallType2ContactCallType = function(ctiCallType){
	var rnt = CONTACT_CALLTYPE_CONSULT ;
	if (ctiCallType == CALLTYPE_INBOUND) {
		rnt = CONTACT_CALLTYPE_INBOUND;      //convert calltype from cti to contact
	} else if (ctiCallType == CALLTYPE_OUTBOUND) {
		rnt = CONTACT_CALLTYPE_OUTBOUND;     //convert calltype from cti to contact
	} else {
		rnt = CONTACT_CALLTYPE_CONSULT;      //convert calltype from cti to contact
	}
	return rnt;
};
 /*
 formatArrayToString
 */
 ContactUtils.prototype.formatArrayToString = function (dataArray) {
    var str = "";
    for (index in dataArray) {
        str += dataArray[index] + DELIMETE;
    }
    return str;
}

/*
 formatStringToArray
*/
ContactUtils.prototype.formatStringToArray = function(dataString){
	if(!dataString){
		return null;
	}
	return dataString.split(DELIMETE);
};

/*
 keyValue
*/
ContactUtils.prototype.getValueByKey = function(dataString,key){
	if(!dataString){
		return '';
	}
	
	var arrs = dataString.split(DELIMETE);
    var arr2;
    for (var i=0;i<arrs.length;i++){
        arr2=arrs[i].split("=");
        if (arr2[0]==key){
            return arr2[1];
            break;
        }
        arr2='';
    }
    arrs ='';
	return '';
};

ContactUtils.prototype.processAttachedData = function(dataString,mediaType){
	if(!dataString){
		return '';
	}
	
	if(mediaType==MEDIATYPE_EMAIL || mediaType==MEDIATYPE_CHAT ){
		var arrs = dataString.split(DELIMETE);
	    var arr2;
	    var rnt = "";
	    for (var i=0;i<arrs.length;i++){
	    	arr2=arrs[i].split("=");
	        if(arr2.length==2&&(
	        	arr2[0]=='Subject'
	        	||arr2[0]=='LastName'
	        	||arr2[0]=='FirstName'
	        	)
	        ){
	        	rnt+=arrs[i];
	        	rnt+=DELIMETE;
	        }
	    }
	    return rnt;
	}
	
	return dataString;
};

/*
extensions
*/
ContactUtils.prototype.getDateByExtensions = function(extensions){
	if(!isNull(extensions)&&extensions.indexOf('seconds=')>-1){
		//var arr = this.formatStringToArray(extensions);
		var strLong = extensions.substring(extensions.indexOf('seconds=')+8);
		if(strLong.indexOf(DELIMETE)>-1){
			strLong = strLong.substring(0,strLong.indexOf(DELIMETE));
		}
		
		if(!isNull(strLong)&&parseInt(strLong)!=NaN){

			time = getDateByLong(parseInt(strLong+"000"));
			return getStringDate(time);
		}
	}
	return null;
}

/*
CHANNELID_FAX = 3;
CHANNELID_SMS = 4;
CHANNELID_MAIL = 5;
*/
ContactUtils.prototype.makeInteractionID = function(nChannelId){
	if(nChannelId==CHANNELID_FAX || nChannelId==CHANNELID_SMS || nChannelId==CHANNELID_MAIL || nChannelId==CHANNELID_EMAIL){
		var rnt = nChannelId+"_";
		now = new Date();
		rnt+=now.getTime()+"_";
		initInteractionID++;
		rnt+=initInteractionID;
		return rnt;
	}else{
		return "";
	}
}
/*
interactionID
*/
ContactUtils.prototype.transformInteractionID = function(interactionID){
	return interactionID;
}
/*

*/
ContactUtils.prototype.getExtensionsSeconds = function(){
	time = new Date();
	return "seconds="+time.getTime();
}
/*
InteractionIDContactObjectContactDetail
*/
ContactUtils.prototype.contactObjects2contactDetails = function(contactObjects){
	var rnt = new Array();
	try{
		if(!isNull(contactObjects)&&contactObjects.length>0){
			var details = {};
			for(var i =0;i<contactObjects.length;i++){
				var interactionID = contactObjects[i].getInteractionID();
				var contactDetail = details[interactionID];
				if(isNull(contactDetail)){
					contactDetail = new ContactDetail();
					//TODO top.getPropertyValue('lPersonCTIId');
					contactDetail.setLAgentCTIId(top.getPropertyValue('lPersonCTIId'));
				}
				
				if(contactObjects[i].getStatus()==STATUS_TALKING){
					contactDetail.setStrInteractionId(interactionID);
					//contactDetail.setLContactId
					contactDetail.setNBoundType(contactObjects[i].getCallType());
					contactDetail.setNChannelId(contactObjects[i].getNChannelId());
					contactDetail.setStrChannelValue(contactObjects[i].getStrChannelValue());
					
					contactDetail.setStrContent(contactObjects[i].getStrContent());
					
					//contactDetail.setLAgentCTIId
					contactDetail.setDtStartTime(contactObjects[i].getDtStartTime());
					
				}else if(contactObjects[i].getStatus()==STATUS_IDLE){
					if(isNull(contactDetail.getStrInteractionId())){
						contactDetail.setStrInteractionId(interactionID);
						//contactDetail.setLContactId
						//CallTypetalking talkingCallType
						//contactDetail.setNBoundType(contactObjects[i].getCallType());
						contactDetail.setNChannelId(contactObjects[i].getNChannelId());
						contactDetail.setStrChannelValue(contactObjects[i].getStrChannelValue());
						
						contactDetail.setStrContent(contactObjects[i].getStrContent());
					}
					if(!isNull(contactObjects[i].getStrChannelValue()))
					{
						contactDetail.setStrChannelValue(contactObjects[i].getStrChannelValue());
					}
					contactDetail.setDtEndTime(contactObjects[i].getDtStartTime());
					//xml java
					contactDetail.setStrAttachedDataXML(contactObjects[i].getAttachedData());
				}
				if(contactDetail.getStrInteractionId()==interactionID){
					details[interactionID] = contactDetail;
				}
			}
			
			for(_id in details){
				rnt[rnt.length] = details[_id];
			}
			return rnt;
		}
	}catch(e){
		//alert("contactObjects2contactDetails.error:"+e);
	}
	return null;
}

/**
 * channelKey definition: Voice,Email,Chat 
 */
ContactUtils.prototype.isLogoutOfChannleCurrentState = function(channelKey,interactionID){
	var rnt = false;
	try{
		//Return value: 0:ready; 1:notReady; 2:Logout  
		var currentStatus = top.getChannleCurrentState(channelKey);
		if(currentStatus==2
			&&isNull(contactArray.getContactObjectByInteractionIDStatus(interactionID,STATUS_DIALING))
			){
			rnt = true;
		}
	}catch(e){
		
	}
	return rnt;
}

/**
 *  原有判断来电是否是监听电话(leader端) * 
 */
ContactUtils.prototype.isMonitorStatus = function(attachedData){
	var rnt = false;
	try{
		var _attachedData = DELIMETE+attachedData+DELIMETE;
		if(_attachedData.indexOf(DELIMETE+"monitorStatus=21"+DELIMETE)>=0){
			rnt = true;
		}
	}catch(e){
		
	}
	
	return rnt;
}

/**
 * 
 */
ContactUtils.prototype.mediaType2ChannelKey = function(mediaType){
	var rnt = '';
	if(mediaType==MEDIATYPE_VOICE){
		rnt = 'Voice';
	}else if(mediaType==MEDIATYPE_EMAIL){
		rnt = 'Email';
	}else if(mediaType==MEDIATYPE_CHAT){
		rnt = 'Chat';
	}
	return rnt;
}

//--------------------------CTIbegin-----------------------
//Applet ready
function onAppletReady(){
	top.hideWaitingPage('sys');
}
//agent status event
function onAgentEvent(status,reason,mediaType,workmode){
	
}

//when ring,popu screen
function onScreenPopup(mediaType,interactionID,callType,status, ani,dnis, attachedData, extensions){
	
	if(contactUtils.isMonitorStatus(extensions)){
		return ;
	}

	if(mediaType==MEDIATYPE_VOICE){
		var nChannelId = CHANNELID_PHONE;
		var nBoundType = 0;
		var strChannelValue= '';
		var dnisForBusiness='';
		
		if (callType == CALLTYPE_CONSULT || callType == CALLTYPE_INTERNAL){
			return;
		} else if (callType == CALLTYPE_INBOUND){
			nBoundType = CONTACT_CALLTYPE_INBOUND;
			strChannelValue = ani;
		} else if (callType == CALLTYPE_OUTBOUND){
			nBoundType = CONTACT_CALLTYPE_OUTBOUND;
			strChannelValue = dnis;
		}
		addVoiceContact(nChannelId,nBoundType,strChannelValue,interactionID,contactUtils.getDateByExtensions(extensions),attachedData);
		var voiceObject = new VoiceObject(interactionID,contactUtils.getDateByExtensions(extensions));
		for (var i=0;i<=arrVoiceObject.length;i++){
			if (arrVoiceObject[i] == undefined || arrVoiceObject[i] == '') {
				arrVoiceObject[i] = voiceObject;
				break;
			}
		}
		
		if(callType==CALLTYPE_INBOUND || callType==CALLTYPE_OUTBOUND){
			dnisForBusiness = ContactUtils.prototype.getValueByKey(attachedData,"IVR_DNIS");
			top.tempIframe_viewBusiness.viewBusiness(dnisForBusiness,attachedData,interactionID,nBoundType);
		}
	}
	
	return;
		
		//以下在ipcc中暂时不执行
			if(contactUtils.isLogoutOfChannleCurrentState(contactUtils.mediaType2ChannelKey(mediaType),interactionID)){
				return ;
			}else{
				//
						var contactObject = new ContactObject();
						contactObject.setInteractionID(interactionID);
						contactObject.setAttachedData(attachedData);
						contactObject.setNChannelId(mediaType);
						//STATUS_DIALING
						contactObject.setStatus(STATUS_DIALING);
						//contactObject.setLineId('0');
						//contactObject.setDtStartTime(contactUtils.getDateByExtensions(extensions));		
						contactObject.setCallType(contactUtils.ctiCallType2ContactCallType(callType));
						if(contactObject.getCallType()==CONTACT_CALLTYPE_INBOUND){
							contactObject.setStrChannelValue(ani);
						}else if(contactObject.getCallType()==CONTACT_CALLTYPE_OUTBOUND){
							contactObject.setStrChannelValue(dnis);
						}else if(!isNull(ani)){
							contactObject.setStrChannelValue(ani);
						}else{
							contactObject.setStrChannelValue(dnis);
						}
						contactArray.addContactObject(contactObject);
			}
	
		var url = strContextPath+"/jsp/ContactSummary";
		var isPop = true;
		var isDeleteBeforePop = false;
		var mainComm ;
		if(mediaType==MEDIATYPE_VOICE){
			url +="/popTel.jsp";
			
			mainComm = contactArray.currentPhoneMainComm;
			if(isNull(mainComm)){
				contactArray.currentPhoneMainComm = interactionID;
			//mainCommSTATUS_TALKINGmainComm
			}else if(top.lActivityId<=0&&isNull(contactArray.getContactObjectByInteractionIDStatus(mainComm,STATUS_TALKING))){
				isDeleteBeforePop = true;
				contactArray.currentPhoneMainComm = interactionID;
			}else if(mainComm==interactionID){
				var objIframe = getPopIframeByInteractionID(interactionID);
				if(!isNull(objIframe)){
					isPop = false;
				}
			}else{
				isPop = false;
			}
			
		}else if(mediaType==MEDIATYPE_EMAIL){
			url +="/popEmail.jsp";
		}else if(mediaType==MEDIATYPE_CHAT){
			url +="/popChat.jsp";
		}else if(mediaType==MEDIATYPE_SMS || mediaType==MEDIATYPE_FAX ||mediaType==MEDIATYPE_MAIL){
			url +="/popOther.jsp";
		}
		//alert(attachedData+":"+encodeURIComponent(attachedData));
		url +="?interactionID="+interactionID;
		url +="&callType="+contactUtils.ctiCallType2ContactCallType(callType);
		url +="&ani="+ani;
		url +="&dnis="+dnis;
		url +="&attachedData="+encodeURIComponent(contactUtils.processAttachedData(attachedData,mediaType));
		
		if(mediaType==MEDIATYPE_VOICE
		   &&callType==CALLTYPE_OUTBOUND
		   &&top.lActivityId>0
		   &&top.lContacteeId >0
		   ){
			url+="&isActivtiyExecution=1";
		}
		
		
		if(isPop&&mediaType==MEDIATYPE_VOICE){
			if(callType==CALLTYPE_OUTBOUND){
				top.strCustomerPhone = dnis;
			}else if(callType==CALLTYPE_INBOUND){
				top.strCustomerPhone = ani;
			}
			top.lCustomerTime = (new Date()).getTime();
			top.strMainContactDirect = contactUtils.ctiCallType2ContactCallType(callType);
		}
		
		//
		if(mediaType==MEDIATYPE_VOICE
		   &&callType==CALLTYPE_OUTBOUND
		   && attachedData != undefined
		   && attachedData.indexOf('lContacteeId')!= -1 
		   && attachedData.indexOf('lActivityId')!= -1
		   &&status!=STATUS_TALKING
		 ){
			//
			var lActivityId = contactUtils.getValueByKey(attachedData,'lActivityId');
			var lContacteeId = contactUtils.getValueByKey(attachedData,'lContacteeId');
			top.findActivity(lActivityId,lContacteeId);
			
		}else{
			// attachedDatalActivityId,
			try{
				//isSummaryOfActivity in activityExecution.js
				if(top.isSummaryOfActivity(top.lActivityId)){
				return ;
				}
			}catch(e){
				
			}
			
			if(isPop){
				//addPopCell in popu.js
				addPopCell(mediaType,interactionID,url);
			}
			
			if(isDeleteBeforePop){
				var objIframe = getPopIframeByInteractionID(mainComm);
					if(!isNull(objIframe)){
						delPopCell(mainComm);
						contactArray.removeContactByInteractionID(mainComm);
					}
			}
			//
			if(mediaType==MEDIATYPE_VOICE&&callType==CALLTYPE_INBOUND){
				top.tempIframe_viewBusiness.viewBusiness(dnis,attachedData);
			}
		}
}

/**
 * 
 * false
 */
function onActivityOutbound(status,lineId,callType,interactionID,ani,dnis,attachedData, extensions){
	var rnt = true;
	// STATUS_TALKINGtimer
	if (callType == CALLTYPE_OUTBOUND && status == STATUS_TALKING){
			if(top.lActivityId>0){
				try{
					top.onTalkingForAutoOutboundActivity();
				}catch(e){
					
				}
			}
	}
	
	//
	try{
		var _lActivityId ;
		if(callType==CALLTYPE_OUTBOUND
			&& attachedData != undefined
			&& attachedData.indexOf('lContacteeId')!= -1
			&& attachedData.indexOf('lActivityId')!= -1
		){
			_lActivityId = contactUtils.getValueByKey(attachedData,'lActivityId');
		}else if(top.lActivityId>0){
			_lActivityId = top.lActivityId;
		}
		
		if(top.isSummaryOfActivity(_lActivityId)){
				rnt =  false;
				//IDLEresetValues
				if(status==STATUS_IDLE){
					top.resetValues();
				}
		}
	}catch(e){
		
	}
	return rnt;
}

/*voice event
ani 
dnis 
*/
function onVoiceEvent(status,lineId,callType,interactionID,ani,dnis,attachedData, extensions){
	
	if(status==STATUS_TALKING&&callType != CALLTYPE_CONSULT){
		setAgentCallId(interactionID);
	}else if(status==STATUS_IDLE&&callType != CALLTYPE_CONSULT){
		resetAgentCallId(interactionID);
		isCanChangeAgent = "0";
		timeOverMonOrInterv();//30s 之内 重置状态
	}else if (status==STATUS_RINGING){
		top.setNormalLayout();
	}
			
	if(contactUtils.isMonitorStatus(extensions)){
		return;
	}

	if(status==STATUS_IDLE){
		var recordid = contactUtils.getValueByKey(attachedData,'record_id_'+top.strManDNId);
		if(recordid==null||recordid==' ' || recordid=='')
		{
			recordid=-1;
		}
		addEndTimeToContact(interactionID,contactUtils.getDateByExtensions(extensions),recordid);

		for (var i=0;i<arrVoiceObject.length;i++){
			if ((arrVoiceObject[i] != undefined) && (arrVoiceObject[i].getStrInteractionID() == interactionID)) {
				if (callType == CALLTYPE_INBOUND) {
					var beginTime = parseDate(contactUtils.getDateByExtensions(extensions)).getTime();
					var endTime = parseDate(arrVoiceObject[i].getBeginTime()).getTime();
					top.setInboundBoundStat(parseInt((beginTime - endTime),10));
				} else if (callType == CALLTYPE_OUTBOUND) {
					var beginTime = parseDate(contactUtils.getDateByExtensions(extensions)).getTime();
					var endTime = parseDate(arrVoiceObject[i].getBeginTime()).getTime();
					top.setOutboundBoundStat(parseInt((beginTime - endTime),10));
				}
				arrVoiceObject[i] = '';
				break;
			}
		}
	}
	
	interactionID = contactUtils.transformInteractionID(interactionID);
	try{
		onVoiceEventTimer(status,lineId,callType,interactionID,ani,dnis);
	}catch(e){
		
	}

	return;
	
	//以下在ipcc暂不执行
	
	//top.addVoiceConatctState(status,callType,interactionID,ani,dnis,attachedData, extensions);
	//if(status==STATUS_IDLE){
	//alert('status:'+status+"lineId:"+lineId+"callType:"+callType+"interactionID:"+interactionID+"ani:"+ani+"dnis:"+dnis+"attachedData:"+attachedData+"extensions:"+extensions);
	//top.jsonrpc.asm.saveAgentContactState('status:'+status+"lineId:"+lineId+"callType:"+callType+"interactionID:"+interactionID+"ani:"+ani+"dnis:"+dnis+"attachedData:"+attachedData+"extensions:"+extensions,null);
	//}
	if(contactUtils.isLogoutOfChannleCurrentState('Voice',interactionID)){
		return ;
	}
	if(status!=STATUS_IDLE){
	if(contactUtils.isMonitorStatus(extensions)){
		return ;
	}
	}
	
	interactionID = contactUtils.transformInteractionID(interactionID);
	try{
		onVoiceEventTimer(status,lineId,callType,interactionID,ani,dnis);
	}catch(e){
		
	}
	//
	if (
	     (callType == CALLTYPE_CONSULT 
	     && attachedData != undefined 
	     && attachedData.indexOf('transConfFlagTrue=transConfFlagTrue') != -1
	     ) 
	     || 
	     (attachedData != undefined 
	       && attachedData.indexOf('assistantOrNotMonitorKey=assistantOrNotMonitorValue') != -1
	     )
	    ) 
	{
		return;
	}
	
	try{
		if (callType == CALLTYPE_OUTBOUND&&top.lActivityId>0){
			if(top.onActivityOutbound(status,lineId,callType,interactionID,ani,dnis,attachedData, extensions)){
				
			}else{
				return ;
			}
		}
	}catch(e){
		
	}

	//
	//alert('RefuseCalling:'+contactUtils.getValueByKey(attachedData,'RefuseCalling'));
	if(!isNull(attachedData)&&contactUtils.getValueByKey(attachedData,'RefuseCalling')=='Refuse'){
		
		if(!isNull(contactArray.currentPhoneMainComm)){
			var _interactionID = contactArray.currentPhoneMainComm;
			var objIframe = getPopIframeByInteractionID(_interactionID);
			if(!isNull(objIframe)){
					delPopCell(_interactionID);
			}
			contactArray.removeContactByInteractionID(_interactionID);
		}
		
		return ;
	}
	if (
	     (status==STATUS_TALKING 
	     || status==STATUS_IDLE
	     )
	     &&
	     (callType == CALLTYPE_INBOUND 
	     || callType == CALLTYPE_OUTBOUND 
	     || callType == CALLTYPE_CONSULT)
	    )
	 {
		if(callType == CALLTYPE_INBOUND){
	 		nowInPhoneNumber = ani;//Add by Alex
	 	}

		var contactObject = new ContactObject();
		contactObject.setInteractionID(interactionID);
		contactObject.setAttachedData(attachedData);
		contactObject.setNChannelId(CHANNELID_PHONE);
		contactObject.setStatus(status);
		contactObject.setLineId(lineId);
		
		contactObject.setDtStartTime(contactUtils.getDateByExtensions(extensions));		
		contactObject.setCallType(contactUtils.ctiCallType2ContactCallType(callType));
		
		
		if(contactObject.getCallType()==CONTACT_CALLTYPE_INBOUND){
			if(!isNull(ani)){
				contactObject.setStrChannelValue(ani);
			}else{//inboundani dnis.
				try{
					var _attachedData = DELIMETE+attachedData+DELIMETE;
					if(_attachedData.indexOf(DELIMETE+"monitorStatus=21"+DELIMETE)>=0){
						contactObject.setStrChannelValue(dnis);
					}
				}catch(e){
					
				}
			}
		}else if(contactObject.getCallType()==CONTACT_CALLTYPE_OUTBOUND){
			contactObject.setStrChannelValue(dnis);
		}else if(!isNull(ani)){
			contactObject.setStrChannelValue(ani);
		}else{
			contactObject.setStrChannelValue(dnis);
		}
		
		if(status==STATUS_TALKING){
			try{
				var _extensions = DELIMETE+extensions+DELIMETE;
				if(_extensions.indexOf(DELIMETE+"CallState=1"+DELIMETE)>=0){
					contactObject.setCallType(CONTACT_CALLTYPE_TRANSFER);
				}else if(_extensions.indexOf(DELIMETE+"CallState=2"+DELIMETE)>=0){
					contactObject.setCallType(CONTACT_CALLTYPE_CONFERENCE);
				}
			}catch(e){
				
			}
		}
		
		contactArray.addContactObject(contactObject);

		//todo 
		if(contactArray.isMainCommInteractionID(interactionID)){
			if(status==STATUS_TALKING){
				//setAgentCallId(interactionID);
				var objIframe = getPopIframeByInteractionID(interactionID);
				if(!isNull(objIframe)){
					try{
					//
					//objIframe.canShowSummary();
					}catch(e){
					}
				}else{
					onScreenPopup(MEDIATYPE_VOICE,interactionID,callType,status, ani,dnis, attachedData);
				}
			}else if(status==STATUS_IDLE){
					//if (contactArray.currentPhoneMainComm == interactionID)
					//addPopCell(mediaType,interactionID,url);
					nowInPhoneNumber = '';//Add by Alex
					//setAgentCallId(interactionID);
					var objIframe = getPopIframeByInteractionID(interactionID);
					if(!isNull(objIframe)){
						//STATUS_TALKING  STATUS_IDLE
						var lActivityId = 0;
						try{
							lActivityId = parseInt(top.lActivityId);
						}catch(e){
							lActivityId = 0;
						}
						if(lActivityId<=0&&isNull(contactArray.getContactObjectByInteractionIDStatus(interactionID,STATUS_TALKING))){
							top.contactArray.removeContactByInteractionID(interactionID);
							top.delPopCell(interactionID);
						}else{
							try{
								var talkingContact = contactArray.getContactObjectByInteractionIDStatus(interactionID,STATUS_TALKING);
								var idleContact = contactArray.getContactObjectByInteractionIDStatus(interactionID,STATUS_IDLE);
								if(!isNull(talkingContact)&&!isNull(idleContact)){
									var lTalking = parseDate(talkingContact.getDtStartTime()).getTime();
									var lIdle = parseDate(idleContact.getDtStartTime()).getTime();
									if(callType == CALLTYPE_INBOUND){ 
										top.setInboundBoundStat(lIdle-lTalking);
									}else if(callType == CALLTYPE_OUTBOUND){
										top.setOutboundBoundStat(lIdle-lTalking);
									}
									//alert("lTalking"+lTalking+"_lIdle:"+lIdle+",lIdle-lTalking="+(lIdle-lTalking));
								}
							}catch(e){
								//alert(e.description);
							}
							try{
							clickPopIco(interactionID);
							objIframe.go2Summary();
							try{
							//Not Ready
								top.changeChannelState('Voice',3);
							}catch(e){
							}
							objIframe.canSumbitSummary();
							}catch(e){
								
							}
						}
					}
			}
		}
	}
}


function onAbandonedEvent(status,lineId,callType,interactionID,ani,dnis,attachedData){
	try{
		var objIframe = getPopIframeByInteractionID(interactionID);
		if(!isNull(objIframe)){
			top.contactArray.removeContactByInteractionID(interactionID);
			top.delPopCell(interactionID);
		}
	}catch(e){
		
	}
}


/** Kevin.yan Start **/
//chat event
function onChatEvent(status, callType, interactionID,customerName, attachedData, extensions){
	return;
	
	//以下ipcc暂不执行
	//alert('status:'+status+"lineId:"+lineId+"callType:"+callType+"interactionID:"+interactionID+"customerName:"+customerName+"attachedData:"+attachedData+"extensions:"+extensions);
	interactionID = contactUtils.transformInteractionID(interactionID);
	if (
	     (
	     status==STATUS_RINGING||
	     status==STATUS_TALKING 
	     || status==STATUS_IDLE
	     )
	     &&
	     (callType == CALLTYPE_INBOUND 
	     || callType == CALLTYPE_OUTBOUND 
	     || callType == CALLTYPE_CONSULT)
	    )
	 {
		var contactObject = new ContactObject();
		contactObject.setInteractionID(interactionID);
		contactObject.setAttachedData(attachedData);
		contactObject.setNChannelId(CHANNELID_CHAT);
		contactObject.setStatus(status);
		contactObject.setDtStartTime(contactUtils.getDateByExtensions(extensions));
		contactObject.setCallType(contactUtils.ctiCallType2ContactCallType(callType));
		contactObject.setStrChannelValue(customerName);
		
		
		contactArray.addContactObject(contactObject);
		
		if(status==STATUS_TALKING){
		
			addContactChat(interactionID,customerName);
		}
		//todo 
		if(status==STATUS_IDLE){
			var objIframe = getPopIframeByInteractionID(interactionID);
				if(!isNull(objIframe)){
					//IDLE TALKING
					if(contactArray.checkContactByInteractionID(interactionID)){
						top.contactArray.removeContactByInteractionID(interactionID);
						top.delPopCell(interactionID);
						top.closeTab(interactionID);
					}else{
						clickPopIco(interactionID);
						objIframe.go2Summary();
						objIframe.canSumbitSummary();
						//TODO 
						top.closeTab(interactionID);
					}
				}
		}
		
	}
	//add stella

 	 else if(status==TRANSFER_FAILED){ //10
 	
     addChatStatusMsg(interactionID,top.ChatTransFailMessage);
     
     changeButtonStatus(interactionID);
	 }else if(status==USER_LEFT){//9 client or client left interaction    callType=0:customer  1:agent
	 addChatStatusMsg(interactionID,customerName+" "+top.ChatLeftMessage);
	 }else if(status==USER_JOINED){//8 agent joined conference    callType=0:customer  1:agent
	addChatStatusMsg(interactionID,customerName+" "+top.ChatJoinMessage);
	 }
	
}


//receive and send chat message
function onChatMessage(interactionID,message,messageFrom){
	return;
	
	//以下ipcc暂不执行
	var strMessage;
	
	while(message.indexOf("<BR>")!=-1){
 		message=message.replace("<BR>","");
	}
	while(message.indexOf("\r\n")!=-1){
 		message=message.replace("\r\n","<BR>");
	}
	while(message.indexOf("\n")!=-1){
 		message=message.replace("\n","<BR>");
	}
	while(message.indexOf("\r")!=-1){
 		message=message.replace("\r","<BR>");
	}
	
	if (messageFrom == '1') {
		strMessage = message;
	} else {
		strMessage = '<span style="color:#0000aa">'+message+'</span>';
	}
	
	addChatMsg(interactionID,strMessage);

	strMessage = null;
}

//Voice Timer Class *********** Begin ****************


var voiceTimerArray = new Array(3);//Voice timer Array
voiceTimerArray[0] = null;
voiceTimerArray[1] = null;
voiceTimerArray[2] = null;

function voiceTimer() {
	this.lineId = null;
	this.interactionID = null;
	this.ani = null;			//
	this.dnis = null;			//
	this.nLeaderNotifyTimes = null;    //Leader
	this.nAgentNotifyTimes = null;    //Agent    
	this.nMaxHoldLeaderPhoneTime = null;    //Leader
	this.nHoldLeaderNotifyTimes = null;    //Leader
	this.nMaxHoldAgentPhoneTime = null;    //Agent
	this.nHoldAgentNotifyTimes = null;    //Agent
	this.nCheckPhoneAgent = null;        //AgentPhoneTime
	this.nCheckPhoneLeader = null;        //LeaderPhoneTime
	this.nCheckHoldAgent = null;        //AgentHoldTime
	this.nCheckHoldLeader = null;        //LeaderHoldTime
	this.nMaxLeaderPhoneTime = null;	//Leader
	this.nMaxAgentPhoneTime = null;		//Agent
	this.talkingTimer = 0;
	this.holdTimer = 0;
	this.talkingState = 0;
	this.holdState = 0;
	this.nTalkingTimeOver = 0;			//over time when talking
	this.nHoldingTimeOver = 0;			//over time when holding
};
voiceTimer.prototype.getTalkingState =function () {return this.talkingState;};
voiceTimer.prototype.setTalkingState =function (state) {this.talkingState = state;};

voiceTimer.prototype.getHoldState =function () {return this.holdState;};
voiceTimer.prototype.setHoldState =function (state) {this.holdState = state;};

voiceTimer.prototype.getLineId =function () {return this.lineId;};
voiceTimer.prototype.setLineId =function (lineId) {this.lineId = lineId;};

voiceTimer.prototype.getInteractionID =function () {return this.interactionID;};
voiceTimer.prototype.setInteractionID =function (interactionID) {this.interactionID = interactionID;};

voiceTimer.prototype.getAni =function () {return this.ani;};
voiceTimer.prototype.setAni =function (ani) {this.ani = ani;};

voiceTimer.prototype.getDnis =function () {return this.dnis;};
voiceTimer.prototype.setDnis =function (dnis) {this.dnis = dnis;};

voiceTimer.prototype.getNLeaderNotifyTimes =function () {return this.nLeaderNotifyTimes;};
voiceTimer.prototype.setNLeaderNotifyTimes =function (nLeaderNotifyTimes) {this.nLeaderNotifyTimes = nLeaderNotifyTimes;};

voiceTimer.prototype.getNAgentNotifyTimes =function () {return this.nAgentNotifyTimes;};
voiceTimer.prototype.setNAgentNotifyTimes =function (nAgentNotifyTimes) {this.nAgentNotifyTimes = nAgentNotifyTimes;};

voiceTimer.prototype.getNMaxHoldLeaderPhoneTime =function () {return this.nMaxHoldLeaderPhoneTime;};
voiceTimer.prototype.setNMaxHoldLeaderPhoneTime =function (nMaxHoldLeaderPhoneTime) {this.nMaxHoldLeaderPhoneTime = nMaxHoldLeaderPhoneTime;};

voiceTimer.prototype.getNHoldLeaderNotifyTimes =function () {return this.nHoldLeaderNotifyTimes;};
voiceTimer.prototype.setNHoldLeaderNotifyTimes =function (nHoldLeaderNotifyTimes) {this.nHoldLeaderNotifyTimes = nHoldLeaderNotifyTimes;};

voiceTimer.prototype.getNMaxHoldAgentPhoneTime =function () {return this.nMaxHoldAgentPhoneTime;};
voiceTimer.prototype.setNMaxHoldAgentPhoneTime =function (nMaxHoldAgentPhoneTime) {this.nMaxHoldAgentPhoneTime = nMaxHoldAgentPhoneTime;};

voiceTimer.prototype.getNHoldAgentNotifyTimes =function () {return this.nHoldAgentNotifyTimes;};
voiceTimer.prototype.setNHoldAgentNotifyTimes =function (nHoldAgentNotifyTimes) {this.nHoldAgentNotifyTimes = nHoldAgentNotifyTimes;};

voiceTimer.prototype.getNCheckPhoneAgent =function () {return this.nCheckPhoneAgent;};
voiceTimer.prototype.setNCheckPhoneAgent =function (nCheckPhoneAgent) {this.nCheckPhoneAgent = nCheckPhoneAgent;};

voiceTimer.prototype.getNCheckPhoneLeader =function () {return this.nCheckPhoneLeader;};
voiceTimer.prototype.setNCheckPhoneLeader =function (nCheckPhoneLeader) {this.nCheckPhoneLeader = nCheckPhoneLeader;};

voiceTimer.prototype.getNCheckHoldAgent =function () {return this.nCheckHoldAgent;};
voiceTimer.prototype.setNCheckHoldAgent =function (nCheckHoldAgent) {this.nCheckHoldAgent = nCheckHoldAgent;};

voiceTimer.prototype.getNCheckHoldLeader =function () {return this.nCheckHoldLeader;};
voiceTimer.prototype.setNCheckHoldLeader =function (nCheckHoldLeader) {this.nCheckHoldLeader = nCheckHoldLeader;};

voiceTimer.prototype.getNMaxLeaderPhoneTime =function () {return this.nMaxLeaderPhoneTime;};
voiceTimer.prototype.setNMaxLeaderPhoneTime =function (nMaxLeaderPhoneTime) {this.nMaxLeaderPhoneTime = nMaxLeaderPhoneTime;};

voiceTimer.prototype.getNMaxAgentPhoneTime =function () {return this.nMaxAgentPhoneTime;};
voiceTimer.prototype.setNMaxAgentPhoneTime =function (nMaxAgentPhoneTime) {this.nMaxAgentPhoneTime = nMaxAgentPhoneTime;};

voiceTimer.prototype.getTalkingTimer =function () {return this.talkingTimer;};
voiceTimer.prototype.setTalkingTimer =function (talkingTimer) {this.talkingTimer = talkingTimer;};

voiceTimer.prototype.getHoldTimer =function () {return this.holdTimer;};
voiceTimer.prototype.setHoldTimer =function (holdTimer) {this.holdTimer = holdTimer;};

voiceTimer.prototype.getNTalkingTimeOver =function () {return this.nTalkingTimeOver;};
voiceTimer.prototype.setNTalkingTimeOver =function (talkingTimeOver) {this.nTalkingTimeOver = talkingTimeOver;};

voiceTimer.prototype.getNHoldingTimeOver =function () {return this.nHoldingTimeOver;};
voiceTimer.prototype.setNHoldingTimeOver =function (holdingTimeOver) {this.nHoldingTimeOver = holdingTimeOver;};

function initVoiceTimer(lineId,interactionID,ani,dnis){
try
{
	voiceTimerArray[lineId] = new voiceTimer();
	voiceTimerArray[lineId].setLineId(lineId);
	voiceTimerArray[lineId].setInteractionID(interactionID);
	voiceTimerArray[lineId].setAni(ani);
	voiceTimerArray[lineId].setDnis(dnis);
	voiceTimerArray[lineId].setNLeaderNotifyTimes(top.jsonrpc.asm.getNLeaderNotifyTimes());
	voiceTimerArray[lineId].setNAgentNotifyTimes(top.jsonrpc.asm.getNAgentNotifyTimes());
	voiceTimerArray[lineId].setNMaxHoldLeaderPhoneTime(top.jsonrpc.asm.getNMaxHoldLeaderPhoneTime());
	voiceTimerArray[lineId].setNHoldLeaderNotifyTimes(top.jsonrpc.asm.getNHoldLeaderNotifyTimes());
	voiceTimerArray[lineId].setNMaxHoldAgentPhoneTime(top.jsonrpc.asm.getNMaxHoldAgentPhoneTime());
	voiceTimerArray[lineId].setNHoldAgentNotifyTimes(top.jsonrpc.asm.getNHoldAgentNotifyTimes());
	voiceTimerArray[lineId].setNCheckPhoneAgent(top.jsonrpc.asm.getNCheckPhoneAgent());
	voiceTimerArray[lineId].setNCheckPhoneLeader(top.jsonrpc.asm.getNCheckPhoneLeader());
	voiceTimerArray[lineId].setNCheckHoldAgent(top.jsonrpc.asm.getNCheckHoldAgent());
	voiceTimerArray[lineId].setNCheckHoldLeader(top.jsonrpc.asm.getNCheckHoldLeader());
	voiceTimerArray[lineId].setNMaxLeaderPhoneTime(top.jsonrpc.asm.getNMaxLeaderPhoneTime());
	voiceTimerArray[lineId].setNMaxAgentPhoneTime(top.jsonrpc.asm.getNMaxAgentPhoneTime());
	voiceTimerArray[lineId].setNTalkingTimeOver(top.jsonrpc.asm.getNTalkingTimeOver());
	voiceTimerArray[lineId].setNHoldingTimeOver(top.jsonrpc.asm.getNHoldingTimeOver());
}
catch(e){}
}

function classCallBack(result,exception){
}
//
function timeOutTalking(lineId){
	var talkingObj = voiceTimerArray[lineId];
	if(talkingObj == null || talkingObj.getTalkingState() == 0){
		voiceTimerArray[lineId] = null;
		return;
	}
	//Agent
	if(talkingObj.getNCheckPhoneAgent() == 1){
		if((talkingObj.getNAgentNotifyTimes() > 0) && (talkingObj.getTalkingTimer() > 0) && (talkingObj.getTalkingTimer() >= talkingObj.getNTalkingTimeOver()) 
		&& (parseInt(talkingObj.getTalkingTimer()-talkingObj.getNTalkingTimeOver()) % talkingObj.getNMaxAgentPhoneTime() == 0)){
			top.showOverTime(talkingObj.getTalkingTimer(),'talking');
			talkingObj.setNAgentNotifyTimes(talkingObj.getNAgentNotifyTimes() - 1);
		}
	}
	//Leader
	if(talkingObj.getNCheckPhoneLeader() == 1){
		try
		{
		if((talkingObj.getNLeaderNotifyTimes() > 0) && (talkingObj.getTalkingTimer() > 0) && (talkingObj.getTalkingTimer() >= talkingObj.getNTalkingTimeOver()) 
		&& (parseInt(talkingObj.getTalkingTimer()-talkingObj.getNTalkingTimeOver()) % talkingObj.getNMaxLeaderPhoneTime() == 0)){
			top.jsonrpc.asm.setCallback(afterSetCallBack,true);
			top.jsonrpc.asm.sendMessageToLead(classCallBack,top.getTenantId(),top.getUserId(),top.getUserName(),parseInt(talkingObj.getTalkingTimer()),top.localSign,"GeneralManager.overTime.TalkingRemind.toLeader");
			talkingObj.setNLeaderNotifyTimes(talkingObj.getNLeaderNotifyTimes() - 1);
		}
		}catch(e){}
	}
	talkingObj.setTalkingTimer(talkingObj.getTalkingTimer() + 1);
	setTimeout("timeOutTalking("+lineId+")",1000);
}

function afterSetCallBack(){ 
    //do nothing 
} 

//
function timeOutTalkingOn(lineId){
	var talkingObj = voiceTimerArray[lineId];
	if(talkingObj == null){
		return;
	}
	talkingObj.setTalkingState(1);
	timeOutTalking(lineId);
}
//
function timeOutTalkingOff(lineId){
	var talkingObj = voiceTimerArray[lineId];
	if(talkingObj == null){
		return;
	}
	talkingObj.setTalkingState(0);
}
//
function timeOutHolding(lineId){
try
{
	var talkingObj = voiceTimerArray[lineId];
	if(talkingObj == null){
		return;
	}
	if(talkingObj.getHoldState() == 0){
		talkingObj.setNHoldAgentNotifyTimes(top.jsonrpc.asm.getNHoldAgentNotifyTimes());
		talkingObj.setNHoldLeaderNotifyTimes(top.jsonrpc.asm.getNHoldLeaderNotifyTimes());
		talkingObj.setHoldTimer(0);
		return;
	}
	//Agent
	if(talkingObj.getNCheckHoldAgent() == 1){
		if((talkingObj.getNHoldAgentNotifyTimes() > 0) && (talkingObj.getHoldTimer() > 0) && (talkingObj.getHoldTimer() >= talkingObj.getNHoldingTimeOver()) 
		&& (parseInt(talkingObj.getHoldTimer()-talkingObj.getNHoldingTimeOver()) % talkingObj.getNMaxHoldAgentPhoneTime() == 0)){
			top.showOverTime(talkingObj.getHoldTimer(),'holding');
			talkingObj.setNHoldAgentNotifyTimes(talkingObj.getNHoldAgentNotifyTimes() - 1);
		}
	}
	//Leader
	if(talkingObj.getNCheckHoldLeader() == 1){
		if((talkingObj.getNHoldLeaderNotifyTimes() > 0) && (talkingObj.getHoldTimer() > 0) && (talkingObj.getHoldTimer() >= talkingObj.getNHoldingTimeOver()) 
		&& (parseInt(talkingObj.getHoldTimer()-talkingObj.getNHoldingTimeOver()) % talkingObj.getNMaxHoldLeaderPhoneTime() == 0)){
			top.jsonrpc.asm.setCallback(afterSetCallBack,true);
			top.jsonrpc.asm.sendMessageToLead(classCallBack,top.getTenantId(),top.getUserId(),top.getUserName(),parseInt(talkingObj.getHoldTimer()),top.localSign,"GeneralManager.overTime.HoldRemind.toLeader");
			talkingObj.setNHoldLeaderNotifyTimes(talkingObj.getNHoldLeaderNotifyTimes() - 1);
		}
	}
	talkingObj.setHoldTimer(talkingObj.getHoldTimer() + 1);
	setTimeout("timeOutHolding("+lineId+")",1000);
	}
	catch(e){}
}
//
function timeOutHoldingOn(lineId){
	var talkingObj = voiceTimerArray[lineId];
	if(talkingObj == null){
		return;
	}
	talkingObj.setHoldState(1);
	timeOutHolding(lineId);
}
//
function timeOutHoldingOff(lineId){
	var talkingObj = voiceTimerArray[lineId];
	if(talkingObj == null){
		return;
	}
	talkingObj.setHoldState(0);
}
//Voice Timer Class *********** End ******************

//
function onVoiceEventTimer(status,lineId,callType,interactionID,ani,dnis){	
	
	try{
		if(status==STATUS_TALKING){
			initVoiceTimer(lineId,interactionID,ani,dnis);
			timeOutTalkingOn(lineId);
		}else if(status==STATUS_IDLE){
			timeOutTalkingOff(lineId);
		}
	}catch(e){
		
	}
}
function onHeldStart(status,lineId,callType,interactionID,ani,dnis,attachedData,extensions){
	timeOutHoldingOn(lineId);
	top.addVoiceHoldState(status,callType,interactionID,ani,dnis,attachedData, extensions,'0');
}

function onHeldStop(status,lineId,callType,interactionID,ani,dnis,attachedData,extensions){
	timeOutHoldingOff(lineId);
	top.addVoiceHoldState(status,callType,interactionID,ani,dnis,attachedData, extensions,'1');
}
/** Kevin.yan End **/

//email event
function onEmailEvent(status, callType, interactionID, fromAddress, attachedData, extensions){
	return;
	
	//以下ipcc暂不执行
	//alert('contact:'+interactionID);
	interactionID = contactUtils.transformInteractionID(interactionID);
	if (
	     (
	     status==STATUS_RINGING||
	     status==STATUS_TALKING 
	     || status==STATUS_IDLE
	     )
	     &&
	     (callType == CALLTYPE_INBOUND 
	     || callType == CALLTYPE_OUTBOUND 
	     || callType == CALLTYPE_CONSULT)
	    )
	 {
		var contactObject = new ContactObject();
		contactObject.setInteractionID(interactionID);
		contactObject.setAttachedData(attachedData);
		contactObject.setNChannelId(CHANNELID_EMAIL);
		contactObject.setStatus(status);
		contactObject.setDtStartTime(contactUtils.getDateByExtensions(extensions));
		contactObject.setCallType(contactUtils.ctiCallType2ContactCallType(callType));
		contactObject.setStrChannelValue(fromAddress);
		
		
		contactArray.addContactObject(contactObject);
			
		//todo 
		if(status==STATUS_TALKING){
				if(callType == CALLTYPE_OUTBOUND){
					var objIframe = getPopIframeByInteractionID(interactionID);
					if(isNull(objIframe)){
						onScreenPopup(MEDIATYPE_EMAIL,interactionID,callType,status, '','', attachedData);
					}
				}
		}else if(status==STATUS_IDLE){
			var objIframe = getPopIframeByInteractionID(interactionID);
				if(!isNull(objIframe)){
					//IDLE TALKING
					//alert(contactArray.checkNoSummaryInteractionID(interactionID)+"_"+interactionID);
					if(contactArray.checkContactByInteractionID(interactionID) || contactArray.checkNoSummaryInteractionID(interactionID)){
						top.contactArray.removeContactByInteractionID(interactionID);
						top.delPopCell(interactionID);
						top.contactArray.removeNoSummaryInteractionID(interactionID);
						top.closeTab(interactionID);
					}else{
						clickPopIco(interactionID);
						objIframe.go2Summary();
						objIframe.canSumbitSummary();
						//TODO 
						top.closeTab(interactionID);
						//
						top.setStatusBarInfo(top.emailManagerOperatorEmailOK);
						top.resetOperatorEmailBarInfo();
					}
				}
		}
	}
}
/*

*/
function onEmailSendCancelEvent(interactionID){
	return;
	
	//以下ipcc暂不执行
	//var objIframe = getPopIframeByInteractionID(interactionID);
	//if(!isNull(objIframe)){
		top.contactArray.removeContactByInteractionID(interactionID);
		top.delPopCell(interactionID);
		top.contactArray.removeNoSummaryInteractionID(interactionID);
		top.closeTab(interactionID);
	//}
}

/*

*/
function onEmailSendSuccessEvent(interactionID,callType,fromAddress){
	//alert(interactionID+"_"+callType+"_"+fromAddress);
	if(callType == CONTACT_CALLTYPE_INBOUND){
		
	}else if(callType == CONTACT_CALLTYPE_OUTBOUND){
		var longTime = (new Date()).getTime();
		var seconds = Math.floor(longTime/1000);
		var extensions = "seconds="+seconds;
		onEmailEvent(STATUS_IDLE,CALLTYPE_OUTBOUND,interactionID,fromAddress,'',extensions);
	}
	//top.closeTab(interactionID);
}
/*

*/
function onNewOutboundEmail(){
	
	var interactionID = contactUtils.makeInteractionID(CHANNELID_MAIL);
	//TODO 
	var longTime = (new Date()).getTime();
	var seconds = Math.floor(longTime/1000);
	var extensions = "seconds="+seconds;
	//onEmailEvent(STATUS_TALKING,CALLTYPE_OUTBOUND,interactionID,'', '', extensions);
	//TODO 
	//top.addTab(interactionID...);
	var url = strContextPath+'/emailManager.do?method=initAddEmail'+top.getStrUserInfo()+'&lPersonCTIId='+top.getUserId()+'&strInteractionID='+interactionID;
	top.addTab(interactionID+'',top.TITLE_EMAIL,url,true,false);
	//try{
	//	//Not Ready
	//	top.changeChannelState('Email',3);
	//}catch(e){
	//	alert(e);
	//}
}

function openMail(obj){
	onNewOutboundEmail();
}

function openChat(obj){
	
}
/*
//cti
function openCobrowseDialog(){
	
}

function openCallmeback(){
	
}*/
//callback event
function onCallmebackEvent(status, callType, interactionID, fromAddress,attachedData,extensions){
	
	interactionID = contactUtils.transformInteractionID(interactionID);
	if (
	     (status==STATUS_TALKING 
	     || status==STATUS_IDLE
	     )
	     &&
	     (callType == CALLTYPE_INBOUND 
	     || callType == CALLTYPE_OUTBOUND 
	     || callType == CALLTYPE_CONSULT)
	    )
	 {
		var contactObject = new ContactObject();
		contactObject.setInteractionID(interactionID);
		contactObject.setAttachedData(attachedData);
		contactObject.setNChannelId(CHANNELID_CALLBACK);
		contactObject.setStatus(status);
		contactObject.setDtStartTime(contactUtils.getDateByExtensions(extensions));
		contactObject.setCallType(contactUtils.ctiCallType2ContactCallType(callType));
		contactObject.setStrChannelValue(fromAddress);
		
		contactArray.addContactObject(contactObject);
			
		//todo 
		if(status==STATUS_IDLE){
			var objIframe = getPopIframeByInteractionID(interactionID);
				if(!isNull(objIframe)){
					clickPopIco(interactionID);
					objIframe.go2Summary();
					objIframe.canSumbitSummary();
				}
		}
	}
}

//handle outbound SMS event
/*
SMS 
status        SMSstatus=STATUS_TALKING,
              status=STATUS_IDLE,
              status=STATUS_CANCEL
interactionID contactUtils.makeInteractionID(CHANNELID_SMS)
dnis          
strContent   
extensions    DELIMETE==#@@# :'seconds=1182335673#@@#sdfsdf=sfsdf'
             seconds=1182335673,1182335673Date.getTime(),contactUtils.getExtensionsSeconds();
*/
function handleSMSEvent(status,interactionID,dnis,strContent,extensions){
	return;
	
	//以下ipcc暂不执行
	interactionID = contactUtils.transformInteractionID(interactionID);

	if(status == STATUS_IDLE || STATUS_TALKING ){
		
		var contactObject = new ContactObject();
		contactObject.setInteractionID(interactionID);
		contactObject.setNChannelId(CHANNELID_SMS);
		contactObject.setStatus(status);
		var strTime = contactUtils.getDateByExtensions(extensions);
		if(isNull(strTime)){
			strTime = getStringDate(new Date());
		}
		contactObject.setDtStartTime(strTime);
		contactObject.setCallType(CONTACT_CALLTYPE_OUTBOUND);
		contactObject.setStrChannelValue(dnis);
		contactObject.setStrContent(strContent);
		
		contactArray.addContactObject(contactObject);
			
		if(status==STATUS_TALKING){
			var objIframe = getPopIframeByInteractionID(interactionID);
			if(isNull(objIframe)){
				onScreenPopup(MEDIATYPE_SMS,interactionID,CALLTYPE_OUTBOUND,status, '','', '');
			}
		}else if(status==STATUS_IDLE){
			var objIframe = getPopIframeByInteractionID(interactionID);
			if(!isNull(objIframe)){
				clickPopIco(interactionID);
				objIframe.go2Summary();
				objIframe.canSumbitSummary();
				//TODO 
				top.closeTab(interactionID);
			}
		}
	}
	
}

function onNewOutboundSMS(){
	var interactionID = contactUtils.makeInteractionID(CHANNELID_SMS);
	var longTime = (new Date()).getTime();
	var seconds = Math.floor(longTime/1000);
	var extensions = "seconds="+seconds;
	handleSMSEvent(STATUS_TALKING,interactionID,'', '', extensions);
	var url=strContextPath+'/smsManager.do?method=go2Add&lUserId='+top.getUserId()+'&lTenantId='+top.getTenantId()+'&strUserName='+top.getUserName()+'&nPurpose=2&interactionID='+interactionID;
	top.addTab(interactionID+'',top.TITLE_SMS,url,true,true);
}

function onSMSSendCancelEvent(interactionID){
	var objIframe = getPopIframeByInteractionID(interactionID);
	if(!isNull(objIframe)){
		top.contactArray.removeContactByInteractionID(interactionID);
		top.delPopCell(interactionID);
		//top.contactArray.removeNoSummaryInteractionID(interactionID);
		top.closeTab(interactionID);
	}
}

/*

*/
function onSMSSendSuccessEvent(interactionID,dnis,strContent){
		var longTime = (new Date()).getTime();
		var seconds = Math.floor(longTime/1000);
		var extensions = "seconds="+seconds;
		handleSMSEvent(STATUS_IDLE,interactionID,dnis,strContent,extensions);
}

//handle outbound Fax event same SMS event
function handleFaxEvent(status,interactionID,dnis,strContent,extensions){
	return;
	
	//以下ipcc暂不执行
	interactionID = contactUtils.transformInteractionID(interactionID);
	if(status == STATUS_IDLE || status==STATUS_TALKING ){
		var contactObject = new ContactObject();
		contactObject.setInteractionID(interactionID);
		contactObject.setNChannelId(CHANNELID_FAX);
		contactObject.setStatus(status);
		var strTime = contactUtils.getDateByExtensions(extensions);
		if(isNull(strTime)){
			strTime = getStringDate(new Date());
		}
		contactObject.setDtStartTime(strTime);
		contactObject.setCallType(CONTACT_CALLTYPE_OUTBOUND);
		contactObject.setStrChannelValue(dnis);
		contactObject.setStrContent(strContent);
		
		contactArray.addContactObject(contactObject);
			
		if(status==STATUS_TALKING){
			var objIframe = getPopIframeByInteractionID(interactionID);
			if(isNull(objIframe)){
				onScreenPopup(MEDIATYPE_FAX,interactionID,CALLTYPE_OUTBOUND,status, '','', '');
			}
		}else if(status==STATUS_IDLE){
			var objIframe = getPopIframeByInteractionID(interactionID);
			if(!isNull(objIframe)){
				clickPopIco(interactionID);
				objIframe.go2Summary();
				objIframe.canSumbitSummary();
				//TODO 
				top.closeTab(interactionID);
			}
		}
	}
}

function onNewOutboundFax()
{
	var interactionID = contactUtils.makeInteractionID(CHANNELID_FAX);
	var longTime = (new Date()).getTime();
	var seconds = Math.floor(longTime/1000);
	var extensions = "seconds="+seconds;
	handleFaxEvent(STATUS_TALKING,interactionID,'', '', extensions);
	//var url = strContextPath+'/faxManager.do?method=readyAdd&lUserId='+top.getUserId()+'&lTenantId='+top.getTenantId()+'&strUserName='+top.getUserName()+'&forward=/jsp/FaxManager/fax/addFax.jsp&interactionID='+interactionID;
	//modify by lisa ---delete forward;this parameter will be set in action;
	var url = strContextPath+'/faxManager.do?method=readyAdd&lUserId='+top.getUserId()+'&lTenantId='+top.getTenantId()+'&strUserName='+top.getUserName()+'&interactionID='+interactionID;
	
	
	top.addTab(interactionID+'',top.TITLE_FAX,url,true,false);

}

var nowInPhoneNumber = "";
function getNowPhoneNumber(){
	return nowInPhoneNumber;
}

function onFaxSendCancelEvent(interactionID){
	var objIframe = getPopIframeByInteractionID(interactionID);
	if(!isNull(objIframe)){
		top.contactArray.removeContactByInteractionID(interactionID);
		top.delPopCell(interactionID);
		//top.contactArray.removeNoSummaryInteractionID(interactionID);
		top.closeTab(interactionID);
	}
}

/*

*/
function onFaxSendSuccessEvent(interactionID,dnis,strContent){
		var longTime = (new Date()).getTime();
		var seconds = Math.floor(longTime/1000);
		var extensions = "seconds="+seconds;
		handleFaxEvent(STATUS_IDLE,interactionID,dnis,strContent,extensions);
}

//handle outbound Mail event same SMS event
function handleMailEvent(status,interactionID,dnis,strContent,extensions){
	return;
	
	//以下ipcc暂不执行
	interactionID = contactUtils.transformInteractionID(interactionID);
	if(status == STATUS_CANCEL){
		contactArray.removeContactByInteractionID(interactionID);
	}else if(status == STATUS_IDLE || STATUS_TALKING ){
		var contactObject = new ContactObject();
		contactObject.setInteractionID(interactionID);
		contactObject.setNChannelId(CHANNELID_MAIL);
		contactObject.setStatus(status);
		var strTime = contactUtils.getDateByExtensions(extensions);
		if(isNull(strTime)){
			strTime = getStringDate(new Date());
		}
		contactObject.setDtStartTime(strTime);
		contactObject.setCallType(CONTACT_CALLTYPE_OUTBOUND);
		contactObject.setStrChannelValue(dnis);
		contactObject.setStrContent(strContent);
		
		contactArray.addContactObject(contactObject);
			
		if(status==STATUS_TALKING){
			var objIframe = getPopIframeByInteractionID(interactionID);
			if(isNull(objIframe)){
				onScreenPopup(MEDIATYPE_MAIL,interactionID,CALLTYPE_OUTBOUND,status, '','', '');
			}
		}else if(status==STATUS_IDLE){
			var objIframe = getPopIframeByInteractionID(interactionID);
			if(!isNull(objIframe)){
				clickPopIco(interactionID);
				objIframe.go2Summary();
				objIframe.canSumbitSummary();
				//TODO 
				top.closeTab(interactionID);
			}
		}
	}
	
}
function onNewOutboundMail(){
	var interactionID = contactUtils.makeInteractionID(CHANNELID_MAIL);
	var longTime = (new Date()).getTime();
	var seconds = Math.floor(longTime/1000);
	var extensions = "seconds="+seconds;
	//handleMailEvent(STATUS_TALKING,interactionID,'', '', extensions);
	var url = strContextPath+'/mailManager.do?method=initAddMail'+top.getStrUserInfo()+'&forward=/jsp/MailManager/mail/addMail.jsp&strInteractionID='+interactionID;
	top.addTab(interactionID+'',top.TITLE_MAIL,url,true,false);
	//try{
	//	//Not Ready
	//	top.changeChannelState('Email',3);
	//}catch(e){
	//	alert(e);
	//}
}
function onMailSendCancelEvent(interactionID){
	var objIframe = getPopIframeByInteractionID(interactionID);
	if(!isNull(objIframe)){
		top.contactArray.removeContactByInteractionID(interactionID);
		top.delPopCell(interactionID);
		//top.contactArray.removeNoSummaryInteractionID(interactionID);
		top.closeTab(interactionID);
	}
}

/*

*/
function onMailSendSuccessEvent(interactionID,dnis,strContent){
		var longTime = (new Date()).getTime();
		var seconds = Math.floor(longTime/1000);
		var extensions = "seconds="+seconds;
		handleMailEvent(STATUS_IDLE,interactionID,dnis,strContent,extensions);
}

//call
function onCallOverTime(mediaType,interactionID){
	
}
//
function onOutboundCallOverTime(status,lineId,callType,interactionID,ani,dnis,attachedData){
	try{
		if(parseInt(top.lActivityId)>0){
			//CTI ACW
			top.changeAgentToACW(0);
			// IDLE
			onVoiceEvent(STATUS_IDLE,lineId,callType,interactionID,ani,dnis,attachedData, '');
		}else{
			top.delPopCell(interactionID);
		}
	}catch(e){
		top.delPopCell(interactionID);
	}
}

//alex
function onChangeAgentChannelStateInCache(currentState){
	top.changeAgentChannelStateInCache(currentState);
}
function onChangeAgentStateInCache(currentState){
	top.changeAgentStateInCache(currentState);
}

function onChangeAgentOffLineInCache(id){
	top.changeAgentOffLineInCache(id);
}

//--------------------------CTIend-----------------------

//--------------------------common function begin----------------
/*

return false or true
*/
function isNull(obj){
	try{
		if(obj==null || obj == undefined || obj==''){
			return true;
		}
	}catch(e){
		//alert(e.description);
	}
	return false;
}


/*
return Date Object
*/
function getDateByLong(lTime){
	date = new Date(lTime);
	return date;
}
/*

return yyyy-MM-dd HH:mm:ss
*/
function getStringDate(time){
	try{
		var ret=time.getFullYear() + "-" 
			    + ((time.getMonth()+1)<10?"0":"") 
			    + (time.getMonth()+1) + "-" 
			    + (time.getDate()<10?"0":"") 
			    + time.getDate(); 
		    
		ret+=" "
		   + (time.getHours()<10?"0":"") 
		   +time.getHours()+":"
		   + (time.getMinutes()<10?"0":"") 
		   +time.getMinutes()+":"
		   + (time.getSeconds()<10?"0":"") 
		   +time.getSeconds(); 
		return ret; 
	}catch(e){
	}
	return "";
}

/*

return yyyy-MM-dd HH:mm:ss
*/
function getStringDateHHmmss(time){
	try{
		var ret=""
		   + (time.getHours()<10?"0":"") 
		   +time.getHours()+":"
		   + (time.getMinutes()<10?"0":"") 
		   +time.getMinutes()+":"
		   + (time.getSeconds()<10?"0":"") 
		   +time.getSeconds(); 
		return ret; 
	}catch(e){
		
	}
	return "";
}

function getDiffTime(timediff){
	var rnt ="";
	hours = Math.floor(timediff / (1000 * 60 * 60)); 
	timediff -= hours * (1000 * 60 * 60);
	if(hours<10){
		rnt+="0";
	}
	rnt +=hours;
	rnt+=":";
	mins = Math.floor(timediff / (1000 * 60)); 
	timediff -= mins * (1000 * 60);
	
	if(mins<10){
		rnt+="0";
	}
	rnt +=mins;
	rnt+=":";
	secs = Math.floor(timediff / 1000); 
	timediff -= secs * 1000;
	if(secs<10){
		rnt+="0";
	}
	rnt +=secs;
	return rnt;
}

 /* 
   StringDate. 
   parseDate('2006-1-1') return new Date(2006,0,1) 
   parseDate(' 2006-1-1 ') return new Date(2006,0,1) 
   parseDate('2006-1-1 15:14:16') return new Date(2006,0,1,15,14,16) 
   parseDate(' 2006-1-1 15:14:16 ') return new Date(2006,0,1,15,14,16); 
   parseDate('2006-1-1 15:14:16.254') return new Date(2006,0,1,15,14,16,254) 
   parseDate(' 2006-1-1 15:14:16.254 ') return new Date(2006,0,1,15,14,16,254) 
   parseDate('') retrun null 
 */  
 function parseDate(str){
   if(typeof str == 'string'){
     var results = str.match(/^ *(\d{4})-(\d{1,2})-(\d{1,2}) *$/);  
     if(results && results.length>3)
       return new Date(parseInt(results[1],10),parseInt(results[2],10) -1,parseInt(results[3],10));   
     results = str.match(/^ *(\d{4})-(\d{1,2})-(\d{1,2}) +(\d{1,2}):(\d{1,2}):(\d{1,2}) *$/);  
     if(results && results.length>6)
       return new Date(parseInt(results[1],10),parseInt(results[2],10) -1,parseInt(results[3],10),parseInt(results[4],10),parseInt(results[5],10),parseInt(results[6],10));   
     results = str.match(/^ *(\d{4})-(\d{1,2})-(\d{1,2}) +(\d{1,2}):(\d{1,2}):(\d{1,2})\.(\d{1,9}) *$/);  
     if(results && results.length>7)
       return new Date(parseInt(results[1],10),parseInt(results[2],10) -1,parseInt(results[3],10),parseInt(results[4],10),parseInt(results[5],10),parseInt(results[6],10),parseInt(results[7],10));   
   }  
   return null; 
 }
 

//--------------------------common function end-----------------

//--------------------------add by Alex start-----------------
//monitor temp flag
var monitorFlag = '0';//default:not monitor(AgentMonitor Flag)
var monitorAgentFlag = '0';//default:not monitor // destroy!!(废除)
var interveneFlag = '0';// destroy!!(废除)
var forceremoveFlag = '0';// destroy!!(废除)
var agentMonitorSign = 0;// destroy!!(废除)
var agentMonitorId = '0';// destroy!!(废除)
var agentMonitorName = '';
var monitorOrInterveneFlag = '0'; // 监控状态（监听/抢插/强拆）标识（失败：返回错误信息  重置 or 30秒TimeOut 重置）30秒不能多次点击；（1不做成功处理；2失败有相应处理，可继续操作）
var isCanChangeAgent = '0';//监控状态标示：监听Call标识（监听/抢插/强拆）（失败：返回错误信息  重置；电话挂断之后重置 / 有可能出现遗漏某种处理情况，死循环）<成功之后作Idle标示的状态，softphone调用重置方法>
//以上是负责按钮状态标示，B1 And B2

// monitor success state// destroy!!(废除)
function successMonitor() {
	if(monitorFlag == '1'||monitorFlag == '2'){
		monitorFlag = '3';
	}
}

// intervene success state// destroy!!(废除)
function successIntervene() {
	interveneFlag = '2';//intervene
	//top.setStatusBarInfo(top.requestSuccess);
}

// forceremove success state// destroy!!(废除)
function successForceremove() {
	forceremoveFlag = '2';//forceremove
	//top.setStatusBarInfo(top.requestSuccess);
}

// monitor center state// destroy!!(废除)
function beforeMonitor(agent_id) {
	monitorFlag = '1';//monitor
	monitorAgentFlag = agent_id; // destroy!!(废除) Name != Id
	//setTimeout("timeOverMonitor();",60000);
}

function beforeMonitorAgent(agent_id) {
	monitorFlag = '2';//monitor//监听坐席标识(1-- Call ; 2 -- Agent .  1作废，目前只有2数据可作为坐席监控)
	monitorAgentFlag = agent_id; // destroy!!(废除) Name != Id
	//setTimeout("timeOverMonitor();",60000);
}

function cancalMonitor() {
	monitorFlag = '0';//monitor
	monitorAgentFlag = '0';// destroy!!(废除)
}

// intervene center state// destroy!!(废除)
function beforeIntervene() {
	interveneFlag = '1';//intervene
	agentMonitorSign = 2;
	setTimeout("timeOverIntervene();",60000);
}

// forceremove center state// destroy!!(废除)
function beforeForceremove() {
	forceremoveFlag = '1';//forceremove
	agentMonitorSign = 3;
	setTimeout("timeOverForceremove();",60000);
}

function beforeMonOrInterv() {
	isCanChangeAgent = "1";
	monitorOrInterveneFlag = '1';//forceremove
	setTimeout("timeOverMonOrInterv();",30000);
}

function timeOverMonOrInterv(){
   	if(monitorOrInterveneFlag == '1'){
   		monitorOrInterveneFlag = '0';
   	}
}

// monitor end state// destroy!!(废除)
function afterMonitor() {
	monitorFlag = '0';//not monitor
}

// intervene end state// destroy!!(废除)
function afterIntervene() {
	interveneFlag = '0';//not intervene
}

// forceremove end state// destroy!!(废除)
function afterForceremove() {
	forceremoveFlag = '0';//not forceremove
}

// destroy!!(废除)
function timeOverMonitor(){
   	if(monitorFlag == '1'||monitorFlag == '2'){
   		monitorFlag = 0;
   		monitorAgentFlag = '0';
   	}
}

// destroy!!(废除)
function timeOverIntervene(){
   	if(interveneFlag == '1'){
   		afterIntervene();
   		//top.setStatusBarInfo(top.localeManagerForceInterveneFaile);
   	}
}

// destroy!!(废除)
function timeOverForceremove(){
   	if(forceremoveFlag == '1'){
   		afterForceremove();
   		//top.setStatusBarInfo(top.localeManagerForceremoveFaile);
   	}
}

//agent monitor success// destroy!!(废除)
function agentMonitorSuccess(successagentid) {
	if(agentMonitorSign == 1){
		successMonitor();
	}else if(agentMonitorSign == 2){
		successIntervene();
	}else if(agentMonitorSign == 3){
		successForceremove();
	}
}

// end Alex
/*
 * handle AgentMonitor event
 * jarod.he
*/
//cti-event.js onAgentMonitor
/*
function handleAgentMonitor(status,callType,monitorStatus,successagentid){
 if(status==STATUS_TALKING){
  if(successagentid!="-1"){
     agentMonitorSuccess(successagentid);
    }
 }else if(status==STATUS_IDLE){
  afterMonitor();
  afterIntervene();
  afterForceremove();
  }  
   
}
*/
function getAUXValueByKey(key){
	var keys = top.getPropertyValue('strAUXKey');
	var values = top.getPropertyValue('strAUXValue');
	if(keys.indexOf(DELIMETE)!=-1){
		while(keys.indexOf(DELIMETE)!=-1){
			var tempKey = keys.substring(0,keys.indexOf(DELIMETE));
			var tempValue = values.substring(0,values.indexOf(DELIMETE));
			if(tempKey == key){
				return tempValue;
			}
			keys = keys.substring(keys.indexOf(DELIMETE)+4,keys.length);
			values = values.substring(values.indexOf(DELIMETE)+4,values.length);
		}
		if(keys==key){
			return values;
		}
	}else{
		if(keys==key){
			return values;
		}
	}
	return "";
}

function getWorkbinEmail(interactionID,lPlaceId,strWorkbinName,strFrom,strSubject){

	var longTime = (new Date()).getTime();
	var seconds = Math.floor(longTime/1000);
	var extensions = "seconds="+seconds;
	onEmailEvent(STATUS_TALKING, CALLTYPE_INBOUND, interactionID, '', '', extensions);
	
	var ani = strFrom;
	var dnis ='';
	var attachedData ='Subject='+strSubject;
	var url = strContextPath+"/jsp/ContactSummary";
		url +="/popEmail.jsp";
		url +="?interactionID="+interactionID;
		url +="&callType="+contactUtils.ctiCallType2ContactCallType(CALLTYPE_INBOUND);
		url +="&ani="+ani;
		url +="&dnis="+dnis;
		url +="&attachedData="+encodeURIComponent(attachedData);
		url +="&isWorkbin=true";
	addPopCell(MEDIATYPE_EMAIL,interactionID,url);
	
	
	var url = strContextPath+'/emailManager.do?method=getWorkbinEmail&lPlaceId='+lPlaceId+'&strWorkbinName='+strWorkbinName+'&strInteractionID='+interactionID+'&lPersonCTIId='+top.getPropertyValue('lPersonCTIId')+'&lUserId='+top.getUserId()+'&lTenantId='+top.getTenantId()+'&strUserName='+top.getUserName();
	top.addTab(interactionID+'',top.TITLE_EMAIL,url,true,true);
}

/*
 *open workbin dialog
*/
function openWorkbinDialog() {
	try{
		if (top.softPhone.getAgentStatus() == AGENT_STATE_READY) {
			changeAgentToNotReady('0');
		}
	}catch(e){}
		var iTop = (top.window.screen.availHeight-30-660)/2;       //?;
    	var iLeft = (top.window.screen.availWidth-10-580)/2;  	     
		window.open(strContextPath+'/mediaAction.do?method=getWorkbin'+getStrUserInfo()+'&lPersonCTIId='+top.getPropertyValue('lPersonCTIId')+'&lUserId='+top.getUserId()+'&lTenantId='+top.getTenantId()+'&strUserName='+top.getUserName()+'&lPlaceCTIId='+top.getPropertyValue('lPlaceCTIId'),'workbin','width=580px,height=660px,top='+iTop+',left='+iLeft);
}
//7510老版本使用，IPCC已废弃
function onAgentMonitor(status,callType,monitorStatus,successagentid){
 if(status==STATUS_TALKING){
  //if(successagentid!="-1"){
   agentMonitorSuccess(successagentid);
  //}
 }else if(status==STATUS_IDLE){
  afterMonitor();
  afterIntervene();
  afterForceremove();
 }  
}

function onPartyDeletedEvent(lineId,callType,interactionID,attactchData)
{

}
//--------------------------add by Alex end-----------------

//cti callback function (not use)
function onPartyAddEvent(istatus,lineId,callType, interactionID, ani, dnis, extensions){}

function onAttachedDataChangedEvent(mediaType,lineId,callType,interactionID,attachedData){}

function onAutoCampaignReschedule(){}

function onUpdateAutoCampaignRecord(){}

function onAutoCampaignDoNotCall(){}

function onCompleteAutoCampaignRecord(){}

function onAutoCampaignError(msg){}

function onAutoCampaignScheduledCall(key,value){}

function onAppletInitFailed(reason){}

var IsUsableCtiServer = true;
function onServerDisconnected(){
	IsUsableCtiServer = false;
	var mainCommId = contactArray.currentPhoneMainComm;
	if(!isNull(mainCommId)){
		delPopCell(mainCommId);
      	contactArray.removeContactByInteractionID(mainCommId);
	}
}
//Campaign->->OCSCall->Reschedule->
function onAutoCampaignReschedule()
{
//	alert("ok");
}


//Campaign->->OCSCall->Reschedule->
function onAutoCampaignError(msgNumber)
{
		var msg="";
		switch(msgNumber){
		case 1:
			msg = "Cannot execute request?no campaign was loaded.\n"
				+ "This is consistent with previous releases:\n"
				+ "1 - No active campaigns\n"
				+ "2 - No active preview campaigns";
			break;
		case 2:
			msg = "Cannot execute preview record request?no preview campaign was started.";
			break;
		case 3:
			msg = "All lists are empty, all records have been processed, or internal buffer is empty,\n"
				+ "and OCS is waiting for the new portion of records.";
			break;
		case 4:
			msg = "OCS received request for nonexisting or already processed record.\n";
			break;
		case 5:
			msg = "Some mandatory keys are missing.\n";
			break;
		case 6:
			msg = "Received request has the wrong request type.\n";
			break;
		case 7:
			msg = "Received time does not meet request conditions(for example; reschedule in the past).\n";
			break;
		case 8:
			msg = "OCS cannot convert string to time (for example;25/45/00).\n";
			break;
		case 10:
			msg = "Cannot execute the request due to database error.\n";
			break;
		case 12:
			msg = "The record already exists.\n";
			break;
		case 13:
			msg = "Cannot add the record.\n";
			break;
		case 15:
			msg = "Cannot start Preview dialing session.\n";
			break;
		case 16:
			msg = "Cannot close Preview dialing session.\n";
			break;
	}
	alert("Reschedule error:\n"+msg);
}

function onMakeCall(phoneNumber){
//	if(top.getIsDonntCallSetting()&&!isNull(phoneNumber)){
//		jsonrpc.asm.setCallback(false);
//		var result = jsonrpc.asm.getIsCanMakeCall(top.getTenantId(),phoneNumber);
//		if(result!='0'){
//			if(!confirm(isConfirmMakeCall))
//			{
//				return false;
//			}
//		}
//	}
	return true;
}

function getIVRList(){
	var rnt = "";
	try{
		var ivrList = top.jsonrpc.ivrManager.getIVRList(top.getTenantId());
		if(ivrList&&ivrList.list){
			var list = ivrList.list;
			for(var i=0;i<list.length;i++){
				rnt += list[i].map.APPNAME;
				rnt += ",";
				rnt += list[i].map.APPLICTIONID;
				rnt += ",";
				rnt += list[i].map.ROUTINGPOINT;
				if(i<list.length-1){
					rnt +=DELIMETE;
				}
			}
		}
	}catch(e){
		//alert(e.description);
	}
	
	return rnt;
}

function openVMDialog(theURL,iWidth,iHeight)
{
	var iTop = (top.window.screen.availHeight-30-iHeight)/2;
    var iLeft = (top.window.screen.availWidth-10-iWidth)/2;  
	openedWindow = window.open(""+theURL+"",'','width='+iWidth+',height='+iHeight+',left=scroll=auto,status=no,resizable=no,help=no,top='+iTop+',left='+iLeft);
}

function onShowVoiceMail(){
	//alert(strManDNId);
	//var url = remindlcontextPath+"/getLeaveWordFileServlet?operateType=queryLeaveWordFiles&forward=/jsp/media/voicemail.jsp&strboxuser="+strManDNId+"&lUserId="+getUserId()+"&lTenantId="+getTenantId()+"&strUserName=&nPageSize=10&nPageIndex=1&nRecordIndex=0&strOrderByFieldName=recording&strOrderDirection=desc";
	var url = remindlcontextPath+"/jsp/media/voiceMailMain.jsp?strDepartmentHeaderId="+strDepartmentHeaderId+"&strSkillGroupId="+strSkillGroupId+"&strboxuser="+strManDNId+"&lUserId="+getUserId()+"&lTenantId="+getTenantId()+"&strUserName=";
	openVMDialog(url,360,370);
}

function onShowGroupMail(){
	//alert(strSkillGroupId);
	var url = remindlcontextPath+"/getLeaveWordFileServlet?operateType=queryLeaveWordFiles&forward=/jsp/media/voicemail.jsp&strboxuser="+strSkillGroupId+"&lUserId="+getUserId()+"&lTenantId="+getTenantId()+"&strUserName=&nPageSize=10&nPageIndex=1&nRecordIndex=0&strOrderByFieldName=recording&strOrderDirection=desc";
	openVMDialog(url,360,370);
}

function onShowDeptMail(){
	//alert(strDepartmentHeaderId);
	var url = remindlcontextPath+"/getLeaveWordFileServlet?operateType=queryLeaveWordFiles&forward=/jsp/media/voicemail.jsp&strboxuser="+strDepartmentHeaderId+"&lUserId="+getUserId()+"&lTenantId="+getTenantId()+"&strUserName=&nPageSize=10&nPageIndex=1&nRecordIndex=0&strOrderByFieldName=recording&strOrderDirection=desc";
	openVMDialog(url,360,370);
}
