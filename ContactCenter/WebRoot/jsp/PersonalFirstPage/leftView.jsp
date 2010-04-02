<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.Function" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.BusinessCenterApp" %>
<%@ page import="com.esoon.EZActor.Lib.WorkBench.WorkBench" %>
<%@ page import="com.esoon.EZActor.Lib.WorkBench.WorkBenchItem" %>
<%@ page import="EZLib.Message.EZMessage" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ include file="/jsp/common/header/include_init.jsp"%>
<%@ include file="/jsp/common/header/include_script.jsp"%>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib prefix="fmt" uri="/WEB-INF/fmt.tld" %>
<%@ include file="/jsp/common/header/include_getRequiredParameter.jsp" %>

<html>
<head>
<link href="<%=request.getContextPath()%>/css/personstyle.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet" type="text/css">
<script src="<html:rewrite forward ='commonQuery'/>"></script>
<script language="JavaScript" type="text/JavaScript">
<!--
  var sleep = 0;
  var tmpTime;
  function loadInfo()
  {      
      tmpTime=top.tempTimer;
      showTime();      
      leftView_HomepageInfo_InfoList.location.href="<%=request.getContextPath()%>/personalInfoAction.do?method=getAboutInfo&lAgentId="+top.getUserId()+"&lReceiverId="+top.getUserId()+top.getStrUserInfo();      
      //leftView_AwardpageInfo_InfoList.location.href="<%=request.getContextPath()%>/personalInfoAction.do?method=getAwardInfo&lAgentId="+top.getUserId()+"&lReceiverId="+top.getUserId()+top.getStrUserInfo();      
  //leftView_HomepageInfo_InfoList.location.href='<%=request.getContextPath()%>/jsp/PersonalFirstPage/workbench/homePageLeftview.jsp";  
  }
  function showTime()
  {   
      var hour=0;
      var hour1=0;
      var hour2=0;  
      var minute=0;      
      var minute1=0;
      var minute2=0;
      var second=0;
      var second1=0;
      var second2=0;
      
      workTime.innerHTML=top.timesValues;
      /*if(tmpTime!=top.tempTimer)
      {
         tmpTime=top.tempTimer;
         top.totalNumber=top.totalNumber+1;
         if(tmpTime!="")
         {
            hour1=top.totalTimer.substring(0,top.totalTimer.indexOf(":"));
            minute1=top.totalTimer.substring(top.totalTimer.indexOf(":")+1,top.totalTimer.lastIndexOf(":"));
            second1=top.totalTimer.substring(top.totalTimer.lastIndexOf(":")+1,top.totalTimer.length);
            
            hour2=tmpTime.substring(0,tmpTime.indexOf(":"));
            minute2=tmpTime.substring(tmpTime.indexOf(":")+1,tmpTime.lastIndexOf(":"));
            second2=tmpTime.substring(tmpTime.lastIndexOf(":")+1,tmpTime.length);
            
            second=second1+second2;
            minute=minute1+minute2;
            hour=hour1+hour2;
            if(second>=60)
            {
               second=second-60;
               minute=minute+1;
            }
            if(minute>=60)
            {
               minute=minute-60;
               hour=hour+1;
            }
            
            top.totalTimer = ((hour < 10) ? "0" : "") + hour;
	        top.totalTimer += ((minute < 10) ? ":0" : ":") + minute;
	        top.totalTimer += ((second < 10) ? ":0" : ":") + second;                        
         }
      } */
      workNum.innerHTML=top.totalNumber;
      workAllTime.innerHTML=top.totalTimer;
      workNum1.innerHTML=top.totalNumber1;
      workAllTime1.innerHTML=top.totalTimer1;
      setTimeout("showTime()", 2000);
  }
  
  function changeMoudle(moudleTd , obj1 , obj2)
	{
		if(moudleTd.style.display=="block") {
	 		moudleTd.style.display="none";
	 		obj1.style.display="none";
	 		obj2.style.display="block";
		}
		else {
			moudleTd.style.display="block";	
			obj1.style.display="block";
	 		obj2.style.display="none";	
		}
	}
	//----------------------------------------------------------------
	// 判断是否存在此moudle,在上层的menu中
	//----------------------------------------------------------------
	function isExistedMoudle(strMoudleId)
	{
		try{
		for(var i = 0; i < top.subView.moduleId.length; i++)
		{
			if(top.subView.moduleId[i] == strMoudleId)
			{
				return true;
			}
		}
		}catch(e)
		{}
		
		return false;
	}
	
	//用于地址簿查询函数
	function qry() {
		
		selectTabViewByAddressBook();	
		//submitForm();			
		
	}
	
	function submitForm()
	{		
		commonTransForm.target = "AddressBookListArea";	
		
		commonTransForm.strOrderField.value = "strStafferId";
		commonTransForm.strAscFlag.value = "asc";
		commonTransForm.nPageSize.value = perPageNum;
		commonTransForm.nPageIndex.value = 1;
		commonTransForm.nRecordIndex.value = 0;

		commonTransForm.lUserId.value = top.getUserId();
		commonTransForm.strUserName.value = top.getUserName();
		commonTransForm.lTenantId.value = top.getTenantId();		
			
		var fc=document.getElementById("fieldContainer");
		var html = fc.innerHTML;
		var flag = "0";
		if (html.indexOf('value') == -1) {
			fc.innerHTML = '';
			flag = "-1";
		}	
		
		commonTransForm.submit();

		if (flag == "-1") {
			fc.innerHTML = html;
		}
	
	}
	
	function changeFilter(){    
    	if(document.all.filterName.value!=""){
		    var fid= document.all.filterName.value;
		    var fdiv= document.getElementById("sf_"+fid);
    		var fc=document.getElementById("fieldContainer");
    		fc.innerHTML=fdiv.innerHTML;
    	}else{
    		var fc=document.getElementById("fieldContainer");
    		fc.innerHTML='&nbsp;';
    	}
	}
	

   //地址簿查询操作
   function selectTabViewByAddressBook()
   {
     //权限检验
     if(!top.isExistedPermission("System.AddressBook"))
     {
     	alert("no permission!");
     	return;
     }
     
     
     //查询条件
     var fc=document.getElementById("fieldContainer");
	 var html = fc.innerHTML;
		
     //刷新所有leftView , workArea , toolBar 区域
     //top.enableSubTab(); 
     //var TabId= top.subView.selectTabViewByName(name);     
     
     //屏蔽刷新方式
     var TabId= "10";
     top.subView.selectTab(TabId);
     
     //alert("../"+top.subView.workAreaSrc[TabId].substring(3,top.subView.workAreaSrc[TabId].length) + "?load=" + html);
     top.workArea.location.href = "../"+top.subView.workAreaSrc[TabId].substring(3,top.subView.workAreaSrc[TabId].length)+ "?load=" + html;
	
	
     if((top.subView.leftViewSrc[TabId] != null) && (top.subView.leftViewSrc[TabId] != ''))
     {
        //top.leftView.location.href = "../"+top.subView.leftViewSrc[TabId].substring(3,top.subView.leftViewSrc[TabId].length);       
     }
     	
     if((top.subView.toolBarSrc[TabId] != null) && (top.subView.toolBarSrc[TabId] != ''))
     {   
        top.toolBar.location.href = "../"+top.subView.toolBarSrc[TabId].substring(3,top.subView.toolBarSrc[TabId].length);
     }
        
   } 
   
//-->
</script>

<%
	//List list = (List) request.getAttribute("moduleList");
	String contextPath = request.getContextPath();	
	
	EZMessage requestMessage1 = new EZMessage();
	requestMessage1.setString("strServiceName", "PersonalInfoManager");
	requestMessage1.setString("strTransName", "GetWorkBench");
	requestMessage1.setLong("lUserId", lUserId);
	requestMessage1.setString("strUserName", strUserName);
	requestMessage1.setLong("lTenantId", lTenantId);
	
	EZMessage responseMessage1 = new EZMessage();	
	BusinessCenterApp.getInstance().handleTrans(requestMessage1,responseMessage1);	
	Function.MessageToRequest(responseMessage1, request);
		
	//初始化workbench
	WorkBench workbench=(WorkBench)responseMessage1.getObject();
%>
<style type="text/css">
<!--
.style1 {
	color: #333333;
	font-weight: bold;
}
-->
</style>
</head>
<body onload="loadInfo()" oncontextmenu=""  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" scroll="no">
<input name="campaignState" type="hidden" />
<table id="__01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td width="0" height="0">
		</td>
		<td></td>
	</tr>
	<tr> 
	<td width="0"></td>	
	<td valign="top">
		<table align="center" class="lab1b" width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
	          <td width="70%" align="left" background="<%=request.getContextPath()%>/images/person/images_listtitle_bg2.gif"> 
	            <table width="100%" border="0" cellspacing="0" cellpadding="0">
	              <tr> 
	                <td width="6%"><div align="center"><img src="<%=request.getContextPath()%>/images/person/tree_images/ban_onlineMo.gif" width="19" height="16"></div></td>
	                <td width="94%"><div align="left" class="font"><%=Function.getMultiLangItemContent("person.firstpage.workbench.leftView.OnlineMonitor",request)%></div></td>
	              </tr>
	            </table>
	          </td>
	          <td width="30%" align="right" background="<%=request.getContextPath()%>/images/person/images_listtitle_bg2.gif">
	          	<div align="center" id="viewhideM">
	    			<a href="javascript:changeMoudle(OnlineMonitor, viewhideM,viewshowM);" title="<%=Function.getMultiLangItemContent("hiddenLeftTree",request)%>" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image11','','<%=request.getContextPath()%>/images/person/tree_images/ban_up02.gif',1)"><img src="<%=request.getContextPath()%>/images/person/tree_images/ban_up01.gif" name="Image11" width="25" height="22" border="0"></a> 
	    		</div>
	    		<div align="center" style="display:none" id="viewshowM">
	    			<a href="javascript:changeMoudle(OnlineMonitor, viewhideM,viewshowM);" title="<%=Function.getMultiLangItemContent("viewLeftTree",request)%>" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image12','','<%=request.getContextPath()%>/images/person/tree_images/ban_down02.gif',1)"><img src="<%=request.getContextPath()%>/images/person/tree_images/ban_down01.gif" name="Image12" width="25" height="22" border="0"></a>
	        	</div>        			        	
	          </td>
	        </tr>
	        <tr valign="top">
	        	<td id="OnlineMonitor" colspan="2" style="display:block"> 
	              <table width="100%" border="0" cellspacing="3" cellpadding="0">
		              <tr> 
		                <td width="55%"><div align="left"><%=Function.getMultiLangItemContent("common.worktime", request)%></div></td>
		                <td width="45%"><span id="workTime"></span></td>
		              </tr>
		              <tr> 
		                <td><div align="left"><%=Function.getMultiLangItemContent("common.Inbound.worknum", request)%></div></td>
		                <td><span id="workNum"></span></td>
		              </tr>
		              <tr> 
		                <td noWrap><div align="left"><%=Function.getMultiLangItemContent("common.Inbound.workalltime", request)%></div></td>
		                <td><span id="workAllTime"></td>
		              </tr>
		              <tr> 
		                <td><div align="left"><%=Function.getMultiLangItemContent("common.Outbound.worknum", request)%></div></td>
		                <td><span id="workNum1"></span></td>
		              </tr>
		              <tr> 
		                <td noWrap><div align="left"><%=Function.getMultiLangItemContent("common.Outbound.workalltime", request)%></div></td>
		                <td><span id="workAllTime1"></td>
		              </tr>
	          	  </table>
	             </td>
	         </tr>                 
		</table>
	
		<table align="center"  width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
	          <td width="70%" align="left" background="<%=request.getContextPath()%>/images/person/images_listtitle_bg2.gif"> 
	            <table width="100%" border="0" cellspacing="0" cellpadding="0">
	              <tr> 
	                <td width="6%"><div align="center"><img src="<%=request.getContextPath()%>/images/ban_Campaign.gif" width="19" height="16"></div></td>
	                <td width="94%"><div align="left" class="font">&nbsp<%=Function.getMultiLangItemContent("person.firstpage.workbench.leftView.HomepageMenu",request)%></div></td>
	              </tr>
	            </table></td>
	          <td width="30%" align="right" background="<%=request.getContextPath()%>/images/person/images_listtitle_bg2.gif">
	          	         	
	          	<div align="center" id="viewhideP">
	    			<a href="javascript:changeMoudle(HomePage, viewhideP,viewshowP);" title="<%=Function.getMultiLangItemContent("hiddenLeftTree",request)%>" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image13','','<%=request.getContextPath()%>/images/person/tree_images/ban_up02.gif',1)"><img src="<%=request.getContextPath()%>/images/person/tree_images/ban_up01.gif" name="Image13" width="25" height="22" border="0"></a> 
	    		</div>
	    		<div align="center" style="display:none" id="viewshowP">
	    			<a href="javascript:changeMoudle(HomePage, viewhideP,viewshowP);" title="<%=Function.getMultiLangItemContent("viewLeftTree",request)%>" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image14','','<%=request.getContextPath()%>/images/person/tree_images/ban_down02.gif',1)"><img src="<%=request.getContextPath()%>/images/person/tree_images/ban_down01.gif" name="Image14" width="25" height="22" border="0"></a>
	        	</div>        		
	        	
	          </td>
	        </tr>
	        <tr valign="top">
	        	<td id="HomePage"  colspan="2" style="display:block"> 
	        		<iframe id="leftView_HomepageInfo_InfoList" name="leftView_HomepageInfo_InfoList" style="filter:chroma(color=#ffffff)" width="100%" height="100%" frameborder="0" scrolling="auto"></iframe>         
	            </td>
	        </tr>                 
		</table>
		
		<div style="display:none">
			<table align="center"  width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
		          <td width="70%" align="left" background="<%=request.getContextPath()%>/images/person/images_listtitle_bg2.gif"> 
		            <table width="100%" border="0" cellspacing="0" cellpadding="0">
		              <tr> 
		                <td width="6%"><div align="center"><img src="<%=request.getContextPath()%>/images/ban_award.gif" width="19" height="16"></div></td>
		                <td width="94%"><div align="left" class="font">&nbsp<%=Function.getMultiLangItemContent("GeneralManager.AddAgentMedal",request)%></div></td>
		              </tr>
		            </table></td>
		          <td width="30%" align="right" background="<%=request.getContextPath()%>/images/person/images_listtitle_bg2.gif">
		          	         	
		          	<div align="center" id="viewhideS">
		    			<a href="javascript:changeMoudle(AwardPage, viewhideS,viewshowS);" title="<%=Function.getMultiLangItemContent("hiddenLeftTree",request)%>" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image15','','<%=request.getContextPath()%>/images/person/tree_images/ban_up02.gif',1)"><img src="<%=request.getContextPath()%>/images/person/tree_images/ban_up01.gif" name="Image15" width="25" height="22" border="0"></a> 
		    		</div>
		    		<div align="center" style="display:none" id="viewshowS">
		    			<a href="javascript:changeMoudle(AwardPage, viewhideS,viewshowS);" title="<%=Function.getMultiLangItemContent("viewLeftTree",request)%>" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image16','','<%=request.getContextPath()%>/images/person/tree_images/ban_down02.gif',1)"><img src="<%=request.getContextPath()%>/images/person/tree_images/ban_down01.gif" name="Image16" width="25" height="22" border="0"></a>
		        	</div>        		
		        	
		          </td>
		        </tr>
		        <tr valign="top">
		        	<td id="AwardPage" height="320" colspan="2" style="display:none">
		        		<iframe id="leftView_AwardpageInfo_InfoList" name="leftView_AwardpageInfo_InfoList" style="filter:chroma(color=#ffffff)" width="100%" height="100%" frameborder="0" scrolling="auto"></iframe>         
		            </td>
		        </tr>   
		        
			</table>
		</div>
	
	</td>
	          
	<td width="0"></td>
	</tr>   
	
	 
	<tr>
	  <td></td>
	  <td></td>
	  <td></td>
	</tr>
</table>
		<div style="display:none" id="sf_strStafferId">
			<input id="strStafferIdLeftValue" name="strStafferIdLeftValue" type="text" class="box01"  maxlength="16" value="<c:out value="${STRSTAFFERIDLEFTVALUE}"/>" size="16">
		</div>
		<div style="display:none" id="sf_strName">
			<input id="strNameLeftValue" name="strNameLeftValue" type="text" class="box01" maxlength="16" value="<c:out value="${STRNAMELEFTVALUE}"/>" size="16">
		</div>
		<div style="display:none" id="sf_strOfficePhoneExt">
			<input id="strOfficePhoneExtLeftValue" name="strOfficePhoneExtLeftValue" type="text" class="box01" maxlength="16" value="<c:out value="${STROFFICEPHONEEXTLEFTVALUE}"/>" size="16">
		</div>
		<div style="display:none" id="sf_strEmail">
			<input id="strEmailLeftValue" name="strEmailLeftValue" type="text" class="box01" maxlength="256" value="<c:out value="${STREMAILLEFTVALUE}"/>" size="16">
		</div>
		<div style="display:none" id="sf_strLoginId">
			<input id="strLoginIdLeftValue" name="strLoginIdLeftValue" type="text" class="box01" maxlength="16" value="<c:out value="${STRLOGINIDLEFTVALUE}"/>" size="16">
		</div>
		<div style="display:none" id="sf_strDepartmentName">
			<input id="strDepartmentNameLeftValue" name="strDepartmentNameLeftValue" type="text" class="box01" maxlength="16" value="<c:out value="${STRDEPARTMENTNAMELEFTVALUE}"/>" size="16">
		</div>
		<div style="display:none" id="sf_strJobTitle">
			<input id="strJobTitleLeftValue" name="strJobTitleLeftValue" type="text" class="box01" maxlength="16" value="<c:out value="${STRJOBTITLELEFTVALUE}"/>" size="16">
		</div>
		<div style="display:none" id="sf_null">
			<input size="15" type="text" class="textReadonly" readonly="readonly"/>
		</div>
</body>
</html>
