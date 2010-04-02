var isPinFloat = false; //0=??pin float,1=pin float
function initSize(){ //??????????
var bheight = document.documentElement.clientHeight-document.getElementById("topDiv").offsetHeight-32;//???????,??????32???????
	//alert(document.getElementById("topDiv").offsetHeight);
	document.getElementById("mainIframe").style.height = bheight;
	document.getElementById("floatRightDiv").style.height = bheight-22; //22????????
	document.getElementById("floatRightFrame").style.height = bheight-22;
	
	
	bwidth  = document.documentElement.clientWidth;//????
	document.getElementById("marqueeMessage").style.width = bwidth-205-15-90*1; //?????--205?????????15?????????????90????????
}

function closeFloat(){
	if(isPinFloat==false){hideDiv('floatRightDiv')}
	else{
		document.getElementById("sensorRight").style.width = 20;
		document.getElementById("floatRightDiv").style.marginLeft = -200;
		hideDiv('floatRightDiv');
		isPinFloat = false;
	}
}

function showHideDiv(divId){if(document.getElementById(divId).style.display == "none"){document.getElementById(divId).style.display = "block";	}else{document.getElementById(divId).style.display = "none";}}
function showDiv(divId){document.getElementById(divId).style.display = "block";}
function hideDiv(divId){document.getElementById(divId).style.display = "none";}
function canHideDiv(divId){
	if(isPinFloat==false){
		hideDiv(divId)
	}else
	{
		return false;
	}
}

function pinFloat(){
if(isPinFloat == false){
		document.getElementById("sensorRight").style.width = 220;
		document.getElementById("floatRightDiv").style.marginLeft = 0;
		document.getElementById("pinText").innerText = "Realse";
		isPinFloat = true;
	}
	else{
		document.getElementById("sensorRight").style.width = 20;
		document.getElementById("floatRightDiv").style.marginLeft = -200;
		document.getElementById("pinText").innerText = "Pin";
		isPinFloat = false;
	}
}

function changeSrc(target,url){
	document.getElementById(target).src = url;
}



function goTop(){
	hideDiv("popTable");
	mainIframe.centerContentFrame.rows = "175,*,0";
	mainIframe.centerContentFrame.frameSpacing = "3";
	mainIframe.topNull.location.href = "common/pop.htm";
	mainIframe.bottomNull.location.href = "common/null.htm";
}

function goBottom(){
	hideDiv("popTable");
	mainIframe.centerContentFrame.rows = "0,*,175";
	mainIframe.centerContentFrame.frameSpacing = "3";
	mainIframe.topNull.location.href = "common/null.htm";
	mainIframe.bottomNull.location.href = "common/pop.htm";
}


//----for marquee start---------------------//
 var marqueeFlag = 0; //0 ????1???
 function marqueeDBclick(){
	 if(marqueeFlag == 1){ document.getElementById("marqueeMessage").start();marqueeFlag = 0;}
	 else { document.getElementById("marqueeMessage").stop(); marqueeFlag = 1; }
 }
 function marqueeMouseOut(){
	 if(marqueeFlag == 1){ return false; }
	 else { document.getElementById("marqueeMessage").start(); }
 }
 function marqueeMouseOver(){
	 if(marqueeFlag == 1){ return false; }
	 else { document.getElementById("marqueeMessage").stop(); }
 }
//----for marquee end---------------------// 
 
 
 
//**************for layout icon start************************// 
function shLeft(){
if(mainIframe.mainFrame.cols == "200,*"){
		mainIframe.mainFrame.cols = "0,*";
		mainIframe.mainFrame.frameSpacing = "0";
	}
	else{
		mainIframe.mainFrame.cols = "200,*";
		mainIframe.mainFrame.frameSpacing = "3";
	}
}
function shRight(){
	showHideDiv('sensorRight');
}

function shFloat(){
if(mainIframe.centerContentFrame.rows == "0,*,0"){showHideDiv('popTable');}//??????
else{//???frame?
var currentCenterContentFrameRows = mainIframe.centerContentFrame.rows; // ??????rows

if(currentCenterContentFrameRows != "0,*,-1"){
		setCenterContentFrameRows = currentCenterContentFrameRows;//???????????????rows
		mainIframe.centerContentFrame.rows = "0,*,-1";
		mainIframe.centerContentFrame.frameSpacing = "0";
	}
	else{
		mainIframe.centerContentFrame.rows = setCenterContentFrameRows;//??????rows
		mainIframe.centerContentFrame.frameSpacing = "3";
	}
}
}
//**************for layout icon end************************// 

 move = null; 
 wmin = 100; 
 zmax = 10000;
 ssize = 4; 
 function Down(obj){
  move = 1;
  obj.x = event.x; 
  obj.y = event.y;
  obj.l = obj.offsetParent.offsetLeft; 
  obj.t = obj.offsetParent.offsetTop;
  obj.w = obj.offsetParent.offsetWidth;
  obj.h = obj.offsetParent.offsetHeight;
  Shadow(obj) 
  obj.setCapture(); 
 }

 function Remove(obj){
  if(move != null){
  
		//limit the obj's x position in the window
		if(obj.offsetParent.offsetLeft + obj.w >= offsetPageBorder && obj.offsetParent.offsetLeft <= document.documentElement.clientWidth-offsetPageBorder){ //if obj in the window,obj can be drag
			obj.offsetParent.style.left = event.x - obj.x + obj.l; 
			}
		if(obj.offsetParent.offsetLeft + obj.w < offsetPageBorder){//obj in the left of window,obj go back automatic
				obj.offsetParent.style.left = offsetPageBorder-obj.w; 
			}
		if(obj.offsetParent.offsetLeft > document.documentElement.clientWidth-offsetPageBorder){//obj in the right of window,obj go back automatic
				obj.offsetParent.style.left = document.documentElement.clientWidth-offsetPageBorder; 
			}
		
		//limit the obj's Y position in the window
		if(obj.offsetParent.offsetTop >= 0 && obj.offsetParent.offsetTop <= document.documentElement.clientHeight-obj.h){
			obj.offsetParent.style.top = event.y - obj.y + obj.t;
			}
		if(obj.offsetParent.offsetTop < 0){
				obj.offsetParent.style.top = 0; 
			}
		if(obj.offsetParent.offsetTop > document.documentElement.clientHeight-obj.h){
				obj.offsetParent.style.top = document.documentElement.clientHeight-obj.h; 
			}
   Shadow(obj) 
   }
 }

 function Resize(obj){
  if(move != null){
   obj.offsetParent.style.width = Math.max(wmin, event.x - obj.x + obj.w); 
   obj.offsetParent.style.height = Math.max(wmin, event.y - obj.y + obj.h -32);
   Shadow(obj) ;
  }
 }

 function Up(obj){
  move = null;
  document.getElementById('shadow').style.visibility = 'hidden'; 
  obj.releaseCapture(); 
 }

 function Focus(obj){
  zmax = zmax +10; 
  obj.style.zIndex = zmax; 
  document.getElementById('shadow').style.zIndex = zmax - 1; 
 }

 function Shadow(obj){
  document.getElementById('shadow').style.left = obj.offsetParent.offsetLeft + ssize;
  document.getElementById('shadow').style.top = obj.offsetParent.offsetTop + ssize;
  document.getElementById('shadow').style.width = obj.offsetParent.offsetWidth;
  document.getElementById('shadow').style.height = obj.offsetParent.offsetHeight;
  document.getElementById('shadow').style.visibility = 'visible';
 }