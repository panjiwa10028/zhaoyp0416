<%@ page  contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.Function" %>
<%@ page import="java.util.*"%>
<%@ include file="/jsp/common/header/include_init.jsp"%>

<html>
<head>
<title><%=Function.getMultiLangItemContent("Business.Title",request)%></title>
<style type="text/css">
<!--
body {
	background-color: black;
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.style1 {font-size: 12px}
-->
</style>

</head>

<body>


<%@ page import="java.io.*"%>
<html>
<head>
<meta name="GENERATOR" Content="Microsoft Visual Studio .NET 7.1">
</head>
<body>

<%
String songname="";
String lid=request.getParameter("lid");
String pageno=request.getParameter("pageno");
String url="";
//System.out.println(url);
try{

	String path = request.getContextPath();
	if(pageno==null)pageno="0";
    url=path+"/listenVoiceServlet?id="+lid+"&lPageno="+pageno;

}catch(Exception e)
{
	System.out.println("url:"+url);
	e.printStackTrace();
}


%>


<table width="100%" height="100%" border="0" align="center" cellpadding="0" cellspacing="1" >
  <tr>
    <td>
    <table width="100%" height="100%" border="0" cellspacing="0" cellpadding="0">    
     <tr>
          <td width="100%" height="30" valign="bottom">
          <table width="100%" border="0" cellspacing="1" cellpadding="3">
              <tr>
              <td style="background-color:black; height:30px; font-weight:fine; font-size:12px; padding-left:12px;"><span  style="color:#89a4ff"><%=Function.getMultiLangItemContent("CCM.VoiceMessages",request)%></span></td>
              <td><span class="style1"></span></td>
            </tr>
            </table>
		 </td>
		 </tr>    
        <tr>
          <td height="70" valign="bottom"><object classid="clsid:22D6F312-B0F6-11D0-94AB-0080C74C7E95" codebase="<%=url%>" type=application/x-oleobject width="400" height="70" align="absmiddle" standby = "Loading Microsoft Windows Media Player components..." id="NSPlay" > <param name="AudioStream" value="1">
              <param name="AutoSize" value="0">
              <param name="AutoStart" value="1">
              <param name="AnimationAtStart" value="1">
              <param name="AllowScan" value="1">
              <param name="AllowChangeDisplaySize" value="1">
              <param name="AutoRewind" value="0">
              <param name="Balance" value="0">
              <param name="BufferingTime" value="3">
              <param name="CaptioningID" value="">
              <param name="ClickToPlay" value="1">
              <param name="CursorType" value="0">
              <param name="CurrentPosition" value="1">
              <param name="CurrentMarker" value="0">
              <param name="DefaultFrame" value="">
              <param name="DisplayBackColor" value="0">
              <param name="DisplayForeColor" value="16777215">
              <param name="DisplayMode" value="0">
              <param name="DisplaySize" value="2">
              <param name="Enabled" value="1">
              <param name="EnableContextMenu" value="1">
              <param name="EnablePositionControls" value="1">
              <param name="EnableFullScreenControls" value="0">
              <param name="EnableTracker" value="1">
              <param name="Filename" value=" <%=url%>">
              <param name="InvokeURLs" value="1">
              <param name="Language" value="1">
              <param name="Mute" value="0">
              <param name="PlayCount" value="1">
              <param name="PreviewMode" value="0">
              <param name="Rate" value="1">
              <param name="SAMILang" value="">
              <param name="SAMIStyle" value="">
              <param name="SAMIFileName" value="">
              <param name="SelectionStart" value="1">
              <param name="SelectionEnd" value="-1">
              <param name="SendOpenStateChangeEvents" value="1">
              <param name="SendWarningEvents" value="1">
              <param name="SendErrorEvents" value="1">
              <param name="SendKeyboardEvents" value="1">
              <param name="SendMouseClickEvents" value="1">
              <param name="SendMouseMoveEvents" value="1">
              <param name="SendPlayStateChangeEvents" value="1">
              <param name="ShowCaptioning" value="0">
              <param name="ShowControls" value="1">
              <param name="ShowAudioControls" value="1">
              <param name="ShowDisplay" value="0">
              <param name="ShowGotoBar" value="0">
              <param name="ShowPositionControls" value="1">
              <param name="ShowStatusBar" value="1">
              <param name="ShowTracker" value="1">
              <param name="TransparentAtStart" value="0">
              <param name="VideoBorderWidth" value="0">
              <param name="VideoBorderColor" value="0">
              <param name="VideoBorder3D" value="0">
              <param name="Volume" value="-600">
              <param name="WindowlessVideo" value="0">
            </object></td>
        </tr>
        
        </table>
    </td>
  </tr>
</table>
</body>
</html>
