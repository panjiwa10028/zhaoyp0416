// 	2007-05-23
// 	Evan.bian

//obj=object;sh=showHide;
//preLoad:--images/ban_bottom_left02.gif;images/ban_bottom_left03.gif



// for drag & drop --------- start
move = null; 
hmin = 0; 
hmax =400;
wmin = 200;
queue_wmin = 90; 
zmax = 1;
ssize = 4; 
var offsetSize= 50;
var offsetPageBorder = 32;
function Down(obj,padVar){
  move = 1;
  obj.x = event.x; 
  obj.y = event.y;
  obj.l = obj.offsetParent.offsetLeft; 
  obj.t = obj.offsetParent.offsetTop;
  obj.w = obj.offsetParent.offsetWidth;
  obj.h = obj.offsetParent.offsetHeight;
  if (padVar == null) popPad(obj);
  obj.setCapture(); 
}

function Remove(obj,padVar){
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

   if (padVar == null) popPad(obj);
   }
}

function Resize(obj,padVar){
  if(move != null){
   obj.offsetParent.style.width = Math.max(wmin, event.x - obj.x + obj.w); 
  // obj.offsetParent.style.height = Math.max(hmin, event.y - obj.y + obj.h -offsetSize);
   var pHeight = Math.max(hmin, event.y - obj.y + obj.h -offsetSize);
   if(pHeight < hmax){obj.offsetParent.style.height = pHeight;}
   if (padVar == null) popPad(obj);
  }
}

function ResizeH(obj,padVar){
  if(move != null){
			//obj.offsetParent.style.height = Math.max(hmin, event.y - obj.y + obj.h -offsetSize);
			 var pHeight = Math.max(hmin, event.y - obj.y + obj.h -offsetSize);
  			 if(pHeight < hmax){obj.offsetParent.style.height = pHeight;}
			if (padVar == null) mainIframe.centerContentFrame.rows = (document.getElementById('popTable1').clientHeight)+',*';
  }
}

 function Hresize(obj){
  if(move != null){
   obj.offsetParent.style.width = Math.max(queue_wmin, event.x - obj.x + obj.w); 
  }
 }
 
 
function ResizeVertical(obj,padVar){
  if(move != null){
   //obj.offsetParent.style.height = Math.max(hmin, event.y - obj.y + obj.h -offsetSize);
    var pHeight = Math.max(hmin, event.y - obj.y + obj.h -offsetSize);
   if(pHeight < hmax){obj.offsetParent.style.height = pHeight;}
   if (padVar == null) popPad(obj);
  }
}
 
function Up(obj){
  move = null;
  //document.getElementById("popPad").style.visibility = "hidden";
  obj.releaseCapture(); 
}

function Focus(obj,padVar){
  zmax = zmax +10; 
 // obj.style.zIndex = zmax; 
   if (padVar == null) document.getElementById("popPad").style.zIndex = zmax-1;
}
function popPad(obj){
if(isMesFloat == 1){
	document.getElementById("popPad").style.left = obj.offsetParent.offsetLeft;
	document.getElementById("popPad").style.top = obj.offsetParent.offsetTop;
	document.getElementById("popPad").style.width = obj.offsetParent.offsetWidth;
	document.getElementById("popPad").style.height = obj.offsetParent.offsetHeight;
	document.getElementById("popPad").style.visibility = "visible";
	}
}
// for drag & drop --------- end

//The following section is for float dropdown menu    ---------start
var lastFloatMenuObject = null;
var currentFloatMenuObject = null;

function setHideAllFloatMenu(_lastFloatMenuObject){
	currentFloatMenuObject = _lastFloatMenuObject;
}

function hideAllFloatMenu(){
	if(lastFloatMenuObject==null){
		lastFloatMenuObject = currentFloatMenuObject;
		currentFloatMenuObject = null;
	}else if(lastFloatMenuObject !=currentFloatMenuObject){
		try{
			lastFloatMenuObject.style.display = "none";
		}catch(e){
		}
		lastFloatMenuObject = currentFloatMenuObject;
		currentFloatMenuObject = null;
	}
}
// for float dropdown menu    --------- end



