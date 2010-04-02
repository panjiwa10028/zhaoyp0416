<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>
<%@ include file="/jsp/common/header/include_getRequiredParameter.jsp" %>
<%@ page import="EZLib.Message.EZMessage" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.BusinessCenterApp" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.Function"%>
<%@ page import="java.net.URLEncoder"%>

<%@ include file="/jsp/common/header/include_init.jsp" %>

	<%if(request.getAttribute("LBUSINESSID")==null || ((Long)request.getAttribute("LBUSINESSID")).longValue()!=0)
	  {
	  	EZMessage requestMessage = new EZMessage();	
		requestMessage.setString("strServiceName", "BusinessManager");
		requestMessage.setString("strTransName", "GetDefaultBusiness");
		requestMessage.setLong("lUserId", 1);
		requestMessage.setString("strUserName", "a");
		requestMessage.setLong("lTenantId", 0);		
		EZMessage responseMessage = new EZMessage();	
		BusinessCenterApp.getInstance().handleTrans(requestMessage,responseMessage);		
		Function.MessageToRequest(responseMessage, request);				
	  }
	%>	


<script language="javascript">	
	if(top.lPresetOutboundBusinessId=='')
	{
	top.lPresetOutboundBusinessId='<c:out value="${LBUSINESS}" />';
	}//alert(top.lPresetOutboundBusinessId);
	function viewBusiness(strInboundNumber,strAttachedData,strInteractionId,nBoundType)
	{
		if (strAttachedData.indexOf("strFrameName")<0 && strAttachedData.indexOf("lBusinessId")>-1)
		{
			document.businessForm.target = '_self';
			var v1=0;
			var v2=0;
			document.businessForm.nName.value=1;
			document.businessForm.strServiceName.value='BusinessManager';
		    document.businessForm.strTransName.value='GetBusiness';
		    document.businessForm.lUserId.value=top.getUserId();
		    document.businessForm.strUserName.value=top.getUserName();
		    document.businessForm.lTenantId.value=top.getTenantId();
		    document.businessForm.nName.value=1;		
		    document.businessForm.strInteractionId.value=strInteractionId;    		    
		    document.businessForm.strAttachedData.value=strAttachedData;
		    s=strAttachedData.substring(strAttachedData.indexOf("lBusinessId"),strAttachedData.length);
	    	v1=s.indexOf("=");
	    	v2=s.indexOf("#@@#");
	    	if(v2<0)
		    {
		    	v2=s.length;		
		    	if(s.substring(v1+1,v2)!=null && s.substring(v1+1,v2)!='' && s.substring(v1+1,v2)!=0)
		    	{		    	
		    		document.businessForm.lBusiness.value=s.substring(v1+1,v2);		
		    	}
		    		
		    }
		    else if(v2>0)
		    {
		    	if(s.substring(v1+1,v2)!=null && s.substring(v1+1,v2)!='' && s.substring(v1+1,v2)!=0)
		    	{
		    		document.businessForm.lBusiness.value=s.substring(v1+1,v2);
		    	}	
		    }
		    else if(v2==0)
		    {
		    	if(document.businessForm.lBusiness.value==null || document.businessForm.lBusiness.value=='' || document.businessForm.lBusiness.value==0)
		    	{	
		    		return;
		    	}
		    }
		    
		    document.businessForm.lId.value=document.businessForm.lBusiness.value;
		    
		    //alert(document.businessForm.lId.value+"KKK");
		    
		    document.businessForm.forward.value = "/jsp/viewBusiness.jsp";
		    
		    document.businessForm.submit();		    
		    
		    document.businessForm.nName.value=0;
		}
		else
		{
			
		//if(top.isExistedPermission("System.BusinessExecution"))
		//{
			document.businessForm.lBusiness.value=top.lPresetOutboundBusinessId;
		    document.businessForm.strInboundNumber.value=strInboundNumber;
		    document.businessForm.strAttachedData.value=strAttachedData;
		    document.businessForm.strServiceName.value='BusinessManager';
		    document.businessForm.strTransName.value='GetBusinessId';
		    document.businessForm.lUserId.value=top.getUserId();
		    document.businessForm.strUserName.value=top.getUserName();
		    document.businessForm.lTenantId.value=top.getTenantId();
		    document.businessForm.nViewBusinessId.value=1;
		    if(nBoundType==null || nBoundType=='')
		    {
		    	document.businessForm.nBoundType.value=0;
		    }
		    else
		    {
		    	document.businessForm.nBoundType.value=nBoundType;
		    }
		    
		    if (strAttachedData.indexOf("strFrameName")>-1) {
			    var s=strAttachedData.substring(strAttachedData.indexOf("strFrameName"),strAttachedData.length);
			    var v1=s.indexOf("=");
			    var v2=s.indexOf("#@@#");
			    if(v2<0)
			    {
			    	v2=s.length;
			    }
			    var IframeName=s.substring(v1+1,v2);
			    if (IframeName != ''){
			    	document.businessForm.target = IframeName;
			    } else {
			    	document.businessForm.target = '_self';
			    }
			    if (strAttachedData.indexOf("lBusinessId")>-1) {
			    	s=strAttachedData.substring(strAttachedData.indexOf("lBusinessId"),strAttachedData.length);
			    	v1=s.indexOf("=");
			    	v2=s.indexOf("#@@#");
			    	if(v2<0)
				    {
						
				    	v2=s.length;		
				    	if(s.substring(v1+1,v2)!=null && s.substring(v1+1,v2)!='' && s.substring(v1+1,v2)!=0)
				    	{

				    		document.businessForm.lBusiness.value=s.substring(v1+1,v2);		
				    	}
				    	if(top.lPresetOutboundBusinessId==null || top.lPresetOutboundBusinessId=='' || top.lPresetOutboundBusinessId==0)
				    	{	
				    		return;
				    	}
				    }
				    else if(v2>0)
				    {
				    			
				    	if(s.substring(v1+1,v2)!=null && s.substring(v1+1,v2)!='' && s.substring(v1+1,v2)!=0)
				    	{

				    		document.businessForm.lBusiness.value=s.substring(v1+1,v2);				    		
				    	}	
				    	/*if(top.lPresetOutboundBusinessId==null || top.lPresetOutboundBusinessId=='' || top.lPresetOutboundBusinessId==0)
				    	{	
				    		return;
				    	}*/
				    	if(document.businessForm.lBusiness.value==null || document.businessForm.lBusiness.value=='' || document.businessForm.lBusiness.value==0)
				    	{
				    		return;
				    	}
				    }
				    else if(v2==0)
				    {	
						
				    	if(document.businessForm.lBusiness.value==null || document.businessForm.lBusiness.value=='' || document.businessForm.lBusiness.value==0)
				    	{		
				    		  		
				    		return;
				    	}
				    	if(top.lPresetOutboundBusinessId==null || top.lPresetOutboundBusinessId=='' || top.lPresetOutboundBusinessId==0)
				    	{	
				    		return;
				    	}
				    }
			    	//document.businessForm.lBusiness.value=s.substring(v1+1,v2);			    	
			    }
			    else
			    {	    	
			    	if(document.businessForm.lBusiness.value==null || document.businessForm.lBusiness.value=='' || document.businessForm.lBusiness.value==0)
			    	{
			    		return;
			    	}
			    }
			    
			    //alert(document.businessForm.lBusiness.value);
			    			    
			    document.businessForm.forward.value = "/jsp/BusinessExec/BusinessPage.jsp";
		    } 
		    else {
		    	document.businessForm.target = '_self';
		    	document.businessForm.forward.value = "/jsp/viewBusiness.jsp";
		    }
		    document.businessForm.strInteractionId.value=strInteractionId;
		    document.businessForm.submit();
		    document.businessForm.lBusiness.value=top.lPresetOutboundBusinessId;
		//}  
		}  
	}
</script>
<form id="businessForm" name="businessForm" method="post" action="<%=request.getContextPath()%>/commonTransAction.do">
	<input name="strServiceName" type="hidden" />
	<input name="strTransName" type="hidden" />
	<input name="lUserId" type="hidden" />
	<input name="lId" type="hidden" />
	<input name="strUserName" type="hidden" />
	<input name="lTenantId" type="hidden" />
	<input name="nViewBusinessId" type="hidden" />
	<input name="strInboundNumber" type="hidden" />
	<input name="strAttachedData" type="hidden" />
	<input name="nName" type="hidden" value="0" />
	<input name="lBusiness" type="hidden" />
	<input name="forward" type="hidden" />	
	<input name="nBoundType" type="hidden" />
	<input name="strInteractionId" type="hidden" value="" />		
</form>
<script language="javascript">
	document.businessForm.lBusiness.value=top.lPresetOutboundBusinessId;		
</script>

<c:if test="${NNAME!=null && NNAME!='' && NNAME==1}">
	<script language="javascript">
		//alert('<c:out value="${LID}" />');
		<c:if test="${STRNAME!=null && STRNAME!=''}" >
		//alert('<%//=(String)request.getAttribute("STRINTERACTIONID")%>');
		
		top.addTab('<c:out value="${LID}" />','<c:out value="${STRNAME}" />','<%=strContextPath%>/jsp/BusinessExec/BusinessPage.jsp?STRINTERACTIONID=<%=(String)request.getAttribute("STRINTERACTIONID")%>',true,false,true);    
		</c:if>
	</script>
</c:if>

<c:if test="${NNAME==null || NNAME=='' || NNAME==0}">
<c:if test="${LBUSINESSID!=null && LBUSINESSID!='' && LBUSINESSID!=-1}">
<script language="javascript"> 
   	top.addTab('<c:out value="${LBUSINESSID}" />','<c:out value="${STRNAME}" />','<%=strContextPath%>/jsp/BusinessExec/BusinessPage.jsp',true,false,true);    
</script>
</c:if>
</c:if>