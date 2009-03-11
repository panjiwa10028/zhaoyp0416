<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>上传演示(新闻发布)</title>
<%@ include file="/common/meta.jsp"%>
</head>
<body>
	<table class="listView">
		<tr>
			<th><a href="${base}/demo/news.action?page.orderBy=name&page.order=
			<s:if test="page.orderBy=='title'">${page.inverseOrder}</s:if><s:else>desc</s:else>
			"><b>标题</b></a></th>
			<th><a href="${base}/demo/news.action?page.orderBy=job&page.order=
			<s:if test="page.orderBy=='auth'">${page.inverseOrder}</s:if><s:else>desc</s:else>
			"><b>作者</b></a></th>
			<th><a href="${base}/demo/news.action?page.orderBy=mobile&page.order=
			<s:if test="page.orderBy=='date'">${page.inverseOrder}</s:if><s:else>desc</s:else>
			"><b>发布日期</b></a></th>
			<th><b>照片</b></th>
			<th><b>操作</b></th>
		</tr>
	
		<s:iterator value="page.result">
			<tr>
				<td nowrap="nowrap">${title}&nbsp;</td>
				<td nowrap="nowrap">${auth}&nbsp;</td>
				<td nowrap="nowrap">${date}&nbsp;</td>
				<td><img src="${base}/upload/${picture}" alt="${base}/upload/${picture}" width="64" height="56"/>&nbsp;</td>
				<td nowrap="nowrap">&nbsp;
					<a href="news!delete.action?news.id=${id}">删除</a>&nbsp;
				</td>
			</tr>
		</s:iterator>
	</table>
	
	<div id="footer" style="margin-top:10px;width: 600px;">
		第${page.pageNo}页, 共${page.totalPages}页 
		<s:set var="actionName" value="news.action"></s:set>
		<a href="${actionName}?page.pageNo=1&page.orderBy=${page.orderBy}&page.order=${page.order}">首页</a>
		<s:if test="page.pageNo-3>0">
			...&nbsp;
		</s:if>
		<s:if test="page.pageNo-2>0">
			<a href="${actionName}?page.pageNo=${page.pageNo-2}&page.orderBy=${page.orderBy}&page.order=${page.order}">${page.pageNo-2}</a>&nbsp;
		</s:if>
		<s:if test="page.pageNo-1>0">
			<a href="${actionName}?page.pageNo=${page.pageNo-1}&page.orderBy=${page.orderBy}&page.order=${page.order}">${page.pageNo-1}</a>&nbsp;
		</s:if>
		<s:if test="page.pageNo>0">
			${page.pageNo}&nbsp;
		</s:if>
		<s:if test="page.totalPages>=page.pageNo+1">
			<a href="${actionName}?page.pageNo=${page.pageNo+1}&page.orderBy=${page.orderBy}&page.order=${page.order}">${page.pageNo+1}</a>&nbsp;
		</s:if>
		<s:if test="page.totalPages>=page.pageNo+2">
			<a href="${actionName}?page.pageNo=${page.pageNo+2}&page.orderBy=${page.orderBy}&page.order=${page.order}">${page.pageNo+2}</a>&nbsp;
		</s:if>
		<s:if test="page.totalPages>=page.pageNo+3">
			<a href="${actionName}?page.pageNo=${page.pageNo+3}&page.orderBy=${page.orderBy}&page.order=${page.order}">${page.pageNo+3}</a>&nbsp;
		</s:if>
		<s:if test="page.totalPages>=page.pageNo+4">
			<a href="${actionName}?page.pageNo=${page.pageNo+4}&page.orderBy=${page.orderBy}&page.order=${page.order}">${page.pageNo+4}</a>&nbsp;
		</s:if>
		<s:if test="page.totalPages>=page.pageNo+5">
			...&nbsp;
		</s:if>
		<a href="${actionName}?page.pageNo=${page.totalPages}&page.orderBy=${page.orderBy}&page.order=${page.order}">末页</a>
		<a href="news!input.action">增加新闻</a>
	</div>
	
</body>
</html>