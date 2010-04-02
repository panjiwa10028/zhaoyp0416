<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<script src="<%=strContextPath%>/script/paginateTool.js" language="JavaScript" type="text/javascript"></script>
<script src="<%=strContextPath%>/script/page.js" language="JavaScript"	type="text/javascript"></script>
<script language="javascript">
<!--
	function toPageValidate(pageNumber)
	{
		if(commonTransForm.nPageCount.value=='' || commonTransForm.nPageCount.value<=0)
		{
			return;
		}
			
		if(pageNumber=='' || pageNumber<=0)
		{
			alert('<%=Function.getMultiLangItemContent("pageNumber.error", request)%>');
			return;
		}
		
		var tempPageNumber = parseInt(pageNumber);
		
		if(isNaN(tempPageNumber) || tempPageNumber<=0 || tempPageNumber > commonTransForm.nPageCount.value)
		{
			alert('<%=Function.getMultiLangItemContent("pageNumber.error", request)%>');			
			return;
		}
		
		if(tempPageNumber!=parseInt(commonTransForm.nPageIndex.value))
		{
			goPage(pageNumber);
		}
		
	}
//-->
</script>
<table width="100%" border="0">
	<tr>
		<td> &nbsp; 
				<%=Function.getMultiLangItemContent("common.count",	request)%>
				<c:out value='${NRECORDCOUNT}' />
				<%=Function.getMultiLangItemContent("common.record", request)%>
		</td>
		<td align="right">
				<img src="<%=strContextPath%>/images/AllPageCount.gif" align="absmiddle" border="0"> 
				<c:out value='${NPAGECOUNT}' />
				<c:if test="${NPAGEINDEX==null || NPAGEINDEX == 1}">
					<img src="<%=strContextPath%>/images/First.gif" title="<%=Function.getMultiLangItemContent("page.FirstPageTitle",request)%>" name="Image29" align="absmiddle" border="0">
					<img src="<%=strContextPath%>/images/Previous.gif" title="<%=Function.getMultiLangItemContent("page.PreviousPageTitle", request)%>" name="Image30" align="absmiddle" border="0">
				</c:if>
				<c:if test="${NPAGEINDEX > 1}">
					<a title="<%=Function.getMultiLangItemContent("page.FirstPageTitle",request)%>" href="javascript:firstPage()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image29','','<%=strContextPath%>/images/First_2.gif',1)">
						<img src="<%=strContextPath%>/images/First.gif" name="Image29" align="absmiddle" border="0">
					</a>
					<a title="<%=Function.getMultiLangItemContent("page.PreviousPageTitle", request)%>" href="javascript:prePage()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image30','','<%=strContextPath%>/images/Previous_2.gif',1)">
						<img src="<%=strContextPath%>/images/Previous.gif" name="Image30" align="absmiddle" border="0"> 
					</a>
				</c:if>
				&nbsp;
				<script language="JavaScript" type="text/javascript">
					printPageNumberList(commonTransForm.nPageCount.value, commonTransForm.nPageIndex.value, 'goPage');
				</script>
				&nbsp;
				<c:if test="${NPAGEINDEX==NPAGECOUNT}">
					<img src="<%=strContextPath%>/images/Next.gif" title="<%=Function.getMultiLangItemContent("page.NextPageTitle",request)%>" name="Image32" align="absmiddle" border="0">
					<img src="<%=strContextPath%>/images/Last.gif" title="<%=Function.getMultiLangItemContent("page.LastPageTitle",request)%>" name="Image31" align="absmiddle" border="0">
				</c:if>
				<c:if test="${NPAGEINDEX < NPAGECOUNT}">
					<a title="<%=Function.getMultiLangItemContent("page.NextPageTitle",request)%>" href="javascript:nextPage()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image32','','<%=strContextPath%>/images/Next_2.gif',1)">
						<img src="<%=strContextPath%>/images/Next.gif" name="Image32" align="absmiddle" border="0"> 
					</a>
					<a title="<%=Function.getMultiLangItemContent("page.LastPageTitle",request)%>" href="javascript:lastPage()" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('Image31','','<%=strContextPath%>/images/Last_2.gif',1)">
						<img src="<%=strContextPath%>/images/Last.gif" name="Image31" align="absmiddle" border="0"> 
					</a>
				</c:if>
				&nbsp;
				<input id="goToPageNumber" name="goToPageNumber" type="text" onkeypress='verifyNum(this);' value="" maxlength="3" style='text-align: right; font-size:11px; height:15px; border:1px solid #4b81c8; background-color:#ffffff;width:22px' />
				<a title="<%=Function.getMultiLangItemContent("page.GoToPageTitle",request)%>" href="javascript:toPageValidate(goToPageNumber.value)" onMouseOut="MM_swapImgRestore()" onMouseOver="MM_swapImage('ImageGo','','<%=strContextPath%>/images/GoToPageHot.gif',1)">
					<img src="<%=strContextPath%>/images/GoToPage.gif" id="ImageGo" border="0" align="absmiddle"> 
				</a>
		</td>
	</tr>
</table>
