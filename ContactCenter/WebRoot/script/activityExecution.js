//需要在外拨时赋值，在做完小结后=0，在切换新活动时也需要=0。
var lActivityId = -1;
var lContacteeId = 0;

var currentActivity = null;
var nOCSActivityFlag = 0;
var ActivityExecutionTabId = 'ActivityExecution';
//var ActivityExecutionTabTitle="ActivityExecution";//move to businessLayout.jsp
var strCustomerContacteeId ='' ;
var strCustomerContacteeName = '';
var strCustomerContactNumber='';

//名单来源 1=未执行名单 2=待跟踪 3=已结案名单
var nFrom = '0';
//未执行名单是否开始自动提取
var isStartAutoContactee='0';

/*
 * 初始化参考值
 */
function resetValues(){
		top.lActivityId = -1;
		top.lContacteeId = 0;
		
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


/**
 * 取活动树
 */
function getActivityTreeList(){
	top.jsonrpc.contactSummaryManager.setCallback(false);
	var list =  top.jsonrpc.activitExeManager.getActivityTree(top.getUserId(),top.getUserName(),top.getTenantId());
	return list;
 	
}

/**
 * 取活动的基本信息
 */
function getActivityInfo(lActivityId){
	return top.jsonrpc.activitExeManager.getActivityInfo(top.getUserId(),top.getUserName(),top.getTenantId(),lActivityId);
}
/**
 * 判断是否需要做小结
 */
function isSummaryOfActivity(lActivityId){
	var rnt = false;
	try{
		if(currentActivity==null || currentActivity.map.LID!=lActivityId){
			currentActivity = getActivityInfo(lActivityId);
		}
		
		if(currentActivity.map.NDOSUMMARY==0){
			rnt = true;
		}
	}catch(e){
		//alert(e.description);
	}
	return rnt;
	
}

/**
 * 
 */
function viewActivity(lActivityId,lContacteeId){
	//TODO 判断外拨活动标签是否打开
	//TODO 判断是否是当然活动 是否重新取活动基本信息
	try{
	var tab = mainIframe.mainCenter.tabFrame.document.getElementById(ActivityExecutionTabId);
	if(tab){
		//var activityTabFrame = top.getTabFrame(ActivityExecutionTabId);
		var activityTabFrame = top.mainIframe.mainCenter.contentsFrame_ActivityExecution;
		activityTabFrame.go2Activity(lActivityId,lContacteeId);
		top.focusTab(ActivityExecutionTabId);
	}else{
		top.addTab(ActivityExecutionTabId,ActivityExecutionTabTitle,getActivityFrameUrl(lActivityId,lContacteeId),true,false);
	}
	}catch(e){
		//alert(e.description);
	}
}
/*
 * 显示坐席所有活动的执行情况
 */
function showActivityExecList(){
	try{
		
	var tab = mainIframe.mainCenter.tabFrame.document.getElementById(ActivityExecutionTabId);
	if(tab){
		top.focusTab(ActivityExecutionTabId);
		var activityTabFrame = top.mainIframe.mainCenter.contentsFrame_ActivityExecution;
		activityTabFrame.showActivityExecList();
	}else{
		top.addTab(ActivityExecutionTabId,ActivityExecutionTabTitle,getActivityFrameUrl('',''),true,false);
	}
	
	}catch(e){
		alert(e.description);
	}
}

/**
 * OCS外拨调用的
 */
function findActivity(lActivityId, lContacteeId)
{
    top.lActivityId = parseInt(lActivityId);
    top.lContacteeId= parseInt(lContacteeId);

    top.nOCSActivityFlag = 1;
    
    viewActivity(lActivityId,lContacteeId);
}

//在自动外拨的电话为通话中 时 去掉自动拨号的timer
function onTalkingForAutoOutboundActivity(){
	try{
		//var activityTabFrame = top.getTabFrame(ActivityExecutionTabId);
		var activityTabFrame = top.mainIframe.mainCenter.contentsFrame_ActivityExecution;
		activityTabFrame.workArea_ListInfo.workArea_ContacteeList.clearAutoDialPhoneTimer();
	}catch(e){
		//alert(e.description);
	}
}
/**
 * 在做完小结之后的处理
 */
function onSummaryAfter(){
	var tab = mainIframe.mainCenter.tabFrame.document.getElementById(ActivityExecutionTabId);
	if(tab){
		try{
			top.focusTab(ActivityExecutionTabId);
			//getTabFrame in tab.js
			//var activityTabFrame = top.getTabFrame(ActivityExecutionTabId);
			var activityTabFrame = top.mainIframe.mainCenter.contentsFrame_ActivityExecution;
			if(top.nFrom=='1'
			   &&top.isStartAutoContactee=='1'
			   &&currentActivity.map.NGETCONTACTEEMODE=='1'
			   &&currentActivity.map.NOUTBOUNDMODE=='5'
			   ){
			  	activityTabFrame.workArea_ListInfo.workArea_ContacteeList.nextContactee();
			}else{
				activityTabFrame.workArea_ListInfo.workArea_ContacteeList.getResult();
			}
		}catch(e){
		
		}
	}else{
		//top.addTab(ActivityExecutionTabId,'ActivityExecution',url,true,true);
	}
	resetValues();
}

function getActivityFrameUrl(lActivityId, lContacteeId){
	var url =strContextPath+"/jsp/ActivityExec/activityExec.jsp?temp=1";
	if(lActivityId!=null&&lActivityId!=undefined &&lActivityId!=''&&lActivityId>0){
		url+="&lActivityId="+lActivityId;
	}
	if(lContacteeId!=null&&lContacteeId!=undefined &&lContacteeId!=''&&lContacteeId>0){
		url+="&lContacteeId="+lContacteeId;
	}
	return url;
}

//只在 未执行的Timed Preview 手动拨号时 如果 没有对上一个名单做操作就取下一个名单， 则需要记录提出时间 到ActivityContacteeLog时  
	//在座席提取名单之后 回收没操作的名单
	function revokeNotOperateContactee(lId,lActivityId,nOutboundMode,nAutoDial,nGetContacteeMode,dtAgentAssignedTime){
		 if(lId>0&&lActivityId>0
		 &&nOutboundMode==5
		 //&&nGetContacteeMode==0
		 ){
		 	top.jsonrpc.activitExeManager.revokeNotOperateContactee(top.getUserId(),top.getUserName(),top.getTenantId(),lId,lActivityId,dtAgentAssignedTime);
		 }
		 
	}
	
	//放弃个人追踪名单 到公共追踪名单
	function abandonTracingContactee(lId,lActivityId){
		//alert('s');
		if(lId>0&&lActivityId>0
		 ){
		 	top.jsonrpc.activitExeManager.abandonTracingContactee(top.getUserId(),top.getUserName(),top.getTenantId(),lId,lActivityId);
		 }
	}
	
