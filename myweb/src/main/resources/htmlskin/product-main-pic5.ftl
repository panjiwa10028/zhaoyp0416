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
      
<table width=680 border=0 cellpadding=0 cellspacing=2 align=right>                                                                                                          
 <tr><td>                                                                                                                                                                                         
  <div id=www_qpsh_com style="overflow:hidden;height:180px;width:695px;color:#ff0000"><table align=right cellpadding=0 cellspace=0 border=0><tr><td id=www_qpsh_com1 valign=top>
  <table border=0 cellpadding=0 cellspacing=0 >
  <tr>
  
  <#list productList.result as product>
  <td valign="top">
  <a href="./${product.htmlPath}/${product.htmlName}" target="_blank">
  <img border=0 src="./${product.picPath}/${product.picName}" width=180 height=140 hspace=22>
  </a>
  <center><b>
  <div class="mudi_list" style="text-overflow:ellipsis; white-space:nowrap; overflow:hidden; width:160px;"><a href="./${product.htmlPath}/${product.htmlName}" target="_blank">${product.name}</a></div>
  </b></center>
  </td>
  <td width=30></td>
  </#list>  
  </tr>
  </table>
 </td><td id=www_qpsh_com2 valign=top></td></tr></table></div>
  <script>
  var speed=10//速度数值越大速度越慢
  www_qpsh_com2.innerHTML=www_qpsh_com1.innerHTML
  function Marquee(){
  if(www_qpsh_com2.offsetWidth-www_qpsh_com.scrollLeft<=0)
  www_qpsh_com.scrollLeft-=www_qpsh_com1.offsetWidth
  else{
  www_qpsh_com.scrollLeft++
  }
  }
  var MyMar=setInterval(Marquee,speed)
  www_qpsh_com.onmouseover=function() {clearInterval(MyMar)}
  www_qpsh_com.onmouseout=function() {MyMar=setInterval(Marquee,speed)}
  </script>
 </td></tr>                                                                                                                                                                                                                            
 </table>
</body>
</html>
