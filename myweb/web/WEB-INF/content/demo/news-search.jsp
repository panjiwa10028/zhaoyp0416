<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>搜索引擎演示</title>
<link href="${base}/scripts/validate/jquery.validate.css" type="text/css" rel="stylesheet" />
<script src="${base}/scripts/validate/jquery.validate.js" type="text/javascript"></script>
<script src="${base}/scripts/validate/messages_cn.js" type="text/javascript"></script>
<script>
	$(document).ready(function(){
		$("#search_text").focus();
		$("#inputForm").validate();
	});
</script>
</head>
<body>
<div>
	<form action="${base}/demo/news!search.action" method="post" id="inputForm">
		<input id="search_text" name="search_text" class="required"/><input type="submit" value="搜索" class="button"/>
	</form>
</div>
<div>
	<table class="listView">
		<s:iterator value="allNews">
			<tr>
				<td nowrap="nowrap">${title}&nbsp;</td>
				<td><img src="${base}/upload/${picture}" alt="${base}/upload/${picture}" width="64" height="56"/>&nbsp;</td>
				<td>${content}&nbsp;</td>
			</tr>
		</s:iterator>
	</table>
</div>
</body>
</html>