<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="/common/taglibs.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>北京发那科机电有限公司-产品列表</title>

 
<script src="<c:url value="/scripts/jquery.js"/>" type="text/javascript"></script>
<link href="${base}/style/style.css" rel="stylesheet" type="text/css" />
<script src="${base}/SpryAssets/SpryValidationTextField.js" type="text/javascript"></script>
<link href="${base}/SpryAssets/SpryValidationTextField.css" rel="stylesheet" type="text/css" />
</head>
<form id="queryForm" name="queryForm" action="product.action" method="post">
<body>
<%@ include file="/head.jsp"%>
<div id="centainer">  
  <div class="centerside">
  <span style=" float:right">
  <select id="filter_EQ_categoryId" name="filter_EQ_categoryId">
  <option value="">全部</option>
  <c:forEach var="element" items="${allProductCategory}">
  <option value="${element.id}" <c:if test="${filter_EQ_categoryId==element.id}">selected</c:if>>${element.name}</option>
  </c:forEach>
  </select>
   &nbsp;&nbsp;<input type="submit" value="搜索"/>&nbsp;&nbsp;</span>
    <div class="th3">
      <p class="font1">产品列表</p>
    </div>
    <div class="th_center3">
    	<ul class="ul1" style="margin:20px;">
    	<s:iterator value="page.result">
    	
    	<table width="100%" border="0" cellspacing="5" cellpadding="0">
  <tr>
    <td width="120">
    <c:if test="${not empty picName }"><a href="${base}/${htmlPath}/${htmlName}" target="_blank"><img src="${base}/${picPath}/${picName}" alt="..." width="100" height="80" border="0"/></a></c:if>
    </td>
    <td valign="top"><table width="100%" border="0" cellspacing="2" cellpadding="0">
      <tr>
        <td><a href="${base}/${htmlPath}/${htmlName}" target="_blank">${name}</a></td>
        <td align="right"><fmt:formatDate value="${updateTime}" pattern="yyyy-MM-dd" /></td>
      </tr>
      <tr>
        <td colspan="2"><hr size="1" style="border:1px #999 dotted;" /></td>
      </tr>
      <tr>
        <td colspan="2">
        ${fn:substring(fn:replace(fn:replace(content,"<img","&lt;img"),"<br />"," "), 0, 120)}...
        </td>
      </tr>
    </table></td>
  </tr>
</table>
<hr/>
             </s:iterator>
        </ul>        
    </div>
    
    <div class="th_foot"><img src="${base}/images/indexs_12_957.gif" /><s:if test="page.result != null">
							<%@ include file="/common/paginateTool.jsp"%>
		</s:if>	</div>
		
    </div>
</div>
<%@ include file="/foot.jsp"%>
</body>
</form>
</html>
