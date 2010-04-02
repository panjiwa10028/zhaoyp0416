

//DHTML Window script- Copyright Dynamic Drive (http://www.dynamicdrive.com)
//For full source code, documentation, and terms of usage,
//Visit http://www.dynamicdrive.com/dynamicindex9/dhtmlwindow.htm

var dragapproved=false
var minrestore=0
var initialwidth,initialheight
var ie5=document.all&&document.getElementById
var ns6=document.getElementById&&!document.all
var divCustomer;
function iecompattest(){
	return (!window.opera && document.compatMode && document.compatMode!="BackCompat")? document.documentElement : document.body
}

function drag_drop(e){
	if (ie5&&dragapproved&&event.button==1){
		if (event.screenY < 30 ||(event.screenY > screen.availHeight-50)) {
			return;
		}
		divCustomer.style.top=tempy+event.screenY-offsety+"px"
		
		if (event.screenX < window.screenLeft + 20 || event.screenX > screen.availWidth -20 || event.screenX > window.screenLeft + screen.availWidth-20) {
			return;
		}		
		divCustomer.style.left=tempx+event.screenX-offsetx+"px"
	} else if (ns6&&dragapproved){
		if (e.screenY < 30 ||(e.screenY > screen.availHeight-50)) {
			return;
		}
		divCustomer.style.top=tempy+e.screenY-offsety+"px"
		
		if (e.screenX < 20 || e.screenX > screen.availWidth - 20 || e.screenX > window.screenLeft + screen.availWidth-20) {
			return;
		}
		divCustomer.style.left=tempx+e.screenX-offsetx+"px"		
	}
}

function initializedrag(e){
	divCustomer = document.getElementById("divCustomer");
	
	//offsetx=ie5? event.clientX : e.clientX
	//offsety=ie5? event.clientY : e.clientY
	offsetx=e.screenX
	offsety=e.screenY
	
	tempx=parseInt(divCustomer.style.left)
	tempy=parseInt(divCustomer.style.top)

	dragapproved=true
	divCustomer.onmousemove=drag_drop
	divCustomer.setCapture();
}

function loadwindow(url,width,height){
	if(divCustomer==null || divCustomer == undefined ){
		divCustomer =document.getElementById("divCustomer");
	}
	if (!ie5&&!ns6)
		window.open(url,"","width=width,height=height,scrollbars=1")
	else{
		var winWidth=iecompattest().scrollWidth;
		var x =winWidth-width-2+"px"
		var y =ns6? window.pageYOffset*1+118+"px" : iecompattest().scrollTop*1+118+"px"

		if (strOffsetX != '') {
			if (parseInt(strOffsetX) >=0) {
				x =strOffsetX+"px"
			} else {
				x =parseInt(winWidth)+parseInt(strOffsetX)+"px"
			}
		}
		if (strOffsetY != '') {
			if (parseInt(strOffsetY) >=0) {
				y =strOffsetY+"px"
			} else {
				y =parseInt(iecompattest().scrollHeight)+parseInt(strOffsetY)+"px"
			}
		}
		divCustomer.style.display=''
		divCustomer.style.width=initialwidth=width+"px"
		divCustomer.style.height=initialheight=height+"px"

		divCustomer.style.left=x;
		divCustomer.style.top=y;
	}
}

function maximize(){
	if(divCustomer==null || divCustomer == undefined ){
		divCustomer =document.getElementById("divCustomer");
	}
	if (minrestore==0){
		minrestore=1 //maximize window
		document.getElementById("maxname").setAttribute("src","restore.gif")
		divCustomer.style.width=ns6? window.innerWidth-20+"px" : iecompattest().clientWidth+"px"
		divCustomer.style.height=ns6? window.innerHeight-20+"px" : iecompattest().clientHeight+"px"
	} else {
		minrestore=0 //restore window
		document.getElementById("maxname").setAttribute("src","max.gif")
		divCustomer.style.width=initialwidth
		divCustomer.style.height=initialheight
	}
	
	divCustomer.style.left=ns6? window.pageXOffset+"px" : iecompattest().scrollLeft+"px"
	divCustomer.style.top=ns6? window.pageYOffset+"px" : iecompattest().scrollTop+"px"
}

function closeit(){
	top.document.getElementById("divCustomer").style.display="none"
}

function stopdrag(){
	if(divCustomer==null || divCustomer == undefined ){
		divCustomer =top.document.getElementById("divCustomer");
	}
	
	divCustomer.releaseCapture();
	dragapproved=false;
}