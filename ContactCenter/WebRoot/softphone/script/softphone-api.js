// constants definition
var EZ_AGENT_VIEW_CURRENT_LINE_ID="EZAgentViewCurrentLineId";
var DN_ID="dnId";
var IVR_MODE="ivrOperationType";
var IVR_CONTEXT="ivrOperationContext";
var IVR_EXTENSION="ivrOperationExtension";
var SWITCH_LOCATION="SwitchLocation";
var IS_OUTOUBND = "isOutbound";
var LISTEN_DN="listen_dn";
var REASON = "ReasonCode";
var WORKMODE="workmode";
var NOTREADYWORKMODE="notReadyWorkMode";
var READYWORKMODE="readyWorkMode";
var SETNOTREADYWHILEIDLE = "setNotReadyWhileIdle";

var VOICE_STATUS_IDLE=2;
var CLIENT_LEFT=9;
var TRANSFER_FAILED=10;
var VOICE_STATUS_DIALING=54;
var VOICE_STATUS_TALKING=55;
var VOICE_STATUS_RINGING=56;
var VOICE_STATUS_HELD=57;

var AGENT_STATE_READY=200;
var AGENT_STATE_SEMI_READY=205;
var AGENT_STATE_NOTREADY=201;
var AGENT_STATE_NOTINUSE=202;
var AGENT_STATE_LOGIN=203 //email chat login success 

/**
  * change setNotReadyWhileIdle
  * @param flag:   true or false  type:String
  */
function setNotReadyWhileIdle(flag){
	setProperty(SETNOTREADYWHILEIDLE,flag);
}
/**
  * set notReadyWorkMode
  * @param workmode:   notReadyWorkMode's value
  */
function setNotReadyWorkMode(workmode){
	setProperty(NOTREADYWORKMODE,workmode);
}
/**
  * set readyWorkMode
  * @param workmode:   readyWorkMode's value
  */
function setReadyWorkMode(workmode){
	setProperty(READYWORKMODE,workmode);
}

/**
  * set property in memory
  * @param key:   Properties' key
  * @param value: Properties' value
  */
function setProperty(key,value){
    if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
    top.softPhone.setProperty(key,value);
}
/**
  * make the listen_dn 's listener disconnect from the call with extension data
  *
  * @param listen_dn: listener's dn  Type:String
  * @param reason: reason of disconnect  Type:String
  * @param extensionKeys: keys array of extension data  Type:Array
  * @param extensionValues: values array of extension data  Type:Array
 */
function listenDisconnect(listen_dn,reason,extensionKeys,extensionValues){
    if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}

	var keys = new Array(LISTEN_DN,REASON);
	var values = new Array(listen_dn,reason);
    top.softPhone.executeCommand("disconnectListenAction",formatArrayToString(keys), formatArrayToString(values),formatArrayToString(extensionKeys), formatArrayToString(extensionValues));
}
/**
  * make the listen_dn 's listener Reconnect to the call with extension data
  *
  * @param listen_dn: listener's dn
  * @param reason: reason of Reconnect
  * @param extensionKeys: keys array of extension data
  * @param extensionValues: values array of extension data
 */
function listenReconnect(listen_dn,reason,extensionKeys,extensionValues){
    if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	var keys = new Array(LISTEN_DN,REASON);
	var values = new Array(listen_dn,reason);
    top.softPhone.executeCommand("reconnectListenAction",formatArrayToString(keys), formatArrayToString(values),formatArrayToString(extensionKeys), formatArrayToString(extensionValues));
}
/**
  * make a new call with data attached 
  *
  * @param phoneNumber phone number to be dialed 
  * @param lineId id of the line to be used(0-2) 
  * @param attachedKeys keys array of data attached 
  * @param attachedValues values array of data attached 
 */
function makeNewCall(phoneNumber,lineId,attachedKeys,attachedValues){
	if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	if(!checkLineId(lineId)){
		alert("Invalid line id!");
		return ;
	}
	
	var keys = new Array(DN_ID , EZ_AGENT_VIEW_CURRENT_LINE_ID);   
	var values = new Array(phoneNumber , lineId );
    var ret = top.softPhone.executeCommand( "makeCallAction" , formatArrayToString(keys), formatArrayToString(values), formatArrayToString(attachedKeys), formatArrayToString(attachedValues) ) ;
    if(ret)return 1;
    else return -1;
}

/**
  * make a new call with data attached for outbound or internal
  *
  * @param phoneNumber phone number to be dialed 
  * @param lineId id of the line to be used(0-2) 
  * @param attachedKeys keys array of data attached 
  * @param attachedValues values array of data attached 
  * @param isOutbound (1:outbound 2: internal)
 */
function makeNewCallForOutboundOrInternal(phoneNumber,lineId,attachedKeys,attachedValues,isOubound){
	if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	if(!checkLineId(lineId)){
		alert("Invalid line id!");
		return ;
	}
	
	var keys = new Array(DN_ID , EZ_AGENT_VIEW_CURRENT_LINE_ID,IS_OUTOUBND);   
	var values = new Array(phoneNumber , lineId, isOubound);
    var ret = top.softPhone.executeCommandEx( "makeCallAction" , formatArrayToString(keys), formatArrayToString(values), formatArrayToString(attachedKeys), formatArrayToString(attachedValues) ) ;
    if(ret)return 1;
    else return -1;
}


/**
  * release a call
  * @param lineId id of the line to be released(0-2)
  */
function releaseCall(lineId){
	if(!checkSoftphoneApplet()){
			alert("Softphone applet not found!");
			return ;
	}
	if(!checkLineId(lineId)){
		alert("Invalid line id!");
		return ;
	}
	var keys = new Array(EZ_AGENT_VIEW_CURRENT_LINE_ID);   
	var values = new Array(lineId );
    top.softPhone.executeCommand( "releaseCallAction" , formatArrayToString(keys), formatArrayToString(values) ) ;
	
}

/**
  * hold a call
  * @param lineId id of the line to be held(0-2)
  */
function holdCall(lineId){
	if(!checkSoftphoneApplet()){
			alert("Softphone applet not found!");
			return ;
	}
	if(!checkLineId(lineId)){
		alert("Invalid line id!");
		return ;
	}
	var keys = new Array(EZ_AGENT_VIEW_CURRENT_LINE_ID);   
	var values = new Array(lineId );
    top.softPhone.executeCommand( "holdCallAction" , formatArrayToString(keys), formatArrayToString(values) ) ;
}

/**
  * retrieve a held call
  * @param lineId id of the line to be retrieved(0-2)
  */
function retrieveCall(lineId){
	if(!checkSoftphoneApplet()){
			alert("Softphone applet not found!");
			return ;
	}
	if(!checkLineId(lineId)){
		alert("Invalid line id!");
		return ;
	}
	
	var status=getLineStatus(lineId);
	if(status!=VOICE_STATUS_HELD){
		alert("Line "+(lineId+1)+" can't be retrieved.");
		return ;
	}
	var keys = new Array(EZ_AGENT_VIEW_CURRENT_LINE_ID);   
	var values = new Array(lineId );
    top.softPhone.executeCommand( "retrieveCallAction" , formatArrayToString(keys), formatArrayToString(values) ) ;
}

/**
  * answer an incoming call
  * @param lineId id of the line to be answered(0-2)
  */
function answerCall(lineId){
	if(!checkSoftphoneApplet()){
			alert("Softphone applet not found!");
			return ;
	}
	if(!checkLineId(lineId)){
		alert("Invalid line id!");
		return ;
	}
	var keys = new Array(EZ_AGENT_VIEW_CURRENT_LINE_ID);   
	var values = new Array(lineId );
    top.softPhone.executeCommand( "answerCallAction" , formatArrayToString(keys), formatArrayToString(values) ) ;
}
/**
  * mute transfer
  * @param lineId id of the line to be transfered(0-2)
  * @param phoneNumber target phone number
  */
function muteTransfer(phoneNumber,lineId){
	if(!checkSoftphoneApplet()){
			alert("Softphone applet not found!");
			return ;
	}
	if(!checkLineId(lineId)){
		alert("Invalid line id!");
		return ;
	}
	var keys = new Array(DN_ID,EZ_AGENT_VIEW_CURRENT_LINE_ID);   
	var values = new Array(phoneNumber,lineId );
    top.softPhone.executeCommand( "muteTransferAction" , formatArrayToString(keys), formatArrayToString(values) ) ;
}

/**
  * initiate a transfer
  * @param lineId id of the line to be transfered(0-2)
  * @param phoneNumber target phone number
  */
function initiateTransfer(phoneNumber,lineId){
	if(!checkSoftphoneApplet()){
			alert("Softphone applet not found!");
			return ;
	}
	if(!checkLineId(lineId)){
		alert("Invalid line id!");
		return ;
	}
	var keys = new Array(DN_ID,EZ_AGENT_VIEW_CURRENT_LINE_ID);   
	var values = new Array(phoneNumber,lineId );
    top.softPhone.executeCommand( "initiateTransferAction" , formatArrayToString(keys), formatArrayToString(values) ) ;
}

/**
  * initiate a transfer
  * @param lineId id of the line to be transfered(0-2)
  * @param phoneNumber target phone number
  * @Name of the remote location in the form of "<SwitchName>" or "<T-ServerApplicationName>@<SwitchName>."
  */
function initiateTransfer(phoneNumber,lineId,location){
	if(!checkSoftphoneApplet()){
			alert("Softphone applet not found!");
			return ;
	}
	if(!checkLineId(lineId)){
		alert("Invalid line id!");
		return ;
	}
	var keys = new Array(DN_ID,EZ_AGENT_VIEW_CURRENT_LINE_ID,SWITCH_LOCATION);   
	var values = new Array(phoneNumber,lineId ,location);
    top.softPhone.executeCommand( "initiateTransferAction" , formatArrayToString(keys), formatArrayToString(values) ) ;
}

/**
  * complete a transfer
  * @param lineId the line held
  */
function completeTransfer(lineId){
	if(!checkSoftphoneApplet()){
			alert("Softphone applet not found!");
			return ;
	}
	if(!checkLineId(lineId)){
		alert("Invalid line id!");
		return ;
	}	
	var keys = new Array(EZ_AGENT_VIEW_CURRENT_LINE_ID);   
	var values = new Array(lineId);
    top.softPhone.executeCommand( "completeTransferAction" , formatArrayToString(keys), formatArrayToString(values) ) ;
}

/**
  * complete a conference
  * @param lineId the line held
  */
function completeConference(lineId){
	if(!checkSoftphoneApplet()){
			alert("Softphone applet not found!");
			return ;
	}
	if(!checkLineId(lineId)){
		alert("Invalid line id!");
		return ;
	}
	var keys = new Array(EZ_AGENT_VIEW_CURRENT_LINE_ID);   
	var values = new Array(lineId);
    top.softPhone.executeCommand( "completeConferenceAction" , formatArrayToString(keys), formatArrayToString(values) ) ;
}

/**
  * initiate a conference
  * @param lineId id of the line to be conferenced(0-2)
  * @param phoneNumber target phone number
  */
function initiateConference(phoneNumber,lineId){
	if(!checkSoftphoneApplet()){
			alert("Softphone applet not found!");
			return ;
	}
	if(!checkLineId(lineId)){
		alert("Invalid line id!");
		return ;
	}
	var keys = new Array(DN_ID,EZ_AGENT_VIEW_CURRENT_LINE_ID);   
	var values = new Array(phoneNumber,lineId );
    top.softPhone.executeCommand( "initiateConferenceAction" , formatArrayToString(keys), formatArrayToString(values) ) ;
}

/**
  * initiate a conference
  * @param lineId id of the line to be conferenced(0-2)
  * @param phoneNumber target phone number
  * @Name of the remote location in the form of "<SwitchName>" or "<T-ServerApplicationName>@<SwitchName>."
  */
function initiateConference(phoneNumber,lineId,location){
	if(!checkSoftphoneApplet()){
			alert("Softphone applet not found!");
			return ;
	}
	if(!checkLineId(lineId)){
		alert("Invalid line id!");
		return ;
	}
	var keys = new Array(DN_ID,EZ_AGENT_VIEW_CURRENT_LINE_ID,SWITCH_LOCATION);   
	var values = new Array(phoneNumber,lineId,location );
    top.softPhone.executeCommand( "initiateConferenceAction" , formatArrayToString(keys), formatArrayToString(values) ) ;
}

/**
  * initiate a ivr
  * @param ivrInfo name,context,extension
  * @param lineId id of the line to ivr
  */
function initiateIVR(ivrInfo,lineId){
	if(!checkSoftphoneApplet()){
			alert("Softphone applet not found!");
			return ;
	}
	if(!checkLineId(lineId)){
		alert("Invalid line id!");
		return ;
	}
	var ivrInfos = ivrInfo.split(",");
	var keys = new Array(IVR_CONTEXT,IVR_EXTENSION,EZ_AGENT_VIEW_CURRENT_LINE_ID);   
	var values = new Array(ivrInfos[1],ivrInfos[2],lineId);
    top.softPhone.executeCommand( "initiateIVRAction" , formatArrayToString(keys), formatArrayToString(values) ) ;
}

/**
  * get the current status of the line specified
  * @param lineId id of the line to be checked
  * @return status 
  * The line status are defined as following:
  * IDLE=2;
  * DIALING=54;
  * TALKING=55;
  * RINGING=56;
  * HELD=57;
  */
function getLineStatus(lineId){
	if(!checkSoftphoneApplet()){
			alert("Softphone applet not found!");
			return 0;
	}
	if(!checkLineId(lineId)){
		alert("Invalid line id!");
		return 0;
	}
	return top.softPhone.getLineStatus(lineId);
}

/**
  * get the status description of the line specified
  * @param lineId id of the line to be checked
  */
function getLineStatusDescription(lineId){
	var status=getLineStatus(lineId);
    if(status==VOICE_STATUS_DIALING){
		return "DIALING";
	}else if(status==VOICE_STATUS_TALKING){
		return "TALKING";
	}else if(status==VOICE_STATUS_RINGING){
		return "RINGING";
	}else if(status==VOICE_STATUS_HELD){
		return "HELD";
	}else{
		return "IDLE";
	}
}

/**
  * get keys of the attached data associated with 
  * only for voice
  
function getAttachedDataValue(key) {
	  if(!checkSoftphoneApplet()){
			alert("Softphone applet not found!");
			return ;
	  }
  	 return top.softPhone.getAttachedDataValue(key);
}*/

/**
  * get the value according to the key specified in attached data
  * associated with current call
  * @param key the specifical key
  * @return the value
  * mediaType : 1 email    2 chat 
  */
function getAttachedDataValue(key,mediaType,interactionID) {	  
	  if(!checkSoftphoneApplet()){
			alert("Softphone applet not found!");
			return ;
	  }
	  if(mediaType==null || mediaType=='' || mediaType=='0' )
	  		return top.softPhone.getAttachedDataValue(key);
  	  else if( mediaType=='1' || mediaType=='2' )
  	  		return top.softPhone.getAttachedDataValue(key,mediaType,interactionID);//1 email,2 chat
}
  
var keyValues;  
/*function getAttachedDataKeys(mediaType) {
	getAttachedDataKeys(mediaType,''); 
}*/  
function getAttachedDataKeys(mediaType,interactionID) {
     //alert("getAttachedDataKeys:"+mediaType);
	 if(!checkSoftphoneApplet()){
			alert("Softphone applet not found!");
			return ;
	 }
	 var result;
	 if(mediaType==null || mediaType=='undifined' || mediaType=='0' ){
     	 result= top.softPhone.getAttachedDataKeys().split(DELIMETE);//default voice       	 	
     	 return result;
     }else{     	 
     	top.softPhone.getAttachedDataKeys(mediaType,interactionID); // 1 email,2 chat    result is in  receiveAttachedDataKeys(txt) 	
     	return keyValues;
     }     
}

/** getAttachedDataKeys(mediaType) 
* only for email,chat, txt is split by #@@#
*/
function receiveAttachedDataKeys(mediaType,txt) {
	keyValues=txt;
}

/**
  * add attached data into current call
  * @param keyArray keys array
  * @param valueArray values array
  *     NOTE: the keys must exactly match the values
  * @return true/false  succeed or not
  * mediaType : 1 email    2 chat   0,null is voice
  */
/*function addAttachedData( keyArray,valueArray,mediaType){
	addAttachedData( keyArray,valueArray,mediaType,'');
}*/
  
function addAttachedData( keyArray,valueArray,mediaType,interactionID){	//mediaType: 0 voice,1 email,2 chat
	//alert("addAttachedData:"+ key+' '+ value+' '+mediaType);
	 if(!checkSoftphoneApplet()){
			alert("Softphone applet not found!");
			return false;
	 }
     if(mediaType==null || mediaType=='undifined' || mediaType=='0')
     	 return top.softPhone.addAttachedData( formatArrayToString(keyArray) , formatArrayToString(valueArray) ); 
     else
        return top.softPhone.addAttachedData( formatArrayToString(keyArray) , formatArrayToString(valueArray), mediaType,interactionID);         
}

/**
  * remove attached data into current call
  * @param keyArray keys array
  * @param valueArray values array
  *     NOTE: the keys must exactly match the values
  * @return true/false  succeed or not
  * mediaType : 1 email    2 chat   0,null is voice
  */
/*function removeAttachedData( keyArray,valueArray,mediaType){
  	  removeAttachedData( keyArray,valueArray,mediaType,'');
}*/
function removeAttachedData( keyArray,valueArray,mediaType,interactionID){	//mediaType: 0 voice,1 email,2 chat
	//alert("removeAttachedData:"+ key+' '+ value+' '+mediaType);
	 if(!checkSoftphoneApplet()){
			alert("Softphone applet not found!");
			return false;
	 }
     if(mediaType==null || mediaType=='undifined' || mediaType=='0')
     	 return deleteUserData(keyArray); 
     else
        return top.softPhone.removeAttachedData( formatArrayToString(keyArray) , formatArrayToString(valueArray), mediaType,interactionID);         
}

/**
*/


/**
  * change agent state to ready
  */
function changeAgentToReady(){
        if(!checkSoftphoneApplet()){
                        alert("Softphone applet not found!");
                        return ;
        }
        top.softPhone.executeCommand( "setReadyAction" , "111", "111") ;        
}

/**
  * change agent state to not ready
  * @param reason not ready reason
  */
function changeAgentToNotReady(reason){
        if(!checkSoftphoneApplet()){
                alert("Softphone applet not found!");
                return ;
        }        
        
        top.softPhone.agentNotReady(reason);    
}

/**
  * change agent state to not ready,only for agent state exchange button
  * 
  */
function changeAgentToNotReadyForAgentButton(){
	if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	var selectStr = top.softPhone.showReasonWindow();
	if(selectStr!=""){		
	}
	return selectStr;
}

function doLogout(){
	if(!checkSoftphoneApplet()){
			alert("Softphone applet not found!");
			return ;
	}
	
	top.softPhone.executeCommand('agentLogoutAction' , '111','111');
    agentStatusChanged('1','0');
}

/**
  * login the dn according to its media type
  * 0: voice
  * 1: email
  * 2: chat
  */
function loginDn(type){ 
 if(!checkSoftphoneApplet()){
   alert("Softphone applet not found!");
   return ;
 }
 if(type==0)
  	top.softPhone.executeCommand( "agentLoginAction" , "111","111" ) ;

}

/**
  * logout the dn according to its media type
  * 0: voice
  * 1: email
  * 2: chat
  */
function logoutDn(type){ 
	if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
 		
	if(type==0)
		top.softPhone.executeCommand( 'agentLogoutAction', '111','111');
}

/**
  * set the dn ready according to its media type
  * 0: voice
  * 1: email
  * 2: chat
  */
function setDnReady(type){ 
	if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
 	
	if(type==0)
		top.softPhone.executeCommand( "setReadyAction" , "111", "111") ;
}

/**
  * set the dn not ready according to its media type
  * 0: voice
  * 1: email
  * 2: chat
  */
function setDnNotReady(type){ 
	if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	if(type==0)
		top.softPhone.executeCommand( "setNotReadyAction" ,"111","111") ;
}

/**
  * validate the line id
  * line id should be between 0 and 2
  * @param lineId id of the line to be validated
  */
function checkLineId(lineId){
	if(lineId==null){
		return false;
	}
	
	return lineId>=0&&lineId<=2;
}
/**
  * check to see whether softphone applet exists
  * if it doesn't exist, then softphone functionalities
  * won't work at all
  */
function checkSoftphoneApplet(){
	if(top.softPhone){
		return true;
	}
	return false;
}

/**
  *get current status of the agent
  */
function getAgentStatus(){
	if(checkSoftphoneApplet()){
		return top.softPhone.getAgentStatus();
	}
	else{
		return AGENT_STATE_NOTINUSE;
	}
}

function changeAgentStatus(){
	var status=getAgentStatus();
	if(status==AGENT_STATE_READY||status==AGENT_STATE_SEMI_READY){
		return changeAgentToNotReadyForAgentButton();	
	}else if(status==AGENT_STATE_NOTREADY){
	 	return changeAgentToReady();
	}
}

/**
  *get current status of the dn according to its type
  * type definition:
  * 0: voice
  * 1: email
  * 2: chat
  */
function getMediaStatus(type){
	if(checkSoftphoneApplet()){
		return top.softPhone.getDnStatus(type);
	}
	else{
		return AGENT_STATE_NOTINUSE;
	}
}

/*
 * get real times status of the Dns specified,
 * this dns type is string whitch is splited by "|";
 * possible status:
 *  { LoggedOut,LoggedIn,NotReadyForNextCall,WaitForNextCall,AfterCallWork
 *    CallConsult,CallDialing,CallInbound,
 *    CallInternal,CallOutbound,CallOnHold,CallRinging,CallUnknown 
 *  }
 *
*/
function getRealtimeDnStatuses(dnArray){
	if(!checkSoftphoneApplet()){
			alert("Softphone applet not found!");
			return null;
	}
	var result=top.softPhone.synExecuteCommand("getDnStatusesAction","dnArray",formatArrayToString(dnArray));	
	return formatStringToArray(result);
}

function getEmailDnStatus(){
	if(!checkSoftphoneApplet()){
			alert("Softphone applet not found!");
			return null;
	}
	return top.softPhone.emailStatus;		
}

function getChatDnStatus(){
	if(!checkSoftphoneApplet()){
			alert("Softphone applet not found!");
			return null;
	}
	return top.softPhone.chatStatus;		
}


function isEmailIdle(){
	//alert(getEmailDnStatus());
	if(getEmailDnStatus()=="MA" || getEmailDnStatus()=="MI"){
		return false;
	}else	
		return true;
}

function isChatIdle(){
	//alert(getChatDnStatus());
	if(getChatDnStatus()=="CA" || getChatDnStatus()=="CI" ){
		return false;
	}else		
		return true;
}

function isPhoneIdle(){
	var line0=getLineStatusDescription(0);//alert('line0:'+line0);
	var line1=getLineStatusDescription(1);//alert('line1:'+line1);
	var line2=getLineStatusDescription(2);//alert('line2:'+line2);
	if(!(line0=="IDLE"&&line1=="IDLE"&&line2=="IDLE"))
	{
   		//alert("line0="+line0+";line1="+line1+";line2="+line2);
	}
	return line0=="IDLE"&&line1=="IDLE"&&line2=="IDLE";
}
/**
*get Current Number of WaitingCalls in this queue
*
*/
function getCurrNumberWaitingCalls(queueNumber)
{
	if(!checkSoftphoneApplet()){
			alert("Softphone applet not found!");
			return null;
	}
	var result=top.softPhone.synExecuteCommand("getCurrNumberWaitingCallsAction","queueNumber",queueNumber);	
	return result;
}

/**
  * refuse inbound call
  * @param lineId id of the ringing line(0-2)
  */
function refuseInboundCall(lineId){
	if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	if(!checkLineId(lineId)){
		alert("Invalid line id!");
		return ;
	}
	if(getLineStatus(lineId)==VOICE_STATUS_RINGING){
		var keys = new Array(EZ_AGENT_VIEW_CURRENT_LINE_ID);   
		var values = new Array(lineId);
    		top.softPhone.executeCommand( "refuseInboundAction" , formatArrayToString(keys), formatArrayToString(values) ) ;
	}
}


function disableAgentButton(){
	if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	top.softPhone.synExecuteCommand("disableAgentButton(){","111","111");	
}


function enableAgentButton(){
	if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	top.softPhone.synExecuteCommand("enableAgentButton(){","111","111");	
}

/**
  * showReasonWindow
  * @return reason code
  */
function showReasonWindow(){
   if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	return top.softPhone.showReasonWindow();
}

/** when agent is not ready, you can invoke this function. AUX window will be poped up, then execute agentNotReadyAction
  * showReasonWindow_  
  * return reason code
  */
function showReasonWindow_(){
   if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	return top.softPhone.showReasonWindow_();
}
/**
  *disable some cit buttons when monitor
  *
  */
function disableButtonsWhenMonitor(){
    if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	top.softPhone.disableButtonsWhenMonitor();
}

/**
  *get monitor agent id
  *@return 
  */
function getMonitorAgentId(){
    if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	return top.softPhone.getMonitorAgentId();
}

/**
  *get monitor current operation
  *@return 
  */
function getMonitorStatus(){
    if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	return top.softPhone.getMonitorStatus();
}

function isAgentButtonDisabled(){
    if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	return top.softPhone.isAgentButtonDisabled();
}


function changeAgentButtonToIdle(){
	if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	top.softPhone.changeAgentButtonToIdle();
}

function isAgentButtonEnableAndNotReady(){
	if(getAgentStatus()== AGENT_STATE_NOTREADY && !isAgentButtonDisabled()) {
		return true;
	}else {
		return false;
	}
}

/** get agent extension
 *  @ return extension(null or string)
 */
function getAgentExtension(){
    if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	return top.softPhone.getAgentExtension();
}

/** get agent loginId
 *  @ return loginId(null or string)
 */
function getAgentLoginId(){
    if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	return top.softPhone.getAgentLoginId();
}

/**
  * single step conference
  * @param lineId id of the line to be conferenced(0-2)
  * @param phoneNumber target phone number
  */
function singleStepConference(phoneNumber,lineId){
	if(!checkSoftphoneApplet()){
			alert("Softphone applet not found!");
			return ;
	}
	if(!checkLineId(lineId)){
		alert("Invalid line id!");
		return ;
	}
	var keys = new Array(DN_ID,EZ_AGENT_VIEW_CURRENT_LINE_ID);   
	var values = new Array(phoneNumber,lineId );
    top.softPhone.executeCommand( "singleStepConferenceAction" , formatArrayToString(keys), formatArrayToString(values) ) ;
}

/**
  * figure out voice dn null or not
  * @return true: voice dn is not null ; false: voice dn is null
  */
function isVoiceDnNotNull(){
	if(!checkSoftphoneApplet()){
			alert("Softphone applet not found!");
			return ;
	}
	return top.softPhone.isVoiceDnNotNull();
}

/**
  * record reschedule
  * @param reschedule datetime
  */
function recordReschedule(type,datetime){
	if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	var r = datetime.match(/^(\d{1,2})(\/)(\d{1,2})\2(\d{1,4}) (\d{1,2}):(\d{1,2})$/);
	if(r==null){
		alert("Invalid Reschedule Date Time!");
		return ;
	}; 
	var d = new Date(r[4], r[1]-1,r[3],r[5],r[6]);
	if(!(d.getFullYear()==r[4]&&(d.getMonth()+1)==r[1]&&d.getDate()==r[3]&&d.getHours()==r[5]&&d.getMinutes()==r[6])){
		alert("Invalid Reschedule Date Time!");
		return ;
	}
	if(type==null){
		alert("Invalid Callback Type!");
		return ;
	}; 

	var keys = new Array("GSW_CALLBACK_TYPE","GSW_DATE_TIME");   
	var values = new Array(type,datetime);
    top.softPhone.executeCommand( "recordRescheduleAction" , formatArrayToString(keys), formatArrayToString(values) ) ;
}

/**
  * update record
  * @param name campaign name
  * @param callresult be sent to change automatically detected call result
  */
function updateRecord(name,callresult)
{
	if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	if(!isInteger(callresult)){
		alert("Invalid CallResult Type!");
		return;
	}
	var keys = new Array("name","callResult");   
	var values = new Array(name,callresult);
	top.softPhone.executeCommand( "updateRecordAction" , formatArrayToString(keys), formatArrayToString(values) ) ;
}

function isInteger(str) {
    for (var i=0; i < str.length; i++)
	{	var ch=str.charAt(i);
		if ((ch != "0") && (ch != "1") && (ch != "2") && (ch != "3") && (ch != "4") && (ch != "5") && (ch != "6") && (ch != "7") && (ch != "8") && (ch != "9"))
			return false;
	}
	if(eval(str)>2147483647)
		return false;
    return true;
}

/**
  * do not call
  * @param phone
  */
function doNotCall(phoneNumber)
{
	if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	var keys = new Array("phone");   
	var values = new Array(phoneNumber);
	top.softPhone.executeCommand( "doNotCallAction" , formatArrayToString(keys), formatArrayToString(values) ) ;
}

/**
  * update custom field
  * @param name campaign name
  * @param fieldname be sent to change field's name
  * @param fieldname be sent to change field's value
  * @param fieldname be sent to change field's type
  */
function updateCustomField(name,fieldname,fieldvalue,fieldtype)
{
	if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	if(fieldname==null || fieldname=='undefined' || fieldname==''){
		alert("Field Name not be specified!");
		return;
	}
	if(fieldvalue==null || fieldvalue=='undefined'){
		alert("Field Value not be specified!");
		return;
	}
	if(fieldtype==null || fieldtype=='undefined' || fieldtype==''){
		alert("Field Type not be specified!");
		return;
	}
	if(!isInteger(fieldtype)){
		alert("Invalid Field Type!");
		return;
	}
	var keys = new Array("name","fieldName","fieldValue","fieldType");
	var values = new Array(name,fieldname,fieldvalue,fieldtype);
	top.softPhone.executeCommand( "updateCustomFieldAction" , formatArrayToString(keys), formatArrayToString(values) ) ;
}

/**
  * record processed
  * @param phone
  */
function recordProcessed()
{
	if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	top.softPhone.executeCommand( "compeletRecordAction" , "111", "111" ) ;
}

/*
 *get aux reason's key
*/
function getReasonKeyArray() {
	return top.getPropertyValue('strAUXKey');
}

/*
 *get aux reason's value
*/
function getReasonValueArray() {
	return top.getPropertyValue('strAUXValue');
}

/**
  * delete user data
  * @param keyString
  */
function deleteUserData(keyArray)
{
	if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	if(keyArray==null || keyArray=='undefined'){
		alert("To delete key not be specified!");
		return;
	}
	var keys = new Array("keys");
	top.softPhone.executeCommand( "deleteUserDataAction" ,"keys", formatArrayToString(keyArray) ) ;
}

/** only in ringing status
*/
function emailDecline(interactionID){
	if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	top.softPhone.emailDecline(interactionID);
}

/**
*only for ringing status
*/
function chatDecline(interactionID){
	if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	top.softPhone.chatDecline(interactionID);
}

/**only for talking status
*if Genesys65,the parameter q should be EmailIn VRP, like 'Email_Inbound_VRP';
*if Genesys72,the parameter q should be EmailIn Queue, like 'EmailIn';
*/
function emailTransferIntoQueue(q,reason,interactionID){
	if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	top.softPhone.emailTransferIntoQueue(q,reason,interactionID);
}

/**only for talking status
*if Genesys65,the parameter q should be Chat VRP, like 'Chat_VRP';
*if Genesys72,the parameter q should be Chat Queue, like 'ChatIn';
*/
function chatTransferIntoQueue(q,reason,interactionID){
	if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	top.softPhone.chatTransferIntoQueue(q,reason,interactionID);
}

/**
  * change agent state to not ready(ACW)
  * 
  */
function changeAgentToACW(reason){
	if(!checkSoftphoneApplet()){
		alert("Softphone applet not found!");
		return ;
	}
	var keys = new Array(WORKMODE,REASON);
	var values = new Array("3",reason);      
	top.softPhone.executeCommand( "setNotReadyAction" , formatArrayToString(keys), formatArrayToString(values) ) ;
}

/*
 *open cobrowse dialog
*/
function openCobrowseDialog() {	
	window.open('https://pdg72.esoon.com/WebAPISamples72/ezactorCobrowse/toplevelframeset.html','cobrowse','width=540px,height=480px,resizable=yes');
}

/**
 * only use to confirm the softphone is available or not.
 */
function isSoftphoneAvailable(){
	var clsName = document.getElementById("dialImage").className;
	if(clsName=="dialImage_disabled"){
		return false;
	}
	return true;
}

/**
*return 200,201,202
*200=ready  201=notReady 202=logout
*/
function getCurrentVoiceState(){
    return currentVoiceState;
}