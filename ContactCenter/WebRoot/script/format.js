	function text2Html(strText)
	{
		if(strText==undefined)
		{
			return '';
		}
		
		strText	=strText.replace(/&/g,"&amp;");
		strText	=strText.replace(/ /g,"&nbsp;");		
		strText	=strText.replace(/>/g,"&gt;");
		strText	=strText.replace(/</g,"&lt;");
		strText	=strText.replace(/\'/g,"&#39;");
		strText	=strText.replace(/\"/g,"&quot;");
		strText	=strText.replace(/\r\n/g,"<br/>");

		return strText;
	}
	

	function html2Text(strText)
	{
		if(strText==undefined)
		{
			return '';
		}
		
		strText	=strText.replace(/&nbsp;/g," ");		
		strText	=strText.replace(/&gt;/g,">");
		strText	=strText.replace(/&lt;/g,"<");
		strText	=strText.replace(/&#39;/g,"'");
		strText	=strText.replace(/&quot;/g,"\"");
		strText	=strText.replace(/&amp;/g,"&");
		strText	=strText.replace(/<br\/>/g,"\r\n");

		return strText;
	}
	
	function text2HtmlView(strText)
	{
		if(strText==undefined)
		{
			return '';
		}
		
		strText	=strText.replace(/&/g,"&amp;");
		strText	=strText.replace(/>/g,"&gt;");
		strText	=strText.replace(/</g,"&lt;");

		return strText;
	}
	function getTime(type)
	 {
	 	var today = new Date();

		var year = today.getYear();
		var month = today.getMonth()+1;
		month = checkTime(month);
		var date = today.getDate();
		date = checkTime(date);
		
		var hours = today.getHours();
		var minutes = today.getMinutes();
		var seconds = today.getSeconds();
		hours = checkTime(hours);
		minutes = checkTime(minutes);
		seconds = checkTime(seconds);
		if(type == "0")
		{
			return year + "-" + month + "-" + date + " " + hours + ":" + minutes + ":" + seconds;
		}
		else if(type == "1")
		{
			return year + "-" + month + "-" + date;
		}
		else 
		{
			return "";
		}
	 }
	function checkTime(i)
	{
		if(i < 10) 
		{
			i = "0" + i;
		}		
		return i;
	}