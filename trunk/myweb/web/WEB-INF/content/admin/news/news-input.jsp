<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>上传演示(录入新闻)</title>
<%@ include file="/common/meta.jsp"%>
<link href="${base}/scripts/validate/jquery.validate.css" type="text/css" rel="stylesheet" />
<script src="${base}/scripts/validate/jquery.validate.js" type="text/javascript"></script>
<script src="${base}/scripts/validate/messages_cn.js" type="text/javascript"></script>
<script type="text/javascript" charset="utf-8" src="${base}/scripts/kindeditor/src/lang/zh_CN.js"></script>
<script type="text/javascript" charset="utf-8" src="${base}/scripts/kindeditor/src/kindeditor-core.js"></script>
<script type="text/javascript" charset="utf-8" src="${base}/scripts/kindeditor/src/plugin-all.js"></script>
<script language="javascript" src="${base}/scripts/date-picker/WdatePicker.js"  type="text/javascript" ></script>
<script type="text/javascript">
	KE.show({
		id:'news.content',
		cssPath:'${base}/scripts/kindeditor/src/index.css'
	});
</script>
<script>
	$(document).ready(function(){
		$("#name").focus();
		$("#inputForm").validate();
	});
</script>
</head>
<body>
	<form id="inputForm" action="news!save.action" method="post" enctype="multipart/form-data">
		<input type="hidden" name="news.id" value="${news.id}" />
		<input type="hidden" name="news.version" value="${news.version}" />
		<table class="inputView">
			<tr>
				<td nowrap="nowrap">标题:</td>
				<td><input type="text" id="name" name="news.title" size="40" value="${news.title}" class="required"/></td>
			</tr>
			<tr>
				<td nowrap="nowrap">图片:</td>
				<td><input type="file" name="upload" class="required"/></td>
			</tr>
			<tr>
				<td nowrap="nowrap">作者:</td>
				<td><input type="text" name="news.auth" size="40" value="${person.auth}" class="required"/></td>
			</tr>
			<tr>
				<td nowrap="nowrap">发布日期:</td>
				<td><input type="text" name="news.date" size="40" value="${news.date}" onFocus="new WdatePicker(this,'%Y-%M-%D',false)"/></td>
			</tr>
			<tr>
				<td nowrap="nowrap">内容:</td>
				<td><textarea id="news.content" name="news.content" style="width:600px;height:250px;visibility:hidden;" class="required">${news.content}</textarea>
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