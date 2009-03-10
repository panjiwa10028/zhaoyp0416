<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>帐号管理</title>
</head>

<body>
<table class="listView">
	<tr>
		<th><a href="${base}/system/user.action?page.orderBy=username&page.order=
		<s:if test="page.orderBy=='username'">${page.inverseOrder}</s:if><s:else>desc</s:else>
		"><b>登录名</b></a></th>
		<th><a href="${base}/system/user.action?page.orderBy=cnname&page.order=
		<s:if test="page.orderBy=='cnname'">${page.inverseOrder}</s:if><s:else>desc</s:else>
		"><b>姓名</b></a></th>
		<th><a href="${base}/system/user.action?page.orderBy=email&page.order=
		<s:if test="page.orderBy=='email'">${page.inverseOrder}</s:if><s:else>desc</s:else>
		"><b>电邮</b></a></th>
		<th><b>角色</b></th>
		<th><b>操作</b></th>
	</tr>

	<s:iterator value="page.result">
		<tr>
			<td nowrap="nowrap">${username}&nbsp;</td>
			<td nowrap="nowrap">${cnname}&nbsp;</td>
			<td nowrap="nowrap">${email}&nbsp;</td>
			<td>${roles}&nbsp;</td>
			<td nowrap="nowrap">&nbsp;
				<security:authorize ifAnyGranted="RES_SAVE_USER">
					<a href="user!input.action?user.id=${id}">修改</a>&nbsp;
				</security:authorize>
				<security:authorize ifAnyGranted="RES_REMOVE_USER">
					<a href="user!delete.action?user.id=${id}">删除</a>&nbsp;
				</security:authorize>
			</td>
		</tr>
	</s:iterator>
</table>

<div id="footer" style="margin-top:10px;width: 600px;">
	第${page.pageNo}页, 共${page.totalPages}页 
	<s:if test="page.hasPre">
		<a href="user.action?page.pageNo=${page.prePage}&page.orderBy=${page.orderBy}&page.order=${page.order}">上一页</a>
	</s:if>
	<s:if test="page.hasNext">
		<a href="user.action?page.pageNo=${page.nextPage}&page.orderBy=${page.orderBy}&page.order=${page.order}">下一页</a>
	</s:if>
	<security:authorize ifAnyGranted="RES_SAVE_USER">
		<a href="user!input.action">增加新用户</a>
	</security:authorize>
</div>

</body>
</html>
