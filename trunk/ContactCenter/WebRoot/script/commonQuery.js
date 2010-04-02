//mikey 2005.08.20
//need import image.js for MM_swapImgRestore() etc. need import input.js for verifyNum()

var perPageNum = 15;	//??????????

function MM_swapImgRestore() { //v3.0
  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
}

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

function MM_swapImage() { //v3.0
  var i,j=0,x,a=MM_swapImage.arguments; document.MM_sr=new Array; for(i=0;i<(a.length-2);i+=3)
   if ((x=MM_findObj(a[i]))!=null){document.MM_sr[j++]=x; if(!x.oSrc) x.oSrc=x.src; x.src=a[i+2];}
}

function calculatePageCount()			//??????????????????????????????????????1??
{
	if (perPageNum <= 0 )	return;
	if( nTotalCount <=0 ) return 1;
	var nTotalPage = Math.ceil(nTotalCount / perPageNum);//nPageCount;
	return nTotalPage;
}
	
function goPageByStart( theStart )			//????goPage??form????????????????
{
	var theForm = document.tableForm;
	theForm.nPageIndex.value = theStart;
	theForm.nRecordIndex.value = (theStart -1) * perPageNum;

	theForm.submit();
}

function goPageN( n )			//??????????N??
{
	goPageByStart( n );
}

function goPrevPage()
{
	if (nPageIndex <= 1)	//??????????????
		return;
	goPageByStart( nPageIndex - 1 );
}
function goNextPage()
{
	var totalPage = calculatePageCount();
	if (nPageIndex >= totalPage) //??????????????
		return;
	
	goPageByStart( nPageIndex + 1 );
}
function goFirstPage()
{
	if ( nPageIndex == 1 )	//????????????
		return; 
	goPageByStart( 1 );
}
function goLastPage()
{
	if (perPageNum <= 0 )	return;
	var totalPage = calculatePageCount();
	if ( nPageIndex >= totalPage ) //??????????????
		return;

	goPageByStart( totalPage );
}
function initFrontPageGo() {
	var html = "";
	var no;
	for (var i=2;i>0;i--) {
		no = nPageIndex - i;
		if (no > 0) {
			html += "<a href='javascript:goPageN("+no+");'>"+no+"</a> ";
		}
	}
	return html;
}
function initBackPageGo() {
	var html = "";
	var no;
	var pagecount = calculatePageCount();
	for (var i=1;i<3;i++) {
		no = parseInt(nPageIndex) + i;
		if (no <= pagecount) {
			html += "<a href='javascript:goPageN("+no+");'>"+no+"</a> ";
		}else {
			break;
		}
	}
	return html;
}
function initGotoPageFAL(totalFlag)
{   

	var currPage,pagecount;
	currPage = nPageIndex;
	pagecount = calculatePageCount();
	var html = "";
	if (totalFlag != '0') {
		html = initRecordCount();
	} else {
		html = "<td width=\"40%\">&nbsp;</td>";
	}
	html += "<td width=\"60%\" align=\"right\"><img src=\""+ contextPath +"/images/AllPageCount.gif\" align=\"absmiddle\" title=\""+go2pagePre+"\"> "+pagecount+" ";
	if ( currPage == 1) {
		html += ""+"<img src=\""+ contextPath +"/images/First.gif\" align=\"absmiddle\" title=\""+go2pageFirst+"\">"+" ";
		html += ""+"<img src=\""+ contextPath +"/images/Previous.gif\" align=\"absmiddle\" title=\""+go2pagePre+"\">"+" ";
	}
	else{
		html += "<a href='javascript:goFirstPage();' onMouseOut=\"MM_swapImgRestore()\" onMouseOver=\"MM_swapImage(\'Image101\',\'\',\'"+contextPath+"/images/First_2.gif\',1)\"><img src=\""+contextPath+"/images/First.gif\" name=\"Image101\" id=\"Image101\" border=\"0\" align=\"absmiddle\" title=\""+go2pageFirst+"\">"+"</a> ";
		html += "<a href='javascript:goPrevPage();' onMouseOut=\"MM_swapImgRestore()\" onMouseOver=\"MM_swapImage(\'Image102\',\'\',\'"+contextPath+"/images/Previous_2.gif\',1)\"><img src=\""+contextPath+"/images/Previous.gif\" name=\"Image102\" id=\"Image102\" border=\"0\" align=\"absmiddle\" title=\""+go2pagePre+"\">"+"</a> ";
	}

	html += initFrontPageGo()+"<font color='red'>"+nPageIndex+"</font> "+initBackPageGo();
	if ( currPage >= pagecount ) {
		html += ""+"<img src=\""+ contextPath +"/images/Next.gif\" align=\"absmiddle\" title=\""+go2pageNext+"\">"+" ";
		html += ""+"<img src=\""+ contextPath +"/images/Last.gif\" align=\"absmiddle\" title=\""+go2pageLast+"\">"+" ";
	}
	else{
		html += "<a href='javascript:goNextPage();' onMouseOut=\"MM_swapImgRestore()\" onMouseOver=\"MM_swapImage(\'Image103\',\'\',\'"+contextPath+"/images/Next_2.gif\',1)\"><img src=\""+contextPath+"/images/Next.gif\" name=\"Image103\" id=\"Image103\" border=\"0\" align=\"absmiddle\" title=\""+go2pageNext+"\">"+"</a> ";
		html += "<a href='javascript:goLastPage();' onMouseOut=\"MM_swapImgRestore()\" onMouseOver=\"MM_swapImage(\'Image104\',\'\',\'"+contextPath+"/images/Last_2.gif\',1)\"><img src=\""+contextPath+"/images/Last.gif\" name=\"Image104\" id=\"Image104\" border=\"0\" align=\"absmiddle\" title=\""+go2pageLast+"\">"+"</a> ";
	}
	html += ""+" ";
	html += initPageGo();
	html += ""+"</td>";
	initPageNum();
	document.write( html);
}

function initPageGo()
{
	var i , html;
	var n , sum;
	n = nPageIndex;
	sum = calculatePageCount();
	/*html='<select onchange="goPageN(this.options[this.selectedIndex].value)" class="box01">';
	for(i=1; i<=sum; i++){
		html+='<option value="'+ i +'"'+ (i==n ? " selected":"") +'>'+ i +'</option>';
	}
	html+="</select>";
	*/
	html = "<input type='text' id='go2pg' onkeypress='verifyNum(this);'  maxlength='10' style='text-align: right; font-size:11px; height:15px; border:1px solid #4b81c8; background-color:#ffffff;width:22px'></td>";
	html += "<td style='height:21px; padding:2px 4px 0xp 0px;'>&nbsp;<a href=\"javascript:if ((document.all.go2pg.value != '') && isUnsignedInteger(document.all.go2pg.value) && ((parseInt(document.all.go2pg.value) <= calculatePageCount()) &&  (parseInt(document.all.go2pg.value) != 0))) goPageN(document.all.go2pg.value); else alert(go2pageMsg);\" onMouseOut=\"MM_swapImgRestore()\" onMouseOver=\"MM_swapImage(\'Image105\',\'\',\'"+contextPath+"/images/GoToPageHot.gif\',1)\"><img src=\""+contextPath+"/images/GoToPage.gif\" name=\"Image105\" id=\"Image105\" border=\"0\" align=\"absmiddle\" title=\""+go2page+"\">"+"</a>";
	return html;
}

function initRecordCount() {
	var html = "<td width=\"40%\"> &nbsp; "+strCountTitle+"&nbsp;"+nTotalCount+"&nbsp;"+strRecordTitle+"</td>";
	return html;	
}
function initPageNum()
{
	document.write("");
}
function  isUnsignedInteger(strInteger)    
{       
	var	newPar=/^\d+$/  
	if(newPar.test(strInteger))
	{
		return true;
	}
	return false;
}