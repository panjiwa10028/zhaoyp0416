<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>角色管理</title>
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
<h3><s:if test="role.id == null">创建</s:if><s:else>修改</s:else>角色</h3>
<form id="inputForm" action="role!save.action" method="post">
<input type="hidden" name="role.id" value="${role.id}" />
<input type="hidden" name="role.version" value="${role.version}" />
<table class="inputView">
	<tr>
		<td>角色标志:</td>
		<td><input type="text" name="role.name" size="40" value="${role.name}" class="required"/></td>
	</tr>
	<tr>
		<td>角色名称:</td>
		<td><input type="text" name="role.cnname" size="40" value="${role.cnname}" class="required"/></td>
	</tr>
	<tr>
		<td>授权:</td>
		<td>
		<div style="word-break:break-all;width:250px; overflow:auto; ">
			<s:checkboxlist name="ids"  list="allResource"  listKey="id" listValue="cnname" cssClass="button"/>
		</div>
		</td>
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