var channelMaps = new Map();
var agentObj;
var timerIDs = new Map();
var channelArray=new Array();

//for email,chat icon state control
var email_ringings=0;
var chat_ringings=0;

//agent status 
readyAllState=0;
readyPartState=1;
busyState=2;
offSeat=3;//not ready; 
offLine=4;//=logout

//channel status
ready=0;
notReady=1;
logout=2;
busy=3; //ring or new create a email or make a call
idle=4; // Idle-finish xiaojie or overTime

var isACWStatus = false;

function channelStateObj(name1) {
	this.name=name1;
	this.workingNumber=0;
    this.choosedState="";//0:ready, 1 not ready,2 logout
}

function agentStateObj() {	
    this.choosedState=-1; //readyAllState=0;readyPartState=1	busyState=2	offSeat=3=not ready; offLine=4=logout;
	this.ifManualAUX = false;
    this.offLineIndex=-1;//aux    
	this.offLineReasonList;//aux key:value
}

//applet AgentViewController.java
function initState(channelList){			
	var   strArray=new   Array();   
    strArray = channelList.split(",");	
	if(channelMaps.size()>0){//
	  return;
	}
	if(channelList!=""){		
		for(var i=0;i<strArray.length;i++){	   
			var curChannel;
			if(strArray[i]=='Voice'){			
	    		channelObj = new channelStateObj(staticChannel[0]);
	    	}else if(strArray[i]=='Email'){	    
	    		channelObj = new channelStateObj(staticChannel[1]);
	    	}else if(strArray[i]=='Chat'){	    
	    		channelObj = new channelStateObj(staticChannel[2]);
	    	}		
	    	//channelObj = new channelStateObj(strArray[i]);
	    	channelObj.choosedState=2; //logout
			channelMaps.put(strArray[i],channelObj);
		} 
		 channelArray=channelMaps.keys();
	} 
	agentObj = new agentStateObj();//agent status
	agentObj.offLineReasonList=new Array();
	setAUXReason();
	agentObj.choosedState=4;//logout
	agentObj.offLineIndex=-1;	
}

function setAUXReason(){
	//agentObj.offLineReasonList[0]="0:meeting";
    //agentObj.offLineReasonList[1]="1:drink";
    //agentObj.offLineReasonList[2]="2:sleep";
    
    var a = new Array();
    a=(getReasonKeyArray()).split("#@@#");
    var b = new Array();
    b=(getReasonValueArray()).split("#@@#");    
    if(a.length == b.length){
      for(var i=0;i<a.length;i++){
    	agentObj.offLineReasonList[i]=a[i]+":"+b[i];
	  }
    }else{
      return;
    }	
}


function stopMMTimer(key) {
	var timeObj = timerIDs.get(key);
	if(timeObj!=null && timeObj.timerRunning) {
		timeObj.timerRunning = false;
		clearTimeout(timeObj.timeoutObj);
		if(key == 'disStatTimer' || key == 'LineOne' || key == 'LineTwo' || key == 'LineThr'){
			timeObj.second = 0;
			timeObj.minute = 0;
			timeObj.hour = 0;
			timerIDs.put(key,timeObj);
		}
    }
    timeObj = null;
}

/**
 * Show talking timer on page.
 */
function showMMTime(key) {
	var timerObj = timerIDs.get(key);
	if(timerObj == null || timerObj == undefined){
		timerObj = new TimerObj(key);
	}
	timerObj.second++;
    
    if (timerObj.second == 60) {
        timerObj.second = 0;
        timerObj.minute += 1;
    }
    if (timerObj.minute == 60) {
        timerObj.minute = 0;
        timerObj.hour += 1;
    }
	
	timerObj.timeValue = ((timerObj.minute < 10) ? "0" : "") + timerObj.minute;
	timerObj.timeValue += ((timerObj.second < 10) ? ":0" : ":") + timerObj.second;
	if(timerObj.hour>0)	
		timerObj.timeValue = ((timerObj.hour < 10) ? "0" : "") + timerObj.hour + ":" + timerObj.timeValue;

    if (document.all) {
        document.getElementById("timer"+key+"").innerText = timerObj.timeValue;
	}
	
	timerObj.timeoutObj = setTimeout("showMMTime('"+key+"')", 1000);
	timerObj.timerRunning = true;
	timerIDs.put(key,timerObj);
}

/**
 * Start talking timer.
 */
function startMMTimer(key) {
	stopMMTimer(key); //Make sure the clock is stopped
	showMMTime(key);
}

function checkMMTimer(mediaType,key) {
	var timeObj = timerIDs.get(key);
	if(timeObj==undefined || timeObj.timerRunning==false) {
		if(mediaType==1){
			addEmailTimer(key);
		}
		else if(mediaType==2){
 			addChatTimer(key);
		}
		startMMTimer(key);
    }
}

function TimerObj(key) {
	this.skey=key;
    this.timerRunning=false;
    this.second=0;
	this.minute=0;
	this.hour=0;
	this.timeoutObj=null;
}

/*
 * Applet is ready
*/
function appletReady(){
	//changeAgentToNotReady('0');
	onAppletReady();	
	return 0;
}

/*
 * Applet is Init Failed
*/
function appletInitFailed(reason){		
	onAppletInitFailed(reason);
}

/*
 * handle ivr validate
*/
function handleIvrValidate(status,lineId,callType,interactionID,ani,dnis,attachedData, extensions){
	LineStatus[lineId].setLineState(lineId,STATUS_PARTY_DELETED,callType,interactionID,ani,dnis,attachedData,extensions);
	onPartyDeletedEvent(lineId,callType,interactionID,attachedData);
}

/*
 * handle voice event
 * add new param - extensions by hippo.zhang 2007.05.30
 */
function handleVoiceEvent(status,lineId,callType,interactionID,ani,dnis,attachedData, extensions){
	//add for PB application
	//document.getElementById("statusDiv").innerText = status;
	//document.getElementById("calltypeDiv").innerText = callType;
	//document.getElementById("lineidDiv").innerText = lineId;
	//document.getElementById("interactionDiv").innerText = interactionID;
	//document.title=status+lineId+callType;
	//end for PB application
	//if(callType == CALLTYPE_OUTBOUND){
    //	outboundPrefix = getOutboundPrefix();
    //	if(dnis!=null && dnis!=""){
	//   	if(status == STATUS_DIALING){    	
	//    		dnis = dnis.substring(outboundPrefix.length);
	//    	}else{
	//    		dnis = dnis.substring(outboundPrefix.length-1);
	//    	}
    //	}
    //}
    
	var lineStatus =LineStatus[lineId].getLineState();
	if(typeof(lineStatus)=='undefined')
		lineStatus = "";
		
	LineStatus[lineId].setLineState(lineId,status,callType,interactionID,ani,dnis,attachedData,extensions);
	//add outbound call
	if(status == STATUS_DIALING && callType == CALLTYPE_OUTBOUND){
		addCallList("out",dnis,callType);
	}
	//add inbound call
	if(status == STATUS_RINGING && callType == CALLTYPE_INBOUND){
		addCallList("in",ani,callType);
	}
	if(typeof(extensions)=='undefined')
		extensions = "";
    var indexOfMonitor = extensions.indexOf(MONITORSTATUS);//check if heldevent is by monitor
    if(indexOfMonitor<0){
        if(status==STATUS_HELD){
            handleHeldStart(status,lineId,callType,interactionID,ani,dnis,attachedData,extensions);
        }else if(status==STATUS_IDLE && lineStatus=="Hold"){
            if(extensions!="")//filter released before transfer completed
            	handleHeldStop(status,lineId,callType,interactionID,ani,dnis,attachedData,extensions);
     }
    }else{
        if(status==2 && extensions.indexOf("monitorStatus=21")>=0){
        	//changeChannelState('Voice',4);
        	//return;
        }
    }
    if(ani == null || ani == "Unknown")ani="";
    
    //alert("after:"+dnis);
    try{
    	onVoiceEvent(status,lineId,callType,interactionID,ani,dnis,attachedData, extensions);
    }catch(e){}
    
    if(status == STATUS_DIALING || status == STATUS_RINGING){
    	if(getChannleCurrentState('Voice')=='0' || getChannleCurrentState('Voice')=='1') //login status
	    	changeChannelState('Voice',3);
	}
	if(status == STATUS_IDLE){
		if(getChannleCurrentState('Voice')=='0' || getChannleCurrentState('Voice')=='1') //login status
			changeChannelState('Voice',4);
	}
}

/*
 *	handle agent status event
 *	there is one more parameter(mediaType) when compared with that in 75
 *	mediaType definition:
 *	0 voice
 *	1 email
 *	2 chat
 */

function handleAgentEvent(status,reason,mediaType,interactionID,workmode){	
	isACWStatus = false;	
	agentState.setAgentState(status,reason,mediaType,workmode);
 	//chose current ACW reasonCode to label
	if(status=='201'){
		agentObj.offLineIndex=-1;
		agentObj.ifManualAUX=false;
		for(var i=0;i<agentObj.offLineReasonList.length;i++){
			var a1=agentObj.offLineReasonList[i].split(":")[0];
			//alert(a1+' '+reason);
			if(agentObj.offLineReasonList[i].split(":")[0] == reason ){		 	
		 		agentObj.offLineIndex=i;
		 		agentObj.ifManualAUX=true;
		 		break;
		 	}
		}
	}
	 
	if(mediaType=='0' || mediaType=='undefined' || mediaType==null){		
		if(workmode==3){			
			isACWStatus = true;
		}
		changeChannelState('Voice',status-200);
		if(workmode==3){			
			onChangeAgentChannelStateInCache('voiceAcw');
		}
	}
	if(mediaType=='1'){		
		if(status==203){
			document.getElementById("mailinImage").className="mailinImage_enabled";document.getElementById("mailinImage").disabled=false;
			document.getElementById("workbinEmailImage").className="workbinEmailImage_enabled";document.getElementById("workbinEmailImage").disabled=false;
			document.getElementById("newEmailImage").className="newEmailImage_enabled";document.getElementById("newEmailImage").disabled=false;	
		}else{
			 if (status==202){
				document.getElementById("mailinImage").className="mailinImage_disabled";document.getElementById("mailinImage").disabled=true;
				document.getElementById("workbinEmailImage").className="workbinEmailImage_disabled";document.getElementById("workbinEmailImage").disabled=false;
				document.getElementById("newEmailImage").className="newEmailImage_disabled";document.getElementById("newEmailImage").disabled=false;	
			}
			changeChannelState('Email',status-200);	
		}		
	}else if(mediaType=='2'){	
		if(status==203){
			document.getElementById("chatImage").className="chatImage_enabled";document.getElementById("chatImage").disabled=false;
		}else{
		 	if (status==202){
				document.getElementById("chatImage").className="chatImage_disabled";document.getElementById("chatImage").disabled=true;	
		 	}
			changeChannelState('Chat',status-200);
		}	
	}
	onAgentEvent(status,reason,mediaType,interactionID);
}

/**
  * handle agent status change event
  * @param newStatus new stataus
  * @reason the reason for this change
  */
function agentStatusChanged(newStatus,reason){}

/**
 *	Define call back functions invoked by Applet
 */
function handleCallmebackEvent(status, callType, interactionID, fromAddress,attachedData, extensions){
//	if(status==55)
//		changeAgentToNotReady('0');
//	onCallmebackEvent(status, callType, interactionID, fromAddress,attachedData, extensions);
}

/*
 * handle email event
*/
function handleEmailEvent(status, callType, interactionID, fromAddress, attachedData, extensions){
	//alert("status="+status+" callType="+callType+" interactionID="+interactionID+" fromAddress="+fromAddress +" attachedData="+attachedData );	
	var webContext=top.softPhone.getWebContext();
	if(status==VOICE_STATUS_RINGING){		
		document.getElementById("mailinImage").className="mailinImage_flash";document.getElementById("mailinImage").disabled=false; 
		emailQueue.unshift(interactionID);
        changeChannelState('Email',3);
        email_ringings++;
	}else if(status==VOICE_STATUS_TALKING){	
		email_ringings--;	
		if(email_ringings<=0)
			document.getElementById("mailinImage").className="mailinImage_enabled";document.getElementById("mailinImage").disabled=false; 
	}else if(status==VOICE_STATUS_IDLE){
	    changeChannelState('Email',4);		
	    if(interaction2Window_Maps_email.get(interactionID)!=null){
	   	   	interaction2Window_Maps_email.get(interactionID).close();
	    	interaction2Window_Maps_email.remove(interactionID);
		}
	}else if(status==10){ 
	     //transfer failed
	     interaction2Window_Maps_email.get(interactionID).transferEnd();		
	}
	onEmailEvent(status, callType, interactionID, fromAddress, attachedData, extensions);
}

/*
 *	handle chat event
 */
function handleChatEvent(status, callType, interactionID,customerName, attachedData, extensions){
	var webContext=top.softPhone.getWebContext();
	if(status==VOICE_STATUS_RINGING){		
		document.getElementById("chatImage").className="chatImage_flash";document.getElementById("chatImage").disabled=false;
		chatQueue.push(interactionID);
		changeChannelState('Chat',3);
	}else if(status==VOICE_STATUS_TALKING){
		chat_ringings--;
		if(chat_ringings<=0)
			document.getElementById("chatImage").className="chatImage_enabled";document.getElementById("chatImage").disabled=false;
	}else if(status==VOICE_STATUS_IDLE){
	     changeChannelState('Chat',4);		
	     if(interaction2Window_Maps.get(interactionID)!=null){
	     	interaction2Window_Maps.get(interactionID).close();	
	    	interaction2Window_Maps.remove(interactionID);	     
		 }		     	
	}else if(status==10){ 
	     //transfer failed	
	     interaction2Window_Maps.get(interactionID).sendFrame.transferEnd();	
	}else if(status==9){//client or client left interaction    callType=0:customer  1:agent
		//alert("9 chat "+ interactionID );			 
	}
	else if(status==8){//agent joined conference    callType=0:customer  1:agent
		//alert("8 chat "+ customerName  +" from:"+ callType);			 
	}
	onChatEvent(status, callType, interactionID,customerName, attachedData, extensions);
}

/*
 *	handle AgentMonitor event
 *	jarod.he
 */
function handleAgentMonitor(status,lineId,callType,interactionID,ani,dnis,attachedData,extensions,monitorStatus,successagentid){
	LineStatus[lineId].setLineState(lineId,status,callType,interactionID,ani,dnis,attachedData,extensions);
	handleVoiceEvent(status,lineId,callType,interactionID,ani,dnis,attachedData,extensions);
	onAgentMonitor(status,callType,monitorStatus,successagentid);
}

/*
 *	replacement of scriptInvokeCustomerInformation in EZActor 75
 */
function handleScreenPopup(mediaType,interactionID,callType,status, ani,dnis, attachedData,extensions){
	if(callType!=CALLTYPE_INTERNAL){
		if(ani == null || ani == "Unknown")ani="";
		//if(callType == CALLTYPE_OUTBOUND){
	    //	outboundPrefix = getOutboundPrefix();
	    //	if(dnis!=null && dnis!=""){
		//    	if(status == STATUS_DIALING){    	
		//    		dnis = dnis.substring(outboundPrefix.length);
		//    	}else{
		//    		dnis = dnis.substring(outboundPrefix.length-1);
		//    	}
	    //	}	    	
	    //}
		onScreenPopup(mediaType,interactionID,callType,status, ani,dnis, attachedData,extensions);
	}
}
/**
 *interactionID
 *	20
 *message 
 *	chat
 *messageFrom 
 *	0-customer
 *  1-agent
 */
function handleChatMessage(interactionID,message,messageFrom){
	//onChatMessage(interactionID,message,messageFrom);
	if(interaction2Window_Maps.get(interactionID)==null)
		return;
	try{	
		if(interaction2Window_Maps.get(interactionID).document.getElementById("divMsg")==null){		
			return;
		}
	}catch(exception ){
		return;
	}
		
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
		strMessage = '<span style="color:red">'+message+'</span>';
	}
	
	interaction2Window_Maps.get(interactionID).document.getElementById("divMsg").innerHTML +=strMessage+'<br>';
	interaction2Window_Maps.get(interactionID).document.getElementById("divMsg").doScroll("pageDown");

}

function handleCallOverTime(interactionID){
	onCallOverTime(0,interactionID);
	
}

function handleCallOverTime(mediaType,interactionID){
	//var webContext=top.softPhone.getWebContext();
	if(mediaType==1){
		email_ringings--;
		if(email_ringings<=0)
			document.getElementById("mailinImage").className="mailinImage_enabled";document.getElementById("mailinImage").disabled=false; 
		changeChannelState('Email',4);
	}
	else if(mediaType==2){
		chat_ringings--;
		if(chat_ringings<=0)
			document.getElementById("chatImage").className="chatImage_enabled";document.getElementById("chatImage").disabled=false; 
		changeChannelState('Chat',4);
	}
	onCallOverTime(mediaType,interactionID);
}

function chatErrorHandle(interactionID){	  
		chat_ringings--;
		if(chat_ringings<=0)
			document.getElementById("chatImage").className="chatImage_enabled";document.getElementById("chatImage").disabled=false; 
		changeChannelState('Chat',4);	 
}

function handleOutboundCallOverTime(status,lineId,callType,interactionID,ani,dnis,attachedData){
	LineStatus[lineId].setLineState(lineId,status,callType,interactionID,ani,dnis,attachedData,"");
	onOutboundCallOverTime(status,lineId,callType,interactionID,ani,dnis,attachedData);
	changeChannelState('Voice',4);
}

/*
 * handle attached data changed
 * add by Hippo.Zhang 2007-05-21
 */
function handleAttachedDataChangedEvent(mediaType,lineId,callType,interactionID,attachedData){}

/*
 * handle inbound Abandoned
 */
function handleAbandonedEvent(status,lineId,callType,interactionID,ani,dnis,attachedData){
	LineStatus[lineId].setLineState(lineId,status,callType,interactionID,ani,dnis,attachedData,"");
	onAbandonedEvent(status,lineId,callType,interactionID,ani,dnis,attachedData);
	changeChannelState('Voice',4);
}

/*
 * handle EventRetrieved event
*/
function handleHoldEvent(status,lineId,callType,interactionID,ani,dnis,attachedData,extensions){
	LineStatus[lineId].setLineState(lineId,status,callType,interactionID,ani,dnis,attachedData,extensions + DELIMETE + "Hold");
	if(typeof(extensions)=='undefined')
		extensions = "";
	var indexOfMonitor = extensions.indexOf(MONITORSTATUS);//check if heldevent is by monitor
    if(indexOfMonitor<0 && (status==STATUS_TRANSFER_END ||status==STATUS_CONFERENCE_END ||status==STATUS_IDLE)){
        handleHeldStop(status,lineId,callType,interactionID,ani,dnis,attachedData,extensions);
    }
}

/*
 *	handle hold start
 */
function handleHeldStart(status,lineId,callType,interactionID,ani,dnis,attachedData,extensions){
//	alert("status="+status+" lineId="+lineId+" callType="+callType+" interactionID="+interactionID);
	onHeldStart(status,lineId,callType,interactionID,ani,dnis,attachedData,extensions);
}

/*
 *	handle hold end
 */
function handleHeldStop(status,lineId,callType,interactionID,ani,dnis,attachedData,extensions){
    var lineStatus = top.softPhone.getLineStatus(lineId);
//	confirm hold status
    if (lineStatus==STATUS_HELD) {
//		alert("status=" + status + " lineId=" + lineId + " callType=" + callType + " interactionID=" + interactionID);
    }
    onHeldStop(status,lineId,callType,interactionID,ani,dnis,attachedData,extensions);
}

/*
 *	handle tserver disconnected
 */
function handleServerDisconnected(){
	try{
		resetLineState();
		resetTimer();	
		changeChannelState('Voice',2);//set idle status
	}
	catch(e){}
	onServerDisconnected();
}

/** get the specialize channel current status 
 * channelKey definition: Voice,Email,Chat 
 *Return value: 0:ready; 1:notReady; 2:Logout  
*/
function getChannleCurrentState(channelKey){
   channelObj = channelMaps.get(channelKey);
   if(channelObj == null || channelObj == undefined){
	  alert("no this channel:"+channelKey);
	  return;	  
	}
	if(channelObj.choosedState==0){
		return 0;
	}else if(channelObj.choosedState==1){
		return 1;
	}else if(channelObj.choosedState==2){
		return 2;
	}	
}

/*
 * change channel status 
 * channelKey:??????Voice,Email,Chat(Applet?????????)
 * channel status :
 * 0 ready
 * 1 notReady
 * 2 logout
 * 3 ring or new create a email or make a call
 * 4 Idle-finish xiaojie or overTime
 * 
*/
function changeChannelState(channelKey,status){	
    //alert("changeChannelState("+channelKey+" "+status+" "+changeType+")"); 
	var channelObj = channelMaps.get(channelKey);
	
	if(channelObj == null || channelObj == undefined){
	  alert("no this channel:"+channelKey);
	  return;	  
	}
	
	if(status==0){ 
		channelObj.choosedState=0;
		channelMaps.put(channelKey,channelObj);
	}else if(status==1){
		channelObj.choosedState=1;
		channelMaps.put(channelKey,channelObj);
	}else if(status==2){
		channelObj.choosedState=2;
		channelObj.workingNumber=0;
		channelMaps.put(channelKey,channelObj);
	}else if(status==3){
		channelObj.workingNumber = channelObj.workingNumber+1;
		channelMaps.put(channelKey,channelObj);
	}else if(status==4 ){		
		if(channelObj.workingNumber >0){				
				channelObj.workingNumber = channelObj.workingNumber-1;
				channelMaps.put(channelKey,channelObj);
		}		
	}
	
	//to decide agent status
	var a = new Array(0,0,0,0);//:busy,ready,notready,logout	
    for(var i=0;i<channelArray.length;i++){       	
    	channelObj = channelMaps.get(channelArray[i]);
		if(channelObj.workingNumber>0){//???????????????????????????
			if(channelArray[i]==channelKey && channelKey != 'Voice' && channelKey == 'Email'){
				onChangeAgentChannelStateInCache('emailBusy');
			}
			if(channelArray[i]==channelKey && channelKey != 'Voice' && channelKey == 'Chat'){
				onChangeAgentChannelStateInCache('chatBusy');
			}
    		a[0]=a[0]+1;
		}else if(channelObj.choosedState==0){//???????????????ready,??????busy
			if(channelArray[i]==channelKey && channelKey == 'Email'){
				onChangeAgentChannelStateInCache('emailReady');
			}
			if(channelArray[i]==channelKey && channelKey == 'Chat'){
				onChangeAgentChannelStateInCache('chatReady');
			}
			if(channelArray[i]==channelKey && channelKey == 'Voice'){
				onChangeAgentChannelStateInCache('voiceReady');
			}
            a[1]=a[1]+1;
		}else if(channelObj.choosedState==1){//???????????????notready,??????busy
			if(channelArray[i]==channelKey && channelKey == 'Email'){
				onChangeAgentChannelStateInCache('emailNotReady');
			}
			if(channelArray[i]==channelKey && channelKey == 'Chat'){
				onChangeAgentChannelStateInCache('chatNotReady');
			}
			if(channelArray[i]==channelKey && channelKey == 'Voice'){
				var status = getMainContactStatus();
				var state = agentState.getAgentState();
				if(status!=STATUS_TALKING && state!='ACW')
					onChangeAgentChannelStateInCache('voiceNotReady');
			}
            a[2]=a[2]+1;
		}else if(channelObj.choosedState==2){//???????????????logout
			if(channelArray[i]==channelKey && channelKey == 'Email'){
				onChangeAgentChannelStateInCache('emailLoginOut');
			}
			if(channelArray[i]==channelKey && channelKey == 'Chat'){
				onChangeAgentChannelStateInCache('chatLoginOut');
			}
			if(channelArray[i]==channelKey && channelKey == 'Voice'){
				onChangeAgentChannelStateInCache('voiceLoginOut');
			}
            a[3]=a[3]+1;
		}
	} 
	
	if(a[0]>0){
    	changeAgentState(busyState,-1);
	}else if(a[1]==channelArray.length){
        changeAgentState(readyAllState,-1);
	}else if(a[3]==channelArray.length){			
		changeAgentState(offLine,-1);			 
	}else if(a[2]==channelArray.length){
		changeAgentState(offSeat,-1);
	}else if(a[2]>0 && a[3]>0 && a[1]==0){
		changeAgentState(offSeat,-1);
	}else if(a[1]>0){
		changeAgentState(readyPartState,-1);
	}
}    
 
function getChannelCount(){
 	return	channelMaps.size();
}

/**
*readyAllState=0;
*readyPartState=1;
*busyState=2;
*offSeat=3;//not ready; 
*offLine=4;//=logout
*/
function changeAgentState(status,offLineIndex){
	//alert("ChangeAgentState:status="+status+" offLineIndex="+offLineIndex);
	
	var webContext=top.softPhone.getWebContext();
	if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}

	if(status ==readyAllState){			
		document.getElementById("disStat").innerText=staticState[0];
		document.getElementById("disStat").className="greenClass";
		document.getElementById("agentStateImage").src=webContext+"/images/agent_image/agentState_allReady.gif";
		if(agentObj.choosedState != status){
            agentObj.choosedState=status;
			startMMTimer('disStatTimer');
		}
		onChangeAgentStateInCache('agentAllReady');
	}else if(status ==readyPartState){
		if(agentObj.choosedState != status){
			agentObj.choosedState=status;		
		    document.getElementById("disStat").innerText=staticState[1];
		    document.getElementById("disStat").className="redClass";
		    document.getElementById("agentStateImage").src=webContext+"/images/agent_image/agentState_partReady.gif";
			startMMTimer('disStatTimer');
		}
		onChangeAgentStateInCache('agentReady');
	}else if(status ==busyState){		
		var busyChannelList="";
		var index=0;
		for(var i=0;i<channelArray.length;i++){
			channelObj = channelMaps.get(channelArray[i]);
			if(channelObj.workingNumber>0){
				if(index == 0){
					busyChannelList +=channelArray[i];
					index +=1;
				}else{
					busyChannelList +=","+channelArray[i];
					index +=1;
				}
    			
			}
		}
		document.getElementById("disStat").innerText=staticState[2]+"("+busyChannelList+")";
		document.getElementById("agentStateImage").src=webContext+"/images/agent_image/agentState_busy.gif";
		if(agentObj.choosedState != status){
            agentObj.choosedState=status;
			startMMTimer('disStatTimer');
		}
		onChangeAgentStateInCache('AgentBusy');
	}else if(status == offSeat){
		//alert("changeAgentState:"+agentObj.offLineReasonList[agentObj.offLineIndex]);
		if( agentObj.ifManualAUX == true ){		
			if(agentObj.offLineIndex>=0){			
				document.getElementById("disStat").innerText=agentObj.offLineReasonList[agentObj.offLineIndex].split(":")[1];				
				var id=agentObj.offLineReasonList[agentObj.offLineIndex].split(":")[0];		
				var imgsrc=document.getElementById("auxImg"+id);		
				if(imgsrc!=null)
					document.getElementById("agentStateImage").src=imgsrc.src;
				else
					document.getElementById("agentStateImage").src=webContext+"/images/agent_image/agentState_rest.gif";			
				onChangeAgentOffLineInCache(agentObj.offLineReasonList[agentObj.offLineIndex].split(":")[0]);			
			}
		}else{			
			agentObj.offLineIndex=-1;
			if(isACWStatus)
				document.getElementById("disStat").innerText=staticState[3]+"(ACW)";
			else
				document.getElementById("disStat").innerText=staticState[3];
			document.getElementById("agentStateImage").src=webContext+"/images/agent_image/agentNotReady_enabled.gif";
			onChangeAgentOffLineInCache('doNothing');			
		}	
		if(agentObj.choosedState != status){
            agentObj.choosedState=status;
			startMMTimer('disStatTimer');
		}
		
	}else if(status == offLine){	     
		document.getElementById("disStat").innerText=staticState[4];
		document.getElementById("agentStateImage").src=webContext+"/images/agent_image/agentNotReady_disable.gif";
		if(agentObj.choosedState != status){
            agentObj.choosedState=status;
			startMMTimer('disStatTimer');
		}
		onChangeAgentStateInCache('AgentOffLine');
	}
}

/*
 * handle party add event
 * add bu hippo.zhang 2007.05.31
 */
function handlePartyAddEvent(status,lineId,callType,interactionID,ani,dnis,attachedData, extensions){
	LineStatus[lineId].setLineState(lineId,status,callType,interactionID,ani,dnis,attachedData,extensions+DELIMETE+"partyAdded");
	onPartyAddEvent(status,lineId,callType, interactionID, ani, dnis, extensions);
}

function showHtmlDialog(strMessage,dialogType){
	var c = new Array;
	c[0]=strMessage;
	c[1]=dialogType;
	if(dialogType==0){
		vReturnValue=window.showModalDialog("softphone/showMessage.jsp",c,"dialogHeight:185px;dialogWidth:445px;status:0;help:0;edge:sunken") ;
		return vReturnValue;
	}else{
		window.showModelessDialog("softphone/showMessage.jsp",c,"dialogHeight:185px;dialogWidth:445px;dialogLeft:0px;dialogTop:"+screen.width+"px;status:0;help:0;edge:sunken") ;
	}
}

function handlePartyChangeEvent(status,lineId,callType,interactionID,ani,dnis,attachedData, extensions){
	LineStatus[lineId].setLineState(lineId,status,callType,interactionID,ani,dnis,attachedData,extensions);
}

function scriptAutoCampaignReschedule(){
	onAutoCampaignReschedule();
}

function scriptUpdateAutoCampaignRecord(){
	onUpdateAutoCampaignRecord();
}

function scriptAutoCampaignDoNotCall(){
	onAutoCampaignDoNotCall();
}

function scriptCompleteAutoCampaignRecord(){
	onCompleteAutoCampaignRecord();
}

function scriptAutoCampaignError(msg){
	onAutoCampaignError(msg);
}

function scriptAutoCampaignScheduledCall(key,value){
	onAutoCampaignScheduledCall(key,value);
}