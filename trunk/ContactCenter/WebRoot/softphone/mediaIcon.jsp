<%@ page language="java" pageEncoding="UTF-8"%>
<%String contextPath = request.getContextPath();%>
<table border="0" cellpadding="0" cellspacing="2">
  <tr>
    <td>
    	<!--input type="image" name="mailinImage" id="mailin" src="<%=contextPath%>/images/cti_image/email_disabled.gif" width="30" height="29" onclick="openMail(this);" style="cursor:not-allowed"
     	onMouseOver="webMouseOver(this.name)" onMouseMove="setTipShow(this.id)" onMouseOut="webMouseOut(this.name);hideTips()" onMouseUp="webMouseUp(this.name)"  onMouseDown="webMouseDown(this.name)"  disabled -->
     	<div id="mailinImage" style="display:none;" class="mailinImage_disabled" 
					onMouseOver="webMouseOver(this.id)"
					onMouseDown="webMouseDown(this.id)"  
					onMouseUp="webMouseUp(this.id)" 
					onMouseOut="webMouseOut(this.id);hideTips()"
					onMouseMove="setTipShow(this.id)"
					onclick="javascript:openMail(this);" disabled></div>
     </td>
    <td>
    <!--input type="image" name="chatImage" id="chat" src="<%=contextPath%>/images/cti_image/chat_disabled.gif" width="30" height="29" style="cursor:not-allowed" onclick="openChat(this);"
     	onMouseOver="webMouseOver(this.name)" onMouseMove="setTipShow(this.id)" onMouseOut="webMouseOut(this.name);hideTips()" onMouseUp="webMouseUp(this.name)"  onMouseDown="webMouseDown(this.name)"  disabled-->
     	<div id="chatImage" style="display:none;" class="chatImage_disabled" 
					onMouseOver="webMouseOver(this.id)"
					onMouseDown="webMouseDown(this.id)"  
					onMouseUp="webMouseUp(this.id)" 
					onMouseOut="webMouseOut(this.id);hideTips()"
					onMouseMove="setTipShow(this.id)"
					onclick="javascript:openChat(this);" disabled></div>
     </td>
 
    <td>
    	<!--<input type="image" name="workbinEmailImage" id="workbin" src="<%=contextPath%>/images/cti_image/workbin_disabled.gif" width="30" height="29" style="cursor:not-allowed" onclick="javascript:openWorkbinDialog();"
     	onMouseOver="webMouseOver(this.name)" onMouseMove="setTipShow(this.id)" onMouseOut="webMouseOut(this.name);hideTips()" onMouseUp="webMouseUp(this.name)"  onMouseDown="webMouseDown(this.name)"  disabled>-->
     	<div id="workbinEmailImage" style="display:none;" class="workbinEmailImage_disabled" 
					onMouseOver="this.className='workbinEmailImage_over';"
					onMouseDown="this.className='workbinEmailImage_down'"  
					onMouseUp="this.className='workbinEmailImage_over'" 
					onMouseOut="this.className='workbinEmailImage_enabled';hideTips()"
					onMouseMove="setTipShow(this.id)"
					onClick="javascript:openWorkbinDialog();" disabled></div>
     </td>
     
     <td>     	
       	<div id="newEmailImage" style="display:none;" class="newEmailImage_disabled" 
					onMouseOver="webMouseOver(this.id)"
					onMouseDown="webMouseDown(this.id)"  
					onMouseUp="webMouseUp(this.id)" 
					onMouseOut="webMouseOut(this.id);hideTips()"
					onMouseMove="setTipShow(this.id)"
					onclick="javascript:newEmail();" disabled></div>
     </td>
     <!--
    <td>
     	<div id="cobrowseImage" class="cobrowseImage_enabled" 
					onMouseOver="this.className='cobrowseImage_over';"
					onMouseDown="this.className='cobrowseImage_down'"  
					onMouseUp="this.className='cobrowseImage_over'" 
					onMouseOut="this.className='cobrowseImage_enabled';hideTips()"
					onMouseMove="setTipShow(this.id)"
					onClick="javascript:openCobrowseDialog();" enabled></div>
     </td>
     -->
  </tr>
</table> 

<script>
function document.onkeydown()
{
   var o = event.srcElement;
   // F1    112         BackSpace      8         Home    36
   // F2    113         TAB            9         End     35
   // F3    114         ENTER          13        Insert  45
   // F4    115         ESC            27        DEL     46
   // F5    116         PageUp         33        <-      37
   // F6    117         PageDown       34        ^       38
   // F7    118         Space          32        ->      39
   // F8    119         Scroll Lock    14        v       40
   // F9    120         break          19
   // F10   121
   if (event.keyCode==116|| (!(o.type=='text' || o.type=='textarea' || o.type == 'file') && (event.keyCode==8 || event.keyCode==46)) )
   {
       event.keyCode = 0;
       event.returnValue=false;
   }
}
</script>