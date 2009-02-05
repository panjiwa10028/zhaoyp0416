// 当前页两边附加的页数量
var g_intAppendstrPageCount = 2;
 
// 向页面输出分页控制页号html
// 	如：1 2 3 4 5 
// 参数:
// 	strPageCount				总页数
// 	strPageNumber				当前也号
//  strGotoPageFunctionName		点击某页是调用的javascript function名称
//
function printPageNumberList(strPageCount, strPageNumber, strGotoPageFunctionName)
{
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

function printChangePageSizeSelect(strCurrentPageSize)
{
	document.write('<select id="pageSizeSelect" name="pageSizeSelect" style="width:110 " onChange="changePageSize(this.options[this.selectedIndex].value)">');
	document.write('<option value="10"> 10 </option>');
	document.write('<option value="20"> 20 </option>');
	document.write('<option value="30"> 30 </option>');
	document.write('<option value="40"> 40 </option>');
	document.write('<option value="50"> 50 </option>');
	document.write('<option value="60"> 60 </option>');
	document.write('<option value="70"> 70 </option>');
	document.write('<option value="80"> 80 </option>');
	document.write('<option value="90"> 90 </option>');
	document.write('<option value="100"> 100 </option>');
	document.write('</select>');
	
	if(strCurrentPageSize!=undefined)
	{
		var crlSelect = document.getElementById("pageSizeSelect");
		if(crlSelect!=null)
		{
			for(var i = 0; i < crlSelect.length; i++)
			{
				if(crlSelect.options[i].value==strCurrentPageSize)
				{
					crlSelect.options[i].selected = true;
					
					break;
				}
			}
		}
	}
}

