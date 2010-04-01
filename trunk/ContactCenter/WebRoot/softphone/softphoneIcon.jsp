<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ page import="com.esoon.EZActor.BusinessCenter.Function"%>
			
<%	//String contextPath = request.getContextPath();
	String host=request.getRequestURL().toString();
	host=host.substring(0,host.lastIndexOf("/"));
	host=host.substring(0,host.lastIndexOf("/"));
%>	
	
	<script language=javascript>
	function webMouseOverKeypad(name) {
	}
	function webMouseOutKeypad(name) {
	}	
	function webMouseOverLineOne(name) {
	}
	function webMouseOutLineOne(name) {
	}	
	function webMouseOverLineTwo(name) {
	}
	function webMouseOutLineTwo(name) {
	}
	function webMouseOverLineThree(name) {
	}
	function webMouseOutLineThree(name) {
	}	
	function webMouseOverMute(name) {
	}
	function webMouseOutMute(name) {
	}	
	function webMouseOverRefuse(name) {
	}
	function webMouseOutRefuse(name) {
	}
	function webMouseOverHold(name) {
	}
	function webMouseOutHold(name) {
	}
	function webMouseOverTransfer(name) {
	}
	function webMouseOutTransfer(name) {
	}	
	function webMouseOverConference(name) {
	}
	function webMouseOutConference(name) {
	}
	function webMouseOverAttacheddata(name) {
	}
	function webMouseOutAttacheddata(name) {
	}	
	function webMouseOverIVR(name) {
	}
	function webMouseOutIVR(name) {
	}	
	function webMouseOverEmailin(name) {		
	}
	function webMouseOutEmailin(name) {
	}
	function webMouseOverChat(name) {
	}
	function webMouseOutChat(name) {
	}
	function webMouseOverCobrowse(name) {
	}
	function webMouseOutCobrowse(name) {
	}
	function webMouseOverCallback(name) {
	}
	function webMouseOutCallback(name) {
	}
	function webMouseOverSms(name) {
	}
	function webMouseOutSms(name) {
	}
	function webMouseOverFax(name) {
	}
	function webMouseOutFax(name) {
	}
	function webMouseOverMail(name) {
	}
	function webMouseOutMail(name) {
	}
	</script>		
	<table width="760" cellpadding="0" cellspacing="1" border="0">
		<tr>		
			<td valign="top">
	        	<div><img name="keypadImage" id="keypad" border="0" src="<%=contextPath%>/images/cti_image/a01-keypad_disabled.gif" width="30" height="28" alt="<%=Function.getMultiLangItemContent("softphone.keypad",request)%>" onmouseover="this.style.cursor='hand';webMouseOverKeypad(this.name);" onmouseout="webMouseOutKeypad(this.name);" onclick="webMouseClick(this.name);" disable></div>
	        	<div id="keypadArea" style="display:none">
		        	<table width="100%" border="0" cellpadding="5" cellspacing="0" bgcolor="#B2C7DC">
		        		<tr>
		            		<td align="center"><%=Function.getMultiLangItemContent("softphone.keypad",request)%></td>
		            	</tr>
		            </table>
		            <iframe frameborder="0" height="220" width="240" marginheight="0" marginwidth="0" scrolling="no" src="<%=contextPath%>/softphone/keypad.jsp"></iframe>
	        	</div>			
			</td>
			<td style="width:32px" valign="top">
				<script language="javascript" type="text/javascript">
				function chenkPhoneNumberStat(){
					if(document.getElementById("keypadArea").style.display == "none" && document.getElementById('phoneNumberHistory').style.display == "none") {
					 	document.getElementById("phoneNumber").className="phoneNumber";
					 }
					 else {
					 	document.getElementById("phoneNumber").className="phoneNumberHover";
					 }
				}
				//设置焦点
				function setPoneNumberFocus(){
					document.getElementById("phoneNumber").focus();
					focusInput(document.getElementById("phoneNumber"));
				}
				//将焦点的光标移到最后
				function focusInput(i)   {   
					var r = i.createTextRange();   
					r.collapse(false);   
					r.select();   
				}
				function showHideKeyPad(objId){	
					var str = document.getElementById('phoneNumberHistory').innerHTML;
					if(str!=""){
						if(document.getElementById(objId).style.display == "none"){
							document.getElementById(objId).style.display = "block";	
						}else{
							document.getElementById(objId).style.display = "none"
						}
					}
				}  
				</script>
				<div  class="phoneNumberDiv" onMouseOver="this.className='phoneNumberDivHover'"  onMouseOut="this.className='phoneNumberDiv'">
					<table  border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td><input class="phoneNumberInput" name="phoneNumber" id="phoneNumber" type="text"></td>
							<td style="padding-right:1px"><img src="<%=contextPath%>/images/cti_image/drop_list.gif" width="15" height="23" border="0" align="absmiddle" style="cursor:pointer" onClick="createCallList();showHideKeyPad('phoneNumberHistory');event.cancelBubble = true;"></td>
						</tr>
					</table>
				</div>
                <div id="phoneNumberHistory" style="display:none; z-index:99">
                </div>
            </td>
			<td>
				<img name="lineOneImage" id="lineOne" border="0" src="<%=contextPath%>/images/cti_image/a02-dial_disabled.gif"  alt="<%=Function.getMultiLangItemContent("softphone.lineOne",request)%>" width="30" height="28" onmouseover="this.style.cursor='hand';webMouseOverLineOne(this.name);" onmouseout="webMouseOutLineOne(this.name);" onclick="webMouseClick(this.name);" disable>
			</td>
			<td>
				<img name="lineTwoImage" id="LineTwo"  border="0" src="<%=contextPath%>/images/cti_image/a02-dial_disabled.gif"  alt="<%=Function.getMultiLangItemContent("softphone.lineTwo",request)%>"  width="30" height="28" onmouseover="this.style.cursor='hand';webMouseOverLineTwo(this.name);" onmouseout="webMouseOutLineTwo(this.name);" onclick="webMouseClick(this.name);" disable>
			</td>
			<td>
				<img name="lineThreeImage" id="LineThree" border="0" src="<%=contextPath%>/images/cti_image/a02-dial_disabled.gif" width="30" height="28" alt="<%=Function.getMultiLangItemContent("softphone.lineThree",request)%>" onmouseover="this.style.cursor='hand';webMouseOverLineThree(this.name);" onmouseout="webMouseOutLineThree(this.name);" onclick="webMouseClick(this.name);" disable>
			</td>
			<td>
				<img name="muteImage"  id="mute" border="0" src="<%=contextPath%>/images/cti_image/a05-dail_disabled.gif" width="30" height="28" alt="<%=Function.getMultiLangItemContent("softphone.mute",request)%>" onmouseover="this.style.cursor='hand';webMouseOverMute(this.name);" onmouseout="webMouseOutMute(this.name);" onclick="webMouseClick(this.name);" disable>
			</td>
			<td>
				<img name="refuseImage" id="refuseImage" border="0" src="<%=contextPath%>/images/cti_image/a20-handnophone_disabled.gif" width="30" height="28" alt="<%=Function.getMultiLangItemContent("softphone.refuse",request)%>" onmouseover="this.style.cursor='hand';webMouseOverRefuse(this.name);" onmouseout="webMouseOutRefuse(this.name);" onclick="webMouseClick(this.name);" disable>
			</td>
			<td>
				<img name="holdImage" id="hold" border="0" src="<%=contextPath%>/images/cti_image/a06-hold_disabled.gif" width="30" height="28" alt="<%=Function.getMultiLangItemContent("softphone.hold",request)%>" onmouseover="this.style.cursor='hand';webMouseOverHold(this.name);" onmouseout="webMouseOutHold(this.name);" onclick="webMouseClick(this.name);" disable>
			</td>
			<td>
				<img name="transferImage" id="transfer" border="0" src="<%=contextPath%>/images/cti_image/a07-transfer_disabled.gif" width="30" height="28" alt="<%=Function.getMultiLangItemContent("softphone.transfer",request)%>" onmouseover="this.style.cursor='hand';webMouseOverTransfer(this.name);" onmouseout="webMouseOutTransfer(this.name);" onclick="webMouseClick(this.name);" disable>
			</td>
			<td>
				<img name="conferenceImage" id="conference" border="0" src="<%=contextPath%>/images/cti_image/a08-conference_disabled.gif" width="30" height="28" alt="<%=Function.getMultiLangItemContent("softphone.conference",request)%>" onmouseover="this.style.cursor='hand';webMouseOverConference(this.name);" onmouseout="webMouseOutConference(this.name);" onclick="webMouseClick(this.name);" disable>
			</td>
			<td>
				<img name="attacheddataImage" id="attacheddata" border="0" src="<%=contextPath%>/images/cti_image/a09-attacheddata_disabled.gif" width="30" height="28" alt="<%=Function.getMultiLangItemContent("softphone.attacheddata",request)%>" onmouseover="this.style.cursor='hand';webMouseOverAttacheddata(this.name);" onmouseout="webMouseOutAttacheddata(this.name);" onclick="webMouseClick(this.name);" disable>
			</td>
			<td>
				<img name="ivrImage" id="ivr" border="0" src="<%=contextPath%>/images/cti_image/a10-ivr_disabled.gif" width="30" height="28"  alt="<%=Function.getMultiLangItemContent("softphone.IVR",request)%>"  onmouseover="this.style.cursor='hand';webMouseOverIVR(this.name);" onmouseout="webMouseOutIVR(this.name);" onclick="webMouseClick(this.name);" disable>
			</td>
			<td>
				<input class="icenter" style="width:28px;" name="QueuedCalls" type="text" value="" readOnly="true"/>
			</td>
			<td>
				<input class="icenter" style="width:60px" name="timer" type="text" value="" readOnly="true"/>
			</td>
			<td>
				<img name="mailinImage" id="mailin" border="0" src="<%=contextPath%>/images/cti_image/a11-email_disabled.gif" width="30" height="28" alt="<%=Function.getMultiLangItemContent("softphone.mailin",request)%>" onmouseover="this.style.cursor='hand';webMouseOverEmailin(this.name);" onmouseout="webMouseOutEmailin(this.name);" onclick="openEmailDialog();" disable>
			</td>
			<td>
				<img name="workbinEmailImage" id="workbinin" border="0" src="<%=contextPath%>/images/cti_image/email_disabled.gif" width="30" height="28" alt="<%=Function.getMultiLangItemContent("workbin",request)%>"  onclick="openWorkbinDialog();" disable>
			</td>
			<td>
				<img name="chatImage" id="chat" border="0" src="<%=contextPath%>/images/cti_image/a12-chat_disabled.gif" width="30" height="28"  alt="<%=Function.getMultiLangItemContent("softphone.chat",request)%>" onmouseover="this.style.cursor='hand';webMouseOverChat(this.name);" onmouseout="webMouseOutChat(this.name);" onclick="openChatDialog();" disable>
			</td>
			<td>
				<img name="cobrowseImage" id="cobrowse" border="0" src="<%=contextPath%>/images/cti_image/a13-cobrowse_disabled.gif" width="30"  alt="<%=Function.getMultiLangItemContent("softphone.cobrowse",request)%>" height="28" onmouseover="this.style.cursor='hand';webMouseOverCobrowse(this.name);" onmouseout="webMouseOutCobrowse(this.name);"  onclick="openCobrowseDialog();" disable>
			</td>
			<td>
				<img name="voipImage" border="0" src="<%=contextPath%>/images/cti_image/a14-voip_disabled.gif" width="30" height="28" border="0" alt="<%=Function.getMultiLangItemContent("softphone.callBack",request)%>" onmouseover="this.style.cursor='hand';webMouseOverCallback(this.name);" onmouseout="webMouseOutCallback(this.name);" onclick="javascript:openCallmeback();" disable>
			</td>
			<td>	
				<img name="smsImage" id="sms" border="0" src="<%=contextPath%>/images/cti_image/a15-SMS_disabled.gif" width="30" height="28" alt="<%=Function.getMultiLangItemContent("softphone.sms",request)%>" onmouseover="this.style.cursor='hand';webMouseOverSms(this.name);" onmouseout="webMouseOutSms(this.name);" onclick="openSMSDialog();" disable>
			</td>
			<td>
				<img name="faxImage" id="fax" border="0" src="<%=contextPath%>/images/cti_image/a16-fax_disabled.gif" width="30" height="28" alt="<%=Function.getMultiLangItemContent("softphone.fax",request)%>"  onmouseover="this.style.cursor='hand';webMouseOverFax(this.name);" onmouseout="webMouseOutFax(this.name);" onclick="openFaxDialog();" disable>
			</td>
			<td>
				<img name="mailImage" border="0" src="<%=contextPath%>/images/cti_image/a18-send_disabled.gif" width="30" height="28" alt="<%=Function.getMultiLangItemContent("softphone.mail",request)%>" onmouseover="this.style.cursor='hand';webMouseOverMail(this.name);" onmouseout="webMouseOutMail(this.name);" onclick="openMailDialog();" disable>
			</td>
		</tr>
	</table>