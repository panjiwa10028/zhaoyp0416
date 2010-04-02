<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>

<%@ include file="/jsp/common/header/include_init.jsp" %>
<%
/**
 * @author Fred
 * 
 */
response.setHeader("Pragma", "No-cache");
response.setDateHeader("Expires", 0);
response.setHeader("Cache-Control", "no-cache");
%> 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="<%=request.getContextPath()%>/css/style.css" rel="stylesheet" type="text/css">
<script language="JavaScript" type="text/JavaScript">
<!--
  var tmpTime;
  function loadInfo()
  {
      tmpTime=top.tempTimer;
      showTime();
  }
  function showTime()
  {   
      /*var hour=0;
      var hour1=0;
      var hour2=0;  
      var minute=0;      
      var minute1=0;
      var minute2=0;
      var second=0;
      var second1=0;
      var second2=0;*/
      
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
      }*/ 
      workNum.innerHTML=top.totalNumber;
      workAllTime.innerHTML=top.totalTimer;
      setTimeout("showTime()", 1500);
  }
//-->
</script>

<style type="text/css">
<!--
.style1 {
	color: #333333;
	font-weight: bold;
}
-->
</style>
</head>
<body oncontextmenu="return false;" onload="loadInfo()" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<input name="campaignState" type="hidden" />
<table id="__01" width="100%" height="100%" border="0" cellpadding="0" cellspacing="0">
<tr background="<%=request.getContextPath()%>/images/tree_image/bu_08.gif">
  <td height="36" colspan="3">
  	<table width="100%" height="100%" border="0" background="<%=request.getContextPath()%>/images/tree_image/bu_08.gif">
	  <tr>
		<td>
		<table width="100%" border="0">
		  <tr>
		  </tr>
		</table>
		</td>
	  </tr>
  </table>
  </td>
</tr>
<tr height="100%">
  <td background="<%=request.getContextPath()%>/images/tree_image/left_2.gif"><img src="<%=request.getContextPath()%>/images/tree_image/left_2.gif" width="8" height="100%" alt=""></td>
  <td width="191" height="100%" valign="top" background="<%=request.getContextPath()%>/images/tree_image/bu_11.gif">&nbsp<%=Function.getMultiLangItemContent("common.worktime", request)%>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<span id="workTime"></span>
  <BR>
  &nbsp<%=Function.getMultiLangItemContent("common.worknum", request)%>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<span id="workNum"></span>
  <BR>
  &nbsp<%=Function.getMultiLangItemContent("common.workalltime", request)%>&nbsp&nbsp<span id="workAllTime"></span>
  </td>
  <td background="<%=request.getContextPath()%>/images/tree_image/left_4.gif"><img src="<%=request.getContextPath()%>/images/tree_image/left_4.gif" width="9" height="100%" alt=""></td>
</tr>
<tr height="14">
  <td><img src="<%=request.getContextPath()%>/images/tree_image/bu_13.gif" width="8" height="100%" alt=""></td>
  <td><img src="<%=request.getContextPath()%>/images/tree_image/bu_14.gif" width="191" height="100%" alt=""></td>
  <td><img src="<%=request.getContextPath()%>/images/tree_image/bu_15.gif" width="9" height="100%" alt=""></td>
</tr>
</table>
</body>
</html>
