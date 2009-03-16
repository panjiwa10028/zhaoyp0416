function firstPage() {
	$('#pageNo').val("1");
	submitForm();

}

function lastPage() {
	$('#pageNo').val($("#totalPages").val());
	submitForm();
	
}

function prePage() {
	$('#pageNo').val($("#prePage").val());
	submitForm();

}

function nextPage() {
	$("#pageNo").val($("#nextPage").val());
	submitForm();

}

function verifyNum(obj) {
	var value = obj.value;
	if (value == "0"){
		obj.value ="";
	}
	if (event.keyCode < 48 || event.keyCode > 57) {
		if (event.keyCode != 8 && event.keyCode != 9) {
			event.keyCode = 0;
	    }
	}
}

function toPageValidate()
{
	pageNumber = $("#goToPageNumber").val();

	if(pageNumber=='' || pageNumber<=0)
	{
		alert('Page.PageNumber.Error');
		return;
	}
	
	var tempPageNumber = parseInt(pageNumber);
	
	if(isNaN(tempPageNumber) || tempPageNumber<=0 || tempPageNumber > $("#totalPages").val())
	{
		alert('Page.PageNumber.Error');			
		return;
	}
	
	if(tempPageNumber!=parseInt($("#pageNo").val()))
	{
		goPage(pageNumber);
	}
	
}

function goPage(pageNumber) {
		if (parseInt($("#totalPages").val()) > 0) {
			if (pageNumber > 0) {
				if (pageNumber <= parseInt($("#totalPages").val())) {
					$('#pageNo').val(pageNumber);
					submitForm();
				}
			}
		}
}


function changgeValueDIV(filterFieldName) {

	if (filterFieldName != '') {
		var valueDIV = document.getElementById(filterFieldName + 'ValueDIV');

		if (valueDIV != null) {
			var appendValue = document
					.getElementById(filterFieldName + 'AppendValue');
			if (appendValue != null) {
				var formatValue = appendValue.value;
				if (formatValue.indexOf('`') == 0) {
					appendValue.value = ' ' + formatValue;
				}

				fieldContainerTD.innerHTML = valueDIV.innerHTML;

				if (formatValue.indexOf('`') == 0) {
					document.getElementById(filterFieldName + 'AppendValue').value = formatValue;
				}
			} else {
				fieldContainerTD.innerHTML = valueDIV.innerHTML;
			}
		}
	} else {
		fieldContainerTD.innerHTML = '&nbsp;';

		try {
			search();
		} catch (e) {

		}

	}

}


function orderBy(strOrderByFieldName) {
	var strSequenceTemp = '';

	strSequence = $("#order").val();
	if (strSequence == '' || strSequence != 'desc') {
		strSequenceTemp = 'desc';
	} else {
		strSequenceTemp = 'asc';
	}
	
	$("#orderBy").val(strOrderByFieldName);
	$("#order").val(strSequenceTemp);


	submitForm();
}


