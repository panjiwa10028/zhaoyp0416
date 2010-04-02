<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ include file="/jsp/common/header/include_init.jsp" %>
<html>
<head>
  <script language="javascript">

    function loadInfo(){  
       commonForm.lUserId.value=top.getUserId();
       commonForm.strUserName.value=top.getUserName();
       commonForm.lTenantId.value=top.getTenantId();
      commonForm.lPlaceCTIId.value = top.document.all.lPlaceCTIId.value;
      commonForm.strRole.value=getRole();
       document.commonForm.submit();
    }
    //为了我负责的活动加的。根据不同的角色确认列表内容
  function getRole()
{
return "planner";
/* if(top.isExistedPermission("System.CampaignManager.ScrewAll") || top.isExistedPermission("System.CampaignManager.ModifyAll")){
  {
  //alert(top.isExistedPermission("System.CampaignManager.ScrewAll"));
  return "supervisor";
  }
 }else{
  return "planner";
 }*/
}
  </script>  
</head>
<body onload="loadInfo()">
<table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" class="lab3"> 
   <tr>
   	 <td>	
       <table width="100%" height="100%" border="0" cellpadding="0" cellspacing="0" class="lab3">
         <tr valign="top" >
           <td id="" width="100%" >
    	    <iframe width="100%" height="100%" frameborder="0" id="showConfigArea" name="showConfigArea"  scrolling="no"></iframe>
           </td>
         </tr> 
      </table>
   </td>
  </tr>
 </table> 
<form name="commonForm" action="<%=strContextPath%>/personalInfoAction.do?method=showConfigPage" method="post" target="showConfigArea">
<input type="hidden" name="lUserId" />
<input type="hidden" name="strUserName" />
<input type="hidden" name="lTenantId" />
<input type="hidden" name="strRole" />
<input name="lPlaceCTIId" type="hidden" value="" />
<input type="hidden" name="forward" value="/jsp/PersonalFirstPage/workbench/firstPage.jsp" />
</form>
</body>
</html>