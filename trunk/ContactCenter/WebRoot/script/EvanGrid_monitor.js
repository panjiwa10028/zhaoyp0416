// JavaScript Document
function MouseDownToResize(obj){
	obj.mouseDownX=event.clientX;
	obj.parentTdW=obj.parentElement.offsetWidth;
	obj.parentTableW=document.getElementById("dragAbleTable").offsetWidth;
	obj.setCapture();
}
function MouseMoveToResize(obj){
		if(!obj.mouseDownX) return false;
			var newWidth=obj.parentTdW*1+event.clientX*1-obj.mouseDownX;
			if(newWidth>25){
				obj.parentElement.style.width = newWidth;
				document.getElementById("dragAbleTable").style.width=obj.parentTableW*1+event.clientX*1-obj.mouseDownX;
		}
}
function MouseUpToResize(obj){
	obj.mouseDownX=0;
	obj.releaseCapture();
}


window.onload = function(){
//??????
var trl=document.getElementById("dataArea").getElementsByTagName("tr");

var normalColor = ""; //normal????
var normalColor2 = "#EEF5FE"; //normal????2
var overColor   = "#B2CFEE"; //mouseover????
var clickColor  = "#0d4b9e"; //???????
var normalFontColor  = "#000000"; //normal????
var clickFontColor  = "#ffffff"; //???????


for (i=0; i<trl.length; i++){
	
	if((i % 2) == 1){trl[i].className="interleaveColor";} //interleaveColor
	
	for(k=0;k<trl[i].cells.length;k++){ if(trl[i].cells[k].innerText.length >=2){trl[i].cells[k].title = trl[i].cells[k].innerText.substring(0,100);}}// title??

	trl[i].onmouseover = function rty1(){	 if (this.style.backgroundColor != clickColor) {this.style.backgroundColor = overColor;this.style.cursor = "pointer";}}//onmouseover

	if((i % 2) == 0){	trl[i].onmouseout =  function rty21(){	if (this.style.backgroundColor != clickColor) {this.style.backgroundColor = normalColor;  }}}
	if((i % 2) == 1){	trl[i].onmouseout =  function rty22(){	if (this.style.backgroundColor != clickColor) {this.style.backgroundColor = normalColor2; }}}	
	
	trl[i].onclick = function rty3(){	
		if (this.style.backgroundColor == clickColor){ //????
			this.style.backgroundRepeat = "no-repeat";
		}
		for (j=0; j<trl.length; j++){
				trl[j].style.backgroundColor = normalColor;
				for(k=0;k<trl[j].cells.length;k++){trl[j].cells[k].style.color = normalFontColor;}
		}
			if (this.style.backgroundRepeat == "no-repeat"){ 
					this.style.backgroundColor = normalColor; 
					this.style.backgroundRepeat = "";
					for(k=0;k<this.cells.length;k++){this.cells[k].style.color = normalFontColor;}
			}
			else{	 this.style.backgroundColor = clickColor; 
					 for(k=0;k<this.cells.length;k++){this.cells[k].style.color = clickFontColor;}
			}
			return true;
	}
}
//????
var thl=document.getElementById("dragAbleTable").getElementsByTagName("th");
	for(i=0;i<thl.length;i++){
		thl[i].innerHTML = "<font class='resizeDivClass' onmousedown='MouseDownToResize(this);' onmousemove='MouseMoveToResize(this);' onmouseup='MouseUpToResize(this);'></font>" +thl[i].innerHTML;
	}
}