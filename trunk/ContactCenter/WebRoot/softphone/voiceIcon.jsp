<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="java.util.ResourceBundle,java.util.Locale" %>
<%
	ResourceBundle bundle = null;    
	Locale locale = new Locale(request.getLocale().getLanguage(), request.getLocale().getCountry(), request.getLocale().getVariant());
	try{
		bundle = ResourceBundle.getBundle("functionkey",locale);
	}
	catch(Exception e){
		bundle = ResourceBundle.getBundle("functionkey",Locale.ENGLISH);
	}
	String[] strPhone = new String[7];
	String[] strPhoneSpec = new String[7];
	String[] strFunc = new String[5];
	String[] strFuncType = new String[5];
	String[] strFuncSpec = new String[5];
	String strTemp = "";
	try{
		if(bundle!=null){
			for(int ii=0;ii<7;ii++){
				strPhone[ii] = "";
				strPhoneSpec[ii] = "";
				strTemp = bundle.getString("cti.phone"+(ii+1));
				if(strTemp!=null && !strTemp.equals("null"))
					strPhone[ii] = strTemp;
				strTemp = bundle.getString("cti.phone"+(ii+1)+"Spec");
				if(strTemp!=null && !strTemp.equals("null"))
					strPhoneSpec[ii] = strTemp;
			}
			for(int jj=0;jj<5;jj++){
				strFunc[jj] = "";
				strFuncType[jj] = "";
				strFuncSpec[jj] = "";
				strTemp = bundle.getString("cti.func"+(jj+1));
				if(strTemp!=null && !strTemp.equals("null"))
					strFunc[jj] = strTemp;
				strTemp = bundle.getString("cti.func"+(jj+1)+"Type");
				if(strTemp!=null && !strTemp.equals("null"))
					strFuncType[jj] = strTemp;
				strTemp = bundle.getString("cti.func"+(jj+1)+"Spec");
				if(strTemp!=null && !strTemp.equals("null"))
					strFuncSpec[jj] = strTemp;
			}
		}
	}catch(Exception e){}
%>
<link href="<%=contextPath%>/softphone/css/softphone.css" rel="stylesheet" type="text/css">
<div id="toolTipLayer" style="position:absolute; visibility: hidden"></div>
<script language="javascript" type="text/javascript">
	tips_map.put("ivrImage",			"<%=com.esoon.EZActor.BusinessCenter.Function.getMultiLangItemContent("softphone.ivr", request)%>");
	tips_map.put("lineOneImage",		"<%=com.esoon.EZActor.BusinessCenter.Function.getMultiLangItemContent("softphone.lineone", request)%>");
	tips_map.put("lineTwoImage",		"<%=com.esoon.EZActor.BusinessCenter.Function.getMultiLangItemContent("softphone.linetwo", request)%>");
	tips_map.put("lineThreeImage",		"<%=com.esoon.EZActor.BusinessCenter.Function.getMultiLangItemContent("softphone.linethr", request)%>");
	tips_map.put("keypadImage",			"<%=com.esoon.EZActor.BusinessCenter.Function.getMultiLangItemContent("softphone.keyboard", request)%>");
	tips_map.put("holdImage",			"<%=com.esoon.EZActor.BusinessCenter.Function.getMultiLangItemContent("softphone.hold", request)%>");
	tips_map.put("transferImage",		"<%=com.esoon.EZActor.BusinessCenter.Function.getMultiLangItemContent("softphone.transfer", request)%>");
	tips_map.put("conferenceImage",		"<%=com.esoon.EZActor.BusinessCenter.Function.getMultiLangItemContent("softphone.conference", request)%>");
	tips_map.put("chatImage",			"<%=com.esoon.EZActor.BusinessCenter.Function.getMultiLangItemContent("softphone.chat", request)%>");
	tips_map.put("mailinImage",			"<%=com.esoon.EZActor.BusinessCenter.Function.getMultiLangItemContent("softphone.email", request)%>");
	tips_map.put("newEmailImage",		"<%=com.esoon.EZActor.BusinessCenter.Function.getMultiLangItemContent("softphone.newEmail", request)%>");
	tips_map.put("workbinEmailImage",	"<%=com.esoon.EZActor.BusinessCenter.Function.getMultiLangItemContent("softphone.workbin", request)%>");
	tips_map.put("cobrowseImage",		"<%=com.esoon.EZActor.BusinessCenter.Function.getMultiLangItemContent("softphone.cobrowse", request)%>");	
	tips_map.put("callMeBackImage",		"<%=com.esoon.EZActor.BusinessCenter.Function.getMultiLangItemContent("softphone.callback", request)%>");
	tips_map.put("dialImage_enabled",	"<%=com.esoon.EZActor.BusinessCenter.Function.getMultiLangItemContent("softphone.call", request)%>");
	tips_map.put("dialImage_ringing",	"<%=com.esoon.EZActor.BusinessCenter.Function.getMultiLangItemContent("softphone.ringing", request)%>");
	//tips_map.put("dialImage_dialing",	"<%=com.esoon.EZActor.BusinessCenter.Function.getMultiLangItemContent("softphone.dialing", request)%>");
	tips_map.put("disconImage_hangup",	"<%=com.esoon.EZActor.BusinessCenter.Function.getMultiLangItemContent("softphone.hangup", request)%>");
	tips_map.put("disconImage_refuse",	"<%=com.esoon.EZActor.BusinessCenter.Function.getMultiLangItemContent("softphone.refuse", request)%>");
	tips_map.put("softkeyA",			"<%=com.esoon.EZActor.BusinessCenter.Function.getMultiLangItemContent("softphone.backspace", request)%>");
	tips_map.put("softkeyB",			"<%=com.esoon.EZActor.BusinessCenter.Function.getMultiLangItemContent("softphone.clear", request)%>");
	tips_map.put("softkeyC",			"<%=com.esoon.EZActor.BusinessCenter.Function.getMultiLangItemContent("softphone.redial", request)%>");
	tips_map.put("softkeyD",			"<%=com.esoon.EZActor.BusinessCenter.Function.getMultiLangItemContent("softphone.call", request)%>");
	tip_style = document.getElementById(tip_div_Id).style;
	
	var popKeyBoxTimer = null;
	function showKeyBoxByPop(){
		if(document.getElementById("softKeyBoardDiv").style.display == "none"){
			document.getElementById("softKeyBoardDiv").style.top="55px";
			popKeyBoxTimer = setTimeout("popKeyBox()",100);
			showHideDiv('softKeyBoardDiv');showHideDiv('softPhonePadFrame');
		}else{
			document.getElementById("softKeyBoardDiv").style.top=(parseInt(document.getElementById("softKeyBoardDiv").style.top)-100)+"px";
			showHideDiv('softKeyBoardDiv');showHideDiv('softPhonePadFrame');
		}
	}
	
	function popKeyBox(){
		document.getElementById("softKeyBoardDiv").style.top=(parseInt(document.getElementById("softKeyBoardDiv").style.top)+100)+"px";
		//document.getElementById("softPhonePadFrame").style.top=(parseInt(document.getElementById("softPhonePadFrame").style.top)+100)+"px";
		if(popKeyBoxTimer != null){ window.clearTimeout(popKeyBoxTimer);popKeyBoxTimer = null; }
	}
</script>
<div id="softPhoneDiv">
<!-- div style="position:absolute;left:500px;top: 100px;display:;">
       
</div> -->
<table width="100%" height="57" border="0" cellpadding="0" cellspacing="0">
	<tr height="10">
          <td>&nbsp;</td>
    </tr>
    <tr>
      <td width="60" align="right"><table width="100%" border="0" cellpadding="1" cellspacing="0">
        <tr>
          <td>
          	<!--<input type="image" name="lineOneImage" id="lineOneImage" src="<%=contextPath%>/images/cti_image/lineOne_Off_1.gif" width="43" height="14" border="0" align="absmiddle" style="cursor:not-allowed" onMouseMove="setTipShow(this.id)" onMouseOut="hideTips()" onclick="webMouseClick(this.name);changeLineStatus(this.name)" onFocus="this.blur()" disabled>-->
          	<div id="lineOneImage" class="lineOneImage_off_disabled"
          			onMouseMove="setTipShow(this.id)" 
          			onMouseOut="hideTips()" 
          			onClick="webMouseClick(this.id);changeLineStatus(this.id)" disabled></div>
          </td>
        </tr>
        <tr height="5">
	          <td>&nbsp;</td>
	    </tr>
        <tr>
          <td>
          	<!--<input type="image" name="lineTwoImage" id="lineTwoImage" src="<%=contextPath%>/images/cti_image/lineTwo_Off_1.gif" width="43" height="14"  border="0" align="absmiddle" style="cursor:not-allowed" onMouseMove="setTipShow(this.id)" onMouseOut="hideTips()" onclick="webMouseClick(this.name);changeLineStatus(this.name)" onFocus="this.blur()" disabled>-->
          	<div id="lineTwoImage" class="lineTwoImage_off_disabled"
          			onMouseMove="setTipShow(this.id)" 
          			onMouseOut="hideTips()" 
          			onClick="webMouseClick(this.id);changeLineStatus(this.id)" disabled></div>
          </td>
          </tr>
          <tr height="5">
	          <td>&nbsp;</td>
	    </tr>
        <tr>
          <td>
          	<!--<input type="image" name="lineThreeImage" id="lineThreeImage" src="<%=contextPath%>/images/cti_image/lineThree_Off_1.gif" width="43" height="14" border="0" align="absmiddle" style="cursor:not-allowed" onMouseMove="setTipShow(this.id)" onMouseOut="hideTips()" onclick="webMouseClick(this.name);changeLineStatus(this.name)" onFocus="this.blur()" disabled>-->
          	<div id="lineThreeImage" class="lineThreeImage_off_disabled"
          			onMouseMove="setTipShow(this.id)" 
          			onMouseOut="hideTips()" 
          			onClick="webMouseClick(this.id);changeLineStatus(this.id)" disabled></div>
          </td>
          </tr>
      </table></td>
      <td width="10">&nbsp;</td>
      <td width="334" background="<%=contextPath%>/images/cti_image/Top_toolbarM_bg.jpg">
		  <table width="334" height="135" border="0" cellpadding="0" cellspacing="0">
		  	<tr align="right">
			  <td height="16" valign="top">
                <span id="statWord"> <span class="statWord" id="lineStatusDiv"></span></span></td>
			  <td align="right" class="nobreak">
			  	<span class="statWord"><div id="timerLineOne"></div><div id="timerLineTwo" style="display:none"></div><div id="timerLineThr" style="display:none"></div></span></td>
			</tr>
			<tr align="center">
			  <td height="70" colspan="2" valign="center">
			  	<input name="numberBox" id="phoneNumber" type="text" class="phoneNumberBox" value="" maxlength="20" onkeypress="verifyNum(this);" onkeydown="dial()">
			  </td>
			</tr>
			<tr><td colspan="2" align="right"> 
			<table border="0" cellspacing="0" cellpadding="0">
			<tr align="right">
	          <td>
	          	<!--<input type="image" name="holdImage" id="holdImage" accessKey="3" src="<%=contextPath%>/images/cti_image/hold_disabled.gif" width="34" height="34" style="cursor:not-allowed" onFocus="this.blur()" onMouseOver="this.src='<%=contextPath%>/images/cti_image/hold_over.gif'" onMouseOut="this.src='<%=contextPath%>/images/cti_image/hold_enabled.gif';hideTips()" onMouseUp="this.src='<%=contextPath%>/images/cti_image/hold_over.gif'" onMouseDown="this.src='<%=contextPath%>/images/cti_image/hold_down.gif'" onMouseMove="setTipShow(this.id)" onclick="webMouseClick(this.name);" disabled>-->
	          	<div id="holdImage" class="holdImage_disabled" 
					 	onMouseOver="this.className='holdImage_over'"
						onMouseDown="this.className='holdImage_down'"  
						onMouseUp="this.className='holdImage_over'" 
						onMouseOut="this.className='holdImage_enabled';hideTips()"
						onMouseMove="setTipShow(this.id)"
						onclick="webMouseClick(this.id);" disabled></div>
	          </td>
	          <td>
	          	<!--<input type="image" name="transferImage" id="transferImage" accessKey="4" src="<%=contextPath%>/images/cti_image/transfer_disabled.gif" width="31" height="34" style="cursor:not-allowed" onFocus="this.blur()" onMouseOver="this.src='<%=contextPath%>/images/cti_image/transfer_over.gif'" onMouseOut="this.src='<%=contextPath%>/images/cti_image/transfer_enabled.gif';hideTips()" onMouseUp="this.src='<%=contextPath%>/images/cti_image/transfer_over.gif'"  onMouseDown="this.src='<%=contextPath%>/images/cti_image/transfer_down.gif'" onMouseMove="setTipShow(this.id)" onclick="webMouseClick(this.name);" disabled>-->
	          	<div id="transferImage" class="transferImage_disabled" 
						onMouseOver="this.className='transferImage_over'"
						onMouseDown="this.className='transferImage_down'"  
						onMouseUp="this.className='transferImage_over'" 
						onMouseOut="this.className='transferImage_enabled';hideTips()"
						onMouseMove="setTipShow(this.id)"
						onclick="webMouseClick(this.id);" disabled></div>
	          </td>
	          <td>
	          	<!--<input type="image" name="conferenceImage" id="conferenceImage" accessKey="5" src="<%=contextPath%>/images/cti_image/conference_disabled.gif" width="31" height="34" style="cursor:not-allowed" onFocus="this.blur()" onMouseOver="this.src='<%=contextPath%>/images/cti_image/conference_over.gif'" onMouseOut="this.src='<%=contextPath%>/images/cti_image/conference_enabled.gif';hideTips()" onMouseUp="this.src='<%=contextPath%>/images/cti_image/conference_over.gif'"  onMouseDown="this.src='<%=contextPath%>/images/cti_image/conference_down.gif'" onMouseMove="setTipShow(this.id)" onclick="webMouseClick(this.name);" disabled>-->
	          	<div id="conferenceImage" class="conferenceImage_disabled" 
						onMouseOver="this.className='conferenceImage_over'"
						onMouseDown="this.className='conferenceImage_down'"  
						onMouseUp="this.className='conferenceImage_over'" 
						onMouseOut="this.className='conferenceImage_enabled';hideTips()"
						onMouseMove="setTipShow(this.id)"
						onclick="webMouseClick(this.id);" disabled></div>
	          </td>
	          <td>
	          	<!--<input type="image" name="ivrImage" id="ivrImage" accessKey="6" src="<%=contextPath%>/images/cti_image/ivr_disabled.gif" width="32" height="34" style="cursor:not-allowed" onFocus="this.blur()" onMouseOver="this.src='<%=contextPath%>/images/cti_image/ivr_over.gif'" onMouseOut="this.src='<%=contextPath%>/images/cti_image/ivr_enabled.gif';hideTips()" onMouseUp="this.src='<%=contextPath%>/images/cti_image/ivr_over.gif'"  onMouseDown="this.src='<%=contextPath%>/images/cti_image/ivr_down.gif'" onMouseMove="setTipShow(this.id)" onclick="webMouseClick(this.name);" disabled>-->
	          	<div id="ivrImage" class="ivrImage_disabled" 
						onMouseOver="this.className='ivrImage_over'"
						onMouseDown="this.className='ivrImage_down'"  
						onMouseUp="this.className='ivrImage_over'" 
						onMouseOut="this.className='ivrImage_enabled';hideTips()"
						onMouseMove="setTipShow(this.id)"
						onclick="webMouseClick(this.id);" disabled></div>
	          </td>
	        </tr> 
      		</table>
	        </td></tr>
		  </table>
	  </td>
      <td width="90"><table width="50" border="0" align="center" cellpadding="0" cellspacing="0">
        <tr>
          <td align="center" height="40">
          	<!--<input type="image" name="dialImage" id="dialImage" accessKey="1" src="<%=contextPath%>/images/cti_image/dial_disabled.gif" width="43" height="44" style="cursor:not-allowed" onFocus="this.blur()" onMouseOver="webMouseOver(this.name)" onMouseOut="webMouseOut(this.name);hideTips()" onMouseUp="webMouseUp(this.name)"  onMouseDown="webMouseDown(this.name)" onMouseMove="setTipShow(this.id)" onclick="webMouseClick(this.name);" disabled>-->
			<div id="dialImage" class="dialImage_disabled" 
					onMouseOver="webMouseOver(this.id)"
					onMouseDown="webMouseDown(this.id)"  
					onMouseUp="webMouseUp(this.id)" 
					onMouseOut="webMouseOut(this.id);hideTips()"
					onMouseMove="setTipShow(this.id)"
					onclick="webMouseClick(this.id);"></div>
          </td>
        </tr>
        <tr>
          <td align="center" height="40">
          	<!--<input type="image" name="disconImage" id="disconImage" accessKey="2" src="<%=contextPath%>/images/cti_image/discon_disabled.gif" width="37" height="44" style="cursor:not-allowed" onFocus="this.blur()" onMouseOver="this.src='<%=contextPath%>/images/cti_image/discon_over.gif'" onMouseOut="webMouseOut(this.name);hideTips()" onMouseUp="this.src='<%=contextPath%>/images/cti_image/discon_over.gif'" onMouseDown="this.src='<%=contextPath%>/images/cti_image/discon_down.gif'" onMouseMove="setTipShow(this.id)" onclick="webMouseClick(this.name);" disabled>-->
          	<div id="disconImage" class="disconImage_disabled" 
					onMouseOver="webMouseOver(this.id)"
					onMouseDown="this.className='disconImage_down'"  
					onMouseUp="this.className='disconImage_over'" 
					onMouseOut="this.className='disconImage_enabled';hideTips()"
					onMouseMove="setTipShow(this.id)"
					onclick="webMouseClick(this.id);" disabled></div>
          </td>
        </tr>
        <tr>
	      <td width="52" align="center" height="40">
	      	<!--<input type="image" id="keypadImage" src="<%=contextPath%>/images/cti_image/keyboard_disabled.gif" width="37" height="37"  style="cursor:not-allowed" onMouseOver="this.src='<%=contextPath%>/images/cti_image/keyboard_over.gif'" onMouseOut="this.src='<%=contextPath%>/images/cti_image/keyboard_enabled.gif';hideTips()" onMouseUp="this.src='<%=contextPath%>/images/cti_image/keyboard_over.gif'"  onMouseDown="this.src='<%=contextPath%>/images/cti_image/keyboard_down.gif'" onMouseMove="setTipShow(this.id)" onClick="showHideDiv('softKeyBoardDiv');showHideDiv('softPhonePadFrame');" onFocus="this.blur()" disabled>-->
	      	<div id="keypadImage" class="keypadImage_disabled" 
						onMouseOver="this.className='keypadImage_over'"
						onMouseDown="this.className='keypadImage_down'"  
						onMouseUp="this.className='keypadImage_over'" 
						onMouseOut="this.className='keypadImage_enabled';hideTips()"
						onMouseMove="setTipShow(this.id)"
						onClick="showKeyBoxByPop();" disabled></div>
	      </td>
        </tr>
      </table></td>
        </tr>
        <tr>
        <td>
        
        
        </td>
      <td>&nbsp;</td>
      </tr>
  </table>
</div>
<iframe id="softPhonePadFrame" style="display:none" frameborder="no"></iframe>
<div id="softKeyBoardDiv" style="display:none">
<table border="0" width="485" height="203" cellpadding="0" cellspacing="0">
	<tr>
	  <td width="52" nowrap align="right"><table width="32" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td ><img id="softKeyImg" src="<%=contextPath%>/images/keypad_image/SZJP_tab1_current.gif" width="32" height="43" class="pointer" alt="<%=com.esoon.EZActor.BusinessCenter.Function.getMultiLangItemContent("softphone.keyboard", request)%>" onClick="changeSoftKeyBoard('softKey')"></td>
        </tr>
        <tr>
          <td ><img id="hisAddImg" src="<%=contextPath%>/images/keypad_image/SZJP_tab2_normal.gif" width="32" height="43" border="0" class="pointer" alt="<%=com.esoon.EZActor.BusinessCenter.Function.getMultiLangItemContent("softphone.callhistory", request)%>" onClick="changeSoftKeyBoard('callHis')"></td>
        </tr>
        <tr>
          <td><img id="AddImg" src="<%=contextPath%>/images/keypad_image/SZJP_tab3_normal.gif" width="32" height="43" border="0" class="pointer" alt="<%=com.esoon.EZActor.BusinessCenter.Function.getMultiLangItemContent("softphone.address", request)%>" onClick="changeSoftKeyBoard('address')"></td>
        </tr>
        <tr>
          <td ></td>
        </tr>
      </table></td>
      <td width="406" valign="top" ><table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td height="12" colspan="2" ></td>
        </tr>
      </table>
        <div id="softKeyBoard">
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
          <tr>
            <td><table border="0" cellpadding="0" cellspacing="2">
                <tr>
                  <td width="55" height="39" id="softkey1" class="skBig" onMouseOut="this.className='skBig'" onMouseOver="this.className='skBigOver'" onMouseDown="this.className='skBigDown'" onMouseUp="this.className='skBigOver'">1<div style="position:absolute; margin-left:-34px; margin-top:-4px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="55" height="39" border="0" align="absmiddle" onClick="inputNumber('1')"></div></td>
                  <td width="55" height="39" id="softkey2" class="skBig" onMouseOut="this.className='skBig'" onMouseOver="this.className='skBigOver'" onMouseDown="this.className='skBigDown'" onMouseUp="this.className='skBigOver'">2<div style="position:absolute; margin-left:-34px; margin-top:-4px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="55" height="39" border="0" align="absmiddle" onClick="inputNumber('2')"></div></td>
                  <td width="55" height="39" id="softkey3" class="skBig" onMouseOut="this.className='skBig'" onMouseOver="this.className='skBigOver'" onMouseDown="this.className='skBigDown'" onMouseUp="this.className='skBigOver'">3<div style="position:absolute; margin-left:-34px; margin-top:-4px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="55" height="39" border="0" align="absmiddle" onClick="inputNumber('3')"></div></td>
                  <td width="55" height="39"><img src="<%=contextPath%>/images/keypad_image/SZJP_button1_01a.gif" id="softkeyA" name="softkeyA" width="55" height="39" border="0" class="softkeyA_class" onMouseOver="this.src='<%=contextPath%>/images/keypad_image/SZJP_button1_01b.gif'" onMouseOut="this.src='<%=contextPath%>/images/keypad_image/SZJP_button1_01a.gif';hideTips()" onMouseDown="this.src='<%=contextPath%>/images/keypad_image/SZJP_button1_01c.gif'" onMouseUp="this.src='<%=contextPath%>/images/keypad_image/SZJP_button1_01b.gif'" onMouseMove="setTipShow(this.id)" onclick="backSpace()"></td>
                </tr>
                <tr>
                  <td width="55" height="39" id="softkey4" class="skBig" onMouseOut="this.className='skBig'" onMouseOver="this.className='skBigOver'" onMouseDown="this.className='skBigDown'" onMouseUp="this.className='skBigOver'">4<div style="position:absolute; margin-left:-34px; margin-top:-4px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="55" height="39" border="0" align="absmiddle" onClick="inputNumber('4')"></div></td>
                  <td width="55" height="39" id="softkey5" class="skBig" onMouseOut="this.className='skBig'" onMouseOver="this.className='skBigOver'" onMouseDown="this.className='skBigDown'" onMouseUp="this.className='skBigOver'">5<div style="position:absolute; margin-left:-34px; margin-top:-4px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="55" height="39" border="0" align="absmiddle" onClick="inputNumber('5')"></div></td>
                  <td width="55" height="39" id="softkey6" class="skBig" onMouseOut="this.className='skBig'" onMouseOver="this.className='skBigOver'" onMouseDown="this.className='skBigDown'" onMouseUp="this.className='skBigOver'">6<div style="position:absolute; margin-left:-34px; margin-top:-4px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="55" height="39" border="0" align="absmiddle" onClick="inputNumber('6')"></div></td>
                  <td width="55" height="39"><img src="<%=contextPath%>/images/keypad_image/SZJP_button1_02a.gif" id="softkeyB" name="softkeyB" width="55" height="39" border="0" class="softkeyB_class" onMouseOver="this.src='<%=contextPath%>/images/keypad_image/SZJP_button1_02b.gif'" onMouseOut="this.src='<%=contextPath%>/images/keypad_image/SZJP_button1_02a.gif';hideTips()" onMouseDown="this.src='<%=contextPath%>/images/keypad_image/SZJP_button1_02c.gif'" onMouseUp="this.src='<%=contextPath%>/images/keypad_image/SZJP_button1_02b.gif'" onMouseMove="setTipShow(this.id)" onclick="clearInput()"></td>
                </tr>
                <tr>
                  <td width="55" height="39" id="softkey7" class="skBig" onMouseOut="this.className='skBig'" onMouseOver="this.className='skBigOver'" onMouseDown="this.className='skBigDown'" onMouseUp="this.className='skBigOver'">7<div style="position:absolute; margin-left:-34px; margin-top:-4px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="55" height="39" border="0" align="absmiddle" onClick="inputNumber('7')"></div></td>
                  <td width="55" height="39" id="softkey8" class="skBig" onMouseOut="this.className='skBig'" onMouseOver="this.className='skBigOver'" onMouseDown="this.className='skBigDown'" onMouseUp="this.className='skBigOver'">8<div style="position:absolute; margin-left:-34px; margin-top:-4px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="55" height="39" border="0" align="absmiddle" onClick="inputNumber('8')"></div></td>
                  <td width="55" height="39" id="softkey9" class="skBig" onMouseOut="this.className='skBig'" onMouseOver="this.className='skBigOver'" onMouseDown="this.className='skBigDown'" onMouseUp="this.className='skBigOver'">9<div style="position:absolute; margin-left:-34px; margin-top:-4px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="55" height="39" border="0" align="absmiddle" onClick="inputNumber('9')"></div></td>
                  <td width="55" height="39"><img src="<%=contextPath%>/images/keypad_image/SZJP_button1_03a.gif" id="softkeyC" name="softkeyC" width="55" height="39" border="0" class="softkeyC_class" onMouseOver="this.src='<%=contextPath%>/images/keypad_image/SZJP_button1_03b.gif'" onMouseOut="this.src='<%=contextPath%>/images/keypad_image/SZJP_button1_03a.gif';hideTips()" onMouseDown="this.src='<%=contextPath%>/images/keypad_image/SZJP_button1_03c.gif'" onMouseUp="this.src='<%=contextPath%>/images/keypad_image/SZJP_button1_03b.gif'" onMouseMove="setTipShow(this.id)" onclick="reDial()"></td>
                </tr>
                <tr>
                  <td width="55" height="39" id="softkeyx" class="skBig" onMouseOut="this.className='skBig'" onMouseOver="this.className='skBigOver'" onMouseDown="this.className='skBigDown'" onMouseUp="this.className='skBigOver'">*<div style="position:absolute; margin-left:-34px; margin-top:-4px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="55" height="39" border="0" align="absmiddle" onClick="inputNumber('*')"></div></td>
                  <td width="55" height="39" id="softkey0" class="skBig" onMouseOut="this.className='skBig'" onMouseOver="this.className='skBigOver'" onMouseDown="this.className='skBigDown'" onMouseUp="this.className='skBigOver'">0<div style="position:absolute; margin-left:-34px; margin-top:-4px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="55" height="39" border="0" align="absmiddle" onClick="inputNumber('0')"></div></td>
                  <td width="55" height="39" id="softkeyz" class="skBig" onMouseOut="this.className='skBig'" onMouseOver="this.className='skBigOver'" onMouseDown="this.className='skBigDown'" onMouseUp="this.className='skBigOver'">#<div style="position:absolute; margin-left:-34px; margin-top:-4px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="55" height="39" border="0" align="absmiddle" onClick="inputNumber('#')"></div></td>
                  <td width="55" height="39"><img src="<%=contextPath%>/images/keypad_image/SZJP_button1_04a.gif" id="softkeyD" name="softkeyD" width="55" height="39" border="0" class="softkeyD_class" onMouseOver="this.src='<%=contextPath%>/images/keypad_image/SZJP_button1_04b.gif'" onMouseOut="this.src='<%=contextPath%>/images/keypad_image/SZJP_button1_04a.gif';hideTips()" onMouseDown="this.src='<%=contextPath%>/images/keypad_image/SZJP_button1_04c.gif'" onMouseUp="this.src='<%=contextPath%>/images/keypad_image/SZJP_button1_04b.gif'" onMouseMove="setTipShow(this.id)" onclick="dial2()"></td>
                </tr>
            </table></td>
            <td valign="top"><table width="100%" border="0" cellpadding="0" cellspacing="0">
                <tr>
                  <td height="4"></td>
                </tr>
                <tr>
                  <td valign="top"><table border="0" cellpadding="0" cellspacing="2">
                      <tr>
                      	<%if(!"".equals(strPhone[0])){%>
                        <td width="35" height="22" class="skMiddle" onMouseOut="this.className='skMiddle'" onMouseOver="this.className='skMiddleOver'" onMouseDown="this.className='skMiddleDown'" onMouseUp="this.className='skMiddleOver'">1<div style="position:absolute; margin-left:-28px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="45" height="29" border="0" align="absmiddle" onClick="execShortcutKeyDial('<%=strPhone[0]%>')"></div></td>
                        <%}else{%>
                        <td width="35" height="22" class="skFun1Rest">1<div style="position:absolute; margin-left:-28px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="45" height="29" border="0" align="absmiddle"></div></td>
                        <%}%>
                        <td width="69"><input name="TL12" type="text" class="skInput" value="<%=strPhoneSpec[0]%>" size="8"></td>
                        <%if(!"".equals(strFunc[0])){%>
                        <td width="35" height="22" class="skFun1" onMouseOut="this.className='skFun1'" onMouseOver="this.className='skFun1Over'" onMouseDown="this.className='skFun1Down'" onMouseUp="this.className='skFun1Over'" title="<%=strFuncSpec[0]%>">F1<div style="position:absolute; margin-left:-28px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="45" height="29" border="0" align="absmiddle" onClick="execFunctionKeyDial('<%=strFunc[0]%>','<%=strFuncType[0]%>')"></div></td>
                        <%}else{%>
                        <td width="35" height="22" class="skFun1Rest">F1<div style="position:absolute; margin-left:-28px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="45" height="29" border="0" align="absmiddle"></div></td>
                        <%}%>
                      </tr>
                      <tr>
                      	<%if(!"".equals(strPhone[1])){%>
                        <td width="35" height="22" class="skMiddle" onMouseOut="this.className='skMiddle'" onMouseOver="this.className='skMiddleOver'" onMouseDown="this.className='skMiddleDown'" onMouseUp="this.className='skMiddleOver'">2<div style="position:absolute; margin-left:-28px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="45" height="29" border="0" align="absmiddle" onClick="execShortcutKeyDial('<%=strPhone[1]%>')"></div></td>
                        <%}else{%>
                        <td width="35" height="22" class="skMiddleRest">2<div style="position:absolute; margin-left:-28px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="45" height="29" border="0" align="absmiddle"></div></td>
                        <%}%>
                        <td><input name="TL22" type="text" class="skInput" value="<%=strPhoneSpec[1]%>" size="8"></td>
                        <%if(!"".equals(strFunc[1])){%>
                        <td width="35" height="22" class="skFun1" onMouseOut="this.className='skFun1'" onMouseOver="this.className='skFun1Over'" onMouseDown="this.className='skFun1Down'" onMouseUp="this.className='skFun1Over'" title="<%=strFuncSpec[1]%>">F2<div style="position:absolute; margin-left:-28px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="45" height="29" border="0" align="absmiddle" onClick="execFunctionKeyDial('<%=strFunc[1]%>','<%=strFuncType[1]%>')"></div></td>
                        <%}else{%>
                        <td width="35" height="22" class="skFun1Rest">F2<div style="position:absolute; margin-left:-28px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="45" height="29" border="0" align="absmiddle"></div></td>
                        <%}%>
                      </tr>
                      <tr>
                      	<%if(!"".equals(strPhone[2])){%>
                        <td width="35" height="22" class="skMiddle" onMouseOut="this.className='skMiddle'" onMouseOver="this.className='skMiddleOver'" onMouseDown="this.className='skMiddleDown'" onMouseUp="this.className='skMiddleOver'">3<div style="position:absolute; margin-left:-28px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="45" height="29" border="0" align="absmiddle" onClick="execShortcutKeyDial('<%=strPhone[2]%>')"></div></td>
                        <%}else{%>
                        <td width="35" height="22" class="skMiddleRest">3<div style="position:absolute; margin-left:-28px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="45" height="29" border="0" align="absmiddle"></div></td>
                        <%}%>
                        <td><input name="TL32" type="text" class="skInput" value="<%=strPhoneSpec[2]%>" size="8"></td>
                        <%if(!"".equals(strFunc[2])){%>
                        <td width="35" height="22" class="skFun1" onMouseOut="this.className='skFun1'" onMouseOver="this.className='skFun1Over'" onMouseDown="this.className='skFun1Down'" onMouseUp="this.className='skFun1Over'" title="<%=strFuncSpec[2]%>">F3<div style="position:absolute; margin-left:-28px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="45" height="29" border="0" align="absmiddle" onClick="execFunctionKeyDial('<%=strFunc[2]%>','<%=strFuncType[2]%>')"></div></td>
                        <%}else{%>
                        <td width="35" height="22" class="skFun1Rest">F3<div style="position:absolute; margin-left:-28px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="45" height="29" border="0" align="absmiddle"></div></td>
                        <%}%>
                      </tr>
                      <tr>
                      	<%if(!"".equals(strPhone[3])){%>
                        <td width="35" height="22" class="skMiddle" onMouseOut="this.className='skMiddle'" onMouseOver="this.className='skMiddleOver'" onMouseDown="this.className='skMiddleDown'" onMouseUp="this.className='skMiddleOver'">4<div style="position:absolute; margin-left:-28px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="45" height="29" border="0" align="absmiddle" onClick="execShortcutKeyDial('<%=strPhone[3]%>')"></div></td>
                        <%}else{%>
                        <td width="35" height="22" class="skMiddleRest">4<div style="position:absolute; margin-left:-28px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="45" height="29" border="0" align="absmiddle"></div></td>
                        <%}%>
                        <td><input name="TL42" type="text" class="skInput" value="<%=strPhoneSpec[3]%>" size="8"></td>
                        <%if(!"".equals(strFunc[3])){%>
                        <td width="35" height="22" class="skFun1" onMouseOut="this.className='skFun1'" onMouseOver="this.className='skFun1Over'" onMouseDown="this.className='skFun1Down'" onMouseUp="this.className='skFun1Over'" title="<%=strFuncSpec[3]%>">F4<div style="position:absolute; margin-left:-28px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="45" height="29" border="0" align="absmiddle" onClick="execFunctionKeyDial('<%=strFunc[3]%>','<%=strFuncType[3]%>')"></div></td>
                        <%}else{%>
                        <td width="35" height="22" class="skFun1Rest">F4<div style="position:absolute; margin-left:-28px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="45" height="29" border="0" align="absmiddle"></div></td>
                        <%}%>
                      </tr>
                      <tr>
                      	<%if(!"".equals(strPhone[4])){%>
                        <td width="35" height="22" class="skMiddle" onMouseOut="this.className='skMiddle'" onMouseOver="this.className='skMiddleOver'" onMouseDown="this.className='skMiddleDown'" onMouseUp="this.className='skMiddleOver'">5<div style="position:absolute; margin-left:-28px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="45" height="29" border="0" align="absmiddle" onClick="execShortcutKeyDial('<%=strPhone[4]%>')"></div></td>
                        <%}else{%>
                        <td width="35" height="22" class="skMiddleRest">5<div style="position:absolute; margin-left:-28px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="45" height="29" border="0" align="absmiddle"></div></td>
                        <%}%>
                        <td><input name="TL52" type="text" class="skInput" value="<%=strPhoneSpec[4]%>" size="8"></td>
                        <%if(!"".equals(strFunc[4])){%>
                        <td width="35" height="22" class="skFun1" onMouseOut="this.className='skFun1'" onMouseOver="this.className='skFun1Over'" onMouseDown="this.className='skFun1Down'" onMouseUp="this.className='skFun1Over'" title="<%=strFuncSpec[4]%>">F5<div style="position:absolute; margin-left:-28px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="45" height="29" border="0" align="absmiddle" onClick="execFunctionKeyDial('<%=strFunc[4]%>','<%=strFuncType[4]%>')"></div></td>
                        <%}else{%>
                        <td width="35" height="22" class="skFun1Rest">F5<div style="position:absolute; margin-left:-28px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="45" height="29" border="0" align="absmiddle"></div></td>
                        <%}%>                        
                      </tr>
                      <tr>
                      	<%if(!"".equals(strPhone[5])){%>
                        <td width="35" height="22" class="skMiddle" onMouseOut="this.className='skMiddle'" onMouseOver="this.className='skMiddleOver'" onMouseDown="this.className='skMiddleDown'" onMouseUp="this.className='skMiddleOver'">6<div style="position:absolute; margin-left:-28px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="45" height="29" border="0" align="absmiddle" onClick="execShortcutKeyDial('<%=strPhone[5]%>')"></div></td>
                        <%}else{%>
                        <td width="35" height="22" class="skMiddleRest">6<div style="position:absolute; margin-left:-28px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="45" height="29" border="0" align="absmiddle"></div></td>
                        <%}%>
                        <td><input name="TL62" type="text" class="skInput" value="<%=strPhoneSpec[5]%>" size="8"></td>
                        <%
                        String tmp=request.getLocale().toString().toLowerCase();
                        if(tmp==null || tmp.equals("") || !(tmp.equals("zh_tw")||tmp.equals("zh_cn")) ){
                         	tmp="en";
                        }else{
                        	int pos = 0;
                        	if((pos = tmp.indexOf("_"))>0)tmp = tmp.substring(0,pos)+tmp.substring(pos).toUpperCase();
                        }
                        %>
                        <td width="35" height="22" class="skFun2"  onMouseOut="this.className='skFun2'" onMouseOver="this.className='skFun2Over'" onMouseDown="this.className='skFun2Down'" onMouseUp="this.className='skFun2Over'" onClick="window.open('<%=contextPath%>/softphone/common/<%=tmp%>/softPhonehelp.htm','help','toolbar=no,menubar=no,scrollbars=yes')">Help</td>
                      </tr>
                      <tr>
                      	<%if(!"".equals(strPhone[6])){%>
                        <td width="35" height="22" class="skMiddle" onMouseOut="this.className='skMiddle'" onMouseOver="this.className='skMiddleOver'" onMouseDown="this.className='skMiddleDown'" onMouseUp="this.className='skMiddleOver'">7<div style="position:absolute; margin-left:-28px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="45" height="29" border="0" align="absmiddle" onClick="execShortcutKeyDial('<%=strPhone[6]%>')"></div></td>
                        <%}else{%>
                        <td width="35" height="22" class="skMiddleRest">7<div style="position:absolute; margin-left:-28px"><img src="<%=contextPath%>/images/keypad_image/null.gif" width="45" height="29" border="0" align="absmiddle"></div></td>
                        <%}%>
                        <td><input name="TL72" type="text" class="skInput" value="<%=strPhoneSpec[6]%>" size="8"></td>
                        <td width="35" height="22" class="skFun1" onMouseOut="this.className='skFun1'" onMouseOver="this.className='skFun1Over'" onMouseDown="this.className='skFun1Down'" onMouseUp="this.className='skFun1Over'"><img src="<%=contextPath%>/images/keypad_image/SZJP_button2_tool.gif" width="21" height="10"></td>
                      </tr>
                  </table></td>
                </tr>
            </table></td>
          </tr>
        </table>
		</div>
		
		
		<div id="callHistoryBoard" style="padding:8px 0px 0px 1px; display:none">
		  <table border="0" cellspacing="0" cellpadding="0">
	        <tr>
	          <td><table width="201" border="0" cellpadding="0" cellspacing="0">
	            <tr>
	              <td> <img id="call_his_left_01" src="<%=contextPath%>/images/keypad_image/call_his_left_01.gif" width="6" height="6" alt=""></td>
	              <td width="189"> <img id="call_his_left_02" src="<%=contextPath%>/images/keypad_image/call_his_left_02.gif" width="189" height="6" alt=""></td>
	              <td> <img id="call_his_left_03" src="<%=contextPath%>/images/keypad_image/call_his_left_03.gif" width="6" height="6" alt=""></td>
	            </tr>
	          </table>
	            <table width="201" border="0" cellpadding="0" cellspacing="0">
	              <tr>
	                <td background="<%=contextPath%>/images/keypad_image/call_his_left_04.gif" width="2" style="width:2px"></td>
	                <td height="150" width="198" valign="top" background="<%=contextPath%>/images/keypad_image/call_his_left_05.gif">
	                <div id="CallHistoryLeft"></div>
	                </td>
	                <td style="background-image:url(<%=contextPath%>/images/keypad_image/call_his_left_06.gif); background-position:right; width:2px" width="2"></td>
	              </tr>
	            </table>
	            <table width="201" border="0" cellpadding="0" cellspacing="0">
	              <tr onMouseOver="this.className='callHisItem'" onMouseOut="this.className=''">
	                <td> <img id="call_his_left_07" src="<%=contextPath%>/images/keypad_image/call_his_left_07.gif" width="6" height="6" alt=""></td>
	                <td width="189"> <img id="call_his_left_08" src="<%=contextPath%>/images/keypad_image/call_his_left_08.gif" width="189" height="6" alt=""></td>
	                <td> <img id="call_his_left_09" src="<%=contextPath%>/images/keypad_image/call_his_left_09.gif" width="6" height="6" alt=""></td>
	              </tr>
	            </table></td>
	          <td width="7"></td>
	          <td><table width="201" border="0" cellpadding="0" cellspacing="0">
	            <tr>
	              <td> <img id="call_his_right_01" src="<%=contextPath%>/images/keypad_image/call_his_right_01.gif" width="6" height="6" alt="" /></td>
	              <td width="189"> <img id="call_his_right_02" src="<%=contextPath%>/images/keypad_image/call_his_right_02.gif" width="189" height="6" alt="" /></td>
	              <td> <img id="call_his_right_03" src="<%=contextPath%>/images/keypad_image/call_his_right_03.gif" width="6" height="6" alt="" /></td>
	            </tr>
	          </table>
	            <table width="201" border="0" cellpadding="0" cellspacing="0">
	              <tr>
	                <td background="<%=contextPath%>/images/keypad_image/call_his_right_04.gif" style="width:2px" width="2"></td>
	                <td height="150" width="198" valign="top" background="<%=contextPath%>/images/keypad_image/call_his_right_05.gif">
	                <div id="CallHistoryRight"></div>
	                </td>
	                <td style="width:2px; background-image:url(<%=contextPath%>/images/keypad_image/call_his_right_06.gif); background-position:right "></td>
	              </tr>
	            </table>
	            <table width="201" border="0" cellpadding="0" cellspacing="0">
	              <tr>
	                <td> <img id="call_his_right_07" src="<%=contextPath%>/images/keypad_image/call_his_right_07.gif" width="6" height="6" alt="" /></td>
	                <td width="189"> <img id="call_his_right_08" src="<%=contextPath%>/images/keypad_image/call_his_right_08.gif" width="189" height="6" alt="" /></td>
	                <td> <img id="call_his_right_09" src="<%=contextPath%>/images/keypad_image/call_his_right_09.gif" width="6" height="6" alt="" /></td>
	              </tr>
	            </table></td>
	        </tr>
	      </table>
		  </div>
	  
	  	<div id="addressBoard" style="display:none">
	  		<iframe id="addressFRM" src="<%=contextPath%>/localeAction.do?method=qryEmployee" frameborder="0" hspace="0" marginheight="0" marginwidth="0" width="415" height="185" allowtransparency="yes"></iframe>
		</div>
		
		</td>
      <td width="16" align="right" valign="top" nowrap "><img src="<%=contextPath%>/images/keypad_image/SZJP_top_right.gif" width="16" height="8"></td>
	</tr>
	<tr>
	  <td height="2" colspan="3" valign="top" nowrap ><table width="100%" border="0" cellpadding="0" cellspacing="0">
        <tr>
          <td width="90%" align="left" valign="top"></td>
          <td width="10%" align="right" valign="top"></td>
        </tr>
      </table></td>
  </tr>
</table>
</div>