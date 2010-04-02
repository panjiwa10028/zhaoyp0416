<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>
<%@ include file="/jsp/common/header/include_init.jsp" %>

<html>
<head>

	<script src="<%=strContextPath%>/script/contactCommon/setStatus.js"></script>
	<link href="<%=request.getContextPath()%>/css/chrome.css" rel="stylesheet" type="text/css">
	<script src="<%=strContextPath%>/script/contactCommon/setStatus.js"></script>
	<script language="JavaScript" type="text/JavaScript">
	<!--
		function loadInfo(){
		
	if(strReturnInfo.value!="")
			{
				//parent.parent.refreshTreeNode();

				if(strReturnInfo.value.indexOf('personalInfo.modpass.newpassword.length.error') == 0 )
				{						
					parent.parent.setStatusBarInfo('<%=Function.getMultiLangItemContent("transactInfo", request)%>'+strMultiLangReturnInfo.value + "<%=""+(Integer)request.getAttribute("NPASSWORDLENGTH")%>", getMsgType());	//Chiou IPCC-201
				}
				else //if(strReturnInfo.value.indexOf('personalInfo.modpass.newpassword.format1.error') == 0 || strReturnInfo.value.indexOf('personalInfo.modpass.newpassword.format2.error') == 0)	
				{						
					parent.parent.setStatusBarInfo('<%=Function.getMultiLangItemContent("transactInfo", request)%>'+strMultiLangReturnInfo.value, getMsgType());	//Chiou IPCC-201
					
					//IPCC-118 clear input password fields in front page if reset database password successfully
					parent.tableForm.strOldPassword.value = '';
					parent.tableForm.strPassword.value = '';
					parent.tableForm.strConfirm.value = '';
										
				}							
				try{
				if(nReturnCode.value == 0)	
				{
					parent.personalInfoForm.nChangeLegalFormat1Flag.value = 1;
					parent.personalInfoForm.nChangeLegalFormat2Flag.value = 1;
				}
				}catch(e){}
			}
				//shortcut
				<%if (((Integer) (request.getAttribute("NRETURNCODE") == null?new Integer(-1):request.getAttribute("NRETURNCODE"))).intValue() == 0) {%>
				
				
					//picture and display
				parent.parent.opener.top.getWorkArea_noLeft().commonForm.submit();	
				
				<c:forEach var="oldnotify" items="${oldList}"  varStatus="status">
		            //alert("1: "+"${notify.LID}");
					parent.parent.opener.top.delQuick("${oldnotify.LID}");

	    		 </c:forEach>
	    		 parent.parent.opener.top.delQuick("logout");
					<c:forEach var="notify" items="${newList}"  varStatus="status">
							//parent.opener.top.delQuick("${notify.LID}");
							var temp="";
							var flag="<img src='' width='100%' height='1' style='background-color:#dadada'>";
							var image="<%=strContextPath%>/images/shortCut_09.gif";
						    if(	"${notify.STRNAME}"==null||"${notify.STRNAME}"=="")
						    {
						    temp=flag+"_|_"+"${notify.LID}"+"_|_"+"";
						    }
						    else
						    {	
						     <c:set var="notifyName" value="${notify.STRNAME}" />	
						       if("${notify.STRIMAGENAME}"!=null&&"${notify.STRIMAGENAME}"!="")
							    {
							    image="<%=strContextPath%>/images/<c:out value='${notify.STRIMAGENAME}'/>";
							    }
							 temp="<img src="+image+" border='0' valign='absMiddle'> "+"<%=Function.getMultiLangItemContent((String)pageContext.getAttribute("notifyName"), request)%>"+"_|_"+"${notify.LID}"+"_|_"+"showUrl('${notify.STRURL}','${notify.LTYPEID}','${notify.STRWIDTH}','${notify.STRHEIGHT}','${notify.STRNAME}','${notify.LQUICKID}')";
							
							 }
								if("${notify.LTYPEID}"=="0")
								    {
								       if(parent.parent.opener.top.isExistedPermission("${notify.STRPERMISSION}"))
								       {
											parent.parent.opener.top.addQuick(temp,"${notify.LID}");
										}
									}
									else
									{
									
										parent.parent.opener.top.addQuick(temp,"${notify.LID}");
									}
							
						
							                
	                </c:forEach>
	             image="<%=strContextPath%>/images/shortCut_08.gif";
      			 //var logout="<img src="+image+" border='0' valign='absMiddle'> "+"<%=Function.getMultiLangItemContent("setquick.Logout", request)%>"+"_|_"+"logout"+"_|_"+"logoutProduct()";
       			//parent.opener.top.addQuick(logout,0);        
			/*	try{

				parent.opener.top.getWorkArea_noLeft().location.reload();
				}catch(e)
				{
				
				
				}
				*/	
				if(parent.parent.commonTransForm.flag.value==1)
			{
			parent.parent.window.close();
			}	
				
			<%}%>
			
			
			
				
				
			
			
		}
	//-->
	</script> 

</head>
<body onLoad="loadInfo()">
	<input name="nReturnCode" type="hidden" value="<c:out value="${NRETURNCODE}" />" />
	<input name="strReturnInfo" type="hidden" value="<c:out value="${STRRETURNINFO}" />" />
	<input name="strMultiLangReturnInfo" type="hidden" value="<%=Function.getMultiLangItemContentExt((String)request.getAttribute("STRRETURNINFO"), request)%>" />
</body>
</html>