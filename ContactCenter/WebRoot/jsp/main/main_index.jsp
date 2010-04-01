<%@ page contentType="text/html; charset=UTF-8" language="java" %><html>
<script language="javascript">
function loadInfo()
{
	frames['leftView'].location=top.leftUrl;
	frames['workArea'].location=top.workUrl;
}
</script>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>work frame</title>
</head>
 <frameset cols="150,*" frameborder="yes" border="0" framespacing="1" bordercolor="#979596" onLoad="loadInfo()">
  <frame src="about:blank" name="leftView" id="leftView">
  <frame src="about:blank" name="workArea" id="workArea">
</frameset>
<body>
</body>

</html>