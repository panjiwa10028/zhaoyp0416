function viewTime() {
    	if (top.win.top.seconds == undefined) {
    		viewTime2();
    		return;
    	}
    	
	    var hour=0;
	    var hour1=0;
	    var hour2=0;  
	    var minute=0;      
	    var minute1=0;
	    var minute2=0;
	    var second=0;
	    var second1=0;
	    var second2=0;
	 
		top.win.top.seconds++;
	    if (top.win.top.seconds == 60) {
	        top.win.top.seconds = 0;
	        top.win.top.minutes += 1;
	    }
	    if (top.win.top.minutes == 60) {
	        top.win.top.minutes = 0;
	        top.win.top.hours += 1;
	    }
	
		top.win.top.timesValues = ((top.win.top.hours < 10) ? "0" : "") + top.win.top.hours;
		top.win.top.timesValues += ((top.win.top.minutes < 10) ? ":0" : ":") + top.win.top.minutes;
		top.win.top.timesValues += ((top.win.top.seconds < 10) ? ":0" : ":") + top.win.top.seconds;
		
		if(top.win.top.tmpTime!=top.win.top.currentTime)
	    {
	         top.win.top.tmpTime=top.win.top.tempTimer;
	         top.win.top.totalNumber=top.win.top.totalNumber+1;
	         if(top.win.top.tmpTime!="")
	         {
	            hour1=top.win.top.totalTimer.substring(0,top.win.top.totalTimer.indexOf(":"));
	            minute1=top.win.top.totalTimer.substring(top.win.top.totalTimer.indexOf(":")+1,top.win.top.totalTimer.lastIndexOf(":"));
	            second1=top.win.top.totalTimer.substring(top.win.top.totalTimer.lastIndexOf(":")+1,top.win.top.totalTimer.length);
	            
	            hour2=top.win.top.tmpTime.substring(0,top.win.top.tmpTime.indexOf(":"));
	            minute2=top.win.top.tmpTime.substring(top.win.top.tmpTime.indexOf(":")+1,top.win.top.tmpTime.lastIndexOf(":"));
	            second2=top.win.top.tmpTime.substring(top.win.top.tmpTime.lastIndexOf(":")+1,top.win.top.tmpTime.length);
	            
	            second=parseInt(second1)+parseInt(second2);
	            minute=parseInt(minute1)+parseInt(minute2);
	            hour=parseInt(hour1)+parseInt(hour2);
	            if(second>=60)
	            {
	               second=second-60;
	               minute=minute+1;
	            }
	            if(minute>=60)
	            {
	               minute=minute-60;
	               hour=hour+1;
	            }
	            
	            top.win.top.totalTimer = ((hour < 10) ? "0" : "") + hour;
		        top.win.top.totalTimer += ((minute < 10) ? ":0" : ":") + minute;
		        top.win.top.totalTimer += ((second < 10) ? ":0" : ":") + second;                        
	         }
	         top.win.top.tmpTime=top.win.top.currentTime;
	    }
	    //top.win.top.viewTime();
		setTimeout("viewTime()", 1000);
    }
    
function viewTime2() {

	    var hour=0;
	    var hour1=0;
	    var hour2=0;  
	    var minute=0;      
	    var minute1=0;
	    var minute2=0;
	    var second=0;
	    var second1=0;
	    var second2=0;
	 
		top.win.top.win.top.seconds++;
	    if (top.win.top.win.top.seconds == 60) {
	        top.win.top.win.top.seconds = 0;
	        top.win.top.win.top.minutes += 1;
	    }
	    if (top.win.top.win.top.minutes == 60) {
	        top.win.top.win.top.minutes = 0;
	        top.win.top.win.top.hours += 1;
	    }
	
		top.win.top.win.top.timesValues = ((top.win.top.win.top.hours < 10) ? "0" : "") + top.win.top.win.top.hours;
		top.win.top.win.top.timesValues += ((top.win.top.win.top.minutes < 10) ? ":0" : ":") + top.win.top.win.top.minutes;
		top.win.top.win.top.timesValues += ((top.win.top.win.top.seconds < 10) ? ":0" : ":") + top.win.top.win.top.seconds;
		
		if(top.win.top.win.top.tmpTime!=top.win.top.win.top.currentTime)
	    {
	         top.win.top.win.top.tmpTime=top.win.top.win.top.tempTimer;
	         top.win.top.win.top.totalNumber=top.win.top.win.top.totalNumber+1;
	         if(top.win.top.win.top.tmpTime!="")
	         {
	            hour1=top.win.top.win.top.totalTimer.substring(0,top.win.top.win.top.totalTimer.indexOf(":"));
	            minute1=top.win.top.win.top.totalTimer.substring(top.win.top.win.top.totalTimer.indexOf(":")+1,top.win.top.win.top.totalTimer.lastIndexOf(":"));
	            second1=top.win.top.win.top.totalTimer.substring(top.win.top.win.top.totalTimer.lastIndexOf(":")+1,top.win.top.win.top.totalTimer.length);
	            
	            hour2=top.win.top.win.top.tmpTime.substring(0,top.win.top.win.top.tmpTime.indexOf(":"));
	            minute2=top.win.top.win.top.tmpTime.substring(top.win.top.win.top.tmpTime.indexOf(":")+1,top.win.top.win.top.tmpTime.lastIndexOf(":"));
	            second2=top.win.top.win.top.tmpTime.substring(top.win.top.win.top.tmpTime.lastIndexOf(":")+1,top.win.top.win.top.tmpTime.length);
	            
	            second=parseInt(second1)+parseInt(second2);
	            minute=parseInt(minute1)+parseInt(minute2);
	            hour=parseInt(hour1)+parseInt(hour2);
	            if(second>=60)
	            {
	               second=second-60;
	               minute=minute+1;
	            }
	            if(minute>=60)
	            {
	               minute=minute-60;
	               hour=hour+1;
	            }
	            
	            top.win.top.win.top.totalTimer = ((hour < 10) ? "0" : "") + hour;
		        top.win.top.win.top.totalTimer += ((minute < 10) ? ":0" : ":") + minute;
		        top.win.top.win.top.totalTimer += ((second < 10) ? ":0" : ":") + second;                        
	         }
	         top.win.top.win.top.tmpTime=top.win.top.win.top.currentTime;
	    }
	    //top.win.top.win.top.viewTime();
		setTimeout("viewTime2()", 1000);
    }
    
//viewTime();    

var timerID = '';
function showTime() {
	if (top.win.top.second == undefined) {
		showTime2();
		return;
	}
	if (top.win.top.timerRunning) {
		top.win.top.second++;

	    if (top.win.top.second == 60) {
	        top.win.top.second = 0;
	        top.win.top.minute += 1;
	    }
	    if (top.win.top.minute == 60) {
	        top.win.top.minute = 0;
	        top.win.top.hour += 1;
	    }
	
		var timeValue = ((top.win.top.hour < 10) ? "0" : "") + top.win.top.hour;
		timeValue += ((top.win.top.minute < 10) ? ":0" : ":") + top.win.top.minute;
		timeValue += ((top.win.top.second < 10) ? ":0" : ":") + top.win.top.second;
	
	    if (top.win.top.document.all.timer) {
		    top.win.top.document.all.timer.value = timeValue;
		}

		timerID = setTimeout("showTime()", 1000);
	} else {
		if (timerID != '') {
			clearTimeout(timerID);
			timerID = '';
		}
	}
}

function showTime2() {
	if (top.win.top.win.top.timerRunning) {
		top.win.top.win.top.second++;

	    if (top.win.top.win.top.second == 60) {
	        top.win.top.win.top.second = 0;
	        top.win.top.win.top.minute += 1;
	    }
	    if (top.win.top.win.top.minute == 60) {
	        top.win.top.win.top.minute = 0;
	        top.win.top.win.top.hour += 1;
	    }
	
		var timeValue = ((top.win.top.win.top.hour < 10) ? "0" : "") + top.win.top.win.top.hour;
		timeValue += ((top.win.top.win.top.minute < 10) ? ":0" : ":") + top.win.top.win.top.minute;
		timeValue += ((top.win.top.win.top.second < 10) ? ":0" : ":") + top.win.top.win.top.second;
	
	    if (top.win.top.win.top.document.all.timer) {
		    top.win.top.win.top.document.all.timer.value = timeValue;
		}

		timerID = setTimeout("showTime()", 1000);
	} else {
		if (timerID != '') {
			clearTimeout(timerID);
			timerID = '';
		}
	}
}

function showDialogMMTime(key) {
	var objTimers = top.win.top.timerIDs.get(key);
	if(objTimers == null || objTimers == undefined){
		objTimers = new top.win.top.TimerObj(key);
	}
	objTimers.second++;
    
    if (objTimers.second == 60) {
        objTimers.second = 0;
        objTimers.minute += 1;
    }
    if (objTimers.minute == 60) {
        objTimers.minute = 0;
        objTimers.hour += 1;
    }
	
	objTimers.timeValue = ((objTimers.minute < 10) ? "0" : "") + objTimers.minute;
	objTimers.timeValue += ((objTimers.second < 10) ? ":0" : ":") + objTimers.second;
	if(objTimers.hour>0)	
		objTimers.timeValue = ((objTimers.hour < 10) ? "0" : "") + objTimers.hour + ":" + objTimers.timeValue;

    top.win.top.document.getElementById("timer"+key+"").innerText = objTimers.timeValue;
	
	objTimers.timeoutObj = setTimeout("showDialogMMTime('"+key+"')", 1000);
	objTimers.timerRunning = true;
	top.win.top.timerIDs.put(key,objTimers);
}