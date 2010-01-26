<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${product.name}</title>
<link href="./../../../style/style.css" rel="stylesheet" type="text/css" />
<script src="./../../../SpryAssets/SpryValidationTextField.js" type="text/javascript"></script>
<link href="./../../../SpryAssets/SpryValidationTextField.css" rel="stylesheet" type="text/css" />
</head>
<body>
<!--#include virtual="./../../../head.jsp"-->
<div id="centainer">
  <div id="leftside1">
  <p>&nbsp;</p>
  <h1 style="text-align:center; border-bottom:1px #ccc solid;padding-bottom:5px;">${product.name}</h1>
  <p style="position:absolute; left:175px; color:#ccc;">发布日期：${product.updateTime?string("yyyy年MM月dd日")}</p>
     <p>&nbsp;</p>
			<div align="center">
			<#if product.picPath??>
			<img src="./../../../${product.picPath}/${product.picName}" width="300" height="280"/>
			<#else>
			<img src="./../../../images/nopic.gif" width="120" height="120"/>
		</#if>
		</div>
  </div>
  <div class="rightside1">
    <div class="th4">
      <p class="font1">${product.name} - 产品详情</p>
    </div>
        <div class="th_center4">
		<div style="margin:10px;" class="chanp">      
        ${product.content}
        </div>
    </div>
    <div class="th_foot"><img src="./../../../images/indexs_12_647.gif" /></div>
    </div>
</div>

<!--#include virtual="./../../../foot.jsp"-->
</body>
</html>
