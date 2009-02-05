		function firstPage()
		{
			if(commonTransForm.nPageSize.value!='')
			{
				if(commonTransForm.nPageCount.value!='')
				{
					if(commonTransForm.nPageIndex.value!="1")
					{
						commonTransForm.nPageIndex.value= "1";
						submitForm();
					}
				}
			}
		}
		
	
		function lastPage()
		{
			if(commonTransForm.nPageSize.value!='')
			{
				if(commonTransForm.nPageCount.value!='')
				{
					if(commonTransForm.nPageIndex.value!=commonTransForm.nPageCount.value)
					{
						commonTransForm.nPageIndex.value = commonTransForm.nPageCount.value;
						submitForm();
					}
				}
			}
		}
		
		
		function prePage()
		{
			if(commonTransForm.nPageSize.value!='')
			{
				if(commonTransForm.nPageCount.value!='')
				{
					if(parseInt(commonTransForm.nPageIndex.value)>1)
					{
						if(parseInt(commonTransForm.nPageIndex.value)<=parseInt(commonTransForm.nPageCount.value))
						{
							commonTransForm.nPageIndex.value--;
							submitForm();
						}
					}
				}
			}
		}
		
	
		function nextPage()
		{
			$("#page.pageNo").val("${page.nextPage}");
			$("#page.orderBy").val("${page.orderBy}");
			$("#page.order").val("${page.order}");
			submitForm();
			
		}
		
	
		function goPage(pageNumber)
		{
			if(commonTransForm.nPageSize.value!='')
			{
				if(parseInt(commonTransForm.nPageSize.value)>0)
				{
					if(pageNumber >0)
					{
						if(pageNumber <= parseInt(commonTransForm.nPageCount.value))
						{
							commonTransForm.nPageIndex.value = pageNumber;
							submitForm();
						}
					}
				}
			}
		}
	
	function changgeValueDIV(filterFieldName)
	{

		if(filterFieldName!='')
		{
			var valueDIV = document.getElementById(filterFieldName + 'ValueDIV');
			
			if(valueDIV!=null)
			{
				var appendValue = document.getElementById(filterFieldName + 'AppendValue');
				if(appendValue!=null)
				{
					var formatValue = appendValue.value;
					if(formatValue.indexOf('`') == 0)
					{
						appendValue.value = ' ' + formatValue;
					}
					
					fieldContainerTD.innerHTML = valueDIV.innerHTML;
					
					if(formatValue.indexOf('`') == 0)
					{		
						document.getElementById(filterFieldName + 'AppendValue').value = formatValue;
					}
				}
				else
				{
					fieldContainerTD.innerHTML = valueDIV.innerHTML;
				}
			}
		}
		else
		{
			fieldContainerTD.innerHTML = '&nbsp;';
	
			try{
				search();
			}catch(e)
			{
				
			}
			
			
		}
		
	}
	
		// ????????????
		// strOrderByFieldName ???????
		// strSequence ????? desc?? ????
		function orderBy(strOrderByFieldName, strSequence)
		{
			var strSequenceTemp = '';
			
			if(strSequence=='' || strSequence!='desc')
			{
				strSequenceTemp = 'asc';
			}
			else
			{
				strSequenceTemp = 'desc';
			}
			
			commonTransForm.strOrderByFieldName.value = strOrderByFieldName;
			commonTransForm.strOrderDirection.value = strSequenceTemp;
			
			if(commonTransForm.nPageSize.value=='' || commonTransForm.nPageSize.value<=0)
			{
				// ????8???
				commonTransForm.nPageSize.value = 10;
			}
			
			if(commonTransForm.nPageIndex.value=="" || commonTransForm.nPageIndex.value==0)
			{
				commonTransForm.nPageIndex.value = 1;
			}
			// commonTransForm.nPageIndex.value = 1;
			
			submitForm();
		}
		
		// ???????
		function initSearchCondition()
		{
			commonTransForm.appendFilterFieldName.selectedIndex = 0;
			
			changgeValueDIV(commonTransForm.appendFilterFieldName.options[0].value);
			
			commonTransForm.nSelectedSearchConditionId.value = 0;
			
		}
		
		
		function changeSelectedSearchConditionId(id)
		{
			commonTransForm.nSelectedSearchConditionId.value = id;
		}
	
		function changePageSize(nPageSize)
		{
			commonTransForm.nPageSize.value = nPageSize;
			commonTransForm.nPageIndex.value = 1;
			
			submitForm();
		}
