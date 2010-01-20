<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>${news.title}</title>
<link href="./../../../../style/style.css" rel="stylesheet" type="text/css" />
<script src="./../../../../SpryAssets/SpryValidationTextField.js" type="text/javascript"></script>
<link href="./../../../../SpryAssets/SpryValidationTextField.css" rel="stylesheet" type="text/css" />
</head>
<body>
<!--#include virtual="./../../../../head.jsp"-->
<div id="centainer">

  <div class="centerside">
    <div class="th">
      <p class="font1">首页-产品列表-内容详情</p>
    </div>
        <div class="th_center">
		<div style="margin:10px;" class="chanp">
        <p style="position:absolute; right:10px; color:#ccc;">${news.date?string("yyyy年MM月dd日 hh点mm分ss秒")}</p>
        <h1 style="text-align:center; border-bottom:1px #ccc solid;padding-bottom:5px;">${news.title}</h1>
         <p></p>
         <#if news.picPath??>
			<img src="./../../../../${news.picPath}/${news.picName}" />
		</#if>
        ${news.content}
        </div>
    </div>
    <div class="th_foot"><img src="./../../../../images/indexs_12_957.gif"/></div>
    </div>
</div>
<!--#include virtual="./../../../../foot.jsp"-->
</body>
</html>
