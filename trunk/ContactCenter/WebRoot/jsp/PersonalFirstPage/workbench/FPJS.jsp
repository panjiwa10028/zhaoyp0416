<%@ page language="java" pageEncoding="UTF-8"%>
<script>
_old_html = false;
_cbp=true;
var date=new Date();
var nowTime=date.getTime();
var tmpTime='';
var hasModidyPasswordPermission = top.isExistedPermission("System.PersonFirstPage.ModidyPassword");
var hasSetFirstPagePermission = top.isExistedPermission("System.PersonFirstPage.SetFirstPage");
var hasSetQuickPermission = top.isExistedPermission("System.PersonFirstPage.SetQuick");
var hasSetPerferencePermissin = top.isExistedPermission("System.PersonFirstPage.setPerference");
var hasTaskManagerPermissin = top.isExistedPermission("System.TaskManager");
var hasCampaignManagerPermissin = top.isExistedPermission("System.CampaignManager.Menu");
var hasMessageManagerPermissin =top.isExistedPermission("System.MessageManager");
var hasCampaignExecutionPermissin = top.isExistedPermission("System.CampaignExecution");



function saveDrag(strDrag)
{


 tableForm.strDrag.value=strDrag;

 tableForm.submit();
}
function checkShowPermissin(){
	try{
		if(!hasTaskManagerPermissin){
			m_3.style.display = "none";
		}
		if(!hasCampaignManagerPermissin){
			m_76.style.display = "none";
		}
		if(!hasMessageManagerPermissin){
			m_6.style.display = "none";
		}
		if(!hasCampaignExecutionPermissin){
			m_75.style.display = "none";
		}
	}catch(e){
	}
}
   function loadInfo(){
	    tableForm.lUserId.value=top.getUserId();
		tableForm.strUserName.value=top.getUserName();
		tableForm.lTenantId.value=top.getTenantId();
		showEnterTime.innerHTML=top.getEnterTime().split(" ")[1];
		checkShowPermissin();
   }

   
   
  	function enableFirstPage() {
  	if (hasSetPerferencePermissin) {
			tdPerfer.style.display = "block";
		}
	}
	
   function openDialog(url,winName,feature){
   		window.open(url,winName,feature);
   }

  // Bulletin
  function showBulletin(lId)
  {
   var url = "<%=strContextPath%>/jsp/PersonalFirstPage/Bulletin/showBulletinDialogForOpen.jsp?lId=" + lId + "&onlyShow=yes&method=show";
   var iTop = (top.window.screen.availHeight-30-690)/2;
      var iLeft = (top.window.screen.availWidth-10-670)/2; 
   window.open(url,'','width=670,height=690,left=scroll=auto,status=no,resizable=no,help=no,top='+iTop+',left='+iLeft);
  }
  // Message
  function showNotifyReadOnly(lId){
    top.tempWinObj = null;
    var url = "<%=strContextPath%>/jsp/PersonalFirstPage/message/modifyMessageDialog.jsp?lId=" +lId;
    var iTop = (top.window.screen.availHeight-30-690)/2;
      var iLeft = (top.window.screen.availWidth-10-670)/2; 
   window.open(url,'','width=670,height=690,left=scroll=auto,status=no,resizable=no,help=no,top='+iTop+',left='+iLeft);
  }
   
   function openPassWord()
   {
   url = '<%=strContextPath%>/jsp/PersonalFirstPage/personalinfoManager/content/modifyPassword.jsp?'+top.getStrUserInfo();
   var iTop = (top.window.screen.availHeight-30-200)/2;
   var iLeft = (top.window.screen.availWidth-10-500)/2; 
   openDialog(url,'','width=500px,height=200px,left=scroll=auto,status=no,resizable=no,help=no,top='+iTop+',left='+iLeft);
   }
   function openEditHomepage()
   {
   url="<%=strContextPath%>/personalInfoAction.do?method=showConfigPageNum&"+top.getStrUserInfo();
    var iTop = (top.window.screen.availHeight-30-380)/2;
   var iLeft = (top.window.screen.availWidth-10-500)/2; 
   openDialog(url,'','width=500px,height=380px,left=scroll=auto,status=no,resizable=no,help=no,top='+iTop+',left='+iLeft);
   }
   function openShortcut()
   {
     var url = '<%=strContextPath%>/SetQuickAction.do?method=go2Set&lUserId='+top.getUserId()+'&lTenantId='+top.getTenantId()+'&strUserName='+top.getUserName();//+'&nPurpose=1&nboxType='+parent.workArea.commonTransForm.nBoxType.value;//+'&lMarqueeId'+lIdTemp;
	var iTop = (top.window.screen.availHeight-30-480)/2;
   var iLeft = (top.window.screen.availWidth-10-460)/2; 
   openDialog(url,'','width=460px,height=480px,left=scroll=auto,status=no,resizable=no,help=no,top='+iTop+',left='+iLeft);
   
	
   }
   function openPerfer()
   {
	url="<%=strContextPath%>/jsp/PersonalFirstPage/workbench/perference/perference.jsp?"+top.getStrUserInfo();
   var iTop = (top.window.screen.availHeight-30-520)/2;
   var iLeft = (top.window.screen.availWidth-10-650)/2; 
   openDialog(url,'perfer','width=650px,height=520px,toolbar=no,location=no,status=no,menubar=no,scrollbars=no,resizable=no,top='+iTop+',left='+iLeft);
   
   }
   
	function submitForm(){
		tableForm.forward.value = "/jsp/PersonalFirstPage/workbench/WorkbenchConfig/configHiddenSubmitIFrame.jsp"
		tableForm.submit();
	}

//更改模块
function changeModule(module)
{
	var nSignPosition = "Module_"+(top.firstflag+1);
	if(module=="bulletin")
	{
		if(top.isExistedPermission("System.BulletinBoard"))
		{
	 		top.addTab(nSignPosition,'<%=Function.getMultiLangItemContent("lable.bulletin", request)%>','<%=strContextPath%>/jsp/main/System.jsp',false,true,false,'<%=strContextPath%>/','<%=strContextPath%>/jsp/PersonalFirstPage/Bulletin/workArea.jsp');
		}
		
	}
	else if(module=="medal")
	{
		if(top.isExistedPermission("System.AgentMedalBoard"))
		{
			top.addTab(nSignPosition,'<%=Function.getMultiLangItemContent("PersonalFirstPage.Medal.show.title", request)%>','<%=strContextPath%>/jsp/main/System.jsp',false,true,false,'<%=strContextPath%>/','<%=strContextPath%>/jsp/PersonalFirstPage/medalAssign/workArea.jsp');
		}
	}
	else if(module=="message")
	{
		if(top.isExistedPermission("System.MessageManager"))
		{
			top.addTab(nSignPosition,'<%=Function.getMultiLangItemContent("lable.msgManager", request)%>','<%=strContextPath%>/jsp/main/System.jsp',false,true,false,'<%=strContextPath%>/','<%=strContextPath%>/jsp/MessageManager/workArea.jsp');
		}
		
	}
	else if(module=="task")
	{
		if(top.isExistedPermission("System.MessageManager"))
		{
			top.addTab(nSignPosition,'<%=Function.getMultiLangItemContent("ScheduleManager.Task", request)%>','<%=strContextPath%>/jsp/main/System.jsp',false,true,false,'<%=strContextPath%>/','<%=strContextPath%>/jsp/TaskManage/workArea.jsp?strModuleType=FIRSTPAGE');
		}
		
	}
	else if(module=="event")
	{
		if(top.isExistedPermission("System.MessageManager"))
		{
			top.addTab(nSignPosition,'<%=Function.getMultiLangItemContent("lable.PersonEventManage", request)%>','<%=strContextPath%>/jsp/main/System.jsp',false,true,false,'<%=strContextPath%>/','<%=strContextPath%>/jsp/EventManage/workArea.jsp?nEventType=2');
		}
		
	}
}

	function findEventDetail(lEventId){
		url = '<%=strContextPath%>/eventAction.do?method=show&lId='+lEventId+top.getStrUserInfo()+"&nView=1";
		var iTop = (top.window.screen.availHeight-30-500)/2;
		var iLeft = (top.window.screen.availWidth-10-650)/2; 
		openDialog(url,'','width=650px,height=515px,left=scroll=auto,status=no,resizable=no,help=no,top='+iTop+',left='+iLeft);
	}
	function findTaskDetail(lTaskId){
		url = '<%=strContextPath%>/taskAction.do?method=view&urlForward=/jsp/TaskManage/fistPageViewTask.jsp&lId='+lTaskId+top.getStrUserInfo();
		var iTop = (top.window.screen.availHeight-30-500)/2;
		var iLeft = (top.window.screen.availWidth-10-530)/2;  
		openDialog(url,'','width=550,height=560,left=scroll=auto,status=no,resizable=no,help=no,top='+iTop+',left='+iLeft);
	}
	
	
	//stella new 
	function showTask(lTaskId){
	var forward='/jsp/TaskManage/task/viewTask.jsp';
	var contentUrl='<%=strContextPath%>/taskAction.do?method=view&forward='+forward+'&lId='+lTaskId+top.getStrUserInfo();
	
		top.addTab('PersonalFirstPage','<%=Function.getMultiLangItemContent("Permission.TaskManager", request)%>',
		contentUrl,
		false,false,false,'','');
		
	}

	//显示我参加的活动 --活动执行
	function showCampaign(lCampaignId){
	var forward='/jsp/CampaignExecution/Go2CampaignContent.jsp';
	var contentUrl='<%=strContextPath%>/CampaignExecutionAction.do?method=go2CampaignContent&strForward='+forward+'&lCampaignId='+lCampaignId+top.getStrUserInfo();
	
		top.addTab('PersonalFirstPage','<%=Function.getMultiLangItemContent("Campaign.CampaignExecution.Name", request)%>',
		contentUrl,false,false,false,'','');
		
	}

	//显示我负责的活动--行销活动
	function showCampaign2(lCampaignId){
		//var forward='/jsp/CampaignExecution/Go2CampaignContent.jsp';
		var contentUrl='<%=strContextPath%>/CampaignManagerAction.do?method=getCampaignContent&lCampaignId='+lCampaignId+top.getStrUserInfo();
		
			top.addTab('CampaignManagerMenu','<%=Function.getMultiLangItemContent("Campaign.CampaignManager.Name", request)%>',
			contentUrl,false,false,false,'','');
			
		}

		function showMessage(lMessageId){
	var url = "<%=strContextPath%>/jsp/PersonalFirstPage/message/modifyMessageDialog.jsp?lId=" +lMessageId;
    var iTop = (top.window.screen.availHeight-30-690)/2;
    var iLeft = (top.window.screen.availWidth-10-670)/2; 
    window.open(url,'','width=670,height=690,left=scroll=auto,status=no,resizable=no,help=no,top='+iTop+',left='+iLeft);
		
	}
	
  
function showForm(formType,lId){
	var contentUrl='';
	var moduleName='';
	var ShowName='';
	top.setBrookWorkSheetingStringID = lId;
	//投诉单
	if(formType=='COMPLAINT')
	{ 
		contentUrl='<%=strContextPath%>/ComplaintAction.do?&comefrom=1&method=complaintDetailBar'+top.getStrUserInfo();
		moduleName="PersonalFirstPage";
		ShowName='<%=Function.getMultiLangItemContent("WorkSheetManager.ComplaintManager.FunctionMenu.ItemName", request)%>';
	}
	//维修单
	if(formType=='SERVICING')
	{ 
		contentUrl='<%=strContextPath%>/MaintainAction.do?&comefrom=1&method=maintainDetailBar'+top.getStrUserInfo();
		moduleName="PersonalFirstPage";
		ShowName='<%=Function.getMultiLangItemContent("WorkSheetManager.MaintainManager.FunctionMenu.ItemName", request)%>';
	}
	//咨询单
	if(formType=='CONSULT')
	{ 
		contentUrl='<%=strContextPath%>/ConsultAction.do?&comefrom=1&method=consultDetailBar'+top.getStrUserInfo();
		moduleName="PersonalFirstPage";
		ShowName='<%=Function.getMultiLangItemContent("WorkSheetManager.ConsultManager.FunctionMenu.ItemName", request)%>';
	}
	//订单
	if(formType=='ORDER')
	{ 
		contentUrl='<%=strContextPath%>/jsp/OrderFormManager/workArea.jsp?comefrom=1&strId='+lId;
		moduleName="PersonalFirstPage";
		ShowName='<%=Function.getMultiLangItemContent("OrderFormManager.FunctionMenu.ItemName", request)%>';
	}

	top.addTab(moduleName,ShowName,contentUrl,false,false,false,'','');
}

//我的代办任务的更多
function taskMore(){
	contentUrl='<%=strContextPath%>/jsp/TaskManage/workArea.jsp?nTaskType=1';
	moduleName="PersonalFirstPage";
	ShowName="<%=Function.getMultiLangItemContent("Permission.TaskManager", request)%>";
	top.addTab(moduleName,ShowName,contentUrl,false,false,false,'','');
}

//给我的信息的更多
function messageMore(){
	contentUrl='<%=strContextPath%>/jsp/MessageManager/workArea.jsp';
	moduleName="notifyManager";
	ShowName="<%=Function.getMultiLangItemContent("lable.msgManager", request)%>";
	top.addTab(moduleName,ShowName,'<%=strContextPath%>/jsp/main/System.jsp',false,false,false,'<%=strContextPath%>/',contentUrl);
}

//我参加的活动的更多
function campaignMore(){
	contentUrl='<%=strContextPath%>/jsp/CampaignExecution/Go2CampaignExecution.jsp';
	moduleName="PersonalFirstPage";
	ShowName="<%=Function.getMultiLangItemContent("Campaign.CampaignExecution.Name", request)%>";
	top.addTab(moduleName,ShowName,contentUrl,false,false,false,'','');
}

//我负责的活动的更多
function campaign2More(){
	contentUrl='<%=strContextPath%>/jsp/CampaignManager/WorkArea.jsp';
	moduleName="CampaignManagerMenu";
	ShowName="<%=Function.getMultiLangItemContent("Campaign.CampaignManager.Name", request)%>";
	top.addTab(moduleName,ShowName,contentUrl,false,false,false,'','contentUrl');
}
</script>