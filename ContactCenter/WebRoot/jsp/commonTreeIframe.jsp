<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.Function" %>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>

<%@ include file="/jsp/common/header/include_init.jsp" %>
<html>
<head>
	<title><%=Function.getMultiLangItemContent("Business.Title",request)%></title>
	<%@ include file="/jsp/common/header/include_link.jsp" %>
	<%@ include file="/jsp/common/header/include_script.jsp" %>
	<script src="<%=strContextPath%>/script/Timer.js" language="JavaScript" type="text/javascript"></script> 

	<link href="<%=request.getContextPath()%>/css/dtree.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/css/chrome.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="<%=strContextPath%>/script/contactCommon/dtree.js"></script>
	<style type="text/css">
	body {
		background-image:url(<%=strContextPath%>/images/title_bg.gif); 
		background-position:left top;
		background-repeat:no-repeat;
		background-color:#f5f8f9;
	}
	</style>
<script>
function setSSS(id,isSelect)
{		
		id=id.substring(8,id.length);
			tree.oSelect(id);
			tree.oSelect(id);
		if(isSelect==true)
		{
			sss[id]=true;
		}
		else
		{
			sss[id]=false;
		}	
}

function copyTree()
{
	// 为本页面构造一棵新的数
	tree = new dTree('tree');

	// 拷贝配置
	tree.config = treeTemp.config;
	
	// 拷贝ico路径
	tree.icon = treeTemp.icon;
	var strName = '';
	
	// 拷贝节点数据
	for(var i = 0; i < treeTemp.aNodes.length; i++)
	{	
		strName = treeTemp.aNodes[i].name;
		strName = html_View2Text(strName);
		
		tree.add(treeTemp.aNodes[i].id,
			treeTemp.aNodes[i].pid, 
			strName, 
			treeTemp.aNodes[i].isType, 
			treeTemp.aNodes[i].isChecked, 
			treeTemp.aNodes[i].isDisabled, 
			treeTemp.aNodes[i].url,
			treeTemp.aNodes[i].title, 
			treeTemp.aNodes[i].target,
			treeTemp.aNodes[i].icon, 
			treeTemp.aNodes[i].iconOpen, 
			treeTemp.aNodes[i].open);
		
		strName = '';
	}
	
	for(var i=0; i < treeTemp.aIndent.length; i++)
	{
		tree.aIndent[i] = treeTemp.aIndent[i];
	}
	
	tree.selectedNode = treeTemp.selectedNode;
	tree.selectedFound = treeTemp.selectedFound;
	tree.completed = treeTemp.completed;
}

var tree;
var treeTemp;
var inputCtrl;
var win;
var agent_sum=0;
var sss;

function loadInfo()
{	
	// 得到父页面传递的树对象
	treeTemp = window.dialogArguments[0];
	agent_sum = treeTemp.aNodes.length;
	
	// 得到父页面窗体
	win = window.dialogArguments[2];
	sss=new Array(agent_sum);

	//继续计时
	try {
		viewTime();
	}catch(e){}
	try {
		showTime();
	}catch(e){}
		
	// 得到父页面待显示选择列表控件
	inputCtrl = win.document.getElementById(window.dialogArguments[1]);
	
	// 拷贝父页面传递的树对象数据到新的树中
	copyTree();
	
	treeDiv.innerHTML = tree.toString();
}

/*	
	var para = window.dialogArguments;
	tree = para[0];
	win = para[1];
	
	var doc = openDialog.document;
	
	doc.writeln(tree.toString('_blank'));
	doc.writeln('<body oncontextmenu="return false;" onUnload="parent.win.getSelectedNameList()"></body>');
	doc.close();
*/

// 将用户当前选择的状态设置到父页面的树的对象及页面中
function ok()
{
	if(tree.config.useControl==true)
	{// 只有使用控件才设置选择状态
		// 判断使用控件类型
		if(tree.config.controlType=='radio')
		{
			// 清除数对象选择状态
			for(var i=0; i < treeTemp.aNodes.length; i++)
			{
				treeTemp.aNodes[i].isChecked = false;
			}
			
			// 复制选择状态
			for(var i=0; i < tree.aNodes.length; i++)
			{
				if(tree.aNodes[i].isChecked==true)
				{
					if((tree.aNodes[i].pid!=-1 && tree.aNodes[i].pid!='-1') || tree.config.isRootUseControl==true)
					{
						// 设置选择状态
						treeTemp.aNodes[i].isChecked = true;
						
						// 得到选择控件并设置状态
						var elementTemp = win.document.getElementById('ctrl' + treeTemp.obj + tree.aNodes[i]._ai);
						if(elementTemp!=null)
						{
							elementTemp.checked = true;
						}
						
						break;
					}
				}
			}
		}
		else if(tree.config.controlType=='checkbox')
		{
			// 复制选择状态
			for(var i=0; i < tree.aNodes.length; i++)
			{
				if((tree.aNodes[i].pid!=-1 && tree.aNodes[i].pid!='-1') || tree.config.isRootUseControl==true)
				{
					// 设置选择状态
					treeTemp.aNodes[i].isChecked = tree.aNodes[i].isChecked;
					
					// 得到选择控件并设置状态
					/*var elementTemp = win.document.getElementById('ctrl' + treeTemp.obj + tree.aNodes[i]._ai);
					if(elementTemp!=null)
					{
						elementTemp.checked = tree.aNodes[i].isChecked
					}*/
					var elementTemp;
					if((sss[i]!=null && sss[i]!='' && sss[i]!=false) || (tree.aNodes[i].isChecked!=false))
					{
						elementTemp=tree.aNodes[i];
						elementTemp.checked = tree.aNodes[i].isChecked;
					}
				}
			}
		}
			
		// 得到选择列表
		inputCtrl.value = treeTemp.getSelectedNameList();
	}
	
	
	try
	{
		win.onOk1();
	}
	catch(e)
	{
	}
	
	window.close();
	
	if(tree.config.isEventOnOk==true)
	{
		if (win.onOk)
		{
			win.onOk();
		}
	}
}

function cancel()
{
	window.close();
}

function clearSelected()
{
	// 清除选择状态
	for(var i=0; i < treeTemp.aNodes.length; i++)
	{
		if((treeTemp.aNodes[i].pid!=-1 && treeTemp.aNodes[i].pid!='-1') || tree.config.isRootUseControl==true)
		{
			if(treeTemp.aNodes[i].isDisabled==false 
				|| (treeTemp.aNodes[i].isDisabled==true && tree.config.isLockDisabledNodeChecked==false)
				|| tree.config.isLockDisabledNodeChecked==false)
			{
				// 清除对象选择状态
				treeTemp.aNodes[i].isChecked = false;
				
				// 清除选择控件选择状态
				var elementTemp = win.document.getElementById('ctrl' + treeTemp.obj + treeTemp.aNodes[i]._ai);
				if(elementTemp!=null)
				{
					elementTemp.checked = false;
				}
			}
		}
	}
	
	// 清除选择列表
	inputCtrl.value = treeTemp.getSelectedNameList();
	
	window.close();
}
</script>
</head>
<body onLoad="loadInfo()" marginheight="0" marginwidth="0" topmargin="0" leftmargin="0" >
	<table width="350" border="0" cellpadding="0" cellspacing="0" id="__01">
	  <tr>
	    <td height="50">
	      <table width="100%" border="0" cellpadding="0" cellspacing="0">
	       <tr>
	  	    <td height="20" valign="middle"><strong style="font-size:12px; padding-left:10px"><%=Function.getMultiLangItemContent("Common.select",request)%></strong></td>  	    
	       </tr>
	      </table>
	    </td>
	  </tr>  
	  <tr>
	    <td>
			<div id="treeDiv" style="width:303px; height:418px; overflow:auto;margin:0px 20px; margin-bottom:8px; border:1px solid #cccccc; background-color:#FFFFFF;"></div>
		</td>
	</tr>
	<tr>
	<td width="100%">	
			<table width="100%" height=40 border="0" align="center" background="<%=strContextPath%>/images/mac_bg1.gif" style="border-top:1px solid #cccccc">
			  <tr>			    
			    <td width="100%" align="center">
				    <input name="button2" type="button" class="button" value=" <%=Function.getMultiLangItemContent("common.OK",request)%> " onClick="ok();">    				    
				    <input name="button4" type="button" class="button" value=" <%=Function.getMultiLangItemContent("common.CLEAR",request)%> " onClick="clearSelected();">
				    <input name="button3" type="button" class="button" value=" <%=Function.getMultiLangItemContent("common.CANCEL",request)%> " onClick="cancel();">
				</td>	    				    
			  </tr>
			</table>
		</td>
	  </tr>
	 </table> 		
</body>
</html>
