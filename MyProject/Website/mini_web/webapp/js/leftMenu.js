
var MenuItem = {};
MenuItem.create = function(id,title,action,itemClass)
{
	var _ctrol = document.createElement("<li id=\"" + id + "\"></li>");
	var aCtrol = document.createElement("A");
	aCtrol.href = "null";
	//ʹ��try��ֹ�����������ʧ�ܡ�
	try{
		aCtrol.onclick = new Function("try{" + action + ";return false;window.focus();}catch(e){}");
	}catch(e){}
	aCtrol.innerHTML = title;
	//var listStyleChart = document.createElement("span");
	//listStyleChart.innerHTML = "��";
	//_ctrol.appendChild(listStyleChart);
	
	_ctrol.appendChild(aCtrol);
	_ctrol.className = itemClass;
	_ctrol.getTitle = function()
	{
		return this.firstChild.innerHTML;
	}
	_ctrol.setTitle = function(title)
	{
		this.firstChild.innerHTML = title;
	}
	
	return _ctrol;
}

var MenuHeader = {};
MenuHeader.create = function(headerId,title,headerOpenClass,headerCloseClass,itemClass)
{
	var header = document.createElement("<div id=\"" + headerId + "\">"
				+ "</div>");
	header.headerOpenClass = headerOpenClass;
	header.headerCloseClass = headerCloseClass;
	header.itemClass = itemClass;
	header.m_maxItemId = 0;
	header.getNewItemId = function()
	{
		return this.id + "_" + (this.m_maxItemId++).toString();
	}
	header.handleclick = function()
	{
		
		var container = this.getItemContainer();
		if(container.style.display=="none")
		{
			this.showAll();
			this.parentNode.onMenuHeaderClick(this.id);
		}
		else
			this.hide();
		
		window.focus();
	}
	header.appendChild(document.createElement("<a href=\"#\"></a>"));
	header.firstChild.innerHTML = title;
	header.firstChild.className = header.headerCloseClass;
	header.firstChild.onclick = function(){
		this.parentNode.handleclick();
		return false;
	}
	var itemContainer = document.createElement("<ul height=0 style=\"margin:0 0 0 0;height:0px;display:none\" id=\"" + headerId +"content\"></ul>")
	header.appendChild(itemContainer);
	itemContainer.onMenuHeaderClick = function(){};
	header.getHeaderCtrol = function()
	{
		return this.firstChild;
	}
	header.setHeaderTitle = function(title)
	{
		return this.firstChild.firstChild.innerHTML = title;
	}
	header.getHeaderTitle = function()
	{
		return this.firstChild.innerText;
	}
	header.setContent = function(htmlContent)
	{
		this.getItemContainer().innerHTML = htmlContent;
//this.getItemContainer().style.display = "";
//alert(this.getItemContainer().offsetHeight);
	}
	header.getItemContainer = function()
	{
		return this.lastChild;
	}
	header.size = function()
	{
		return this.getItemContainer().childNodes.length;
	}
	header.addItem = function(title,url)
	{
		var itemId = this.getNewItemId();
		var newItem = MenuItem.create(itemId,title,url,"");
		newItem.className = this.itemClass;
		this.getItemContainer().appendChild(newItem);
		//this.getItemContainer().style.display="none";
		//this.getItemContainer().style.height = "0px";

		return newItem;
	}
	header.addItemAt = function(index,title,url,block)
	{
		if(block==null)
		{
			var itemId = this.getNewItemId();
			var newItem = MenuItem.create(itemId,title,url,"");
			newItem.className = this.itemClass;
			var children = this.getItemContainer().childNodes;
			if(index>=children.length)
			{
				this.getItemContainer().appendChild(newItem);
			}else
				this.getItemContainer().insertBefore(newItem,children[index]);
			return newItem;
		}else
		{
			var blockHeader = this.getBlock(block);
			if(blockHeader==null)
			{
				var blockId = this.getNewItemId();
				blockHeader = MenuHeader.create(blockId,block,"headerOpen1","headerClose1",this.itemClass);
				this.getItemContainer().appendChild(blockHeader);
				blockHeader.forceShow();
				blockHeader.firstChild.onclick = function(){return false;};
				blockHeader.firstChild.href = "";
			}
			return blockHeader.addItemAt(index,title,url);
		}
	}
	header.addItemWithBlock = function(title,url,block)
	{
		var blockHeader = this.getBlock(block);
		if(blockHeader==null)
		{
			var blockId = this.getNewItemId();
			blockHeader = MenuHeader.create(blockId,block,"headerOpen1","headerClose1",this.itemClass);
			this.getItemContainer().appendChild(blockHeader);
			blockHeader.forceShow();
			blockHeader.firstChild.onclick = function(){return false;};
			blockHeader.firstChild.href = "";
		}
		return blockHeader.addItem(title,url);
	}
	
	header.getBlock = function(block)
	{
		var container = this.getItemContainer();
		var items = container.childNodes;
		for(var i=0;i<items.length;i++)
		{
			if( items[i].getHeaderTitle!=null && items[i].getHeaderTitle() == block )
			{
				return items[i];
			}
		}
		return null;
	}
	
	header.removeItemAt = function(index)
	{
		var children = this.getItemContainer().childNodes;
		if(index>=children.length)
			return;
		else
			return this.getItemContainer().removeChild(children[index]);
	}
	header.getItemAt = function(index)
	{
		var children = this.getItemContainer().childNodes;
		if(index>=children.length)
			return null;
		else
			return children[index];
	}
	header.removeLastItem = function()
	{
		var container = this.getItemContainer();
		container.removeChild(container.lastChild);
	}
	header.removeItemByTitle = function(title)
	{
		var container = this.getItemContainer();
		var items = container.childNodes;
		for(var i=0;i<items.length;i++)
		{
			if( items[i].getTitle() == title )
			{
				container.removeChild(items[i]);
				break;
			}
		}
	}
	header.removeAll = function()
	{
		var container = this.getItemContainer();
		var children = container.childNodes;
		for(var i=children.length-1;i>=0;i--)
		{
			container.removeChild(children[i]);
		}
		header.firstChild.className = header.headerCloseClass;
	}
	header.forceShow = function()
	{
		var container = this.getItemContainer();
		container.style.display = "block";
		header.firstChild.className = header.headerOpenClass;
	}
	header.showAll = function()
	{
		var container = this.getItemContainer();
		if(container.childNodes.length!=0)
		{
			container.style.display = "block";
		}else
			container.style.display = "none";
		header.firstChild.className = header.headerOpenClass;
	}
	header.hide = function()
	{
		var container = this.getItemContainer();
		container.style.display = "none";
		header.firstChild.className = header.headerCloseClass;
	}
	header.getMaxHeight = function()
	{
		var totalHeight = 0;
		var items = this.getItemContainer().childNodes;
		for(var i=0;i<items.length;i++)
		{
			totalHeight += items[i].offsetHeight;
		}
		return totalHeight;
	}
	return header;
}

var AccMenu = {};
AccMenu.extend = function(menuElement,headerOpenClass,headerCloseClass,itemClass)
{
	menuElement.innerHTML = "";
	menuElement.m_maxId = 0;
	menuElement.speed =1;
	menuElement.timer = 20;
	menuElement.headerOpenClass = headerOpenClass;
	menuElement.headerCloseClass = headerCloseClass;
	menuElement.itemClass = itemClass;
	menuElement.getNextHeaderId = function(){
		return this.id + "_" + (this.m_maxId++).toString();
	};
	menuElement.getMenuIndexByHeaderId = function(headerId)
	{
		var iPos = headerId.lastIndexOf("_");
		if(iPos==-1)
			return;
		var index = parseInt(headerId.substring(iPos+1,headerId.length));
		return index;
	};
	menuElement.addHeader = function(title){
		var headerId = this.getNextHeaderId();
		var header = MenuHeader.create(headerId,title,this.headerOpenClass,this.headerCloseClass,this.itemClass);
		this.appendChild(header);
		return header;
	};
	menuElement.getHeaderAt = function(index)
	{
		var headerId = this.id + "_" + index.toString();
		return document.getElementById(headerId);
	}
	menuElement.addItem = function(header,itemtitle,itemurl,itemClass)
	{
		return header.addItem(itemtitle,itemurl);
	};
	menuElement.addItemAt = function(headerIndex,itemtitle,itemurl,itemClass)
	{
		var header = this.getHeaderAt(headerIndex);
		return this.addItem(header,itemtitle,itemurl,itemClass);
	};
	menuElement.removeItemAt = function(headerIndex,itemIndex)
	{
		var header = this.getHeaderAt(headerIndex);
		header.removeItemAt(itemIndex);
	};
	menuElement.removeAll = function()
	{
		var children = this.childNodes;
		for(var i=children.length-1;i>=0;i--)
		{
			this.removeChild(children[i]);
		}
	}
	menuElement.init = function()
	{
		
	}
	menuElement.onMenuHeaderClick = function(headerId)
	{
		var children = this.childNodes;
		for(var i=0;i<this.children.length;i++)
		{
			if(children[i].id!=headerId)
			{
				children[i].hide();
			}
		}
	};
	menuElement.showMenu = function(headerId)
	{
		var children = this.childNodes;
		for(var i=0;i<this.children.length;i++)
		{
			if(children[i].id!=headerId)
			{
				children[i].hide();
			}else
			{
				children[i].showAll();
			}
		}
	}
	return menuElement;
}

var AccMenuManager = {
	m_menus : new Array(),
	createNewMenu : function(containerId,headerOpenClass,headerCloseClass,itemClass)
		{
			var menuElement = document.getElementById(containerId);
			if(menuElement!=null)
			{
				AccMenu.extend(menuElement,headerOpenClass,headerCloseClass,itemClass);
				this.m_menus.push(containerId);
			}
			return menuElement;
		},
	getMenu : function(containerId)
	{
		var found = false;
		for(var i=0;i<this.m_menus.length;i++)
		{
			if(this.m_menus[i]==containerId)
			{
				found = true;
				break;
			}
		}
		if(found)
			return document.getElementById(containerId);
		else
			return null;
	}
};

var HistoryOpMenuMgr =
{
	init:function(accMenuId,header)
	{
		this.accMenuId = accMenuId;
		this.header = header;
	},
	clear:function()
	{
		this.header.removeAll();
	},
	push_front:function(title,url,block)
	{
		//this.header.removeItemByTitle(title);
		var result = null;
		var blockHeader = this.header.getBlock(block);
		if(blockHeader==null)
		{
			return this.header.addItemAt(0,title,url,block);
		}
		var lastItem = blockHeader.getItemAt(0);
		if(lastItem.getTitle()==title)
			return lastItem;
		else
			result = this.header.addItemAt(0,title,url,block);
		if(blockHeader.size()>5)
		{
			blockHeader.removeLastItem();
		}
		return result;
	},
	push_back:function(title,url)
	{
		this.header.removeItemByTitle(title);
		return this.header.addItem(title,url);
	},
	pop_front:function()
	{
		return this.header.removeItemAt(0);
	},
	pop_back:function()
	{
		return this.header.removeLastItem();
	}
}

function getFunctionCfgByCallFuncArgs(args)
{
	var s = "";
	var results = new Array();
	for(var i=0;i<args.length;i++)
	{
		s += (i==0?"":",");
		if(args[i]!=null)
			s += "'" + args[i] + "'";
		else
			s += "null";
	}
	if(g_function_cfg==null)
		throw("need file funcDefineGen.js");
	for(var i=0;i<g_function_cfg.length;i++)
	{
		if(g_function_cfg[i].FunctionCall.indexOf(s)!=-1 )
		{
			results.push(g_function_cfg[i]);
		}
	}
	if(results.length==0)
		return null;
	var bestIndex = 0;
	for(var i=1;i<results.length;i++)
	{
		if(results[i].FunctionCall.length < results[bestIndex].FunctionCall.length)
			bestIndex = i;
	}
	return results[bestIndex];
}


function TryAddHistoryOpFromCallFunc(args)
{
	var funcobj = getFunctionCfgByCallFuncArgs(args);
	if(funcobj!=null)
	{
		
		s = funcobj.FunctionCall;
		try{
			HistoryOpMenuMgr.push_front(funcobj.FunctionName,s,funcobj.BlockNameText);
		}catch(e){}
	}
}



/*********************************
*���triggerFunc�Ĳ����ȡ ������Ƶ���Ϣ
*����args:triggerFunc�� arguments
*����ֵ�����������ļ����ҵ������ض�Ӧ��json���󣬷��򷵻�null
**********************************/
function getFuncObjByTriggerArgs(blockName,pageName,params)
{
	alert(blockName);
	alert(pageName);
	//alert(params);
	if(g_function_cfg==null)
		throw("need file funcDefineGen.js");
	var foundTimes = 0;
	var foundIndex = -1;
	for(var i=0;i<g_function_cfg.length;i++)
	{
		if(g_function_cfg[i].FunctionPage == pageName)
		{
			var find = true;
			for(var j=0;j<params.length;j++)
			{
				if(g_function_cfg[i].FunctionCall.indexOf(params[j])==-1)
				{
					find = false;
					break;
				}
			}
			if(find)
			{
				foundTimes++;
				foundIndex = i;
			}
		}
	}
	if(foundTimes==1)
		return g_function_cfg[foundIndex];
	return null;
}

function TryAddHistoryOpFromTriggerFunc(args,iframeName)
{
	return;
	var clientNo = "";

	var url;
	var targetName = "";
	if(iframeName!=null)
	{
		var target = window.frames[iframeName];
		if( target == null )
			return;
		try{
			clientNo = target.document.getElementById("ClientNo").value;
		}catch(e){
			return;
		}
	
		if(args[2]!="_self")
			return;
			
		targetName = iframeName;
	
		var oldPath = target.location.href;
		var pos0 = oldPath.lastIndexOf("/");
		if(pos0==-1)
			return;
		var urlPre = oldPath.substring(0,pos0+1);
		url = urlPre + args[0];
	}else
	{
		url = args[0];
		targetName = args[2];
		
	}
	//alert(url);

	var pos0 = url.lastIndexOf("/");
	var urlPre = url.substring(0,pos0);
	var pos1 = urlPre.lastIndexOf("/");
	if(pos1==-1)
		return;
	var blockName = url.substring(pos1+1,pos0);

	var pos2 = args[0].lastIndexOf("/");
	var pageName;
	if( pos2==-1)
		pageName = args[0];
	else
		pageName = args[0].substring(pos2+1);
	pageName = pageName.substring(0,pageName.length-5);
	//alert(pageName);
	
	var params = new Array();
	for(var i=3; i<args.length; i++)
	{
		if(iframeName==null && i==args.length-1)
			break;
		params.push(args[i]);
	}
	//alert(params);
	//alert("hi");
	var funcobj = getFuncObjByTriggerArgs(blockName,pageName,params);
	//alert(funcobj);
	if(funcobj!=null)
	{
		var s = "";
		for(var i=0;i<args.length;i++)
		{
			s += (i==0?"":",");
			if(i==0)
				s += "'" + url +"'";
			else if(i==2)
				s += "'" + targetName + "'";
			else if(args[i]!=null)
				s += "'" + args[i] + "'";
			else
				s += "null";
		}
		if(iframeName!=null)
			s += ",'ClientNo=" + clientNo +"'";
		s = "triggerFunc(" + s + ");";
		//alert(s);
		try{
			HistoryOpMenuMgr.push_front(funcobj.FunctionName,s);
		}catch(e){}
	}
}

/*
window.onload = function()
{
	var menu = AccMenuManager.createNewMenu("testMenu","headerOpen","headerClose","menuItem");
	var header = menu.addHeader("���ù���","");
	header.setContent("<div>aaaaaaaaaaa<br>aaaaa<br>aaaaa</div>");
	/*header.addItem("item0","alert('item0click');alert(typeof(this));alert(this.outerHTML);HistoryOpMenuMgr.push_front(this.innerHTML,this.onclick)");
	header.addItem("item1","alert('item1click');HistoryOpMenuMgr.push_front(this.innerHTML,this.onclick)");
	header.addItem("item2","alert('item2click');HistoryOpMenuMgr.push_front(this.innerHTML,this.onclick)");

	var header = menu.addHeader("��ʷ����","");
	HistoryOpMenuMgr.init("testMenu",header);
	HistoryOpMenuMgr.clear();
	var header = menu.addHeader("�ҵ��ղؼ�","");
	header.addItem("item0","alert('item0click');");
	header.addItem("item1","alert('item1click');");
	header.addItem("item2","alert('item2click');");
	header.addItem("item3","alert('item3click');");
}
*/




