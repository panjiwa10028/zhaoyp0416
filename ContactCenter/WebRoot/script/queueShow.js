var queueUseContextPath = "";
var qColor = new Array();
qColor[0] = "red";//all color
qColor[1] = "green";
qColor[2] = "blue";
qColor[3] = "yellow";//like #ff0055 is be allowed too!
qColor_length = 3;//color size
var t=20000;//refurbish time
var isShowZero = true;
var showBackgroundColor = "#FFFFFF";

function initQueueShow(contextPathParameter){
	queueUseContextPath = contextPathParameter;
//	t_queue.style.top = 95;//the show area's init top
//	t_queue.style.left = document.body.scrollWidth - 200;//the show area's init left
//	t_queue.style.backgroundColor = showBackgroundColor;
	if(strStatServerAvailableThisPage == '1')
	{
		strQueue.style.display="block";
		setTimeout('changeimg('+n+')',0);
	}
	QueueAjax();
	queueFlag=1;//??????queue??
}

function QueueAjax()
{
	try{
		top.jsonrpc.asm.setCallback(afterSetCallBack,true);
 		top.jsonrpc.asm.getQueueValues(callBackQueue);
 	}catch(e){
	}
}

function afterSetCallBack(){ 
    //do nothing 
} 

function callBackQueue(result,exception){
	var strValue = result;
	if(strValue == null){
		strValue = "";
	}
	parseQueueValue(strValue);
}

//????????????????
var playFile;
var queueList = new Array();
var queuelength=1;
var queueFlag=0;

var colorIndex = 0;
function parseQueueValue(strValue)	//parse queue
{
	playFile= new Array();
	var queueNum = strValue;
	queueList=queueNum.split("|");
	queuelength=queueList.length;
	if(queuelength==1)
	{
	 playFile="";
	}
	else
	{
		var queueName=new Array();
		var queueCount=new Array();
		for(var i=0;i<queuelength-1;i++)
		{
			colorIndex = i%qColor_length;
			queueName[i]=queueList[i].substring(0,queueList[i].indexOf(":"));
			queueCount[i]=queueList[i].substring(queueList[i].indexOf(":")+1,queueList[i].length);
			if(queueCount[i]==0||queueCount[i]=='0'){
				if(isShowZero){
					playFile[i]="<font color='"+qColor[colorIndex]+"'>"+queueName[i]+queueShowTitle+queueCount[i]+"</font>";	
				}
			}else{
				playFile[i]="<font color='"+qColor[colorIndex]+"'>"+queueName[i]+queueShowTitle+queueCount[i]+"</font>";	
			}
		}
	}
}
/*
function processAjaxResponse()
{
	if(this.xmlServerHttp!=null){
	playFile= new Array();
	var readyState = this.xmlServerHttp.readyState;
	var req = this.xmlServerHttp;
	if(readyState == 4){
		if(this.xmlServerHttp.status == 200)
	    {
			var queueNum = req.responseText;
			queueList=queueNum.split("|");
			queuelength=queueList.length;
			if(queuelength==1)//???????
			{
			 playFile="";
			}
			else
			{
				var queueName=new Array();
				var queueCount=new Array();
				for(var i=0;i<queuelength-1;i++)
				{
					colorIndex = i%qColor_length;
					queueName[i]=queueList[i].substring(0,queueList[i].indexOf(":"));
					queueCount[i]=queueList[i].substring(queueList[i].indexOf(":")+1,queueList[i].length);
					if(queueCount[i]==0||queueCount[i]=='0'){
						if(isShowZero){
							playFile[i]="<font color='"+qColor[colorIndex]+"'>"+queueName[i]+queueShowTitle+queueCount[i]+"</font>";	
						}
					}else{
						playFile[i]="<font color='"+qColor[colorIndex]+"'>"+queueName[i]+queueShowTitle+queueCount[i]+"</font>";	
					}
				}
			}
				
			
	    
	    }
    }
}
}

var xmlServerHttp = null;
function executeXhr2(callback,url){
  if (window.XMLHttpRequest) {//not IE
	req = new XMLHttpRequest();
	req.onreadystatechange = callback;
	req.open("GET", url, false);
	req.send(null);
  } // branch for IE/Windows ActiveX version
  else if (window.ActiveXObject) {
	try{ 
	  try {
		xmlServerHttp = new ActiveXObject("Msxml2.ServerXMLHTTP");
	  }
	  catch (e) {
	  	  //alert("1:"+e.description);
		  try {
			xmlServerHttp = new ActiveXObject("MSXML2.ServerXMLHTTP");
		  }
		  catch (e) {
			//alert("2:"+e.description);
		  }
	  }

	  var   lResolve = 5*1000;
	  var   lConnect = 5*1000;
	  var   lSend = 10*100;
	  var   lReceive = 20*100;

	  xmlServerHttp.onreadystatechange = function(){
		processAjaxResponse();
	  };
	  
	  xmlServerHttp.setTimeouts(lResolve,lConnect,lSend,lReceive);
	  xmlServerHttp.open("GET", url,   false);
	  xmlServerHttp.send();
	  }catch(e){
	  	//alert(e.message);
	  }
  }
  
}
*/

n=0;
function changeimg(n){//n:playFile???		
	if(queuelength==1)
	{
		if(queueFlag==0)
		{                
			QueueAjax(); 
		}
		else if(queueFlag==1)//?????queue?
		{
			queueFlag=0;
		}            
		if(playFile == undefined || playFile == 'undefined')
			playFile = '';
		document.getElementById("message").innerHTML = playFile;
		setTimeout('changeimg('+n+')',t);
    }
	else
	{
		if (n>=queuelength-1)
		{
			QueueAjax();				 
			n=0;
		}
		if(playFile=="")//??????
		{
			//document.getElementById("message").innerHTML = playFile;
			setTimeout('changeimg('+n+')',t);
		}
		else
		{
			if(playFile[n] != undefined && playFile[n] != 'undefined'){
				document.getElementById("message").innerHTML = playFile[n];n++;setTimeout('changeimg('+n+')',t);
			}else{
				n++;setTimeout('changeimg('+n+')',t);
			}
		}
	}
		
}