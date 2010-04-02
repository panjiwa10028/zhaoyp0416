function disabledForm()
{
	var theFormObj = document.forms[0];
	if(theFormObj!=undefined)
	{
		for(var i = 0; i < theFormObj.length; i++)
		{
			if(theFormObj.elements[i].type!="hidden")
			{
				if(theFormObj.elements[i].type=="text" || theFormObj.elements[i].type=="password" || theFormObj.elements[i].type=="file" || theFormObj.elements[i].type=="textarea")
				{
					theFormObj.elements[i].readOnly = true;
					theFormObj.elements[i].className = "textReadonly";
					if(theFormObj.elements[i].onfocus!=null)
					{
						theFormObj.elements[i].onfocus = "";
					}
				}
				else
				{
					theFormObj.elements[i].disabled = true;
					theFormObj.elements[i].className = "textReadonly";
				}
			}
		}
		
		var imagesObj = document.getElementsByTagName("img");
		for(var i=0;i<imagesObj.length;i++)
		{
			imagesObj[i].style.display = 'none';
		}
	}	
}
