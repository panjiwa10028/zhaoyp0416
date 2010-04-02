<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>

<%@ include file="/jsp/common/header/include_init.jsp" %>
<%@ include file="/jsp/common/header/include_link.jsp" %>
<%@ include file="/jsp/common/header/include_script.jsp" %>
<%@ taglib uri="/WEB-INF/struts-bean.tld" prefix="bean" %>
<%@ taglib uri="/WEB-INF/struts-html.tld" prefix="html" %>
<%@ taglib uri="/WEB-INF/struts-logic.tld" prefix="logic" %>
<%@ taglib prefix="fmt" uri="/WEB-INF/fmt.tld" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
</head>

<frameset rows="*,30" frameborder="NO" border="0" framespacing="0">
  <frame src="<%=strContextPath%>/jsp/showAgentStates.jsp" name="mainFrame" >
  <frame src="<%=strContextPath%>/jsp/agentStatQuery.jsp" name="bottomFrame" scrolling="NO"  noresize>
</frameset>
<noframes><body>
</body></noframes>
</html>