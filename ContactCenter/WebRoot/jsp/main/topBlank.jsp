<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<title></title>
<script language="javascript" type="text/javascript">
function changeSize(){
if(top.isMesFloat == 0){
	top.document.getElementById('popTable1').style.width   = document.body.offsetWidth;
		if(top.mainIframe.mainFrame.cols == "0,*"){
			top.document.getElementById('popTable1').style.posLeft=0;
		}else{
			top.document.getElementById('popTable1').style.posLeft = top.mainIframe.leftTreeFrame.document.body.offsetWidth +2; //2 is this width of frame border.
		}

		if(Math.abs(document.body.offsetHeight - top.document.getElementById('popTable1').offsetHeight) >2 ){
			top.mainIframe.centerContentFrame.rows = ""+top.document.getElementById('popTable1').offsetHeight+",*";
		}
  }
}
</script>
</head>
<body onResize="changeSize()" scroll="no"></body>
</html>