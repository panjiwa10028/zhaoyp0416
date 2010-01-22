<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>新闻列表</title>
<script src="<c:url value="/scripts/jquery.js"/>" type="text/javascript"></script>
<link href="${base}/style/style.css" rel="stylesheet" type="text/css" />
<script src="${base}/SpryAssets/SpryValidationTextField.js" type="text/javascript"></script>
<link href="${base}/SpryAssets/SpryValidationTextField.css" rel="stylesheet" type="text/css" />
</head>
<form id="queryForm" name="queryForm" action="news.action" method="post">
    <input name="filter_EQ_categoryId" type="hidden" value="${filter_EQ_categoryId}"/>
<body>
<%@ include file="/head.jsp"%>
<div id="centainer">
  <div id="leftside">
  <h3>新闻分类</h3>
    <ul>
    	<li><a href="news.action">所有新闻</a></li>
    <s:iterator value="allNewsCategory">
    	<li><a href="news.action?filter_EQ_categoryId=${id}">${name}</a></li>
    </s:iterator>
    </ul>
  </div>
  <div class="rightside">
    <div class="th">
      <p class="font1">首页-新闻列表</p>
    </div>
    <div class="th_center">
    	<ul class="ul1" style="margin:20px;">
    	<s:iterator value="page.result">
        	<li><span style=" float:right"><fmt:formatDate value="${updateTime}" pattern="yyyy-MM-dd" /></span><a href="${base}/${htmlPath}/${htmlName}" target="_blank">[<a href="news.action?filter_EQ_categoryId=${newsCategory.id}">${newsCategory.name}</a>]  ${title} </a></li>
             </s:iterator>
        </ul>        
    </div>
    
    <div class="th_foot"><img src="${base}/images/indexs_12.gif" /><s:if test="page.result != null">
							<%@ include file="/common/paginateTool.jsp"%>
		</s:if>	</div>
		
    </div>
</div>
<%@ include file="/foot.jsp"%>
</body>
</form>
</html>
