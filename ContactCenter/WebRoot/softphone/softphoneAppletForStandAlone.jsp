<%@ page language="java" pageEncoding="UTF-8"%>
<OBJECT id="softPhone" classid="clsid:8AD9C840-044E-11D1-B3E9-00805F499D93"
    width="0" height="0" align="baseline"
    codebase="http://java.sun.com/products/plugin/autodl/jinstall-1_4_2-windows-i586.cab#Version=1,4,2,0">
    <PARAM name="code" value="com.esoon.ezactor.softphone.applet.impl.AgentViewContronller.class">
    <PARAM name="codebase" value="<%=request.getContextPath()%>/applet/">
    <PARAM name="id" value="AgentViewCTIController">
    <PARAM name="name" value="AgentViewCTIController">
    <PARAM name="type" value="application/x-java-applet;jpi-version=1.4.2">    
   	<PARAM name="archive" value="commons-beanutils-1.8.x.jar,commons-collections-3.1.jar,commons-digester-1.6.jar,commons-lang-2.4.jar,commons-logging-1.0.4.jar,log4j-1.2.15.jar,slf4j-api-1.5.5.jar,slf4j-log4j12-1.5.5.jar,ezactor_common.jar,ezactor-softphone-7.6.jar,j2ee.jar,pbx-common.jar,fmj.jar,jain-sip.jar,JavaPhone.jar,jdom.jar,jspeex.jar,Stun4J.jar">
    <PARAM name="scriptable" value="true">
    <PARAM name="mayscript" value="true">    
    	
    <PARAM name="extension" value="<%=request.getParameter("extension")%>"/>
    <PARAM name="agentId" value="<%=request.getParameter("agentName")%>"/>
    <PARAM name="QueueDn" value="<%=request.getParameter("queueName")%>"/>
    <PARAM name="placeId" value="<%=request.getParameter("placeName")%>"/>
    <PARAM name="loginID" value="<%=request.getParameter("login")%>"/>
    <PARAM name="positionId" value=""/>
    <PARAM name="passwd" value="<%=request.getParameter("passwd")%>"/>
    <PARAM name="emailDn" value="<%=request.getParameter("emailDn")%>"/>
    <PARAM name="chatDn" value="<%=request.getParameter("chatDn")%>"/>    
    <PARAM name="webContext" value="<%=request.getContextPath()%>"/>
    <PARAM name="useCTI" value="true"/>		
    <PARAM name="isVoiceDN" value="yes"/>
    <PARAM name="EZContacVersion" value="76"/>
	<PARAM name="AgentIP" value="<%=request.getRemoteAddr()%>"/>
  	<PARAM name="country" value="<%=request.getLocale().getCountry()%>"/>
    <PARAM name="language" value="<%=request.getLocale().getLanguage()%>"/>
    <PARAM name="variant" value="<%=request.getLocale().getVariant()%>"/>
    <PARAM name="useRejectCall" value="true"/>
    <PARAM name="ClientHost" value="<%=request.getRemoteAddr()%>"/>
        No Java 2 SDK, Standard Edition v 1.4.2 support for APPLET!!
</OBJECT>