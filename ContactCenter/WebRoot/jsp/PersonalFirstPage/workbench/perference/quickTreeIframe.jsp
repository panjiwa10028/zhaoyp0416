<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.Function" %>
<%@ taglib prefix="c" uri="/WEB-INF/c.tld" %>
<%@ page import="EZLib.Message.EZMessage" %>
<%@ page import="com.esoon.EZActor.BusinessCenter.BusinessCenterApp" %>
<%@ include file="/jsp/common/header/include_init.jsp" %>
<%@ include file="/jsp/common/header/include_getRequiredParameter.jsp" %>
<html>
<head>
	<title><%=Function.getMultiLangItemContent("Business.Title",request)%></title>
	<%@ include file="/jsp/common/header/include_link.jsp" %>
	
	<script type="text/javascript" src="<%=strContextPath%>/script/contactCommon/dtree.js"></script>
	<script type="text/javascript" src="<%=strContextPath%>/script/input.js"></script>
<link href="<%=strContextPath%>/css/chrome.css" rel="stylesheet" type="text/css">
	<link href="<%=request.getContextPath()%>/css/dtree.css" rel="stylesheet" type="text/css">	
<script>
var tree;
var treeTemp;
var inputCtrl;
var win;

var treeb;
var treec;
var treed;

var treeTemp1;
var treeTemp2;
var treeTemp3;

var strAgentId;
var strDepartId;

var departTypeTree;
var strDepartId;
var flag1;
var selectValue;

function searchNode()
{	
	tree.filter = searchStr.value;
	treeDiv.innerHTML = tree.toString();
}

function reset()
{	
	tree.filter = null;
	treeDiv.innerHTML = tree.toString();
}

function validateChecked(value){
	for (var i = 0;i < selectValue.length; i++){
		if(trim(selectValue.options[i].innerHTML) == trim(value)){
			return true;
		}
	}
	return false;
}

function copyTree()
{
	// 为本页面构造一棵新的数
	tree = new dTree('tree');

	// 拷贝配置
	tree.config = treeTemp.config;
	
	// 拷贝ico路径
	tree.icon = treeTemp.icon;

	// 拷贝节点数据
	for(var i = 0; i < treeTemp.aNodes.length; i++)
	{
		if(!validateChecked(treeTemp.aNodes[i].name)){
			tree.add(treeTemp.aNodes[i].id,
				treeTemp.aNodes[i].pid, 
				treeTemp.aNodes[i].name, 
				treeTemp.aNodes[i].isType, false,
				//validateChecked(treeTemp.aNodes[i].name), //判断 是否选取
				treeTemp.aNodes[i].isDisabled, 
				treeTemp.aNodes[i].title, 
				treeTemp.aNodes[i].target,
				treeTemp.aNodes[i].icon, 
				treeTemp.aNodes[i].iconOpen, 
				treeTemp.aNodes[i].open);
		}
	}
	
	for(var i=0; i < treeTemp.aIndent.length; i++)
	{
		tree.aIndent[i] = treeTemp.aIndent[i];
	}
	
	tree.selectedNode = treeTemp.selectedNode;
	tree.selectedFound = treeTemp.selectedFound;
	tree.completed = treeTemp.completed;
	
	// 为本页面构造一棵新的数
	treeb = new dTree('treeb');

	// 拷贝配置
	treeb.config = treeTemp1.config;
	
	// 拷贝ico路径
	treeb.icon = treeTemp1.icon;
	
	// 拷贝节点数据

	for(var i = 0; i < treeTemp1.aNodes.length; i++)
	{
		if(treeTemp1.aNodes[i].isType || !validateChecked(treeTemp1.aNodes[i].name)){
			treeb.add(treeTemp1.aNodes[i].id,
				treeTemp1.aNodes[i].pid, 
				treeTemp1.aNodes[i].name, 
				treeTemp1.aNodes[i].isType,false,
				treeTemp1.aNodes[i].isDisabled, 
				treeTemp1.aNodes[i].title, 
				treeTemp1.aNodes[i].target,
				treeTemp1.aNodes[i].icon, 
				treeTemp1.aNodes[i].iconOpen, 
				treeTemp1.aNodes[i].open);
		}
	}
	
	for(var i=0; i < treeTemp1.aIndent.length; i++)
	{
		treeb.aIndent[i] = treeTemp1.aIndent[i];
	}
	
	treeb.selectedNode = treeTemp1.selectedNode;
	treeb.selectedFound = treeTemp1.selectedFound;
	treeb.completed = treeTemp1.completed;
	
	// 为本页面构造一棵新的数
/*	treec = new dTree('treec');

	// 拷贝配置
	treec.config = treeTemp2.config;
	
	// 拷贝ico路径
	treec.icon = treeTemp2.icon;
	
	// 拷贝节点数据

	for(var i = 0; i < treeTemp2.aNodes.length; i++)
	{
		treec.add(treeTemp2.aNodes[i].id,
			treeTemp2.aNodes[i].pid, 
			treeTemp2.aNodes[i].name, 
			treeTemp2.aNodes[i].isType, 
			treeTemp2.aNodes[i].isChecked, 
			treeTemp2.aNodes[i].isDisabled, 
			treeTemp2.aNodes[i].url,
			treeTemp2.aNodes[i].title, 
			treeTemp2.aNodes[i].target,
			treeTemp2.aNodes[i].icon, 
			treeTemp2.aNodes[i].iconOpen, 
			treeTemp2.aNodes[i].open);
	}
	
	for(var i=0; i < treeTemp2.aIndent.length; i++)
	{
		treec.aIndent[i] = treeTemp2.aIndent[i];
	}
	
	treec.selectedNode = treeTemp2.selectedNode;
	treec.selectedFound = treeTemp2.selectedFound;
	treec.completed = treeTemp2.completed;
	
	// 为本页面构造一棵新的数
	treed = new dTree('treed');

	// 拷贝配置
	treed.config = treeTemp3.config;
	
	// 拷贝ico路径
	treed.icon = treeTemp3.icon;
	
	// 拷贝节点数据

	for(var i = 0; i < treeTemp3.aNodes.length; i++)
	{
		treed.add(treeTemp3.aNodes[i].id,
			treeTemp3.aNodes[i].pid, 
			treeTemp3.aNodes[i].name, 
			treeTemp3.aNodes[i].isType, 
			treeTemp3.aNodes[i].isChecked, 
			treeTemp3.aNodes[i].isDisabled, 
			treeTemp3.aNodes[i].url,
			treeTemp3.aNodes[i].title, 
			treeTemp3.aNodes[i].target,
			treeTemp3.aNodes[i].icon, 
			treeTemp3.aNodes[i].iconOpen, 
			treeTemp3.aNodes[i].open);
	}
	
	for(var i=0; i < treeTemp3.aIndent.length; i++)
	{
		treed.aIndent[i] = treeTemp3.aIndent[i];
	}
	
	treed.selectedNode = treeTemp3.selectedNode;
	treed.selectedFound = treeTemp3.selectedFound;
	treed.completed = treeTemp3.completed;
	*/
}

function loadInfo()
{	
	 
	// 得到父页面传递的树对象
	treeTemp = window.dialogArguments[0];			
	treeTemp1 = window.dialogArguments[3];
//	treeTemp2 = window.dialogArguments[4];
//	treeTemp3 = window.dialogArguments[5];
	
	// 得到父页面窗体
	win = window.dialogArguments[2];
	selectValue = win.getSelectValue();
	//继续计时
	try {
		viewTime();
	}catch(e){}
	try {
		showTime();
		showAUXTime();
	}catch(e){}
		
	// 得到父页面待显示选择列表控件
	inputCtrl = win.document.getElementById(window.dialogArguments[1]);
	// 拷贝父页面传递的树对象数据到新的树中
	
	copyTree();		
	treeDiv.innerHTML = tree.toString();		
	treeDiv1.innerHTML = treeb.toString();
//	treeDiv2.innerHTML = treec.toString();
//	treeDiv3.innerHTML = treed.toString();
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
						treeTemp.setCheckedCtrlId(tree.aNodes[i].id,true);
						
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
					for(var j=0; j < treeTemp.aNodes.length; j++)
						{
							if(tree.aNodes[i].isChecked && treeTemp.aNodes[j].name == tree.aNodes[i].name){
								treeTemp.aNodes[j].isChecked = true;
								break;
							}
						}
					//treeTemp.aNodes[i].isChecked = tree.aNodes[i].isChecked;
					
					// 得到选择控件并设置状态
					var elementTemp = win.document.getElementById('ctrl' + treeTemp.obj + tree.aNodes[i]._ai);
					if(elementTemp!=null)
					{
					//	elementTemp.checked = tree.aNodes[i].isChecked
					}
				}
			}			
			for(var i=0; i < treeb.aNodes.length; i++)
			{
				if((treeb.aNodes[i].pid!=-1 && treeb.aNodes[i].pid!='-1') || treeb.config.isRootUseControl==true)
				{
					// 设置选择状态
					for(var j=0; j < treeTemp1.aNodes.length; j++)
						{
							if(treeb.aNodes[i].isChecked && treeTemp1.aNodes[j].name == treeb.aNodes[i].name){
								treeTemp1.aNodes[j].isChecked = true;
								break;
							}
						}
					//treeTemp1.aNodes[i].isChecked = treeb.aNodes[i].isChecked;
					
					// 得到选择控件并设置状态
					var elementTemp1 = win.document.getElementById('ctrl' + treeTemp1.obj + treeb.aNodes[i]._ai);
					if(elementTemp1!=null)
					{
						elementTemp1.checked = treeb.aNodes[i].isChecked
					}
				}
			}
	/*	for(var i=0; i < treec.aNodes.length; i++)
			{
				if((treec.aNodes[i].pid!=-1 && treec.aNodes[i].pid!='-1') || treec.config.isRootUseControl==true)
				{
					// 设置选择状态
					treeTemp2.aNodes[i].isChecked = treec.aNodes[i].isChecked;
					
					// 得到选择控件并设置状态
					var elementTemp2 = win.document.getElementById('ctrl' + treeTemp2.obj + treec.aNodes[i]._ai);
					if(elementTemp2!=null)
					{
						elementTemp2.checked = treec.aNodes[i].isChecked
					}
				}
			}
			for(var i=0; i < treed.aNodes.length; i++)
			{
				if((treed.aNodes[i].pid!=-1 && treed.aNodes[i].pid!='-1') || treed.config.isRootUseControl==true)
				{
					// 设置选择状态
					treeTemp3.aNodes[i].isChecked = treed.aNodes[i].isChecked;
					
					// 得到选择控件并设置状态
					var elementTemp3 = win.document.getElementById('ctrl' + treeTemp3.obj + treed.aNodes[i]._ai);
					if(elementTemp3!=null)
					{
						elementTemp3.checked = treed.aNodes[i].isChecked
					}
				}
			}*/
			
		}
			
		// 得到选择列表
		/*if(treeTemp.getSelectedNameList()!=null && treeTemp.getSelectedNameList()!='' && treeTemp1.getSelectedNameList()!=null && treeTemp1.getSelectedNameList()!='')
		{
			inputCtrl.value = treeTemp.getSelectedNameList()+";"+treeTemp1.getSelectedNameList();
		}
		else if((treeTemp.getSelectedNameList()==null || treeTemp.getSelectedNameList()=='') && (treeTemp1.getSelectedNameList()!=null && treeTemp1.getSelectedNameList()!=''))
		{
			inputCtrl.value = treeTemp1.getSelectedNameList();
		}
		else
		{
			inputCtrl.value = treeTemp.getSelectedNameList();			
		}*/	
		if(treeTemp.getSelectedNameList()!=null && treeTemp.getSelectedNameList()!='')
		{
			inputCtrl.value = treeTemp.getSelectedNameList();
			//alert(inputCtrl.value);
		   var strApply=treeTemp.getSelectedNameList();
		   parent.win.addListCheck(strApply,0);
		}
		if(treeTemp1.getSelectedNameList()!=null && treeTemp1.getSelectedNameList()!='')
		{
		/*	if(inputCtrl.value!=null && inputCtrl.value!='')
			{
				inputCtrl.value = inputCtrl.value + ";" + treeTemp1.getSelectedNameList();
			}
			else
			{
				inputCtrl.value = treeTemp1.getSelectedNameList();
			}	
			*/	
			
			 var strBusiness=treeTemp1.getSelectedNameList();
			
			/* var list=strBusiness.split(";");
			 if((list.length+parent.win.getSelectBusinessNum())>5)
			 {
			alert("<%=Function.getMultiLangItemContent("Business.Select.Too.Many",request)%>");
			 return;
			 }
			 else
			 {*/
			 parent.win.addListCheck(strBusiness,1);
			// }
		}
/*		if(treeTemp2.getSelectedNameList()!=null && treeTemp2.getSelectedNameList()!='')
		{
			if(inputCtrl.value!=null && inputCtrl.value!='')
			{
				inputCtrl.value = inputCtrl.value + ";" + treeTemp2.getSelectedNameList();
			}
			else
			{
				inputCtrl.value = treeTemp2.getSelectedNameList();
			}	
		}
		if(treeTemp3.getSelectedNameList()!=null && treeTemp3.getSelectedNameList()!='')
		{
			if(inputCtrl.value!=null && inputCtrl.value!='')
			{
				inputCtrl.value = inputCtrl.value + ";" + treeTemp3.getSelectedNameList();
			}
			else
			{
				inputCtrl.value = treeTemp3.getSelectedNameList();
			}				
		}
		
		*/
		
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
	
	for(var i=0; i < treeTemp1.aNodes.length; i++)
	{
		if((treeTemp1.aNodes[i].pid!=-1 && treeTemp1.aNodes[i].pid!='-1') || treeb.config.isRootUseControl==true)
		{
			if(treeTemp1.aNodes[i].isDisabled==false 
				|| (treeTemp1.aNodes[i].isDisabled==true && treeb.config.isLockDisabledNodeChecked==false)
				|| treeb.config.isLockDisabledNodeChecked==false)
			{
				// 清除对象选择状态
				treeTemp1.aNodes[i].isChecked = false;
				
				// 清除选择控件选择状态
				var elementTemp1 = win.document.getElementById('ctrl' + treeTemp1.obj + treeTemp1.aNodes[i]._ai);
				if(elementTemp1!=null)
				{
					elementTemp1.checked = false;
				}
			}
		}
	}
	
/*	for(var i=0; i < treeTemp2.aNodes.length; i++)
	{
		if((treeTemp2.aNodes[i].pid!=-1 && treeTemp2.aNodes[i].pid!='-1') || treec.config.isRootUseControl==true)
		{
			if(treeTemp2.aNodes[i].isDisabled==false 
				|| (treeTemp2.aNodes[i].isDisabled==true && treec.config.isLockDisabledNodeChecked==false)
				|| treec.config.isLockDisabledNodeChecked==false)
			{
				// 清除对象选择状态
				treeTemp2.aNodes[i].isChecked = false;
				
				// 清除选择控件选择状态
				var elementTemp2 = win.document.getElementById('ctrl' + treeTemp2.obj + treeTemp2.aNodes[i]._ai);
				if(elementTemp2!=null)
				{
					elementTemp2.checked = false;
				}
			}
		}
	}
	
	for(var i=0; i < treeTemp3.aNodes.length; i++)
	{
		if((treeTemp3.aNodes[i].pid!=-1 && treeTemp3.aNodes[i].pid!='-1') || treed.config.isRootUseControl==true)
		{
			if(treeTemp3.aNodes[i].isDisabled==false 
				|| (treeTemp3.aNodes[i].isDisabled==true && treed.config.isLockDisabledNodeChecked==false)
				|| treed.config.isLockDisabledNodeChecked==false)
			{
				// 清除对象选择状态
				treeTemp3.aNodes[i].isChecked = false;
				
				// 清除选择控件选择状态
				var elementTemp3 = win.document.getElementById('ctrl' + treeTemp3.obj + treeTemp3.aNodes[i]._ai);
				if(elementTemp3!=null)
				{
					elementTemp3.checked = false;
				}
			}
		}
	}*/
	
	// 清除选择列表
	inputCtrl.value = treeTemp.getSelectedNameList();
	
	window.close();
}
</script>
<style type="text/css">
body {
	background-image:url(<%=strContextPath%>/images/title_bg.gif); 
	background-position:left top;
	background-repeat:no-repeat;
	background-color:#f5f8f9;
}
</style>
</head>
<body onLoad="loadInfo()" marginheight="0" marginwidth="0" topmargin="0" leftmargin="0" >
    	<div id="agentView" style='display:block'>
			<table width="100%" height=24 border="0" align="center" background="<%=strContextPath%>/images/mac_bg1.gif" style="border-top:1px">
			  <tr>
			   <!--  <td width="13%" ALIGN="left" VALIGN="bottom">&nbsp<%=Function.getMultiLangItemContent("assignContact.mode", request)%></td>-->
			    <td width="22%" ALIGN="left" VALIGN="top"><input type="radio" name="selectTree1" onClick="agentView.style.display='block';departView.style.display='none';selectTree1[0].checked=true;selectTree1[1].checked=false;" checked><%=Function.getMultiLangItemContent("setquick.page.common.apply", request)%></td>
			    <td width="22%" ALIGN="left" VALIGN="top"><input type="radio" name="selectTree1" onClick="agentView.style.display='none';departView.style.display='block';selectTree2[0].checked=false;selectTree2[1].checked=true;"><%=Function.getMultiLangItemContent("setquick.page.common.businss", request)%></td>	    
			   <!--  <td width="22%" ALIGN="left" VALIGN="top"><input type="radio" name="selectTree1" onClick="agentView.style.display='none';departView.style.display='none';groupView.style.display='block';roleView.style.display='none';selectTree3[0].checked=false;selectTree3[1].checked=false;selectTree3[2].checked=true;selectTree3[3].checked=false;"><%=Function.getMultiLangItemContent("business.page.common.assign.group", request)%></td>	    
			    <td width="21%" ALIGN="left" VALIGN="top"><input type="radio" name="selectTree1" onClick="agentView.style.display='none';departView.style.display='none';groupView.style.display='none';roleView.style.display='block';selectTree4[0].checked=false;selectTree4[1].checked=false;selectTree4[2].checked=false;selectTree4[3].checked=true;"><%=Function.getMultiLangItemContent("business.page.common.assign.role", request)%></td>	    
			 --> </tr>
			</table>
		
		<BR>
			<div style="width:100%;margin:0px 16px; margin-bottom:8px; border:1px solid #cccccc; background-color:#FFFFFF;">
				<table width="100%" border="0" cellpadding="1" cellspacing="0" id="__01">
					  
				  <tr>
				   <td> 
					<div id="treeDiv" style="width:320px; height:270px;overflow:auto;"></div>					
				   </td>
				  </tr>
				 </table>  	
			 </div>	
			 <table width="100%" height=70 border="0" align="center" background="<%=strContextPath%>/images/mac_bg1.gif" style="border-top:1px solid #cccccc">
			  <tr>			    
			    <td align="center" valign="top">
				    <input name="button2" type="button" class="button" value=" <%=Function.getMultiLangItemContent("common.OK",request)%> " onClick="ok();">    
				    <input name="button3" type="button" class="button" value=" <%=Function.getMultiLangItemContent("common.CANCEL",request)%> " onClick="cancel();">
				 <!--    <input name="button4" type="button" class="button" value=" <%=Function.getMultiLangItemContent("common.CLEAR",request)%> " onClick="clearSelected();">-->
				</td>	    				    
			  </tr>
			</table>
		</div>	
		
		<div id="departView" style='display:none'>
				<table width="100%" height=24 border="0" align="center" background="<%=strContextPath%>/images/mac_bg1.gif" style="border-top:1px">
			  <tr>
			   <!--  <td width="13%" ALIGN="left" VALIGN="bottom">&nbsp<%=Function.getMultiLangItemContent("assignContact.mode", request)%></td>-->
			    <td width="22%" ALIGN="left" VALIGN="top"><input type="radio" name="selectTree2" onClick="agentView.style.display='block';departView.style.display='none';selectTree1[0].checked=true;selectTree1[1].checked=false;"><%=Function.getMultiLangItemContent("setquick.page.common.apply", request)%></td>
			    <td width="22%" ALIGN="left" VALIGN="top"><input type="radio" name="selectTree2" onClick="agentView.style.display='none';departView.style.display='block';selectTree2[0].checked=false;selectTree2[1].checked=true;" checked><%=Function.getMultiLangItemContent("setquick.page.common.businss", request)%></td>	    
			  <!--   <td width="22%" ALIGN="left" VALIGN="top"><input type="radio" name="selectTree2" onClick="agentView.style.display='none';departView.style.display='none';groupView.style.display='block';roleView.style.display='none';selectTree3[0].checked=false;selectTree3[1].checked=false;selectTree3[2].checked=true;selectTree3[3].checked=false;"><%=Function.getMultiLangItemContent("business.page.common.assign.group", request)%></td>	    
			    <td width="21%" ALIGN="left" VALIGN="top"><input type="radio" name="selectTree2" onClick="agentView.style.display='none';departView.style.display='none';groupView.style.display='none';roleView.style.display='block';selectTree4[0].checked=false;selectTree4[1].checked=false;selectTree4[2].checked=false;selectTree4[3].checked=true;"><%=Function.getMultiLangItemContent("business.page.common.assign.role", request)%></td>	    
			  --></tr>
			</table>
			<BR>
			<div style="width:100%;margin:0px 16px; margin-bottom:8px; border:1px solid #cccccc; background-color:#FFFFFF;">
				<table width="100%" border="0" cellpadding="0" cellspacing="0" id="__01">				 
				  <tr>
				   <td>
						<div id="treeDiv1" style="width:320px; height:270px; overflow:auto;"></div>
				   </td>
				  </tr>
				 </table>  	
			 </div>		
			 <table width="100%" height=50 border="0" align="center" background="<%=strContextPath%>/images/mac_bg1.gif" style="border-top:1px solid #cccccc">
			  <tr>			    
			    <td align="center" valign="top">
				    <input name="button2" type="button" class="button" value=" <%=Function.getMultiLangItemContent("common.OK",request)%> " onClick="ok();">    
				    <input name="button3" type="button" class="button" value=" <%=Function.getMultiLangItemContent("common.CANCEL",request)%> " onClick="cancel();">
				</td>	    				    
			  </tr>
			</table>	
	    </div>
	    

</body>
</html>