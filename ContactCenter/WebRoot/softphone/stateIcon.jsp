<%@ page language="java" pageEncoding="UTF-8"%>
<%@ page import="com.esoon.ezactor.contact.Function"%>
<%	String contextPath = request.getContextPath();%>
 
﻿<script language="javascript" type="text/javascript">
var staticState = new Array();
staticState[0]='<%=Function.getMultiLangItemContent("agent.status.Ready",request)%>';//"Ready";//All
staticState[1]='<%=Function.getMultiLangItemContent("agent.status.Ready",request)%>';  //"Ready";//Part
staticState[2]='<%=Function.getMultiLangItemContent("agent.status.Busy",request)%>';//"Busy";//
staticState[3]='<%=Function.getMultiLangItemContent("agent.status.OffSeat",request)%>'; ////
staticState[4]='<%=Function.getMultiLangItemContent("agent.status.OffLine",request)%>'; //"OffLine";//
	
var staticChannelState = new Array();
staticChannelState[0]="<%=Function.getMultiLangItemContent("agent.status.Ready",request)%>";
staticChannelState[1]="<%=Function.getMultiLangItemContent("agent.status.notReady",request)%>";
staticChannelState[2]="<%=Function.getMultiLangItemContent("agent.status.Logout",request)%>";
staticChannelState[3]="<%=Function.getMultiLangItemContent("agent.status.Login",request)%>";

var staticChannel=new Array();
staticChannel[0]="<%=Function.getMultiLangItemContent("softphone.voice",request)%>";
staticChannel[1]="<%=Function.getMultiLangItemContent("softphone.email",request)%>";
staticChannel[2]="<%=Function.getMultiLangItemContent("softphone.chat",request)%>";
</script>

<script language="javascript" type="text/javascript">
function viewAgentState(){
	if(getChannelCount()==0){
		return;
	}
	delRow();
	addrow();
}

function delRow()
{
	//alert("总共："+document.getElementById("agentStateTable").rows.length)
	for (i=document.getElementById("agentStateTable").rows.length-1;i>=1; i-- )
	{
		document.getElementById("agentStateTable").deleteRow(i);
	}

	//alert("总共："+document.getElementById("agentStateTable").rows.length)
	for (i=document.getElementById("channelStateTable").rows.length-1;i>=1; i-- )
	{
		document.getElementById("channelStateTable").deleteRow(i);
	}
}
	
function addrow(){
    var channelChoosedState="";
 
    var stateForAgent;
    
    //添加坐席状态以显示
	for(var j=0;j<=2;j++){
	    var srcImg = "<%=contextPath%>/images/agent_image/left_space.gif";
	    if(j==0){
            stateForAgent = 0;
	    }else if(j==1){
            stateForAgent = 3;
	    }else if(j==2){
            stateForAgent = 4;
	    }
        if((agentObj.choosedState==0 && j==0)||(agentObj.choosedState==3 && j==1)||(agentObj.choosedState==4 && j==2)){
	        srcImg ="<%=contextPath%>/images/agent_image/green_dot.gif";
	    }
        
		var oTr = document.getElementById("agentStateTable").insertRow();
        var oTd = oTr.insertCell();
		oTd.innerHTML = "<img id='zxStat"+j+"Img' src='"+srcImg+"' width='20' height='22' border='0' align='absmiddle'>"+staticState[stateForAgent];
		oTd.setAttribute("id","zxStat"+j);
		oTd.onmouseover=function(){this.className='tdOver'};
		oTd.onmouseout=function(){this.className='tdOut'};
		oTd.setAttribute("style","font-weight:bold");
		oTd.attachEvent("onclick",agentStateChanged(stateForAgent,-1)) ;
	}
	
	var oTr = document.getElementById("agentStateTable").insertRow();
    var oTd = oTr.insertCell();
	oTd.innerHTML="<hr>";
	
	for(var i=0;i<agentObj.offLineReasonList.length;i++){
	    var srcImg = "<%=contextPath%>/images/agent_image/left_space.gif";
        if(agentObj.choosedState==3 && agentObj.offLineIndex==i){
	    	srcImg ="<%=contextPath%>/images/agent_image/green_dot.gif";
		}
    	oTr = document.getElementById("agentStateTable").insertRow();
    	oTd = oTr.insertCell();
		oTd.innerHTML = "<img id='zxStat"+(i+3)+"Img' src='"+srcImg+"' width='20' height='22' border='0' align='absmiddle'>"+agentObj.offLineReasonList[i].split(":")[1];
		oTd.setAttribute("id","zxStat"+(i+3));
		oTd.onmouseover=function(){this.className='tdOver'};
		oTd.onmouseout=function(){this.className='tdOut'};
		oTd.setAttribute("style","font-weight:bold");
		oTd.attachEvent("onclick",agentStateChanged(3,i)) ;
    }
    
	//添加管道
	for(var i=0;i<channelArray.length;i++){
	    var choosedState=channelMaps.get(channelArray[i]).choosedState;
	    var channelName=channelMaps.get(channelArray[i]).name;
		if(choosedState == 0){
		 	channelChoosedState = staticChannelState[0];
		}else if(choosedState == 1){
		 	channelChoosedState = staticChannelState[1];
		}else if(choosedState == 2){
		 	channelChoosedState = staticChannelState[2];
		}
	    var gdStat_select = "gdStat"+(i+1)+"_select1";
	    var gdStatPadFrame_select = "gdStatPadFrame"+(i+1)+"_select1";
		var oTr = document.getElementById("channelStateTable").insertRow();
       
		oTr.attachEvent("onmouseover",t1(gdStat_select)) ;
		oTr.attachEvent("onmouseout",t2(gdStat_select)) ;
		
		oTr.attachEvent("onmouseover",t1(gdStatPadFrame_select)) ;
		oTr.attachEvent("onmouseout",t2(gdStatPadFrame_select)) ;
		
	    oTr.onmouseover=function(){t1(gdStat_select);this.className='tdOver'};
		oTr.onmouseout=function(){t2(gdStat_select);this.className='tdOut'};
        oTr.setAttribute("id","gdStat"+(i+1));

        var oTd1 = oTr.insertCell();
        oTd1.innerHTML="<img id='gdStat"+(i+1)+"Img' src='<%=contextPath%>/images/agent_image/left_space.gif' width='20' height='22' border='0' align='absmiddle'><span style='width:50px;'>"+channelName+"</span>";
		var oTd2 = oTr.insertCell();
		oTd2.innerHTML="<span id='gdStat"+(i+1)+"_stat1'>["+channelChoosedState+"]</span>";
        var oTd = oTr.insertCell();
		var insertHtml =" <img src=\"<%=contextPath%>/images/agent_image/sanjiao.gif\" width=\"5\" height=\"9\" border=\"0\" align=\"absmiddle\"> "+
                          "<iframe src=\"\" id=\"gdStatPadFrame"+(i+1)+"_select1\" frameborder=0 hspace=0 marginheight=0 marginwidth=0 style=\"position:absolute; width:82px; height:71px; display:none; z-index:480\"></iframe>"+
                          "<div id=\"gdStat"+(i+1)+"_select1\" style=\"margin-left:0px; display:none; position:absolute;　border:1px solid #8592B5; background-color:#FFFFFF; width: 80px; z-index:500 \">"+ 
                            "<table width=\"100%\" border=\"0\" cellspacing=\"0\" cellpadding=\"4\">";
		if( choosedState == 2){
		     insertHtml += "<tr>"+ 
                                "<td onMouseOver=\"this.className='tdOver';\" onMouseOut=\"this.className='tdOut'\""+ "onClick=\"setChannelState('gdStat"+(i+1)+"_select1','"+channelArray[i]+"','3');\">"+staticChannelState[3]+"</td> "+
                              "</tr> "+ 
                            "</table>"+ 
                          "</div>";
		}else{
			insertHtml += "<tr>"+ 
                                "<td onMouseOver=\"this.className='tdOver';\" onMouseOut=\"this.className='tdOut'\""+ "onClick=\"setChannelState('gdStat"+(i+1)+"_select1','"+channelArray[i]+"','0');\">"+staticChannelState[0]+"</td> "+
                              "</tr> "+
                             " <tr>"+ 
                                "<td onMouseOver=\"this.className='tdOver';\" onMouseOut=\"this.className='tdOut'\""+ "onClick=\"setChannelState('gdStat"+(i+1)+"_select1','"+channelArray[i]+"','1');\">"+staticChannelState[1]+"</td> "+
                              "</tr> "+
                              "<tr>"+ 
                                "<td onMouseOver=\"this.className='tdOver';\" onMouseOut=\"this.className='tdOut'\""+ "onClick=\"setChannelState('gdStat"+(i+1)+"_select1','"+channelArray[i]+"','2');\">"+staticChannelState[2]+"</td> "+
                              "</tr>"+ 
                            "</table>"+ 
                          "</div>";
		}
	
		oTd.innerHTML = insertHtml;
		oTd.setAttribute("width","10");
		
		if( choosedState == 2){
			document.getElementById("gdStatPadFrame"+(i+1)+"_select1").style.height = "25"; }
		else {
			document.getElementById("gdStatPadFrame"+(i+1)+"_select1").style.height = "71";}
	}
	showHideDiv('statMenu');
	showHideDiv('statMenuPadFrame');
	document.getElementById('statMenuPadFrame').style.height = document.getElementById('statMenu').clientHeight+2;
	
}

function setChannelState(id,channelKey,status){
	if(top.softPhone.getSoftphoneController()=="hardphone")return;
  	manualChangeChannelState(channelKey,status,0);
   	document.getElementById(id).style.display = "none";
 	document.getElementById('statMenu').style.display = "none";
 	document.getElementById('statMenuPadFrame').style.display = "none";
}

var agentStateChanged = function(stateValue,index){
  	return function()
  	{
  		if(top.softPhone.getSoftphoneController()=="hardphone")return;
    	manualChangeAgentState(stateValue,index);
		document.getElementById('statMenu').style.display = "none";
		document.getElementById('statMenuPadFrame').style.display = "none";
  	}
}

var t1 = function(id){
  	this.className='tdOver';
  	return function()
  	{
   		document.getElementById(id).style.display = "block";
  	}
}

var t2 = function(id){
  	return function()
  	{
   		document.getElementById(id).style.display = "none";
  	}
}

/*
 * change channel status 
 * status definition:
 * 0 ready
 * 1 notReady
 * 2 logout
 * 3 login 
*/
 function manualChangeChannelState(channelKey,status,changeType,offLineIndex){   
 	//alert("manualChangeChannelState("+channelKey+" "+status+" "+changeType+")");
	var channelObj = channelMaps.get(channelKey);
	var webContext=top.softPhone.getWebContext();
	if(channelObj == null || channelObj == undefined){
		return;
	}
	var type=-1;
	if(channelKey == 'Voice'){
		type = 0;
		if(channelObj.workingNumber>0){
			openMessageBox("<%=Function.getMultiLangItemContent("agent.convert.forbidden",request)%>.");
			return;
		}
	}else if(channelKey == 'Email'){
		type = 1;
	}else if(channelKey == 'Chat'){
		type = 2;
	}
	
	if(status == 2){
	    channelObj = channelMaps.get(channelKey);
		if(channelObj.workingNumber>0){
   			if(confirm('<%=Function.getMultiLangItemContent("agent.logout.Confirm",request)%> ?')){
    		}else return;
		}
	}
	
	//not ready
    if(status == 1){
		a = new Array(0,0);
		for(var i=0;i<channelArray.length;i++){
			if(channelArray[i] != channelKey){
    			channelObj = channelMaps.get(channelArray[i]);
				if(channelObj.workingNumber>0){
    				a[0]=a[0]+1;
				}else if(channelObj.choosedState==1 || channelObj.choosedState==2){
            		a[1]=a[1]+1;
				}
	  		}
		}
	 
		if(changeType==2 && (offLineIndex==-1|| offLineIndex==undefined) ){//select offseat and not aux
		 	openAUXBox(agentObj.offLineReasonList);
		 	return;
		 }else if(a[1]==channelArray.length-1){//only one channel is not netReady //changeType==0 ||changeType==1
		 	channelObj = channelMaps.get(channelKey);
		  	 if(offLineIndex==-1|| offLineIndex==undefined){
				openAUXBox(agentObj.offLineReasonList);		
				return;  	
		 	 }	 
		 }
	}

	if(status == 0){
	    agentObj.ifManualAUX=false;
		setDnReady(type);
	}else if(status == 1){
		agentObj.ifManualAUX=true;
		if(offLineIndex>=0){
			var reason = agentObj.offLineReasonList[offLineIndex].split(":")[0];			
			changeAgentToNotReady(reason); 
		}else
			setDnNotReady(type);
	}else if(status == 2){
		agentObj.ifManualAUX=false;
		logoutDn(type);
	}else if(status == 3){
		agentObj.ifManualAUX=false;
		loginDn(type);
	}
}

/*
 * change agent status 
 *
 * status definition:
 * 0 all ready 
 * 1 part ready;
 * 2 busy ;
 * 3 offSeat
 * 4 offLine
*/
function manualChangeAgentState(status,offLineIndex){
	var channelStateVaule=-1;
	if(status==0){
		if( agentObj.choosedState==4 ){
			openMessageBox("<%=Function.getMultiLangItemContent("agent.convert.forbidden",request)%>.");
			return;
		}
		channelStateVaule=0;
	}
	
    if(status==3 ){
		if(offLineIndex != -1){
			channelStateVaule=1;
			agentObj.ifManualAUX=true;
		}else{
			channelStateVaule=1;
			agentObj.offLineIndex=-1;
		}
	}
	if(status==4 ){
		channelStateVaule=2;
	}
	for(var i=0;i<channelArray.length;i++){
		var channelObj = channelMaps.get(channelArray[i]);
		if( channelObj!=null && channelObj.choosedState != 2){
			manualChangeChannelState(channelArray[i],channelStateVaule,2,offLineIndex);
			if(status==3)
				break;
		}
	}
}
</script>

	<tr>
    	<td width="155">
    		<iframe id="statMenuPadFrame" style="display:none"></iframe>
			<div id="statMenu" style="display:none">
                <table width="100%" border="0" cellspacing="0" cellpadding="0" id="agentStateTable">
                	<tr>
                		<td class="notCurrentMenu"><%=Function.getMultiLangItemContent("agent.status",request)%></td>
                	</tr>
                </table>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" id="channelStateTable">
                	<tr>
                		<td class="notCurrentMenu"><%=Function.getMultiLangItemContent("agent.change.channel.status",request)%></td>
                    	<td class="notCurrentMenu">&nbsp;</td>
                    	<td class="notCurrentMenu">&nbsp;</td>
                	</tr>
                </table>
        	</div>
		</td>
    	<td width="50" align="center" style="padding-right:5px;"><img src="<%=contextPath%>/images/agent_image/agentNotReady_disable.gif" id="agentStateImage" width="38" height="44" border="0"  onClick="viewAgentState();event.cancelBubble = true;" style="cursor:pointer"></td>
    </tr>
    <tr valign="top">
    	<td height="16" colspan="2" align="right"><span id="disStat"><%=Function.getMultiLangItemContent("agent.status.OffLine",request)%> </span>&nbsp;<span id="timerdisStatTimer">00:00&nbsp;&nbsp;</span>  </td>
	</tr>