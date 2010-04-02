<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>
<%@ include file="/jsp/common/header/include_init.jsp" %>
<script src="<%=strContextPath%>/script/Menu.js" language="JavaScript" type="text/javascript"></script>
<script language="JavaScript" type="text/javascript">
<!--
	//构造菜单
	var arrMenuItem=new Array(3);
	arrMenuItem[0]=new MenuItem();
	arrMenuItem[0].strId			="Add";
	arrMenuItem[0].strLabel			="<%=Function.getMultiLangItemContent("contacteeSource.toolbar.addContacteeSource.tip", request)%>";
	arrMenuItem[0].strNormalIcon	="<%=strContextPath%>/images/Icon-AddType.gif";
	arrMenuItem[0].strDisabledIcon	="<%=strContextPath%>/images/Icon-AddTypeDisabled.gif";
	var hasAddTypePermission 		= top.isExistedPermission("<c:out value="${param.addTypePermission}"/>");
	if(hasAddTypePermission==true)
	{
		arrMenuItem[0].nState		=0;//Normal
	}
	else
	{
		arrMenuItem[0].nState		=1;//Disabled
	}
	arrMenuItem[1]=new MenuItem();
	arrMenuItem[1].strId			="Modify";
	arrMenuItem[1].strLabel			="<%=Function.getMultiLangItemContent("contacteeSource.toolbar.modifyContacteeSource.tip", request)%>";
	arrMenuItem[1].strNormalIcon	="<%=strContextPath%>/images/Icon-ModifyType.gif";
	arrMenuItem[1].strDisabledIcon	="<%=strContextPath%>/images/Icon-ModifyTypeDisabled.gif";
	var hasModifyTypePermission 	= top.isExistedPermission("<c:out value="${param.modifyTypePermission}"/>");
	if(hasModifyTypePermission==true)
	{
		arrMenuItem[1].nState		=0;//Normal
	}
	else
	{
		arrMenuItem[1].nState		=1;//Disabled
	}
	arrMenuItem[2]=new MenuItem();
	arrMenuItem[2].strId			="Delete";
	arrMenuItem[2].strLabel			="<%=Function.getMultiLangItemContent("contacteeSource.toolbar.deleteContacteeSource.tip", request)%>";
	arrMenuItem[2].strNormalIcon	="<%=strContextPath%>/images/Icon-DeleteType.gif";
	arrMenuItem[2].strDisabledIcon	="<%=strContextPath%>/images/Icon-DeleteTypeDisabled.gif";
	var hasDeleteTypePermission 	= top.isExistedPermission("<c:out value="${param.deleteTypePermission}"/>");
	if(hasDeleteTypePermission==true)
	{
		arrMenuItem[2].nState		=0;//Normal
	}
	else
	{
		arrMenuItem[2].nState		=1;//Disabled
	}
	
	var menu=new Menu();
	menu.strId		="Menu";
	menu.strLabel	="<%=Function.getMultiLangItemContent("ContacteeManager.contactee.source.type", request)%>";
	menu.strIcon	="<%=strContextPath%>/images/Icon-Menu.gif";
	menu.nLeft		=120;
	menu.nTop		=36;
	menu.nWidth		=80;
	menu.nHeight	=76;
	menu.nState		=0;
	menu.arrMenuItem=arrMenuItem;
	
//-->
</script>