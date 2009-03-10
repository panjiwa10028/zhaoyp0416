<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>资源管理</title>
<link href="${base}/scripts/validate/jquery.validate.css" type="text/css" rel="stylesheet" />
<script src="${base}/scripts/validate/jquery.validate.js" type="text/javascript"></script>
<script src="${base}/scripts/validate/messages_cn.js" type="text/javascript"></script>
<script>
	$(document).ready(function(){
		$("#name").focus();
		$("#inputForm").validate();
	});
	
</script>
</head>

<body>
<h3><s:if test="resource.id == null">创建</s:if><s:else>修改</s:else>资源</h3>
<form id="inputForm" action="resource!save.action" method="post">
<input type="hidden" name="resource.id" value="${resource.id}" />
<input type="hidden" name="resource.version" value="${resource.version}" />
<table class="inputView">
	<tr>
		<td>授权标志:</td>
		<td><input type="text" name="resource.name" size="40" value="${resource.name}" class="required"/></td>
	</tr>
	<tr>
		<td>授权名称:</td>
		<td><input type="text" name="resource.cnname" size="40" value="${resource.cnname}" class="required"/></td>
	</tr>
	<tr>
		<td>授权路径:</td>
		<td><input type="text" name="resource.path" size="40" value="${resource.path}" class="required"/></td>
	</tr>
	<tr>
		<td colspan="2">
			<input type="submit" value="提交" class="button"/>&nbsp; 
			<input type="button" value="取消" onclick="back();" class="button"/>
		</td>
	</tr>
</table>
</form>
</body>
</html>