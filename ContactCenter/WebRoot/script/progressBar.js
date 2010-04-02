var progressInterval = 200; // set to time between updates (milli-seconds)

var progressAt = 0;
var progressEnd = 100;
var progressColor = "blue";
var num = 0;
var progressTimer;

function waiting(waitingInfo) {
	progressAt ++;
 	num ++;
 	if(progressAt > 10){
   		progressAt = 0;
   	}
 
 	if(num > 8){
 		num = 1;
 	}
 
 	if(document.getElementById("Layer"+num).style.display == "block"){
 		document.getElementById("Layer"+num).style.display = "none";
 	}
 	else{
 		document.getElementById("Layer"+num).style.display = "block";
 	}
 	
 	var waitingInfoDiv = document.getElementById("waitingInfo");
	var divLoadTextDiv = document.getElementById("divLoadText");
 	waitingInfoDiv.style.display = "";
 	
 	
 	var str = "<table align='center' width='100%' height='100%'><tr><td align='right' width='50%'>";
	str += waitingInfo + "</td><td valign='middle'>"
   	for(i = 0;i < progressAt;i ++){
   		str += "<font size=5 color='#37A33F'><bold>.</bold></font>";
   	}
   	str += "</td></tr></table>";
   	
   
   	divLoadTextDiv.innerHTML = str;

 	progressTimer = window.setTimeout("waiting('" + waitingInfo + "')",progressInterval);
}

function progressBar() {
	progressAt ++;
 	num ++;
 	if (progressAt > progressEnd){
 		progress_stop();
 	}
 	else{
 	    if(num > 8){
 	       num = 1;
 	    }
 	    
 	    if(document.getElementById("Layer"+num).style.display == "block"){
 	        document.getElementById("Layer"+num).style.display = "none";
 	    }
 	    else{
 	        document.getElementById("Layer"+num).style.display = "block";
 	    }
 	  
 		var waitingInfoDiv = document.getElementById("waitingInfo");
		var divLoadTextDiv = document.getElementById("divLoadText");
 		waitingInfoDiv.style.display = "";
 		
 		var str = "<table align='center' width='100%' height='100%' border='0' cellpadding='0' cellspacing='0'><tr>";
   		str += "<td WIDTH='" + progressAt + "%' bgcolor='#000080' align='center'><font color='#FFFFFF'>" + 
   				progressAt + "%</font></td>";
   		str += "<td width='" + (100-progressAt) + "%'></td></tr></table>";
   				divLoadTextDiv.innerHTML = str;
		
		if(progressAt > 90){
			progressInterval = 500;
		}
		
		//if(progressAt == 98){
			//progressAt --;
		//}
 		progressTimer = window.setTimeout("progressBar()",progressInterval);
 	}
}

function progressBarUtil(){
	progressAt = 99;
	progressInterval = 1;
	progressBar();
}


function progress_stop() {
 	window.clearTimeout(progressTimer);
}
