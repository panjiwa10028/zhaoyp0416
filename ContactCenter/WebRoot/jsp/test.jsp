<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<script language="JavaScript" type="text/javascript">

	function getValue(){
		var v1 = "<c:out value='${param.strUserName}'/>";
		
		sid.value = v1;
		sid1.value = decodeURI(v1);
		
	}

</script>
</head>
<body onload="getValue()">
<input id="sid" type="text" value="" />
<input id="sid1" type="text" value="" />
<input id="sid2" type="text" value="<c:out value='${param.strUserName}'/>" />
</body>
</html>