<%@ page language="java" pageEncoding="UTF-8"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>IVR</title>
<style type="text/css">
body,td,th,input,select,textarea {
	font-size: 11px;
	color: #000000;
	font-family:Tahoma,Verdana,Segoe,sans-serif;
}
body {
	margin: 0px;
	border: none;
	SCROLLBAR-FACE-COLOR: #D4DCE6;
	SCROLLBAR-HIGHLIGHT-COLOR: #f8f8f8;
	SCROLLBAR-SHADOW-COLOR: #92A7C3;
	SCROLLBAR-3DLIGHT-COLOR: #92A7C3;
	SCROLLBAR-ARROW-COLOR: #5F5F5F;
	SCROLLBAR-TRACK-COLOR: #f8f8f8;
	SCROLLBAR-DARKSHADOW-COLOR: #f8f8f8;
}
</style>
<script language="javascript">
function getSelectedIVR(){
	var strSelectedIvr = "";
	for(var i=0;i<document.forms[0].radiobutton.length;i++){
		if(document.forms[0].radiobutton[i].checked){
			strSelectedIvr = document.forms[0].radiobutton[i].value;
			break;
		}
	}
	return strSelectedIvr;
}
</script>
</head>

<body>
<form>
<table width="200" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td><input type="radio" name="radiobutton" value="1901;1">
      IVR测试1</td>
  </tr>
  <tr>
    <td><input type="radio" name="radiobutton" value="1901;0">
      IVR测试2</td>
  </tr>
  <tr>
    <td><input type="radio" name="radiobutton" value="radiobutton3">
      IVR测试3</td>
  </tr>
  <tr>
    <td><input type="radio" name="radiobutton" value="radiobutton4">
      IVR测试4</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
  <tr>
    <td>&nbsp;</td>
  </tr>
</table>
</form>
</body>
</html>
