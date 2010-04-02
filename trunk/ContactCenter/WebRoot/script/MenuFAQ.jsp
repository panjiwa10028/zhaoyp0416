<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>
<%@ include file="/jsp/common/header/include_init.jsp" %>
<script src="<%=strContextPath%>/script/Menu.js" language="JavaScript" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript">
<!--
	//构造菜单
	var arrMenuItem=new Array(6);
	arrMenuItem[0]=new MenuItem();
	arrMenuItem[0].strId				="AddTemplate";
	arrMenuItem[0].strLabel				="<%=Function.getMultiLangItemContent("common.addTemplateType", request)%>";
	arrMenuItem[0].strNormalIcon		="<%=strContextPath%>/images/Icon-AddType.gif";
	arrMenuItem[0].strDisabledIcon		="<%=strContextPath%>/images/Icon-AddTypeDisabled.gif";
	var hasAddTemplateTypePermission 	= top.isExistedPermission("<c:out value="${param.addTemplateTypePermission}"/>");
	if(hasAddTemplateTypePermission==true)
	{
		arrMenuItem[0].nState			=0;//Normal
	}
	else
	{
		arrMenuItem[0].nState			=1;//Disabled
	}
	arrMenuItem[1]=new MenuItem();
	arrMenuItem[1].strId				="ModifyTemplate";
	arrMenuItem[1].strLabel				="<%=Function.getMultiLangItemContent("common.modifyTemplateType", request)%>";
	arrMenuItem[1].strNormalIcon		="<%=strContextPath%>/images/Icon-ModifyType.gif";
	arrMenuItem[1].strDisabledIcon		="<%=strContextPath%>/images/Icon-ModifyTypeDisabled.gif";
	var hasModifyTemplateTypePermission = top.isExistedPermission("<c:out value="${param.modifyTemplateTypePermission}"/>");
	if(hasModifyTemplateTypePermission==true)
	{
		arrMenuItem[1].nState			=0;//Normal
	}
	else
	{
		arrMenuItem[1].nState			=1;//Disabled
	}
	arrMenuItem[2]=new MenuItem();
	arrMenuItem[2].strId				="DeleteTemplate";
	arrMenuItem[2].strLabel				="<%=Function.getMultiLangItemContent("common.deleteTemplateType", request)%>";
	arrMenuItem[2].strNormalIcon		="<%=strContextPath%>/images/Icon-DeleteType.gif";
	arrMenuItem[2].strDisabledIcon		="<%=strContextPath%>/images/Icon-DeleteTypeDisabled.gif";
	var hasDeleteTemplateTypePermission = top.isExistedPermission("<c:out value="${param.deleteTemplateTypePermission}"/>");
	if(hasDeleteTemplateTypePermission==true)
	{
		arrMenuItem[2].nState			=0;//Normal
	}
	else
	{
		arrMenuItem[2].nState			=1;//Disabled
	}
	
	arrMenuItem[3]=new MenuItem();
	arrMenuItem[3].strId			="Add";
	arrMenuItem[3].strLabel			="<%=Function.getMultiLangItemContent("common.addType", request)%>";
	arrMenuItem[3].strNormalIcon	="<%=strContextPath%>/images/Icon-AddType.gif";
	arrMenuItem[3].strDisabledIcon	="<%=strContextPath%>/images/Icon-AddTypeDisabled.gif";
	var hasAddTypePermission 		= top.isExistedPermission("<c:out value="${param.addTypePermission}"/>");
	if(hasAddTypePermission==true)
	{
		arrMenuItem[3].nState		=0;//Normal
	}
	else
	{
		arrMenuItem[3].nState		=1;//Disabled
	}
	arrMenuItem[4]=new MenuItem();
	arrMenuItem[4].strId			="Modify";
	arrMenuItem[4].strLabel			="<%=Function.getMultiLangItemContent("common.modifyType", request)%>";
	arrMenuItem[4].strNormalIcon	="<%=strContextPath%>/images/Icon-ModifyType.gif";
	arrMenuItem[4].strDisabledIcon	="<%=strContextPath%>/images/Icon-ModifyTypeDisabled.gif";
	var hasModifyTypePermission 	= top.isExistedPermission("<c:out value="${param.modifyTypePermission}"/>");
	if(hasModifyTypePermission==true)
	{
		arrMenuItem[4].nState		=0;//Normal
	}
	else
	{
		arrMenuItem[4].nState		=1;//Disabled
	}
	arrMenuItem[5]=new MenuItem();
	arrMenuItem[5].strId			="Delete";
	arrMenuItem[5].strLabel			="<%=Function.getMultiLangItemContent("common.deleteType", request)%>";
	arrMenuItem[5].strNormalIcon	="<%=strContextPath%>/images/Icon-DeleteType.gif";
	arrMenuItem[5].strDisabledIcon	="<%=strContextPath%>/images/Icon-DeleteTypeDisabled.gif";
	var hasDeleteTypePermission 	= top.isExistedPermission("<c:out value="${param.deleteTypePermission}"/>");
	if(hasDeleteTypePermission==true)
	{
		arrMenuItem[5].nState		=0;//Normal
	}
	else
	{
		arrMenuItem[5].nState		=1;//Disabled
	}
	var menu=new Menu();
	menu.strId		="Menu";
	menu.strLabel	="<%=Function.getMultiLangItemContent("common.typeManage", request)%>";
	menu.strIcon	="<%=strContextPath%>/images/Icon-Menu.gif";
	menu.nLeft		=120;
	menu.nTop		=36;
	menu.nWidth		=80;
	menu.nHeight	=128;
	menu.nState		=0;
	menu.arrMenuItem=arrMenuItem;
	
//-->
</script>