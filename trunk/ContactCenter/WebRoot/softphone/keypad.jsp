<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
<title>KeyPad</title>
<style type="text/css">
<!--
body {	margin: 0px; }
td { text-align:center; font-size:12px; font-weight:bold;}
input {font-size:20px; font-weight:bold; color: #FF3300; cursor:pointer}
-->
</style>
<script language="javascript" type="text/javascript">
var PhoneNumberObjectId=top.document.getElementById("phoneNumber");

var DELIMETE = "#@@#";

/**
  * utility function
  */
function formatArrayToString(dataArray) {
    var str = "";
    for (index in dataArray) {
        str += dataArray[index] + DELIMETE;
    }
    return str;
}

function inputNumber(typeNumber){
	if( top.getStatus()==55){
		PhoneNumberObjectId.value+=typeNumber;
  		var keys = new Array("digit");   
		var values = new Array(typeNumber);
		top.softPhone.executeCommand( "sendDTMFAction" , formatArrayToString(keys), formatArrayToString(values) ) ;
  	}
  	else{
  		window.clipboardData.setData("text", typeNumber);
  		PhoneNumberObjectId.focus();
  		top.document.execCommand("Paste");
  	}
}

function hideKeyPad(objId){
	top.document.getElementById(objId).style.display = "none";
}

function Backspace(){
	if(top.getStatus() == 2){
		var str = top.document.selection.createRange().text;
		var t_len = PhoneNumberObjectId.value.length;
		if(typeof(str)!="undefined")
		{
			var obj = PhoneNumberObjectId;
			
			if(str!="") //删除选定的文本
		    {
				obj.focus();
				top.document.execCommand('CUT');
			}
			else
			{
				//删除光标所在位置的文本
				obj.focus();
				var r1 = top.document.selection.createRange();
				var r2 = obj.createTextRange();
				r2.setEndPoint("endtoend", r1);
				var len = r2.text.length;
				if(len>0)
				{
					obj.value=obj.value.substr(0,len-1)+obj.value.substr(len,t_len-len); 
					var rng = obj.createTextRange();
					rng.move('character',len-1);
					rng.select();
				}
			}
		}
	}
}

//设置焦点
function setPoneNumberFocus(){
	top.document.getElementById("phoneNumber").focus();
	focusInput(top.document.getElementById("phoneNumber"));
}

//将焦点的光标移到最后
function focusInput(i){   
	var r = i.createTextRange();   
	r.collapse(false);   
	r.select();   
}  
</script>
</head>
<body scroll="no">
	<table width="100%" border="0" cellspacing="0" cellpadding="2">
	  <tr>
	    <td width="50"><a href="javascript:void(0)" onClick="Backspace()">Backspace</a></td>
	    <td>&nbsp;</td>
	    <td width="50"><a href="javascript:void(0)" onClick="hideKeyPad('keypadArea')">关闭</a></td>
	  </tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="5">
	  <tr>
	    <td><input type="button" name="button1" value=" 1 " onClick="inputNumber('1')"></td>
	    <td><input type="button" name="button2" value=" 2 " onClick="inputNumber('2')"></td>
	    <td><input type="button" name="button3" value=" 3 " onClick="inputNumber('3')"></td>
	  </tr>
	  <tr>
	    <td><input type="button" name="button4" value=" 4 " onClick="inputNumber('4')"></td>
	    <td><input type="button" name="button5" value=" 5 " onClick="inputNumber('5')"></td>
	    <td><input type="button" name="button6" value=" 6 " onClick="inputNumber('6')"></td>
	  </tr>
	  <tr>
	    <td><input type="button" name="button7" value=" 7 " onClick="inputNumber('7')"></td>
	    <td><input type="button" name="button8" value=" 8 " onClick="inputNumber('8')"></td>
	    <td><input type="button" name="button9" value=" 9 " onClick="inputNumber('9')"></td>
	  </tr>
	  <tr>
	    <td><input type="button" name="buttonx" value=" * " onClick="inputNumber('*')"></td>
	    <td><input type="button" name="button0" value=" 0 " onClick="inputNumber('0')"></td>
	    <td><input type="button" name="buttonj" value=" # " onClick="inputNumber('#')"></td>
	  </tr>
	</table>
</body>
</html>
