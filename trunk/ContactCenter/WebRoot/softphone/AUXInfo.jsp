<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.esoon.ezactor.contact.Function"%>
<%	String contextPath = request.getContextPath();%>

﻿<script language="JavaScript">
function submitt(){
	var obj=document.getElementsByName("content");  
	for(i=0;i<obj.length;i++){
	  	if(obj[i].checked){   
			//agentObj.offLineIndex=obj[i].value;
			agentObj.ifManualAUX=true;
			var reason = agentObj.offLineReasonList[i].split(":")[0];
          		changeAgentToNotReady(reason);
          		break;
	  	}
	}
	closeAUXBox();
}
</script>

<iframe id="q111" style="position:absolute; border-width:0px; top:0px; left:0px; width:0px; height:0px;z-index:100010; background-color:#ffffff;filter:alpha(Opacity=0);opacity:0"></iframe>
<div id="r44" style="position:absolute; display:none; top:0px; left:0px; width:0px; height:0px;z-index:100020; background-color:#ffffff;filter:alpha(Opacity=70);opacity:0.7"></div>
<div id="s33" style="position:absolute;  display:none; width:350px; height:150px;z-index:100030; background-color:#ffffff;border:1px solid #7191c1;table-layout:fixed; ">
<table width="100%" height="22" border="0" cellpadding="4" cellspacing="0" background="<%=contextPath%>/images/alert_image/drop3.gif" style="border-bottom:1px solid #e0edf6">
  <tr>
    <td><img src="<%=contextPath%>/images/alert_image/alertDot.gif" width="13" height="13" border="0" align="absmiddle"><%=Function.getMultiLangItemContent("softphone.alert", request)%></td>
    <td align="right" style="padding-right:8px"><img src="<%=contextPath%>/images/alert_image/tab_close2.gif" width="8" style="cursor:pointer" height="8" onMouseOver="this.src='<%=contextPath%>/images/alert_image/tab_close1.gif'" onMouseOut="this.src='<%=contextPath%>/images/alert_image/tab_close2.gif'" onClick="closeAUXBox()"></td>
  </tr>
</table>
	
	
<table width="330" height="94" border="0" ss cellpadding="5" cellspacing="0">
  <tr>
	    <td><div id="AUXDIV" style="display:none">
			<table width="100%" border="0" cellpadding="0" cellspacing="0" id='reasonList'>
				<tr>
	    			<td >
	    			</td>
				</tr>
			</table>
		</div></td>
    </tr>
</table>	
	
<table width="100%" height="32" border="0" cellpadding="5" cellspacing="0" bgcolor="ecf4fa">
  <tr>
    <td align="center">
		<input name="submit" type="button" class="button" value="<%=Function.getMultiLangItemContent("common.submit", request)%>" onClick="submitt();"> &nbsp;
		<input name="close"  type="button" class="button" value="<%=Function.getMultiLangItemContent("softphone.close", request)%>" onClick="closeAUXBox()">
    </td>
    </tr>
</table>	
</div>
