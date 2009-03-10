<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>角色管理</title>
</head>
<body>
	<table class="listView">
		<tr>
			<th><b>标志</b></th>
			<th><b>名称</b></th>
			<th><b>授权</b></th>
			<th><b>操作</b></th>
		</tr>
	
		<s:iterator value="allRoles">
			<tr>
				<td nowrap="nowrap">${name}</td>
				<td nowrap="nowrap">${cnname}</td>
				<td>${resources}</td>
				<td nowrap="nowrap">&nbsp; 
					<security:authorize ifAnyGranted="RES_SAVE_ROLE">
						<a href="role!input.action?role.id=${id}">修改</a>&nbsp;
					</security:authorize>
					<security:authorize ifAnyGranted="RES_REMOVE_ROLE">
						<a href="role!delete.action?role.id=${id}">删除</a>&nbsp;
					</security:authorize>
				</td>
			</tr>
		</s:iterator>
	</table>

<div id="footer" style="margin-top:10px;width: 600px;">
	<security:authorize ifAnyGranted="RES_SAVE_ROLE">
			<a href="role!input.action">增加新角色</a>
	</security:authorize>
</div>

</body>
</html>