<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>
<OBJECT id="softPhone" classid="clsid:CAFEEFAC-0016-0000-0011-ABCDEFFEDCBA"
    width="0" height="0" align="baseline"
    codebase="<%=request.getContextPath()%>/install/jre-6u11-windows-i586-p-s.exe#Version=1,6,0,11">
    <PARAM name="code" value="com.esoon.ezactor.softphone.applet.impl.AgentViewContronller.class">
    <PARAM name="codebase" value="<%=request.getContextPath()%>/applet/">
    <PARAM name="id" value="AgentViewCTIController">
    <PARAM name="name" value="AgentViewCTIController">
    <PARAM name="type" value="application/x-java-applet;jpi-version=1.6.0_11">
  	<PARAM name="archive" value="commons-beanutils-1.8.x.jar,commons-collections-3.1.jar,commons-digester-1.6.jar,commons-lang-2.4.jar,commons-logging-1.0.4.jar,log4j-1.2.15.jar,slf4j-api-1.5.5.jar,slf4j-log4j12-1.5.5.jar,ezactor_common.jar,ezactor-softphone-7.6.jar,j2ee.jar,pbx-common.jar,fmj.jar,jain-sip.jar,JavaPhone.jar,jdom.jar,jspeex.jar,Stun4J.jar">
    <PARAM name="scriptable" value="true">
    <PARAM name="mayscript" value="true">   
    
    <PARAM name="extension" value="<c:out value="${EXT}"/>"/> 
    <PARAM name="placeId" value="<c:out value="${STRPLACENAME}"/>"/>
    <PARAM name="agentId" value="<c:out value="${STRSTAFFERID}"/>"/> 
    <PARAM name="loginId" value="<c:out value="${STRLOGINNAME}"/>"/>
    <PARAM name="passwd" value="<c:out value="${STRPBXPASSWORD}"/>"/>
    <PARAM name="positionId" value=""/>
    <PARAM name="QueueDn" value="<c:out value="${STRQUEUEDN}"/>">
    <PARAM name="emailDn" value=""/> 
    <PARAM name="chatDn" value=""/>
    	
    <PARAM name="webContext" value="<%=request.getContextPath()%>"/>
    <PARAM name="useCTI" value="<c:if test='${NSOFTPHONEUSESTATE==1}'>true</c:if><c:if test='${NSOFTPHONEUSESTATE!=1}'>false</c:if>"/>     	
		
    <PARAM name="isVoiceDN" value="true"/> 	
    <PARAM name="EZContacVersion" value="76"/>
    <PARAM name="TserverAttempts" value="<c:out value="${NATTEMPTS}"/>"/>
    <PARAM name="TServerPort" value="<c:out value="${NPORT}"/>"/>
    <PARAM name="TServerIP" value="<c:out value="${STRIP}"/>"/>
    <PARAM name="AgentIP" value="<%=request.getRemoteAddr()%>"/>
    
    <PARAM name="TserverRedundancyType" value="<c:out value="${NREDUNDANCYTYPE}"/>"/>
    <PARAM name="BkpTserverIP" value="<c:out value="${STRBKHOST}"/>"/>
    <PARAM name="BkpTserverPort" value="<c:out value="${NBKPORT}"/>"/>
    <PARAM name="country" value="<%=request.getLocale().getCountry()%>"/>
    <PARAM name="language" value="<%=request.getLocale().getLanguage()%>"/>
    <PARAM name="variant" value="<%=request.getLocale().getVariant()%>"/>
    <PARAM name="useRejectCall" value="<c:if test='${NISREJCALL==1}'>true</c:if><c:if test='${NISREJCALL!=1}'>false</c:if>"/>
    <PARAM name="ClientHost" value="<%=request.getRemoteAddr()%>"/>
        No Java 2 SDK, Standard Edition v 1.4.2 support for APPLET!!
</OBJECT>