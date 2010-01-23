<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>产品列表</title>
<link href="./../../../style/style.css" rel="stylesheet" type="text/css" />
<script src="./../../../SpryAssets/SpryValidationTextField.js" type="text/javascript"></script>
<link href="./../../../SpryAssets/SpryValidationTextField.css" rel="stylesheet" type="text/css" />
</head>
<body>
<ul>
	<#list productList.result as product>
                 <li><div style="width:300px;float:left;height: 18px; border: 0px;overflow:hidden; padding:3px 2px 0px 2px; text-overflow:ellipsis"><a href="./${product.htmlPath}/${product.htmlName}" target="_blank">${product.name}</a></div></li>
     </#list>
                 </ul>
</body>
</html>
