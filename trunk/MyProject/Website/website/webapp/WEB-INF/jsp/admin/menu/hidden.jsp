<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" >
<html>
	<head>
		<title></title>
		<%@ include file="/common/meta.jsp"%>

		<link href="${ctx}/js/validate/jquery.validate.css" type="text/css"
			rel="stylesheet" />
		<script src="${ctx}/js/validate/jquery.validate.js"
			type="text/javascript"></script>
		<script src="${ctx}/js/validate/messages_cn.js" type="text/javascript"></script>

		<script>
	
	function initPage()
	{
		alert(document.getElementById("Javascript.Div2").innerText);
		window.dialogArguments.mainWorkArea.location = "menu.action";

	}

	
	
</script>


	</head>

	<body onload="initPage()">
	<div id="Javascript.Div2" class="div" style="width: 85%; height:24px;border:1px" align="center">
	<s:actionmessage />
</div>
				
	
	</body>
</html>