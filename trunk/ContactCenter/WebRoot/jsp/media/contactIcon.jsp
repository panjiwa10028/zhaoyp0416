<script language="JavaScript" type="text/javascript">
	function changeImage(id,path){
		document.getElementById(id).src = path;
	}
</script>
<table height="160" border="0" cellpadding="0" cellspacing="0">
  <tr valign="bottom">
  <td id="vmTD1" style="display:" title="<%=Function.getMultiLangItemContentExt("Media.ContactIcon.VoiceMail", request)%>"><input type="image" name="smsImage1" id="vm1" src="<%=contextPath%>/images/null.gif" width="1" height="1" onfocus="blur();"></td>
  	<td id="vmTD" style="display:" title="<%=Function.getMultiLangItemContentExt("Media.ContactIcon.VoiceMail", request)%>"><input type="image" name="smsImage" id="vm" src="<%=contextPath%>/images/ban_voicemail_normal.gif" width="30" height="29" onclick="onShowVoiceMail();" style="cursor:hand" 
    	onMouseOver="changeImage('vm','<%=contextPath%>/images/ban_voicemail_over.gif')" onmouseout="changeImage('vm','<%=contextPath%>/images/ban_voicemail_normal.gif')" 
    	onmousedown="changeImage('vm','<%=contextPath%>/images/ban_voicemail_down.gif')" onmouseup="changeImage('vm','<%=contextPath%>/images/ban_voicemail_over.gif')">
    </td>
    <td id="vmDisableTD" style="display:none"><img border="0" src="<%=contextPath%>/images/ban_voicemail_disable.gif" width="30" height="29" style="cursor:not-allowed">
  	
    <td id="emailTD" style="display:block" title="<%=Function.getMultiLangItemContentExt("common.email", request)%>"><input type="image" name="emailImage" id="email" src="<%=contextPath%>/images/ban_top2_1_01_normal.gif" width="30" height="29" onclick="onNewOutboundEmail()" style="cursor:hand" 
    	onMouseOver="changeImage('email','<%=contextPath%>/images/ban_top2_1_01_over.gif')" onmouseout="changeImage('email','<%=contextPath%>/images/ban_top2_1_01_normal.gif')" 
    	onmousedown="changeImage('email','<%=contextPath%>/images/ban_top2_1_01_down.gif')" onmouseup="changeImage('email','<%=contextPath%>/images/ban_top2_1_01_over.gif')">
    </td>
    <td id="emailDisableTD" style="display:none" ><img border="0" src="<%=contextPath%>/images/ban_top2_7_01_disable.gif" width="30" height="29" style="cursor:not-allowed">
    </td>
    <td id="smseTD" style="display:none" title="<%=Function.getMultiLangItemContentExt("Media.ContactIcon.SMS", request)%>"><input type="image" name="smsImage" id="sms" src="<%=contextPath%>/images/ban_top2_5_01.gif" width="30" height="29" onclick="onNewOutboundSMS();" style="cursor:hand" 
    	onMouseOver="changeImage('sms','<%=contextPath%>/images/ban_top2_5_01_over.gif')" onmouseout="changeImage('sms','<%=contextPath%>/images/ban_top2_5_01.gif')" 
    	onmousedown="changeImage('sms','<%=contextPath%>/images/ban_top2_5_01_down.gif')" onmouseup="changeImage('sms','<%=contextPath%>/images/ban_top2_5_01_over.gif')">
    </td>
    <td id="smsDisableTD" style="display:none"><img border="0" src="<%=contextPath%>/images/ban_top2_5_01_disable.gif" width="30" height="29" style="cursor:not-allowed">
    </td>
    
    <td id="faxTD" style="display:none" title="<%=Function.getMultiLangItemContentExt("Media.ContactIcon.Fax", request)%>"><input type="image" name="faxImage" id="fax" src="<%=contextPath%>/images/ban_top2_6_01.gif" width="30" height="29" onclick="onNewOutboundFax();" style="cursor:hand" 
    	onMouseOver="changeImage('fax','<%=contextPath%>/images/ban_top2_6_01_over.gif')" onmouseout="changeImage('fax','<%=contextPath%>/images/ban_top2_6_01.gif')" 
    	onmousedown="changeImage('fax','<%=contextPath%>/images/ban_top2_6_01_down.gif')" onmouseup="changeImage('fax','<%=contextPath%>/images/ban_top2_6_01_over.gif')">
    </td>
    <td id="faxDisableTD" style="display:none" ><img border="0" src="<%=contextPath%>/images/ban_top2_6_01_disable.gif" width="30" height="29" style="cursor:not-allowed">
    </td>
    
    <td id="mailTD" style="display:none" title="<%=Function.getMultiLangItemContentExt("Media.ContactIcon.Mail", request)%>"><input type="image" name="mailImage" id="mail" src="<%=contextPath%>/images/ban_top2_7_01_normal.gif" width="30" height="29" onclick="onNewOutboundMail();" style="cursor:hand" 
    	onMouseOver="changeImage('mail','<%=contextPath%>/images/ban_top2_7_01_over.gif')" onmouseout="changeImage('mail','<%=contextPath%>/images/ban_top2_7_01_normal.gif')" 
    	onmousedown="changeImage('mail','<%=contextPath%>/images/ban_top2_7_01_down.gif')" onmouseup="changeImage('mail','<%=contextPath%>/images/ban_top2_7_01_over.gif')">
    </td>
    <td id="mailDisableTD" style="display:none" ><img border="0" src="<%=contextPath%>/images/ban_top2_7_01_disable.gif" width="30" height="29" style="cursor:not-allowed">
    </td>
    
  </tr>
</table> 
<script language="JavaScript" type="text/javascript">
	var addFaxPermission = top.isExistedPermission("System.FaxManager.AddFax");
	var addSMSPermission = top.isExistedPermission("System.ShortMessageManage.AddSMS");
	var sendMailPermission = top.isExistedPermission("System.MailManager.SendMail");
	var sendEMailPermission = top.isExistedPermission("System.EmailManager.SendEmailTop");
	var lookVoiceMailPermission = top.isExistedPermission("System.MailManager.VoiceMail");

	if(lookVoiceMailPermission){
		vmTD.style.display = "block";
		vmDisableTD.style.display = "none";
	}else{
		vmTD.style.display = "none";
		vmDisableTD.style.display = "block";
	}

	if(addFaxPermission){
		faxTD.style.display = "block";
		faxDisableTD.style.display = "none";
	}else{
		faxTD.style.display = "none";
		faxDisableTD.style.display = "block";
	}
	
	if(addSMSPermission){
		smseTD.style.display = "none";
		smsDisableTD.style.display = "none";
	}else{
		smseTD.style.display = "none";
		smsDisableTD.style.display = "none";
	}
	
	if(sendMailPermission){
		mailTD.style.display = "block";
		mailDisableTD.style.display = "none";
	}else{
		mailTD.style.display = "none";
		mailDisableTD.style.display = "block";
	}
	
	if(sendEMailPermission){
		emailTD.style.display = "block";
		emailDisableTD.style.display = "none";
	}else{
		emailTD.style.display = "none";
		emailDisableTD.style.display = "block";
	}
</script>