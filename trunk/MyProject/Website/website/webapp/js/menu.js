var g_ShowTimerTickId;

var g_DebugMsg = "";
var g_RootMenuLI = [];
var g_SubMenuLI = [];

var g_RootMenuUL;
var g_RootMenuID;
var g_WaitTime = 50;
var g_RootWaitTime = 0;

var g_AllMenuHide = true;
var g_ModalDialogClick = false;

document.onclick=hideAllSubMenu;

function openShim(menuObj,menuParentLI)
{
    if (menuObj==null) return;
    var shim = null;
    shim = getShim(menuObj);
    if (shim==null) shim = createMenuShim(menuObj,getShimId(menuObj));
    
    //Change menu zIndex so shim can work with it
    menuObj.style.zIndex = 100;
    
    //var width = (menuObj.offsetWidth == 0 ? menuObj.scrollWidth : menuObj.offsetWidth);
    var width = menuObj.offsetWidth;
    if(width == 0)
    {
    	width = menuObj.style.width;//scrollWidth
    	
    }
    var height = menuObj.offsetHeight;
     
    if(height == 0) 
    { 
    	height = menuObj.scrollHeight;
    }
    
    shim.style.width = width;
    shim.style.height = height;
    //shim.style.top = menuObj.style.top;
    //shim.style.left = menuObj.style.left;
    shim.style.top = menuObj.offsetTop;
    shim.style.left = menuObj.offsetLeft;
    shim.style.zIndex = menuObj.style.zIndex - 1;
    shim.style.position = "absolute";
    shim.style.display = "block";
    //alert(shim.outerHTML);
}

function closeShim(menuObj)
{
    if (menuObj==null) return;
    var shim = getShim(menuObj);
    if (shim!=null) shim.style.display = "none";
}

function getShimId(menuObj)
{
    var menuId = menuObj.id;
    if ((menuId==null) ||(menuId==''))
    {
    	var randomId = Math.random();
    	while(document.getElementById("ID"+randomId))
    	{
    		randomId = Math.random();
    	}
    	menuObj.id = "ID"+randomId;
    	return "shim_"+menuObj.id;
	}
    return "shim_"+menuObj.id;
}


function getShim(menuObj)
{
    return document.getElementById(getShimId(menuObj));
}

function createMenuShim(menuObj)
{
    if (menuObj==null) return null;

    var shim = null
    shim = document.createElement("<iframe src='/CmbBank_GenShell/UI/GenShellPC/Base/Blank.htm' scrolling='no'  frameborder='0'"+
                                      "style='position:absolute; top:0px;"+
                                      "left:0px; display:none'></iframe>"); 
    shim.name = getShimId(menuObj);
    shim.id = getShimId(menuObj);
    
    //Unremark this line if you need your menus to be transparent for some reason
    //shim.style.filter="progid:DXImageTransform.Microsoft.Alpha(style=0,opacity=0)";
    if (menuObj.offsetParent==null || menuObj.offsetParent.id=="") 
    {
        window.document.body.appendChild(shim);
    }
    else 
    {
        menuObj.offsetParent.appendChild(shim); 
    }
    return shim;
}


//show the menuitem when onmouseover event occured
function showMenuLi(menuLI)
{
	menuLI.displayed = true;
	var menuItemA = null;
	for (var itemIndex=0;itemIndex<menuLI.childNodes.length;itemIndex++) 
	{
			var sitem = menuLI.childNodes[itemIndex];
			if(sitem.nodeName == "A")
			{
				menuItemA = sitem;
			}
			else if(sitem.nodeName == "UL")
			{	
				sitem.style.left = "auto";
				openShim(sitem,menuLI);
			}
	}
}
//hide the menuitem when onmouseout event occured
function hideMenuLi(menuLI)
{
	//var menuLI = document.getElementById(menuLid);
	menuLI.displayed = false;
	//menuLI.className=menuLI.className.replace(new RegExp(" menuitemhover\\b"), "");
	for (var itemIndex=0;itemIndex<menuLI.childNodes.length;itemIndex++) 
	{
		var sitem = menuLI.childNodes[itemIndex];
		if(sitem.nodeName == "UL")
		{
			sitem.style.left = "-9999em";
			closeShim(sitem);
		}
	}
}

//init event proc of menuitem, called by buildMenu.
function initMenuEventProc(rootMenuUL)
{
	var menuLIs = rootMenuUL.getElementsByTagName("LI");
	for (var i=0; i<menuLIs.length; i++) {
		menuLIs[i].isRoot = false;
		menuLIs[i].onmouseover=function() 
		{//show the menuitem when onmouseover event occured
			mouseOverMenuLiProc(this);
		}
		menuLIs[i].onmouseout=function() 
		{//hide the menuitem when onmouseout event occured
			mouseOutMenuLiProc(this);
		}
		
		menuLIs[i].onclick=function() 
		{//hide the menuitem when onclick event occured, just comment these code as you wish
			//mouseClickMenuLiProc(this);
			
			if(this.isRoot)
			{
				clickRootMenuLiProc(this);
				return false;
			}
			//if(this.isLeaf) 
			else
			{
				hideAllSubMenu();
			}
			//event.returnValue = true;
			event.cancelBubble = true;
		}
		
	}
}

//init the sub menu,called by buildMenu to add css to menuitems
function initSubMenu(rootMenuUL)
{
	var menuLIs = rootMenuUL.getElementsByTagName("LI");
	for (var i=0; i<menuLIs.length; i++) 
	{
		var menuLI = menuLIs[i];
		var menuItemA = null;
		for (var itemIndex=0;itemIndex<menuLI.childNodes.length;itemIndex++) 
		{
			var sitem = menuLI.childNodes[itemIndex];
			menuLI.isLeaf = true;
			if(sitem.nodeName == "A")
			{
				menuItemA = sitem;
				
				/*if(sitem.onclick == null)
				{
					sitem.onclick = function()
					{
						window.event.returnValue = true;
						//event.cancelBubble = true;
						return true;
					}
				}*/
				
			}
			else if(sitem.nodeName == "UL")
			{	
				menuLI.isLeaf = false;
				if(menuItemA != null)
				{
					menuLI.isSub = true;
					if(menuLI.isRoot)
					{
						menuItemA.onclick = function()
						{ 
							this.blur();
						}
					}
					else
					{
						menuItemA.className += " submenu";
					
						menuItemA.onclick = function()
						{ 
							window.event.returnValue = false;
							window.event.cancelBubble = true;
							//return false;
						}
					}
					
					g_SubMenuLI[g_SubMenuLI.length] = menuLI;
				}
				else
				{
					menuLI.isSub = false;
				}
			}
		}
	}
}
//add an ID property to every menu item
function initMenuItemId(rootMenuUL)
{
	var menuLIs = rootMenuUL.getElementsByTagName("LI");
	for (var i=0; i<menuLIs.length; i++) 
	{
		var menuLI = menuLIs[i];
		var menuId = menuLI.id;
		if ((menuId==null) ||(menuId==''))
		{
    		var randomId = Math.random();
    		while(document.getElementById("LI_"+randomId))
    		{
    			randomId = Math.random();
    		}
    		menuLI.id = "LI_"+randomId;
		}
	}
}
//init the root menu,called optionally
function initRootMenu(rootMenuUL)
{
	if (!rootMenuUL.childNodes || rootMenuUL.childNodes.length == 0) 
    {
       	return;
    }
    for (var itemi=0;itemi<rootMenuUL.childNodes.length;itemi++) 
    {
       	var menuLI = rootMenuUL.childNodes[itemi];
       	if (menuLI.nodeName == "LI") 
       	{
       		menuLI.isRoot = true;
       		menuLI.isLeaf = false;
       		g_RootMenuLI[g_RootMenuLI.length] = menuLI;
       		for (var itemIndex=0;itemIndex<menuLI.childNodes.length-1;itemIndex++) 
			{
				var sitem = menuLI.childNodes[itemIndex];
				if(sitem.nodeName == "A")
				{
					if(itemi < rootMenuUL.childNodes.length -1)
					{
						sitem.className=sitem.className+" rootmenuA";
					}
				}
			}
			
       	}
     }
}

function hideAllSubMenu()
{
	for(var i=0; i<g_SubMenuLI.length; i++)
	{
		moveCss2Menu(g_SubMenuLI[i]);
		hideMenuLi(g_SubMenuLI[i]);
	}
	g_AllMenuHide = true;
}

function showAllSubMenu(subMenuLI)
{
	
	var menuLI = subMenuLI;
	while(menuLI)
	{
		if(menuLI.nodeName == "LI")
		{
			addCss2Menu(menuLI);
			showMenuLi(menuLI);
		}
		else if(menuLI.nodeName == "UL")
		{
	  		if(menuLI.id ==g_RootMenuID)
	  		{
	  			break;
	  		}
		}
	  	menuLI = menuLI.parentNode;
	}
	g_AllMenuHide = false;
}

function addCss2Menu(menuLI)
{
	var menuclassname = "menuitemhover";
	if(menuLI.isRoot)
	{
		menuclassname = "rootmenuitemhover";
	}
	if(menuLI.className.indexOf(menuclassname) < 0)
	{
		menuLI.className+=" "
		menuLI.className+=menuclassname;
	}
	if(menuLI.isRoot) return;
	for (var itemIndex=0;itemIndex<menuLI.childNodes.length;itemIndex++) 
	{
		var sitem = menuLI.childNodes[itemIndex];
		if(sitem.nodeName == "A")
		{
			sitem.style.color = "white";
			if(sitem.className.indexOf("submenu") >= 0)
			{
				//sitem.style.backgroundImage = "url(Images/arrow_white.gif)";
			 }
		}
	}
	return true;
}

function moveCss2Menu(menuLI)
{
	var menuclassname = "menuitemhover";
	if(menuLI.isRoot)
	{
		menuclassname = "rootmenuitemhover";
	}
	var expr = " "+menuclassname+"\\b";
	if(menuLI.className.indexOf(menuclassname) >= 0)
 	{
		menuLI.className=menuLI.className.replace(new RegExp(expr), "");
	}
	if(menuLI.isRoot) return;
	
	for (var itemIndex=0;itemIndex<menuLI.childNodes.length;itemIndex++) 
	{
		var sitem = menuLI.childNodes[itemIndex];
		if(sitem.nodeName == "A")
		{
			sitem.style.color = "#0783DF";
			if(sitem.className.indexOf("submenu") >= 0)
			{
				//sitem.style.backgroundImage = "url(Images/arrow_blue.gif)";
			}
		}
	}
}


function mouseOverMenuLiProc(menuLI)
{
	window.focus();
	addCss2Menu(menuLI);
	//event.cancelBubble = true;
	
	if(menuLI.isLeaf)
	{
		if(g_ModalDialogClick) 
		{
			event.cancelBubble = true;
			g_ModalDialogClick = false;
		}
		return;
	}
	if(menuLI.isRoot)
	{
		if(g_AllMenuHide) return;
	}
	var waitTime = g_WaitTime;
	if(menuLI.isRoot)
	{
		waitTime = g_RootWaitTime;
	}
	window.clearTimeout(g_ShowTimerTickId);
	g_ShowTimerTickId = window.setTimeout("showSubMenu('"+menuLI.id+"');", waitTime);
	event.cancelBubble = true;
	return;
}
function clickRootMenuLiProc(menuLI)
{
	if(g_AllMenuHide)
	{
		showSubMenu(menuLI.id);
		event.cancelBubble = true;
	}
	else
	{
		hideAllSubMenu();
	}
}
function showSubMenu(menuLid)
{
	hideAllSubMenu();
	var menuLI = document.getElementById(menuLid);
	showAllSubMenu(menuLI);
}
function mouseOutMenuLiProc(menuLI)
{
	moveCss2Menu(menuLI);
	if(menuLI.contains(event.toElement))
	{
		addCss2Menu(menuLI);
	}
	/*
	if((!g_RootMenuUL.contains(event.toElement))||(!menuLI.contains(event.toElement)))
	{
		//moveCss2Menu(menuLI);
		//window.focus();
		
		//mainWorkArea.setActive();
		//g_RootMenuUL.setActive();
		//hideAllSubMenu();
	}
	*/
	event.cancelBubble = true;
	return;
}


//Build the Menu, should be called in the onload event of the web page.
function buildMenu(rootMenuId)
{
	g_RootMenuLI.length = 0;
	g_SubMenuLI.length = 0;
	
	var rootMenuUL = document.getElementById(rootMenuId);
	if(rootMenuUL == null) return;
	g_RootMenuUL = rootMenuUL;
	g_RootMenuID = rootMenuId;
	if (!rootMenuUL.childNodes || rootMenuUL.childNodes.length == 0) return;
  
  //Add id property to every LI
	initMenuItemId(rootMenuUL);
	//Associate event proc with LI
	initMenuEventProc(rootMenuUL);
	//Add css to RootMenu LI
	initRootMenu(rootMenuUL);
	//Add css to SubMenu LI
	initSubMenu(rootMenuUL);
	//
	
}