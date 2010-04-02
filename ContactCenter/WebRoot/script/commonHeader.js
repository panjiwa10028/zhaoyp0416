function MM_preloadImages() { //v3.0
  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function MM_showHideLayers() { //v6.0
  var i,p,v,obj,args=MM_showHideLayers.arguments;
  for (i=0; i<(args.length-2); i+=3) if ((obj=MM_findObj(args[i]))!=null) { v=args[i+2];
    if (obj.style) { obj=obj.style; v=(v=='show')?'visible':(v=='hide')?'hidden':v; }
    obj.visibility=v; }
}
function MM_swapImage() { //v3.0
      var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)

      if ((x=MM_findObj(a[i]))!=null){
		  var t = x.src;
		  if(t.charAt(t.indexOf(".gif")-1)=="3"){
		      return;
		  }
		  document.MM_sr[j++]=x; 
		  if(!x.oSrc) 
			  x.oSrc=x.src; 
		 x.src=a[i+2];
		}
}
function MM_swapImgRestore() { //v3.0
	var i,x,a=document.MM_sr;
	var b=document.image_flag;
    for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) {
		if(b && b[0] == x);
		else
			x.src=x.oSrc;
		}
}

function image_cancel(){
	var i,x,a=document.image_flag;
    for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;

}
function MM_onClickImage(){
      image_cancel();
      var i,j=0,x,a=MM_onClickImage.arguments;document.image_flag=new Array; for(i=0;i<(a.length-2);i+=3){
      if ((x=MM_findObj(a[i]))!=null){document.image_flag[j++]=x;  if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}}
}

function checkTreatmentRelation(form){
	var callResult=form.callResult.value; 
	var recActionCode = form.recActionCode.value;
	var callActionCode = form.callActionCode.value;
	if(callResult ==21 && recActionCode == 7){
		return false;
	}
	if(callResult ==47 && (recActionCode == 1 || recActionCode == 2|| recActionCode == 6|| recActionCode == 7|| recActionCode == 8)){
		return false;
	}
	if( callActionCode >0 && (callResult != 9 || callResult != 17 || callResult != 19 || callResult != 33)){
		return false;
	}
	return true;

}