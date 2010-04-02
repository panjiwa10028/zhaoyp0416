<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.*" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.BusinessCenterApp" %>
<%@ page import="com.esoon.EZActor.Lib.WorkBench.WorkBench" %>
<%@ page import="com.esoon.EZActor.Lib.WorkBench.WorkBenchItem" %>
<%@ page import="EZLib.Message.EZMessage" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.Function" %>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>
<%@ taglib prefix="fmt" uri="/WEB-INF/fmt.tld" %>
<%@ taglib prefix="fn" uri="/WEB-INF/fn.tld" %>
<%@ include file="/jsp/common/header/include_init.jsp" %>
<%@ include file="/jsp/common/header/include_script.jsp" %>	 
<%@ include file="/jsp/common/header/include_getRequiredParameter.jsp" %>


<html>
<head>
<title><%=Function.getMultiLangItemContent("Business.Title",request)%></title>
<link href="<%=strContextPath%>/css/chrome.css" rel="stylesheet" type="text/css">
<script src="<%=strContextPath%>/script/common.js"></script>
<script src="<%=strContextPath%>/script/contactCommon/setStatus.js"></script>
<script type="text/javascript" src="<%=strContextPath%>/script/contactCommon/dtree.js"></script>


  <script language="JavaScript" type="text/JavaScript">

   function loadInfo(){    
 	
	
	       
	       
   }
   
   //pic
function formVerrify(){
	var strTemp,strValue,strLen,strExName;
    if (document.all.binContent.value == "") 
    {
     tableForm.IsModifyPic.value=0;
	}
	 if (document.all.binContent.value != "") 
	{//图片类型检查
		tableForm.IsModifyPic.value=1;
      strTemp=document.all.binContent.value;
      strValue=strTemp.toLowerCase()
      strLen=strTemp.length
      strExName=strValue.substring(strValue.lastIndexOf('.'),strLen)
      if (strExName!=".jpg" && strExName!=".gif" && strExName!=".jpeg")
      {
        alert("<%=Function.getMultiLangItemContent("personalInfo.modpic.fomat.error",request)%>")
        return false;
       }
	}	
	return true; 	
}

//shortcut

	function deleteQuick() {
		if(document.forms[0].ReceiveList.selectedIndex==-1)
		{
		alert('<%=Function.getMultiLangItemContent("please.select.one",request)%>');
			return;
		}
		var i;
		
			for(i=0; i<document.forms[0].ReceiveList.options.length; i++){
			//alert(document.forms[0].ReceiveList.options[i].selected.value);
				if(document.forms[0].ReceiveList.options[i].selected)
				{
					document.forms[0].ReceiveList.options[i]=null;
					document.getElementById("ReceiveList").style.width="200";
					
				}
			}
	
	}
	
	function moveOption(nDirection) {
		
		
	/*	var quickList=document.forms[0].ReceiveList;
			var temp;
			for(i=0; i<quickList.options.length; i++){
			if(quickList.options[i].selected)
			{
			alert(quickList.options[i].value+"  "+quickList.options[i-1].value);
			  temp=quickList.options[i];
			  quickList.options[i]=quickList.options[i-1];
			   quickList.options[i-1]=temp;
			}
			}
			*/
			if(document.forms[0].ReceiveList.selectedIndex==-1)
		{
		alert('<%=Function.getMultiLangItemContent("please.select.one",request)%>');
			return;
		}
			var select=document.forms[0].ReceiveList;
		    var nFrom=select.selectedIndex;
		    if(nFrom>=0){
				var nTo=nFrom;
				if(nDirection>0)
					nTo++;
				else if(nDirection<0)
					nTo--;
				if   (nTo!=nFrom&&nTo>=0&&nTo<select.length){
					select.options[nTo].swapNode(select.options[nFrom]);
				}
			}
	
	}
	
	function insertSign() {
		if(document.forms[0].ReceiveList.selectedIndex==-1)
		{
		alert('<%=Function.getMultiLangItemContent("please.select.one",request)%>');
			return;
		}
		var i;
		
			for(i=0; i<document.forms[0].ReceiveList.options.length; i++){
			//alert(document.forms[0].ReceiveList.options[i].selected.value);
				if(document.forms[0].ReceiveList.options[i].selected)
				{
				   if(i==0)
				   {
				   var item=tableForm.ReceiveList.options[i].value;	
					  if(item=='')
					   {
					  alert("<%=Function.getMultiLangItemContent("setquick.one.separator.allowed", request)%>");
					   }
					   else
					   {
							typeId=item.split(";");
							if(typeId[1]!=3)//本条记录不是分隔符
							{//去查上条记录是不是分隔符
							 	  var temp=new Option('────────────','',true,true);
							     document.forms[0].ReceiveList.add(temp,i);
							 }
							 else
							{
							alert("<%=Function.getMultiLangItemContent("setquick.one.separator.allowed", request)%>");
							}
						}

				   }
				   else{
					   var preItem=tableForm.ReceiveList.options[i-1].value;
					   var item=tableForm.ReceiveList.options[i].value;	
					  if(item=='')
					   {
					  alert("<%=Function.getMultiLangItemContent("setquick.one.separator.allowed", request)%>");
					   }
					   else
					   {
							typeId=item.split(";");
							if(typeId[1]!=3)//本条记录不是分隔符
							{//去查上条记录是不是分隔符
							     if(preItem=='')
									   {
									   alert("<%=Function.getMultiLangItemContent("setquick.one.separator.allowed", request)%>");
									   }
									   else
									   {
											preTypeId=preItem.split(";");
											if(preTypeId[1]!=3)//上条记录不是分隔符
											{
										 	var temp=new Option('────────────','',true,true);
											document.forms[0].ReceiveList.add(temp,i);
											}
											else
											{
											alert("<%=Function.getMultiLangItemContent("setquick.one.separator.allowed", request)%>");
											}
										}
							}
							else
							{
							alert("<%=Function.getMultiLangItemContent("setquick.one.separator.allowed", request)%>");
							}
						}			
					}
			
				}
			}
	
	}
		function del()
	{
	//opener.top.delQuick("logout");
	<c:forEach var="notify" items="${list}"  varStatus="status">
            alert("1: "+"${notify.LID}");
			parent.opener.top.delQuick("${notify.LID}");

     </c:forEach>
	}
	function addListCheck(revitem,lTypeId)
		{
			var strquickId;	
		    var flag=0;
			if(lTypeId==0)
			{
			  strquickId= applyTree.getSelectedDatabaseIdList().split(",");
			}
			else
			{
			strquickId= businessTree.getSelectedDatabaseIdList().split(",");
			}	
			var temp=new Array(strquickId.length);
			var list=revitem.split(";");
			
			for(var i=0;i<list.length;i++)
			{
			temp[i]=strquickId[i]+";"+lTypeId;
			   for(var j=0;j<tableForm.ReceiveList.options.length;j++)
			     {
			    // alert(tableForm.ReceiveList.options[j].value+"temp: "+temp[i]);
			     if(temp[i]==tableForm.ReceiveList.options[j].value)
			      flag=-1;  
			     }
			   //  alert(flag);
				if(flag==0)
				{
				document.forms[0].ReceiveList[document.forms[0].ReceiveList.length] = new Option(list[i],temp[i],true,true);
				}
				flag=0;
			}
		}
	
	function showModalBusinessDialogTree(tree, inputCtrlId,tdName,num)
{		    
	    var array = new Array(5);		    
	    array[0] = tree;
	    array[1] = inputCtrlId;
	    array[2] = window;	
	    array[3] = tdName;  
	    array[4] = num;	    
		window.showModalDialog("<%=request.getContextPath()%>/jsp/PersonalFirstPage/workbench/perference/quickTreeIframe.jsp", array, 'dialogWidth=360px;dialogHeight=400px;status:no;resizable:no;help:no;scroll:no');
}
 	 
function printBusinessTreeToNewWindow(tree, inputCtrlId,tdName,num)
{
		showModalBusinessDialogTree(tree, inputCtrlId,tdName,num);
}

function getSelectBusinessNum()
{
  var temp;
	var num=0;
	 for(var i=0;i<tableForm.ReceiveList.options.length;i++)
   {
		  temp=tableForm.ReceiveList.options[i].value; 
		 if((temp.substr(temp.length-1)==1))
            num++;  
  
   }
 return num;
}

function getSelectValue(){
	return document.getElementById("ReceiveList");
}
//password
function formVerrifyPasswd()
{
if(document.all.strOldPass.value == ""&&document.all.strNewPass.value == ""&&document.all.strConfirm.value == "")
{
 tableForm.IsModifyPasswd.value=0;
return true;
}
else
{
 tableForm.IsModifyPasswd.value=1;
    /*************输入项不能为空的验证************/
    if (document.all.strOldPass.value == "") {
		alert('<%=Function.getMultiLangItemContent("personalInfo.modpass.oldpass.notNull",request)%>');
		//document.all.strOldPass.focus();
		return false;
	}
	
	if (document.all.strNewPass.value == "") {
		alert('<%=Function.getMultiLangItemContent("personalInfo.modpass.newpass.notNull",request)%>');
		//document.all.strNewPass.focus();
		return false;
	}
		
	if (document.all.strConfirm.value == "") {
		alert("<%=Function.getMultiLangItemContent("personalInfo.modpass.confimpass.notNull",request)%>");
		//document.all.strConfirm.focus();
		return false;
	}
	
	var strOld = document.all.strOldPass.value;
	var strNew = document.all.strNewPass.value;
	var strConfirm  = document.all.strConfirm.value;
	
	if(strNew == strOld)
	{
	   alert('<%=Function.getMultiLangItemContent("PersonalInfoManager.ModifyPassword.password.repeat",request)%>');
	   //clsStr();	   
	   document.all.strNewPass.value="";
	   document.all.strConfirm.value="";
	  // document.all.strNewPass.focus();
	  return false;
	}		
	/****************两次输入密码相同的验证*************/
	if(strNew != strConfirm)
	{
	   alert('<%=Function.getMultiLangItemContent("PasswordConfirmError",request)%>');
	   clsStr();
	   //document.all.strConfirm.focus();
	  return false;
	}	
	}
	return true; 	
}


function clsStr(){
	var sk=document.all.strConfirm;
    sk.value='';    
}    
	function submitForm(){

	var count=0;

		for(var i=0;i<tableForm.ReceiveList.length;i++)
		{
		typeId=tableForm.ReceiveList.options[i].value.split(";");
		if(typeId[1]==1)
		  count++;
		}
		if(count>5)
		{
			alert("<%=Function.getMultiLangItemContent("businss.Select.Too.Many",request)%>");
			return;
		}
	
		for(var i=0;i<tableForm.ReceiveList.length;i++){
		tableForm.strQuickList.value +=tableForm.ReceiveList.options[i].value+"T";
		
		}
		
		tableForm.forward.value = "/jsp/PersonalFirstPage/workbench/perference/configHiddenSubmitIFrame.jsp";
		tableForm.action="<%=strContextPath%>/personalInfoModPicAction.do?method=submitPerference&forward="+tableForm.forward.value+"&strQuickList="+tableForm.strQuickList.value;
		tableForm.strQuickList.value="";
		 var ret = formVerrify();
		 var ret1=formVerrifyPasswd();
	    if(ret == true&&ret1 == true){  
	 	 tableForm.target = "configArea";
		tableForm.submit();
		
		}
	}
  </script>

</head>
<body bgcolor="FFFFFF" onLoad="loadInfo()" topmargin="0">
 <form enctype="multipart/form-data" name="tableForm" method="post" action="" >
      <input name="strServiceName" type="hidden" />
		<input name="strTransName" type="hidden" />
	
		<input name="forward" type="hidden" />
		
		<input name="lUserId" type="hidden" value="<c:out value='${LUSERID}' />" />
		<input name="strUserName" type="hidden" value="<c:out value='${STRUSERNAME}' />" />
		<input name="lTenantId" type="hidden" value="<c:out value='${LTENANTID}' />" />

		<input name="strPageId" type="hidden"  />
		<input name="IsModifyPic" type="hidden"  />
		<input name="lId" type="hidden" value="<c:out value='${LID}' />" />
		<input name="nMsgPosition" value="0" type="hidden" />
		<input name="nBulletinPosition" value="0" type="hidden" />
		<input name="nMedalPosition" value="0" type="hidden" />
		
		<input name="strQuickList" type="hidden"  />
<input name="strApplyId" type="hidden" value="<c:out value="${STRAPPLYID}" /><c:out value="${param.strApplyId}" />" />
<input name="strBusinessId" type="hidden" value="<c:out value="${STRBUSINESSID}" /><c:out value="${param.strBusinessId}" />" />
<input name="strQuickName" readonly type="hidden" class="box01" size="58" value="<c:out value="${STRQUICKNAME}"></c:out>" >
    <input name="nPWNeedChangeFlag" type="hidden" value="0" />
    <input name="nChangeLegalFormat1Flag" type="hidden" value="1" />
    <input name="nChangeLegalFormat2Flag" type="hidden" value="1" />
    <input name="IsModifyPasswd" type="hidden"  />
    
    
   <!-- <input name="nBulletinNums" type="hidden" value='5'  /> -->  
<div id="pic_setting" style="display:block">
<table width="100%"  border="0" cellpadding="5" cellspacing="0" bgcolor="#d5e2f3">
    <tr>
      <td><strong><%=Function.getMultiLangItemContent("personalInfo.upload.new.pic", request)%></strong></td>
    </tr>
  </table>
  <table width="100%"  border="0" cellpadding="3" cellspacing="1">
    <tr>
        <td align="center"><input name="binContent" type="file" class="inputBox" size="65" value="" onKeyDown="return false"/> </td>
      
    </tr>
  </table>
  <table width="100%" border="0" cellpadding="4" cellspacing="0">
    <tr>
      <td>&nbsp;</td>
      <td><span class="red"><b><%=Function.getMultiLangItemContent("ResultManager.pageHelp.Explain", request)%></b> <br>
        <%=Function.getMultiLangItemContent("personalInfo.page.common.uploadpic.gif", request)%><br>
       <%=Function.getMultiLangItemContent("personalInfo.page.common.uploadpic.size", request)%></span></td>
      </tr>
  </table>
</div>


<div id="display_setting" style="display:none">
<table width="100%" border="0" cellspacing="0" cellpadding="10">
  <tr>
    <td>
      <table width="100%" border="0" cellspacing="0" cellpadding="5">
        <tr>
         <td style="border-bottom:1px dashed #cccccc" >
		 <table border="0" cellpadding="3" cellspacing="1">
           <tr>
             <td width="160" align="right" ><strong><%=Function.getMultiLangItemContent("lable.order", request)%></strong></td>
            
             <td width="2" >&nbsp;</td>
             <td ><%=Function.getMultiLangItemContent("personalInfo.set.display.num", request)%>
                 <select name="nMedalNums" class="inputBox" style="width:60px">
					<option value="1" <c:if test='${NMEDALNUMS==1}'>selected</c:if>>1</option><option value="2" <c:if test='${NMEDALNUMS==2}'>selected</c:if>>2</option>
					<option value="3" <c:if test='${NMEDALNUMS==3}'>selected</c:if>>3</option><option value="4" <c:if test='${NMEDALNUMS==4}'>selected</c:if>>4</option>
					<option value="5" <c:if test='${NMEDALNUMS==5 ||NMEDALNUMS==null}'>selected</c:if>>5</option><option value="6" <c:if test='${NMEDALNUMS==6}'>selected</c:if>>6</option>
					<option value="7" <c:if test='${NMEDALNUMS==7}'>selected</c:if>>7</option><option value="8" <c:if test='${NMEDALNUMS==8}'>selected</c:if>>8</option>
					<option value="9" <c:if test='${NMEDALNUMS==9}'>selected</c:if>>9</option><option value="10" <c:if test='${NMEDALNUMS==10}'>selected</c:if>>10</option>
					</select></td>
           </tr>
         </table></td>
        </tr>
        <tr>
          <td style="border-bottom:1px dashed #cccccc" >
		  <table border="0" cellpadding="3" cellspacing="1">
            <tr>
              <td width="160" align="right" ><strong><%=Function.getMultiLangItemContent("ScheduleManager.Task", request)%></strong></td>
              
              <td width="2" >&nbsp;</td>
              <td ><%=Function.getMultiLangItemContent("personalInfo.set.display.num", request)%>
                  <select name="nTaskNums" class="inputBox" style="width:60px">
					<option value="1" <c:if test='${NTASKNUMS==1}'>selected</c:if>>1</option><option value="2" <c:if test='${NTASKNUMS==2}'>selected</c:if>>2</option>
					<option value="3" <c:if test='${NTASKNUMS==3}'>selected</c:if>>3</option><option value="4" <c:if test='${NTASKNUMS==4}'>selected</c:if>>4</option>
					<option value="5" <c:if test='${NTASKNUMS==5 ||NTASKNUMS==null}'>selected</c:if>>5</option><option value="6" <c:if test='${NTASKNUMS==6}'>selected</c:if>>6</option>
					<option value="7" <c:if test='${NTASKNUMS==7}'>selected</c:if>>7</option><option value="8" <c:if test='${NTASKNUMS==8}'>selected</c:if>>8</option>
					<option value="9" <c:if test='${NTASKNUMS==9}'>selected</c:if>>9</option><option value="10" <c:if test='${NTASKNUMS==10}'>selected</c:if>>10</option>
					</select></td>
            </tr>
          </table></td>
        </tr>
        <tr>
         <td style="border-bottom:1px dashed #cccccc" >
		 <table border="0" cellpadding="3" cellspacing="1">
           <tr>
             <td width="160" align="right"><strong><%=Function.getMultiLangItemContent("lable.msgManager", request)%></strong></td>
             
             <td width="2" >&nbsp;</td>
             <td ><%=Function.getMultiLangItemContent("personalInfo.set.display.num", request)%>
                 <select name="nMsgNums" class="inputBox" style="width:60px">
					<option value="1" <c:if test='${NMSGNUMS==1}'>selected</c:if>>1</option><option value="2" <c:if test='${NMSGNUMS==2}'>selected</c:if>>2</option>
					<option value="3" <c:if test='${NMSGNUMS==3}'>selected</c:if>>3</option><option value="4" <c:if test='${NMSGNUMS==4}'>selected</c:if>>4</option>
					<option value="5" <c:if test='${NMSGNUMS==5 ||NMSGNUMS==null}'>selected</c:if>>5</option><option value="6" <c:if test='${NMSGNUMS==6}'>selected</c:if>>6</option>
					<option value="7" <c:if test='${NMSGNUMS==7}'>selected</c:if>>7</option><option value="8" <c:if test='${NMSGNUMS==8}'>selected</c:if>>8</option>
					<option value="9" <c:if test='${NMSGNUMS==9}'>selected</c:if>>9</option><option value="10" <c:if test='${NMSGNUMS==10}'>selected</c:if>>10</option>
					</select></td>
           </tr>
         </table></td>
        </tr>
        <tr>
       <td style="border-bottom:1px dashed #cccccc" >
	   <table border="0" cellpadding="3" cellspacing="1">
         <tr>
           <td width="160" align="right"><strong><%=Function.getMultiLangItemContent("personalInfo.agent.Campaign", request)%></strong></td>
          
           <td width="2" >&nbsp;</td>
           <td ><%=Function.getMultiLangItemContent("personalInfo.set.display.num", request)%>
              <select name="nEventNums" class="inputBox" style="width:60px">
					<option value="1" <c:if test='${NEVENTNUMS==1}'>selected</c:if>>1</option><option value="2" <c:if test='${NEVENTNUMS==2}'>selected</c:if>>2</option>
					<option value="3" <c:if test='${NEVENTNUMS==3}'>selected</c:if>>3</option><option value="4" <c:if test='${NEVENTNUMS==4}'>selected</c:if>>4</option>
					<option value="5" <c:if test='${NEVENTNUMS==5 ||NEVENTNUMS==null}'>selected</c:if>>5</option><option value="6" <c:if test='${NEVENTNUMS==6}'>selected</c:if>>6</option>
					<option value="7" <c:if test='${NEVENTNUMS==7}'>selected</c:if>>7</option><option value="8" <c:if test='${NEVENTNUMS==8}'>selected</c:if>>8</option>
					<option value="9" <c:if test='${NEVENTNUMS==9}'>selected</c:if>>9</option><option value="10" <c:if test='${NEVENTNUMS==10}'>selected</c:if>>10</option>
					</select></td>
         </tr>
       </table></td>
        </tr>
        <tr>
          <td style="border-bottom:1px dashed #cccccc" >
		  <table border="0" cellpadding="3" cellspacing="1">
		  
            <tr>
              <td width="160" align="right"><strong><%=Function.getMultiLangItemContent("personalInfo.agent.Campaign2", request)%></strong></td>
              
              <td width="2" >&nbsp;</td>
              <td ><%=Function.getMultiLangItemContent("personalInfo.set.display.num", request)%>
                  <select name="nBulletinNums" class="inputBox" style="width:60px">		
		<option value="1" <c:if test='${NBULLETINNUMS==1}'>selected</c:if>>1</option><option value="2" <c:if test='${NBULLETINNUMS==2}'>selected</c:if>>2</option>
		<option value="3" <c:if test='${NBULLETINNUMS==3}'>selected</c:if>>3</option><option value="4" <c:if test='${NBULLETINNUMS==4}'>selected</c:if>>4</option>
		<option value="5" <c:if test='${NBULLETINNUMS==5||NBULLETINNUMS==null}'>selected</c:if>>5</option><option value="6" <c:if test='${NBULLETINNUMS==6}'>selected</c:if>>6</option>
		<option value="7" <c:if test='${NBULLETINNUMS==7}'>selected</c:if>>7</option><option value="8" <c:if test='${NBULLETINNUMS==8}'>selected</c:if>>8</option>
		<option value="9" <c:if test='${NBULLETINNUMS==9}'>selected</c:if>>9</option><option value="10" <c:if test='${NBULLETINNUMS==10}'>selected</c:if>>10</option>
		</select></td>
            </tr>
          </table></td>
        </tr>
      </table>
</td>
  </tr>
</table>
</div>

<div id="shortcut_setting" style="display:none">
<table  border="0" align="center" cellpadding="4" cellspacing="0">
    <tr>
      <td valign="top"><br><table width="100%"  border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td><%=Function.getMultiLangItemContent("setquick.QuickList", request)%></td>
          </tr>
        </table>
        <div id="ReceiveListDiv" style="width:210px;height:298px;overflow:auto;border:2px solid A2C1DF">
          <table width="200"  border="0" align="center" cellpadding="0" cellspacing="0">
            <tr>
              <td valign="top" height="270">
              <span style="position:absolute;margin:5px 5px 5px 5px;">
              <select name="ReceiveList" size="20"  id="ReceiveList" class='inputbox' style="margin:-3px;width:200px" >
            <c:forEach var="quick" items="${list}" >
             <c:set var="notifyName" value="${quick.STRNAME}" />
		    <%
		    String name=(String)pageContext.getAttribute("notifyName");
		    %>	
		     
		    <script>
		   
		    if("${quick.LTYPEID}"=="0")
			    {
			       if(parent.opener.top.isExistedPermission("${quick.STRPERMISSION}"))
			       {
			       document.write("<Option value=\"<c:out value="${quick.LQUICKID}"/>;<c:out value="${quick.LTYPEID}"/>\" > <c:if test="${quick.LQUICKID==0}">────────────</c:if><c:if test="${quick.LQUICKID!=0}"><%=Function.getMultiLangItemContent(name, request)%></c:if></option>");
          		  
			        }
			    }
			   
			    else
			    {
			     document.write("<Option value=\"<c:out value="${quick.LQUICKID}"/>;<c:out value="${quick.LTYPEID}"/>\" > <c:if test="${quick.LQUICKID==0}">────────────</c:if><c:if test="${quick.LQUICKID!=0}"><%=Function.getMultiLangItemContent(name, request)%></c:if></option>");
          		  
			  }
          		  
           </script>
               
            </c:forEach>
            
            </select>
            </span>
            
            </td>
            </tr>
        </table></div></td>
      <td align="center">
        <table  border="0" cellspacing="0" cellpadding="3">
          <tr>
            <td align="center"><input name="Submit3" type="button" class="addButton" value="<%=Function.getMultiLangItemContent("common.Add", request)%>" style="width:120px" onClick="printBusinessTreeToNewWindow(applyTree, 'strQuickName',businessTree)"></td>
          </tr>
          <tr>
            <td align="center"><input name="Submit22" type="button" class="delButton" value="<%=Function.getMultiLangItemContent("common.Delete", request)%>" style="width:120px" onClick="deleteQuick();"></td>
          </tr>
          <tr>
            <td height="50" align="center">&nbsp;</td>
          </tr>
          <tr>
            <td align="center"><input name="Submit22" type="button" class="button" value=" <%=Function.getMultiLangItemContent("common.Up", request)%> " style="width:120px" onClick="moveOption(-1)"></td>
          </tr>
          <tr>
            <td align="center"><input name="Submit222" type="button" class="button" value=" <%=Function.getMultiLangItemContent("common.Down", request)%> " style="width:120px" onClick="moveOption(1)"></td>
          </tr>
          <tr>
            <td align="center"><input name="Submit2222" type="button" class="button" value="<%=Function.getMultiLangItemContent("common.InsertSign", request)%>" style="width:120px" onClick="insertSign()"></td>
          </tr>
          </table></td>
    </tr>
  </table>
</div>

<div id="password_setting" style="display:none">
<table border="0" cellpadding="5" cellspacing="0">
              <tr>
                <td width="100" align="right"><div align="right"><font color="red">*</font><%=Function.getMultiLangItemContent("personalInfo.modpass.old",request)%></div><br><br></td>
                <td >
                    <INPUT id="strOldPass" name="strOldPassword"  type="password" class="inputbox" size="32"><br><br></td>
              </tr>
              <tr>
                <td align="right"><div align="right"><font color="red">*</font><%=Function.getMultiLangItemContent("personalInfo.modpass.new",request)%></div><br><br></td>
                <td ><input id='strNewPass' name="strPassword"  type="password" class="inputbox" size="32" >
               <!--  <%=Function.getMultiLangItemContent("personalInfo.modpass.disc",request)%>
                <br><br> --></td>
              </tr>              
              <tr>
                <td align="right"><div align="right"><font color="red">*</font><%=Function.getMultiLangItemContent("personalInfo.modpass.confirm",request)%></div><br><br></td>
                <td ><INPUT id="strConfirm" name="strConfirm"  type="password" class="inputbox" size="32"><br><br></td>
              </tr>
            </table>  
</div>

</form>

<iframe width="0" height="0" frameborder="0" id="configArea" name="configArea"  scrolling="no"></iframe>
</body>
	
 </html>
 
 <script>
var applyTree = new dTree('applyTree');
var businessTree = new dTree('businessTree');
	
   var strApplyId = tableForm.strApplyId.value;
	var idArray = strApplyId.split(",");
	    var flag = "false";		
	    
		applyTree.config.useControl = true;			
		applyTree.config.useCookies = true;			
		applyTree.config.controlType = 'checkbox';	
		applyTree.config.isCorrelateSelect = true;		
		applyTree.config.typeIdArrayName = 'selectedApplyId';	
		applyTree.config.correlateSelectType = 'node';	
		applyTree.config.isDelayBuild = true;	
		applyTree.add('0','-1','<%=Function.getMultiLangItemContent("setquick.system.view", request)%>', 'true', 'false', 'true',0);	        
		<c:forEach var="applyTreeNode" items="${applyList}" >				
		    flag = "false";
		    <c:set var="notifyName" value="${applyTreeNode.STRNAME}" />
		    
		    if ('<c:out value="${applyTreeNode.NTYPE}"/>' != 1) {	 	        
				for (var i=0;i<idArray.length;i++) {			   			
					if (idArray[i] =='<c:out value="${applyTreeNode.LID}"/>') {
						flag = "true";				
						break;
					}
				}
			}
			if(parent.opener.top.isExistedPermission("${applyTreeNode.STRPERMISSION}"))
			{
				applyTree.add('<c:out value="${applyTreeNode.LID}"/>',
					'<c:out value="${applyTreeNode.LPARENTID}"/>',
					'<%=Function.getMultiLangItemContent((String)pageContext.getAttribute("notifyName"), request)%>',
					'<c:if test="${applyTreeNode.NTYPE==1}">true</c:if>',
					flag,
					'<c:if test="${applyTreeNode.NCHECKED==1}">true</c:if>','false',0								
					);
					}
		</c:forEach>
	
	     var strBusinessId = tableForm.strBusinessId.value;
	    var idBusinessArray = strBusinessId.split(",");
	    var flag1 = "false";		
	    
		businessTree.config.useControl = true;			
		businessTree.config.useCookies = true;			
		businessTree.config.controlType = 'checkbox';	
		businessTree.config.isCorrelateSelect = true;		
		businessTree.config.typeIdArrayName = 'selectedBusinessId';	
		businessTree.config.correlateSelectType = 'node';
		businessTree.config.isDelayBuild = true;			
		businessTree.add('0','-1','<%=Function.getMultiLangItemContent("setquick.application.view", request)%>', 'true', 'false', 'true',0);
	      			
		<c:forEach var="businessTreeNode" items="${businessList}" >				
		    flag1 = "false";			    
		    if ('<c:out value="${businessTreeNode.NTYPE}"/>' == 1) {	 	        
				for (var i=0;i<idBusinessArray.length;i++) {						    		   			
					if (idBusinessArray[i] =='<c:out value="${businessTreeNode.LID}"/>') {
						flag1 = "true";				
						break;
					}
				}
			}
			
			businessTree.add('<c:out value="${businessTreeNode.LID}"/>',
				'<c:out value="${businessTreeNode.LPARENTID}"/>',
				'<c:out value="${businessTreeNode.STRNAME}"/>',
				'<c:if test="${businessTreeNode.NTYPE==1}">true</c:if>',
				flag1,
				'<c:if test="${businessTreeNode.NCHECKED==1}">true</c:if>','false',0								
				);
		</c:forEach>

</script>
   
  
