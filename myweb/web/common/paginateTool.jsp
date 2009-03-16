<%@ page contentType="text/html;charset=UTF-8"%>
<script src="${base}/js/paginateTool.js" language="JavaScript"
	type="text/javascript"></script>
<script src="${base}/scripts/page.js" language="JavaScript"
	type="text/javascript"></script>
<script language="javascript">
<!--


var g_intAppendstrPageCount = 2;
function printPageNumberList(strGotoPageFunctionName)
{
	strPageCount = $("#totalPages").val();
	strPageNumber = $("#pageNo").val();
	if(strPageCount=='' || strPageCount<=0)
	{// 总叶数<=0
		document.write(0 + '&nbsp;');
		
		return;
	}
	
	if(strPageNumber=='' || strPageNumber<=0)
	{// 当前页号<=0
		document.write(0 + '&nbsp;');
		
		return;
	}
	
	// 显示当前页的前附加的页号
	var prePageNumber = strPageNumber - g_intAppendstrPageCount;
	
	var i = 0;
	
	while(i < g_intAppendstrPageCount)
	{
		if(prePageNumber > 0)
		{
			document.write('<a href="javascript: ' + strGotoPageFunctionName + '(' + prePageNumber + ');' + '">' + prePageNumber + '</a>&nbsp;');
		}
		
		prePageNumber++;
		
		i++;
	}
	
	// 显示当前页号
	document.write('<font color="red">' + strPageNumber + '</font>' + '&nbsp;');
	
	// 显示当前页的后附加的页号
	var tempPageNumber = strPageNumber;
	tempPageNumber++;
	
	var behindPageNumber = tempPageNumber;
	
	i = 0;
	
	while(i < g_intAppendstrPageCount)
	{
		if(behindPageNumber <= strPageCount)
		{
			document.write('<a href="javascript: ' + strGotoPageFunctionName + '(' + behindPageNumber + ');' + '">' + behindPageNumber + '</a>&nbsp;');
		}
		
		behindPageNumber++;
		
		i++;
	}
	
	document.write("<input type=\"text\" style=\"display:none\" style=\"width:0;height:0\"/>");
}

	function MM_preloadImages() { //v3.0
	  var d=document; if(d.images){ if(!d.MM_p) d.MM_p=new Array();
	    var i,j=d.MM_p.length,a=MM_preloadImages.arguments; for(i=0; i<a.length; i++)
	    if (a[i].indexOf("#")!=0){ d.MM_p[j]=new Image; d.MM_p[j++].src=a[i];}}
	}

	function MM_swapImgRestore() { //v3.0
	  var i,x,a=document.MM_sr; for(i=0;a&&i<a.length&&(x=a[i])&&x.oSrc;i++) x.src=x.oSrc;
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

//-->
</script>


<input id="orderBy" name="page.orderBy" type="hidden"
	value="${page.orderBy}" />
<input id="pageNo" name="page.pageNo" type="hidden"
	value="${page.pageNo}" />
<input id="order" name="page.order" type="hidden" value="${page.order}" />
<input id="totalPages" name="page.totalPages" type="hidden"
	value="${page.totalPages}" />
<input id="prePage" name="page.prePage" type="hidden"
	value="${page.prePage}" />
<input id="nextPage" name="page.nextPage" type="hidden"
	value="${page.nextPage}" />
<table width="100%" border="0" cellSpacing="1" border="0">
	<tr>
		<td align="left">
			共 ${page.totalCount} 条记录
		</td>
		<td align="right">
			<img src="${base}/images/page/AllPageCount.gif" align="absmiddle"
				border="0">
			${page.totalPages}
			<s:if test="!page.hasPre">
				<img src="${base}/images/page/First.gif" title="Page.FirstPageTitle"
					name="Image29" align="absmiddle" border="0">
				<img src="${base}/images/page/Previous.gif"
					title="Page.PreviousPageTitle" name="Image30" align="absmiddle"
					border="0">
			</s:if>
			<s:if test="page.hasPre">
				<a title="Page.FirstPageTitle" href="javascript:firstPage()"
					onMouseOut="MM_swapImgRestore()"
					onMouseOver="MM_swapImage('Image29','','${base}/images/page/First_2.gif',1)">
					<img src="${base}/images/page/First.gif" name="Image29"
						align="absmiddle" border="0"> </a>
				<a title="Page.PreviousPageTitle" href="javascript:prePage()"
					onMouseOut="MM_swapImgRestore()"
					onMouseOver="MM_swapImage('Image30','','${base}/images/page/Previous_2.gif',1)">
					<img src="${base}/images/page/Previous.gif" name="Image30"
						align="absmiddle" border="0"> </a>
			</s:if>
			&nbsp;
			<script language="JavaScript" type="text/javascript">
							printPageNumberList('goPage');
						</script>
			&nbsp;
			<s:if test="!page.hasNext">
				<img src="${base}/images/page/Next.gif" title="Page.NextPageTitle"
					name="Image32" align="absmiddle" border="0">
				<img src="${base}/images/page/Last.gif" title="Page.LastPageTitle"
					name="Image31" align="absmiddle" border="0">
			</s:if>
			<s:if test="page.hasNext">
				<a title="Page.NextPageTitle" href="javascript:nextPage()"
					onMouseOut="MM_swapImgRestore()"
					onMouseOver="MM_swapImage('Image32','','${base}/images/page/Next_2.gif',1)">
					<img src="${base}/images/page/Next.gif" name="Image32"
						align="absmiddle" border="0"> </a>
				<a title="Page.LastPageTitle" href="javascript:lastPage()"
					onMouseOut="MM_swapImgRestore()"
					onMouseOver="MM_swapImage('Image31','','${base}/images/page/Last_2.gif',1)">
					<img src="${base}/images/page/Last.gif" name="Image31"
						align="absmiddle" border="0"> </a>
			</s:if>
			&nbsp;
			<input id="goToPageNumber" name="goToPageNumber" type="text"
				onkeypress='verifyNum(this);' value="" maxlength="3"
				style='text-align: right; font-size: 11px; height: 15px; border: 1px solid #4b81c8; background-color: #ffffff; width: 22px' />
			<a title="Page.GoToPageTitle" href="javascript:toPageValidate()"
				onMouseOut="MM_swapImgRestore()"
				onMouseOver="MM_swapImage('ImageGo','','${base}/images/page/goToPageHot.gif',1)">
				<img src="${base}/images/page/goToPage.gif" id="ImageGo" border="0"
					align="absmiddle"> </a>
		</td>
	</tr>
</table>
