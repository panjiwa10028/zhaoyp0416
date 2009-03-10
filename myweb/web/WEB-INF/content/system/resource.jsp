<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>资源管理</title>
</head>
<body>
	<table class="listView">
		<tr>
			<th><b>授权标志</b></th>
			<th><b>授权名称</b></th>
			<th><b>授权路径</b></th>
			<th><b>操作</b></th>
		</tr>
	
		<s:iterator value="allResource">
			<tr>
				<td nowrap="nowrap">${name}</td>
				<td nowrap="nowrap">${cnname}</td>
				<td>${path}</td>
				<td nowrap="nowrap">&nbsp; 
					<security:authorize ifAnyGranted="RES_SAVE_RESOURCE">
						<a href="resource!input.action?resource.id=${id}">修改</a>&nbsp;
					</security:authorize>
					<security:authorize ifAnyGranted="RES_REMOVE_RESOURCE">
						<a href="resource!delete.action?resource.id=${id}">删除</a>&nbsp;
					</security:authorize>
				</td>
			</tr>
		</s:iterator>
	</table>

<div id="footer" style="margin-top:10px;width: 600px;">
	<security:authorize ifAnyGranted="RES_SAVE_RESOURCE">
			<a href="resource!input.action">增加新资源</a>
	</security:authorize>
</div>

</body>
</html>